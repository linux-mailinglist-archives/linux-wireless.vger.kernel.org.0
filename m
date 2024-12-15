Return-Path: <linux-wireless+bounces-16398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F19F24BA
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA271605D4
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE81190665;
	Sun, 15 Dec 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+p5Pdaa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA9148FE6
	for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278893; cv=none; b=XZJM2l21CjlN+k/5klJ+y5toNkcbfenD1EuEwC+M/dvx58FHMBLJThKOxvA9RrgCW0eXq1IpXvxRc1bTHl7yN3j9rt7rNYPYlXpwyH/odIRKEaj4wak74lMm6qop8+UEdkjm3w9HQkWUoWvA4R+r15gDFxvMVEzYA0w8PCnUa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278893; c=relaxed/simple;
	bh=P5Z2L2NR4Zwptsivm7F+CjfdqcynPJts4uC3SxS9hMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COXgH9OdiGNPcp0RzxXcYqj765Jj54LagLK2tG2YrFadH5mB3kLm7poSIASZw05aYvIG/ph/RB2Of5qenPxo+cMVwju3w+hC6gmtT/TY/YvKdP9ardViBNsX7uQqHOupskrdBZ5OXNQPQJUuOlt8DrURjQCWNFuW5e0OmHvwVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+p5Pdaa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so2890709a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734278891; x=1734883691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5Z2L2NR4Zwptsivm7F+CjfdqcynPJts4uC3SxS9hMQ=;
        b=U+p5Pdaac+I5wJ4UqVS2Ly5dsYaGsDdzhRe56hCjiQuNOQ4wWpkDF/6HHZgxm7aWlm
         +9wgy7FH1HRXPn5mGQ0SG7n6NmnFan0+I6T4jUAv2iDh1Ja1ykXk0mjszlSEqApUcg5l
         Kkh+Ul2GFSEdYxLsnfAtiPExEULcVduV2l6ScQd/BnFTiiAOTaWtIxLWjKrIYZqHicZh
         XzfkMGhk30e1dbiTOyj8w7zAvgyugwtZUG8ZutJ7r8zfzyff8V/Bz+FWgPEWB7bPeQr+
         dubj9Vtttjnl085jgv3Tvb14eMi4pv1Nzy6np1a6ziqT3cz58OBAzV6ODjbyeqjAp6Kb
         BSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734278891; x=1734883691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5Z2L2NR4Zwptsivm7F+CjfdqcynPJts4uC3SxS9hMQ=;
        b=blAeBXiIeFDK5DNLsKoTl8ruovsy2nOZxAmcNxdgKyxXk5K3yPyrAdDpcoqzo/95bZ
         CX1q8j9vnS1IvHCRrJGf1yIRSElq0GtQVAO7M/5LTKVHL/XsT5K6lql7ZR8o4QOvKhmP
         pzukmbBPQR+PeE223xfHXbdiGwJ5M3UpQVbsJ7F0lGlLGvYigwNG+hKZ8CqcPSXkYW1h
         NUmFiC89uk3q64Ef8D/dHzZTSIbp9Y8NEVhwKL7+x2gZbDdZFxpIMxfsltZxYn9sNLyv
         US5eYHbZHuBO2lF+OdYE/2IKRXxSLbkms/c5cwxORiM66HIr3fLkc2DRp0pdXTA8zDr0
         VC+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGqD5n31Y4gNLKxLPKJqW7d07MRpbmutKKBMbI8oeJZSVMEbbfmk6V3KRDVsqljkUhEyQxgf1P/LZJ3/gQjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGn+wnm6QNo9QoOKMAJezLI6QaTkbjgply8Y6cNyWj8aqP171z
	oFBY7RU1nuDpL7Pd3NimaXqVvA/YFlcqiyGwZV6iWStpwheik/dKLYFie95/M3hWtM6mFKjYAtw
	zKiGt9SApSQhO7bCWevhKS7TCffo=
X-Gm-Gg: ASbGncui1iIHRYJqjNRJMg8/PikmNrwbHzKxv1CxDPOMp82SZgU/hZLlRKH9nCPGygW
	Q9E+M8F/r8pWFmasSZvmreH/CugDvXt6rDNw3MAeazvePM8kP2EqeZ6UwGQk/zwc3hstc0QVz
X-Google-Smtp-Source: AGHT+IGF0zGrZtfVbdv0yvQXYaTe/OWsxjuqyTxCboomBSvdCzuDV7eWTq52L/Ihe6HEL4ueuwNK/n6m0vl9KbzHpgQ=
X-Received: by 2002:a17:90b:2e4c:b0:2f2:a9f0:40b0 with SMTP id
 98e67ed59e1d1-2f2a9f0589bmr5782882a91.23.1734278891428; Sun, 15 Dec 2024
 08:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com> <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
 <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com> <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com>
In-Reply-To: <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 15 Dec 2024 10:08:00 -0600
Message-ID: <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 6:12=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 12/14/2024 2:34 PM, KeithG wrote:
> > Arend,
> >
> > I looked through the info where I got the latest firmware:
> > https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-A-cla=
ss-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
> > https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Cypre=
ss-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
> > and did not find anything, but I really do not know what I am looking f=
or.
>
> I think I had a bit more luck and maybe found the needle. I sent out
> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
>
> Regards,
> Arend
Arend,

Can you send me a link to that patch? I want to try it.

Keith

