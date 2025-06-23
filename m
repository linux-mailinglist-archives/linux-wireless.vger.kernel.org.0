Return-Path: <linux-wireless+bounces-24374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB7AE577B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 00:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C78B1BC828D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77A223DEF;
	Mon, 23 Jun 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaCyt8im"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BB70838;
	Mon, 23 Jun 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718181; cv=none; b=H3PEclHwixrzZxHM69mGK8ej1ckedhJy2+bjY6ZLgu9OamkiWuwspRwvv4HR8EO5dfOnx+LeUf0lhU9EJ5m09iCtGBctsLh68vOJb/ySAnk4u9PY6ykq28pFdn2xO52661VKDpMwyDcsseHZBYs5NY59FOOX/W+zW/OO6It40tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718181; c=relaxed/simple;
	bh=VMqjvdqjYjwE3uE3p4fOORmN3YUCuI69v1hvsEPa/as=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PVyXeXAjRUd4IPeWe4nMmnncmHUnNqcC837sG9gGaqkHitoMxjBfP6bNHuRDpG0hw8SCj0kBawz6VYdppoNJbUxdSTO5KU2d/5bPwKfSaEWFHtK2aSwKJkLxzAbDPuA8tkowKleL+NJmbj4bX9JgnlPgOIJROhLkKKT0/ckPny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaCyt8im; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-235d6de331fso67295835ad.3;
        Mon, 23 Jun 2025 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750718179; x=1751322979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMqjvdqjYjwE3uE3p4fOORmN3YUCuI69v1hvsEPa/as=;
        b=RaCyt8imbpjdfN3GsDqDfCAnqLfRUO/ETgsHdiqsJfQgZqxAhecNkz/U0bebUYeyYp
         URnJvb5qOQKhr3SaZYk8c3CwPFiD+n2TOvMlMgmiQFPfdTWRCZ5j34XEN9yshEeKnvSZ
         z85e2/tpBWLEQjWdeNulZAnkHbJkhAKlU5iFO4mykoJ6ghDBk6h0SQ1aiDQ+BvzhK6Jp
         QJTB+o1/PtI0kJzP7k1ZpUgGC3l9tBtnLBymsAhciurJlfBLEXHLMRmAU5axFhE6Zlsy
         ezN3kAABQB3oeH8pE+15RddHzoojbBHqtOW5JR8h8Ky2qyDzZrEw7rbY6beckR+zvF3M
         J8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750718179; x=1751322979;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMqjvdqjYjwE3uE3p4fOORmN3YUCuI69v1hvsEPa/as=;
        b=ZJ4RXmcOlm0ewnc1x/JZxIFOz9Q1NAKcyRcAeuMkZytLkwOk2gdUo3v1OO2/qwV05u
         /dApYQ+AyBo97vNT1ovfwlY2DrC2/xkoeBCygbvo0jw98vbAMgSca1XxyKBEKsLnpBzC
         QMR5FPLQkzPBG/7KRIjpwxqjbeD1lltLwbt7onKixUwCNrBJCt+6KPwekxMOZ85pKsxs
         2cedsdXK2ruPOencVb2Yi9Rh44aXr4cxPm/4mQWdHOnHhXxzkKSOjurOwTJXlKxTwqGe
         k3eT5DR/CH0sFigRgptWOsO/TBMGsilN6Im5wdbchwQsa4oO7JlC48As8maVd3M90NCY
         oLQw==
X-Forwarded-Encrypted: i=1; AJvYcCV4IltdrqkZfC69VDpRHzoAnOMbsG3+4q6odlBJ3zAFEsa3dWkb6N3KoqpLlq/cGhhSuwt9OxElhr5TybXlyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pB5kLkI+kwSNp1LuTBURwHwWCiTTrdoGBJv0uRB1XK/6dyRq
	ZD1Greez9ZttUrG3zu30MmMFuzEi8u464QBqbH/8TzVW7ur0AJwJceas
X-Gm-Gg: ASbGncve/oYWlBuEWEKFKepKF0S1Z3JQhv6luPiZPofpF8pMA1NNSrclMWdcDhdZr4P
	iwnnJL3suEp8N1xC12LAm4mUUIWzT6ORHoNH7y459zhZAFQNLaM0F96Fx/pGGlwHxdWZTSPVoc5
	ZZmc2XM2aBmLpFKutkjqrfBnvjGF6sXZ6QGVFYYbD+KzpZ42BFubzIy4tMehXCxVJc3jhG7iuHk
	tGYVhJCWO6Jh9YsXxBBHTmannF0wEtno5QCSv4uo0Txee2rW7tra9O7mwyZxGPHdYZyWcvt8xvB
	UbSrWKsSHftyCR7AVQ1UV/bywpdSeDzW5cCmCDmJAkMXbX6UNW6oOPlbpL3soNq+162I3j4e7Dn
	P4Q==
X-Google-Smtp-Source: AGHT+IGiVCAqyMHQ0aUFxGZw6AWg0MqiQazeu7JnOPflkRiJ+eMoHJV1tXkOWbhWH0g+7MB4gsek8w==
X-Received: by 2002:a17:903:8cb:b0:234:de0a:b36e with SMTP id d9443c01a7336-237d9bd9bc3mr218762735ad.49.1750718178827;
        Mon, 23 Jun 2025 15:36:18 -0700 (PDT)
Received: from [127.0.0.1] ([115.187.48.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86d77b4sm93201365ad.205.2025.06.23.15.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 15:36:18 -0700 (PDT)
Date: Tue, 24 Jun 2025 04:06:13 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
CC: stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bath10k=5D=5BQCA9377=5D_Firmware_crashes_on_Dell_I?=
 =?US-ASCII?Q?nspiron_5567_=28IRQ_=2316=2C_all_modern_distro_kernels=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <2DC25FD4-0EA4-41CE-BA17-BFF84C1C5F7E@gmail.com>
References: <CAEmM+Qh=8tm55Ypa2w3ZtOFFrGXTpKqxue59mVAo_5TVy0RJ6g@mail.gmail.com> <CD81F065-CDDD-41F6-AECD-167B509F57C6@gmail.com> <2DC25FD4-0EA4-41CE-BA17-BFF84C1C5F7E@gmail.com>
Message-ID: <690B1DB2-C9DC-4FAD-8063-4CED659B1701@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Resending this as it appears that the original message did not reach the at=
h10k mailing list=2E

On 24 June 2025 1:09:54=E2=80=AFam IST, Bandhan Pramanik <bandhanpramanik0=
6=2Efoss@gmail=2Ecom> wrote:
> For some reason, the Reddit link on troubleshooting the firmware leads t=
o nowhere=2E
>=20
> Here is the Reddit link yet again (let's see if it works): https://www=
=2Ereddit=2Ecom/r/linux/s/egXvRBYhYp
>=20
> Apologies for interrupting more than once=2E

