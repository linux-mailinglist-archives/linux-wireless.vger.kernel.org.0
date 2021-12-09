Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5500F46F24B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhLIRof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:44:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52060 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhLIRoa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:44:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D666BCE276D
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0A4C341C3;
        Thu,  9 Dec 2021 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071654;
        bh=IuFXyW0UIszz7IRa4DgXSvKvJgL6hujh2kGssNlUOZ8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ndfjZbeeTrThS7qGYe49kVoLULhSc8kcoEz6roxQM4/gMfkBIVi/xcQQAbORyGwB+
         jnnmwmwikfnHrF6rQGbbevrst4zWdMC4GtwQvPdLX4NzvCdMvmKWVfDYB0kihf6ElA
         f1Ca/nPJnZQV2FXE0/4CXMFP1nnEZOkbuUJXWGhbKI9HO8ZMtBYs6wMkFz5JjQc9Xl
         A+RdOoM7QwAad1ipUVKHBW10n+5lhkcdeK58Ng9mmgeJaX9AracXBj0eISy4WIaYS+
         45uy3NOd6uY3DSikmZvbHzbI0gpdrQZ8RagI0gCebNuG/O+5kdtohjHUovxuOGdIFz
         4sn6pIIXUphwg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 14/15] ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-15-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:40:51 +0200
In-Reply-To: <20211026111913.7346-15-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:19:12 -0400")
Message-ID: <87pmq5vfq4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Add the handler for WMI_VDEV_SET_TPC_POWER_CMDID, it is for 6 GHz band.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 63 +++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/wmi.h | 61 ++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 985035fab744..603a4373af57 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -2225,6 +2225,69 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
>  	return ret;
>  }
>  
> +int ath11k_wmi_send_vdev_set_tpc_power(struct ath11k *ar,
> +				       u32 vdev_id,
> +				       struct ath11k_reg_tpc_power_info *param)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct wmi_vdev_set_tpc_power_cmd *cmd;
> +	struct wmi_vdev_ch_power_info *ch;
> +	struct sk_buff *skb;
> +	struct wmi_tlv *tlv;
> +	u8 *ptr;
> +	int i, ret, len;
> +
> +	len = sizeof(*cmd) + TLV_HDR_SIZE;
> +	len += (sizeof(struct wmi_vdev_ch_power_info) * param->num_pwr_levels);
> +
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	ptr = skb->data;
> +
> +	cmd = (struct wmi_vdev_set_tpc_power_cmd *)ptr;
> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_VDEV_SET_TPC_POWER_CMD) |
> +			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
> +	cmd->vdev_id = vdev_id;
> +	cmd->psd_power = param->is_psd_power;
> +	cmd->eirp_power = param->eirp_power;
> +	cmd->power_type_6ghz = param->power_type_6g;
> +	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
> +		   "wmi TPC vdev_id: %d is_psd_power: %d eirp_power: %d power_type_6g: %d\n",
> +		   vdev_id, param->is_psd_power, param->eirp_power, param->power_type_6g);

"wmi tpc vdev_id %d is_psd_power %d eirp_power %d power_type_6g %d\n"

> +
> +	ptr += sizeof(*cmd);
> +	tlv = (struct wmi_tlv *)ptr;
> +	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
> +		      FIELD_PREP(WMI_TLV_LEN, param->num_pwr_levels * sizeof(*ch));
> +
> +	ptr += TLV_HDR_SIZE;
> +	ch = (struct wmi_vdev_ch_power_info *)ptr;
> +
> +	for (i = 0; i < param->num_pwr_levels; i++, ch++) {
> +		ch->tlv_header = FIELD_PREP(WMI_TLV_TAG,
> +					    WMI_TAG_VDEV_CH_POWER_INFO) |
> +				FIELD_PREP(WMI_TLV_LEN,
> +					   sizeof(*ch) - TLV_HDR_SIZE);
> +
> +		ch->chan_cfreq = param->chan_power_info[i].chan_cfreq;
> +		ch->tx_power = param->chan_power_info[i].tx_power;
> +
> +		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
> +			   "wmi TPC chan_cfreq: %d , tx_power: %d\n",
> +			   ch->chan_cfreq, ch->tx_power);

"wmi tpc chan_cfreq %d tx_power %d\n"

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
