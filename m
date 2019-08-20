Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108F596AD9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfHTUqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:46:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43796 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:46:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0B1b-0008Pt-4r; Tue, 20 Aug 2019 22:46:39 +0200
Message-ID: <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
Subject: Re: [PATCH 31/49] ath11k: add mac.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:46:37 +0200
In-Reply-To: <1566316095-27507-32-git-send-email-kvalo@codeaurora.org> (sfid-20190820_181539_894705_E3B317D0)
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
         <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
         (sfid-20190820_181539_894705_E3B317D0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:

> +static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
> +{
> +	struct ath11k *ar = hw->priv;
> +	int ret = 0;
> +
> +	/* mac80211 requires this op to be present and that's why
> +	 * there's an empty function, this can be extended when
> +	 * required.
> +	 */

Well, oops. Maybe it shouldn't be required?

> +	mutex_lock(&ar->conf_mutex);
> +
> +	/* TODO: Handle configuration changes as appropriate */
> +
> +	mutex_unlock(&ar->conf_mutex);

It's not actually empty though - why bother locking the mutex for
nothing?

> +	if (sta->mfp) {
> +		/* TODO: Need to check if FW supports PMF? */

Probably not? shouldn't get a sta with MFP unless you advertised support
for it. At least I'd think so, and consider it a mac80211 bug if you
still did.

> +	/* This is a workaround for HT-enabled STAs which break the spec
> +	 * and have no HT capabilities RX mask (no HT RX MCS map).
> +	 *
> +	 * As per spec, in section 20.3.5 Modulation and coding scheme (MCS),
> +	 * MCS 0 through 7 are mandatory in 20MHz with 800 ns GI at all STAs.

Wouldn't that better be in mac80211?

> +	ampdu_factor = (vht_cap->cap &
> +			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
> +		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;

consider u32_get_bits() or something like that from bitfield.h

> +	/* Workaround: Some Netgear/Linksys 11ac APs set Rx A-MPDU factor to
> +	 * zero in VHT IE. Using it would result in degraded throughput.
> +	 * arg->peer_max_mpdu at this point contains HT max_mpdu so keep
> +	 * it if VHT max_mpdu is smaller.
> +	 */
> +	arg->peer_max_mpdu = max(arg->peer_max_mpdu,
> +				 (1U << (IEEE80211_HT_MAX_AMPDU_FACTOR +
> +					ampdu_factor)) - 1);

Wait, that seems familiar. Again, put it into mac80211?

> +static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
> +				     struct peer_assoc_params *arg)
> +{
> +	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
> +	int smps;
> +
> +	if (!ht_cap->ht_supported)
> +		return;
> +
> +	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
> +	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;

also here, u*_get_bits() or something might be nicer

(and yes, I've written tons of code like this myself before that
existed, which is why I'm pointing it out - it's much nicer)

> +void ath11k_mac_drain_tx(struct ath11k *ar)
> +{
> +	/* make sure rcu-protected mac80211 tx path itself is drained */
> +	synchronize_net();

Doesn't mac80211 ensure that in the relevant places like flush()? But
then again, not sure where you call this.

> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac set fixed rate params vdev %i rate 0x%02hhx nss %hhu sgi %hhu\n",
> +		   arvif->vdev_id, rate, nss, sgi);

nit: that could use a line-break

> +	vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
> +	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +					    vdev_param, rate);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
> 
> +	/* TODO: Check if HT capability advertised from firmware is different
> +	 * for each band for a dual band capable radio. It will be tricky to
> +	 * handle it when the ht capability different for each band.
> +	 */

For each band shouldn't really be that tricky?

johannes

