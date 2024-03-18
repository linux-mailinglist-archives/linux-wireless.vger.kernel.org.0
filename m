Return-Path: <linux-wireless+bounces-4836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6AA87E886
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E65D1C21540
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60B2D043;
	Mon, 18 Mar 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtsCqYpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7B2D7B8
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760988; cv=none; b=FJ0aSOYmcWrGmjV7Lpw3un9agdGuNwXgm5sIMqJxj5FP99YUuHt4UBGSbBImYtJwtIdyWcBHMSOeSEi2YDY1UdvgxuvvhJQLbd2q0brNWpN00XmT0xAqjW8Uvy0qPIBb6K7IvynXZTpkXa5+UQQeOZLFa31qI4HOdyUyjh0+pug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760988; c=relaxed/simple;
	bh=EzI3bstGT7kjdnXFj7oEJPmOPn0ZxQCZrqM2oP0Skv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpDmyA/A0lyQRjkb33Nb9mOMNza4jj48EgbwtSkG2Ml75112FG1OsT1Cxt7eRI6NKIq3evZmFFahXuPDWk3H5yBj7uoxAf9ADPFlEhcfDIYNFVMXtGyoTSk6lWBXCqj+OXg7QxgfhD7n/CGOPOvZWUOu2acpBMebmAjcrm/pPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtsCqYpG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45f257b81fso545000466b.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760985; x=1711365785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPI/UsZ7xO2R+jvbfm0djmgWZ2X1nvpv/p/DeAJdrwI=;
        b=BtsCqYpGNXug2MUwiTV0r0fxC1pCpIZMwxm/qCuBBwzApuFC5CCpKpVdcF7eLgmQTI
         oWMkBZoR7GAcHbhDeZosiQxrsS+YMc1e0PJuhk1bKft8jkkOs4zqgafvyGs2e/HSmcvZ
         ErgpX2/hwYqeaxSWoU+fs6iZb3srQIyT31Mliv6GibJpWqff7FQ83en/GvTPiJs1Bdhh
         OXMMtS908PbkB0Hb6aaulrs7m2aUleydhh80ut3eK5+RzUqAE6az5/jE26LtO/M8EcmB
         73PgBkM0suJb819w6k8FbGPe2es0hfYCzAP5FdA6msrkipH6qgnfYCK0jihnzJwfjRjC
         Euqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760985; x=1711365785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPI/UsZ7xO2R+jvbfm0djmgWZ2X1nvpv/p/DeAJdrwI=;
        b=gCLyhhtNs5ex5TZDiSuBI6x6pG0w4i5cNVke62NfWMuFfHQErSzDcvJHfRUWRMq2dA
         vSUVXhDcgWcD/WYcKxWTqX3IDNaJx0ZybJ10Qy8rgR+myIIR1qJrPnuiMzFEUvOV/7Ur
         DJ05tmVA9bwqXo9jhdQzML+/V1aH1DLkSndnYI4JrzgBqeBfcm5FOfldri1Z3NYj9C6E
         P0ERmw0IO9EyCEbX5UU5jyPEvb7bi6ANzoJHqEsFpR55pRzWbBiBJe8BSGoWCQ+z5mzR
         3WeCdwc0qVyAaB365CfNilOQb60xbRrffezUNgI6NHiDNW+h+ZazGoM1whOI5jWPOYxH
         4K7Q==
X-Gm-Message-State: AOJu0Ywme95uUR0amznipVtxjx3njuwTMR6aOzrfEWgXs3ib9dzk6mSO
	M2yQ18VM/v+P2FHWYCJ5mVUMPP7oLWuwBOmoAgy148o7A7Q9kP8FOc/qxv3pFEJ6XF/e/D0Z5cj
	beESJfbkxECDweSUW8PA6Y5SGNUzjcXIjtJw=
X-Google-Smtp-Source: AGHT+IGUBLJmmxgtqfRY/cTo3fyAoMkwZyF1/mP2qZjpE0xwRH5NhB3GhOcj+q5qCGPPRLdLRMliS3pRNYRGYclRnIY=
X-Received: by 2002:a17:906:6855:b0:a46:166d:d0d8 with SMTP id
 a21-20020a170906685500b00a46166dd0d8mr6218490ejs.64.1710760984527; Mon, 18
 Mar 2024 04:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFED-j=3_xLuJFp5R_gThMtv2C6r6WzRxzrY3_wjFTn=XJQLwg@mail.gmail.com>
 <bb884b84dbaa1c97f9d3a1e610f98ec6e069a706.camel@sipsolutions.net>
 <CAFED-jkowv0GTtWUC3=HwGNjzwe8d2F-m_QrZratdpA5HnkuBA@mail.gmail.com> <52d4ad82257001925849a34aa9fd717046208e26.camel@sipsolutions.net>
In-Reply-To: <52d4ad82257001925849a34aa9fd717046208e26.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Mon, 18 Mar 2024 12:22:53 +0100
Message-ID: <CAFED-jk8pJheJEViESnE54f-K+JgRMiWoiCSa0GBt=RKaCn7sw@mail.gmail.com>
Subject: Re: BE200 - 6.5 backports - disabled EHT issue
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 18 mar 2024 o 10:58 Johannes Berg <johannes@sipsolutions.net> napisa=
=C5=82(a):
>
> On Sun, 2024-03-17 at 10:53 +0100, Janusz Dziedzic wrote:
> > pt., 15 mar 2024 o 19:04 Johannes Berg <johannes@sipsolutions.net> napi=
sa=C5=82(a):
> > >
> > > >
> > > > I see this one do this:
> > > >  if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
> > > >       *conn_flags |=3D IEEE80211_CONN_DISABLE_EHT;
> > > >
> > > > Testing on openwrt and using backports.
> > > > Is there some patch I can easy cherry-pick to fix it?
> > > > So far just disable ieee80211_verify_sta_eht_mcs_support() check an=
d
> > > > BE200 works in EHT mode correctly.
> > >
> > > Then either the code there or the AP is broken?
> > >
> > > That function checks that the client supports the MCSes that the AP
> > > requires. If it lets you connect without them, then it's broken. If t=
he
> > > checks there are wrong, the code is broken :)
> > >
> > > I guess you can capture the assoc response frame and we can check
> > > manually.
> > Added such dbg:
> >
> > printk(KERN_ERR "%d vs %d, %d vs %d\n",
> >                                 req_rx_nss, have_rx_nss,
> >                                 req_tx_nss, have_tx_nss);
> >                         if (req_rx_nss > have_rx_nss ||
> >                             req_tx_nss > have_tx_nss)
> >                                 return false;
> >
> > [   70.243183] ieee80211_verify_sta_eht_mcs_support nss 4  -
> > (ARRAY_SIZE(req->rx_tx_max_nss))
> > [   70.248336] 4 vs 2, 4 vs 2
> > [   70.251035] disable EHT due to mcs
> > [   70.260724] wlan1: send auth to ....
> >
> > AP have 4 NSS.
>
> Which doesn't just mean it _has_ 4 NSS though, it also means it
> _clients_ to have 4 NSS, if I'm reading the code correctly? So we
> correctly don't connect, and the AP incorrectly lets us connect if you
> hack out the check.
>
> Arguably the AP should not even include 4 NSS as the minimum
> requirement, but of course it can, if it really wants pretty much no
> client to connect (in EHT) :-)
>
> Unless I'm misreading the code, but it looks pretty straight-forward.
> Check what wireshark says about the EHT operation element?
>

Basic EHT-MCS And Nss Set: 0x44444444
Seems this is AP issue, will report it.
Thanks for help.

BR
Janusz

