Return-Path: <linux-wireless+bounces-9824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CA7923C7D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40FC2816FF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD0143746;
	Tue,  2 Jul 2024 11:33:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32C15B55E
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920002; cv=none; b=ac2xPiu7S1XcBOp+kIkICyKHapSGgYAfx8nNYqqekAvpMi9UuWkpQhd+EMy1J2sLWgFnDS9Iy24g0592xXB3fw4aqFem4ITYc+eYpimjuV642MC9R91qQEwaHit4knGo5qYgX9lj86LYRkTL8JHBLR7mCXYcQ/E09b9evd5m7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920002; c=relaxed/simple;
	bh=iuicH2M3aEW+SRIVuKMYTGTZUGN64ap/cB851b4MTfE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cID+oTlalvcyyDaVIiOcftjxBZ5DIoY4va4jLr8QIwU3UFJQiGz0lAsgcPFy2JucVBtINrGMtgATYdG1vQ22KajWQbLhWJ+uEFICqapMsvtd4BGzrWKLB295zqoNS5jVwbz6IGHZXi+Net32ccqgBL6+ASUjUuRex9WkySTbodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 462BXHSJ0860912, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 462BXHSJ0860912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jul 2024 19:33:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 19:33:17 +0800
Received: from [127.0.1.1] (172.16.17.57) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Jul
 2024 19:33:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: coex: Add coexistence policy for hardware scan
In-Reply-To: <20240626023129.7776-1-pkshih@realtek.com>
References: <20240626023129.7776-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d1904b29-95e1-4ab4-90e2-a4aa4a0a2442@RTEXMBS04.realtek.com.tw>
Date: Tue, 2 Jul 2024 19:33:16 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Add additional policy option to let Bluetooth audio can play well
> during Wi-Fi is hardware scanning.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d2f299a4c998 wifi: rtw89: coex: Add coexistence policy for hardware scan

---
https://github.com/pkshih/rtw.git


