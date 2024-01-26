Return-Path: <linux-wireless+bounces-2550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31983D930
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6CB3ED70
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2F12B6C;
	Fri, 26 Jan 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa8uny3r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FA12B6F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265997; cv=none; b=hHnQl8xy/pRbD0vByFEoW8e+zq1XTWwtNIiXhDRKY0BoNR/p33kEutdl8/WiOJcykYs/lZUBKfAq8sRPseEc3HbQHEb6yRhhHDvRblTjSSvTeM453C2w3s3BFYCLsLOSn8Qzpmma1nYPvGMRfcrxIgWFwvcGwIZOBa+nF16uI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265997; c=relaxed/simple;
	bh=lv7lTnch23M14rjMsV/eshYaQgNIUJk4h2Njl3Rn63M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9M5pW8Sur01iryGFo7XeFzRcMTmT0Cg4+q60B0vCnAdi8PLaslOlliPX30xx3fcCQCY4WeuMlfE1Z15ErYxb95Zh6nblrvQUhno2qj+1G4+n+LXSGGDzNvACzE/X68GDIIys8fwo6KCpP22yKQxGmKrSK61pQFRlWqwWpcKPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa8uny3r; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818f3cf00aso3001236d6.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 02:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706265994; x=1706870794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krVn4OeUL/ZtKJj1q/PKY6xPFZUbhi/ZPPKjnOMh/OU=;
        b=Sa8uny3rhBmvR6hNMkWPkVNd5JXuWfvng5ugRldp9vkAIKF7V7XQ/iwIPKiDyWhlOp
         zuQk0mkUKEa38O0e60pS0VCk+nev7Ci+nXX58kRCJHVJz1DGvGpzE7adpvGIvoc1XRer
         KulaWV9a+35WEJEC2D+tqjsoPouxOulXhFqQwzikxwm7yxowdYrCyaCtjZe73TU+1IMS
         NaA+8kAFzk9nDRKk9RH7rz8a+6en3FKpJBBQaczaG7KsQxAQeA+1L209N6kglscdRt+Z
         2ou4ISKQ44JsYkwdvMD5G358NUnjz29uzgUB09zfJwWw3Qsna3SwgaWgeqT/ipQgZLX3
         bRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706265994; x=1706870794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krVn4OeUL/ZtKJj1q/PKY6xPFZUbhi/ZPPKjnOMh/OU=;
        b=C1fyNM58IkOhi/gaNiuSqzBpn92I5K8nvmIkHCoQT2nL0qrFbGbjQ09fUwyVI309zC
         4T0AJfgjP0gEOJdhGW+m/3OmGcRB8GOxk/ZCAUsaLDg6CKyFUOP2tKzX0yyfd0RdhlvD
         oml7MKPRnaQJlYpdGs6lXmmx/SfKws+bX8WwCfSlOAgb640Ulc/BThjAaX6CfYW2X4g6
         JaNEzPr73n1+L/Kgn3bl8JhQSUyHnWSBRZ7w6a5aYXtQn8cv/Xx6NYEuEREarGn+aO/B
         8XaRJTsKyRC//vfSn7Z99UVt4WjPW/WsPOaoXojOUO7CbeqvE68AsldonAkBCv9FOAsP
         8Bbw==
X-Gm-Message-State: AOJu0Yzte/050DflAM+CFR7Wauw+Db/G3l7X7TvCqxNhIZOw29CiJn6y
	FHM+iHQmTkB+Vmu/ty9DchLRhNX4y4xe2zSQ3Y4kBaCEuoAyfjS2O/5bFYDMM0q1CxAMhWQ52Ce
	0mkSRPydp9FKgfovZgksFU734q2fwE+PRElc=
X-Google-Smtp-Source: AGHT+IG4KEy17knQeCJ7D0bBdlM0MgTqZGNJPR4DCzhUZ8j0NKQ177ro1LkU5tHWow08DHmc0sdOCfKP8jddXUu01go=
X-Received: by 2002:a05:6214:2249:b0:686:ab0f:9ad0 with SMTP id
 c9-20020a056214224900b00686ab0f9ad0mr1211997qvc.124.1706265994387; Fri, 26
 Jan 2024 02:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
 <CAPuHQ=GSuKW5=T0GXXCq7Pf9jw=zcEnms-fEJey68QUWH1ishQ@mail.gmail.com>
 <a5123274d5a8d80d554ffb786e25bef72d45f69b.camel@sipsolutions.net> <CAPuHQ=HSJNXx_ukS4G=+AsM=qp2yMA4mKD=NHDpq+BoMMLSv+Q@mail.gmail.com>
In-Reply-To: <CAPuHQ=HSJNXx_ukS4G=+AsM=qp2yMA4mKD=NHDpq+BoMMLSv+Q@mail.gmail.com>
From: Petko Bordjukov <bordjukov@gmail.com>
Date: Fri, 26 Jan 2024 12:46:23 +0200
Message-ID: <CAAgmp6vdK-bMJCnXUqhPPADRcd3sJXeFvuSOt5_7HCSV2dVKEQ@mail.gmail.com>
Subject: Re: WiF Transmit Power Control (TPC) Regulatory Requirements?
To: b.K.il.h.u+tigbuh@gmail.com
Cc: wireless-regdb <wireless-regdb@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, thomas.huehn@hs-nordhausen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The only project I've heard of that implements such functionality is
https://github.com/thuehn/Minstrel-Blues.

On Thu, Jan 4, 2024 at 12:02=E2=80=AFPM <b.K.il.h.u+tigbuh@gmail.com> wrote=
:
>
> Ideally, TPC should be a fully automatic mechanism that reduces
> transmit power between the two points to as low of a level as possible
> while delivering the same quality of service. The purpose is to reduce
> the excess headroom in each link. I.e., if you could still link with
> 65Mb/s towards a given direction using 14dBmW, you should not transmit
> with 20dBmW.
>
> Some only set the AP TX power globally (i.e., same towards all of its
> connected clients at the moment) to tackle the hidden/exposed node
> problem, but again must do this adaptively and change this constantly
> without human intervention. There exist multiple advanced algorithms
> for this, some proprietary tuned for corporate deployment.
>
> Actually, if we accepted automatically retuning tx power with iw based
> on actual link stats of momentarily connected clients every 60s with
> cron, this could be added to OpenWrt pretty easily.
>
> > Class A devices control their transmit power within =C2=B13 dB and clas=
s B devices control their power within =C2=B19 dB.
>
> - https://www.litepoint.com/blog/wi-fi-6-ofdma/
> - https://www.cisco.com/c/en/us/td/docs/wireless/controller/technotes/8-3=
/b_RRM_White_Paper/tpc.html
>
> On Thu, Jan 4, 2024 at 10:42=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >
> > On Thu, 2024-01-04 at 10:07 +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> > > You can find a wording in most such regulations that if TPC is not
> > > supported, the maximal TX power must be reduced by 3 dBmW. Hence in
> > > all such cases, the entries in db.txt contain 3 less than the maximum=
.
> > >
> > > If, on the other hand, you know of a country that specifies that
> > > devices lacking TPC may not use the band at all, all such band entrie=
s
> > > must be omitted (commented out along with a URL).
> >
> > Yeah, that's how we (currently) handle things.
> >
> > I'm not even sure what the requirements would be for "TPC" to be
> > implemented, tbh.
> >
> > > > As far as I know the kernel doesn't have facilities to support TPC =
or
> > > > transmit power control,
> >
> > Right. I have, however, heard the interpretation that the fact that we
> > have - even if nobody uses it - the "iw set txpower" command means that
> > we *do* have TPC ... Not really sure what to make of that though.
> >
> > > > nor does the wireless-regdb database.
> >
> > Correct. With the new regdb format we could add something that would
> > enable these ranges in the kernel only with some additional
> > requirements, but
> >   (a) we don't implement that now, and
> >   (b) I don't know what the requirements would actually be, e.g. would
> >       it be enough that the driver promises it implements "TPC" in some
> >       way? Or even the manual setting?
> >
> > > > And so
> > > > in the database we would either omit rules that require TPC, or inc=
lude
> > > > alternative rules (as specified by local regulations) not requiring=
 TPC.
> > > > Am I right?
> >
> > Right.
> >
> > johannes
>

