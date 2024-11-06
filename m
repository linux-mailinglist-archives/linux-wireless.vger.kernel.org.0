Return-Path: <linux-wireless+bounces-14960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F01929BDEE4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EF1283998
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167118FDC2;
	Wed,  6 Nov 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="d077eUMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E7191494
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874727; cv=none; b=jcvN0n0UXV/oFQkFsbiSnrYAqZr53YIw0H6ECuoh/J+LnsLg3xvKcEbszRVbHdmPg4a/tpOfa2YZcgYPM+A17qFCVP8wTPfRhGEQm5+jg5WTvVgJZKpI9BUoIU1tNC3z0wvuKruVrUYIN646upCRZ6XZ01ppnYllzg3TP2aoH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874727; c=relaxed/simple;
	bh=4rAJe2o0Hs+9TLmwLJ/S8IeIw4bXmSevkksvHRhFAR0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=iH3b8PqIUKaJvbvgANp/qQ3HWJuHacZNBexmWCad08WLnTRyYouYIT6MTrgtBXHkI0WOmYefxUsbYNn+iJXdjPkyPXfY9+wuzVN0ME3WZ82nOIJjYDnfN6T7oB1cEgXbp+fv7XtBvtQRMr9Lzb2zPiNXy6a2f380mnJ8xCy3KP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=d077eUMm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66W1Q402313880, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730874721; bh=4rAJe2o0Hs+9TLmwLJ/S8IeIw4bXmSevkksvHRhFAR0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=d077eUMmBGuLeIgrLhRCsjP4IU4vT9U9N54l6SYBwG+cVZyl6gzCvIAz1R+aJ1tcx
	 JTqM5zCZ9ByDzrLVCJ9CxhxgG7w7+eGgLAfa55w9uAypbKW8aiK+VL/jZf0OKYfLd5
	 MAoiF1zaHDAcUf1PiI5mFglglpRRPF34tzCtRRBE1oPtSQ36wCZbuSrxdL4ZonkNWg
	 nJF4ocD4sg5z3k3fFhQ/islvp16ZVve/9lY1/hO9myW2njAnJrIcxTXQgny0C8Sxls
	 gwMMOz8t19R/URD4t0MUBP3gLuTa98wpmjykPDgbCL9aFeVbLwirhccmsNemO1Zp4Z
	 OjT/Od2lxeOkQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66W1Q402313880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 14:32:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:32:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:32:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v4 1/7] wifi: rtw88: Add rtw8812a_table.{c,h}
In-Reply-To: <086f476c-e832-4867-963c-a64a63252fd6@gmail.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com> <086f476c-e832-4867-963c-a64a63252fd6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <05dca2fd-880e-40f8-a5b2-849deae8c239@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:32:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> These contain various arrays for initialising RTL8812AU. Also TX power
> limits.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

528f902ecc0e wifi: rtw88: Add rtw8812a_table.{c,h}
4b81da5cd2b4 wifi: rtw88: Add rtw8821a_table.{c,h}
b870b9d31c9e wifi: rtw88: Add rtw88xxa.{c,h}
32e284a23880 wifi: rtw88: Add rtw8821a.{c,h}
4f8ec8927bc2 wifi: rtw88: Add rtw8812a.{c,h}
8f82bb2cfaf7 wifi: rtw88: Add rtw8821au.c and rtw8812au.c
0e3e8284f8e1 wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

---
https://github.com/pkshih/rtw.git


