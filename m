Return-Path: <linux-wireless+bounces-16882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7210B9FE195
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 02:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC9A1881EE4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A687EAD0;
	Mon, 30 Dec 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="X5ZiMd0b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA533F6
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735522156; cv=none; b=TNxEYriEWpgC1T3DygfstUClyJgoMUU8Bw5vNCE22e0qeWKJh32n1MPW/TBVHDr3O54Ee6JjjL+6oMYfKL6v+zD0WPkE9963HQJvBmwyxAy5Mfbk3vN2NqCI+2OSMNZFOmgWFuxvBmGLOh56mDHZOfh9jalzeYyPcs26G2YcYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735522156; c=relaxed/simple;
	bh=c/3i7NzUhPUMS4mDyd+04eOZ7yiYGDJEPmhXgWdBHT4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=sqwXAzBKxa2HbbyFgUyn1cDqOrsPHraGhEQ9AHOXcfxKUg4KbYfNM8zoM4naA0QbgWPMHswGJrPn8fDfMZ5Jj1WQLuFBDP1wrmUd9iWYS+qsYuVqhruryNeRWRa6bZK7zSM+jAs8mO+M1iq5gC78izpEEKSSA4qxjOIXzKbdx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=X5ZiMd0b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BU1T8ajC3532665, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735522149; bh=c/3i7NzUhPUMS4mDyd+04eOZ7yiYGDJEPmhXgWdBHT4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=X5ZiMd0bu+SWdmdWnqjTheMrFtE3AyNsZ0/kiW6QN3Wm4pZtTr/miblGcMP8bEeOv
	 2wxlKMQBjoTkdfCls5KPtgx2wFsgjIR7aftgf+lX48JQ5KW93fRjlmI7j+bb5wO6ZJ
	 cXvoNn2HLlQHLUQ3Lpik8AwOsqW83LotEyMzwETM3N+xJ1RjfzIcdZ+tHC11V22yZn
	 sUJpPxs01q2Gh5QME3ATAsLjE8Uh5w+xhIfC295btZtOAdJ57Dt/IQ7xY/NxcDZYvP
	 wcQrOTs9aYJneUH/dIwn/3n0gKeviYzNUgIvf7p+4Kp+9MY/d1pz3514YV3YopxYab
	 nJvmSJ2xmJ9lg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BU1T8ajC3532665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 09:29:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Dec 2024 09:29:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 30 Dec
 2024 09:29:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
In-Reply-To: <cba8e2f2-32c4-4174-90ba-0219f29dbdde@gmail.com>
References: <cba8e2f2-32c4-4174-90ba-0219f29dbdde@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f3aadebb-46b3-45bb-ae45-a63b4fa4b45f@RTEXMBS04.realtek.com.tw>
Date: Mon, 30 Dec 2024 09:29:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> A user reports that the firmware upload consistently fails when it's
> uploaded in chunks of 128 bytes, but it works when uploaded in chunks
> of 196 bytes. The official driver uses 196 bytes also.
> 
> Link: https://github.com/a5a5aa555oo/rtl8xxxu/issues/2
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

93b3a45645f1 wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size

---
https://github.com/pkshih/rtw.git


