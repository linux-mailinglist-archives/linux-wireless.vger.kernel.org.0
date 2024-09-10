Return-Path: <linux-wireless+bounces-12758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B497366D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 13:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3132874EB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47918B48A;
	Tue, 10 Sep 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="OtrEIHgk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D65188CDF
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968816; cv=none; b=Hg0FojJhxM9zrSRC2mcImu/IL4KKnytLlZ0G8txotAnGG186lW7SUvkbuTupRH7hPYVW6enlp+RVdVe19kifD4Vlkhv/uAdiXn3ayoXx3T2Pawfl0bAvYXmUc1V9epjt0DhDkxC/j/EsC8viGLxfd/mDCbOgGTMLZ7KZP30SAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968816; c=relaxed/simple;
	bh=Dp8FVCAMfjFHHrJU/+WRSCcBJDFm9Wm1P5xx/iVeluY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3Jwq/efBNab/582YvTiuAnNh7Wy2zeNQmeeCT+zMUVtHnFlnhFZdnf0UYPKidBTHCdzYWY8hH2LnWz53MbhIe/vZkGo5ZT1sG3HlEj8aSvbqnLSBgD35PWg8iUy0cO0zcQmxNNsQq1rY5aBdHvvpgsts2Ejb4gdOtigllVMWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=OtrEIHgk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3615852a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1725968814; x=1726573614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3cVdTlyiLbROx6VtFK10wvApSZ87I0tXOB74QiLmi4=;
        b=OtrEIHgk+YEQcfMKjSVRRaZLBUp2advHzlQ7fvOTN0XEX6W7v0J63U0mIzD0U0uLez
         SI51HxrHMIq9DRXx7DSXwHf5W8u3ZWECctRpQlkkYD6vB0nvz4u/Z1Dk3N4rvkMj2AgB
         8YxadspbuSYXdQfxOZyh2+nszgvT+hrF2rngJuyrjsIWkZQVJiFlwVBbzQYkez/G8vL4
         jJ7OedhIyVN3ZjHZx8U5T2jhssBj3JqTaJTwdW/zXuvm0h6C/ICzGis1ZmuUBn02J+Gd
         ngKQL6KxQZWdZe2Mm2o4MHOcEWayO0q/JsADOgwHepyI2IzwaTC7OLUtMoxa1cxT9ut4
         85qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725968814; x=1726573614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3cVdTlyiLbROx6VtFK10wvApSZ87I0tXOB74QiLmi4=;
        b=fOQrgooupR107EMhEDcn/E1swVaOj6mPpy2tdy3R7qTfMpHgQHRawICeb0qVV9tFFA
         5gN2sk7XfrUhGLXXBJDXm4U++jZT6iSvHjAnFfMpeMPjIwAsSo165sBNRcSJROlCUN9t
         54pm936E4F9xzJud3K5WCQUq/igsQzi8rCzs3Fid+bZ66ElkoIssE/t/v3HlSX3MVgxH
         ZCdEggItIRYaAF8H4IWwWxVQTwSoeI1mvgsP8GM0NDasUUIdOVA3k90dVLZRnraaKEpQ
         E9B6OQs79njz+Eu17xrIhNTDWJxo170vo5R5Fweh19pUqhWovX2vfHTvtH0YXXxQRH6T
         sUvA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ELfitp9EMDUZkGt/fxkYjJ3FEejg8j+kOVsBOGzWmePWh6ch4YLZ4GdbpQx0p4zr02K1VEcEmOslBmbrSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2L7TDAFrz/ZK6tt94vKBY+W3M08Gue0HRiHJ/0a5iizA71xEY
	Qq495MjH274KBO3/zoFf2+cVfBAmYr++bZsjhRKfBVakEAH2Rd8fPXr3VkxBmkNJcRw3LHacv6e
	pAR21lhQkpaZ31hHic2L6+RzdIXIbAFkUfq+HEg==
X-Google-Smtp-Source: AGHT+IFWMlF1n0oib92jKUMP9migRt2KT8rXo9OZgHZh3G/xI2ifvrcMjWGowcMeFpb/4QlwzzC/qdpkQMcerpb58U0=
X-Received: by 2002:a05:6300:4043:b0:1cc:de9b:1ca with SMTP id
 adf61e73a8af0-1cf5e11fcd8mr724101637.30.1725968813821; Tue, 10 Sep 2024
 04:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <3772134.MHq7AAxBmi@ripper> <87h6ang8v3.fsf@kernel.org> <2248097.72vocr9iq0@ripper>
In-Reply-To: <2248097.72vocr9iq0@ripper>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 10 Sep 2024 13:46:42 +0200
Message-ID: <CA+HBbNEOSMFWiRYxQwaH2DMEYuvccCG+Prt3R7dE2acfqpYJZA@mail.gmail.com>
Subject: Re: New staging repos for ath1*k firmware
To: Sven Eckelmann <sven@narfation.org>
Cc: ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	ath10k <ath10k@lists.infradead.org>, ath12k <ath12k@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 1:39=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Tuesday, 10 September 2024 11:23:44 CEST Kalle Valo wrote:
> > As there are so many different branches I have lost track, do you have =
a
> > list of missing firmware updates? We could try to push for updates on
> > our own end as well.
>
> Afaik, ath10k is missing various security updates - but I don't know the
> firmware version which has these security updates.
>
> ath11k is missing the 2.9.0.1 release - which seems to be still required =
to
> get various APs working correctly (without a crash). Maybe Robert Marko h=
as
> the newest firmware version (not the file - the version) somewhere.

Hi Sven,
I have actually found WLAN.HK.2.12-01368-QCAHKSWPL_SILICONZ-1 v1 ath11k FW =
for
IPQ8074, IPQ6018 and QCN9074 online and after looking into it, that is
actually the latest version
from QSDK 12.5.

Multiple people have contacted me since the FW spread our various
communities stating that
they have tested it out on IPQ6018 and unlike the current public FW
versions we have available
and use in OpenWrt it works stable.

So, it would help to see the new FW for IPQ6018 especially as it is
quite unstable with the current
public FW that we have to use in OpenWrt.

Regards,
Robert
>
> Afaik, there are even newer ath11k versions - for example for IPQ9574 (wh=
ich
> is completely missing at the moment in the repositories).
>
> For the completely missing ones, I've submitted following list to QCA:
>
> * ath11k/IPQ5018_QCN6122 (that might be rather complicated due to the way=
 how
>   QCA designed this)
> * ath11k/IPQ5018_QCN6122_QCN6122 (that might be rather complicated due to=
 the
>   way how QCA designed this)
> * ath11k/IPQ9574
> * ath12k/IPQ5322
> * ath12k/IPQ5322_QCN6432_QCN6432 (sounds a little bit like the QCN6122
>   situation)
> * ath12k/QCN9274
>
> Kind regards,
>         Sven



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

