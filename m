Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C71E45D2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbgE0O1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbgE0O1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:27:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E5C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:27:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdx1y-0049fO-6z; Wed, 27 May 2020 16:27:42 +0200
Message-ID: <4e3a5ab6eed1dc91f45a459bb616fa05a110483d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 03/11] nl80211: add HE 6 GHz Band Capability support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 16:27:40 +0200
In-Reply-To: <1589399105-25472-3-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-3-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 12:44 -0700, Rajkumar Manoharan wrote:
>  
>  /**
> + * enum ieee80211_he_6ghz_chanwidth - HE 6 GHz channel width
> + * @IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ: 20 MHz bandwidth
> + * @IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ: 40 MHz bandwidth
> + * @IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ: 80 MHz bandwidth
> + * @IEEE80211_HE_6GHZ_CHANWIDTH_80P80MHZ: 160 or 80+80 MHz bandwidth
> + */
> +enum ieee80211_he_6ghz_chanwidth {
> +	IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ		= 0,
> +	IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ		= 1,
> +	IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ		= 2,
> +	IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ	= 3,
> +};
> +
> +/**
> + * struct ieee80211_he_oper_6ghz_op_info - 6 GHz Operation Information
> + *
> + * This structure is defined as described in IEEE P802.11ax/D6.0,
> + * Figure 9-787k—6 GHz Operation Information field.
> + *
> + * @primary_chan: The channel number of the primary channel in the 6 GHz band.
> + * @control: First two bits defines channel width field indicates the BSS
> + *	channel width and is set to 0 for 20 MHz, 1 for 40 MHz, 2 for 80 MHz,
> + *	and 3 for 80+80 or 160 MHz.
> + * @center_freq_seg0_idx: Channel center frequency index for the 20 MHz,
> + *	40 MHz, or 80 MHz, or 80+80 MHz.
> + * @center_freq_seg1_idx: Channel center frequency index of the 160 MHz.
> + * @min_rate: Minimum rate, in units of 1 Mb/s, that the non-AP STA is allowed
> + *	to use for sending PPDUs.
> + */
> +struct ieee80211_he_oper_6ghz_op_info {
> +	u8 primary_chan;
> +	u8 control;
> +	u8 center_freq_seg0_idx;
> +	u8 center_freq_seg1_idx;
> +	u8 min_rate;
> +} __packed;
> 

Looks like I had

+/**
+ * ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
+ * @primary: primary channel
+ * @control: control flags
+ * @ccfs0: channel center frequency segment 0
+ * @ccfs1: channel center frequency segment 1
+ * @minrate: minimum rate (in 1 Mbps units)
+ */
+struct ieee80211_he_6ghz_oper {
+       u8 primary;
+#define IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH  0x3
+#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ     0
+#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ     1
+#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ     2
+#define                IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ    3
+#define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON 0x4
+       u8 control;
+       u8 ccfs0;
+       u8 ccfs1;
+       u8 minrate;
+} __packed;


Any objection to that? The names are getting _really_ long the way you
had them ...

FWIW, I also had a fix in ieee80211_he_oper_size() where the size of the
oper is now sizeof(struct ieee80211_he_6ghz_oper).

And this, to find it:

+/**
+ * ieee80211_he_6ghz_oper - obtain 6 GHz operation field
+ * @he_oper: HE operation element (must be pre-validated for size)
+ *     but may be %NULL
+ *
+ * Return: a pointer to the 6 GHz operation field, or %NULL
+ */
+static inline const struct ieee80211_he_6ghz_oper *
+ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
+{
+       const u8 *ret = (void *)&he_oper->optional;
+       u32 he_oper_params;
+
+       if (!he_oper)
+               return NULL;
+
+       he_oper_params = le32_to_cpu(he_oper->he_oper_params);
+
+       if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
+               return NULL;
+       if (he_oper_params & IEEE80211_HE_OPERATION_VHT_OPER_INFO)
+               ret += 3;
+       if (he_oper_params & IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
+               ret++;
+
+       return (void *)ret;
+}
+


>  #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
>  #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
> @@ -1982,6 +2029,15 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
>  #define IEEE80211_TX_RX_MCS_NSS_SUPP_TX_BITMAP_MASK			0x07c0
>  #define IEEE80211_TX_RX_MCS_NSS_SUPP_RX_BITMAP_MASK			0xf800
>  
> +/* 802.11ax HE 6 GHz Band Capability */
> +#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START_SPACE_MASK		GENMASK(2, 0)
> +#define IEEE80211_HE_6GHZ_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK	GENMASK(5, 3)
> +#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LENGTH_MASK		GENMASK(7, 6)
> +#define IEEE80211_HE_6GHZ_CAP_SMPS_MASK				GENMASK(10, 9)
> +#define IEEE80211_HE_6GHZ_CAP_RD_RESP				BIT(11)
> +#define IEEE80211_HE_6GHZ_CAP_RX_ANTENNA_PATTERN		BIT(12)
> +#define IEEE80211_HE_6GHZ_CAP_TX_ANTENNA_PATTERN		BIT(13)

I don't like GENMASK() much ... but ok. FWIW, I had

+struct ieee80211_he_6ghz_capa {
+       /* uses IEEE80211_HE_6GHZ_CAP_* below */
+       __le16 capa;
+} __packed;
+
+/* HE 6 GHz band capabilities */
+/* uses enum ieee80211_min_mpdu_spacing values */
+#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START   0x0007
+/* uses enum ieee80211_vht_max_ampdu_length_exp values */
+#define IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP        0x0038
+/* uses IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_* values */
+#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN     0x00c0
+/* WLAN_HT_CAP_SM_PS_* values */
+#define IEEE80211_HE_6GHZ_CAP_SM_PS_SHIFT       9
+#define IEEE80211_HE_6GHZ_CAP_SM_PS            0x0600
+#define IEEE80211_HE_6GHZ_CAP_RD_RESPONDER     0x0800
+#define IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS   0x1000
+#define IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS   0x2000


again, just shorter names ...


johannes

