Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD846789F9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAWVu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjAWVu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 16:50:56 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96C0A3526C
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 13:50:41 -0800 (PST)
Message-ID: <c80f04d2-8159-a02a-9287-26e5ec838826@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1674510632;
        bh=QreBtEGkhDpfBdGHu05goTg8psV6QCr2xrkw16ZowDw=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Tny4ui5K3B8+0d3c0+wFxQr7VQT89fGoU91vEeZNZblss0jf5AR5lUNVV1xCUScog
         STITCII6j2rQeGUaVGFP+H16nIvAWh2ihI6JNdrrRBaNE2db77YRibhyQHo9dfFqS1
         mFzyjz4DgMS1lezwkXnZpNRzXyW6Cx5hrmlWhiLI=
Date:   Mon, 23 Jan 2023 22:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: BUG: KASAN: use-after-free in ieee80211_mgd_auth
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230112173808.6205-1-alexander@wetzel-home.de>
 <1d2ac266daf0e68d60d5a7074f96b2962c733a41.camel@sipsolutions.net>
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <1d2ac266daf0e68d60d5a7074f96b2962c733a41.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.01.23 15:42, Johannes Berg wrote:
> Hi Alexander,
> 
>> 	if (req->key && req->key_len) {
> 
> You get into this with this code, I believe?
> 

That we get into that code turns out to be a red flag already:
The hostapd test wext_pmf is using WPA2.

While req->key is only for WEP!!

> I think this is misleading you.
> 
>> Jan 11 12:37:35 debian kernel: BUG: KASAN: use-after-free in ieee80211_mgd_auth+0x59f/0xc50 [mac80211]
>> Jan 11 12:37:35 debian kernel: Read of size 13 at addr ffff8881608bd4a0 by task wpa_supplicant/624
> 
> Clearly, that is reporting a 13-byte memcpy(), and a *read* at that too,
> so it must be req->key that's being used after free?
> 

That was the tip I needed to unravel that mystery. Thanks.
I documented my findings in this mail, mostly for myself.

> And I think the answer is some issue in cfg80211:

Looks like this is happening:

wireless_dev has a wext compat structure:
  @wext: (private) Used by the internal wireless extensions compat code

which has a field control:
  @wext.connect: (private) connection handling data

When using WEP cfg80211_connect() is setting a pointer to the WEP key:

	if (cipher == WLAN_CIPHER_SUITE_WEP40 ||
	    cipher == WLAN_CIPHER_SUITE_WEP104) {
		connect->key_idx = idx;
		connect->key = connkeys->params[idx].key;
		connect->key_len = connkeys->params[idx].key_len;

But nobody zeros connect->key and connect->key_len.
Which is really wext.connect->key (and so on) on the interface level 
when using wext.

cfg80211_sme_connect() is then copying the wext.connect structure into
&wdev->conn->params with our then invalid pointer.

cfg80211_conn_do_work() is then finally copying the invalid key pointer 
and len  data into a private struct cfg80211_auth_request auth_req which 
is handed over to eee80211_mgd_auth().

Which then tries to access memory freed when the last WEP handshake on 
the interface completed.

KASAN happily points out the worker freeing the memory. Which was a task 
completely unrelated to the current assoc.

In other words: When we first connect with WEP and later (on the same 
interface) with WPA we have a key_len and pointer left from the last WEP 
connect. And ieee80211_mgd_auth() then tries to access the deleted key 
via the remaining pointer.

Which now makes it strange that the hostapd test runs were often working...
Someone else must have reused the memory with at least one of the two 
checked values being zero.

> I think you might just be hitting some strange sequence of things? Or
> it's just some really ancient bug?
> 
Ancient bug. The problematic code was added with
'commit fffd0934b939 ("cfg80211: rework key operation")'
in 2009, kernel 2.6.32.

The fix is trivial, I'll probably just zero key and key-len when not 
using wext. But maybe I find a more wext-only solution.

I'll submit a patch tomorrow.

Alexander
