Return-Path: <linux-wireless+bounces-2065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F782FC30
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 23:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94431C27AAD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579124204;
	Tue, 16 Jan 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUJB58Uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A311DA4E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437492; cv=none; b=BTWDsWYCfE6M29840lmtQG1/Fr0cUtGbaKMRL8uzu5WWSysBJzopoDX1W7gb2lVDoB0MHk4rqYc/lGAkktQGa9mESSv1NLeWtlPpNA97rn7cx08taRmm/M9iGng3aGh2WweySMz9JOYRipLuC1qbCEnDnLLnfWtE1BS+gzYHoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437492; c=relaxed/simple;
	bh=bWnVFvHAU4t6eKXS1KrLc7i+mwN8k/7L5hdAhkpCffs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=WBm9g12qQQJAaGZ+p7MiLo0tH99CnbafRa51GRkNZv+tic9ulq8yB4WV5mdbkwjbTgHDZyuVv5ixLcUTBqHz1fRiI2OO47Hx4DRd4vPReyfGDjoTWlBHteDFBnyrUyF9NerhmJHCkxOzJQYVi3hh3PA8sBwz+y9VljeILOMRww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUJB58Uu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28bd9ca247so1237727666b.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705437488; x=1706042288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWnVFvHAU4t6eKXS1KrLc7i+mwN8k/7L5hdAhkpCffs=;
        b=nUJB58Uukrk24uCuzcK4ktX+4W739rHcRnyiLYJIxOvfstnDne7Hbzo38Lrij4t4uq
         LRyZkJQUQxqCrrNdj9O99xZYpjaZlPC1li9W6bgXT+WR/Fg96jzYvSOuEvfe7BiNb1vv
         2agSwQOqbkVoWnuEvp2kEdB/ULa+Q83BWSwwZS7wG2omigPXqLFCiiyOQEnxD2NQO0cO
         dCKbyuhTX5u3q0doGQ9IZWKgqrGpP5X82YBrDo43UGp9B6PJ2o+paeugcDMoihkLcXD7
         kdYB2WVQRN+t8EYjEPc43ypzJzAE2tLe+MBO4kH3FR2JvoBvsAS9ji2Hj2Gi5lM+DoB9
         30dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437488; x=1706042288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWnVFvHAU4t6eKXS1KrLc7i+mwN8k/7L5hdAhkpCffs=;
        b=Likpu146wUNJ4XHy9KxGdcg3iuFtfkAxcGCe73So01OaPoKMeZB8rWnYeb3w1pxe/W
         GYoiaM6441wDbB9fV5RN5Quwz6bies63nzj3E74I9oCNXB+RtUMinM0VyATREq8uZanw
         AryUvghk+uExBZb1gZxzopl45ziCbNShzp90dJr/BvDhY15qo2QEdRQVFgGabgn5z0pB
         5osswZJVzRAL4spKQSAFszVjqI1h9nt2Ns8LWFmh3ZwQLH9ATGKlVqhElRy6B98HTpCQ
         UN1SmbdDTPkfTu2TNb/UWjUw5TOCFFHys1cW4Tq/iwpH61scZLjSLPGm5GJqALIrlBt5
         +Azw==
X-Gm-Message-State: AOJu0YxafqnVGyuOHvrqVHJ08P4HDOqbr69CnjXJIGjjSDFGRTFiJHIi
	RKCgACqUjEkBrx/tILxg7AYYxasFh0M9R/O7hGY=
X-Google-Smtp-Source: AGHT+IEvBx4rDwsNBGd2mqiEDJRVE3qx9LAjbxEgjkdJ6l8w6IjqdmV8Dx8w64I3aWYy1V3hgfMwwIe6PwjnF/ZeWPs=
X-Received: by 2002:a17:907:8e86:b0:a2e:4914:cba with SMTP id
 tx6-20020a1709078e8600b00a2e49140cbamr1490840ejc.133.1705437487321; Tue, 16
 Jan 2024 12:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
 <dae4bb032ad8b0c9fa6547de5e869e51f9f6e766.camel@sipsolutions.net>
 <CAJvGw+ATM3B09KbuLM0VsmU9GZRSO-ZP6ffwvvOa75xVHR3-kw@mail.gmail.com> <d14d6b4c02282d6ef48a936b1ac8be71c80a8835.camel@sipsolutions.net>
In-Reply-To: <d14d6b4c02282d6ef48a936b1ac8be71c80a8835.camel@sipsolutions.net>
From: coldolt <andypalmadi@gmail.com>
Date: Tue, 16 Jan 2024 22:37:55 +0200
Message-ID: <CAJvGw+BF+LWAzOKa8aJvGcdORWWjRDZObXupkCF5VAgSEm21nA@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7 broke wifi "AP is in CSA process, reject auth"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ayala.beker@intel.com, linux-wireless@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 1:43=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> so mode=3D=3D1 indicates quiet, new_operating_class/new_ch_num are actual=
ly
> the channel it's currently on, and count is 9.
>
> Can you say if it actually changes the count? Maybe capture on channel
> 36 using the NIC as a sniffer what it does over time:
> https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#air_s=
niffing

If I keep checking it the line "Unknown IE (60): 01 16 24 09" seems to
always stay the same, the 09 doesn't change, it's the same today as it
was yesterday.

I captured the channel 36 for 15 mins, here is the 34MB file in
gdrive: https://drive.google.com/file/d/1yqDb3g3Cfttm4W-Jb5AA51nLQ7OglWhl/v=
iew?usp=3Dsharing

> Initially I'd say though that if this situation persists, then your AP
> is having some problems and we'd not have stayed connected without the
> patch in question either. If you want, maybe revert and see what the
> symptom is then?

I now compiled and installed commit c09c4f3 and its parent 2bf57b0.
The 2bf57b0 works great, connects immediately and I used it for 30+
mins, also tried to connect/disconnect 5+ times smoothly, no symptoms.
The c09c4f3 has the problem described originally, never connects even
if trying 10+ times in 5+ minutes, keeps outputting the same dmesg
message "AP is in CSA process, reject auth".

