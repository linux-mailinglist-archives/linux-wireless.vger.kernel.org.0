Return-Path: <linux-wireless+bounces-9627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9D7919D0E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4621F22FCA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC832139DC;
	Thu, 27 Jun 2024 01:52:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A7211C
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453165; cv=none; b=BEo+Mm29eHW9v2WZniH4DG3Wi8pdT1V7VmOv7xu6ffgXE0NxLaI1z0qqJDQdO3RP9N4IoZDzBMlo7bfZQ4NHEN62bkBahEgZOdNo99Pb0ZHt6OD+iGVEAVDX4JJcuSAqnbvuOfaZdN6pI0qYwdAoDX9I+VuIiXM6XaC4giwDvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453165; c=relaxed/simple;
	bh=VbEZvq4/mXCzBYdfD2dwiJ+Kafunor7JHI1UsBfiqVQ=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=l0fHPlG084bRnLrD7LVmTuNL2aH5wM+GvBZrxS4Y+ZonITCqdXqGM7pA9jnhlig+BGfsDtTWB6CxG8trPCxJ6ImKJBmtLKvE46M1HTLGBJKuxx03Wa44yae3zw+jJWDv1bWwdwk5skXtNwPsIyw6RI1Ead4OSd9Uid6k0e9fWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R1qd0oB2499681, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R1qd0oB2499681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 09:52:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 09:52:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 09:52:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852bt: rfk: add TSSI
In-Reply-To: <20240621073458.55187-2-pkshih@realtek.com>
References: <20240621073458.55187-1-pkshih@realtek.com> <20240621073458.55187-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <2c7416eb-57df-4ab8-9175-bd8300d27633@RTEXMBS04.realtek.com.tw>
Date: Thu, 27 Jun 2024 09:52:39 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> TSSI is transmitter signal strength indication, which is a close-loop
> hardware circuit to feedback actual transmitting power as a reference for
> next transmission.
> 
> It does full calibration when we are going to connect an AP. When switching
> bands or channels for scanning or some reasons, reset hardware status to
> prevent use wrong power value feedback from previous transmission.
> 
> It also loads tables of compensation values reflecting current temperature
> into registers according to channel and band group to transmit packets
> with expected power.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

9f8852a92e82 wifi: rtw89: 8852bt: rfk: add TSSI
5b8c61b82eec wifi: rtw89: 8852bt: rfk: add DPK

---
https://github.com/pkshih/rtw.git


