Return-Path: <linux-wireless+bounces-2567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2383DAA7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 14:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A31C2237B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08411BDC0;
	Fri, 26 Jan 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl9ASqzS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB71BDC5
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275307; cv=none; b=mCMP/2mOwirgkqxTo5PuY7O3/esYTLvQqXg52NfsAREw0mt7IJpt7MLdlK8kBMRuis4exo7JwBswdyikC9l1ouD5JGq1U4lfHtyuoWAZj+MZlDEPs5KJVj4f/I8PtkkgeZUIZKrbvcKK2QgW8/jLTLeBN4U/8HbnnR0Hxyc2bkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275307; c=relaxed/simple;
	bh=E318jbBI3Sfmaas3eq3UTLrKlPS3jJTstVGnWt2qb/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jd6DArtAFhadyGB1k78ShKQpRvuJp48axmb/aEwOeTxlIWW9poNyonvlU0HBPP+eatRSH5cIBwb90KHUYSpJUGqXpJLe6ZjwacqzHapUtaIcYDTuHkOYuI2xbz0tCnQ7/J//+vXMIlas2VPTNSx+yVTqkJdai2zA7cQhoTMXJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl9ASqzS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a4516ec46so2806541cf.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 05:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706275305; x=1706880105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E318jbBI3Sfmaas3eq3UTLrKlPS3jJTstVGnWt2qb/w=;
        b=cl9ASqzSooX3KQ4evUNW17b7iUsjjhqSRNVgn6kBxudeNiZqit5WfUWAhSnTs+thEr
         pKfGV22ZKjgDu4UQ/BoqdrDijO4tCWsbjf+PKkAK5nk4+GE/S9Bk3ZDsjFvd2lBSqHxl
         s/VDn86Wh3+10oN23c+Gwb0THPi/I4xKe7GpDJrxZZdq6Sbih1TeUDLjQ0EvYSsN4meq
         fT6XI2bTkeScoikGPUTdmFvfV1R4evhZcTOA320XblXFFWoDpDzSqXh4Czp01IACkbPn
         X33Qq6CDhX7EJWTa/uVk8+sa6tQYV9/olxn+uBAqhwNVgMz401PYkVJHnNfzjhn+w3fu
         G8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706275305; x=1706880105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E318jbBI3Sfmaas3eq3UTLrKlPS3jJTstVGnWt2qb/w=;
        b=VOz5DkQw2uTZlVU2/HYuctoN41lJ5E/HsOtPyoUIqCpdIvC+hB73YSwwKRXYToSSKl
         B1ehtfDvHLL37vD9jJXpfb07bpDDNZ7tUx3E+MvqGMV9R65gQxtdpi5lATFOFwuqLdOw
         XzqnULubh++Wpj+pjlt46gl7xsiyfyIsV+biHc+cszyBEEO5+79AGfWEmP+gY8HJw2GA
         D1mjPLqySKl1/HMu00B9J5PYCPBA45RKAkPventP0ZUU/sULTqTV4wmrVaDDnPTK/yvI
         GRg8vUZR9IYDUNiSuarEsjxSfeTkbfpcFNmNjCwYswpOkRcOuMrPMj2SElTHbtl6F7Nu
         3XGw==
X-Gm-Message-State: AOJu0YxJfAYv5vq0E5Ga90SzDOxRBYrQOramtFEaKOxnkI0XpJgFI2O4
	exIOp2drhfGegvtai5uUs6mB5sVYb2I9oiEsQFFY6lsF/OWb6VyySHk6B0FCjU4FPMkKvGfu6up
	yZx4D99HuUiWqtOHdDA0NjYMTpZ8=
X-Google-Smtp-Source: AGHT+IH77LyfjdWdccbMaJlyxoI/kras+Q5L77PhaerHh21iJq5Nc/R3Kl9i6aKWv57a2uEW6hfoNKP6DNG1TJc+yX0=
X-Received: by 2002:a05:622a:6dc5:b0:42a:7e25:d938 with SMTP id
 ir5-20020a05622a6dc500b0042a7e25d938mr743333qtb.0.1706275304961; Fri, 26 Jan
 2024 05:21:44 -0800 (PST)
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
Date: Fri, 26 Jan 2024 15:21:33 +0200
Message-ID: <CAAgmp6t_emZ1GSnh56JuO9Cp=dJcf13rOCN=KdGMXG10nxBoEA@mail.gmail.com>
Subject: Re: WiF Transmit Power Control (TPC) Regulatory Requirements?
To: b.K.il.h.u+tigbuh@gmail.com
Cc: wireless-regdb <wireless-regdb@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 12:02=E2=80=AFPM <b.K.il.h.u+tigbuh@gmail.com> wrote=
:
>
> Ideally, TPC should be a fully automatic mechanism that reduces
> transmit power between the two points to as low of a level as possible
> while delivering the same quality of service. The purpose is to reduce
> the excess headroom in each link. I.e., if you could still link with
> 65Mb/s towards a given direction using 14dBmW, you should not transmit
> with 20dBmW.

Just to add to that, that for most if not all of the EU it must also
'provide on average, a mitigation factor of at least 3 dB on the
maximum permitted output power of the systems'. I read this (not a
lawyer or radio engineer, so please correct me if I'm wrong) as the
average e.i.r.p. of the entire BSS must at any point in time not
exceed the maximum allowed - 3db. This would include AP->STA, STA->AP,
and STA->STA transmissions.

