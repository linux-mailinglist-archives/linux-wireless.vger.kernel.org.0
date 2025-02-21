Return-Path: <linux-wireless+bounces-19239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13054A3EA54
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034F53BD77C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 01:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2821C5F14;
	Fri, 21 Feb 2025 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZuhaZy3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FB6F30C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102528; cv=none; b=KCV+jFHEllZtT32IJCShi0n6RpIf4hn8BBvqn1d83ojvVSXH9V7xzocYkxESEGMRh4oXy2WSABaRcGqvT2DQM/Hl/ylC5jjFlFbaflbWLPDhj/eZQCBVuoapEheZAdAzqufWLNzyFrDJDqLEyBPezI3r1Y3URB75OfkhojRoEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102528; c=relaxed/simple;
	bh=wJkRFmA+3jRN+TogyAElq+XrnY4HkdQ3OLfLCAj7yhM=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=hD7PsTqwxAR4WR3e6wM3G1EGxMxP97rHplp0bbHO/bv9QxTJ0H8Q1GVg4iPmf2vgZuV5U4oujyt5BYReT6ioUXjtTWKixMlvHzS+2rkg8Yman/MTfrcCGR8KnKXcpOEsgvquX32THcc06jETYgIMoazSoNK+56ZYN9FRMUEFhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZuhaZy3S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L1mhwR7822869, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740102523; bh=wJkRFmA+3jRN+TogyAElq+XrnY4HkdQ3OLfLCAj7yhM=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=ZuhaZy3SR2MgRz5ahWBFjXR4ghepQD6lasxChC487viDKur+jhOeILihuBS7eGawB
	 7BosPHuf9eEWZl26AVPJFFTx05lPXH3zyvpWQnBV7vOnRWlL6ZdHkj5QeRR0hH56vp
	 adXIYLuK1+SehbbJ4eFif930kTc9daAg3VBIxxKBsI3pfBKyTgck/jAarQ/rQ6mQed
	 ktt89ReFDm7MhuGZT+46hyFMXY0yvrSxBVn+frrWbWoEqdPeWI4UFBVijqcZZSYWxo
	 7/aLcklED1BZsoAmQW7hsIcQ6e5YDni2ZosfzADuwmWFSkOCqBj+8v+w7O/oAGBHTw
	 SOCNK1tcr5ovA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L1mhwR7822869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 09:48:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 09:48:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Feb
 2025 09:48:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to share common flow
In-Reply-To: <20250217063053.38936-2-pkshih@realtek.com>
References: <20250217063053.38936-1-pkshih@realtek.com> <20250217063053.38936-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <db6ce225-8aa9-49ef-ae68-affce0a8ebab@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Feb 2025 09:48:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The agg_limit and txcnt_limit are used by BT-coexistence to reduce
> WiFi TX time at once to share time with Bluetooth devices. Since
> these registers address are different from WiFi 6 and 7 chips, define
> them accordingly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

a5b8fd3f07d7 wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to share common flow
c852d2abee30 wifi: rtw89: add H2C command of TX time for WiFi 7 chips

---
https://github.com/pkshih/rtw.git


