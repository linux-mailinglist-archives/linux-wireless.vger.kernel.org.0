Return-Path: <linux-wireless+bounces-24787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B982AAF6C88
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B6B1BC7334
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0022C1586;
	Thu,  3 Jul 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZETcyJ2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE02C08CC;
	Thu,  3 Jul 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530337; cv=none; b=EDrItqGeH8BlMZNagbP8RPn42TsLIX2e9n+VIu4tFJGam2Wg2ExTsyu+veltHfUsgDTOLIN9meYaRs1wJGeBbN2WtF7xroOhIxSkmf2Rij5vBrp965QMlZn9+DHPgjr0I/ccSGz9F9fvqqRKoD+kynAQrzmMOBP1iwItG1IIxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530337; c=relaxed/simple;
	bh=gerF8JQWMEdkhKtxPVw/PtBWBbq5eskmcKg3u+ll64w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JWgUpK2fkA9XfixKOztczQOxZEJOq/fCItcTJOFLSdLED3O8c61UYTVn8+HPHVI0FAsAd7KQDBvtUia1BHgW3SB1YqFKJ5ud2AhkqTToBjLOesDoHWrtYoSRGJSVEbSFjz/tmxBGwelmpTRWIiQaLV7a2DXMtgvXpn52YZvH+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZETcyJ2C; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so4627134f8f.2;
        Thu, 03 Jul 2025 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751530334; x=1752135134; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2Amm6SDjKC70sAGhYgLWsL4iEpai6FEV+TRkntvAp0=;
        b=ZETcyJ2CesOB/5P5LEv16xLTUfjyHayVmHDugtmlmozvFoAvx5fUNJMa7hH30TqOtj
         qJXWXFeUeIiu5qpS652wb9KODHaWgn2Eq58+glbBbJtWrwGsc88i6jHyY+9Nnx3fn0DT
         7PZA0NrJ8s7X/LAbSK5qd6ZC3IW/o0penquMgB7VXjSDuNDFv+3hHJUAtTl6DV/5q9Wu
         qJ6VlobI9HxDwollVC93cIWV9J4pfemnwqJ2b9k2iaM1JPcodPIXDOnKepJvSXGgavLD
         PiV+0bot6hvBZnhE2JIxJ4bdBQBilYanY7v2/sNzWz9cvznBcq3r3UFAhGhtf/mMurfN
         co+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530334; x=1752135134;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2Amm6SDjKC70sAGhYgLWsL4iEpai6FEV+TRkntvAp0=;
        b=xOn9OJjD+IRNYmCVeieQdml6b2WxsrwoFoMfguszQqP16qm1H7vDawqN0G7KO/cq7w
         3IUxMTuW3LlWiD7Exkq7CNABgaGjK8J3CghAVzmgDicBIYwLMtyT29/PxcjlGQoMk0xs
         YZ88+cTSmDFbSkjs8BzCef/Hg8365fpIsyv3UzLDgJHE6yyUXbl7HWZ+I1RFH1FbJt1C
         ab+cXz0R0KTDyi1BBcoqhSoM2LvORi69hhFCbsjNhgq0WgY4bWnFLKeOfbXcmgfK6yyI
         +ZU8OVDRp1aeYvbQ3vRnw2QYiBO8fU4pF9P/OiXcKDxq2UouLzv0UBYSn623w7aC4yb3
         mmzw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCzJ7R0OTMMHW0UmN/SA6gnMFdzBRMKLpDEUk+1oJufn4psDXuDaGlRGk4mixYGh6CwrCgQiXEXLrDmFIpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGxHJm8Oq3ycZ8ryT5CG++3DYDQl5n3hpwmXV7YaejSyl2tcM
	BCTqcn2f4uYTQard1MH2ZXXlc+vy0A8wEc3Ppzf6+Km3ijGPsK3ZL73y
X-Gm-Gg: ASbGnctARHmC6KT5NnzmS5Sfm4d07Ch9wAnZj2gY+sZnYJxVyJt+kZ+CAwQEYr+6JGv
	cPICYuvCcp+I/kZuJzLQBmpTX4ewzHLylCFDrAO0hkk91sgooLgNV4UnkRfk9Anv0R6V5hmZ7tf
	hp+V/NLZbhnN75aJ4H6FGD5lzkjcf1hsLKHG+NwPlF2f5r6QxmXN1UhMMw3RIw03TsuSJkaDwIA
	vfsieCqDwp33RFqqG18msr6trJAb2P8Sj8PQi5IJosX6QE+0dikK4jGToqElT8g+QQF6/+a0edI
	WCBv6USTxkpjPx71MDl5Igs6PxkkhncM2P5fz50JNEtCElvE8oSxd9lTadEmzgdorcMxAHx1Wcl
	qYqNQ
X-Google-Smtp-Source: AGHT+IEsq9wzUgl/VuH0s0iIjat6vHpL06Nc9v/cKnSMypsYOplsRyGJHy9CMEXSR8iNqHbAWyjM3A==
X-Received: by 2002:adf:b60c:0:b0:3a3:71cb:f0bd with SMTP id ffacd0b85a97d-3b32c196f1bmr1505622f8f.23.1751530333868;
        Thu, 03 Jul 2025 01:12:13 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5972bsm18169702f8f.68.2025.07.03.01.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Jul 2025 10:12:12 +0200
Message-Id: <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 <syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Moon Hee Lee" <moonhee.lee.ca@gmail.com>, <johannes@sipsolutions.net>,
 <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
In-Reply-To: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>

On Wed Jul 2, 2025 at 8:59 AM CEST, Moon Hee Lee wrote:
> VHT operating mode notifications must not be processed when the channel
> width is 5 MHz or 10 MHz, as the VHT specification does not support these
> narrow widths.

Hello,
Is this really specific for VHT ? or for HE /EHT as well ?

>
> Without validation, a malformed notification using 10 MHz can reach
> ieee80211_chan_width_to_rx_bw(), triggering a WARN_ON due to the invalid
> width. This issue was reported by syzbot.
>
> Reject these widths early in sta_link_apply_parameters() when
> opmode_notif is used.
>
> Reported-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dededba317ddeca8b3f08
> Fixes: 751e7489c1d7 ("wifi: mac80211: expose ieee80211_chan_width_to_rx_b=
w() to drivers")
> Tested-by: syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
>  net/mac80211/cfg.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 56540c3701ed..5a6ae093a8bd 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1981,6 +1981,21 @@ static int sta_link_apply_parameters(struct ieee80=
211_local *local,
>  	ieee80211_sta_init_nss(link_sta);
> =20
>  	if (params->opmode_notif_used) {
> +		enum nl80211_chan_width width =3D link->conf->chanreq.oper.width;
> +
> +		switch (width) {
> +		case NL80211_CHAN_WIDTH_20_NOHT:
Because this seems weird for VHT
> +		case NL80211_CHAN_WIDTH_20:
> +		case NL80211_CHAN_WIDTH_40:
> +		case NL80211_CHAN_WIDTH_80:
> +		case NL80211_CHAN_WIDTH_160:
> +		case NL80211_CHAN_WIDTH_80P80:
> +		case NL80211_CHAN_WIDTH_320:
And this did not exist for VHT either
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
>  		/* returned value is only needed for rc update, but the
>  		 * rc isn't initialized here yet, so ignore it
>  		 */


