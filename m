Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5312749F799
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 11:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbiA1Kur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 05:50:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45522 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347907AbiA1Kuf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 05:50:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85B8861E92;
        Fri, 28 Jan 2022 10:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA891C340E0;
        Fri, 28 Jan 2022 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643367034;
        bh=AwHz/9028/BB+o2wJdlF0quiUktHVDmT+1V1QIlbCgU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ffie739NVTRnWab+sJXAjyYQSWIvSrfwXIjklhvzT+mjZs0/2NiSm5GiKbxgpHFwz
         Gmw6KDBMnzN/Mb9PgJr9XXtyy67f+s3BQQLKekH3jlfUA8KKIZLpOCalzuVjEwIbnn
         21afcTyGHFKI7yNE2u50xDSvxZmr0gKk3rMXYDR5/Be7YJT4Kqcze6GoNa49pPSdPx
         eJVO7fEX3Zo0h1Z8wi27diPBcPWuDNV6ROsuB5EDWJxcPj0PgwRR5+ESUpBXNHLZ2m
         SvJGk3+MJTfPntuDZFVjMlfxkFtcWXJX0CZPAUB7ryqJy9CU4fTkgUC+YWtlJ6rP2O
         Q6QHfVAG1AEfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 10/19] ath11k: Add QMI changes for WCN6750
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-11-git-send-email-quic_mpubbise@quicinc.com>
Date:   Fri, 28 Jan 2022 12:50:30 +0200
In-Reply-To: <1642337235-8618-11-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:17:06 +0530")
Message-ID: <87o83wf821.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> In the case of WCN6750, FW doesn't request for DDR memory
> via QMI, instead it uses a fixed 12MB reserved Memory region
> in the DDR which is called as MSA region. As a result, QMI
> message sequence is not same as other ath11k supported devices.
>
> Also, M3 firmware will be bundled into the FW and will be
> downloaded to the target as part of Q6 boot.
>
> This is the QMI flow in the case of WCN6750,
>
> 1) QMI firmware indication REQ/RESP
> 2) QMI host capability REQ/RESP
> 3) QMI target capability REQ/RESP
> 4) QMI device info REQ/RESP
> 5) QMI BDF download
> 6) QMI FW ready
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

> @@ -2490,6 +2497,13 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
>  	struct qmi_txn txn;
>  	int ret = 0;
>  
> +	/* In the case of WCN6750, M3 is bundled into the FW
> +	 * binary, and will be downloaded as part of Q6 boot.
> +	 */
> +	if (!ab->bus_params.m3_fw_support &&
> +	    ab->bus_params.hybrid_bus_type)
> +		return 0;

A check like this makes me think if it's just better to m3_fw_support to
ath11k_hw_params. That way you could disable m3 for WCN6750 via
hw_params.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
