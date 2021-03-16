Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0181E33DB32
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhCPRpq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 13:45:46 -0400
Received: from z11.mailgun.us ([104.130.96.11]:21194 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239020AbhCPRpe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 13:45:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615916733; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cG9vldJJ1LkzKM/FgVY+2KK5neliGdtcrk5p6nSslQU=;
 b=mHl6AbP5bkfrg85dHIPfkuaDKLBhvC8O4GdW5+7Q5BVVZfwQ+A1DHesWn2mIcfWL+umAz93q
 Nk1735t6cGUfzKF+AO5kx+1WpaqwCkYa5OJtFWyIM2z9tEl9Ld/8RHrtbHt1NIdK5gt9edQ3
 PbOHALDojRNp3OavQpMyDwwMt0w=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6050eeb05d70193f88dc57a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Mar 2021 17:45:20
 GMT
Sender: gsamin=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 738EAC433C6; Tue, 16 Mar 2021 17:45:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: gsamin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D5C7C433C6;
        Tue, 16 Mar 2021 17:45:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 16 Mar 2021 23:15:19 +0530
From:   Govindaraj Saminathan <gsamin@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] mac80211: fix low throughput due to invalid addba
 extension
In-Reply-To: <e38a1ff5efbe5532a97310c053b50c6ce5ef027e.camel@sipsolutions.net>
References: <1615909674-13412-1-git-send-email-gsamin@codeaurora.org>
 <e38a1ff5efbe5532a97310c053b50c6ce5ef027e.camel@sipsolutions.net>
Message-ID: <631e58cbfc146db2a6ca70ffc8b90648@codeaurora.org>
X-Sender: gsamin@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-03-16 21:21, Johannes Berg wrote:
> On Tue, 2021-03-16 at 21:17 +0530, Govindaraj wrote:
>> Addba request action frame received with the extension element from
>> certain 11ac stations,
>> 
> 
> Please indicate which so we have a record of who's shipping broken 
> junk.
> 
>> but the cmd id and length not matching to addba
>> extension and it failing in element parsing.
> 
>> Due to this, addba request
>> not acknowledged and aggregation not started which is causing low
>> throughput. Hence validating the cmd id before processing addba 
>> extension.
> 
>>  	ies_len = len - offsetof(struct ieee80211_mgmt,
>>  				 u.action.u.addba_req.variable);
>> -	if (ies_len) {
>> +	if (ies_len &&
>> +	    mgmt->u.action.u.addba_req.variable[0] == WLAN_EID_ADDBA_EXT) {
>>  		ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
>>                                  ies_len, true, &elems, mgmt->bssid, 
>> NULL);
>>  		if (elems.parse_error)
> 
> So we get into parse_error without this?
yes, we getting parse error.
> 
> What are they putting there instead?
first 9 bytes are addba request action frame and remaining 7 bytes 
extension causing for parse error.
03 00 01 02 10 00 00 e0 0a cf 08 06 11a 46 09 fe
> 
> johannes
