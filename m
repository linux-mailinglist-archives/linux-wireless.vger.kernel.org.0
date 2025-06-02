Return-Path: <linux-wireless+bounces-23531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF79ACAB2B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 11:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4207E189B27C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11942A92;
	Mon,  2 Jun 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iph3gcnO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6A1DDC37
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748855124; cv=none; b=GHUaXpMSksn/UdVOXikRaavC1PSdyB3YFrrJpN/xgHEJ9KOOkeszmeq5ZV1ECrMgO0nXPyIpOQS7w9wx2KIi34y8JWXgz4WlgTV/4MlbOhSY5RTNCVjAh9epN5r6sBQJ//y6moBX+ACjWFlA//kIN7FASKI7Ju31b8FOGQwsmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748855124; c=relaxed/simple;
	bh=dVbI7XdFVpRcPmf62+H8zFIC+HYdsRQ2dDPaf9FJdT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qZNsPTC041H1TwkWKw5EyNTrMg4LIKzmHvSwJHwKWmFcQtZptKVe5Mac+QX7mDy/O302V9Ye4gAKPsWS9GYDDy8usUWviohLlN+OzGfPyf3/3Xa+pTfrOF0vVxWXyJA+ygwZmM01BBcZsPiPKqzW8ik2th87bPIz4hiy0VWDIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iph3gcnO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441c99459e9so26826435e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748855121; x=1749459921; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOf+PkyA5GgMoeVaDLySq++0gYfNwU+cfdIdrQGlBDk=;
        b=Iph3gcnO/IJ7qllinio9ZIag7m01Q3j5tt5rapYCZZNanEEOrOTiq9QaZ1aaBwIv2U
         fgQsl+ULZ/Cs3yU8gprtDvbRfzm4XpDfJrbqmnOahUwpagJAcU+IAG8Y/VeEHS8pf0AJ
         dcKwcwaD0+WS3fTekofC9+M3jbYi3i5GUCBi+iIYGUKOuqbad5oJzFT6Nr1ffh5JWt2J
         GuaSYfDbUck/VBdF4LGOiCSKtVS7gT5PrVlaRrCYTuJTseCDCz8Vgl861LjJ5GjIvYDW
         XojHKDddxs6DnWGyn4qk9bogRFzVbHIPL6mf1LLzjogLfyuQ+DmrDwB8c9YPtdCZ9aYU
         bH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748855121; x=1749459921;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UOf+PkyA5GgMoeVaDLySq++0gYfNwU+cfdIdrQGlBDk=;
        b=HAVhRCYyHHI8o+WgawjXekpM9UpZOAJS/m+JyTf0U4r57dsv5Pdje2vw3tji6ltrt+
         kD5ueFV8eAyoaJYPRN8+KQn0vtnl7+deq3mKq3zWIoSVmq4EEjhL1F9kGRsvKJsjz0F0
         hkphKsSnbU81IrRVaIVigMMqI8G+1k/m3m1E32VPM8AzW4Gu0pQV9dbe9IHxk704wS71
         UraAosQGRs/r+Uefx13fq7jIy4QlD/Q7RX/TD9dxi7PGM+SrM0r2UA+uuE2f/dSXEOEg
         ID9ezcY0pVZ4BE4vLsD+zHIaOq0+QMyMJVqrr75NAJ3MSeVHSzfAqN6D/rTnznL6KAYS
         YMsg==
X-Gm-Message-State: AOJu0Yz897C73z1UHKnJL59UG0icZN+hTMMe/B78KLSD+49xWZZGxUTY
	w2g24UgVV2PxRnB+v870VqXj0dlRO0sQ/EGm2Dg+0vFspgcd6uKYDkDgoVuTzA==
X-Gm-Gg: ASbGnctLXBNCJx4vKbiu5jhQhuISeZ69MJuIyN+AVlrtGZJ/8fa+XVFGBBvsryNeXrj
	r+/L4INFKzZCxFQ4TJpYFHLfAspob1xKosjat4Cn+s1oJ8JRBk+CzyfK61vPsty+PgBIjtBFuXA
	yxal0fagKJnRaQhiXPjmVlhwpPHYHHEziRwvzDYGdT46VslkIw+mj+v37FooHrfSPPbsf+oW1qn
	p9TeYYJvSUV+6r8ddnZbE9SbpBeySY1mKm7L0spLcMtfCYKyERRsFXBHKjt0w8SGTDs16UMjol0
	GIYPHbcHMuSwcqOyQ+JPI0BI/LQuyOAp46EUTlKbxEU8xCzAuxNsmN9o6nz87C7s+x3s2A==
X-Google-Smtp-Source: AGHT+IGuYWcDUv4A6KOpnkgns5eFzZREoCd+HqPrUTZjIoaRW2oxarhH3bJFNmGlcRQWXrWQyeSOMg==
X-Received: by 2002:a05:600c:4d82:b0:450:d6d4:9627 with SMTP id 5b1f17b1804b1-450d6d49672mr64727295e9.29.1748855120699;
        Mon, 02 Jun 2025 02:05:20 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb0654sm114324955e9.21.2025.06.02.02.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 02:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Jun 2025 11:05:19 +0200
Message-Id: <DABXEETZP415.3EDDINBHDH42A@gmail.com>
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
 <DA2JV34RZGAQ.24P9Y3C865UHN@gmail.com>
 <b7d500e3-445e-455d-a74f-4ec3c7f3fde3@quicinc.com>
In-Reply-To: <b7d500e3-445e-455d-a74f-4ec3c7f3fde3@quicinc.com>

On Wed May 28, 2025 at 8:16 PM CEST, Pradeep Kumar Chitrapu wrote:
>
>
> On 5/22/2025 1:34 AM, Nicolas Escande wrote:
>> On Wed May 21, 2025 at 11:38 PM CEST, Pradeep Kumar Chitrapu wrote:
>> [...]
>>> Thanks Nicolas,
>>>
>>> I believe IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ mean only
>>> 80PLUS80 not both 160 and 80PLUS80 and STA must set
>>> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ flags for indicating 160 MHz
>>> support. Please correct me if my understanding is correct. However I
>>> agree that we must allow STA to connect irrespective of which flag STA
>>> sets as long as bandwidth is 160MHz. I see ath10k and ath11k also allow=
s
>>> this by setting default phymode of MODE_11AC_VHT160 for BW
>>> =3D=3DIEEE80211_STA_RX_BW_160 case.
>>> I will make this change in next revision.
>>> Thanks
>>> Pradeep
>>=20
>> Hello Pradeep,
>>=20
>> Well this is quite unclear for me maybe Johannes or someone more aware o=
f the
>> evolutions of the standard could shime in.
>>=20
>>  From what I've gathered:
>>    - the naming IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ implie=
s both
>>      which points it was the case when added
>>    - and the original 802.11ac-2013 Table 8-183v states:
>> 	Set to 0 if the STA does not support either 160 or 80+80 MHz.
>> 	Set to 1 if the STA supports 160 MHz.
>> 	Set to 2 if the STA supports 160 MHz and 80+80 MHz.
>> 	The value 3 is reserved.
>>=20
>> Things get complicated after:
>>   - later versions like 802.11-2020 have deprecated value 2 in favor of =
the new
>>     Extendeed NSS BW feature
>>   - Table 9-272 still implies both 160 & 80+80
>>   - Table 11-23 & Table 11-24 implies only 80+80 but both talk about the
>>     'VHT Operation' Channel Width field and not the 'VHT Capabilities' S=
upported
>>     Channel Width. And thoses had different values even in the first AC =
amendment
>>=20
>> So it feels like when no Extended NSS BW Support is used (first gen AC d=
evices),
>> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ really means both 160 =
& 80+80
> Thanks Nicolas for detailed response.
> Request you to kindly review V14 series and let me know if it works?
>
> Thanks
> Pradeep

Hello Pradeep,

Yes your new version fixes the problem for me.

Thanks

