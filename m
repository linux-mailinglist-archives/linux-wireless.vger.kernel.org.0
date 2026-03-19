Return-Path: <linux-wireless+bounces-33454-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEmTEKuSu2mYlgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33454-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 07:07:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E412C687A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 07:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF2D322D406
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A119A2A3;
	Thu, 19 Mar 2026 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNnCCA3i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB363128B8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900036; cv=none; b=BNIGHtIZfZCH6mwQs+2RJZDt31++RqqcLpXhc+43B9dPFfxiTk6xeDe9FMTbvjk2KcdKtpm+ldEnCfP5ge+GkZf46QrcWWuokG5XbFKimx1tGZrvGa/ohkc5LbDf/B3itfxuzSL8rA5imL3zKEqWJvzO4dT8HIjAc+W/iCuCXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900036; c=relaxed/simple;
	bh=AuWihEjS4Na7P8c7/Ns1+pfE5wBeUB1/pngLuFfpbcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0KfCJvMfVaIyG1V5YzY3BrpUMWPt3xTIrYmbOI2Sg4rHrQ061NiRtRzf8GLQvnL/+SFSphfFGFawBbIzWEQkrGqRdr1ApD21BkXksNDHSJmcZV7ELmfwczOEajo1o5A75wTl99itraKosLK9esz2OAOU082ecZiMDCZKSD4/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNnCCA3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1882C19425
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773900035;
	bh=AuWihEjS4Na7P8c7/Ns1+pfE5wBeUB1/pngLuFfpbcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tNnCCA3ik0KvW0zvCbUHJmnV4mMOfkrLiosjuMIQshYCPkAHPwtR8aNSmEcTwm1QF
	 8w8dGHsBTr14xhkrOgLeghdHVI+iT1xeFofv2I9arr9FzRsBkOnTubZy6gJl+GJ1Vy
	 OZ7oBrSgz2TipKmLa2l+8+0a4aW/D5lD1HI4ZHJhqXEeEP8/X8zZ3aAcsIUeyLGelY
	 RAAZCkUqqOXaiSaIHRiUTC+zTOQKFXjVt2W7AzWk3c/ae9qvHjC65WP1uJxSor/GN+
	 MLbJxd+PenKmHkCMb0AAtH6HHtV7f2TVXXrCgxsjVulUQwqOIplRuuDUqDXh2vyjKK
	 Nn3KKpjUql3BA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a723b2b29so4762431fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 23:00:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWpysOK5m3UkccV9k5BgwpHA/g7vrbRJhvHmNXrzh4qp1iRNAi
	rLts0gfwiIT0ZQYwz0skZG/rKk/JEVKwfF0MkTUljhV363gw92BXVhEz3k74s79fTKakGP3hxD7
	xX0R0Dk8I1sqib7UzOdYRdbKArtEAxcU=
X-Received: by 2002:a05:6512:31d5:b0:5a2:78f2:3ade with SMTP id
 2adb3069b0e04-5a2796a2b69mr2368923e87.20.1773900034065; Wed, 18 Mar 2026
 23:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317173016.136975-1-lucid_duck@justthetip.ca> <20260317173016.136975-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260317173016.136975-2-lucid_duck@justthetip.ca>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 19 Mar 2026 01:00:18 -0500
X-Gmail-Original-Message-ID: <CAGp9LzqLbdEb25ocObMMuFPZitrL-UnC7uhaLOkYQN=TgSTmnA@mail.gmail.com>
X-Gm-Features: AaiRm53QdOUvnbNx-i8dM1p_P0LtvYl7pIHuSWO3YbYIIHqfYJ72DeFNeS7VzAo
Message-ID: <CAGp9LzqLbdEb25ocObMMuFPZitrL-UnC7uhaLOkYQN=TgSTmnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] wifi: mt76: mt7921: fix txpower reporting from
 rate power configuration
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	linux-mediatek@lists.infradead.org, morrownr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33454-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,lists.infradead.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email,sku_tlbv.channel:url]
X-Rspamd-Queue-Id: 91E412C687A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Mar 17, 2026 at 12:30=E2=80=AFPM Lucid Duck <lucid_duck@justthetip.=
ca> wrote:
>
> The mt7921 driver never updates phy->txpower_cur
> when TX power rate configuration is sent to firmware. This causes
> mt76_get_txpower() to report bogus values to userspace (typically
> 3 dBm) regardless of actual regulatory or SAR limits. User-set
> txpower limits via iw are also not reflected.
>
> Three root causes are addressed:
>
> 1. The rate power loop in mt76_connac_mcu_rate_txpower_band() computes
>    the correct bounded TX power for each channel but discards the return
>    value of mt76_get_rate_power_limits(). Fix: capture the return value
>    and store it to phy->txpower_cur when processing the current channel.
>
> 2. mt7921 uses the chanctx model but its add_chanctx callback bypasses
>    the common mt76_phy_update_channel(), leaving phy->chandef stale.
>    Fix: update phy->chandef from ctx->def in both add_chanctx and
>    change_chanctx, and trigger the rate power path to refresh
>    txpower_cur. Also trigger on IEEE80211_CONF_CHANGE_CHANNEL in
>    config(), matching mt7915.
>
> 3. For chanctx drivers, mac80211 routes user txpower changes through
>    BSS_CHANGED_TXPOWER in bss_info_changed() -- not through
>    IEEE80211_CONF_CHANGE_POWER in config(). hw->conf.power_level is
>    never updated. Fix: handle BSS_CHANGED_TXPOWER in
>    mt7921_bss_info_changed(), bridge bss_conf.txpower to
>    hw->conf.power_level, and re-trigger the rate power path.
>
> Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.17.1-300.fc43:
>
>   Before: iw dev wlan0 info shows "txpower 3.00 dBm" (wrong)
>   After:  correct per-band values, user limits reflected
>
> Test results (regulatory domain: Canada/CA):
>   - 2.4GHz ch6:  33 dBm (30 dBm limit + 3 dBm 2x2 path delta)
>   - 5GHz ch36:   26 dBm (23 dBm limit + 3 dBm path delta)
>   - 6GHz ch5:    15 dBm (12 dBm limit + 3 dBm path delta)
>   - Band switch: 100 cycles, 0 failures
>   - Module reload: 50 cycles, 0 failures
>   - 2-hour soak: 480 samples, zero drift
>   - Regdomain switching: 10 countries, all correct
>   - User txpower limits: reflected on all bands
>   - Monitor mode: correct on all tested channels
>
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 12 +++++++---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 22 ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 16db0f208..5856924a9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2193,14 +2193,20 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy=
 *phy,
>                                 .hw_value =3D ch_list[idx],
>                                 .band =3D band,
>                         };
> -                       s8 reg_power, sar_power;
> +                       s8 reg_power, sar_power, max_power;
>
>                         reg_power =3D mt76_connac_get_ch_power(phy, &chan=
,
>                                                              tx_power);
>                         sar_power =3D mt76_get_sar_power(phy, &chan, reg_=
power);
>
> -                       mt76_get_rate_power_limits(phy, &chan, limits,
> -                                                  sar_power);
> +                       max_power =3D mt76_get_rate_power_limits(phy, &ch=
an,
> +                                                              limits,
> +                                                              sar_power)=
;
> +
> +                       if (phy->chandef.chan &&
> +                           phy->chandef.chan->hw_value =3D=3D ch_list[id=
x] &&
> +                           phy->chandef.chan->band =3D=3D band)
> +                               phy->txpower_cur =3D max_power;
>
>                         tx_power_tlv.last_msg =3D ch_list[idx] =3D=3D las=
t_ch;
>                         sku_tlbv.channel =3D ch_list[idx];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 5881040ac..38a59c6f2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -638,7 +638,8 @@ static int mt7921_config(struct ieee80211_hw *hw, int=
 radio_idx, u32 changed)
>
>         mt792x_mutex_acquire(dev);
>
> -       if (changed & IEEE80211_CONF_CHANGE_POWER) {
> +       if (changed & (IEEE80211_CONF_CHANGE_POWER |
> +                      IEEE80211_CONF_CHANGE_CHANNEL)) {
>                 ret =3D mt7921_set_tx_sar_pwr(hw, NULL);
>                 if (ret)
>                         goto out;
> @@ -719,6 +720,14 @@ static void mt7921_bss_info_changed(struct ieee80211=
_hw *hw,
>         if (changed & BSS_CHANGED_CQM)
>                 mt7921_mcu_set_rssimonitor(dev, vif);
>
> +       if (changed & BSS_CHANGED_TXPOWER) {
> +               int tx_power =3D info->txpower;
> +
> +               if (tx_power !=3D INT_MIN && tx_power > 0)
> +                       hw->conf.power_level =3D tx_power;
> +               mt7921_set_tx_sar_pwr(hw, NULL);
> +       }
> +
>         if (changed & BSS_CHANGED_ASSOC) {
>                 mt7921_mcu_sta_update(dev, NULL, vif, true,
>                                       MT76_STA_INFO_STATE_ASSOC);
> @@ -1360,8 +1369,15 @@ mt7921_add_chanctx(struct ieee80211_hw *hw,
>                    struct ieee80211_chanctx_conf *ctx)
>  {
>         struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> +       struct mt76_phy *mphy =3D hw->priv;
>
>         dev->new_ctx =3D ctx;
> +       mphy->chandef =3D ctx->def;
> +
> +       mt792x_mutex_acquire(dev);
> +       mt7921_set_tx_sar_pwr(hw, NULL);
> +       mt792x_mutex_release(dev);
> +
>         return 0;
>  }
>
> @@ -1396,6 +1412,10 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
>                 mt7921_mcu_config_sniffer(mvif, ctx);
>         else
>                 mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss=
_conf.mt76, ctx);
> +
> +       phy->mt76->chandef =3D ctx->def;
> +       mt7921_set_tx_sar_pwr(hw, NULL);
> +

I do not think the additional mt7921_set_tx_sar_pwr() calls are justified.

mt7921_set_tx_sar_pwr() is not a lightweight per-channel refresh. It
rebuilds and pushes the rate txpower table for all channels in the band
through the MCU path. This is appropriate when the underlying power
constraints change (e.g. SAR, regulatory limits, or user-configured
txpower), but not for pure channel/chanctx transitions.

add_chanctx(), change_chanctx(), and IEEE80211_CONF_CHANGE_CHANNEL only
reflect channel/context changes and do not imply that the firmware
txpower table needs to be recomputed. Using mt7921_set_tx_sar_pwr() here
effectively turns it into a catch-all sync path.

If the issue is stale txpower reporting after a channel switch, it should
be fixed by updating phy->txpower_cur from the already computed bounded
max power for the current channel, rather than re-triggering full table
programming on every chanctx/channel event.

BSS_CHANGED_TXPOWER is also problematic. It is a per-BSS (per-vif) event,
while hw->conf.power_level is shared per-HW state. Writing
info->txpower into hw->conf.power_level allows one interface to affect
the effective txpower of others sharing the same PHY, which breaks
multi-vif semantics.

>         mt792x_mutex_release(phy->dev);
>  }
>
> --
> 2.51.0
>

