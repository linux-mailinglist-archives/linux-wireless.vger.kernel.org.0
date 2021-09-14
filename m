Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729AF40A968
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhINIh6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 04:37:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16981 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhINIh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 04:37:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631608601; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ThxMhkVj/OTj4p4TH0zWh6uCc1CbZd7A1TXlOIaUUwU=;
 b=PSFudoHoW9Q9wt5wvMCD9OdFcT/1pye8hZs4N37y028g5ovqjWM+7ksuAaY5CWLKHBr15iwz
 EodaaGzoOV4opqt+1arvlhEj4nbNOfM04pnHc5O2abBgioKMk+ZmImPhfD0okC/g2bq3ixoV
 TdmmdAkLqyLT9olYoXh35/h2gcE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61405f18bd6681d8edc5c07b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 08:36:40
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 751B9C43460; Tue, 14 Sep 2021 08:36:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F3F1C4338F;
        Tue, 14 Sep 2021 08:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6F3F1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: Split PCI write/read functions
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210913180902.193874-2-jouni@codeaurora.org>
References: <20210913180902.193874-2-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210914083639.751B9C43460@smtp.codeaurora.org>
Date:   Tue, 14 Sep 2021 08:36:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> ath11k_pci_write32/read32 tries to wake up MHI before doing actual
> write/read work, which means each time a u32 is written/read, MHI
> wake up is performed. This is not necessary in case where we do a
> large amount of write/read, cause only one time of wake up is needed.
> So split each one into two parts, the first part does MHI get/put
> and the second one does actual write/read work.
> 
> Also avoid the put operation if the previous get operation fails.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This causes new warnings:

drivers/net/wireless/ath/ath11k/pci.c:177:6: error: no previous prototype for 'ath11k_pci_do_write32' [-Werror=missing-prototypes]
drivers/net/wireless/ath/ath11k/pci.c:224:5: error: no previous prototype for 'ath11k_pci_do_read32' [-Werror=missing-prototypes]

I fixed them in the pending branch like this:

--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -174,7 +174,7 @@ static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
        return window_start;
 }
 
-void ath11k_pci_do_write32(struct ath11k_base *ab, u32 offset, u32 value)
+static void ath11k_pci_do_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
        struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
        u32 window_start;
@@ -221,7 +221,7 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
                mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
-u32 ath11k_pci_do_read32(struct ath11k_base *ab, u32 offset)
+static u32 ath11k_pci_do_read32(struct ath11k_base *ab, u32 offset)
 {
        struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
        u32 val, window_start;


-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210913180902.193874-2-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

