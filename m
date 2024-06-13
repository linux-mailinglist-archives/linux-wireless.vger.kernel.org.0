Return-Path: <linux-wireless+bounces-8987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F12A0907D37
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 22:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9933C1F24F14
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF66824A4;
	Thu, 13 Jun 2024 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmvIrAaM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A676EEA;
	Thu, 13 Jun 2024 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309717; cv=none; b=F4PtL99XPus1GAW1DLn9E+nYwbkMYjSJrYSnighzGq9ZOzLiws0Zkj46iFDMyzXHQWcb1d00/w+mXOf1sT47SDnk4Ice/8g/ZM0JlEVB/sV8RMxFIj5q7JnuNMzJ4DWMSyMpVlyEZ+ow/4t4XbKa2B0eFt/UorCpqb9FE2vhB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309717; c=relaxed/simple;
	bh=0VyVbcu1boTZF6DwGTdBdmpjhkqK9llX60FYNycn2ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBgsfVh6JWU+FZABItouBZln3rAj+tVWcQkG9h582jIGm9Rk4nTcRbI/wYyaVl9d9fZGbfgi5EMOqzniWHTd+pBSGCKnMXO0I9HsClZwSR+wZLlaKP4rYKbzEZPLyyAiEacUIfnYHqtShKqb3Xu+zl2w4OaYbao8XTDaJ/vO6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmvIrAaM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f70a87fd16so875125ad.3;
        Thu, 13 Jun 2024 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309715; x=1718914515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbflSuWMUpgqTUBYoUQqUfwyzkg6nAlYMJc1UzV9Z44=;
        b=HmvIrAaMRPwokdkSDGSBC6i75K1hyf/m/C+sz9mNqxRoExKgHZ3hRAXMHVNK/FUdTY
         2unrmgub+Ln3kFQTSDpQmnA49or6Tqr1NRadURR12EZZzQ1LJdAClzvs+H14tSIZCe9w
         3TarHah53zcJT4STsifGfZW/93L/mVA44m7fQSV/HikSesC/wTjmYQ2ZddDhEvfr4ByS
         ccCXrayOCYBeaD/BTqcgxwgh91qQZ98bCstE1fi+mnbRyrlgG/l1kZ2Uwk1btWPb2OtD
         RYcreOw8jK0x5mtw+0KpfZQwEOpzcB03/bjAUkbP4oHJ9JG94U5Nl5ShcgzNtKuet9A2
         TglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309715; x=1718914515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbflSuWMUpgqTUBYoUQqUfwyzkg6nAlYMJc1UzV9Z44=;
        b=ftLgsDOjF5WorAWO8MJHCxBU8F20zd2SV5U5KXh3xr5zWdD0SjswqNlJwCRYGEjRX+
         JTZRWvQwIdfF9fTWdz+dd9eiZ14RlwDzQHD3PA09spb5sc0NDWKgVDoFOg9Dz+pGSjOU
         QsUf+8ZWOGN2hiJMsr6Fe4VigrWU3yaUTW3M4nucGOxF+58b9Wnxa+6GJjnWiJHFun2b
         f/q2a4nIX4gu3NuC5ZcOrJU/nFg9cgCfph4lAGWdOF8m2p96EIOIVBCxfiDx6q7SjY2L
         K/msrTlIb1UI9Aq02i0yLbGwTMNga3eFkIHUREwmAGhTLbu9JjbkaPXgHOLLgndWAshp
         gnVA==
X-Forwarded-Encrypted: i=1; AJvYcCW+1aB/TLnQLwu6dXCuj2To9jSz6FY0CVVcT9Hate1j5saT6WCvxvBnncLxoBHuqb2gW3BRSXdyNgXVJh6lDP0xKWvtYoMW0qE5IuRkLtNQGAFtk4sRJClfnS/1KFP0I7h3mtMOapCT2tWYx6c=
X-Gm-Message-State: AOJu0YyFQ6ICsigS+ytX/R3WHx6JVcQlp2yMb3aAlMwLxYmtXupw4z5P
	wE4w3AND59/VvVFTTBS+UQnsVYjrVAC0q0vGk/91emiwtRP9G6qP4uCIgft1VhM607TowimDWqv
	oZxr8bdh3ebwFD/sQUbc5F8k5rqQ=
X-Google-Smtp-Source: AGHT+IFmx3oQAQqw3JJ/zFU64xUpwOUXiRy5J8pNaJ8mcjqFV74Sy3HFNb8wQ9haUW3V4Od24xga70MR9vX8OI9ddKQ=
X-Received: by 2002:a05:6a20:f385:b0:1b4:4ed4:91f5 with SMTP id
 adf61e73a8af0-1bae845b35emr838497637.6.1718309715376; Thu, 13 Jun 2024
 13:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
 <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
 <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
 <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com> <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
 <35750452-e362-4dfa-803a-3360a4e16cd8@quicinc.com> <6e556f7b6b769c4d70be3e248b98d8d09d51452b.camel@sipsolutions.net>
In-Reply-To: <6e556f7b6b769c4d70be3e248b98d8d09d51452b.camel@sipsolutions.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Jun 2024 17:15:03 -0300
Message-ID: <CAOMZO5CN_kbPcEYsN9SqqfUyrJdq9yaDisfJKL+CnENVTPuq3g@mail.gmail.com>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Johannes Berg <johannes@sipsolutions.net>, Will Deacon <will@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, miriam.rachel.korenblit@intel.com, 
	kvalo@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes and Baochen,

Thanks for the great suggestions.

On Thu, Jun 13, 2024 at 7:37=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:

> Oh. So I guess try to pick up commit 14cebf689a78 ("swiotlb: Reinstate
> page-alignment for mappings >=3D PAGE_SIZE").

Good catch, thanks!

After applying 14cebf689a78 ("swiotlb: Reinstate> page-alignment for
mappings >=3D PAGE_SIZE")
on top of 6.6.33 I no longer have the flood of alignment warnings and
iwlwifi can be used again:

# dmesg | grep iwlwifi
[    4.295064] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[    4.305459] iwlwifi 0000:01:00.0: Detected crf-id 0x3617, cnv-id
0x100530 wfpm id 0x80000000
[    4.315440] iwlwifi 0000:01:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
[    4.346029] iwlwifi 0000:01:00.0: api flags index 2 larger than
supported by driver
[    4.353816] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 89.3.35.37
[    4.363135] iwlwifi 0000:01:00.0: loaded firmware version
77.ad46c98b.0 cc-a0-77.ucode op_mode iwlmvm
[    4.444427] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX200
160MHz, REV=3D0x340
[    4.604918] iwlwifi 0000:01:00.0: Detected RF HR B3, rfid=3D0x10a100
[    4.676138] iwlwifi 0000:01:00.0: base HW address: 3c:21:9c:4e:16:6x
[    5.339929] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
[    9.840136] iwlwifi 0000:01:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 1

Will, is it OK for me to ask the stable folks to backport 14cebf689a78
("swiotlb: Reinstate> page-alignment for mappings >=3D PAGE_SIZE")
to 6.6 stable?

Thanks!

Fabio Estevam

