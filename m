Return-Path: <linux-wireless+bounces-14624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488C9B4113
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 04:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F05282954
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111101F426C;
	Tue, 29 Oct 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="K2LsxP8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF416F84F
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173004; cv=none; b=Yn56DDxyseCPBaFPy2zntwWmBHlsTCBvT+KgvkWYiSPw+FIDcZf+357q2KynWmSfUswQHhw4TNBEKf9QE1lcwo0MAXXAV3Sb/Dy6WPBHTE6Wc++BYOl+F+erGqgGyD6+mXxE+8Yv2JLi+9N/76TDRgWEhRB5wdPojDnr8PXp2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173004; c=relaxed/simple;
	bh=BFWDPQfhZv52j0kxil9iblMKzSoMBZe0ftMxSioPYmI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ldg9uNdK8fIQK/GxkY1xQJ1cAzy4jNyOHxFtPzg/rBV/NSgTOu0KI2qeBWj70WWosnG7bDx+D8AKcrqCfWfwuZCnwa1UDuta2u9EVLJbg2so/HRuj3UlF81h6IFwfMlboB2CIECdceFoOzf566jLFG1pl4jtDMn6sbi06XIejzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=K2LsxP8Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49T3ab5N31784559, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730172997; bh=BFWDPQfhZv52j0kxil9iblMKzSoMBZe0ftMxSioPYmI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=K2LsxP8YDpyzNDqI8D9rAwPXF6hivUmbzeYMkyR2AISpiuurhxfpbxzHKTvZd5Pq4
	 KALMrNJXfI7IcppkW4o9R8fn/We7Fe8aSB4xZ3UVhPrygB+Nlf7WXp32GBg/iJ5YtJ
	 n1Oa5mzcmvLuFgLAnqS/CMVTxexsAh/J7N/LZqzQ4V8LEQZ45ifBqXETOtFtF9EsZG
	 E2aDHqRRK5/pNN7bkmpCNmLqARir9f+xHz8saXlbHgFOfGPdFDypSnPXy8P2eyLls1
	 IrI5DxPIvsN5210PvKlhoo01V9SEWVpFKG1zYAAiX067/kbmjPjRmWhLbui2Scjszy
	 NFFHm3Z1AbVbA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49T3ab5N31784559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 11:36:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 11:36:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 29 Oct
 2024 11:36:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/5] wifi: rtw89: Add header conversion for MLO connections
In-Reply-To: <20241022083106.149252-2-pkshih@realtek.com>
References: <20241022083106.149252-1-pkshih@realtek.com> <20241022083106.149252-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c0745f94-e7e1-4e51-957d-6af17058985a@RTEXMBS04.realtek.com.tw>
Date: Tue, 29 Oct 2024 11:36:37 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> For MLO connections, this setting replaces 802.11 header addresses
> to according link addresses based on each packet's destination.
> The fields most likely to be replaced would be both A1 and A2.
> For legacy connections, it's the same with or without the conversion.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

b8499664fca9 wifi: rtw89: Add header conversion for MLO connections
c39eed4bd70d wifi: rtw89: Add encryption support for MLO connections
68ec751b2881 wifi: rtw89: chan: manage active interfaces
2305ebc1835b wifi: rtw89: tweak setting of channel and TX power for MLO
94318a40033e wifi: rtw89: 8922a: extend RFK handling and consider MLO

---
https://github.com/pkshih/rtw.git


