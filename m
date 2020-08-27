Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7BA254584
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH0M6Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgH0MmP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:42:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A1C061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:42:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBHEH-00Bais-FO; Thu, 27 Aug 2020 14:42:09 +0200
Message-ID: <ba50a77e7503b226cf01a3d71a87bc968e695eac.camel@sipsolutions.net>
Subject: Re: [PATCH v3 01/13] mac80211: rework tx encapsulation offload API
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Thu, 27 Aug 2020 14:42:07 +0200
In-Reply-To: <20200821084926.10650-2-nbd@nbd.name>
References: <20200821084926.10650-1-nbd@nbd.name>
         <20200821084926.10650-2-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


I was going to not worry about it, but now that I'm replying anyway ...

> +++ b/net/mac80211/iface.c
> @@ -43,6 +43,7 @@
>   */
>  
>  static void ieee80211_iface_work(struct work_struct *work);
> +static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata);

Do we really need that, can can't reorder things?

> +static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
> +{
> +	switch (iftype) {
> +	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_P2P_GO:
> +	case NL80211_IFTYPE_P2P_CLIENT:

The P2P ones cannot happen here due to the iftype munging that mac80211
does, suggest you add a comment about that and remove them.

> +		list_for_each_entry(key, &sdata->key_list, list) {
> +			if (key->conf.cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
> +			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
> +			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
> +			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
> +				continue;

I had to read that a few times to understand it ... maybe add a comment
that the management frame keys aren't relevant? :)


But anyway, what I was really not sure about is this function:

> +static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_sub_if_data *bss = sdata;
> +	struct ieee80211_key *key;
> +	bool enabled;
> +
> +	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
> +		if (!sdata->bss)
> +			return;
> +
> +		bss = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
> +	}
> +
> +	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
> +	    !ieee80211_iftype_supports_encap_offload(bss->vif.type))
> +		return;

There are a lot of returns here, some of which make sense, but the
sdata->bss one seems dynamic and doesn't really make sense? Could it
change?

Or maybe we don't care because if it's not linked to a BSS it cannot be
transmitting?

johannes

