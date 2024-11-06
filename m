Return-Path: <linux-wireless+bounces-14956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244F9BDEB2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379461F244D8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070D3190676;
	Wed,  6 Nov 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gn88DKdc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B517B4FC
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873873; cv=none; b=an6Ne7Xg2cZCnO8CQSBm19S5gvvnTmPWbXFE2fDFaxUyNC9tY+T6jzvCF0O5FFUi8ah6C6d/qs7ghvymkkrAbPhYfRP/UzTI2zm3S5SDm/gIwFBO8N1ci260QMKcUvjJ83ZtGIiK71oCU4LdxA9RB9bYLsijt5s5tCP9PDZkCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873873; c=relaxed/simple;
	bh=fVXFleIMy6IW9mOkcWLIg49GU4QUrQXTFtVmk0sGdMs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=LhvBJ969E3LSWg5uqw4RcD6ooPrP6jCZpffYGWWRtAtJIxqN+nWViYk3qEsa9YAHk8wrf6ObB1yv7vrVF/RnvKAvYkyrfZmoBP72ZoGFcd0ybJpGFygXPUIbVmNWSjbMR1MPkcZ6y9iFbQgOkvL/66utF/CUfwDf7DNt22ULb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gn88DKdc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66HmhU62303433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730873868; bh=fVXFleIMy6IW9mOkcWLIg49GU4QUrQXTFtVmk0sGdMs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=gn88DKdcD5TPqxAalpTvI1KInwMQn8ekaN/Pr1ChE2eF6nWK/t+TnjagENJUF1R42
	 0hKvN3Us9fo7C20bbSYeyhzYWtux1opeASawY4RpBOPZjBkSrIkmOK95/gGXY/jSph
	 hK4XZB241ryhck3d4MeVmoOvw3nI/U6v55Vs5IhHOQJ/pxYSijyvKbBQu3JTFh5OQv
	 PpohGbRfM430rV7J/JrZNOliETZAvhPtLJfGeU7L9LbyfEMx8DV3e9W0yBzs+06Iwk
	 mlbU6NxfytiFwT0FuGyWty1T3JAcUUTWxCbS2FFZASmclQBQzogjuzYFqfuMeF36nv
	 +/0aajuBkPCkA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66HmhU62303433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 Nov 2024 14:17:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:17:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:17:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: 8922a: fill the missing OP1dB configuration
In-Reply-To: <20241030022903.13243-1-pkshih@realtek.com>
References: <20241030022903.13243-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <84ae63ca-a6b1-4442-9f69-a24f470aaed0@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:17:48 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> OP1dB stands for Output 1dB Compression Point. At this point, the power
> amplifier starts to enter the saturation region, resulting in distortion.
> The configuration of OP1dB can optimize the RX gain saturation region,
> improving RX throughput from 573 to 675 Mbps.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

95fa94562298 wifi: rtw89: 8922a: fill the missing OP1dB configuration

---
https://github.com/pkshih/rtw.git


