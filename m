Return-Path: <linux-wireless+bounces-9118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5490B328
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B531F21FE8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5C13AA5A;
	Mon, 17 Jun 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlcMyTRD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FC13AA48;
	Mon, 17 Jun 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633301; cv=none; b=S+bD5kGQ9r0/+hFDP795/hnBu8uF6Ri0sQC9iPtjq036qj+/1OWV+y6sWe/dDjSAJkElG1CaJWzoWYrjQP9gIsHfLd1O1LhKgR44MkdQhd0L7DI8FgKJbAtEwfjn7aDGu9pjTVmBqgin2H2MyKG9SSOo/yOxX8pj8oZG1YwCxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633301; c=relaxed/simple;
	bh=WXbjESbsSniDe5JAAxAHYsoDTBYof7BSAyMy5UDLhcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElIty57YUiEdgp+QWi1hLQAHlZ+zrPu7ovlG1VVPOS4JzUD4oSx/7FP6hsko5eU1+ABIwaf+ZBrA0HnXA4c9nehudWP7KjjTnyEww0nHvSf2mL8Y7WQ7O9WsTQPQeIKI+0Df2jemx9MB+kSdBo5cJ3nJj7KIYnJ9iTGE+sAP1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlcMyTRD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f737bd5cfeso3778385ad.1;
        Mon, 17 Jun 2024 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718633300; x=1719238100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXbjESbsSniDe5JAAxAHYsoDTBYof7BSAyMy5UDLhcg=;
        b=MlcMyTRDAwP4HYq0XrUvwNkqFaeXBao+C7WqognFz0RYCfRa0K2YKtcxjzpRGTmAI+
         dugY5UjE4H+fXTBfFwtgbgAnJVu0C0/OrCuexxJ4b68GrxJNKWdISVmN070N8Kpz4eXR
         uelUqDcowFKoHirRS9OTpCceprzxR1jGtSke0mHpZ8fR5ySlJPMzJUdW/4vSGItd9rJf
         Bekc1xdEdvv4DtmuJ6ODiTWRu1Gl0FX65AAQoGuxDUepTUhnSth8mRIbDt+iFhYVSnCf
         QoLpWhO3Q+kmoiFbdLYadR4tLsttsw2gd4bswHzEmsRc1PyX9FdbqFdodd7v0VD8duLM
         vWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633300; x=1719238100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXbjESbsSniDe5JAAxAHYsoDTBYof7BSAyMy5UDLhcg=;
        b=bgnxSBsbXKDUaL38DsN6j73uvTWN2XIrCWl3ZXTrBsP/jJOfgP4Jn+rJf/KCrQw36K
         0WJLr3tkYeergAdxD03skNqGx+lKaQNlKgF0fBsHNx5+CBQzsUXNY1VC7wMDnYZbCAxL
         HnPt48fMlwzlg9XlnSOgtDd9ZJrSYas7PS+zDPx7mbEPvJYSLrlXuHGo9Ui77/bbeMoz
         WSO2RBpCyV443aD4WL0cFYTWaJDBu+5GmZs8JURMbsn0yrr1ksB4POuzNFycVYfqSLjb
         fp1y0MT6YXcA67g4iozvTLtrvyYw7OUJ18aiwBRrdhQTAGgT4K464/k8fzZpaDjENSIs
         DwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW9uVkGSNa63x3pa45Jt5aDRv+gLXAeXD2D02B+j3lU5cfQh/YhMWsDuSqkTDpnbcDWgqoVke63+emKAaXDZ2E813+fLUT6/A2hmLCIq5LXwErLxNNjCDsEieiqUbAYvSraBBCeZCPr8abfjo=
X-Gm-Message-State: AOJu0Ywe3R3RjCUbXD2gMnQM1QMNB9M1lKi5Qk4m0CPzta0lbCiy4vYm
	6abJ/3PWtqNaUFqjlS1II59mp9puNCGZc9Di41kToMsn1ItI5tq+TyrxEVSmrfLYO5Yben5GWNt
	6jHFXw1LZVGo/ZL11+czp/IjtcbY3cY+u
X-Google-Smtp-Source: AGHT+IGsT72g2JwKho6wZZPiR4BwxAxLlHv99PK4li2By2akfpCprUp6s9FVHkl3+fIYafQVV5D0Bp9ztkF4EA+QkoY=
X-Received: by 2002:a17:902:dac5:b0:1f7:3ed:e7b2 with SMTP id
 d9443c01a7336-1f86253a470mr113738725ad.0.1718633299645; Mon, 17 Jun 2024
 07:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
 <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
 <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
 <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com> <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
 <35750452-e362-4dfa-803a-3360a4e16cd8@quicinc.com> <6e556f7b6b769c4d70be3e248b98d8d09d51452b.camel@sipsolutions.net>
 <CAOMZO5CN_kbPcEYsN9SqqfUyrJdq9yaDisfJKL+CnENVTPuq3g@mail.gmail.com> <20240617120804.GA861@willie-the-truck>
In-Reply-To: <20240617120804.GA861@willie-the-truck>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Jun 2024 11:08:07 -0300
Message-ID: <CAOMZO5D2Atb=rnvmNLvu8nrsn+3L9X9NbG1bkZx_MenCCmJK2Q@mail.gmail.com>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Will Deacon <will@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Mon, Jun 17, 2024 at 9:08=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:

> If you want to backport that change, then I think you should probably
> take the whole series:
>
> https://lore.kernel.org/all/20240308152829.25754-1-will@kernel.org/
>
> (and there were some follow-ups from Michael iirc; you're best off
> checking the git history for kernel/dma/swiotlb.c).
>
> FWIW: we have this series backported to 6.6 in the android15-6.6 tree.

Thanks for the suggestion.

From this series, only the two patches below are not present in the
6.6 stable tree:

swiotlb: Enforce page alignment in swiotlb_alloc()
swiotlb: Reinstate page-alignment for mappings >=3D PAGE_SIZE

I will submit these two to stable and also an additional one:

swiotlb: extend buffer pre-padding to alloc_align_mask if necessary

Thanks,

Fabio Estevam

