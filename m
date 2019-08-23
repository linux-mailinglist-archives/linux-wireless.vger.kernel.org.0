Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED69AEE8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbfHWMPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 08:15:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41298 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391421AbfHWMPo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 08:15:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A34E6090E; Fri, 23 Aug 2019 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566562542;
        bh=1r30JA6PGylRMvBWwK0MZPMCK+yXDedgJm+kK/1QSt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kd8S4QJ9iHirqnsy3+azh/ueoMPdHx/7Wr4wSaWVIRdRKSLeWaqbwHzRXxotw00Qt
         gMVmcIQISocWukFbeFdRsV//HuaSe0jWlbHsGhUCzedxm3gEGvb/6aXQTp4vhpmVBU
         QGAGjUt//I2mPUi/Af6Q3dxxSNsX05Gd+AwXOFHk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8CBA860710;
        Fri, 23 Aug 2019 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566562541;
        bh=1r30JA6PGylRMvBWwK0MZPMCK+yXDedgJm+kK/1QSt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/7+Ox6qOBClultfxMqHQV9n4QwPMnionX8tCHLvQg4gn/lzWCK9UHUoBlU9b+qFB
         V4h42m9yUhGBR8ZZUQIXoJtWaqrC0NHVOCMfMIuEfFgwl9y2ymbgHjLjDN3CuNZFCA
         Q7LU7yTaUEDzJDIktXmYAyHhROiapK0ASQ2DxKd4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Aug 2019 17:45:41 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
 (sfid-20190820_181539_894705_E3B317D0)
 <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
Message-ID: <ee38dc5e80097d0ebc186f81b2f11d37@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-21 02:16, Johannes Berg wrote:
> On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
> 
>> +static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
>> +{
>> +	struct ath11k *ar = hw->priv;
>> +	int ret = 0;
>> +
>> +	/* mac80211 requires this op to be present and that's why
>> +	 * there's an empty function, this can be extended when
>> +	 * required.
>> +	 */
> 
> Well, oops. Maybe it shouldn't be required?

I think we require this for some configuration handling. The comment is 
to be updated with
proper information. We'll address that.

> 
>> +	mutex_lock(&ar->conf_mutex);
>> +
>> +	/* TODO: Handle configuration changes as appropriate */
>> +
>> +	mutex_unlock(&ar->conf_mutex);
> 
> It's not actually empty though - why bother locking the mutex for
> nothing?

Sure, we'll remove this locking.

> 
>> +	if (sta->mfp) {
>> +		/* TODO: Need to check if FW supports PMF? */
> 
> Probably not? shouldn't get a sta with MFP unless you advertised 
> support
> for it. At least I'd think so, and consider it a mac80211 bug if you
> still did.
> 

I could see driver getting sta with MFP irrespective of whether driver
advertises it's support in hw_flags by setting IEEE80211_HW_MFP_CAPABLE.
I see MFP station in driver even when I remove the support for the MFP 
cipher
suits in STA mode. I agree all these needs to be handled in mac80211.

>> +	/* This is a workaround for HT-enabled STAs which break the spec
>> +	 * and have no HT capabilities RX mask (no HT RX MCS map).
>> +	 *
>> +	 * As per spec, in section 20.3.5 Modulation and coding scheme 
>> (MCS),
>> +	 * MCS 0 through 7 are mandatory in 20MHz with 800 ns GI at all 
>> STAs.
> 
> Wouldn't that better be in mac80211?

Right.

> 
>> +	ampdu_factor = (vht_cap->cap &
>> +			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
>> +		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
> 
> consider u32_get_bits() or something like that from bitfield.h
> 
>> +	/* Workaround: Some Netgear/Linksys 11ac APs set Rx A-MPDU factor to
>> +	 * zero in VHT IE. Using it would result in degraded throughput.
>> +	 * arg->peer_max_mpdu at this point contains HT max_mpdu so keep
>> +	 * it if VHT max_mpdu is smaller.
>> +	 */
>> +	arg->peer_max_mpdu = max(arg->peer_max_mpdu,
>> +				 (1U << (IEEE80211_HT_MAX_AMPDU_FACTOR +
>> +					ampdu_factor)) - 1);
> 
> Wait, that seems familiar. Again, put it into mac80211?
> 

Sure.

>> +static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
>> +				     struct peer_assoc_params *arg)
>> +{
>> +	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
>> +	int smps;
>> +
>> +	if (!ht_cap->ht_supported)
>> +		return;
>> +
>> +	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
>> +	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
> 
> also here, u*_get_bits() or something might be nicer
> 
> (and yes, I've written tons of code like this myself before that
> existed, which is why I'm pointing it out - it's much nicer)
> 

Ok.

>> +void ath11k_mac_drain_tx(struct ath11k *ar)
>> +{
>> +	/* make sure rcu-protected mac80211 tx path itself is drained */
>> +	synchronize_net();
> 
> Doesn't mac80211 ensure that in the relevant places like flush()? But
> then again, not sure where you call this.

This tx drain cleans up any pending management frames in the software 
queue.
This will be done from hw_restart and drv_start callback to make sure we
do not have any pending management frames.

> 
>> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac set fixed rate params vdev 
>> %i rate 0x%02hhx nss %hhu sgi %hhu\n",
>> +		   arvif->vdev_id, rate, nss, sgi);
> 
> nit: that could use a line-break
> 
>> +	vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
>> +	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
>> +					    vdev_param, rate);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
>> 
>> +	/* TODO: Check if HT capability advertised from firmware is 
>> different
>> +	 * for each band for a dual band capable radio. It will be tricky to
>> +	 * handle it when the ht capability different for each band.
>> +	 */
> 
> For each band shouldn't really be that tricky?
> 

Sure, we'll review and address this TODO.

Thanks,
Vasanth

> _______________________________________________
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k
