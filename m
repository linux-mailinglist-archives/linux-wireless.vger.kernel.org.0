Return-Path: <linux-wireless+bounces-26178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281CB1C7CF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C2F62219D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BF215F4A;
	Wed,  6 Aug 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxeunQk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6C9463
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491373; cv=none; b=Fseoci4A+GDMwwm+Oo3Cf7D/ueTLypwXlpCC0mcZXcpq7XF8bq/Kyss8liqhdR1RCs2C23cV+vkTxSaDVqpRB9ftzTo6R3G0Th9QDMbmQPQ4LjPOwGsEBQoH1/X5S5y763ojozQL+jjQas/5gVL7724mGmQmUUPmz/CYPXVJweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491373; c=relaxed/simple;
	bh=BhA3aCH2p2c2V1J10H8bAIZ5wB+Um0dt9uf2I0XaOFI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ZMea3SZ8gFCLoRiCl+PDUn3EbQoYh6ybNpNk1oj7FsZGzqqMhrXoDncB9FLkougiCWDcLJaGEuol0lBmnDRTSI6Asz9nfElmW/1SDibpj8JTPOvyiou/55+OqA2d+I19k3JgFPKFcRTp8gBadj8KdY6kyIaOt31UGP5gxvNueac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxeunQk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7910123a0so6678210f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754491370; x=1755096170; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWw+MjM3br4Mpju/7XqdWU9TQLJhhkihJVgJqEHEcAA=;
        b=UTxeunQk9L8WgGr9EnYw33JELKPd/PE9mZpoImnmXagdfLpujIjmcUylMAoXPoG+uw
         NCRalDLwltViv8k6zqEQuJ2H3c6C0nmgMU1LOfVl1rSRaz7AcQDzbHP9JG2bzu8x7sJ/
         7Z+uiQR05JCI60DZJM2HL586EpwAGklKvlystYpjyrBJWjnp68FBZMXyKbbnYwxWVj7s
         Tjve+dzoGRkbO0cFtX2Z/p6MiSgsVJP444Z6JaEWPKysBHGex//aefY9zehecmCIakX0
         9bLH9sf8gx3SQ3/94FJRvFfanyMGhVPAP5AMWSacsmvjRukUqpyKOwdBXbuVgUqRFE5P
         8xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491370; x=1755096170;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QWw+MjM3br4Mpju/7XqdWU9TQLJhhkihJVgJqEHEcAA=;
        b=LlYUFGIPuiqkaxhU0wJ6nccEK+7u9vmZGgKbh4HSZ9Dq6l3iCBJ5kTCIwy0SdMKNZW
         hRRWQzPLqzxoKvfrZJkX2k4ZlLE1+afSuOV2n2MO0rqp+n8kto8221802EDnPznnbIgk
         Szyfz6zN9U2sL+4URJXFx3jGGCfL9hPPNL/IYZo3X4nbfG8sNjb4owEbYnXWFKKJrdCg
         /ENVIgOjlx7YhK77tgYfwEAGwp3r60WS8vBg3mQcGkvRfKok1XlOQtwH5/DqtWtFh0aw
         /vVBfwvTD0UgUwCpvoo/o2XH5VxWN0VAq7WlfDX0ped0QtY8BY/g0p7Y2V3jgm6iHsp6
         empA==
X-Gm-Message-State: AOJu0YyFygCmB+Jv65KSSVBwU4802qwFB0fFmqOejfLrP2JByYx2uTDd
	PXb16zJDjogB/xj8k/54CY6d91Sc2u1/Errw18o3T7Ayf7xkORyPk/n/
X-Gm-Gg: ASbGncuglind0ganUZp1q9+cue7tHxW70/D4XXrQhSnPPhr+VwM1hYqJWKA4N61PzUc
	9APwtSR4biYyxOqaAAWCeg5wTu96pimoQAsyUryWQsJhv9YPEwmik+x9iqSa8C7Bchtf0uuQGzA
	1IvV8kQaFCBsxudyR1n6SgzLTD1DHf8wrndM5D3oaQLnCccVFzSCP423K3KOqSPrf8ZMkotZs87
	1OSuY9zacjutiYzPq/IG6QiTgQ8ehQXjWbLkCmggY5bV5HaaErr44A/jx5M0sYW7FZX3XseEG1w
	bm7vZ4SERqif+EMiVS2B02ZkQtscHxpr5A/Gm3vKXPpryeBA/f+sZBaLSIFMYJoGnSrSkRpPNCe
	LXwstb72ufLPOyE3FExr3wF833icdqmZ1/D7lBmzL
X-Google-Smtp-Source: AGHT+IHWeGfQXaO+4NLW4ZYjiQkn0HSH4ezZav2OEQkSkp83L62iz1a5bKsv2KyEuXbYkEeAhim/Cg==
X-Received: by 2002:a05:6000:4287:b0:3b7:90f3:cd8a with SMTP id ffacd0b85a97d-3b8f41b6e65mr2942970f8f.49.1754491369781;
        Wed, 06 Aug 2025 07:42:49 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9c7dsm23096886f8f.26.2025.08.06.07.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 16:42:48 +0200
Message-Id: <DBVFA7TPXKHU.33YF5JEOR1ZLT@gmail.com>
To: "Zhi-Jun You" <hujy652@gmail.com>, <jjohnson@kernel.org>
Cc: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
Subject: Re: [RFC PATCH] wifi: ath10k: support flush_sta method
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250806070005.1429-1-hujy652@gmail.com>
In-Reply-To: <20250806070005.1429-1-hujy652@gmail.com>

On Wed Aug 6, 2025 at 9:00 AM CEST, Zhi-Jun You wrote:
> When a STA is marked as no longer authorized, if the driver doesn't
> implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> flush hardware queues to avoid sending unencrypted frames.
>
> This has became a problem for ath10k because ieee80211_flush_queues()
> will stop all traffic and call ath10k_flush, which waits until the
> whole HW queue is empty. In a busy environment this will trigger a
> timeout warning and stalls other STAs.
>
> Fix this by implementing flush_sta method using WMI command to flush
> frames of a specific STA.
> Flushed frames will be marked as discard in tx complete indication.
>
> ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
> true.
>
> Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157
>
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless=
/ath/ath10k/mac.c
> index 24dd794e31ea..6959f20334a7 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -8135,6 +8135,20 @@ static void ath10k_flush(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
>  	mutex_unlock(&ar->conf_mutex);
>  }
> =20
> +static void ath10k_mac_op_flush_sta(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
> +			     struct ieee80211_sta *sta)
> +{
> +	struct ath10k_vif *arvif =3D (void *)vif->drv_priv;
> +	struct ath10k *ar =3D hw->priv;
> +	u32 bitmap =3D 0xFFFFFFFF;
> +	int ret =3D 0;
> +
> +	ret =3D ath10k_wmi_peer_flush(ar, arvif->vdev_id, sta->addr, bitmap);
> +	if (ret)
> +		ath10k_warn(ar, "failed to flush sta (sta %pM)\n",
> +			    sta->addr);

Hello,

Just to be sure, you have seen real improvements from this ?
Because I remember trying this exact WMI command two years ago and I couldn=
't be
sure it was actually doing something. That's one of the reasons why we ende=
d up
doing the per peer frame accounting as posted by remi here
https://lore.kernel.org/linux-wireless/17d26d6a3e80ff03939ee7935fdc07f979b6=
1a4f.1732293922.git.repk@triplefau.lt/

Thanks

