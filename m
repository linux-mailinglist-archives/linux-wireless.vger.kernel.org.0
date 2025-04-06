Return-Path: <linux-wireless+bounces-21174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF1A7D060
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 22:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BED9169C8D
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880F1A5B8E;
	Sun,  6 Apr 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C8qbSjl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B921487F6;
	Sun,  6 Apr 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743971939; cv=none; b=GzpigS2DlsszuKfgaki6gkeb3jocFhxqrhh/mjINMA2/t/O3aAHxrJwb9DPrO6lyPfPIB3d3wsrZSBZ8xb4sFBLH35UYRblwPJf6YFkB261rjZMyN8sD/lSZnVIj2d4MsI6iSAV5fUDP0Y9AQO+oORsxaViQNyKMc2wAcKqOiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743971939; c=relaxed/simple;
	bh=NI1/kyy0gTrSMXMDeYc9TiMNCu+lNoTvc7HFd6GFVr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+n/BOXv1IKaRg9LOxDGYniT0IHu+SCYQjV65nGBXMsfzE5x7jD63I/bXVKryCz8rVPP81c2lTZrXmkkqjv+3u61YZz9jp2fFFtKp5FyYNNhTivDYQVMbbzEKJE4OCvtjdjXX6sr/yesG5oNvdfomo6gQXW0/WZbDQTw+HvPHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C8qbSjl1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fd89d036so40654815ad.1;
        Sun, 06 Apr 2025 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743971937; x=1744576737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydwO1JyYbeugO8yOiEfHx3MM3FsXIUg1LfWXi3rj/4M=;
        b=C8qbSjl1w73HTPnPSeQN6y3Q2za9i09nDD+6K5A8qppvqKxkW8ei4SRDbDkNJ7bykU
         Dd2EKkPVECsyydhJzVcGw01i0k3XnC7+kpWhbc0MMITnSdg8Gb80X+QoRHvP2+kGq0Z+
         B+z3FiqQmZ8GaD1ElgMiXaHInea1JAIQNbI3dtGQU09F15+w9PTMvGGXwVcNLxtgqe+D
         sGFWHBNnJaXknjSxZjS4zOsfTboG6IO1eXHg8Q/D2468L9roosulC/+IZ9ujPvJJbXP+
         1a0T4BA87JzLSSu8Y5mUxDGT11yDMZRx0p2BHyAejB/DsRcoEvrVf/VSl7XSMMHLg5Lh
         nk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743971937; x=1744576737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydwO1JyYbeugO8yOiEfHx3MM3FsXIUg1LfWXi3rj/4M=;
        b=Dhgl0/Pzncv+UTIolytm8XX7Vs+wiNGgZzIl2qfPJGy2waUvJ/yjB1NeUzScrLdsDp
         fTeeKABCv0U/4oOJvk6R8/jm7iLxnsE0f5Ydh8TLfzPsTXMiXAE03mQIJZaw3VM/ItcT
         cT1knUPy4RK3GLgxOjGewAzTK4mIJGxuCTlMZvGtgdnqatK64/HmwO8OpHSmFYx+9t5b
         XzGUEeqFNQWTaHbdI8YIs8hJ3CF1dZuOvnN+dyTmwb/UU741UwhG993JO4k0dKyxgl9u
         Nz3F7RGSUC5JqgHDZrx7ukWZH/F3DSUNRStZrrRXMrX4xVKvmRi4WKHa+RHrAvpqDCwg
         U3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVG95vaJlo3OUbMiDDgiGKBGCNgmpQazqROrFvwdj9JpwD42xLiBuvfSdsPX8Ai8yyzV+AmR72tBieb@vger.kernel.org, AJvYcCVSNrI4MNA+/ml5uhWG26joZccThljyyZrf7AhUITJuqSOYQ5yNyEcLy3HiS5/+83kAMwonbGFa3+kTI0uCvBQ=@vger.kernel.org, AJvYcCX5EmEK/2tbaFjTWr2dxLOdSAvU3vwc6FctsiJ2Xhr5Ou/JnmOZ0U01HW9UgLHGR3tm0lJahP0jQaFL@vger.kernel.org, AJvYcCXPZjfMTilyV6evsZkt498oSO2t9j4qg/uovX7AhhO9doHKWjHLXJWKqtxhW2HiQvY22WRCGerHxm6QL73k@vger.kernel.org
X-Gm-Message-State: AOJu0YyAK3qgBBm7O7hKhlQxD4JpBK4f5ItYyKGtL0dLMT9qKoxgsZi4
	SOmVorRF1nVpj/h27yGqZgUgEIzaXWfJyQeLmeaX/f9PvYmkUhLTosXJ6s8VH3+RkmdKxX86wFc
	zVlwhmtBreQVdMkZKBdclteke//s=
X-Gm-Gg: ASbGncuVsaH6GpPzGy+uE6j0yX2ZhHzhWoUYHaWBUMtzXPwbVaeIV1uUStNDXW1YckU
	dEBOzAttB6Md/hbmM0i15L10C7ylZwFE9dDlxpD/7pydqQIzOcZjycKhOlGhTRdCENpbzQYCwzH
	EySvXKtGyA1UXrb5eKZuuY1KG/vfAb3Y3Q3NTD4vtA
X-Google-Smtp-Source: AGHT+IGDuS2E1gbvf+gLEVGC9aXsTzLI97TA0L4xSj8FjsSjT4qJXWhbv3i5QpV5K5VBN+QeBy8RRJfKYOEPI2TztGs=
X-Received: by 2002:a17:903:2ec5:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22a8a0a3599mr145741465ad.39.1743971937401; Sun, 06 Apr 2025
 13:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net> <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>
In-Reply-To: <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 6 Apr 2025 22:38:46 +0200
X-Gm-Features: ATxdqUHvsyKfKqx08asuwFCr7vofQGUcWxylj7FIDVyn6z9dRxtd3LDG4d6Z8JE
Message-ID: <CAFBinCADBn2uUvdL9he0LZEZx4Kt=qPqrhifw_MUn4=BxLeJFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: Add Realtek RTL8188 USB WiFi
To: j.ne@posteo.net
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, 
	Matthias Kaehlcke <mka@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:07=E2=80=AFPM J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
[...]
> +description:
> +  The Realtek RTL8188 is a USB-connected 2.4 GHz WiFi module.
> +  TODO- website or soemthing
When you re-send this patch (to update the email address) please
delete the TODO (a website is not strictly necessary)

