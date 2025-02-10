Return-Path: <linux-wireless+bounces-18683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F6FA2E28E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB389164B82
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3135957;
	Mon, 10 Feb 2025 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="W7QAJvpw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265433E1
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157520; cv=none; b=gAu9CfsFVefEfB2PO+uCC5q+kXsF+hOjvL1VagbYYi5snjZR4yD5CTkNRjwPv0yk3vW5ZY9jhSpAZXaM2TytPIhUt8BEieeMiiAyNxKmE6WMjeiLnerQACKooJW3hw4AGsL1vT+gxeQAww5qFC5Y5GPJvVTdtNF3TBPqI4pagT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157520; c=relaxed/simple;
	bh=hIZZNF/f2fX958BU67olkn3jTNmSrGUDkwHjxiC6/d4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=f8Ed8ajMMuF8q52EMEJt2CAK8ahBTwX36ExNwi2lc+Nr4Q0BJ+Dwp/dKxnKudJSDQxZ01E02Tej7TZYs+BPQiP/b7ahrVhNLB7zuX90064XFdyY+fKFf4fWH+cw1oVMchQpZVmRCvq50vX5ZyAoxvspTg9WlFFDTog9qvoI+e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=W7QAJvpw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A3IYIZ01565847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739157514; bh=hIZZNF/f2fX958BU67olkn3jTNmSrGUDkwHjxiC6/d4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=W7QAJvpwRiC+/xsPK1xpZE1dxU24WyV/SeirZZwJk15Xnvc+4968xRhUhegyHblp8
	 Ops/yE7SXVgq29VaBqR5CTjy4UeiGKbsuu8dd1PEHjgQMJOS6hS4qUceiFdvtku/SN
	 a2xJCDOyen7KtHyKZROu4xFbTUdVEMnRb6pk4DrB2J5E5Y8Kh8eGHQyCxagx+Mt7d4
	 DKb8Ois4TUP9U7bFOTjFcewa26Lskg9yefALvP9wJ1IwrqvdjFECJUOGVbAa8uHXv4
	 MNvNgBmHccyfr5d1dN/Jp3g2OfBolccNuKubHnHlKimUYSVGxwFsKpYPcv1SGQTRkI
	 VFm0PeyEVrhBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A3IYIZ01565847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 11:18:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 11:18:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 11:18:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: call power_on ahead before selecting firmware
In-Reply-To: <20250203072911.47313-2-pkshih@realtek.com>
References: <20250203072911.47313-1-pkshih@realtek.com> <20250203072911.47313-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <81718f85-3b5b-415a-9fc7-b91e1daa5a16@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 11:18:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Driver selects firmware by hardware version, which normally can be read
> from registers before selecting firmware. However, certain chips such as
> RTL8851B, it needs to read hardware version from efuse while doing
> power_on, but do power_on after selecting firmware in current flow.
> 
> To resolve this flow problem, move power_on out from
> rtw89_mac_partial_init(), and call rtw89_mac_pwr_on() separately at
> proper places to have expected flow.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

d078f5857a00 wifi: rtw89: call power_on ahead before selecting firmware
5dde1a569c13 wifi: rtw89: ps: update H2C command with more info for PS
1f0efffd5978 wifi: rtw89: fw: validate multi-firmware header before accessing
2b8bdc523701 wifi: rtw89: fw: validate multi-firmware header before getting its size

---
https://github.com/pkshih/rtw.git


