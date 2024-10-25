Return-Path: <linux-wireless+bounces-14491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172699AF75A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15A31F2285B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6871750;
	Fri, 25 Oct 2024 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SgmUM3No"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E879C8
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823036; cv=none; b=XUUev6mICzfCN355U7rjEbW05MVFv6Odf9V4QP0jgOtF0qVW5tN1i7rdx662ro//SPYvs1KzOAUlNtuvScOTXmleIgmrga59ss0GORhrzb4CQ8WeVkYU52AVul+VAMg3bUpiqkuE3ejvaGxXpQbgp+kkb+0x4MuCnK1vA4heAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823036; c=relaxed/simple;
	bh=2O3ECHGMsX/U3EVMt6ktijrd9zYiBL4QbxZHj2iiIbI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=uMBeWwrMMgWI8793Xi9LjgbfFvFIRgis7+bY1jwCLmjRgtSi4ho+mykZGCOoGPyobPwbkAMc05CzdvIvMhYW0h5AIC1qSQbuN4EAISW9duosU5l2JWnqCpsrCK4DVcLAW/ZgPVjeTxlXHCchGyyirXsrJIWPQjNXuuvJ7AKwmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SgmUM3No; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2NqCqA4097822, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729823032; bh=2O3ECHGMsX/U3EVMt6ktijrd9zYiBL4QbxZHj2iiIbI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=SgmUM3No+Ktqo0BwDKJ+PfIpx12BWDmOyQjyjnejJf9T0ntMtSupgpG7PApOy7zZX
	 skKW5i4dv9QOyR2R5u18WDhopzWLa9DniGbQGGaNwokZYHk6sYnJf0qOmdx/lNE8/B
	 mocr61ZObocfPnnH98DPvfxl/V+ETN1l079BxsifWu2tTMpwOnj4Ev1I3uEKyLS6sS
	 r0IUtADAf6txKXfOg85h9RmM4FkXSSXhH7sglKpTqd/ImlY9cVcPwLMCA/EJLRdR5P
	 ARTd7SJA3RMNuFMrOeEnetwid9kfdBR7QNOBHONcdlp6KPABwYiWswl/yr/okSTioN
	 nU7Qpi3g7gt+A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2NqCqA4097822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 10:23:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:23:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:23:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: coex: Set Wi-Fi/Bluetooth priority for Wi-Fi scan case
In-Reply-To: <20241019063131.9462-1-pkshih@realtek.com>
References: <20241019063131.9462-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <44c60230-5ffe-4014-b2d1-31f4d417f5e3@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:23:52 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The priority table should be changed according to what the in using
> Bluetooth application is. To avoid Bluetooth audio + HID (mouse) will
> trigger the lag experience, update the priority table.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9dffa44171d9 wifi: rtw89: coex: Set Wi-Fi/Bluetooth priority for Wi-Fi scan case

---
https://github.com/pkshih/rtw.git


