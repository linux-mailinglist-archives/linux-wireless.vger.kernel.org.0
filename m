Return-Path: <linux-wireless+bounces-23908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E1AD2B53
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980667A652E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935C19C553;
	Tue, 10 Jun 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ueDvNltS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A827472
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518961; cv=none; b=GtxpHrE4v3nKOpCG3DWwQBvtyPP7GTmJ+t3x8gkphnGn2h5upDYdF5kmaj26EJrzWVzWS+xtm5WvM23ttPISyjbp4TrR1hUen8B+lLs4TDPsP8A5mMpH2kt5upX2XbmSI8LdoBalAQbWqTL96AWXQTIkYCBgCGuRg083RhgT0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518961; c=relaxed/simple;
	bh=gJDTeje8NqXwwWC1q3xtDGeK0ojxQzfKJEePTtq4bTk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=lGrj8QqAWCgbY3362vNpwFEzVAK4gG8gjqksQvzCU+8w7IH3esKmBhWmzl/RWurRlxsv0Dg4qezfLUEbsD2G/g1uCvClRIYyGb1hav2prczB6+9YlwFJ4h9WsNOOMmbd+WtP1EaXmM+oONLkLaTRGVpjQUjae6t6iaszzThT1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ueDvNltS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A1TDgY42049623, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749518954; bh=YZUS+SdICwjOr96nSj971Tw3M1A8Jk6/3COe2TjA1YQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=ueDvNltSomehljvpFwJzoAKkNunjH7neLAiiDe109LhRyR/wRKH+0sWQERxJuNRMk
	 GTqnei8ctI3SlvmDBpdmMWNlsCK5WWVV4JjN8CwlR3rqB/q8QvhSwUs9yNYody1t+6
	 75A7BMiGu0FJ4a9NS8Mrbgfc/Dx1yhqgp/RXJmGxkmu/xisEUAhp7hdFlfrkY6AhhK
	 +0WcESvK2u2JASTPpca46+hI80MEEE8kOQZbcG5HGBVo/jR6aSSXl2foT3/6YARKb9
	 ObeI3GgRmC4M3L0VJeHnDhDL5lLgScpemJWoer6DoVsGeO/wKoYyBFfgkgnATQeW9F
	 0nQ1fAL5PG4tw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A1TDgY42049623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 09:29:14 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 09:29:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 09:29:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw88: pci: add PCI Express error handling
In-Reply-To: <20250523062711.27213-2-pkshih@realtek.com>
References: <20250523062711.27213-1-pkshih@realtek.com> <20250523062711.27213-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0ea21399-9bc5-451d-82a3-e53901478f99@RTEXDAG02.realtek.com.tw>
Date: Tue, 10 Jun 2025 09:29:13 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Sometimes PCIe Advanced Error Reporting(AER), like bad TLP or
> Data link protocol error, happens due to unstable pci signal or
> no response from PCI host.
> 
>   pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
>   pcieport 0000:00:00.0: AER: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
>   pcieport 0000:00:00.0: AER:   device [14c3:6786] error status/mask=000000c1/00006000
>   pcieport 0000:00:00.0: AER:    [ 0] RxErr                  (First)
>   pcieport 0000:00:00.0: AER:    [ 6] BadTLP
>   pcieport 0000:00:00.0: AER:    [ 7] BadDLLP
>   pcieport 0000:00:00.0: AER: Corrected error message received from 0000:00:00.0
>   pcieport 0000:00:00.0: AER: found no error details for 0000:00:00.0
>   pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
>   pcieport 0000:00:00.0: AER: found no error details for 0000:00:00.0
>   pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
>   pcieport 0000:00:00.0: AER: found no error details for 0000:00:00.0
> 
> Setup callback function to call SER function to reset driver to recover
> from these states
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

cdb82c80b934 wifi: rtw88: pci: add PCI Express error handling
16e3d93c6183 wifi: rtw89: pci: add PCI Express error handling

---
https://github.com/pkshih/rtw.git


