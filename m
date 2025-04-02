Return-Path: <linux-wireless+bounces-21062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242FA78939
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067FB7A55F0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 07:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE2D2746C;
	Wed,  2 Apr 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdVqE+g1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED52F5A
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580573; cv=none; b=WEXlm3+AQn4n0r5GHu0LKuWbwdUe80Stpgv4aXAfdk/IgNbAyv2TD07i0xhAHaAB356TJm1Ovx40Y4pN02AQ7/TE4m1AfrjlUG2ZiE12dx7GkgFZ72xqfY6Sro/covsoozE8jld91pwI1iOhrqreeqisNcBwT7aakDjdXgPdlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580573; c=relaxed/simple;
	bh=mZS3xoWcPOwRbPbarw8xXtqa9LNu/1wjVra49z4kk/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWSS2SeSwAXgOC+1ARxTofWv1FnY74BPdP5otltEbVaDPdjtP1lXS+F+LSSekbl21i3HcovjJd4aXhcvniQfNRdywuTOtynIyepPusGxJBNVddYAEUgHtpNqBp5o5L90gEXDFZEC7GbWOd+BkjJQLKTeg4AOUCxGXhLbu+uTyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdVqE+g1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25d2b2354so1048769066b.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743580570; x=1744185370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZS3xoWcPOwRbPbarw8xXtqa9LNu/1wjVra49z4kk/M=;
        b=RdVqE+g154QDFGa5tAYNPH8ldG7T10jJ5sGF6BhDpVR7W8NQLxERfNhlC0yKxUjp8b
         a6m9g13qt9RiRVwsCwew9vC0c+pSMCpKyqP4lCrvoKv0USMRY3dEdMkTgOqVlDHxTqXt
         lh2UAm2MCRkwWEzLqUq56i/pepsOf14S+5V9InZNSTo5zIau0htoWonz4Y66DX8SGqc9
         cq3OtX4nndT2N9j5AT//JvnR577HWPs4QbPhPae2D8SJl8k6NZELJ/mcwPTKFnU23Bod
         j86rVrxTS4DYqmqr5C1LKbCZjNjdmIxuwnUAmYMmMDk10B+vZnk7Vw8mvmt2TEv3MxIA
         nB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580570; x=1744185370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZS3xoWcPOwRbPbarw8xXtqa9LNu/1wjVra49z4kk/M=;
        b=OU3gkokKt7a1ab1mbufGO+DVVOQhG8aVfXtIkZbkrnDS2PvuVP5WFodnitikRvQGSl
         9MMhlUcvrcW25CIctrVpT3H1XqPMQK7IluUwrDeeY22QPvL14WlQNiCLj6TSxkdJCAy/
         UDUgQtxwHltYclbOJpyn8C75Rn31eIDdIcxw+DN9858ZmWFQh9QxDmzuge4wARw6kUrv
         0uk3THsy+AN1eITIuDYI+AiyvyqtHnKHpftxlZEJ5mYElOHb8WiHH7uDo/Ju2WFk1O/a
         aDMzycuvdyTWDD2A+aqTLwvAnXYUcvqPxHGiqIMaK/1jz7A7YVjaJvCDerWQEw2sxzfY
         l2kg==
X-Gm-Message-State: AOJu0YxlW8Xrz8GrTqRTrXomOU1NxulfukCSfgpo4b2p4oIm+U+tm1W3
	2SiMooj7AASA7Jf41s5vTGHo4evs2sX2Xd6XYWX0x7vGpQoqCn+5RQegwtQgXitGdn3I7YRNNnM
	y1CgQwiwojlp4dWc11y9oJMqvrjo=
X-Gm-Gg: ASbGncuvbchtHHvgovArQHHd+gQ99gI6oBf2L37xtoe0ofe2QcTZOTtNpB7CHctS1nn
	5BsbpVzzhZSIhKIUB95DUEbTV16iimlAC+0cWEwIWxsvuDFjjTRtevSLbdIOtHk474mnVZo40r1
	BPCtDZzHybDI1cKjMPcdLvb6Pdhf31
X-Google-Smtp-Source: AGHT+IEbfflbDcB6mSU1pIogbYDfLFDXNn42fuFbsYkKXgjUPTyutNd95lUDtiIvpCeavW2uEh/b5Bjln+kdIdYU7qY=
X-Received: by 2002:a17:907:7d90:b0:ac6:f6ea:cc21 with SMTP id
 a640c23a62f3a-ac738c153a2mr1237816866b.55.1743580569862; Wed, 02 Apr 2025
 00:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
 <9481e6a3844f897d03f8f4bfef335092f4ac76da.camel@sipsolutions.net>
 <CAFED-jm3Ot3urZuDnYaWE1vyXuAMDvw_W7vuxUOjQtRqN-y0uA@mail.gmail.com> <abf1538df6f224e38b1e42b66cc71b76c2645288.camel@sipsolutions.net>
In-Reply-To: <abf1538df6f224e38b1e42b66cc71b76c2645288.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Wed, 2 Apr 2025 09:55:58 +0200
X-Gm-Features: AQ5f1JrcriVcJSZFtqjFRwLqfJD5_UBHBktjCutJTmOUtv0SEL3H39KoFCQgNAo
Message-ID: <CAFED-j=5KTpaCm8p7rbHnHVykTLvnRYu+ZO08ggh4jgxfuyoPg@mail.gmail.com>
Subject: Re: [RFC wireless-next 0/2] wifi: allow tagged control packets
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, j@w1.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 2 kwi 2025 o 09:24 Johannes Berg <johannes@sipsolutions.net> napi=
sa=C5=82(a):
>
> On Wed, 2025-04-02 at 09:17 +0200, Janusz Dziedzic wrote:
> >
> > Just do minimal imp/check and share RFC, while don't know this
> > approach could be accepted.
> >
>
> What choices are there? What's the alternative? Go back to sending the
> frames via raw sockets? I guess it works but it's not great?
>
Yes, back to netdev/bridge eap read in hostapd should fix receive path.
But, don't see it on netdev/bridge when use tcpdump - guess we change
smth here for rx path (or skip not protected when control port used).

Some background:
 - backhaul AP send primary_vlan_id in assoc resp in multi_ap IE
 - backhaul STA (agent) if support multi_ap profile >=3D 2 should tag
EAPOLs with primary_vlan_id
 - with control_port we have today hostapd backhaul AP don't get this
tagged EAPOLs

Other issue is sending tagged EAPOL from hostapd when backhaul STA
multi_ap_profile >=3D 2.
But RX path looks like regression compare to raw sockets.

BR
Janusz

