Return-Path: <linux-wireless+bounces-7401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C607D8C1547
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F03D1F20FA0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3A653;
	Thu,  9 May 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzmhoC0j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E07F7C5
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282233; cv=none; b=icyHJCuVmiGMBqH5OTt8cePlJgweMXzb7MPdki29MotdS+H1YvKbZ6zFWEEXZZ/iVnmX8EEwvj7AQs6GSeHSti7+bX32SB4tGk2DJRyOnEoKDETQsnQTMXpGGHvaFvVt+JMRQcExtSIwroywt4Ugh1xjN9a61G4yOv7ERpt4gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282233; c=relaxed/simple;
	bh=/4ChlJcJf+93ktEswVwUf1vlCCpZIvOpU7pXV3h7bEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XBSz81qJ6M755imbzWgYsqt0mXt5Yo5qAoOF1BFcBMRnAwZiIqzWyqFUxdt3qDZ5aKrSx2BJpKwQIlwHH4k70hx3TujhYo6v6fs73kQcUx2Euw39BjMxM8Ofo1LGeyU/Hsq7d5yzXm01D46dFptgPjC5QRXTwoFMg9c3+KBU2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzmhoC0j; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61804067da0so12502877b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2024 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715282230; x=1715887030; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4ChlJcJf+93ktEswVwUf1vlCCpZIvOpU7pXV3h7bEk=;
        b=gzmhoC0jTwFjY3m41ApIKnoLBmhPcyG8bDp5SW3ESgqXYfSYFWbJk/IibeELDO4ui6
         +vMWkWjNRwCYEYQZeQnxrQwG9xPDwVMaZQlRJIsc5i3aJ5LJTETtH1HAcrOTqhhF9RBG
         xFw7h0GKJzdkjZqsJn5/wlRQ3iQsYMnP7S0Pf55LeKNpFEnqRAPvyNtgozwXzHgUzIbF
         tZr+FUYwfwI3XTGu7OKYNSJ4loiM7Lj3Cmq/xL44Xf/XiGxuBgHP50yVlK8f0NXKN61S
         ldgM5a8h81prViH1KwPBAgjVM8n59zNMhPTAZpGg6z5KJnMpoXvS0Gqx1jq1toXvXd4D
         PGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282230; x=1715887030;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4ChlJcJf+93ktEswVwUf1vlCCpZIvOpU7pXV3h7bEk=;
        b=eEYxhSsHLcgqjr70S6lijqP8B6dIpkpWJeL4D8ZZ/Seka/qa8pJn6tK3rzX0saqedN
         yuNswpFAINGqsFMi5ZuzxR0XAg8mnmj4TbNy5iVJgjnQdLmayNqr58gvnP7XzHmarQ3U
         9ZGet+01QMHgikbtYbNP5Nyq4PZ6EgOzXU3frWEhLD+n7HyjPGi5cL37gVXAIVeGVORd
         ljbVPSf+OoPSL+7aoiHuQHvWdoq63z5/1QVoYK72KfVXXPAJd4DbslmjSO6DkG6n8cQy
         triLhseb2FNkjlQjeEs5Ift+48X5C64yHiT97Cs6cZ9iKLPd3hmLlfvoAqw8TwILyq/q
         TR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAS35f2wIsGbxZqkONq3uabkf8fT6poODU02Hxd0f+YliXTPf8AcxFjhMKgBHv8O3X+Q7FWEv8c3bGyNIOae/D+5+xcuID6w3vAiU1yjI=
X-Gm-Message-State: AOJu0Yy+wL5XouJhJ5fEvIqkuIxb+6uCwpBbgTLWRMws4kYEktoumeQE
	RmA2/cbWkG2ig3O09g7x9IepuNl8HEmAdLCi4MluufOcSClPkimCj8fQtpYswm/5PxIqQ7fbqvL
	M4EQp3uDpDAE/B4/8EWGFo+S05kFjdr0=
X-Google-Smtp-Source: AGHT+IGJpTaltVGmFwHcNw4gtELnBidY8Yl71i2o1mfyKLqcOQ1Txha9v3QiW4ZkYdhtf8urEB9dqZGutz9TRy2x+Gs=
X-Received: by 2002:a05:690c:b0e:b0:617:fe2a:a0aa with SMTP id
 00721157ae682-622aff76e17mr5229817b3.6.1715282230617; Thu, 09 May 2024
 12:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFR8rtBZPAU9j2k_YLK36memrm-Tj0XFSZnkUyw2Hd-mw=vsxQ@mail.gmail.com>
In-Reply-To: <CAFR8rtBZPAU9j2k_YLK36memrm-Tj0XFSZnkUyw2Hd-mw=vsxQ@mail.gmail.com>
From: Nick Morrow <morrownr@gmail.com>
Date: Thu, 9 May 2024 14:16:44 -0500
Message-ID: <CAFktD2fEEpUw_fSetotpsg5H_BihYMgnUKf3WGLrX7Boa9_5RA@mail.gmail.com>
Subject: Re: Wireless slow down on MediaTek MT7922 for Framework Laptop 13 AMD Ryzen
To: Matt Hartley <mrh@frame.work>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:53=E2=80=AFPM Matt Hartley <mrh@frame.work> wrote:
>
> Greetings folks,
>
> We are seeing multiple reports from those on Fedora 39 and Fedora 40
> that they are seeing significant wireless internet speed reduction
> from previous firmware release for the MT7922 wireless card.
>
> [ 28.870498] mt7921e 0000:01:00.0: ASIC revision: 79220010 [
> 28.950129] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
> Time: 20240219103244a [ 29.342888] mt7921e 0000:01:00.0: WM Firmware
> Version: ____000000, Build Time: 20240219103337
>
> Testing indicates this is not a problem with region or power savings.
> I'd welcome any insights you may have.

I've been seeing an uptick with reports from Fedora 39 and 40 users
also but it is with mt7921au based usb adapters. Here is a link to a
long thread that covers the last 2-3 months:

https://github.com/morrownr/USB-WiFi/issues/378

Note that not all reports involved fedora so it is hard to blame
fedora. This report is not exactly the same as yours but it does have
some workarounds that you could try and might be useful to the
Mediatek devs.

>
> --
> Matt Hartley
> Linux Support Lead
> Framework
> https://frame.work
> https://community.frame.work/
>

Nick
github.com/morrownr
Main Menu: https://github.com/morrownr/USB-WiFi

