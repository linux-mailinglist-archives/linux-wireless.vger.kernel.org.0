Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4123E1165D4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 05:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLIEd3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 23:33:29 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:44652
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbfLIEd3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 23:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575866008;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=KQpRpRQoaMEDukK1IeBPBcM+8J7tLI1yFUGS9m9HLnQ=;
        b=Xvq1E/aRxj4+UhkfopTyYFjhJP2zDsopZY7EIVdA6iV/oLnX1N8CPzBX0y9Fxv7p
        LfkqakBQGSi5ODDroXg/wIE175e4Vlo0XGWQlPHfCqUfeIBTxE3lUnBUnRanI0ThCfN
        sT1ZTWeQxgZqJZDwBjlRErQDnhBfnRsc5H3YcP14=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575866008;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=KQpRpRQoaMEDukK1IeBPBcM+8J7tLI1yFUGS9m9HLnQ=;
        b=EKE7MkGQ8OZyR7tI9YXub4m7ybxO9Mqzm7sE87LE4Xz8o+d0oRkMfJOhzw4x5Ugj
        sAn9kKtQ0b8/PvE3C9j/AvvtXt+vjIoi744hk9lAwOxkbmqENLTq4Lxfsh2DsmPfgGF
        Nwk2C/ZB9m65qGP2zFRjiYKLH78wEx1Q3ej3iQRM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 9 Dec 2019 04:33:28 +0000
From:   vthiagar@codeaurora.org
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 6/7] ath11k: add WMI calls required for handling BSS color
In-Reply-To: <20191206143401.4080-6-john@phrozen.org>
References: <20191206143401.4080-1-john@phrozen.org>
 <20191206143401.4080-6-john@phrozen.org>
Message-ID: <0101016ee8ef01a3-a48ae67a-693f-4656-ae5e-0bc0cc63fe7a-000000@us-west-2.amazonses.com>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.12.09-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-06 20:04, John Crispin wrote:
> If the he_operation field of the beacon sets a BSS color, we need to 
> inform
> the FW of the settings. This patch adds the WMI command handlers 
> required
> to do so.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 67 +++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/wmi.h | 31 +++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c
> b/drivers/net/wireless/ath/ath11k/wmi.c
> index 8cf7220a95f9..5d9276db9a85 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -2789,6 +2789,73 @@ ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar,
> u32 vdev_id,
>  	return ret;
>  }
> 
> +int
> +ath11k_wmi_send_obss_color_collision_cfg_cmd(struct ath11k *ar, u32 
> vdev_id,
> +					     u8 bss_color, u32 period,
> +					     bool enable)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct ath11k_base *ab = wmi->wmi_ab->ab;
> +	struct wmi_obss_color_collision_cfg_params_cmd *cmd;
> +	struct sk_buff *skb;
> +	int ret, len;
> +
> +	len = sizeof(*cmd);
> +
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_obss_color_collision_cfg_params_cmd *)skb->data;
> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
> WMI_TAG_OBSS_COLOR_COLLISION_DET_CONFIG) |
> +			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
> +	cmd->vdev_id = vdev_id;
> +	cmd->evt_type = enable ? ATH11K_OBSS_COLOR_COLLISION_DETECTION :
> +				 ATH11K_OBSS_COLOR_COLLISION_DETECTION_DISABLE;
> +	cmd->current_bss_color = bss_color;
> +	cmd->detection_period_ms = period;
> +	cmd->scan_period_ms = ATH11K_BSS_COLOR_COLLISION_SCAN_PERIOD_MS;
> +	cmd->free_slot_expiry_time_ms = 0;
> +	cmd->flags = 0;
> +
> +	ret = ath11k_wmi_cmd_send(wmi, skb,
> +				  WMI_OBSS_COLOR_COLLISION_DET_CONFIG_CMDID);
> +	if (ret) {
> +		ath11k_warn(ab, "Failed to send 
> WMI_OBSS_COLOR_COLLISION_DET_CONFIG_CMDID");
> +		dev_kfree_skb(skb);
> +	}

WMI debug log please.

> +	return ret;
> +}
> +
> +int ath11k_wmi_send_bss_color_change_enable_cmd(struct ath11k *ar,
> u32 vdev_id, bool enable)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct ath11k_base *ab = wmi->wmi_ab->ab;
> +	struct wmi_bss_color_change_enable_params_cmd *cmd;
> +	struct sk_buff *skb;
> +	int ret, len;
> +
> +	len = sizeof(*cmd);
> +
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_bss_color_change_enable_params_cmd *)skb->data;
> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, 
> WMI_TAG_BSS_COLOR_CHANGE_ENABLE) |
> +			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
> +	cmd->vdev_id = vdev_id;
> +	cmd->enable = enable ? 1 : 0;
> +
> +	ret = ath11k_wmi_cmd_send(wmi, skb,
> +				  WMI_BSS_COLOR_CHANGE_ENABLE_CMDID);
> +	if (ret) {
> +		ath11k_warn(ab, "Failed to send WMI_TWT_DIeABLE_CMDID");
> +		dev_kfree_skb(skb);
> +	}

Same here.


Vasanth
