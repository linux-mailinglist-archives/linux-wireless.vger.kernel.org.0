Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0B44E42E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhKLJyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 04:54:37 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:15644 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhKLJyh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 04:54:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636710706; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/zCpRT63mnO+KjCn3Vvfhc6iabeFMMs2BFMUyiQmfik=;
 b=Kl7F2gvWnhZ3+7tXqCBZfHg1BF0qyeuaq9mHMYGCiVQ3TVcxNYjEtADqtfOp2/2tkoMY+f4W
 0guUfFMlY5lDImBltHWKWracqnP6VzEA6hrFw2CLKWjEzunLy1YByLaCk0nj+Qhr5eDhgh9i
 Io6L547vahKxktFXnmHN4/i/bO8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 618e392ea445961e72fcf0bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 09:51:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79528C43460; Fri, 12 Nov 2021 09:51:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE41AC4360C;
        Fri, 12 Nov 2021 09:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CE41AC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add provision to configure rx hashmap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1635164316-27055-1-git-send-email-quic_ppranees@quicinc.com>
References: <1635164316-27055-1-git-send-email-quic_ppranees@quicinc.com>
To:     P Praneesh <quic_ppranees@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163671069706.11814.3105845576240199326.kvalo@codeaurora.org>
Date:   Fri, 12 Nov 2021 09:51:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <quic_ppranees@quicinc.com> wrote:

> Currently the hashmap is set to default during REO setup and all REO
> rings are equally distributed across 32 hash values.
> 
> In multiple radio cases, 40MHz+80MHz+160MHz, distributing received
> packets across all the CPU will cause CPU overhead. In this case,
> during runtime we can span 40MHz and 80MHz among 2 cores and remaining
> 2 cores are equally distributed for 160MHz by using register mapping.
> 
> Add provision to configure the hashmap during runtime through debugfs
> for improving flexibility to control the destination HW rx queues/rings,
> so that affinity could be used to assign those interrupts to specific
> rings. Setting 0 will disable hash based steering.
> 
> echo "hashmap" > /sys/kernel/debug/ath11k/ipq8074\ hw2.0/rx_hash
> 
> Developers who are aware of hardware register mapping can leverage
> this rx_hash debugfs.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>

debugfs is for debugging and testing. To me it looks like this feature is for
configuring the driver, not debugging.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1635164316-27055-1-git-send-email-quic_ppranees@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

