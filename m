Return-Path: <linux-wireless+bounces-14955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92639BDE81
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD139285156
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186A36D;
	Wed,  6 Nov 2024 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OJZ4DBhR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE26190678
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873286; cv=none; b=gI9gZhkdnJXG3xYGJhT+9Gk/87cempbnDNXq2/hM2a2++GmHR1p/ENpIvYLYttaA8aLMI0f1WjL9WdrScaK/0dX1RMc3uusGJz7lHnPgkw2AQ4zvJJfGp6PYbuJccZ5JtbwnKnA07b5IgzvorBE8/dbeBdFWBga0MUR567+tSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873286; c=relaxed/simple;
	bh=r52qQgVELj0v7xlRDfuF4y4goMIHOu3Ouy99KdHa0Qk=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=IeLxOsogmo1jaJF0Fqf7zWVLeVp7j3kPme+rCQ+U100F500/mf+Rut6usTos44a+E0eDWASSf0VELtn9xlxVrm3EQfH6jVz+/9XWnL7QekEee9zxobZ79xAPPhZ0LPLWi7WfQqAefnfWd/wkvG3JQ6uP79DwETHxUkEWXLKDwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OJZ4DBhR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A6680C402293637, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730873280; bh=r52qQgVELj0v7xlRDfuF4y4goMIHOu3Ouy99KdHa0Qk=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=OJZ4DBhRg7ex6gEnSlnUQpW2id2qaFmp9yfSAbGus3tf/8BqYscQ3HldicdjJ/751
	 8yxjbnmTHLMbo7wtOVwikQZc/axTM8ShvdTZ1Cn8hGwWYgz3MqXSYv7VHZwwzttMd8
	 F80FzUpjUjjOCQee9iBed+XeVnL0jx39TJlUlLSz8BaWsyKd43ssY65bwJSDSvi1Dl
	 Z1M8+JurgObFNcWmomp9SCK3Ol0ILkpEVK16AIFxDCFlntUtFTk9McUa0dZs3BgCyA
	 pVkbEGJ2zrAB2eEZLIeH25ChKX0wmd767a+YS2ZZ0ZEydzJB6aFsut4uVZtaInFt4b
	 uh3uO1krhxrcw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A6680C402293637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 Nov 2024 14:08:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:08:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:08:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: rtw89: efuse: move reading efuse of fw secure info to common
In-Reply-To: <20241030022135.11688-2-pkshih@realtek.com>
References: <20241030022135.11688-1-pkshih@realtek.com> <20241030022135.11688-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <71479741-7977-4ca2-8335-2d844456abee@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:08:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The secure key used by certain hardware module is programmed in efuse, so
> driver should read the information from efuse before downloading firmware.
> 
> Originally only RTL8922AE can support firmware secure boot, and read efuse
> during chip power on. To extend to support all chips, move the caller to
> common power on flow and add separate functions to read efuse for
> WiFi 6 chips.
> 
> No logic change at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

d230e215e3b9 wifi: rtw89: efuse: move reading efuse of fw secure info to common
0ce1df1cc352 wifi: rtw89: efuse: move recognize firmware MSS info v1 to common
e1551a79c499 wifi: rtw89: efuse: read firmware secure info v0 from efuse for WiFi 6 chips
40c06adf63d0 wifi: rtw89: fw: shrink download size of security section for RTL8852B
86ee0024e582 wifi: rtw89: fw: set recorded IDMEM share mode in firmware header to register
f9fe3baeb204 wifi: rtw89: fw: move v1 MSSC out of __parse_security_section() to share with v0
6d995ef770af wifi: rtw89: fw: use common function to parse security section for WiFi 6 chips
da824a86b07c wifi: rtw89: mac: no configure CMAC/DMAC tables for firmware secure boot

---
https://github.com/pkshih/rtw.git


