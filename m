Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372B7450163
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhKOJb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:31:58 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:23415 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbhKOJZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:25:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636968165; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=U62EmARxNR8KH+ktmhYEC9AhrDv5PTxIm7p0ahUtG9M=;
 b=GgjaYmWREziSvn9VxhkaX3gRGkj1ukhSXLqF0K6f3E8DQdR8R/mthZ1ZSZxcBnA8VeXW+zk6
 K0sBc2T9DTIqT69W7DPQs8q5hOIwp6GklZtTQUQBTk+Mu6t+ggiQztj04uOrQofzuTsZ5gL0
 TR+ylYRR4q38KWJ9DfD+d0mPOCs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 619226e4bb7027b8e18b90de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:22:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3041BC4338F; Mon, 15 Nov 2021 09:22:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15117C43460;
        Mon, 15 Nov 2021 09:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 15117C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/12] ath11k: disable unused CE8 interrupts for
 ipq8074
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1630560820-21905-2-git-send-email-ppranees@codeaurora.org>
References: <1630560820-21905-2-git-send-email-ppranees@codeaurora.org>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696815604.13305.8404519954796662032.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:22:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <ppranees@codeaurora.org> wrote:

> Host driver doesn't need to process CE8 interrupts (used
> by target independently)
> 
> The volume of interrupts is huge within short interval,
>  CPU0           CPU1       CPU2       CPU3
> 14022188          0          0          0       GIC  71 Edge      ce8
> 
> Hence disabling unused CE8 interrupt will improve CPU usage.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

12 patches applied to ath-next branch of ath.git, thanks.

2c5545bfa29d ath11k: disable unused CE8 interrupts for ipq8074
6452f0a3d565 ath11k: allocate dst ring descriptors from cacheable memory
5e76fe03dbf9 ath11k: modify dp_rx desc access wrapper calls inline
a1775e732eb9 ath11k: avoid additional access to ath11k_hal_srng_dst_num_free
c4d12cb37ea2 ath11k: avoid active pdev check for each msdu
db2ecf9f0567 ath11k: remove usage quota while processing rx packets
400588039a17 ath11k: add branch predictors in process_rx
d0e2523bfa9c ath11k: allocate HAL_WBM2SW_RELEASE ring from cacheable memory
a8508bf7ced2 ath11k: remove mod operator in dst ring processing
cbfbed495d32 ath11k: avoid while loop in ring selection of tx completion interrupt
bcef57ea400c ath11k: add branch predictors in dp_tx path
be8867cb4765 ath11k: avoid unnecessary lock contention in tx_completion path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1630560820-21905-2-git-send-email-ppranees@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

