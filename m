Return-Path: <linux-wireless+bounces-28697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A848EC434A4
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 21:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE0C4E0437
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 20:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066371514F7;
	Sat,  8 Nov 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KCCnmSDV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086A2AD25
	for <linux-wireless@vger.kernel.org>; Sat,  8 Nov 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762634575; cv=none; b=Ufrk55uqHpKPlNd3Am/r7hoPn0w9Ks5y3LskMni45CfHt9mJ6+//W2iQtcfINf/4sUxBUXl6jsWUSmzX/i4tbz3oboCoQlw/3QQcU/qPgMo1gKLVV9dZMjDrt95jsCjXI5fc5dHcwJ+3lINsumEC2gbSvb1vSn3ueUmPYj+iwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762634575; c=relaxed/simple;
	bh=rvz22euyiQuemd7gE2/WyX9KUivWOzw/dV0pveuzV0I=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=LeipTd9/RN4L7pNGBE4q+KoLfTBNKSuythOYLsNtCDjk4B04zSG2eouSrf4I+SdH7HZeQaqehlJoh8h1EU1ke3SBeQsTUJ54O2c9kMUGMgmvWdlAAb/vvwwCxAWfAqg8daOFmEx3mbocRrE5qaXV0jRU73WH+27wJ7ehuATpEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KCCnmSDV; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762634556; x=1762893756;
	bh=rvz22euyiQuemd7gE2/WyX9KUivWOzw/dV0pveuzV0I=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KCCnmSDVrZiGE8SSJgvbsc7+5EIn4h8GCGTdtf0z4B1Rxnnf4vyJPLK3hvKsimtC7
	 bQNvTy5fg2jxCPt3Re2RWJzKQDjjAS3LTkTCsAkfv35iucavrJ9r5opx7sZd4sPerH
	 rMU9Rm/IWUGCFFdplz0D7HEUiWnWmjGaFmz1U3rrG7KgbiiSLxV8v+ZvqqAkA+gVXi
	 JOqu+ETsFEakRBe+0v9YE2kMhLITJovktRWup3MLBtBPP03kCVRqyIkOPeEjkyEMBP
	 SWyNkHjZnZ9RqozFoDulaS4mE/KCyx+KR0GMfR7HfLfMhWFbnQ3pOXF8Ux1owTIiD3
	 uSQWioot5Se9g==
Date: Sat, 08 Nov 2025 20:42:31 +0000
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
From: "olivier.perardelle" <olivier.perardelle@protonmail.com>
Subject: [DRIVER REQUEST] Status and development plan for MediaTek MT7927 chipset
Message-ID: <HQybgWTYrvKIrFPV4I0eMUz6ppxBw5slyhVQ8KRKxEg1ZkVkQYKjP7ggfQUDQk_a5bQ_1hXkylnIdv5jq0NTEODzuNeVOiPlAvQop2AZTTE=@protonmail.com>
Feedback-ID: 6491766:user:proton
X-Pm-Message-ID: 468efb95342101b26cb1ef375adce661723f3c28
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi developers and maintainers,

I have a Wifi 7 adaptor with the MT7927 chipset I can't use it on linux sin=
ce more than a year. Would it be possible to prioritize the delivery of thi=
s driver?

Many thanks for your help

