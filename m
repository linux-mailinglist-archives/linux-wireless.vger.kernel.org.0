Return-Path: <linux-wireless+bounces-21591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76964A8AFB1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 07:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC122189C100
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0311A5BAA;
	Wed, 16 Apr 2025 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MpxdVaqd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BD10E9;
	Wed, 16 Apr 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781505; cv=none; b=tgD14hOXYym00YzGUVsBOGjUdQm8deK0JjpM0eBWcXJXYZ6OLqjOF3MV3PeGJEStIrRoIP2pd+IIL2paATybJzd89v+lq3Q+svxZGhpFFLyNv1lkz08hgGrSmOiwaCREV9SKJALGPek6EUBkDPNJW3G5dF0lpWC84XpXoEACl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781505; c=relaxed/simple;
	bh=scZhou3DcU402HaHrSyIVjrflB8vNzs67vAnYo7pvDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+AkXFDMkntiJe1Et+SlpPVpoZ9rtKtTeHwQRmGNiGgXJaDPA4G9z+cT7ysnrFtLXbB2Tah5DR5CsaY0zyfraeZJsWjZwV/wSvOoNR/dLvb1CbYMwWacAQFEnwsNPA4SWB/GiIpANm+8WU/jADVMALgyL5DlGUnNYPSnQ1UFb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MpxdVaqd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33ac23edso3169065ad.0;
        Tue, 15 Apr 2025 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744781503; x=1745386303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scZhou3DcU402HaHrSyIVjrflB8vNzs67vAnYo7pvDo=;
        b=MpxdVaqdXj5g8q0GmbI5fzRBreYWI5YvxZNwLc/ahtuTXyiCJMHYhLr37scBkgfJ2V
         I2Og8pUR9zB/oTQxxMYKpnv49xkpR6aC/aKEBZJybdHlAYQxTKP47O50zaGf18cOEl/I
         eB/wnYuGMeH/ozQIj/amPSKzM6d/hL47SuFNQC1M/yNoFItWJcwm7AQKv8VOO6rUjY3K
         qfnZEc45j6iysVKfsfi4sVKAZz9iMKI/c7n+wvmtcIMuWTCb8Ljdusb+ibOcx7Vqbkfp
         Jf8JLo+NXKTXajhh0gV5K34sWV+XSXHn2G2d65G62ZwSWa9s3+HwUUuTEMd5b0zFhNgP
         3pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744781503; x=1745386303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scZhou3DcU402HaHrSyIVjrflB8vNzs67vAnYo7pvDo=;
        b=q3dEh7EyTtmJaCRzdjCqYjjlEnbUJd+f1DnIEmhUHeCXI19WTT33PMzX5zd1xSNqyY
         Q6E8OPtwYaBJr2n4JcYsphBGSaEWkf150j5/2gfDwS/d03vSi+oOaXNFJuNO+Nu8a9sF
         x/A49UwDo3OXRXenxaHKq7QRuGOjxYHaDbAPOxY/9MWcbvpabo6wbNJldOUA7imU4d6Y
         HY/X3W8KaEbsEULnMrpIHaCouDgi1cWk4imC/N9CsEG/epPUdKpRPhwwS3Kq3dRBlrsv
         gQGPoLGvdWMEEeiNZbYXW8+nVngEudzqJZgoq3dKk2k6d0L/UcEeHw5TYNwTndSmWJgd
         xaHw==
X-Forwarded-Encrypted: i=1; AJvYcCUMV/3PmHNZenyC5FBhqOu/zL70XRsPAYPOYBOd9alP21h1bKjg7nq2G9llUW9Mqp2dnk7fd3TMiINmZG4=@vger.kernel.org, AJvYcCUU8PH3q7cncvNDZh9D+IVfvGnYhAqqekyrNWopp8nfoSiLv012StADW4M28+0A3gqE+toqiYu1U0eP2++Ab7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ChUoS63fg/LpYk8q1UoDx+oveaQz3WK36sn7TqozcIY9DCcv
	ycvc3jWFOilVnSVU/7lCs5yay/6d1tfa6yVs9Gy8y2jFD1LNfEupVu80nao5r+gsozeQ8dUk01d
	l8MQcV2h2HmmXv/QZD3RRaUVyHXM=
X-Gm-Gg: ASbGncv1N+CrrAveu5+xQTEYwRWLRUnFTYOdHw+xnGw4SMWqUW85kc8QjqGnwhcynHX
	ZX7NOWdsz0aVr2ND4X1jkCiymymplhwh+E76o3bE2wKudzPn7CjEn74KASnEuwlbaXeA4MMoE7A
	q1vQ2sWvgL2QRrbC00Bsoyk2yTg92SKQzmtRTEust3tYFiFj1Fijls0A==
X-Google-Smtp-Source: AGHT+IEPRZ/Kqr+BZHd5ZCJrkWtPZ23MNPQpFqzeh4U2oyRC4w09qvIjZ7iq6t1Ss8As9iAro/tsKHru/2H653Ym2vc=
X-Received: by 2002:a17:903:98b:b0:223:3630:cd32 with SMTP id
 d9443c01a7336-22c35990bfbmr10472895ad.53.1744781503491; Tue, 15 Apr 2025
 22:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
 <20250410154217.1849977-3-zhen.xin@nokia-sbell.com> <CAFBinCDVd6eVFcDzP1N8ayS6OmVZng5ti2jrHfYkbqFY4BdfLQ@mail.gmail.com>
 <74fe1fe102324d809d7f23b14d335bac@realtek.com>
In-Reply-To: <74fe1fe102324d809d7f23b14d335bac@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 16 Apr 2025 07:31:31 +0200
X-Gm-Features: ATxdqUFleBpb2JKR5GRg5H8JGcWGCVOQSsFCXGaB_UcMWtWF0HnEEzlD34OjM1o
Message-ID: <CAFBinCBzwiCBzfT9g4XqH-fBkMyh-D6039U_mtxqAipSsh66Yw@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zhen XIN <zhen.xin@nokia-sbell.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:33=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 5:46=E2=80=AFPM Zhen XIN <zhen.xin@nokia-sbell.=
com> wrote:
> > >
> > > Rtw88-sdio do not work in AP mode due to the lack of tx status report=
 for
> > Ping-Ke, in case you want to keep the spelling of rtw88 consistent:
> > can you update it while applying the patch (or do we need a v3)?
> > Same question for the other patch in this series.
>
> I can update commit messages while applying patches. But not sure what yo=
u
> mentioned. Did you mean to change 'Rtw88-sdio' to 'rtw88-sdio'?
Indeed, I meant changing Rtw88-sdio to rtw88-sdio

Thank you!

