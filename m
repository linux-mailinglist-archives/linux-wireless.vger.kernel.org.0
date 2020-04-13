Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F21A654E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgDMKmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 06:42:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33449 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727776AbgDMKl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 06:41:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586774518; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BLIfpS2X7n41IUOye8ElAh0Wra+ZHgzc1tlUzqOHPPg=;
 b=i3XrGCxWFz22rhAgKVbUirb5uNBiLeIciavnbqCCRM5r+myA3uPkf1KI3D4v7neii+RCpIdk
 Mjl3P945hvGTIL+Wzo2T9jOZLJxIZ6ByPQvgkNozJpir5Tnvkl7VIDUkBvNBG/2TYM+9Rcgi
 N7lEuKfO3fGSws0JYXvhpl2yKOI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9441e7.7f5901f30e30-smtp-out-n03;
 Mon, 13 Apr 2020 10:41:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 43503C433BA; Mon, 13 Apr 2020 10:41:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1185C433CB;
        Mon, 13 Apr 2020 10:41:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Apr 2020 16:11:41 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>, shaul.triebitz@intel.com
Cc:     'Luca Coelho' <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: 4addr NDP in HE mode
In-Reply-To: <d54ca54a2a7801b796393be3f5414f7a657773b4.camel@sipsolutions.net>
References: <006501d5e621$f21f3b60$d65db220$@codeaurora.org>
 (sfid-20200218_070924_650739_B62973D0)
 <d54ca54a2a7801b796393be3f5414f7a657773b4.camel@sipsolutions.net>
Message-ID: <1b40c00498b6e0509ddc6176a4578188@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-20 18:28, Johannes Berg wrote:
> On Tue, 2020-02-18 at 11:39 +0530, Sathishkumar Muruganandam wrote:
> 
>> Since ieee80211_send_4addr_nullfunc() is only called for successful
>> association of 4addr STA, shall we allow below case alone for HE ?
>> 
>> static bool ieee80211_assoc_success(struct ieee80211_sub_if_data 
>> *sdata,
>>                                     struct cfg80211_bss *cbss,
>>                                     struct ieee80211_mgmt *mgmt, 
>> size_t len,
>>                                     struct ieee802_11_elems *elems)
>> {
>> ..
>>   /*
>>          * If we're using 4-addr mode, let the AP know that we're
>>          * doing so, so that it can create the STA VLAN on its side
>>          */
>>         if (ifmgd->use_4addr)
>>                 ieee80211_send_4addr_nullfunc(local, sdata);
>> ..
>> 
>> Whether this 4addr NDP in HE mode will affect any UL-MIMO from the 
>> 4addr STA
>> ? Please comment.
> 
> Off the top of my head, I don't know. Adding Shaul who might have an
> idea.
> 
> Shaul, basically the NDP is used here to initialize the 4-addr
> connection as such, and if the connection is HE capable we drop it. Can
> you remind me what exactly the issue with NDP in HE was, and do you 
> know
> how that'd be affected by 4-addr NDPs?
> 

Shaul, awaiting your response !

Thanks,
Sathishkumar
