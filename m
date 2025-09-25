Return-Path: <linux-wireless+bounces-27649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C080B9EE91
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8921319C1927
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB820E6;
	Thu, 25 Sep 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="axS/0vCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EF287274
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799851; cv=none; b=NPh4/USm3Fduno9nfZGv4PA2xrmpeA/FsoVQfiZ/TaRKIuuf5USpG6W0pkV55jEUqhRThykCIVA0LKy/WI9lNq6np2BDsaOEb8xyfocyXfs+JsF1g7wUClthOblkwl3/r/bG1hyM9dDm+nDSQRopaWE+s0JMO1wUJ+ai+qolPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799851; c=relaxed/simple;
	bh=LRnemnqNWUw7RqRTqpb5s+BboHjWuTOsbJFLzwh/52E=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=lWKGZOEG0692PJk03kn+yW1ErKTAMOIT+CaB1e/LPTB9rv3i/ur5o/4w92P0oXkCfklgjNf9cZ20PHfNuNPwEGZIW6r+hAnUEH9XETXHdWeqoSHv0GDSLkdyKJGtmoHLwfNEX3/d2uzn2u/yq5zjAAuH0GXQCVaMsaL0JrrGKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=axS/0vCE; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3o3f36kae5dhlimh5y7k5sj5oq.protonmail; t=1758799840; x=1759059040;
	bh=LRnemnqNWUw7RqRTqpb5s+BboHjWuTOsbJFLzwh/52E=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=axS/0vCEBrbUc9TXE0xWmcF54MU7bUhJUuClE02yJJdXuP3MQOJ3GHoldIfxIckA8
	 vns/YjBUDk5TunnNl+iKGlrRssHIZJQgOq8xdMe7YlwDt0DPaK60HZ5K++1+jU/lK9
	 SGVcD7Ry8I6AbfRtvWhe5uDL6UxOJhCajL5/a7OZjZ95ilSMkdMagd8i935UwRA896
	 j+9FV4lAnUl64yE+GYvKGMqhvILPtfiKxxBbzwzmXigTToWuLvE/wzf5R4aVolE/pO
	 KYOVgNL45znSynh7dMoyk6eJWRwO4sj2y2o0Y2bJfE3FPzB9KqDJfUo2wDc1E05J7m
	 Zobqo4kMpyNAQ==
Date: Thu, 25 Sep 2025 11:30:34 +0000
To: "nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>, "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>, "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, "deren.wu@mediatek.com" <deren.wu@mediatek.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: HMTheBoy154 <hmtheboy154@proton.me>
Subject: Requesting MT7902 support for mt76 driver
Message-ID: <zJTdgBCk5Us_-6bstYmzg2Trn-ntC0_mJyMLOvAQya5Jxg-wn17E3E_go5qM3aqvz1ncA2MV8bqTy_8udMubwLvsxkZuWCfav--IlrA-I8c=@proton.me>
Feedback-ID: 46487666:user:proton
X-Pm-Message-ID: 25682861f240f550ec316fee506f58e409dc0269
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, could the mt76 driver be updated to support the MT7902 Wi-Fi card?
Recently a lot of hardware like laptops & motherboard come with the PCIe ve=
rsion of this wifi card. I've noticed that the MT7902's drivers for other p=
latforms (like Windows or the Android BSP driver at the link below) show it=
's very similar to the already-supported MT7921 series. I believe this simi=
larity suggests that adding support for the MT7902 may be feasible. If not,=
 could I have a reason for why ?

Link: https://github.com/MiCode/MTK_kernel_modules/tree/bsp-rodin-v-oss/con=
nectivity/wlan/core/gen4-mt79xx

Sent with Proton Mail secure email.

