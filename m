Return-Path: <linux-wireless+bounces-8077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B78CFC1E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B204283CD9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC95FDA5;
	Mon, 27 May 2024 08:48:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52705FEE6
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799686; cv=none; b=qtvnsFt6T72m3THTXCp3CoUnwufG4fvFsB9kR3fd6KT6L7qLOADK63RVw6loHN7HBlA0VGvUagSIYt9E6X15cxS3zSJckGI0LKF1hu933PjuiRjgYd1g8FyGqR38xi4PxRM2S5YltAvsLRF/o16zR6wLYSUMrTMBhkYngRNCDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799686; c=relaxed/simple;
	bh=3cYSNLp8pCzBJiAmAG/iEnFmzQiNyZFh5MRjYQh50yk=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=LhjG17+hqKIPYdirnJAnDHI6yE6+xH4ihOvJiM84QEC+xNvnwF+V9xgHQcydVP7CR+/Kpd4iyTk+aeqsvDS6aKXkAViqE6EMdohL4CUMmWynVizdwdjq3TWUm9NDTzNhgZ0N0HfTfOvSD7sfchOeYO2OU1ZYbxrNf/vrUCGe2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44R8lwoX7956409, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44R8lwoX7956409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:47:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 16:47:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 16:47:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: 8852c: correct logic and restore PCI PHY EQ after device resume
In-Reply-To: <20240521040139.20311-1-pkshih@realtek.com>
References: <20240521040139.20311-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <28823fb3-88c6-4acd-9bfb-350292d4d163@RTEXMBS04.realtek.com.tw>
Date: Mon, 27 May 2024 16:47:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> PCI PHY EQ value is missing after card off/on, so update the value after
> device resume. The original commit only updates once at probe stage, which
> could lead problem after suspend/resume.
> 
> The logic should be read a value from one register and write to another
> register with a mask to avoid affecting unrelated bits.
> 
> Fixes: a78d33a1286c ("wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9e305a6f01ad wifi: rtw89: 8852c: correct logic and restore PCI PHY EQ after device resume

---
https://github.com/pkshih/rtw.git


