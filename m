Return-Path: <linux-wireless+bounces-15498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D39D21E0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 09:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7FD1F21558
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742B197A7A;
	Tue, 19 Nov 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbbv24pD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75313C8F3;
	Tue, 19 Nov 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006356; cv=none; b=gdloTm7LqGXKw0REojoxZVw/w1Fql9N9RIgK3pqxGDK8bNblTAShwvFOp9augYrXoSjLxPEEpzQGGCkABXAVbnXQuEQYHFnO6Lz4/aJOQCSxvwruLAuJlRL/4Shaqd0nwFe9givz8kEnputFvH3lfn3iltnNvD8xo4e0INOzbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006356; c=relaxed/simple;
	bh=UAsTUyY0fHhTZjbPvR5l8EhE92x+1fw/zMhbScAb7Tw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=THScn8cDuJnBtap4On3EZZEypA48f6nDzVBZh2mtEIUsIba6BbQARw0JSV3S1DMQpBwJDftIHSljV/fhYeJiNfSm5L3Ws/a0uoXy7NeHxPT+DZS/WjruJFxmOJqH4EthylaERXyLggCZgBkWkGpLGrJY50JbNbFZw+KE7xysmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbbv24pD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314b316495so33761515e9.2;
        Tue, 19 Nov 2024 00:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732006353; x=1732611153; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJJ6Qh9/cJn/S1mD4JxORrTt4yPsQ4TBPTItPsiRXrA=;
        b=Fbbv24pD/1PmgJKcf/+ofFCe0irDiUA2XBc9nvmXvm1SIB48yFmhWMT+iOzXJtM/Gz
         6PpUQVrLDMoNRegQyzu8LA/3uQRiQc11zecx/KSibFe83Od+l2AkxqrgimkNfc/hEEo6
         yiWwqePjttRMhC3+XrFdSBP9rGWVy9Pl+fS0JLMJqSyk6UiDfOtPdr3xKGyv4wplEOse
         YIE03dCoLP7HgBAYtvmL2d71cOfDqIwyQUGTP2Hl5x6y6x656AA280zCpidJfPQuZr8d
         X9ILrbsBvZwgcR3oRwwhFebplSAU+rVxOA9c/0slSgcpYLFalPoLwk4fRZh0xwRMonKK
         S04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732006353; x=1732611153;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sJJ6Qh9/cJn/S1mD4JxORrTt4yPsQ4TBPTItPsiRXrA=;
        b=HHVAi66lFO6ythZp4kgld9RXlEHtzAuvkTbxYFMIXRrIJVbhnzLBOs8RNQp0Cv9aSh
         SnfAsv6+Go1gc6ltyGdJRtAgrkbJJfdl8da7Bf26xUu0VO81tgZRQ9ZiH+cd2KQ08bNU
         UuXxC6U8fcgzUjaAUSFcsYcCqX5w73sSDnyGX6GcUb26ucT9MdLOvJ9badP9Hw65IMne
         UOhX9XxdcmFlaOQaK6jHZs8BU9c0i6+cLt5HwWy0AaqjJVyla6j5XYDazsSk9DW0201M
         PzegJjobq219+YD+tItiqulbDbLx5JssgwyG7FZPmTn1bK5T5nIb145U4YKSJWaExbZY
         ZEHA==
X-Forwarded-Encrypted: i=1; AJvYcCWtPmNKyH8ebgNmdhbssYFQ8jk+Tu660E/nO8lGDyI+YUBFeH4kp2wBUlkXw65OexyWou6Pc2U+IEMCLfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuVMVr9mDOO6ExOtj1/wuT8M/FvORs1/cE6gD11RW2lpIRgZ/
	dCb97r6msBTvJl9gWGK/CWwGyWAgB+LLDPlY2yf87TMdjqd3vBPBGGQfDQ==
X-Google-Smtp-Source: AGHT+IGIEPh/1yaHnfAopF2mwL/6Z2kZykGcfp15AvtWpsFIO62caqpTfT2h9LdjwWvAjsa1DtcVgw==
X-Received: by 2002:a05:600c:3b20:b0:431:5f9e:3f76 with SMTP id 5b1f17b1804b1-432df74d896mr151575045e9.16.1732006352900;
        Tue, 19 Nov 2024 00:52:32 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80a28sm185160435e9.24.2024.11.19.00.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 00:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 09:52:32 +0100
Message-Id: <D5Q10DQM9OC7.3VR13L1UINUVF@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Sathishkumar Muruganandam" <quic_murugana@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: mac80211: add EHT 320 MHz support for mesh
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Aditya Kumar Singh" <quic_adisi@quicinc.com>, "Johannes Berg"
 <johannes@sipsolutions.net>, "Kalle Valo" <kvalo@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241119-mesh_320mhz_support-v1-0-f9463338d584@quicinc.com>
 <20241119-mesh_320mhz_support-v1-1-f9463338d584@quicinc.com>
In-Reply-To: <20241119-mesh_320mhz_support-v1-1-f9463338d584@quicinc.com>

On Tue Nov 19, 2024 at 5:27 AM CET, Aditya Kumar Singh wrote:
> From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
>
> Currently, ieee80211_ie_build_he_oper() lacks support for 320 MHz handlin=
g
> (already noted as a TODO). This is because 320 MHz is not included in
> IEEE 802.11-ax. However, IEEE 802.11-be introduces 320 MHz support and if
> the chandef indicates a 320 MHz bandwidth and is used directly as it is, =
it
> will result in an incorrect HE Operation Information Element.
>
> In order to support EHT 320 MHz, HE Operation Element should indicate
> bandwidth as 160 MHz only. In EHT Operation IE, the correct bandwidth wil=
l
> be present. Devices capable of EHT can parse EHT Information Element and
> connect in 320 MHz and other HE capable devices can parse HE and can
> connect in 160 MHz.
>
> Add support to downgrade the bandwidth in ieee80211_ie_build_he_oper()
> during 320 MHz operation and advertise it.
>
> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
>  net/mac80211/util.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index a4e1301cc999d24d6ab1bd899742a2ff04229040..c88ce537aaa7ea5d59dc42e5f=
30805c6eb4a5c6d 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -2762,6 +2762,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const struc=
t cfg80211_chan_def *chandef)
>  {
>  	struct ieee80211_he_operation *he_oper;
>  	struct ieee80211_he_6ghz_oper *he_6ghz_op;
> +	struct cfg80211_chan_def he_chandef;
>  	u32 he_oper_params;
>  	u8 ie_len =3D 1 + sizeof(struct ieee80211_he_operation);
> =20
> @@ -2793,27 +2794,33 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const str=
uct cfg80211_chan_def *chandef)
>  	if (chandef->chan->band !=3D NL80211_BAND_6GHZ)
>  		goto out;
> =20
> +	cfg80211_chandef_create(&he_chandef, chandef->chan, NL80211_CHAN_NO_HT)=
;
> +	he_chandef.center_freq1 =3D chandef->center_freq1;
> +	he_chandef.center_freq2 =3D chandef->center_freq2;
> +	he_chandef.width =3D chandef->width;
> +
>  	/* TODO add VHT operational */
>  	he_6ghz_op =3D (struct ieee80211_he_6ghz_oper *)pos;
>  	he_6ghz_op->minrate =3D 6; /* 6 Mbps */
>  	he_6ghz_op->primary =3D
> -		ieee80211_frequency_to_channel(chandef->chan->center_freq);
> +		ieee80211_frequency_to_channel(he_chandef.chan->center_freq);
>  	he_6ghz_op->ccfs0 =3D
> -		ieee80211_frequency_to_channel(chandef->center_freq1);
> -	if (chandef->center_freq2)
> +		ieee80211_frequency_to_channel(he_chandef.center_freq1);
> +	if (he_chandef.center_freq2)
>  		he_6ghz_op->ccfs1 =3D
> -			ieee80211_frequency_to_channel(chandef->center_freq2);
> +			ieee80211_frequency_to_channel(he_chandef.center_freq2);
>  	else
>  		he_6ghz_op->ccfs1 =3D 0;
> =20
> -	switch (chandef->width) {
> +	switch (he_chandef.width) {
>  	case NL80211_CHAN_WIDTH_320:
> -		/*
> -		 * TODO: mesh operation is not defined over 6GHz 320 MHz
> -		 * channels.
> +		/* Downgrade EHT 320 MHz BW to 160 MHz for HE and set new
> +		 * center_freq1
>  		 */
> -		WARN_ON(1);
> -		break;
> +		ieee80211_chandef_downgrade(&he_chandef, NULL);
> +		he_6ghz_op->ccfs0 =3D
> +			ieee80211_frequency_to_channel(he_chandef.center_freq1);
I don't understand the full implication of those two calls but I made 320MH=
z
work by doing the same as for 160 but with +/- =3D 16 instead of 8.
> +		fallthrough;
>  	case NL80211_CHAN_WIDTH_160:
>  		/* Convert 160 MHz channel width to new style as interop
>  		 * workaround.
> @@ -2821,7 +2828,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const struc=
t cfg80211_chan_def *chandef)
>  		he_6ghz_op->control =3D
>  			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
>  		he_6ghz_op->ccfs1 =3D he_6ghz_op->ccfs0;
> -		if (chandef->chan->center_freq < chandef->center_freq1)
> +		if (he_chandef.chan->center_freq < he_chandef.center_freq1)
>  			he_6ghz_op->ccfs0 -=3D 8;
>  		else
>  			he_6ghz_op->ccfs0 +=3D 8;

Something along this lines seemed to be enough:

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a4e1301cc999..f24479f74813 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2808,18 +2808,15 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const struc=
t cfg80211_chan_def *chandef)
=20
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_320:
-		/*
-		 * TODO: mesh operation is not defined over 6GHz 320 MHz
-		 * channels.
-		 */
-		WARN_ON(1);
-		break;
+		if (chandef->chan->center_freq < chandef->center_freq1)
+			he_6ghz_op->ccfs0 -=3D 16;
+		else
+			he_6ghz_op->ccfs0 +=3D 16;
+		fallthrough;
 	case NL80211_CHAN_WIDTH_160:
 		/* Convert 160 MHz channel width to new style as interop
 		 * workaround.
 		 */
-		he_6ghz_op->control =3D
-			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
 		he_6ghz_op->ccfs1 =3D he_6ghz_op->ccfs0;
 		if (chandef->chan->center_freq < chandef->center_freq1)
 			he_6ghz_op->ccfs0 -=3D 8;
--=20
2.47.0


