Return-Path: <linux-wireless+bounces-23274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF36AC0733
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C6F9E627C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D10F223714;
	Thu, 22 May 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/J1XnUb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D51B0412
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902896; cv=none; b=dLQrAnvbEtLtgCPOFGmypUsXSpREv6z0/sglZCQ/y7o8c1rZK9UQJmuw6rzfkEjj8q/GMF+fWf/iyQ0wKJQjkucXUZQKFsum8N0kExh8yaGnr+PHsER5kNfx6K6nXGxSnBGTibyf62fEdPJqWPhboyckzxh740AZUOXlIRGbC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902896; c=relaxed/simple;
	bh=UAR/DjT7nqs4XRth/rm2CG08CFNDXmdmHDGn+ONEAMM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OuIGi0g/WP7rmQ7+277/xeyPFm7KUGHruPYsoqzEEHQvJHEzt0hgkNSyWkMs4VatIFvIVSIjTduA4RiH83yvYniy/wam5Lh2FoacofBJI8HPLOC2L3fYOLdE+GvJIYveQ1VEEmbG3G7QjZWgSvcY6inXxC9hSRX88xgJEyd35ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/J1XnUb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0618746bso62740855e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747902892; x=1748507692; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1fTB/swNzWWmYp5oJCHFgWQwcocMbpiQpoHyf5EFUE=;
        b=D/J1XnUb4U+70hjzQUj9a5t4z7VtdZ87lLmz79FpHhX4akxIad5FiHOkUbenh1hztq
         eqHEG2ihOyIsTfahArmPkZWuAIx9fpsHcph91gMCDy98XgirgoxPwpwWaHh/cKVl4r/o
         ZbwNHPgDZIXlJtzqiXVkIiZUH5BKTtkJn+UtzP/fAGE4R+uEdBPWDazPKh22/CMm+UM4
         /9hh6N+AiRnV7KGFFyr2/hs685t+rFQE4ALVSkFH51faAMUF665yXGJunuQPMD0jCG6K
         g5KRhL33vo46nEcR7Eh4X0oc9u8UMow0pDAtlLD89dgQumrLVgs8t1MSoJynNA9SACTh
         BrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902892; x=1748507692;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b1fTB/swNzWWmYp5oJCHFgWQwcocMbpiQpoHyf5EFUE=;
        b=nBIEYTrwyEddqqOMNcKrVTlnzNWudAu/+ed4pyuFJpOJKG0ZV+z/9180109F2jKI2C
         /67YsVoqKirqFpqKmJicGHKvSkgvCoKih4WRKYFOb1Yuhqd3b1LgGQ1S3rgOLn0lWUdK
         /ogYBiIj1BVJdb2EYJX23RwJUXFrc1lJFSIZH8Omk/6eudvuRLte9TOend51iR7RzTob
         5w9jVIv9VTH9ggK/TF91ENFYt7CP0KFxll+cTsYCEtEI6/qQhhLiyEQ//XUD1tC+q8sk
         5WS9sFzK0oeBRuHuaknrIdOfT+8OvN/NNR4kDOYQ60TSvoNTXXEnh1ozfNosxrrd+05N
         tYfA==
X-Gm-Message-State: AOJu0Yz8YlAafezo73CWKyd9s/Ob6diKo2trg/bGwm5GK/e2a76QJH3M
	OYJAxP0+fP/hPfUqLFAK8HReiIqNXd/Bn5JxA7y08KhFAtlrFPqnFAO5POa5Tg==
X-Gm-Gg: ASbGncs9IpQP1UR4aDn5DzeOlDin0bAmTogg31oJeF2CpM+Uq7WvXUyIQMNZqID+J/l
	SOgqA/5yKgCDtixNnBNXD53EjNQVlbELWtSNM/rcC/zrVUB37P/MSibbq5nXYVTcn/VoFxh1/Ud
	fCc5VN65FNmiuSVs62LI+c81e/wUg6icHa9mvKxPnj5iX22EKYY95uZ3J8QtoD9oHbGSR5/f262
	j/NqncNiHSW7nj+b0J9PHzJcmjYhqiG+q9BfV6axJawTJD/CvEyPCJJ/9HFvat2Uep7StckuUoW
	wUCO38+tGssjqq13po66LPfY3s5ozae+E4O5i7aKJwC5DmpYq0cJvkbQVhHS1DXViiJmnQ==
X-Google-Smtp-Source: AGHT+IExEwr2NroN2VTAq+V2IZUILYxrbMXqDlsfBtFCfMOb+ACjpmRjVcpe7vA5cSdNaULw15JVXQ==
X-Received: by 2002:a05:6000:250d:b0:3a3:76cd:3e83 with SMTP id ffacd0b85a97d-3a376cd3fd3mr11183064f8f.23.1747902892399;
        Thu, 22 May 2025 01:34:52 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aea59sm99321675e9.25.2025.05.22.01.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 May 2025 10:34:51 +0200
Message-Id: <DA2JV34RZGAQ.24P9Y3C865UHN@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "P Praneesh"
 <quic_ppranees@quicinc.com>, "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH V13 8/9] wifi: ath12k: add support for 160 MHz bandwidth
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-9-quic_pradeepc@quicinc.com>
 <DA08F3TG062A.151WKWWF5OPL0@gmail.com>
 <c21146ef-3cf6-4d8e-a32d-8479e4d96f3b@quicinc.com>
In-Reply-To: <c21146ef-3cf6-4d8e-a32d-8479e4d96f3b@quicinc.com>

On Wed May 21, 2025 at 11:38 PM CEST, Pradeep Kumar Chitrapu wrote:
[...]
> Thanks Nicolas,
>
> I believe IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ mean only=20
> 80PLUS80 not both 160 and 80PLUS80 and STA must set=20
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ flags for indicating 160 MHz=20
> support. Please correct me if my understanding is correct. However I=20
> agree that we must allow STA to connect irrespective of which flag STA=20
> sets as long as bandwidth is 160MHz. I see ath10k and ath11k also allows=
=20
> this by setting default phymode of MODE_11AC_VHT160 for BW=20
> =3D=3DIEEE80211_STA_RX_BW_160 case.
> I will make this change in next revision.
> Thanks
> Pradeep

Hello Pradeep,

Well this is quite unclear for me maybe Johannes or someone more aware of t=
he
evolutions of the standard could shime in.

From what I've gathered:
  - the naming IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ implies bo=
th
    which points it was the case when added
  - and the original 802.11ac-2013 Table 8-183v states:
	Set to 0 if the STA does not support either 160 or 80+80 MHz.
	Set to 1 if the STA supports 160 MHz.
	Set to 2 if the STA supports 160 MHz and 80+80 MHz.
	The value 3 is reserved.

Things get complicated after:
 - later versions like 802.11-2020 have deprecated value 2 in favor of the =
new
   Extendeed NSS BW feature
 - Table 9-272 still implies both 160 & 80+80
 - Table 11-23 & Table 11-24 implies only 80+80 but both talk about the
   'VHT Operation' Channel Width field and not the 'VHT Capabilities' Suppo=
rted
   Channel Width. And thoses had different values even in the first AC amen=
dment

So it feels like when no Extended NSS BW Support is used (first gen AC devi=
ces),
IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ really means both 160 & 8=
0+80

