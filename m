Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089D8450475
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 13:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhKOMgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 07:36:32 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:13772 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKOMga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 07:36:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636979614; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gE7WOtuGMUbwrv9NMhWGakPOiySEjRXkywfT11D4RW8=; b=j59X2dkishaymSeCwqyR+8FLaFlyRRPC82tuNP1sXGCTs++k9NIIhegfJ1A+ajsL1NTgaIQ+
 LR7I1uBbWvtwmqBAVffho5/NzncNDnRl2aG1xVK1s+JkATAGUztsdEm51Tyc8fDkoB5/MXWO
 Zb7DGI3DyOmMY6R9TV9RMFTj4jI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6192539e13b6884719196356 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 12:33:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97E75C43616; Mon, 15 Nov 2021 12:33:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14E82C4338F;
        Mon, 15 Nov 2021 12:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 14E82C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: add string type to search board data in board-2.bin for WCN6855
References: <20211111065340.20187-1-quic_wgong@quicinc.com>
Date:   Mon, 15 Nov 2021 14:33:29 +0200
In-Reply-To: <20211111065340.20187-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 11 Nov 2021 01:53:40 -0500")
Message-ID: <87sfvxha3q.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Currently ath11k only support string type with bus, chip id and board id
> such as "bus=ahb,qmi-chip-id=1,qmi-board-id=4" for ahb bus chip and
> "bus=pci,qmi-chip-id=0,qmi-board-id=255" for PCIe bus chip in
> board-2.bin. For WCN6855, it is not enough to distinguish all different
> chips.
>
> This is to add a new string type which include bus, chip id, board id,
> vendor, device, subsystem-vendor and subsystem-device for WCN6855.
>
> ath11k will first load board-2.bin and search in it for the board data
> with the above parameters, if matched one board data, then download it
> to firmware, if not matched any one, then ath11k will download the file
> board.bin to firmware.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Jouni Malinen <quic_jouni@quicinc.com>
> ---
> v2: remove the mask of chip id and board id in ath11k_core_create_board_name()
>
>  drivers/net/wireless/ath/ath11k/core.c | 27 ++++++++++++++++++++------
>  drivers/net/wireless/ath/ath11k/core.h | 13 +++++++++++++
>  drivers/net/wireless/ath/ath11k/pci.c  | 10 ++++++++++
>  3 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 2012b0170e3c..3ac0dca997e1 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -473,11 +473,26 @@ static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
>  		scnprintf(variant, sizeof(variant), ",variant=%s",
>  			  ab->qmi.target.bdf_ext);
>  
> -	scnprintf(name, name_len,
> -		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
> -		  ath11k_bus_str(ab->hif.bus),
> -		  ab->qmi.target.chip_id,
> -		  ab->qmi.target.board_id, variant);
> +	switch (ab->id.bdf_search) {
> +	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
> +		scnprintf(name, name_len,
> +			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%04x,qmi-board-id=%04x%s",

For consistency I changed qmi-chip-id and qmi-board-id to use %d, like
before:

 "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",

This is now in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
