Return-Path: <linux-wireless+bounces-10351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C736934CDB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF53C1F22852
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16B313B780;
	Thu, 18 Jul 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mWufwUOg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281113AD38
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303914; cv=none; b=A2Oq0KMRIq5DGxB1ObD6/UBvU5hw8qtMhZeZbzCg1Zelg7hg2b1xDQy25LLWvzFEv03GJUTeJgvR2TV8eMG0GLGU/E71ex2Do/LFpXceiJNwmoNTsq8lkl+OSo4rfxpGmWwWlczTE+cVFAf8pAiv6Tv+qwiP6FSjK7qRF2wxvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303914; c=relaxed/simple;
	bh=FFrNdvWWjN63s42BKAKBM8xaz6ftXrgEKRS6jcbmJL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3MoTWt4JGZgfPZ9h/CFh1IpkeSjcV1a3oWMfqiiNhBf8hkoT5IKdMvf9j/5yZXQs2YKrThZZjgmFWhGkOf5uh9KrxS1JqH7Olcw2LThIrEQ2TgIEuhEB2X9aBho7uM5RDX9PvxrwL4a/lGhx7fR/SFwwwp5s+sWBdF2vPwsZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mWufwUOg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so1575215e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721303909; x=1721908709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT3/r8iq9vh5IHb+laarDBOv4FqNaSgzXd7Frm5ubA4=;
        b=mWufwUOgGu9tdiTbF+wwaBViwZ/n4VkZG88CacADd3i1zoS9DkkZusfrOmHeK/jtli
         Np/roYCnPe/6gkZWafuTul7lmwqWOct92+bai0+qHrEjtsqT/9krxKTRlxCe2zq2rYvv
         ASYfWg4jaZMhWrVKMb9zOq5kI/rJQviCHWeK/o9qB7DB2ECMjFjn7SMvqlH8SLgGQGxz
         CJplTKapwkiyg8sm6kBEKMrj68Iez0l3L60XL0SrUo5m82q3VKstqAULLMEROCSnuErU
         pc71vIg7gz5X+z4zGwuqAeyodqQUmUyBvspOf974PiNE080Sr97Gn+/iH0N0vhRxCO7z
         NxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303909; x=1721908709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT3/r8iq9vh5IHb+laarDBOv4FqNaSgzXd7Frm5ubA4=;
        b=jK1d1B6TKOag4fVLpCO7S19KgbkifeTIB28LRdORQje0kgcg8wfu4fwShSQBt5QLDv
         1fU5SW9SobZtsk54r7f6hU0++dWWiWH6Dx9plqqHuSRCaKt6GWhKS7VJyNmciTf2CfDe
         ufJ6OhmJBa2R61HJNWQkIqRy63wXLBeV45qsDDA4bGCDKfBPdt/jJ0RmNrY0C1nmYQmk
         80zu/UjpskMLa7dxZ/bA/u88pHLsOLR52X18j90y9nOAehlQ0MCQ7esGwAO4pyFTmvVA
         fsEMWOYuaodEKEZbtWYS0Az8CVbBjRn48xfoa4Qfh4yQ1V05McPc/xPKI/tIZflarexJ
         Ps3g==
X-Forwarded-Encrypted: i=1; AJvYcCX2ifd6v3LS8BBpHpp7uL2Sh4pKvPIhR7xs1Kun7a5k/ZxEwOK2OPl5yCijAIFshAkg7sXAS2Le6o2cyPwpPKy7z6tOz8oKmy+Xr7ZCVpE=
X-Gm-Message-State: AOJu0Ywft0yXwagHGc0ZJx/HYceUHr03gEbU4qNninW9haa+Q19a61fF
	N3MrPjLE+56IXDa8SH0eWtFKxQYLMSVtvT8lD1bdIcYretTwJoG5v2rGsujNZwk=
X-Google-Smtp-Source: AGHT+IHpOFhVVOR50WDCPfi6DXrjDJkGmwaqmpgdsmAo5+FCsTxtL42b6u3Rfj/yngP1z/p7fq9EnA==
X-Received: by 2002:a05:600c:4751:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-427d2b527demr5295885e9.13.1721303909431;
        Thu, 18 Jul 2024 04:58:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58d4:2f84:5fcd:8259])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368467a34dcsm2258703f8f.109.2024.07.18.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:58:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Kconfig: reduce the amount of power sequencing noise
Date: Thu, 18 Jul 2024 13:58:27 +0200
Message-ID: <172130382340.64067.7765392027721457700.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717142803.53248-1-brgl@bgdev.pl>
References: <20240717142803.53248-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 17 Jul 2024 16:28:03 +0200, Bartosz Golaszewski wrote:
> Kconfig will ask the user twice about power sequencing: once for the QCom
> WCN power sequencing driver and then again for the PCI power control
> driver using it.
> 
> Let's automate the selection of PCI_PWRCTL by introducing a new hidden
> symbol: HAVE_PWRCTL which should be selected by all platforms that have
> the need to include PCI power control code (right now: only ARCH_QCOM).
> 
> [...]

I'm picking this up into my pwrseq/for-current branch. I'll be off next week
so I want to give the autobuilders the chance to play with this and I'll send
a PR to Linus with another pwrseq fix I have queued tomorrow evening.

Let me know if there are any objections.

[1/1] Kconfig: reduce the amount of power sequencing noise
      commit: ed70aaac7c359540d3d8332827fa60b6a45e15f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

