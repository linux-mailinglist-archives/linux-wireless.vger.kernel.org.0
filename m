Return-Path: <linux-wireless+bounces-29120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B65DC6D108
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC3BE385A94
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604371ACEDE;
	Wed, 19 Nov 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfrQOHdW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546826F2B3
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536559; cv=none; b=AnCSTj6WiXjWmnxpy8qFbKp2lZV7yPZFdOyXJKzqg9y0fSVRDDUjHcAGAwaZB5U5SeaFxCxR/bLPtV0h+UUC7CfGOIA26TRR7ntVOHF1+XJQ4DV3v0QjXRHcEbUWEAsSqGZ0Mr9Ib/3QIJLMlLiJwcVsGcJDAbFRJ5iIuwQf4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536559; c=relaxed/simple;
	bh=+Q919YY4UaKLS4vXXdAXFRmjV2PpkX6QxmAkc/GjHSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2njWzIJprfTbVNZ0g1NUucolgywCnn7Vwk7Zf/iCFrz4xUcjVoSRioVzfB6bW9zRTHbur1/D204xOCnnolyKT7EUz4ryVFq+pdFZQ3s25sWe8yYteF8eTUjqiWbgkmQaBb5f9FrsMv4sM3tZGkfFqTiBdPghZVZbGyMO5uyFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfrQOHdW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2980d9b7df5so68598905ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 23:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763536556; x=1764141356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Q919YY4UaKLS4vXXdAXFRmjV2PpkX6QxmAkc/GjHSM=;
        b=hfrQOHdWV2LH8S1ugvVHw9WOOao4sFaBgYGWNcf8UYlU9K6rajMc8kb4E00N4O8ACB
         e09D6pXM4fvqcDUhxwPx8QcPyTedtLoZ2phZ06vDFieJwMVcxs8y1UHCUU/bIxNhD1Aa
         bn7NA1/wrfAXEP1R9AVO2iD/BW1cYt8doHJpvVo/zXr/WlZwg1nPUUjODeBRLsfWmdc9
         FC0stYXAMHNI85VW9VkNFl2f07o1oab64QZFA3uY2RQIgq2qD6amMBF1rpXK/Y460ZeI
         XBrL/GUmNGj3DzsEbKxjP2fVUER5dBRuEAaEsuy34Wd1Us5fyMwCNIrzrcCj4NVgUUka
         5fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763536556; x=1764141356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q919YY4UaKLS4vXXdAXFRmjV2PpkX6QxmAkc/GjHSM=;
        b=BPEJjkOGfkP/Ys+M9DMf6HNcEyhxHxWa54yoWEdCPYiyshLAdFw4Ugw8avfcz/lmPi
         VZ6+Bkowam5dMRh6RDLJwluzgpvvxySNUQG0YI2iBhxAAiJfqKVaIXjV+Uld+rF5Mzia
         Lvgc+OYMx06yCm1Ef9bvedQNnlTqfNY++w/jIWkKxlkniVKwnhQIW8561xiw27X13fCV
         6muhLTa5yYGk0+iHsZ8+f9w54iVW9z8w0RotT+Qls/Mu2rv1MOw6BpzNsvoiPqDS7iM7
         gYtzdA2YFjUbtX39e2xevNVwwUuEMyg2h7LRA0KEGQIhkxSbdHsGKfd0prEMlFFU5DUB
         yKUw==
X-Forwarded-Encrypted: i=1; AJvYcCWA9sTOxFuPGcf2xukhQ+q6r4OSbWUzZM0Bui37HzlpkAM/MUbSkPyLjj29Qsed3pXQuv/P+lblWMRSR/PFaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbw29b0BA0elhQqoB65izqDgB66jPITN/zYrfrZfA3jesTfXw
	IjxCV6gASPcD81n753Io1BTPtbv5iCHfsah9sqMiIPnqDUsftv8MFDV8
X-Gm-Gg: ASbGnctPxTdf86rHEY4mwPNswuhTxLkSoY/iqDLyjIC0x3iPUNA0GwGGLQnYhYzUaRm
	pLq0lT7L7d/n9Mpz+aPJWLlmXY+fea5pztMM1fJvezMzD+PmUdu8mMmYzx67g0xmPpM6vGtwW4A
	VzAQtspKayD2DzD9/Va0OmC/EeQa81inO//mhjNh6XyMAa+QaEK5xpt5H0yG0+li4iP330dm6uS
	XbIg5JB9AhChYoBxIFnuQRmAOR+D8am4aWgwHfrsw1CGhuVRsitKGL/EipObDDVVaCyiWWInyWi
	7epChby9W9lJjD18uwwDyf3xwugjOzJ331d4ihNke4QB4tfgq3DBTLhUhoMu4mlrYsDu9d798eG
	zbDKN0uuxdPjlawvA2gATzYsT7AvlA1jknuB4bUnTLkRvfu7IKNT7HH13DnVCMYK5xFwipil0kl
	h0DaYwRtohpl+a0cddLXwu68xqigzh22rj2KXb6ug6+OZRVRTo50QHY5egAUBcJyWFW76M929Ym
	nBlwQ7BBs02
X-Google-Smtp-Source: AGHT+IH/iUQ8k8q5jtZzLfjEzHUKUb772uSPLdrKVRVqRGDk2k6QnX5BocvtI856ni6peH5IMOtroQ==
X-Received: by 2002:a17:902:fc86:b0:298:3aa6:c03d with SMTP id d9443c01a7336-2986a76a3e1mr216602015ad.57.1763536556432;
        Tue, 18 Nov 2025 23:15:56 -0800 (PST)
Received: from ?IPv6:2401:4900:60d7:2218:52ea:a17:db14:a44? ([2401:4900:60d7:2218:52ea:a17:db14:a44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c253b30sm194118615ad.46.2025.11.18.23.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:15:55 -0800 (PST)
Message-ID: <5d56bba8cc4b48ad61042e9ab7063be856a6565d.camel@gmail.com>
Subject: Re: [PATCH iwlwifi-next v3] wifi: iwlwifi: fix uninitialized
 pointers with free attribute
From: ally heev <allyheev@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 19 Nov 2025 12:45:48 +0530
In-Reply-To: <DM3PPF63A6024A9184DD38E41273FC35C7DA3D6A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: 
	<20251111-aheev-uninitialized-free-attr-wireless-v3-1-26e889d0e7ee@gmail.com>
	 <DM3PPF63A6024A9184DD38E41273FC35C7DA3D6A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 20:15 +0000, Korenblit, Miriam Rachel wrote:
>=20
> > -----Original Message-----
> > From: Ally Heev <allyheev@gmail.com>
> > Sent: Tuesday, November 11, 2025 10:08 AM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kern=
el.org;
> > linux-kernel@vger.kernel.org; Dan Carpenter <dan.carpenter@linaro.org>;=
 Ally
> > Heev <allyheev@gmail.com>
> > Subject: [PATCH iwlwifi-next v3] wifi: iwlwifi: fix uninitialized point=
ers with free
> > attribute
> >=20
> > Uninitialized pointers with `__free` attribute can cause undefined beha=
vior as the
> > memory assigned randomly to the pointer is freed automatically when the=
 pointer
> > goes out of scope.
> >=20
> > It is better to initialize and assign pointers with `__free` attribute =
in one statement
> > to ensure proper scope-based cleanup
>=20
> As this is now in discussion (https://lore.kernel.org/lkml/58fd478f408a34=
b578ee8d949c5c4b4da4d4f41d.camel@HansenPartnership.com/)
> I will not apply it for the time being.
>=20
> Miri

Makes sense. I will wait a day or two before making any changes. I
think the current consensus is on making the initialization and alloc
go together?

Regards,
Ally

