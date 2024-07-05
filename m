Return-Path: <linux-wireless+bounces-9997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3C927FF8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536C81F2144E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368562579;
	Fri,  5 Jul 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="h+Vjlcuq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D430634
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144733; cv=none; b=kQHNh5JlqPI1mX41fGPOCCmOE7E/zXAi/ZBfi0Yddgk0JveYISvM/URDO5iDWT/PalwJqCPwjSIWiHudjrzxR6jiQhXuhcxECwcf4Y3LZRKQXpoCc5LmynDPG93H/WaRRA6/2dIzFv3s/M+yEWQ1OlCzF5cqUlIy4L5fkWkNXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144733; c=relaxed/simple;
	bh=fDEjle3hz6lu4fzw6RxXV00RJWNJ/+9koCHGD/qDxMc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=U6WGAQb963Um7URVg+B9GHL7/KJFrJmuBTz2CPkARmjKFqw9+DY4XCgwoU0Yr/gRp6PMxf+dSWy71agGFUeflUiK3jQWy68nMrYfY2aiaebHkpuF+Xf4BNdXO1QkQIZcUdyj5JxezFjhVo7ynlSGX0fpOQg5B+cWMea6ZHH3OzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=fail (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=h+Vjlcuq reason="key not found in DNS"; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4651wna374094472, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720144729; bh=fDEjle3hz6lu4fzw6RxXV00RJWNJ/+9koCHGD/qDxMc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=h+VjlcuqGDmv7hOfc9C75TZHridWWPLcM34KmzEluLAXM+rQ+SSrLzeoLFH08X46Y
	 /JL053hhPwhkr2s97x59JXEr1HptjZIvYR9wbv0F6LaKhW0f9Wc5OYs315QODab5um
	 4qow2liIbCQZFPk9xq7ZegK0DE18ku8Mg4EK/n+648Suu5TkOvgNhC7CGLHwvdV9kM
	 v1wwuFA3hwTpRl9U8q1D4YP+zostQb8UZ0U8AheBguVsP6mRF8pp2rd2JTG3hQCaxy
	 BdgveBAnaw56lJb4yqfCRL7VAnl3fK9E59HRBmA94TgjJRT1EZJLLVMf+xtDlEzR91
	 jaRHdHzr/1/sw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4651wna374094472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 5 Jul 2024 09:58:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 09:58:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Jul
 2024 09:58:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH v2 1/2] wifi: rtw89: mac: parse MRC C2H failure report
In-Reply-To: <20240702124452.18747-1-pkshih@realtek.com>
References: <20240702124452.18747-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ecc84d50-dd84-4fd3-a595-0da57789b1a3@RTEXMBS04.realtek.com.tw>
Date: Fri, 5 Jul 2024 09:58:47 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> MRC (multi-role concurrency) has a C2H event for status report. Newer
> FW will report some kinds of failures. We parse them now and show by
> debug log.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

1e71be6a3446 wifi: rtw89: mac: parse MRC C2H failure report
8095364696d3 wifi: rtw89: unify the selection logic of RFK table when MCC

---
https://github.com/pkshih/rtw.git


