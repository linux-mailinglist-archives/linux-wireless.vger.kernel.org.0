Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E655345902C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 15:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhKVO2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 09:28:52 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:44362 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbhKVO2v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 09:28:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637591144; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O5LEWHvlqelZZBsxlrDsi4+wwGGYq7RrqrTfQUl0ntM=; b=Dt3W88FYC9ofStutQBan5X77R0W9ELO7bSvkWuWgNxVgRkCj/Sm58wKO9KZygMAr5Vv3by/j
 6UJsdU97T4k42uAnoWBdMUQoy8K0JeVNk8wH9lkdF28H8v3LS5fYekaeB/Eg1ijblUTeqOsA
 VeXaRZDIQ/eZMZ/21p5IDyfmcjQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 619ba85c4fca5da46de31279 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 14:25:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8DAE0C4338F; Mon, 22 Nov 2021 14:25:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43DC3C4360D;
        Mon, 22 Nov 2021 14:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 43DC3C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: add read variant from SMBIOS for download board data
References: <20211118100033.8384-1-quic_wgong@quicinc.com>
Date:   Mon, 22 Nov 2021 16:25:29 +0200
In-Reply-To: <20211118100033.8384-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 18 Nov 2021 05:00:33 -0500")
Message-ID: <87o86c8dye.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> This is to read variant from SMBIOS such as read from DT, the variant
> string will be used to one part of string which used to search board
> data from board-2.bin.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +int ath11k_core_check_smbios(struct ath11k_base *ab)
> +{
> +	ab->qmi.target.bdf_ext[0] = '\0';
> +	dmi_walk(ath11k_core_check_bdfext, ab);

For consistency I added error handling for dmi_walk().

> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index bbfc10fd5c6d..b234514e7138 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -952,7 +952,18 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
>  			  struct ath11k_board_data *bd);
>  void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
>  int ath11k_core_check_dt(struct ath11k_base *ath11k);
> +/* SMBIOS type containing Board Data File Name Extension */
> +#define ATH11K_SMBIOS_BDF_EXT_TYPE 0xF8
>  
> +/* SMBIOS type structure length (excluding strings-set) */
> +#define ATH11K_SMBIOS_BDF_EXT_LENGTH 0x9
> +
> +/* Offset pointing to Board Data File Name Extension */
> +#define ATH11K_SMBIOS_BDF_EXT_OFFSET 0x8
> +
> +/* The magic used by QCA spec */
> +#define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
> +int ath11k_core_check_smbios(struct ath11k_base *ab);
>  void ath11k_core_halt(struct ath11k *ar);
>  int ath11k_core_resume(struct ath11k_base *ab);
>  int ath11k_core_suspend(struct ath11k_base *ab);

This was an awkward place for the defines, so I moved up in the file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
