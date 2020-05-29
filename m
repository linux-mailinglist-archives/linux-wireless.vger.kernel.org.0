Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8231E7D3A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 14:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgE2MaA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 08:30:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43671 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgE2M37 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 08:29:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590755399; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KSp3CUfantJjjy0gRx40mNlk42o3RuZm0eRjDulAmvw=;
 b=I1/KA63STz2Ut4KRkRtVV2/Q2/zEENoZ2W+S4kXNHQDCuL8aLsi14kJ/nBQkgB7ESV7MpH9m
 xr+PSZCY6IuGL+xyXmb3Un7kZ7E/LG6zHit5AFVDnvtO51Qo9eFP7Qt4ngeqkjfTN9OCKqPi
 iRExg1QYvmS9B3RXtQXTI6PEjas=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ed10040c0031c71c25eda96 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 12:29:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 912EFC433CA; Fri, 29 May 2020 12:29:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5767EC433C9;
        Fri, 29 May 2020 12:29:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 17:59:51 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: enable TKIP when using encapsulation
 offloading
In-Reply-To: <aaa53c3a9cf6788cb653eb574073a1a0bcc5e6bf.camel@sipsolutions.net>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
 <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
 (sfid-20200424_113624_468114_4CC488DE)
 <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
 <7fb606edf1e5c7ab5b1446d637768ee7@codeaurora.org>
 <aaa53c3a9cf6788cb653eb574073a1a0bcc5e6bf.camel@sipsolutions.net>
Message-ID: <4bab3197997bb2dd6555ff920c5dd1cb@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 17:40, Johannes Berg wrote:
> On Fri, 2020-05-29 at 17:38 +0530, Sathishkumar Muruganandam wrote:
> 
>> > I don't think it can. It doesn't have all the necessary information to
>> > call cfg80211_michael_mic_failure(), as far as I can tell.
>> 
>> Ath11k HW has capability of reporting TKIP MIC error when hw encap is
>> enabled as well, so TKIP encryption shall be enabled.
> 
> Maybe so. But it cannot tell wpa_supplicant about MIC errors, and so
> that cannot do countermeasures, so something isn't right.
> 
>> Shall we have a ieee80211_hw_flags for the driver to advertise TKIP 
>> MIC
>> error reporting capability when hw encap is enabled ?
>> TKIP bring-up will be disabled for the drivers which doesn't have the
>> capability.
> 
> That would be better, since for TKIP it's actually more tricky and
> requires more work.
> 
> But mostly I was thinking that you should make it possible for ath11k 
> to
> actually report the MIC errors up to userspace. Right now I don't think
> it can, because it doesn't have the netdev pointer?
> 

Yes, currently only tx encap support is added and rx decap support is in
progress to do TKIP MIC error reporting to userspace via 
cfg80211_michael_mic_failure().
With NL80211_CMD_MICHAEL_MIC_FAILURE, hostapd will be able to do TKIP 
counter-measures.

Thanks,
Sathishkumar
