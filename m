Return-Path: <linux-wireless+bounces-15084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4959C0776
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A35B21660
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AE1EF0A2;
	Thu,  7 Nov 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT8EEkG2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A01DDD1
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986221; cv=none; b=MWveoPqn1QUrxLo6w1E11nnR3Bf3+l0lAtWfz404ZcGh0RO7zmOXlnFazGrQf9ThF63Ywez28snDe2Djn8efbUFPnKFPKdm4eiNJV/SMdp95/bvZEMGiHDC/eKOmdJ8vvOU6MsVXLatoSsZnM39kRoO+FWwu3wHdZVDl1uWOwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986221; c=relaxed/simple;
	bh=EdUHy+dJaT2hjot9BfU5nIFtHsjfeKtMy7/W74D8iDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxyCBMTiNW2tcTOFa5P+rHYfEYO0Cfl053tebiNmPP0r9Ax/k+nVcpzplZMIsOfnErALiPvXfyqxS3GX1NORQvyNQyYKktl6lo+Ds/B4I/QJlFHt0WK4HOa2wttRxfX4YuPhRBafF26qCCPDQrlVVefMC3ysh121lmr+SD5S3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT8EEkG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001CBC4CED2
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730986221;
	bh=EdUHy+dJaT2hjot9BfU5nIFtHsjfeKtMy7/W74D8iDw=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=jT8EEkG2MOmhdwILypbKO2JgvVuLL2Z3GlKsn3sB3HnrOK/NxM4eMCj9BxtAplynJ
	 O9xUxyYAzeE5w1d9poy4UgUq8HEXGvDNcsjlmvjTDOkZWqoLHIr3dyE2m9Z77FMvZA
	 CwloSZwyXOzpiSTXq+lkVccIVcZgXfSb+EhCYQG/6tBJRhPOnXNE4IIb0o1vEkxZf3
	 3gNdw1omujeObgVIzeJrkvQez17sN/PqjiqKH7oU0pr05gVfLwndSKa0/Na5Sj77aI
	 nuLGJxH1TQLw7M/KmIbIHI4qd5r53hc6lDzxe6uzFYOJdan93GecfgfqH18zBOeQkP
	 HAIKjy0KFJhBA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e9ba45d67fso8908497b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 05:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgm8r3TWS2q1IDF1/RnMKD4wxyVGhqe4SjCwGECQuJhoKWVzkXfHToLxEXi77K1Ho0uDDiQOZrGhx9iaZm3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuF5TxsTY5Z27+g05nYLX3itiY0XXCgk0oIDZDoBhhIM8F9hcp
	85PxBA7y8DbnrN1ZSvfkTH+YmhDBGGt1IfdZfN4sO0BQBxztTNkOlMY635roRXBrpuxtzoAH6d1
	rykhtCCXm/+T3SNRYAgtZK/1Mmdc=
X-Google-Smtp-Source: AGHT+IFqE9SiTrIbIR3jW1Lp8HrntjO9jRGgJASZJSv9BBpyfB81D2bbgfkCGLbvPr1HXnR0Wyz0hNG1id8V5iS89dU=
X-Received: by 2002:a05:690c:48c4:b0:6ea:7861:799f with SMTP id
 00721157ae682-6ead609d958mr12503357b3.38.1730986220252; Thu, 07 Nov 2024
 05:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107004830.14261-1-zenmchen@gmail.com> <20241107070707.1438-1-zenmchen@gmail.com>
In-Reply-To: <20241107070707.1438-1-zenmchen@gmail.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 7 Nov 2024 08:30:09 -0500
X-Gmail-Original-Message-ID: <CA+5PVA6u5hnYf+5Z7MP1oJPF-ubETiY5oPPJDpa4FPjdAvKgtA@mail.gmail.com>
Message-ID: <CA+5PVA6u5hnYf+5Z7MP1oJPF-ubETiY5oPPJDpa4FPjdAvKgtA@mail.gmail.com>
Subject: Re: [PATCH] rtw88: Add firmware v52.14.0 for RTL8812AU
To: Zenm Chen <zenmchen@gmail.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	pkshih@realtek.com, rtl8821cerfe2@gmail.com, usbwifi2024@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:07=E2=80=AFAM Zenm Chen <zenmchen@gmail.com> wrote=
:
>
> > This file contains the firmware for RTL8812AU and was was extracted fro=
m
>
> Hi Josh,
>
> I found I typed one more "was" in my commit message, could you please fix
> this typo before merge the patch? many thanks!

Fixed.

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/358

josh

>
> > the vendor driver v5.13.6-23-g232107d9b.20210820 from
> > https://github.com/morrownr/8812au-20210820

