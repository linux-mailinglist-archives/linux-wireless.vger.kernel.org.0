Return-Path: <linux-wireless+bounces-32747-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMgrLdtrrmkvEAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32747-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:42:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE942344DF
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B97BA3008A51
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0923603D6;
	Mon,  9 Mar 2026 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWwiKulv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAB3603F9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038553; cv=none; b=kvwN9Gu8dWVZuPlEVcbjq0b3mUpWihF5Igcbxp2KrVs3zfLdJuWwsjwpTMTZIHLWsD46oMyswlfiKZa3PHQKgrOwuos9kyCIXZWBdawRUs5U30HvxYQA7+xa2e8vZLF2ZYA4RjIIMUP/8nFmDoOe2YM+kR9IDllg1+thJwPzQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038553; c=relaxed/simple;
	bh=bK4Sr5UqmtGz43bgA7L5468rrUIu5McOxaPwXrtQ7p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/1NGiVMpIDBVqAL8TuE7drZqSoJ1VKA3fSjTdTY8aUbI/qGE5LDqfq2li+8mN6JjHWhCuzT7f7qkXR4dZ6SLb+SDz0CY4lgTMM6C9wHHHajwU+rweyv8osU+8aa8YJi6yJ8e3+WYIn/KT56YT4etdb1A00OZZ+rBza3KYl0EQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWwiKulv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBB9C4CEF7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773038553;
	bh=bK4Sr5UqmtGz43bgA7L5468rrUIu5McOxaPwXrtQ7p0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mWwiKulvCnIo8rj5DXimcH7a17H3bDJFPKPAx7tJIQ4vHIWnQrZEIQ6ywkUTm+0ok
	 CcXNmZCQAdb+TmRvDZwbxCIF0k4T1SxdXivx+HaOWN1/xNxuGQh/pz/HIakYb9jSBP
	 kjCYyh37QMygU26kGR1ID21XVOAogrZpbPVNIt7kUx+23eUV5MUU4X4GLwCdzHSTu1
	 s6A4a6I7lTr7Fg0OgKcn6S/2i31i0KVJydGyu6OhiYhJwJWxOcjZS1aIQ1x9YKecTt
	 gy8912SdEbV5PT+Te0K+UBVnuyDh5cJIuaB/oG5FVXW+92hdR+x/aLnv9W3PH1sUUO
	 lfi6YIRC8SE9w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a13d6a2d7bso2192306e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2026 23:42:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8ih3b2S3tsoxfNuM1vcykX7lEy+1nK9XpFLMmwQT2Jxr5NYfZ
	/YdBVfIyjZXZqMhuRtYkKtrekk6SpvEvgLQ2ZF/bBjkgIBlmvqN5zN1GhhpHy88E1jxIZNsYmBm
	tLJixdQRePvv1YL5XfOmjAW24cxeaXuk=
X-Received: by 2002:a05:6512:2241:b0:5a1:2c19:4e83 with SMTP id
 2adb3069b0e04-5a131f27b2fmr4547137e87.20.1773038551421; Sun, 08 Mar 2026
 23:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
In-Reply-To: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 9 Mar 2026 01:42:20 -0500
X-Gmail-Original-Message-ID: <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
X-Gm-Features: AaiRm535bp3mMDjGT40DMDnRmBiHn2tomilrBSmxbcjZXNAf71PJZph4xcRZiHw
Message-ID: <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: bryam vargas <bryamestebanvargas@gmail.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1AE942344DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32747-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	NEURAL_HAM(-0.00)[-0.956];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

On Fri, Feb 27, 2026 at 3:53=E2=80=AFAM bryam vargas
<bryamestebanvargas@gmail.com> wrote:
>
> From 0a29ccaeb2211451b88ad71c4c0cdbc418b7d64d Mon Sep 17 00:00:00 2001
> From: bryam <bryamestebanvargas@gmail.com>
> Date: Fri, 27 Feb 2026 04:30:01 -0500
> Subject: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in
>  mt76_connac_mcu_set_rate_txpower()
>
> mt76_connac_mcu_set_rate_txpower() sends the TX power SKU table to the
> firmware but never updates mphy->txpower_cur. This causes mt76_get_txpowe=
r()
> to always report 3 dBm regardless of the actual configured power level,
> since txpower_cur remains at its zero-initialized value and only the
> path delta for 2 chains (6 units of 0.5 dBm) gets applied.
>
> Fix this by calculating the effective TX power using the same approach
> as mt7915: mt76_get_power_bound() applies SAR constraints and chain
> delta, then mt76_get_rate_power_limits() applies the per-rate EEPROM
> limits, yielding the actual value the firmware will use.

I wonder if this would fit better in .get_txpower instead.

mt76_connac_mcu_set_rate_txpower() is primarily a programming path
that pushes the SKU table to firmware. Updating txpower_cur there
mixes write-side configuration with reporting logic.

It might be cleaner to handle this in .get_txpower with an
mt7921-specific callback that derives the reported TX power from the
SKU limits instead of updating the cached value in the write path.

>
> Fixes: 3b4a3bdba808 ("mt76: mt7921: add support for reporting tx power")
> Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
> ---
>  .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index fc3e672..4ed31ff 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2272,6 +2272,20 @@ int mt76_connac_mcu_set_rate_txpower(struct
> mt76_phy *phy)
>              return err;
>      }
>
> +    /* Update txpower_cur so mt76_get_txpower() reports the actual
> +     * configured TX power instead of always returning 3 dBm due to
> +     * txpower_cur being left at its zero-initialized value.
> +     * The value is stored in 0.5 dBm units as used by the SKU table.
> +     */
> +    if (phy->chandef.chan) {
> +        struct mt76_power_limits limits;
> +        s8 tx_power;
> +
> +        tx_power =3D mt76_get_power_bound(phy, phy->chandef.chan->max_po=
wer);
> +        tx_power =3D mt76_get_rate_power_limits(phy, phy->chandef.chan,
> +                          &limits, tx_power);
> +        phy->txpower_cur =3D tx_power;
> +    }
>      return 0;
>  }
>  EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
> --
> 2.43.0
>

