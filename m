Return-Path: <linux-wireless+bounces-33044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CRpQKSpOsmlpLgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:24:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C626D5E3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8C330AD4A3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C733947AF;
	Thu, 12 Mar 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH88NPNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76983932E9
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773293095; cv=none; b=IDELRXoOaBdkOwS+ZreabUzrLj8+1STT2WlPf/9hr47DZibo3ACNb+S9aWBslltAWnLFTconNsaVWbAW/gHUGJz9cBuhmGPvX3EBqO2YtMDPeBLseuS2fFZb+GyyiNOYQ78ikpOYimUIC5lZBcfi6FssMhzwe2cat2DJWhAYYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773293095; c=relaxed/simple;
	bh=2ecOeqfyRFrj/e+SpsihyfKp7aoNYixjg74nS+O6fK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN/ANftLfqzclsRDhVkj1Am/4kcS+7IcEmJ2oKq69FdrfcQuZO0A9beZGRBMTHvBmYCXIQsl4bPfzPSXbjwaNDigHTCfirjA5V9KK+sMvKDJnutF159XfhRiIVJ4Kqi/NVwIr8x7uHkWHsN/UaFd5K5e/+padMCTqZz9hyoU9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH88NPNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C17C2BC9E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773293095;
	bh=2ecOeqfyRFrj/e+SpsihyfKp7aoNYixjg74nS+O6fK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VH88NPNRdviJuzoRjI9hjhwWp3ADXLruXwoy+UQFn0OKdYq9XD8g6lXoMx3DYwcfn
	 B5nobsjrDlCv0jD2WGEejgipnBH5dfI8J3JiAXhB+W4VFIttUL3EUg7LhN0TgoEiu7
	 Nc/ETQGEV2DQ676aGPHjkjBzlL/gFOJwfaat4BmebFPCmEIvhb+FnnYZeIgFlGvfuW
	 LAbGawagq0ENlfOon7YcYkuxoHZo6uxumdHwrjcQECJl1XcjANSACKoj5mS0pfU8VM
	 ge4EjwnWLJhJUy5C43Xh0VAwkhzQwRYqZTFAaeO3pfvtQVEq870n6ck2exDHREvNx/
	 ouTIsnEELfl+g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a107b387a5so836392e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 22:24:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw7zY9FxFHjw6Mrlv7/ploNZ9uvgkHiQO26IucDAr62fan6n2ga
	Fhm67IXiJNMb1F3XYaWVn3Gy7WJe+0Bfd1C4cePmkTPe5MOjSetIT01XOYXc0mpCHjiZxigxEaH
	nV+GmM/5UM/BqvyVba1/HNQYAdN/cEO0=
X-Received: by 2002:a05:6512:1559:20b0:5a1:59b7:8a50 with SMTP id
 2adb3069b0e04-5a159b78c85mr624904e87.36.1773293093701; Wed, 11 Mar 2026
 22:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
 <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
 <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com> <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
In-Reply-To: <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 12 Mar 2026 00:24:42 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzqr3MU6stHOYhZAu-tNCkGrpGX5Psf3wrAxcvQEvM3ZCA@mail.gmail.com>
X-Gm-Features: AaiRm51DcCI0nwDlLcOubrnU2kyO7tb72XQqSHUCBKcYSIvggxAZvOvuoVo5ZO8
Message-ID: <CAGp9Lzqr3MU6stHOYhZAu-tNCkGrpGX5Psf3wrAxcvQEvM3ZCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: bryam vargas <bryamestebanvargas@gmail.com>, lucid_duck@justthetip.ca
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33044-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B8C626D5E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I just realized that Lucid already implemented another approach to
obtain the TX power here:
https://lore.kernel.org/linux-wireless/20260130215839.53270-1-lucid_duck@ju=
stthetip.ca/
We should respect his work. Could you also take a look at it and reply
to his patch to avoid potential rework?

On Wed, Mar 11, 2026 at 3:57=E2=80=AFPM bryam vargas
<bryamestebanvargas@gmail.com> wrote:
>
> From 6c75ad481f0c3667d6ae2a2c8f7c2df08b1d52b5 Mon Sep 17 00:00:00 2001
> From: bryam <bryamestebanvargas@gmail.com>
> Date: Mon, 9 Mar 2026 11:52:53 -0500
> Subject: [PATCH v2 1/2] mt76: mt7921: add mt7921-specific get_txpower cal=
lback
>
> Instead of updating txpower_cur in the write path
> (mt76_connac_mcu_set_rate_txpower), implement a mt7921-specific
> .get_txpower callback that derives the reported TX power directly
> from the SKU limits at query time.
>
> This avoids mixing write-side configuration with reporting logic.
> The callback uses mt76_get_power_bound() for SAR constraints and
> chain delta, then mt76_get_rate_power_limits() for per-rate EEPROM
> limits, yielding the actual TX power value.
>
> Fixes: 3b4a3bdba808 ("mt76: mt7921: add support for reporting tx power")
> Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 67383c4..35454e5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1517,6 +1517,31 @@ static void mt7921_rfkill_poll(struct ieee80211_hw=
 *hw)
>      wiphy_rfkill_set_hw_state(hw->wiphy, ret ? false : true);
>  }
>
> +
> +static int mt7921_get_txpower(struct ieee80211_hw *hw,
> +                  struct ieee80211_vif *vif,
> +                  unsigned int link_id, int *dbm)
> +{
> +    struct mt76_phy *phy =3D mt76_vif_phy(hw, vif);
> +    struct mt76_power_limits limits;
> +    int n_chains, delta;
> +    s8 tx_power;
> +
> +    if (!phy)
> +        return -EINVAL;
> +
> +    if (!phy->chandef.chan)
> +        return mt76_get_txpower(hw, vif, link_id, dbm);
> +
> +    n_chains =3D hweight16(phy->chainmask);
> +    delta =3D mt76_tx_power_path_delta(n_chains);
> +    tx_power =3D mt76_get_power_bound(phy, phy->chandef.chan->max_power)=
;
> +    tx_power =3D mt76_get_rate_power_limits(phy, phy->chandef.chan,
> +                          &limits, tx_power);
> +    *dbm =3D DIV_ROUND_UP(tx_power + delta, 2);

how can you make sure it is the result of the maximum rate power used
in the loop within mt76_connac_mcu_rate_txpower_band (updated with
each call) ?

> +    return 0;
> +}
> +
>  const struct ieee80211_ops mt7921_ops =3D {
>      .tx =3D mt792x_tx,
>      .start =3D mt7921_start,
> @@ -1541,7 +1566,7 @@ const struct ieee80211_ops mt7921_ops =3D {
>      .wake_tx_queue =3D mt76_wake_tx_queue,
>      .release_buffered_frames =3D mt76_release_buffered_frames,
>      .channel_switch_beacon =3D mt7921_channel_switch_beacon,
> -    .get_txpower =3D mt76_get_txpower,
> +    .get_txpower =3D mt7921_get_txpower,
>      .get_stats =3D mt792x_get_stats,
>      .get_et_sset_count =3D mt792x_get_et_sset_count,
>      .get_et_strings =3D mt792x_get_et_strings,
> --
> 2.43.0

