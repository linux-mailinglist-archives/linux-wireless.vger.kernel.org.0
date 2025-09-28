Return-Path: <linux-wireless+bounces-27685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21EBA7614
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 20:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207D57A0439
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE422422E;
	Sun, 28 Sep 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="BujgXpBu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BC635
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759082605; cv=none; b=CftYcOp93gt2uLSAac9nj7ZGsTu7oMktACFU0iJxv1F9n0vlxgk1by22Nn1ll2DNHfRgwWqoJWqAy/nkvbz4mfKS94MeNpvrMIeRcj96mQOhsPYn1d5KlH50oWCx6e0x99aGge5vmrVv7IeeGRVFZF2ndbKiL+HzjbnDbAvXOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759082605; c=relaxed/simple;
	bh=bgunawdgQpz9eVGimH9e9PPLGWTVwubqsnssgLynuY0=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=PP+weesLmpNdBWe67IwM4v1TIPTk8sk7Zji126Mbtmt+4Ml4EtVOh2S0o65IBTUUDDZQbr8F46noaa1qHN4JMWSxChtoMuQVKrWB3SX6N5zffuaElwJpHfOD8j0PuKQgIbNDZZGtFgUT8jmq9fHJ+1yvxjPUof4BG6x/09l3LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=BujgXpBu; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 70383C83238C
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 20:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759082601;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=RhndnqCrVGzN2GkgijhrFCwMWs0Mokxd9sKqMolC5yY=;
	b=BujgXpBuR3tSt1fbfg7VXLCotz4EDXWLuvZ2KusrKmY6YaFyHn+S2imVwWCXoMYL
	4SNxG/KZoyCkXmLCL3Ij2jt8brS2oa8XIBBw8idMCzBv88mdYr+l9f++09Hc+JIS6SL
	dTCc5Xfnq8RLaMLAM7oah6M9Lmreh+RnFJhx6qg4d1ph+jqTXc8Zith4E1yN/+X+e2Z
	xgOsurE2IMvLyr8aaNjvfz4OgxrJ4RYogtWGEt32+FsL7hZgobAOORAW1Jgzz4jjXVl
	pfacTVPsDo1PKwNKOy/8ps+JrnPiPnPZW0CJuDVB85bRhJjtMh4G/gx7guNbFUDuH26
	2xTs/AydMg==
Date: Sun, 28 Sep 2025 20:03:21 +0200 (CEST)
From: cybersnow_2001@tutamail.com
To: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <OaGU_Py--F-9@tutamail.com>
Subject: (RTW88, RT8812AU) TXPower enforced for regulation only and not for
 user preference
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Can you look at issues regarding the WIFI TXPower being enforced by country regulation that cause problems? When people want to bypass 80211 regulations, we cannot do it. The original Realtek drivers permit this but not the included kernel RTW88 driver. I know you want your driver to be compliant to 80211 but I cannot set the txpower to 31.5dB on my RTL8812AU adapter. I would like that you include the max power capability of 3149 mdBm into the driver with a module parameter that could disable any limits. I'm forced yet to stay with the old driver and i'm forced to make patches to it for newer kernels... TXPower cannot be only set by the regulatories. It limits my hardware if i'm somewhere else. If for example I set the country HK, the max permitted is 36dB for 2G and 5G. But how the driver know the hardware is limited to 31.5dB? 

thanks,

