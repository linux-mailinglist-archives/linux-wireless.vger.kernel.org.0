Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29373206F91
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbgFXJBH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388864AbgFXJBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:01:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7070C061573
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2020 02:01:07 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jo1HE-00BFXD-1e; Wed, 24 Jun 2020 11:01:04 +0200
Message-ID: <11b8d5a5631cc472fce17638ff9e1dfef8750628.camel@sipsolutions.net>
Subject: Re: [PATCH v7 06/17] wilc1000: add cfg80211.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, Venkateswara.Kaja@microchip.com
Date:   Wed, 24 Jun 2020 11:00:52 +0200
In-Reply-To: <20200623110000.31559-7-ajay.kathat@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
         <20200623110000.31559-7-ajay.kathat@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-06-23 at 11:00 +0000, Ajay.Kathat@microchip.com wrote:
> 
> +struct wilc_p2p_pub_act_frame {
> +	u8 category;
> +	u8 action;
> +	u8 oui[3];
> +	u8 oui_type;
> +	u8 oui_subtype;
> +	u8 dialog_token;
> +	u8 elem[];
> +} __packed;
> +
> +struct wilc_vendor_specific_ie {
> +	u8 tag_number;
> +	u8 tag_len;
> +	u8 oui[3];
> +	u8 oui_type;
> +	u8 attr[];
> +} __packed;
> +
> +struct wilc_attr_entry {
> +	u8  attr_type;
> +	__le16 attr_len;
> +	u8 val[];
> +} __packed;
> +
> +struct wilc_attr_oper_ch {
> +	u8 attr_type;
> +	__le16 attr_len;
> +	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
> +	u8 op_class;
> +	u8 op_channel;
> +} __packed;
> +
> +struct wilc_attr_ch_list {
> +	u8 attr_type;
> +	__le16 attr_len;
> +	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
> +	u8 elem[];
> +} __packed;
> +
> +struct wilc_ch_list_elem {
> +	u8 op_class;
> +	u8 no_of_channels;
> +	u8 ch_list[];
> +} __packed;

It seems like these should be used from ieee80211.h, and/or added there
if they don't already exist?

> +static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
> +				      struct key_params *params)
> +{
> +	kfree(key_info->key);
> +
> +	key_info->key = kmemdup(params->key, params->key_len, GFP_KERNEL);
> +	if (!key_info->key)
> +		return -ENOMEM;
> +
> +	kfree(key_info->seq);
> +
> +	if (params->seq_len > 0) {
> +		key_info->seq = kmemdup(params->seq, params->seq_len,
> +					GFP_KERNEL);
> +		if (!key_info->seq)
> +			return -ENOMEM;

you may leak key_info->key here?

> +static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf, u32 len, u8 sta_ch)

That's a bit big to be forced inline, imho. if it's used only once the
compiler will inline it anyway.

> +	d = (struct wilc_p2p_pub_act_frame *)(&mgmt->u.action);
> +	if (d->oui_subtype != GO_NEG_REQ && d->oui_subtype != GO_NEG_RSP &&
> +	    d->oui_subtype != P2P_INV_REQ && d->oui_subtype != P2P_INV_RSP)
> +		goto out_rx_mgmt;
> +
> +	vendor_ie = cfg80211_find_vendor_ie(WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P,
> +					    buff + ie_offset, size - ie_offset);
> +	if (!vendor_ie)
> +		goto out_rx_mgmt;
> +
> +	p = (struct wilc_vendor_specific_ie *)vendor_ie;
> +	wilc_wfi_cfg_parse_ch_attr(p->attr, p->tag_len - 4, vif->wilc->sta_ch);

but overall, why do you even need this? I don't think this is normally
handled in the driver, but wpa_s?


Anyway, I'm not convinced that we should really keep kicking this back
over minor issues like this ... better to merge it and fix later, imho.

johannes


