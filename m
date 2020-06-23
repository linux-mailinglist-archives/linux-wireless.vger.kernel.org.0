Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F0204BB9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 09:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgFWHxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 03:53:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13987 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgFWHxY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 03:53:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592898804; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=e2mGF6PtNNfI3gEF24guLC1y1di3bczVoNfQ+izipEs=;
 b=XtrNmFBK8+2R3CrQP0Tlic9umqX9+nciMtKtir0tclDi/egwrCqEWiJRHpVOzR7wq88ojy6q
 lg9yxLhO/boT++Hkviw84Xm8KQuJxcjhrCmUDCHR2rDMrMYyjn9NYjXFlKhfrx3QThfABQoM
 h1kQzdm0THqFMJ03HMRvKdy2kVM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ef1b4ea86de6ccd445af177 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 07:53:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 407F3C433CB; Tue, 23 Jun 2020 07:53:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0398AC433C8;
        Tue, 23 Jun 2020 07:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0398AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/12] ath11k: ahb: call ath11k_core_init() before irq
 configuration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1592316055-24958-2-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200623075313.407F3C433CB@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 07:53:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> This is needed to init .max_radios in hw_params and onfigure external
> interrupts for available pdev_ids.
> 
> Compile tested only.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

12 patches applied to ath-next branch of ath.git, thanks.

166e22b38aa3 ath11k: ahb: call ath11k_core_init() before irq configuration
d3318abf41cf ath11k: convert ath11k_hw_params to an array
b1cc29e97d1b ath11k: define max_radios in hw_params
d547ca4c8cc5 ath11k: add hw_ops for pdev id to hw_mac mapping
3b94ae4c62db ath11k: Add bdf-addr in hw_params
7b57b2ddec21 ath11k: create a common function to request all firmware files
34d9fc80bac3 ath11k: don't use defines for hw specific firmware directories
31d78a3de4de ath11k: change ath11k_core_fetch_board_data_api_n() to use ath11k_core_create_firmware_path()
21b1a5a4c34c ath11k: remove useless info messages
6e5dd03c0b1f ath11k: qmi: cleanup info messages
b3a18338ebd6 ath11k: don't use defines in hw_params
a9bf09093203 ath11k: remove define ATH11K_QMI_DEFAULT_CAL_FILE_NAME

-- 
https://patchwork.kernel.org/patch/11607585/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

