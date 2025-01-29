Return-Path: <linux-wireless+bounces-18126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E10A219CE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793F73A6400
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A969F8462;
	Wed, 29 Jan 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agcWJUJo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992A1A9B40
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142646; cv=none; b=PN5YP0L1MZkRxNbG8fXD3UT76WKhmxtZLqg/co0+UdnR2wpgV3lg0U6Txjh2Zx0uNpkv5yMfwXTZorBMYgriHn7gUQzy5rwqn3ztRmyy97NtTl3iPz6UJ8rxeg/cqAzRf2CqsGDn916QzKJHzp2x4n2oTYRZ8Kaz6i+LaZrlQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142646; c=relaxed/simple;
	bh=erM6ZljNSp/CnAww5r95719IE7Of9EuPxjeASyRZrHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=SJVnhpxJpAOU5Mhgo4h8Xo4rLshMM2vFyxMSHP9pNhyhDQaSBUuPqtMs573KNQdVDA87cbzPZJn1MFWpvxnT+OFNwqZcm7N8G8AQV3R/2yDbIj44VdOgkt+/rJ2osPwtZt5HZvJHzEWZh2K+tG8CdLff/VjUs3BjS0EKZnjPi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agcWJUJo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863703258fso273815f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 01:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738142643; x=1738747443; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lihPpJHFlhu1T9GX5rKbX3/sLgkFoYvwNag8T5iMjEQ=;
        b=agcWJUJoYHTmUZEau9LICtvaHyRqeCHcUKdxAbYU/7TYHH0X4cItovYWgWxd4bqKrx
         u+otlOIFfVvsbObfG1MEP3TXmNr+kK7E2BaFA0Hb/Q/LV3PfxmrtAbgVIfonR4O5sjyc
         MZrSWHNHHij5OKzVrG8P8suomqZlLXJEyivydRgbWMvE4zVuFzyxs7+0T6Ge/HTcAK3Y
         oac5ZSOkVmTcHJC94Wsu2cNc+9NJTBotIg+na0voWRLOXLmg1tPXCwD9vqXiMGr3RWtJ
         nJiO1PF8EMTd+V6St/enLx3IJq5Z1KhZXo6o9p4fi38ud2HKAb3NygnOxRIVuKUrE6GC
         Hz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738142643; x=1738747443;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lihPpJHFlhu1T9GX5rKbX3/sLgkFoYvwNag8T5iMjEQ=;
        b=GR4CnaoBNluMXDF+NVolNQpfkAESaqFwuWz8q8O/UgIMJBqfaNpZ3YqGo/om9MFabt
         Kpsk+8FGTIkzAx/bcA0vXKfPKd7pTFdWUbVXYTKDrtKcHYFRIJCGcaelQ2XbHELUDDWw
         4PSWBdQuEmY+tylmhuK6QI3F7uf4VOBbHI6rwwGxqD9Wkl9fjGR0So32uLKVmJKkG7p7
         av4UgN69zd0jhdn+zmq9x1vdysms17G/i7ps5+h96LgJQTYAVTDijG6ZemRMm1UVr64e
         sbYC7A/09B614trRlZinhzSU/3cJ1s2Q6obuWnL/KZutH0aFhmBtFG4PGB1LAotWU0Ev
         I6+A==
X-Gm-Message-State: AOJu0YxJVPRLjfi+nQNuLNwgDd2RlIKsp2hEyuTn3v7Wb1hwW80lobkX
	e30VK/Dz1gSVSjD5YtgHLhEBwIDS+qdMyJIbX3a1ic8VqbyDptbAbwEk6A==
X-Gm-Gg: ASbGncuDliKtZ0egmowQzewZlOWBBzaWiidLp6b0zlSNv6SiGkwtXCmFcO6FRHa38uR
	d9ekSUCnOk3R/YT5csVt8mUeR1qcCT0Afdo0uMkDTsWW4/Dm7M28w4i0Nl0C7LfLoRK6Kip1QC5
	NNITyPpSI9DyNTTAtxz3jpXZpo6od8skRWUwONYkxacLgNfLZUPmkKnkBfS3b5zDgPg8xNfZrLl
	kLSQTzspNF4Yz+M5ey+FCNADKOHJiaJTS29oIilkoeT87stVt7xSGJKtknmXjBEeVueSQE7TDvv
	grbRPe6fq+ewxZhxLPVABVQ+oYW2fX8brw==
X-Google-Smtp-Source: AGHT+IH4Y4nWWV0fiFq9wMrFsPxfI+tlpUXenEohsMWeQWv89IPcCB4aUODTmHi762tZVXXaRACUYA==
X-Received: by 2002:a5d:5982:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-38c49a26177mr5242204f8f.7.1738142642823;
        Wed, 29 Jan 2025 01:24:02 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2a96dsm15705645e9.19.2025.01.29.01.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 01:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jan 2025 10:24:01 +0100
Message-Id: <D7EG56E1I0SX.3BZRTM7N6CQ44@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 <ath11k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250117181953.3375273-1-nico.escande@gmail.com>
 <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>
In-Reply-To: <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>

On Tue Jan 28, 2025 at 11:29 PM CET, Jeff Johnson wrote:
> On 1/17/2025 10:19 AM, Nicolas Escande wrote:
>> Commit b205ce4c266c (ath11k: support avg signal in station dump) added a=
n
>
> I'll fixup this reference to address the checkpatch error:
> ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+=
 chars of sha1> ("<title line>")' - ie: 'Commit b205ce4c266c ("ath11k: supp=
ort avg signal in station dump")'
> total: 1 errors, 0 warnings, 0 checks, 8 lines checked

Arf I can see that the commit format is wrong but I wonder why checkpatch d=
idn't=20
arn me. Do I need more options set on the cmdline ?

	scripts/checkpatch.pl mail/0001-wifi-ath11k-remove-extra-rssi-update-in-at=
h11k_dp_rx.patch
	total: 0 errors, 0 warnings, 0 checks, 8 lines checked

	mail/0001-wifi-ath11k-remove-extra-rssi-update-in-ath11k_dp_rx.patch has n=
o obvious style problems and is ready for submission.
>
>> extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
>> when it added the average rssi support. So lets keeps only one by removi=
ng
>> the legacy assignment so the two statements about rssi stay next to each
>> other. Compile tested only.
>>=20
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

