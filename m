Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A62455900
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbhKRK2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:28:42 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:22180 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242769AbhKRK2j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:28:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637231139; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4927RC/IA3KFdMDmSVHhPFatshhrWxyEjmsrez8/tlA=;
 b=s/DXdebV+nGytJtdayLrzE9z6RXdyhGAqJRgKh0tEkmZDdZaAs9y29FVd5g2YvW5q48Ft9s+
 hkhPtuEL9jJQEVJJaTm09hgaeaBl04YiQkShxqh+LIqT1xMePv+hSV3kwTaUkeInYs4nMNyA
 SVY+r/uJYoUzYHe3UJhrln/2l1Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61962a23638a2f4d610e0c65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 10:25:39
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9203C43460; Thu, 18 Nov 2021 10:25:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CB3EC4338F;
        Thu, 18 Nov 2021 10:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Nov 2021 18:25:38 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add read variant from SMBIOS for download board
 data
In-Reply-To: <163713928364.10263.15372409026240983506.kvalo@codeaurora.org>
References: <20211011082433.30415-1-wgong@codeaurora.org>
 <163713928364.10263.15372409026240983506.kvalo@codeaurora.org>
Message-ID: <d9ff63f49c50b0561932be77bed5ce87@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-17 16:54, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> wrote:
> 
>> This is to read variant from SMBIOS such as read from DT, the variant
>> string will be used to one part of string which used to search board
>> data from board-2.bin.
>> 
>> Tested-on: WCN6855 hw2.0 PCI 
>> WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> 
> I'm dropping all patches listed below in one go. I didn't manage to
> apply any of these without conflicts, please remember to always use
> ath.git master branch as the baseline to avoid conflicts.
> 
> 9 patches set to Changes Requested.
> 
> 12549401 ath11k: add read variant from SMBIOS for download board data
> 12549415 ath11k: add wait operation for tx management packets for
> flush from mac80211
> 12549419 ath11k: change to treat alpha code na as world wide regdomain
> 12549431 ath11k: report rssi of each chain to mac80211
> 12549433 ath11k: Add signal report to mac80211 for QCA6390 and WCN6855
> 12549449 ath11k: report tx bitrate for iw wlan station dump
> 12554953 ath11k: add support for hardware rfkill for QCA6390
> 12583807 ath11k: add 11d scan offload support
> 12583809 ath11k: calculate the correct NSS of peer for HE capabilities

I have rebased to latest ath.git master ath-202111170737 and resend v2 
for below patches:
[v2] ath11k: report rssi of each chain to mac80211
[v2,0/2] ath11k: add 11d scan offload support for QCA6390/WCN6855
[v2] ath11k: add read variant from SMBIOS for download board data
[v2] ath11k: skip sending vdev down for channel switch
[v2] ath11k: fix read fail for htt_stats and htt_peer_stats for single 
pdev
[v2] ath11k: calculate the correct NSS of peer for HE capabilities
[v2] ath11k: add wait operation for tx management packets for flush from 
mac80211
[v2] ath11k: change to treat alpha code na as world wide regdomain

I will rebase the left patches after these patches upstream, otherwise 
the left patches will have conflict with these patches
because they change same location but actually have no logic relation.
