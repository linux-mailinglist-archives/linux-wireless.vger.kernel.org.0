Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BBC113AFB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 05:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfLEE56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 23:57:58 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:43954
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728522AbfLEE55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 23:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575521876;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=rbyG6gpalqEBAd4o6L3Tn57JuIJKKpj9UtUP0IY/Cdk=;
        b=RnSfFbDjSucnKCWM9+tTe4HZTJUYo11pnrjd+RH+pDEMJgQKCClmddAOaKnRZDRX
        EOiVHp5HmqNKAoTsqYBZsoBY5JAC7BRooOTpQkzrZUeLP6uLj3cIyzIzJFtJRZ48XQc
        ovNyEiEoypjz1oKA4/HJ/VuAxPNGQsxu0fgspDUk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575521876;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=rbyG6gpalqEBAd4o6L3Tn57JuIJKKpj9UtUP0IY/Cdk=;
        b=B2I1hNDLCRDg1RKSDfmkdi3K0Uoo1mKEnakbNZqle0TATbQy2hcbQRQ+kdHOW5yU
        pXRkKXJwg7fzstJu/4AO3nkpi+zGSmYSgcun23Syx+SXP7yJm/u4DiUQPn+E1dfd3++
        ZXz7oi2n7jux2qp0lg11LsvwchS+djBqdSkroSYQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 5 Dec 2019 04:57:56 +0000
From:   vthiagar@codeaurora.org
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] ath11k: add OMI debug support
In-Reply-To: <20191204162541.9602-1-john@phrozen.org>
References: <20191204162541.9602-1-john@phrozen.org>
Message-ID: <0101016ed46bf9fd-78e30229-67e8-4282-a006-880ae8edc425-000000@us-west-2.amazonses.com>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.12.05-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-04 21:55, John Crispin wrote:
> This patch allows us to initiate a OMI transaction for test purposes 
> using
> a debugfs interface. the xmit_omi file expects 9 parameters. The first 
> two
> are VHT and HE followed by the 7 A-Control fields from D4.0/9.2.4.6a.2.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  drivers/net/wireless/ath/ath11k/debug.h       | 10 ++++
>  drivers/net/wireless/ath/ath11k/debugfs_sta.c | 47 +++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/wmi.c         | 33 ++++++++++++-
>  drivers/net/wireless/ath/ath11k/wmi.h         | 10 ++++
>  4 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/debug.h
> b/drivers/net/wireless/ath/ath11k/debug.h
> index 805e30c07e14..1535af2eebe5 100644
> --- a/drivers/net/wireless/ath/ath11k/debug.h
> +++ b/drivers/net/wireless/ath/ath11k/debug.h
> @@ -12,6 +12,16 @@
>  #define ATH11K_TX_POWER_MAX_VAL	70
>  #define ATH11K_TX_POWER_MIN_VAL	0
> 
> +#define	ATH11K_XMIT_OMI_VHT		BIT(0)
> +#define	ATH11K_XMIT_OMI_HE		BIT(1)
> +#define	ATH11K_XMIT_OMI_RX_NSS		GENMASK(4, 2)
> +#define	ATH11K_XMIT_OMI_CHWIDTH		GENMASK(6, 5)
> +#define	ATH11K_XMIT_OMI_UL_UM_DIS	BIT(7)
> +#define	ATH11K_XMIT_OMI_TX_NSTS		GENMASK(10, 8)
> +#define	ATH11K_XMIT_OMI_ER_SU_DISABLE	BIT(11)
> +#define	ATH11K_XMIT_OMI_MIMO_RESOUND	BIT(12)
> +#define	ATH11K_XMIT_OMI_UL_MU_DATA_DIS	BIT(13)
> +
>  enum ath11k_debug_mask {
>  	ATH11K_DBG_AHB		= 0x00000001,
>  	ATH11K_DBG_WMI		= 0x00000002,
> diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
> b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
> index 3cdc34218a7d..61c40105bd2a 100644
> --- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
> @@ -526,6 +526,52 @@ static const struct file_operations 
> fops_peer_pktlog = {
>  	.llseek = default_llseek,
>  };
> 
> +static ssize_t ath11k_dbg_sta_write_xmit_omi(struct file *file,
> +					     const char __user *ubuf,
> +					     size_t count, loff_t *ppos)
> +{
> +	struct ieee80211_sta *sta = file->private_data;
> +	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
> +	u8 vht, he, rx_nss, chwidth, ul_mu_disable, tx_nsts, er_su_disable;
> +	u8 resound_recommendation, ul_mu_data_disable;
> +	u8 buf[64] = {0};
> +	u32 val;
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, 
> count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] = '\0';
> +	ret = sscanf(buf, "%hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu",
> +		     &vht, &he, &rx_nss, &chwidth, &ul_mu_disable, &tx_nsts,
> +		     &er_su_disable, &resound_recommendation,
> +		     &ul_mu_data_disable);
> +	if (ret != 9)
> +		return -EINVAL;
> +
> +	val = FIELD_PREP(ATH11K_XMIT_OMI_VHT, vht) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_HE, he) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_RX_NSS, rx_nss) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_CHWIDTH, chwidth) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_UL_UM_DIS, ul_mu_disable) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_TX_NSTS, tx_nsts) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_ER_SU_DISABLE, er_su_disable) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_MIMO_RESOUND, 
> resound_recommendation) |
> +	      FIELD_PREP(ATH11K_XMIT_OMI_UL_MU_DATA_DIS, ul_mu_data_disable);
> +
> +	ret = ath11k_wmi_set_peer_param(arsta->arvif->ar, sta->addr,
> +					arsta->arvif->vdev_id,
> +					WMI_PEER_PARAM_XMIT_OMI,
> +					val);
> +	return ret ? ret : count;
> +}
> +
> +static const struct file_operations fops_write_xmit_omi = {
> +	.write = ath11k_dbg_sta_write_xmit_omi,
> +	.open = simple_open
> +};
> +
>  void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct 
> ieee80211_vif *vif,
>  			    struct ieee80211_sta *sta, struct dentry *dir)
>  {
> @@ -543,4 +589,5 @@ void ath11k_sta_add_debugfs(struct ieee80211_hw
> *hw, struct ieee80211_vif *vif,
> 
>  	debugfs_create_file("peer_pktlog", 0644, dir, sta,
>  			    &fops_peer_pktlog);
> +	debugfs_create_file("xmit_omi", 0644, dir, sta, 
> &fops_write_xmit_omi);
>  }
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c
> b/drivers/net/wireless/ath/ath11k/wmi.c
> index ba08a7d95764..425fdd46e529 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -99,6 +99,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] 
> = {
>  		= { .min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
>  	[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT]
>  		= { .min_len = sizeof(struct wmi_twt_add_dialog_event) },
> +	[WMI_TAG_PEER_OPER_MODE_CHANGE_EVENT]
> +		= { .min_len = sizeof(struct wmi_peer_oper_mode_change_event) },
>  };
> 
>  #define PRIMAP(_hw_mode_) \
> @@ -5695,6 +5697,33 @@ static void
> ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab, struct sk_bu
>  	kfree(tb);
>  }
> 
> +static void ath11k_wmi_peer_oper_mode_change_event(struct ath11k_base
> *ab, struct sk_buff *skb)
> +{
> +	const void **tb;
> +	const struct wmi_peer_oper_mode_change_event *ev;
> +	int ret;
> +
> +	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_PEER_OPER_MODE_CHANGE_EVENT];
> +	if (!ev) {
> +		ath11k_warn(ab, "failed to fetch peer oper mode change ev");
> +		goto exit;
> +	}
> +
> +	ath11k_dbg(ab, ATH11K_DBG_WMI,
> +		   "OMI Change Event - ind: %ds, rxnss: %d, bw: %d, txnss: %d,
> disablemu: %d\n",
> +		   ev->ind_type, ev->new_rxnss, ev->new_bw, ev->new_txnss,
> ev->new_disablemu);
> +
> +exit:
> +	kfree(tb);
> +}
> +
>  static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct 
> sk_buff *skb)
>  {
>  	struct wmi_cmd_hdr *cmd_hdr;
> @@ -5775,10 +5804,12 @@ static void ath11k_wmi_tlv_op_rx(struct
> ath11k_base *ab, struct sk_buff *skb)
>  	case WMI_TWT_ADD_DIALOG_EVENTID:
>  		ath11k_wmi_twt_add_dialog_event(ab, skb);
>  		break;
> +	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
> +		ath11k_wmi_peer_oper_mode_change_event(ab, skb);
> +		break;
>  	/* add Unsupported events here */
>  	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
>  	case WMI_VDEV_DELETE_RESP_EVENTID:
> -	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
>  	case WMI_TWT_ENABLE_EVENTID:
>  	case WMI_TWT_DISABLE_EVENTID:
>  	case WMI_TWT_DEL_DIALOG_EVENTID:
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h
> b/drivers/net/wireless/ath/ath11k/wmi.h
> index 6e0be33bd37c..f8823766fc1c 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -2004,6 +2004,7 @@ enum {
>  #define WMI_PEER_SET_MAX_TX_RATE                        0x11
>  #define WMI_PEER_SET_MIN_TX_RATE                        0x12
>  #define WMI_PEER_SET_DEFAULT_ROUTING                    0x13
> +#define WMI_PEER_PARAM_XMIT_OMI				0x1c
> 
>  /* slot time long */
>  #define WMI_VDEV_SLOT_TIME_LONG         0x1
> @@ -4684,6 +4685,15 @@ struct wmi_obss_spatial_reuse_params_cmd {
>  	u32 vdev_id;
>  };
> 
> +struct wmi_peer_oper_mode_change_event {
> +	struct wmi_mac_addr peer_macaddr;
> +	u32 ind_type;
> +	u32 new_rxnss;
> +	u32 new_bw;
> +	u32 new_txnss;
> +	u32 new_disablemu;
> +};

Needs to be marked with __packed, I guess.

Vasanth
