Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E74458D12
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhKVLOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 06:14:41 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:23171 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhKVLOl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 06:14:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637579494; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JYTaObHzIxh6C32B2N15FaPkWgjeQafVaeU47vgZa5E=;
 b=Xh+qFoHJ6zZP7TlKcyvRIVrEHz+nkBeKWbpktm4LVSTrMOmvV24MwRJLKnaw0D7HuSO/KnqE
 bcynE22yMFQXP1P5089xaafuW+uIp55XiyYoSFOJ2iGe+57zb9angGJn+dzRvIsJaiOIkHtB
 RVX+cXIr2GWMYLJvrEMq39IRSGo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 619b7ae3e57f5502a4523c2a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 11:11:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 375E1C4338F; Mon, 22 Nov 2021 11:11:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E70DDC4360C;
        Mon, 22 Nov 2021 11:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E70DDC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] ath11k: get msi_data again after request_irq is
 called
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211026041636.5008-1-bqiang@codeaurora.org>
References: <20211026041636.5008-1-bqiang@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163757948549.22734.11076988421581123204.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 11:11:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> wrote:

> The reservation mode of interrupts in kernel assigns a dummy vector
> when the interrupt is allocated and assigns a real vector when the
> request_irq is called. The reservation mode helps to ease vector
> pressure when devices with a large amount of queues/interrupts
> are initialized, but only a minimal subset of those queues/interrupts
> is actually used.
> 
> So on reservation mode, the msi_data may change after request_irq
> is called, so ath11k reads msi_data again after request_irq is called,
> and then the correct msi_data is programmed into QCA6390 hardware
> components. Without this change, spurious interrupt occurs in case of
> one MSI vector. When VT-d in BIOS is enabled and ath11k can get 32 MSI
> vectors, ath11k always get the same msi_data before and after request_irq,
> that's why this change is only required when one MSI vector is to be
> supported.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

7 patches applied to ath-next branch of ath.git, thanks.

87b4072d7ef8 ath11k: get msi_data again after request_irq is called
01279bcd01d9 ath11k: add CE and ext IRQ flag to indicate irq_handler
4ab4693f327a ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
c41a6700b276 ath11k: refactor multiple MSI vector implementation
ac6e73483f7b ath11k: add support one MSI vector
915a081ff307 ath11k: do not restore ASPM in case of single MSI vector
e94b07493da3 ath11k: Set IRQ affinity to CPU0 in case of one MSI vector

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211026041636.5008-1-bqiang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

