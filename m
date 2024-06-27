Return-Path: <linux-wireless+bounces-9628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7C919D11
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C778283D1F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 01:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D32139DC;
	Thu, 27 Jun 2024 01:55:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A6DF5B
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453317; cv=none; b=gHb+l16FcyBfYobDSzm/8G/F97EA8ws3flTdb/goug6KxxCYkEQiSLjqrgXg9kkYUQU9fmY+ezxN6PNIFAoAFcpLDcTabYETkRdf7XfbGeitWEv2z/7CDoebvA09FgkGvVUhoYnu6K3elQHzcHkYzsxUWK4isABvf0QMNNO+/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453317; c=relaxed/simple;
	bh=Wyx7td2ftbKtr3VWttHA417HujZSzOd4iJWEyfAf1BI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=DhLmUpClMB0ftXwfNnI5Kv+Qti6CsARUYm4XTJcY+34uW+lRfq2GvYB2yy7bUgzrHry/pHA+Q3/3GKyWxSvV9WX59jU0P8H8A+RqtMIO8tVK3QlXhgtZw0R6j54D5freAsOiuQ7L59WTujwBoNhekDBqtFPq05xynwUUx+qre7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R1tCnU52501119, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R1tCnU52501119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 09:55:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 09:55:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 09:55:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852b: set AMSDU limit to 5000
In-Reply-To: <20240621123617.6687-1-pkshih@realtek.com>
References: <20240621123617.6687-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <755a3c8b-da37-4d1f-ab02-ec6be7a222b9@RTEXMBS04.realtek.com.tw>
Date: Thu, 27 Jun 2024 09:55:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Enlarge AMSDU limit to improve MAC efficient to get better TX throughput
> from 851 to 895 Mbps. No change for RX throughput 902 Mbps.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

5f7e92c59b8e wifi: rtw89: 8852b: set AMSDU limit to 5000
2f35712ab826 wifi: rtw89: 8852b: fix definition of KIP register number

---
https://github.com/pkshih/rtw.git


