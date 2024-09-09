Return-Path: <linux-wireless+bounces-12655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87379971539
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3EE1C20892
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA71B29D9;
	Mon,  9 Sep 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcHFhZfa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF661AC8BF
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877432; cv=none; b=QuWztShm1tViGE+tAb3mZ2YZSrGnXdwX9z2M3krTm7Fzn/U17fQTrBpU11AjyASYzDkQrE6s3n903Id6/+ZI1UPXTPN342i9nL6hNg7a0M4hA1GObZx5aJF8QbXlWcqYywhxvFh+rNEGIa2ucAYNwi8NFVuW7PvyqwRz0J4bRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877432; c=relaxed/simple;
	bh=h61LGH+S84P2w6OPgDLzP9DQzLyWs4H4IVlYbHx9+yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=SuqbTFppO8EgmEluZEnRT4NNr1C3pVB+yD16KLJ9qqJHvb6QgHA5kMwuxJbd6kHnXIheOjDO8NHd1nluMymFn6azU99LyZ6J15L4o99A0Rgfh5kWxAZA/OQ6xR1ube8TC2Hobur++DXjzKqSqaBU71DIR1qf27TUVc/Mmn2Rsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcHFhZfa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c84dcc64so3100760f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2024 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725877429; x=1726482229; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiNp6Bs5OiARYdGamLrScaqZ2kHMNObdVSq851tJm40=;
        b=fcHFhZfamSyk3hGb8eXG9d2Z/jLAuJKTjtBqKX68+nvMIxG8fuXFU2axNsuWWUGpBf
         GqnueiXT5QV4pY7omdnk4gQEPobIRZowMdwyzb1nLoy5N3Wabp+XlT2nzMvrP89830Wf
         llETRGj7gazyeDEmArN1SIKjxadCfr8BWb2xWtIPH1K91fCwFT4tjdO+J/6G1dAaNx/P
         Mp/qikkFOKU/55qncO8caDOnBu+2YlXWqiaWOI3tTqAO4fhac35YbdcVcOoWxZecwJqs
         npgvLjHbDfhiRmsBgVQb2RANSx5HE4+cm6LAgbtopqqEcKNUw5JXgynUzZCnw3T37Di7
         cRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877429; x=1726482229;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oiNp6Bs5OiARYdGamLrScaqZ2kHMNObdVSq851tJm40=;
        b=haF9xK/qWkSnQMDmBiwcYji75kMy1kxYL2Rc8TUcaNJYohdpbtkMlzvl41oKhDlnOD
         cWvWcligsXTEINWK2WP/Kmn3lOEdq+WiVmHMwZpLi/k7Q4SzbjjkVo6D58pEvKaURiSt
         p37WDcIPy/ao+ipb2DItrmYb/fF5S8wKNi1Yly+SIv7ZDBr/qvXJr1joozGK9QOhepst
         skDMLk6Qh7u3nHO76eZVRvUFTdDeYDSvfk1PsKvDt5WXlkVzQIvo6oTosUw6739tURi/
         38P4jtrRZvIyaRVKPxDYlvO7SmP+wL/IgYCS81Pzu1jjpmPtCNlJwoq1Lpt1YJ5Tcfuh
         MWxw==
X-Forwarded-Encrypted: i=1; AJvYcCX3JrjJNwpxBwQSGdYJcjEJEE+I6/0YgqBPhfRmWO68CsUIPs+f5i9H3bEUu3Ua9ypAbnVOr0Afv+kupaw87A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7iyyYeth9R2q31zuPhMX7ivQ9cSAssiO2lt/SFx9GcLWeaZ+
	+IzxigOpAvkB0WfigxgSKUiGLOt3811F65cTybq+gbANQdn/U/vf
X-Google-Smtp-Source: AGHT+IFDDHzFypmB0ayJiExvuzqMfUAgm499uUtVMHqaG8+AfQm2YmSU8hxvh56gKCcg1m6keIUmzQ==
X-Received: by 2002:a05:6000:2:b0:374:d254:61b3 with SMTP id ffacd0b85a97d-378922a6603mr5577585f8f.14.1725877429113;
        Mon, 09 Sep 2024 03:23:49 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de3aesm5644202f8f.110.2024.09.09.03.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 03:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 12:23:48 +0200
Message-Id: <D41OHKZYZR9E.2JD7SQKZBBYGH@gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kalle Valo" <kvalo@kernel.org>
Cc: "Santhosh Ramesh" <quic_santrame@quicinc.com>,
 <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 "Sathishkumar Muruganandam" <quic_murugana@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
 <D41LUTO0MIC3.12475D2J3VNX3@gmail.com> <87mskhgpox.fsf@kernel.org>
In-Reply-To: <87mskhgpox.fsf@kernel.org>

On Mon Sep 9, 2024 at 11:07 AM CEST, Kalle Valo wrote:
> "Nicolas Escande" <nico.escande@gmail.com> writes:
>
> > On Mon Sep 9, 2024 at 9:30 AM CEST, Santhosh Ramesh wrote:
> >
> > [...]
> >
> >> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wirel=
ess/ath/ath12k/mac.c
> >> index 137394c36460..6d7a005d83b4 100644
> >> --- a/drivers/net/wireless/ath/ath12k/mac.c
> >> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> >> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif =
*arvif,
> >>  							chandef->chan->band,
> >>  							arvif->vif->type);
> >>  	arg.min_power =3D 0;
> >> -	arg.max_power =3D chandef->chan->max_power * 2;
> >> -	arg.max_reg_power =3D chandef->chan->max_reg_power * 2;
> >> -	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain * 2;
> >> +	arg.max_power =3D chandef->chan->max_power;
> >> +	arg.max_reg_power =3D chandef->chan->max_reg_power;
> >> +	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain;
> >> =20
> >
> > For what it's worth, I already got a similar patch from QCA a few month=
 ago, and
> > it fixed some tx power problems when scanning so I know there is truth =
in this.
>
> What hardware and what firmware did you use? The firmware branches can
> behave differently so whenever testing something it's good to include
> that info.

Well what I tested was with the additionnal patch provided. So depending on
Santhosh response, I'll either give the proprer tested by tag, or if the pa=
tch
isn't needed. I'll need to find some time to test it :)

