Return-Path: <linux-wireless+bounces-26442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424BB2B5FC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0F35270DC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 01:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65116DEB1;
	Tue, 19 Aug 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AXXcABDs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006391E47BA;
	Tue, 19 Aug 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567017; cv=none; b=NTyEah9MT01KBkosJCNtmKEVQJ/6+XRSLtI+etoBVt+Tj8nGsnn3ZcEQo9wt8ZFsOaWwOwMZr5NIwpvKLpoWH1l5mvqG/y5di0MW9rnGbhnF6r5f5LEXyZd4R0uSwS15UJZKw/Qu2UlpGka3pCCRAK0FAJ+xoPAXyUB88VUz9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567017; c=relaxed/simple;
	bh=KrhjKHWaskiquIZeVdoF1Nx4OCf1G6OqoI6qRcTp4yY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=vFn/xufF17XXNU6fA/mCbpiHZs1i8nbrAR+Rfd8iAuA58oIKLoyReLrL3QwtQgzltnJ9eS0pQ9PtNqXzw0HiAvj8QwsDjDq0OVkAfuOrVTmAhBXX7cM80WFr51Pfkg8wPkbKVhWdXJGYdqgxK4NAHNF35arO4syT3gtUT5FeVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AXXcABDs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J1UBuI41863213, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755567011; bh=7CVQ5zTljnh9TMNtumXoAl/dBzTmJgMU/Okh09Nc/Ac=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=AXXcABDs9m0kCxO87gXRPgiaWDD+m/0nxErieAPuPuXRG+vAKoEhHW373VCUfxwAp
	 MMjrMKabTb/N+C51M4ibBJnglKL2DKroAJfMv4++RTcJQB7HnfmHnKQyOD/vJMparg
	 lni6uQ84xot626jFIE1WWtOiEX4PZDUFPWPmuQbcjLjTAsAQUqgWqBF3b3AajHCdXo
	 062gObV7JM8DCWd3CwCIyEDDrk7zJbAZYNg2yEiSYDAzEqa3/BQrkq/kG8WcX2tmPH
	 83ZbduEUa0Ha0Xo2HkLHrkj72akT5gsVEgHU5h2kPgMmp3hVeRRPlClRMYjwishHbR
	 VEF6L3LQfyNgg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J1UBuI41863213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 09:30:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 09:30:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 09:30:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Ping-Ke Shih <pkshih@realtek.com>,
        "open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH] wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions
In-Reply-To: <20250818064219.448066-1-liaoyuanhong@vivo.com>
References: <20250818064219.448066-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <92d7b814-5f0e-4fc7-8a0d-d3d2daa244bb@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 19 Aug 2025 09:30:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Some simple if-else logic can be simplified using the ! operator to improve
> code readability.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

33319e8fd7ac wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions in _dpk_onoff()

---
https://github.com/pkshih/rtw.git


