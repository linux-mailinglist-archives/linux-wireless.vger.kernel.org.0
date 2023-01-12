Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE96666FDB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjALKji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbjALKin (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:38:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90B559EF
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tkqk9OVwHc7cakUNTHfk3WWi62OITypjR+r3piaBfbE=;
        t=1673519551; x=1674729151; b=fa2utgGchaC97/Bgk32AuSiwsQ87TO86ZoP9Lxv9r2xm0C7
        vb6TCni2C+GHG3mGhJ3/ZFtRfLvigNNlSUkXKF7D5ehAnxmRNZRjdwdGOcSXnyAvj+s7sTKdkeXOy
        S1DbcDRUobJZjycvXSaYXYoGTXRu0dvcg/fc6x5V3UkrC44AgdKheTTuX1J5CANAivKfI9JxJrgJi
        ehJ487JMLxGWxWq4e/DlmxjBqVxMsMnadikCLP1HEyBqpsruXl4n0z91UB/J2XGdmETxu/EYfC0UI
        9HizSHzCRPMUkobknR2d4RWwQIttOwG2bBNtOpXhI+gt4tQzOOlv40FRp0Ql+oLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFusn-00H3Lv-2u;
        Thu, 12 Jan 2023 11:32:30 +0100
Message-ID: <4dc5facf3dd23bc330659f3a46b559bb48a38981.camel@sipsolutions.net>
Subject: Re: [RFC v2 6/6] mac80211: minstrel_ht - add debugfs entry per sta
 for fixed tx-power
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name
Date:   Thu, 12 Jan 2023 11:32:29 +0100
In-Reply-To: <20220920104032.496697-7-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-7-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
> Create a new debugfs entry called 'rc_fixed_txpower_idx' in debugfs dir
> for each station. By writing a positive static tx-power idx into this
> file, minstrel_ht applies this tx-power idx to each packet or each mrr
> stage, depending on what the hardware supports. By writing (u32)-1 to
> the file, minstrel will return to automatic mode which currently just
> passes -1 as tx-power idx, indicating that the driver should use a
> default.
> The debugfs entry will only be created if either tpc per packet or per
> mrr is supported.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
>  net/mac80211/rc80211_minstrel_ht.c         | 14 ++++++++++++++
>  net/mac80211/rc80211_minstrel_ht.h         | 11 +++++++++++
>  net/mac80211/rc80211_minstrel_ht_debugfs.c | 11 +++++++++++
>  3 files changed, 36 insertions(+)
>=20
> diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_mi=
nstrel_ht.c
> index 24c3c055db6d..222b51e7d9ee 100644
> --- a/net/mac80211/rc80211_minstrel_ht.c
> +++ b/net/mac80211/rc80211_minstrel_ht.c
> @@ -1486,6 +1486,14 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, str=
uct minstrel_ht_sta *mi,
> =20
>  	ratetbl->rate[offset].idx =3D idx;
>  	ratetbl->rate[offset].flags =3D flags;
> +
> +#ifdef CONFIG_MAC80211_DEBUGFS
> +	if (mi->fixed_txpower_idx !=3D -1) {
> +		ratetbl->rate[offset].txpower_idx =3D mi->fixed_txpower_idx;
> +		return;
> +	}
> +#endif
> +	ratetbl->rate[offset].txpower_idx =3D -1;
>  }
> =20
>  static inline int
> @@ -1603,8 +1611,14 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_=
sta *sta, void *priv_sta,
>  	info->flags |=3D mi->tx_flags;
> =20
>  #ifdef CONFIG_MAC80211_DEBUGFS
> +	if (mi->fixed_txpower_idx !=3D -1)
> +		info->control.txpower_idx =3D mi->fixed_txpower_idx;
> +
>  	if (mp->fixed_rate_idx !=3D -1)
>  		return;
> +#else
> +	/* Pass -1 to indicate 'ignore txpower' or 'use default' */
> +	info->control.txpower_idx =3D -1;
>  #endif
> =20
>  	/* Don't use EAPOL frames for sampling on non-mrr hw */
> diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_mi=
nstrel_ht.h
> index 1766ff0c78d3..15222d66c4b8 100644
> --- a/net/mac80211/rc80211_minstrel_ht.h
> +++ b/net/mac80211/rc80211_minstrel_ht.h
> @@ -194,6 +194,17 @@ struct minstrel_ht_sta {
> =20
>  	/* MCS rate group info and statistics */
>  	struct minstrel_mcs_group_data groups[MINSTREL_GROUPS_NB];
> +
> +#ifdef CONFIG_MAC80211_DEBUGFS
> +	/*
> +	 * enable fixed tx-power processing per STA
> +	 *   - write static index to debugfs:ieee80211/phyX/netdev:wlanY
> +	 *   		/stations/<MAC>/rc_fixed_txpower_idx
> +	 *   - write -1 to enable automatic processing again
> +	 *   - setting will be applied on next update
> +	 */
> +	u32 fixed_txpower_idx;

Use s32? You don't need that large range anyway.

> +
> +	if (ieee80211_hw_check(mp->hw, SUPPORTS_TPC_PER_PACKET) ||
> +	    ieee80211_hw_check(mp->hw, SUPPORTS_TPC_PER_MRR))
> +	{

bad indentation

> +		mi->fixed_txpower_idx =3D (u32)-1;
> +		debugfs_create_u32("rc_fixed_txpower_idx", S_IRUGO | S_IWUGO,
> +				   dir, &mi->fixed_txpower_idx);
>=20

Seems like that should be a function with some range check?

johannes
