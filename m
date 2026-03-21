Return-Path: <linux-wireless+bounces-33622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGk8CSRevmnxNgMAu9opvQ
	(envelope-from <linux-wireless+bounces-33622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 10:00:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EF72E448E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 10:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A88B303C025
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE32D0610;
	Sat, 21 Mar 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQWM+2+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D8346A0A
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774083508; cv=none; b=iLOnl1sJAtfyW2pQyr5lM7rDvOsUc832NyJhgrBNKA29xsbZdGCLosXyChjD3+3T41vrVG37ZJk3PAjmXPUm95IUIFqseBUCQQ5qxBY61NDkkgD90bNbPjyt7tJ7PMxi+siMEygSabwm3Gf0qyY3wUE/85F1jTF8CtXZPFHoqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774083508; c=relaxed/simple;
	bh=2XHxbPwnxKukyNT67I5mzcaAWXGuDcV1AruFyiB0Bd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XePL1MjhxffURrnZn91jJvXWCwIrJAA0QbYs0RdqdMKtYnX3PQl3dVC6tLJ3mYMwe+Uh3Tm4wL/QvuK0J8ZGX1Y4DvHwTZrefyof6tYUlA2l4k2GXYXusRGxnLfFNXWoQiEO5C7Cmie+mqa4AOKhBQU8gbGmounLhFyOM9fjk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQWM+2+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77364C2BCB0
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774083508;
	bh=2XHxbPwnxKukyNT67I5mzcaAWXGuDcV1AruFyiB0Bd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oQWM+2+0a1J0ixRPtxTmIis0R0JYOZWP3n3HX53iAsns6Xreszyeocic6+Og5dA8q
	 +BzkRwqNK4th/1cnSrp2IfAfO6yfTt461eeP2KIABBn93jUh5gyDI+0osVbU6nFg6c
	 +jYvDo35Bjm50kNARQNpaX0nmbYS7zx5oJeB/gI8VZGEhuEtchSeNbTzMYyjuMhL1U
	 86OTRfeqxae7bXerF/ntdYbRqEcRFxixCU5VCj8kvoq2cduL1gBWVLXZAmMqapdMak
	 WC+mrY6kn1iHoUbm/4lBCZKt2a/RdMTrvvSbWLs5aOSmi5VNwMmRnX5Cz6TD4gUUdS
	 k5kTl0SyQjfyQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a0faa0d15cso2624584e87.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 01:58:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA0fbuGxndjJyphaNANIwRdoIHFdfFyUzOn910LZ1ynczcqLzgKo+ZtxAGSsjGsF+V6KG+MOY4GcBSxPu06Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtHRaTuYnsiW+G/DuRD4n5TXEGIb7iYih7nQ6pIHpnefvAikO
	KWawouwnSgngtBEwnqCFhVdaZosf+pspltLCLtUWkGnF8zLAhIrfyI2rW7rS7Gv7sIV0w7wLqOX
	GlPqdl046Cpi1+FA6brFu98zczv9Z0ps=
X-Received: by 2002:a05:6512:3b0a:b0:5a1:d34e:25d with SMTP id
 2adb3069b0e04-5a285b071camr1756554e87.18.1774083506738; Sat, 21 Mar 2026
 01:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp9LzqLbdEb25ocObMMuFPZitrL-UnC7uhaLOkYQN=TgSTmnA@mail.gmail.com>
 <20260319203854.30479-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260319203854.30479-1-lucid_duck@justthetip.ca>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 21 Mar 2026 03:58:15 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpVYj=FVyJX+mm0vSsJL52WEPi=L-6Ev3taViJZ+xL_vw@mail.gmail.com>
X-Gm-Features: AaiRm52CEIxpNeBsnDo08uYM5XfWpwvzEeFcNwWJAwhqs_1O6X-L42sdV8KzR9E
Message-ID: <CAGp9LzpVYj=FVyJX+mm0vSsJL52WEPi=L-6Ev3taViJZ+xL_vw@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mt76: mt7921: fix txpower reporting from rate
 power configuration
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, morrownr@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33622-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73EF72E448E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 19, 2026 at 3:39=E2=80=AFPM Lucid Duck <lucid_duck@justthetip.c=
a> wrote:
>
> The mt7921 driver never updates phy->txpower_cur from the rate power
> configuration sent to firmware, causing mt76_get_txpower() to report
> bogus values to userspace (typically 3 dBm) regardless of actual
> regulatory or SAR limits.
>
> Two issues are addressed:
>
> 1. The rate power loop in mt76_connac_mcu_rate_txpower_band() computes
>    the correct bounded TX power per channel via
>    mt76_get_rate_power_limits() but discards the return value. Capture
>    it and store to phy->txpower_cur when processing the current
>    channel, matching how mt7915 handles this in
>    mt7915_mcu_set_txpower_sku(). Subtract the multi-chain path delta
>    before storing, since mt76_get_txpower() adds it back when
>    reporting -- consistent with mt7915's use of mt76_get_power_bound()
>    which performs the same subtraction.
>
> 2. mt7921 uses the chanctx model but its add_chanctx callback does not
>    update phy->chandef, leaving it stale after association. The rate
>    power loop's channel comparison then fails silently. Sync
>    phy->chandef from ctx->def in add_chanctx and change_chanctx, and
>    recompute txpower_cur via a lightweight helper that performs the
>    same bounded power calculation for the current channel without
>    reprogramming firmware rate tables.
>
> Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.19.8, Canada:
>
>   Before: iw dev wlan0 info shows "txpower 3.00 dBm" (wrong)
>   After:  2.4GHz 36 dBm, 5GHz 23 dBm, 6GHz 12 dBm (match regulatory)
>
> Cc: stable@vger.kernel.org
> Fixes: 1c099ab44727 ("mt76: mt7921: add MAC support")
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
> ---
> Changes since v3:
> - Removed mt7921_set_tx_sar_pwr() from add_chanctx and change_chanctx.
>   Channel transitions don't change underlying power constraints, so
>   reprogramming the full rate table is unnecessary. Replaced with a
>   lightweight helper that recomputes txpower_cur locally.
> - Removed IEEE80211_CONF_CHANGE_CHANNEL trigger from config().
> - Removed BSS_CHANGED_TXPOWER handler from bss_info_changed(). Writing
>   per-vif txpower into per-HW hw->conf.power_level breaks multi-vif
>   semantics. User txpower limits need a different approach (follow-up).
> - Subtracted path delta before storing txpower_cur. The connac rate
>   loop stores total bounded power, but mt76_get_txpower() adds the
>   multi-chain path delta when reporting. mt7915 accounts for this via
>   mt76_get_power_bound(), which subtracts the delta before storing.
>   Without the same subtraction, reported values were inflated by 3 dBm
>   on 2x2 devices.
>
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 14 +++++++--
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 30 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 16db0f208..e26a2cb39 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2193,14 +2193,22 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy=
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
> +                               phy->txpower_cur =3D max_power -
> +                                       mt76_tx_power_path_delta(
> +                                               hweight16(phy->chainmask)=
);
>
>                         tx_power_tlv.last_msg =3D ch_list[idx] =3D=3D las=
t_ch;
>                         sku_tlbv.channel =3D ch_list[idx];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 5881040ac..a77ae5791 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1355,13 +1355,39 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ie=
ee80211_vif *vif,
>         mt792x_mutex_release(dev);
>  }
>
> +static void mt7921_update_txpower_cur(struct mt76_phy *phy)
> +{
> +       struct mt76_power_limits limits;
> +       struct ieee80211_channel *chan =3D phy->chandef.chan;
> +       int n_chains =3D hweight16(phy->chainmask);
> +       s8 reg_power, sar_power, max_power;
> +       int tx_power;
> +
> +       if (!chan)
> +               return;
> +
> +       tx_power =3D 2 * phy->hw->conf.power_level;
> +       if (!tx_power)
> +               tx_power =3D 127;
> +
> +       reg_power =3D mt76_connac_get_ch_power(phy, chan, tx_power);
> +       sar_power =3D mt76_get_sar_power(phy, chan, reg_power);
> +       max_power =3D mt76_get_rate_power_limits(phy, chan, &limits, sar_=
power);
> +
> +       phy->txpower_cur =3D max_power - mt76_tx_power_path_delta(n_chain=
s);
> +}
> +
>  static int
>  mt7921_add_chanctx(struct ieee80211_hw *hw,
>                    struct ieee80211_chanctx_conf *ctx)
>  {
>         struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> +       struct mt76_phy *mphy =3D hw->priv;
>
>         dev->new_ctx =3D ctx;
> +       mphy->chandef =3D ctx->def;
> +       mt7921_update_txpower_cur(mphy);
> +

I don't think this is the right fix.

This mixes multiple things in one patch and duplicates the same power
limit calculation in shared connac code and mt7921-specific code.

The issue is in txpower reporting. A channel context is just a view of
the current PHY configuration and should not be used to overwrite PHY
state.

I think this needs to be reworked in a cleaner way, with the shared
logic kept in shared code and the reporting side fixed in the common
mt792x path so it can apply cleanly to both mt7921 and mt7925.

Given the points above, I'd prefer not to keep iterating on the current
approach for v5. I'll try to rework this along the lines above and send
an updated version.

>         return 0;
>  }
>
> @@ -1396,6 +1422,10 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
>                 mt7921_mcu_config_sniffer(mvif, ctx);
>         else
>                 mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss=
_conf.mt76, ctx);
> +
> +       phy->mt76->chandef =3D ctx->def;
> +       mt7921_update_txpower_cur(phy->mt76);
> +
>         mt792x_mutex_release(phy->dev);
>  }
>
> --
> 2.53.0
>

