Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE67D409D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjJWUGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJWUF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 16:05:59 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847AF9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 13:05:57 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2CC4324007C;
        Mon, 23 Oct 2023 20:05:55 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6DC0913C2B0;
        Mon, 23 Oct 2023 13:05:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6DC0913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698091554;
        bh=jIru+GbdLJ062v0dHJTA9uRftVTJ9St5VtB1EObNycQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kC9S3wzxBO/QQszdXcRcmcDsED5DnH2sghCy1ce/w74OFtBCikZ4LquKetfdCN2S2
         ZJC0HELn/i4y3gcMg9k1jG+mBSWP/V2HBlhqTyyxG/t1e0kgMzF/Hmhf0xD1VrFv6R
         Td0Z1Wno6bH6PwJiYbAsZxwnd0exapEmtu3Ew69k=
Message-ID: <c6a2047e-0b01-bdd7-9920-5a1c81aa96b3@candelatech.com>
Date:   Mon, 23 Oct 2023 13:05:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: mac80211: work around crash in mlme.c
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20231023175738.1686631-1-greearb@candelatech.com>
 <08a47f34f85bb64be720e473d5a43193412185a1.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <08a47f34f85bb64be720e473d5a43193412185a1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698091556-4bh3lvb5e7Vu
X-MDID-O: us5;at1;1698091556;4bh3lvb5e7Vu;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/23/23 11:17, Johannes Berg wrote:
> On Mon, 2023-10-23 at 10:57 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Protect from NULL ifmgd->assoc_data in ieee80211_mgd_deauth, crash
>> was seen here fairly often in a 32-station test case utilizing
>> mtk7922 and be200 radios.  I'm not sure if radio types matters
>> though.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>
>> Patch is for wireless-next tree, bug was likely introduced in
>> this release since this crash was not seen in earlier 6.6-rc testing
>> nor in 6.5 or earlier.
>>
>> There may be a better way to fix this...
> 
> I mean, you're not *actually* suggesting we merge this patch, right?
> Right?!

No, but it is easier to explain backtraces when you can see the code that
generated it.

> 
>> +++ b/net/mac80211/mlme.c
>> @@ -8185,13 +8185,18 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
> 
> I don't know what you did there, but that file doesn't even have 8k
> lines for me.

The bug appears to have come in with this patch that I grabbed from linux-wireless
mailing list:

[greearb@ben-dt5 linux-6.6-wn.dev.y]$ git show 4600547c01ef7
commit 4600547c01ef728113253c6df9367eb4ed75193c
Author: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Date:   Thu Sep 28 17:35:34 2023 +0300

     wifi: mac80211: add link id to mgd_prepare_tx()

     As we are moving to MLO and links terms, also the airtime protection
     will be done for a link rather than for a vif. Thus, some
     drivers will need to know for which link to protect airtime.
     Add link id as a parameter to the mgd_prepare_tx() callback.

     Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
     Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>


I see no response to it on linux-wireless mailing list.  I applied the
series locally since it preceded other iwlwifi related patches that
I wanted to test.

>>   			   "aborting authentication with %pM by local choice (Reason: %u=%s)\n",
>>   			   req->bssid, req->reason_code,
>>   			   ieee80211_get_reason_code_string(req->reason_code));
> 
> So let me get this straight ... this is the "aborting authentication"
> (!) case, but
> 
>> -
>> -		info.link_id = ifmgd->assoc_data->assoc_link_id;
> 
> your code is accessing the assoc_data? I'm not surprised that crashes,
> but that's in no way what the upstream code looks like?

So proper fix (assuming Miri's patch is applied at all) is to just not
assign link-id in this specific case?

Also, there was a WARN_ON from net/wireless/mlme.c that was triggered just
after my splat, from the method below.

eca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  128) static void cfg80211_process_disassoc(struct wireless_dev *wdev,
3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  129)                                      const u8 *buf, size_t len,
3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  130)                                      bool reconnect)
6039f6d23fe79 (Jouni Malinen             2009-03-19 13:39:21 +0200  131) {
f26cbf401be93 (Zhao, Gang                2014-04-21 12:53:03 +0800  132)        struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
6829c878ecd24 (Johannes Berg             2009-07-02 09:13:27 +0200  133)        struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
19957bb399e27 (Johannes Berg             2009-07-02 17:20:43 +0200  134)        const u8 *bssid = mgmt->bssid;
ceca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  135)        u16 reason_code = le16_to_cpu(mgmt->u.disassoc.reason_code);
ceca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  136)        bool from_ap = !ether_addr_equal(mgmt->sa, wdev->netdev->dev_addr);
6829c878ecd24 (Johannes Berg             2009-07-02 09:13:27 +0200  137)
3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  138)        nl80211_send_disassoc(rdev, wdev->netdev, buf, len, reconnect,
3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  139)                              GFP_KERNEL);
a3b8b0569fbef (Jouni Malinen             2009-03-27 21:59:49 +0200  140)
7b0a0e3c3a882 (Johannes Berg             2022-04-14 16:50:57 +0200  141)        if (WARN_ON(!wdev->connected ||
7b0a0e3c3a882 (Johannes Berg             2022-04-14 16:50:57 +0200  142)                    !ether_addr_equal(wdev->u.client.connected_addr, bssid)))
596a07c18b35c (Johannes Berg             2009-07-11 00:17:32 +0200  143)                return;
6829c878ecd24 (Johannes Berg             2009-07-02 09:13:27 +0200  144)
ceca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  145)        __cfg80211_disconnected(wdev->netdev, NULL, 0, reason_code, from_ap);
ceca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  146)        cfg80211_sme_disassoc(wdev);
667503ddcb96f (Johannes Berg             2009-07-07 03:56:11 +0200  147) }

And of course it is always possible some other patch I've applied or created is actually
triggering this problem.

>> +		if (WARN_ON_ONCE((unsigned long)(ifmgd) < 4000 ||
>> +				 (unsigned long)(ifmgd->assoc_data) < 4000)) {
> 
> You complain that it takes effort to get stuff upstream, but at the same
> time this is what you post - you can't have really bad patches and a
> fast track into upstream at the same time...

Of course I don't expect every patch to go upstream effortlessly.

But there is also the case where a patch may be technically OK, and useful
to me, but it is not an API or feature that the driver/stack maintainer
cares about, so it is ignored.  Regarding my previous patch to fix a
crash, I'm not going to spend my time renaming
variables on the off chance that you'd like the patch vs just fixing the
specific broken code and moving on to other tasks.  Since you known your
own mind, you could rename variables in 2 minutes, post the patch, and
you'd be done.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


