Return-Path: <linux-wireless+bounces-7101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D3D8B9380
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C47B208FA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745317753;
	Thu,  2 May 2024 02:59:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34ED17C73
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618754; cv=none; b=pcKCImoVp73KniZQmFlS9P5x/QsmLxxeCIJqZH5RExTJYWCTqTM40VuKpN9lSITA80DhhAMNZxC7F7rE3aG1MKV0J/Zi/JaDE5r6ft1EtJJk2+oHIjdkvIrKYOTmizzyT3gXqwbGEXWdVivJCjC+MldkPf3nxvWx7tUJhU6Qf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618754; c=relaxed/simple;
	bh=QTw7WtSiEJg9p/xE5xjkUT0IGby4XGmo5Wq2chDjlgI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Q4OhTyOQhJ5FQq1CmGAwJ58nsL9V91Xy+eJx2OUBXkP7rkF+br/BzFAoGEHYIAa4nbF6q5cGQGZSJS8xNgUXKeBdqgbEkZxGv9IUovexDNyrYYTNDHp8MIXFLejntTTBxVLwU1qxVQsGurmmBKfi51S+N44tkPpwSxRofO0vnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422x9T412049726, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422x9T412049726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:59:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:59:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:59:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <timlee@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw89: reset AFEDIG register in power off sequence
In-Reply-To: <20240426061200.44262-1-pkshih@realtek.com>
References: <20240426061200.44262-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f69ccce3-04b5-4320-be43-14784aaa0aa2@RTEXMBS04.realtek.com.tw>
Date: Thu, 2 May 2024 10:59:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Some Wi-Fi chips meet card lost issue due to unstable hardware signal of
> GPIO pins during power off. Reset AFEDIG register before BB reset in
> power off sequence could avoid unstable signal and fix the issue.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

535c045da60f wifi: rtw89: reset AFEDIG register in power off sequence
4e5957101d42 wifi: rtw89: 8852c: refine power sequence to imporve power consumption

---
https://github.com/pkshih/rtw.git


