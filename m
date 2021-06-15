Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F073A7980
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhFOIyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 04:54:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41483 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhFOIyH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 04:54:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623747123; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UfurvAI5gmjvhKXSvBE1vk57GCtIEol3U/zXy9tzXcI=;
 b=clCqDBH3yfF3yemTJXwchl8ANAl/XXx8t/0dOVp71A4cwsLynXAYn5BQFdk4qHGaW8JYZ/dS
 6pPOOpp7nCvpb9alJNe84nDE1h6ZgDaAw/7Fqfufc1/dSCerFexk2Vtwc1sA579EPdbCnSfg
 DVe6BXvYGuUysJwP597TKNqMpfE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c86a32b6ccaab753699445 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 08:52:02
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85D2FC43217; Tue, 15 Jun 2021 08:52:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17A99C43145;
        Tue, 15 Jun 2021 08:52:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Jun 2021 16:52:00 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/9] cfg80211/mac80211: Add support for 6GHZ STA for
 various modes : LPI, SP and VLP
In-Reply-To: <6add42222bd66655fe76ce62676bd105@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <6add42222bd66655fe76ce62676bd105@codeaurora.org>
Message-ID: <06f396f96870a57b9139095c550ee61a@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-25 18:04, Wen Gong wrote:
> On 2021-05-18 04:19, Wen Gong wrote:
>> It introduced some new concept:
>> power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
>> power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
>> power spectral density(psd)
>> 
>> This patchset for cfg80211/mac80211 is to add the definition of new
>> concept of 6G and add basic parse of IE(transmit power envelope
>> element) in beacon and save power spectral density(psd) reported
>> by lower-driver for 6G channel, the info will be passed to lower
>> driver when connecting to 6G AP.
>> 
>> Wen Gong (9):
>>   cfg80211: add power type definition for 6G Hz
>>   mac80211: add definition of regulatory info in 6G Hz operation
>>     information
>>   mac80211: add parse regulatory info in 6G Hz operation information
>>   cfg80211: add definition for 6G power spectral density(psd)
>>   cfg80211: save power spectral density(psd) of regulatory rule
>>   mac80211: add definition for transmit power envelope element
>>   mac80211: add parse transmit power envelope element
>>   mac80211: add transmit power envelope element and power constraint 
>> in
>>     bss_conf
>>   mac80211: save transmit power envelope element and power constraint
>> 
> ...
> Nobody have comments?
Hi Johannes Berg,

Do you have comments?
