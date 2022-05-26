Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70008535419
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 21:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbiEZTtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiEZTtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 15:49:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6D7092F
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=D+XPuqufi7YUfEXLixwGRwC75l4JcbhfcN/4Gg3q1GE=;
        t=1653594560; x=1654804160; b=c4YD0xs91HaVe9bIStw3C6rrUA28JmqKWHkvPNUxEKAtHrJ
        +nukXWq7dtXs4AeqsXeLeb0v1kYm69O4DsIvVunEWqpfp4vxnEjSi2mShVqJRdrkhe8hv894q9Hpg
        hJXMKIubzEzC7u/d+18wCUAkpdvXCsWaWZ18THgJGeH0lXXehSpOin3dUe2YtagNQ4Y0op1/cFVyH
        5J6boVI8BjIjtqDn4LCzGYkGGA/O69lr/yPqvv3y/JKT4oGERfLXcrakorP8smFM7q14BRIN44ENC
        t6an1JrBIkPEIWmiGpkmTquPOGMxes3AAJ7WzR4lCdlfW6Ky2tfsUDYknj8ZSSgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuJTx-005G2e-W8;
        Thu, 26 May 2022 21:49:18 +0200
Message-ID: <200a74dbed0ec37b4d374d963bcd0961a249b0ed.camel@sipsolutions.net>
Subject: Re: [RFC v2 38/96] cl8k: add mac80211.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 21:49:17 +0200
In-Reply-To: <20220524113502.1094459-39-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-39-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-24 at 14:34 +0300, viktor.barna@celeno.com wrote:
>=20
> +static void cl_ops_tx_single(struct cl_hw *cl_hw,
> +			     struct sk_buff *skb,
> +			     struct ieee80211_tx_info *tx_info,
> +			     struct cl_sta *cl_sta,
> +			     struct ieee80211_sta *sta)
> +{

...

> +	if (sta) {
> +		u32 sta_vht_cap =3D sta->vht_cap.cap;
> +		struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)skb->data;
> +
> +		if (!(sta_vht_cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK))
> +			goto out_tx;
> +
> +		if (ieee80211_is_assoc_resp(mgmt->frame_control)) {
> +			int len =3D skb->len - (mgmt->u.assoc_resp.variable - skb->data);
> +			const u8 *vht_cap_addr =3D cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY,
> +								 mgmt->u.assoc_resp.variable,
> +								 len);
> +
> +			if (vht_cap_addr) {
> +				struct ieee80211_vht_cap *vht_cap =3D
> +					(struct ieee80211_vht_cap *)(2 + vht_cap_addr);
> +
> +				vht_cap->vht_cap_info &=3D
> +					~(cpu_to_le32(IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK |
> +						      IEEE80211_VHT_CAP_SHORT_GI_160));
> +			}

Huh??


> +int cl_ops_config(struct ieee80211_hw *hw, u32 changed)
> +{
> +	/*
> +	 * Handler for configuration requests. IEEE 802.11 code calls this
> +	 * function to change hardware configuration, e.g., channel.
> +	 * This function should never fail but returns a negative error code
> +	 * if it does. The callback can sleep
> +	 */
> +	int error =3D 0;
> +
> +	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
> +		error =3D cl_ops_conf_change_channel(hw);

I'm really surprised to see this callback in a modern driver - wouldn't
you want to support some form of multi-channel operation? Even just
using the chanctx callbacks might make some of the DFS things you have
there easier?


>=20
> +void cl_ops_bss_info_changed(struct ieee80211_hw *hw,
> +			     struct ieee80211_vif *vif,
> +			     struct ieee80211_bss_conf *info,
> +			     u32 changed)
> +{

...

> +		if (beacon) {
> +			size_t ies_len =3D beacon->tail_len;
> +			const u8 *ies =3D beacon->tail;
> +			const u8 *cap =3D  NULL;
> +			int var_offset =3D offsetof(struct ieee80211_mgmt, u.beacon.variable)=
;
> +			int len =3D beacon->head_len - var_offset;
> +			const u8 *var_pos =3D beacon->head + var_offset;
> +			const u8 *rate_ie =3D NULL;
> +
> +			cl_vif->wmm_enabled =3D cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
> +								      WLAN_OUI_TYPE_MICROSOFT_WMM,
> +								      ies,
> +								      ies_len);
> +			cl_dbg_info(cl_hw, "vif=3D%d wmm_enabled=3D%d\n",
> +				    cl_vif->vif_index,
> +				    cl_vif->wmm_enabled);
> +
> +			cap =3D cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies, ies_len);
> +			if (cap && cap[1] >=3D sizeof(*ht_cap)) {
> +				ht_cap =3D (void *)(cap + 2);
> +				sgi_en |=3D (le16_to_cpu(ht_cap->cap_info) &
> +					   IEEE80211_HT_CAP_SGI_20) ||
> +					  (le16_to_cpu(ht_cap->cap_info) &
> +					   IEEE80211_HT_CAP_SGI_40);
> +			}
> +
> +			cap =3D cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
> +			if (cap && cap[1] >=3D sizeof(*vht_cap)) {
> +				vht_cap =3D (void *)(cap + 2);
> +				sgi_en |=3D (le32_to_cpu(vht_cap->vht_cap_info) &
> +					   IEEE80211_VHT_CAP_SHORT_GI_80) ||
> +					  (le32_to_cpu(vht_cap->vht_cap_info) &
> +					   IEEE80211_VHT_CAP_SHORT_GI_160);
> +			}
> +
> +			cap =3D cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len=
);
> +			if (cap && cap[1] >=3D sizeof(*he_cap) + 1)
> +				he_cap =3D (void *)(cap + 3);
> +
> +			rate_ie =3D cfg80211_find_ie(WLAN_EID_SUPP_RATES, var_pos, len);
> +			if (rate_ie) {
> +				if (cl_band_is_24g(cl_hw))
> +					if (cl_is_valid_g_rates(rate_ie))
> +						hw_mode =3D cl_hw->conf->ci_cck_in_hw_mode ?
> +							     HW_MODE_BG : HW_MODE_G;
> +					else
> +						hw_mode =3D HW_MODE_B;
> +				else
> +					hw_mode =3D HW_MODE_A;
> +			}
> +		} else {
> +			cl_dbg_warn(cl_hw, "beacon_data not set!\n");
> +		}
> +

This feels ... odd. You really shouldn't have to look into the beacon to
figure out these things?

And SGI etc. are per-STA rate control parameters anyway? Hmm.

> +/* This function is required for PS flow - do not remove */
> +int cl_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, b=
ool set)
> +{
> +	return 0;
> +}

You have all this hardware/firmware and you implement this? Interesting
design choice. One that I'm sure you'll revisit for WiFi 7 ;-)

johannes
