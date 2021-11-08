Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752C44801D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 14:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhKHNSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 08:18:36 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:37923 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235636AbhKHNSf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 08:18:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636377351; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=A1GF7ciAhzKFLhXNoAxvAUsh4dNzJRLyoFWA/HdTu3Y=; b=Rh+cjppPIQ5Y2aN+PlzoWR62CTi4H9Ic12iX+Ethu1gx2HmjzNCgaWz6cDnYkZSMQm3baD84
 7exQGeG87/03nOoeapZcooP0T/V6EHDaXPc1ECZROaNIwjKpv4splrbpYOSO5+Kq5tjqS1qG
 dGXkxa0zz9IYkzwXK0rrlzRRzKg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 618923069198e3b2569ed8d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Nov 2021 13:15:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF458C43460; Mon,  8 Nov 2021 13:15:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBE9CC4338F;
        Mon,  8 Nov 2021 13:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EBE9CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH] ath11k: add string type to search board data in board-2.bin for WCN6855
References: <20210913181131.194024-1-jouni@codeaurora.org>
Date:   Mon, 08 Nov 2021 15:15:44 +0200
In-Reply-To: <20210913181131.194024-1-jouni@codeaurora.org> (Jouni Malinen's
        message of "Mon, 13 Sep 2021 21:11:31 +0300")
Message-ID: <87mtmepz3z.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Wen Gong <wgong@codeaurora.org>
>
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
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 27 ++++++++++++++++++++------
>  drivers/net/wireless/ath/ath11k/core.h | 13 +++++++++++++
>  drivers/net/wireless/ath/ath11k/pci.c  | 10 ++++++++++
>  drivers/net/wireless/ath/ath11k/qmi.h  |  3 +++
>  4 files changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 8f09ae827170..a8c6f7cf33d5 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -406,11 +406,26 @@ static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
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
> +			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
> +			  ath11k_bus_str(ab->hif.bus),
> +			  ab->id.vendor, ab->id.device,
> +			  ab->id.subsystem_vendor,
> +			  ab->id.subsystem_device,
> +			  FIELD_GET(ATH11K_CHIP_ID_MASK, ab->qmi.target.chip_id),
> +			  ab->qmi.target.board_id & 0xFF,

Why are chip_id and board_id masked? Why cannot we use values directly
provided by the firmware?

And if we need to mask those, it's better to do them in qmi.c where they
are stored:

	if (resp.chip_info_valid) {
		ab->qmi.target.chip_id = resp.chip_info.chip_id;
		ab->qmi.target.chip_family = resp.chip_info.chip_family;
	}

	if (resp.board_info_valid)
		ab->qmi.target.board_id = resp.board_info.board_id;
	else
		ab->qmi.target.board_id = 0xFF;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
