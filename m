Return-Path: <linux-wireless+bounces-15142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACDE9C1C54
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 12:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E952850C2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DACC1E47A1;
	Fri,  8 Nov 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IgvGN62/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DA7B3E1;
	Fri,  8 Nov 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066188; cv=none; b=RCIdLvKs+K4SSYJzbHDRmff0g6fOAyWP/wsweursUtGij6Ymul1Qfsd24iXnPRRIwdRbXS49xPmt77giuzQRMftOiEUy9WbbZw1+/HJz99ZWbeS0l90IrHq4RjARh5LzoH2MGbdrAE2mtKwqwkGcNcc0ZDwxY1tVbtlnvWq6pXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066188; c=relaxed/simple;
	bh=zbYO/1NB/+gNBdZpKxIp2w8dCQN5Jsvjfv7ErVnPOn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7H+QHaNFOkgwiVEZPmwlD1zQl/EALZ2vX+WAVMvP7PpXJl/l59YHrpqwPsL/an9rNrqDlrWw6GDxM9z0uRYGcHGw8PZ1b6Ql1Cr3IRs2jhoHvjlxC0SUKIVmJvxtoaD8pu6RZBgpFdLgHiw9G4655drwRSnreL+8sxaEtOaqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IgvGN62/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FwTrzwv674lJ7/jefdJjg08FQjpqD2Ar32gnGbB5/0Q=;
	t=1731066186; x=1732275786; b=IgvGN62/nmox57rHEYPlvdWtLa+FcwCcFvTsFKnbEfas8U4
	hPTq/+S0PppXVspNmu6GOuFwaYgUZyAVrU4LRZzw5V9b0GkhQ23jZn44Jz59TUpoJ+tH8p7muMUXG
	4013DaqDhNxx1z7Se5Y2VtSWKuGowGQOtvhojc+xGOKT1U2pEHlbBgsE/VoJW3q8gt27ufna5g+Er
	oqpFK/qoUg8Ss8FtDGMK1cUnWaMExvOkwqTYq+ZPDx2EmgdzgJ2S33QYGAYa9HP2NVjNK3y8wkK+d
	ugSNkoBFh+9yhkCLmQHo1FY4/aFwFnoBOYSCmODH1M3ActQVfddkDTfxDvm5yzEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9NOG-0000000HEKm-1zD4;
	Fri, 08 Nov 2024 12:43:00 +0100
Message-ID: <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Subject: Re: [PATCH v5 09/17] wifi: cc33xx: Add main.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Nemanov <michael.nemanov@ti.com>, Kalle Valo <kvalo@kernel.org>,
  "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
Date: Fri, 08 Nov 2024 12:42:59 +0100
In-Reply-To: <20241107125209.1736277-10-michael.nemanov@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
	 <20241107125209.1736277-10-michael.nemanov@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

reading through this anyway looking for mac80211 integration, so I'll
nitpick too ... ;-)

> +#define CC33XX_FW_RX_PACKET_RAM (9 * 1024)
> +static int no_recovery     =3D -1;

that makes it look related?

> +static const u8 cc33xx_rate_to_idx_2ghz[] =3D {
> +	CONF_HW_RXTX_RATE_UNSUPPORTED,
> +	0,              /* RATE_INDEX_1MBPS */

for all of these arrays - use C99? sure it'll give the compiler a lot
more work, but it looks better and is less error-prone...

	[0] =3D UNSUPPORTED,
	[RATE_INDEX_1MBPS] =3D 0,
	...

> +/* can't be const, mac80211 writes to this */

Technically, I believe that's cfg80211.


> +	/* If we started out as wide, we can change the operation mode. If we
> +	 * thought this was a 20mhz AP, we have to reconnect

MHz

> +	if (wlvif->sta.role_chan_type !=3D NL80211_CHAN_HT40MINUS &&
> +	    wlvif->sta.role_chan_type !=3D NL80211_CHAN_HT40PLUS)
> +		ieee80211_connection_loss(cc33xx_wlvif_to_vif(wlvif));

You seem to support HE (PPE thresholds above and all that), but then you
still use CHAN_HT40MINUS/PLUS?! That seems ... rather wrong? You should
probably track in terms of NL80211_CHAN_WIDTH_*, I'm not even sure how
you get NL80211_CHAN_* values in the first place, mac80211 should never
use them now?

> +static void cc33xx_rc_update_work(struct work_struct *work)
> +{
> +	struct cc33xx_vif *wlvif =3D container_of(work, struct cc33xx_vif,
> +						rc_update_work);
> +	struct cc33xx *cc =3D wlvif->cc;
> +	struct ieee80211_vif *vif =3D cc33xx_wlvif_to_vif(wlvif);
> +
> +	mutex_lock(&cc->mutex);

Given the way the wiphy mutex now works, I'd strongly recommend not
having your own mutex any more - it's a huge simplification in a lot of
places, and there's very little downside since everything coming from
higher layers holds the wiphy mutex already (and almost certainly needs
to acquire your own mutex.)

> +static inline void cc33xx_tx_watchdog_work(struct work_struct *work)
> +{
> +	container_of(to_delayed_work(work), struct cc33xx, tx_watchdog_work);
> +}

I don't think that does what you think it does. Well, I don't know what
you think it does, but ...

Also there should be (almost) no inline in C files, and even if it were
correct you'd probably just use it exactly once?

> +#define CTRL_TYPE_BITS 4
> +static int get_type(struct control_info_descriptor *control_info_descrip=
tor)
> +{
> +	u16 type_mask =3D GENMASK(CTRL_TYPE_BITS - 1, 0);
> +
> +	return le16_to_cpu(control_info_descriptor->type_and_length) & type_mas=
k;

could use le16_get_bits()

> +static unsigned int get_length(struct control_info_descriptor *control_i=
nfo_descriptor)
> +{
> +	return le16_to_cpu(control_info_descriptor->type_and_length) >> CTRL_TY=
PE_BITS;
> +}

more interesting here

> +static int parse_control_message(struct cc33xx *cc,
> +				 const u8 *buffer, size_t buffer_length)
> +{
> +	u8 *const end_of_payload =3D (u8 *const)buffer + buffer_length;
> +	u8 *const start_of_payload =3D (u8 *const)buffer;

I don't think the "u8 *const" is useful here, and the cast is awkward.
If anything you'd want "const u8 *const" (which should make it not need
the cast), but the const you have adds no value... do you even know what
it means? ;-)

> +	struct NAB_header *nab_header;

surely checkpatch complained about CamelCase or so with the struct name
like that?

> +/* caller must not hold cc->mutex, as it might deadlock */

Exactly the type of problem you don't even have to think about if you
only use the wiphy mutex/wiphy work.

> +static void cc33xx_recovery_work(struct work_struct *work)
> +{
> +	struct cc33xx *cc =3D container_of(work, struct cc33xx, recovery_work);
> +	struct cc33xx_vif *wlvif;
> +	struct ieee80211_vif *vif;
> +
> +	cc33xx_notice("CC33xx driver attempting recovery");
> +
> +	if (cc->conf.core.no_recovery) {
> +		cc33xx_info("Recovery disabled by configuration, driver will not resta=
rt.");
> +		return;
> +	}
> +
> +	if (test_bit(CC33XX_FLAG_DRIVER_REMOVED, &cc->flags)) {
> +		cc33xx_info("Driver being removed, recovery disabled");
> +		return;
> +	}
> +
> +	cc->state =3D CC33XX_STATE_RESTARTING;
> +	set_bit(CC33XX_FLAG_RECOVERY_IN_PROGRESS, &cc->flags);
> +
> +	mutex_lock(&cc->mutex);
> +	while (!list_empty(&cc->wlvif_list)) {
> +		wlvif =3D list_first_entry(&cc->wlvif_list,
> +					 struct cc33xx_vif, list);
> +		vif =3D cc33xx_wlvif_to_vif(wlvif);
> +
> +		if (test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags))
> +			ieee80211_connection_loss(vif);
> +
> +		__cc33xx_op_remove_interface(cc, vif, false);
> +	}
> +	mutex_unlock(&cc->mutex);
> +
> +	cc33xx_turn_off(cc);
> +	msleep(500);
> +
> +	mutex_lock(&cc->mutex);
> +	cc33xx_init_fw(cc);
> +	mutex_unlock(&cc->mutex);
> +
> +	ieee80211_restart_hw(cc->hw);
> +
> +	mutex_lock(&cc->mutex);
> +	clear_bit(CC33XX_FLAG_RECOVERY_IN_PROGRESS, &cc->flags);
> +	mutex_unlock(&cc->mutex);

even more so with the awful locking/unlocking/... here (also no need to
unlock to call restart_hw, I think?)

and using both a mutex and atomic ops seems ... odd?


> +	/* PLT init: Role enable + Role start + plt Init  */
> +	int ret =3D 0;
> +
> +	/* Role enable */
> +	u8  returned_role_id =3D CC33XX_INVALID_ROLE_ID;


extra whitespace

> +	u8 bcast_addr[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

should probably be static const

> +	if (ret >=3D 0) {
> +		cc33xx_info("PLT init Role Start succeed!, PLT roleID is: %u ",
> +			    returned_role_id);
> +	} else {
> +		cc33xx_info("PLT init Role Start FAILED! , PLT roleID is: %u ",
> +			    returned_role_id);
> +	}

no need for braces

> +static void cc33xx_op_tx(struct ieee80211_hw *hw,
> +			 struct ieee80211_tx_control *control,
> +			 struct sk_buff *skb)
> +{
> +	struct cc33xx *cc =3D hw->priv;
> +	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +	struct ieee80211_vif *vif =3D info->control.vif;
> +	struct cc33xx_vif *wlvif =3D NULL;
> +	enum cc33xx_queue_stop_reason stop_reason =3D CC33XX_QUEUE_STOP_REASON_=
WATERMARK;
> +	unsigned long flags;
> +	int q, mapping;
> +	u8 hlid;
> +
> +	if (!vif) {
> +		ieee80211_free_txskb(hw, skb);
> +		return;
> +	}
> +
> +	wlvif =3D cc33xx_vif_to_data(vif);
> +	mapping =3D skb_get_queue_mapping(skb);
> +	q =3D cc33xx_tx_get_queue(mapping);
> +
> +	hlid =3D cc33xx_tx_get_hlid(cc, wlvif, skb, control->sta);
> +
> +	spin_lock_irqsave(&cc->cc_lock, flags);
> +
> +	/* drop the packet if the link is invalid or the queue is stopped
> +	 * for any reason but watermark. Watermark is a "soft"-stop so we
> +	 * allow these packets through.
> +	 */
> +
> +	if (hlid =3D=3D CC33XX_INVALID_LINK_ID ||
> +	    (!test_bit(hlid, wlvif->links_map)) ||
> +	    (cc33xx_is_queue_stopped_locked(cc, wlvif, q) &&
> +	    !cc33xx_is_queue_stopped_by_reason_locked(cc, wlvif, q,
> +						      stop_reason))) {
> +		cc33xx_debug(DEBUG_TX, "DROP skb hlid %d q %d ", hlid, q);
> +		ieee80211_free_txskb(hw, skb);
> +		goto out;
> +	}

I'd consider converting to itxq APIs, you already use them anyway via
ieee80211_handle_wake_tx_queue so you don't gain anything from not doing
it, but you gain a lot of flexibility from doing it and don't have to do
things like this?

It's not _that_ hard.

> +/* Allocates an RX filter returned through f
> + * which needs to be freed using rx_filter_free()
> + */
> +static int
> +cc33xx_convert_wowlan_pattern_to_rx_filter(struct cfg80211_pkt_pattern *=
p,
> +					   struct cc33xx_rx_filter **f)

use ERR_PTR() etc instead of **f?

> +static void cc33xx_configure_resume(struct cc33xx *cc, struct cc33xx_vif=
 *wlvif)
> +{
> +	int ret =3D 0;
> +	bool is_ap =3D wlvif->bss_type =3D=3D BSS_TYPE_AP_BSS;
> +	bool is_sta =3D wlvif->bss_type =3D=3D BSS_TYPE_STA_BSS;
> +	struct cc33xx_core_conf *core_conf =3D &cc->conf.core;
> +
> +	if (!is_ap && !is_sta)
> +		return;
> +
> +	if ((is_sta && !test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags)) ||
> +	    (is_ap && !test_bit(WLVIF_FLAG_AP_STARTED, &wlvif->flags)))
> +		return;
> +
> +	cc33xx_configure_wowlan(cc, NULL);
> +
> +	if (is_sta) {
> +		if (core_conf->suspend_wake_up_event =3D=3D core_conf->wake_up_event &=
&
> +		    core_conf->suspend_listen_interval =3D=3D core_conf->listen_interv=
al)
> +			return;
> +
> +		ret =3D cc33xx_acx_wake_up_conditions(cc, wlvif,
> +						    core_conf->wake_up_event,
> +						    core_conf->listen_interval);
> +
> +		if (ret < 0)
> +			cc33xx_error("resume: wake up conditions failed: %d",
> +				     ret);
> +
> +	} else if (is_ap) {
> +		ret =3D cc33xx_acx_beacon_filter_opt(cc, wlvif, false);

That never uses that ret assignment here, will almost certainly cause
compiler warnings later

> +static inline void cc33xx_op_stop(struct ieee80211_hw *hw, bool suspend)=
 {}

inline again

> +	switch (wlvif->bss_type) {
> +	case BSS_TYPE_AP_BSS:
> +		if (wlvif->p2p)
> +			return CC33XX_ROLE_P2P_GO;
> +		else if (ieee80211_vif_is_mesh(vif))
> +			return CC33XX_ROLE_MESH_POINT;
> +		else
> +			return CC33XX_ROLE_AP;

no need for else, that also makes it clearer that there's no need for
break/fallthrough

(and checkpatch didn't notice??)

> +	/* mac80211 configures some values globally, while we treat them
> +	 * per-interface. thus, on init, we have to copy them from cc
> +	 */
> +	wlvif->band =3D cc->band;

I don't know what you do (yet, at this point of the patch), but mac80211
certainly does not configure a band globally unless you specifically
wanted it to...

> +	wlvif->power_level =3D cc->power_level;
> +
> +	INIT_WORK(&wlvif->rc_update_work, cc33xx_rc_update_work);
> +	INIT_DELAYED_WORK(&wlvif->channel_switch_work,
> +			  cc33xx_channel_switch_work);

This might be problematic if you get here via HW restart and the work
might be pending/running? There's a check before, but I'm not sure how
you'd get to remove_interface in restart first?

Also seems like a lot of races there (that comment about "some very
corner case" ...) - again something avoided by relying more on wiphy
mutex.

> +static int cc33xx_allocate_hw_queue_base(struct cc33xx *cc,
> +					 struct cc33xx_vif *wlvif)
> +{
> +	struct ieee80211_vif *vif =3D cc33xx_wlvif_to_vif(wlvif);
> +	struct cc33xx_hw_queue_iter_data iter_data =3D {};
> +	int i, q_base;
> +
> +	if (vif->type =3D=3D NL80211_IFTYPE_P2P_DEVICE) {
> +		vif->cab_queue =3D IEEE80211_INVAL_HW_QUEUE;
> +		return 0;
> +	}
> +
> +	iter_data.vif =3D vif;
> +
> +	/* mark all bits taken by active interfaces */
> +	ieee80211_iterate_active_interfaces_atomic(cc->hw,
> +						   IEEE80211_IFACE_ITER_RESUME_ALL,
> +					cc33xx_hw_queue_iter, &iter_data);

probably don't need atomic in this context

> +	/* Last AP, have more stations. Configure sleep auth according to STA.
> +	 * Don't do thin on unintended recovery.

typo

> +unlock:
> +	mutex_unlock(&cc->mutex);
> +
> +	cancel_work_sync(&wlvif->rc_update_work);
> +	cancel_delayed_work_sync(&wlvif->connection_loss_work);
> +	cancel_delayed_work_sync(&wlvif->channel_switch_work);
> +	cancel_delayed_work_sync(&wlvif->pending_auth_complete_work);
> +	cancel_delayed_work_sync(&wlvif->roc_timeout_work);
> +
> +	mutex_lock(&cc->mutex);

also this kind of thing ... just use wiphy mutex/work

> +	if (sta_rate_set) {
> +		wlvif->rate_set =3D cc33xx_tx_enabled_rates_get(cc, sta_rate_set,
> +							      wlvif->band);
> +	}

you have a thing for extra braces ;-)
(also in many other places)


> +static int cc33xx_op_config(struct ieee80211_hw *hw, u32 changed)
> +{
> +	struct cc33xx *cc =3D hw->priv;

Yeah, ok, now I see why you have issues with band setting and whatnot.
You probably should not implement this op in a multi-role capable device
with anything other than "return 0"? We should probably change mac80211
to not require it.

> +	/* configure each interface */
> +	cc33xx_for_each_wlvif(cc, wlvif) {
> +		ret =3D cc33xx_config_vif(cc, wlvif, conf, changed);
> +		if (ret < 0)
> +			goto out;
> +	}

that kind of thing is just awful ... use channel contexts etc. instead?
What part does it need to still do through here that's for each *vif*?

> +static int cc33xx_init_ieee80211(struct cc33xx *cc)
> +{
> +	unsigned int i;
> +
> +	if (cc->conf.core.mixed_mode_support) {
> +		static const u32 cipher_suites[] =3D {
> +			WLAN_CIPHER_SUITE_CCMP,
> +			WLAN_CIPHER_SUITE_AES_CMAC,
> +			WLAN_CIPHER_SUITE_TKIP,
> +			WLAN_CIPHER_SUITE_GCMP,
> +			WLAN_CIPHER_SUITE_GCMP_256,
> +			WLAN_CIPHER_SUITE_BIP_GMAC_128,
> +			WLAN_CIPHER_SUITE_BIP_GMAC_256,
> +		};
> +		cc->hw->wiphy->cipher_suites =3D cipher_suites;
> +		cc->hw->wiphy->n_cipher_suites =3D ARRAY_SIZE(cipher_suites);
> +
> +	} else {
> +		static const u32 cipher_suites[] =3D {
> +			WLAN_CIPHER_SUITE_CCMP,
> +			WLAN_CIPHER_SUITE_AES_CMAC,
> +			WLAN_CIPHER_SUITE_GCMP,
> +			WLAN_CIPHER_SUITE_GCMP_256,
> +			WLAN_CIPHER_SUITE_BIP_GMAC_128,
> +			WLAN_CIPHER_SUITE_BIP_GMAC_256,
> +		};

I don't see you have GEM here, yet you handle it in other places above,
that seems odd. Also I'm not sure it can work at all now that we removed
the whole extended IV mess, unless you offloaded that?

> +	/* clear channel flags from the previous usage
> +	 * and restore max_power & max_antenna_gain values.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(cc33xx_channels); i++) {
> +		cc33xx_band_2ghz.channels[i].flags =3D 0;
> +		cc33xx_band_2ghz.channels[i].max_power =3D CC33XX_MAX_TXPWR;
> +		cc33xx_band_2ghz.channels[i].max_antenna_gain =3D 0;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(cc33xx_channels_5ghz); i++) {
> +		cc33xx_band_5ghz.channels[i].flags =3D 0;
> +		cc33xx_band_5ghz.channels[i].max_power =3D CC33XX_MAX_TXPWR;
> +		cc33xx_band_5ghz.channels[i].max_antenna_gain =3D 0;
> +	}
> +
> +	/* Enable/Disable He based on conf file params */
> +	if (!cc->conf.mac.he_enable) {
> +		cc33xx_band_2ghz.iftype_data =3D NULL;
> +		cc33xx_band_2ghz.n_iftype_data =3D 0;
> +
> +		cc33xx_band_5ghz.iftype_data =3D NULL;
> +		cc33xx_band_5ghz.n_iftype_data =3D 0;
> +	}

it seems wrong to modify the global data here

> +	/* We keep local copies of the band structs because we need to
> +	 * modify them on a per-device basis.
> +	 */
> +	memcpy(&cc->bands[NL80211_BAND_2GHZ], &cc33xx_band_2ghz,
> +	       sizeof(cc33xx_band_2ghz));
> +	memcpy(&cc->bands[NL80211_BAND_2GHZ].ht_cap,
> +	       &cc->ht_cap[NL80211_BAND_2GHZ],
> +	       sizeof(*cc->ht_cap));

and in particular if you *then* do that??

> +#define create_high_prio_freezable_workqueue(name)			\
> +	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
> +			WQ_MEM_RECLAIM | WQ_HIGHPRI, 1, (name))

not much value in this macro, you're hopefully not going to do many of
these?

johannes

