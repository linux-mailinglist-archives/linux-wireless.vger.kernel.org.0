Return-Path: <linux-wireless+bounces-27584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFBB9169E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F23A4E95
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26D30BB91;
	Mon, 22 Sep 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IaeRSp5f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7482D3720
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547993; cv=none; b=jIyZawrT4aeYO/OoK6WuUp/EE7YJtRN1GLJzgciIh+PePeA3amCAvaz7F3s9hK/KigluxIbImCGZTHmDyXv+FHK8rMaApIB6Rj37nohCeK6AvPw6/rT4WLHbLeVzTRcuashoF5VGpuOg9TDTP128icjsHt949rxsnRCyuub7dWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547993; c=relaxed/simple;
	bh=ju/+Tk1jIZw8C+PDK6Uifc35Hld5yaogm6d4PJKSVxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBaQq1u8cVTe0W8h494nS3C/b+42zF/LNeAGibHVvEiDyJhSx87ENEWXivJpIMMLnux0FHca9wEY62M3oZoTr0K4bWd015HBNMxgyLi1vsT3igZhzyfvHX2kb1PJE0pK+c0JWT+HLN8ItWtG9h+7VOzmnkDheRRfzdes5WMBhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IaeRSp5f; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso3053361e87.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758547989; x=1759152789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju/+Tk1jIZw8C+PDK6Uifc35Hld5yaogm6d4PJKSVxM=;
        b=IaeRSp5fW3FI4cjA2qid95VidKwoAWpdi78h1l+cJVfevuWQpKNOo9IbRWtKtA5mwa
         1FAWVUSwrR1YjXSnc4iTGqhKkMiQe4oGGk+l0Z62YzUtbCb9qoGZg8WyuGsoIK8Bec1t
         FTkY/U8Juq1JA/+ACJekmouAQ3KircfHYMO+70OFxPtbPMZGPquIExujnSVD2eWSApOe
         LfPueYV/MG1bXAbokuowgkUM/CrBkbXjKIb2zoImPpAr73qZ/p/6Orw7GN3LbRjQZkQW
         /dVm3ReZ4MdvTFe+ayvEztR+vak5zHwzmGT7bBUaj8koJzf7yjzEkQWJcEX5SWap3+PW
         KclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547989; x=1759152789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju/+Tk1jIZw8C+PDK6Uifc35Hld5yaogm6d4PJKSVxM=;
        b=HS+kIN4NzXtm3dMtObYzH5Ag0VhmRjNKUoawepWNHRTTDh2P87zvcRUn9BMDhH6M9v
         SDBQEjQMJQD2ppMtbWQ3uSkKNR97vV6KhmaWXHj97Dm1vyKOF3uHeS4g54ecP8WD9XWk
         BrrDKst+WbB9tqhKeNYVH5fDwX46Q6lEZSXsfRxmQLmrTVcbHZCLq8B925dcGjqn+PBY
         x1OSw42QCzWdkcYro+R2y83Mg8psrmzTHyDiq2ZNwYIlBg/8LKx7YwC/CPaGSwlH6gbl
         35bW5RLyXGBFocI6AwIhCJWhSyuDrl3JP73H7tfERMDFDthUffWsdgmVJEOSBhguf2OM
         GZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrAEP6IvUmGedYSxBFBHDXmynech5rDCDsH5V1IAzfUeIIwwudViea05eNv2PZ3WATMBmgN4VyrWTSmJcXGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVnMfMSXL8w40MnLoMXvDLDQuQ51wsSlrADcGybzzbOQaAegl
	qcWfXGlQzhcUoTOwz/X4d7AZqHf8I/qkEaApYzLvsmKAzIGj8oyem7p6ls7/AHWM2HO8xje5q5n
	MsXhG9Ze4RGHvcNZB/eaMqVCqTgwk2djR2vsJecmZCygkHLRM5sbl
X-Gm-Gg: ASbGncsQT2byyGhB3OvErMgiTMA+9jvUHyxPMb+xVxFm14pjkwY5E68KRjglL2PAo1t
	cJRU+N801AJebf/kWj5uwZz+A5ad4oWllH5RiqYXvnhp/dfg6DBswcoWUVOdP1pt4/zoOe2rgCQ
	Vd2VyjnOBXn3AvGfPhADCqCm+mvb1n+/LxdFS9Buo2aaB1R7sDxOrx9J5f03Am+4rDbsyG8CDlD
	J9o00u9pQCVDQIESp0Ptsu/JaOAb+QlbQCKC5q+
X-Google-Smtp-Source: AGHT+IHTBjNX0HP3ZCkaVoLL4eLDrptLZmHCvsE+kJJ3VY7J9vfIkHf0tBWobs9HDVtvaVyexH4mBI1JSmF5zBtai5s=
X-Received: by 2002:a05:6512:2093:b0:55f:503c:d328 with SMTP id
 2adb3069b0e04-579e2cc187emr3681505e87.36.1758547989257; Mon, 22 Sep 2025
 06:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922102407.186660-1-marco.crivellari@suse.com>
 <20250922102407.186660-2-marco.crivellari@suse.com> <b64db199e6e1cd09b26f44d2e8cc1bec43b163fd.camel@sipsolutions.net>
In-Reply-To: <b64db199e6e1cd09b26f44d2e8cc1bec43b163fd.camel@sipsolutions.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 22 Sep 2025 15:32:58 +0200
X-Gm-Features: AS18NWBfPDmqzwWyp5Hr3BDD1B5D9T66jY4pTEMJ-g36rEN9zorzdVIGywuXji0
Message-ID: <CAAofZF4=UgS+hH_fNry-Sjt8O1wzrEp2x12pcPzh7oPETUZ0-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: libertas: WQ_PERCPU added to alloc_workqueue users
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Brian Norris <briannorris@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Kalle Valo <kvalo@kernel.org>, "Dr . David Alan Gilbert" <linux@treblig.org>, Jeff Chen <jeff.chen_1@nxp.com>, 
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:33=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> On Mon, 2025-09-22 at 12:24 +0200, Marco Crivellari wrote:
> >
> > With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND)=
,
> > any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ=
_UNBOUND
> > must now use WQ_PERCPU.
>
> Which I guess forces a decision, and should be kept for a few releases,
> but ... is "keep what it did" really the right decision in all places?
> It seems to me that for instance for libertas here, there really is no
> reason to be CPU bound?

Hello Johannes,

This change has been massively introduced only to make explicit that one
of the two flags must be used (preserving the old behavior), where WQ_UNBOU=
ND
was not present..
Going for each subsystem and checking who really needs to be per-cpu would
have been a future step.

I've already sent a v2 for a few other subsystems changing the old behavior=
.
I haven't seen per-cpu work, so removing the WQ_PERCPU flag and using
explicitly WQ_UNBOUND instead, is not a problem, also for libertas.

Thank you!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

