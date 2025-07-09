Return-Path: <linux-wireless+bounces-25078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B89AFE0A2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91B33AE3CB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3E26B747;
	Wed,  9 Jul 2025 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PSsa92w4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E34433A4;
	Wed,  9 Jul 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044227; cv=none; b=bO9Aj4zHSBJPVQGundwe8Ljj+ATRUxtZBnZ/NfWLH0YenAbS7Qqgsgk4PSxc5KcbUGM3EAXWrbRzDK6D7VavRPmayAPSI2xlrKTqFBtnAJUtvGqQVS6IhjKFek52Xt41cms8miyKxviU8BwjFHDGNINdOwVGU0sAkNvZiQSsxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044227; c=relaxed/simple;
	bh=OSouZSCyYrv7CZM/qG1bMqrBA7SEWVwSosQH79Nu3wU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/EaVGMpjRbJmJwmF+69+ZUKRMzLsctASNOEsVOq/VXnbCb16l+4uKRYu2cvoI1qlvMrKMxDGZbMlAZemBru43r8mmBlB0jthXWpCJEKqt4529KY/zUUsZwmgQ4/B5wUAxBPJwFx8sLPam1nS0toFekfFREIP9Hfusq7aFFCuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PSsa92w4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5696uub97869399, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752044216; bh=OSouZSCyYrv7CZM/qG1bMqrBA7SEWVwSosQH79Nu3wU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PSsa92w4/o7UpO5A0+tvdjB9mSE/gCPVqs5TDRQYY6ZBnV9lZSUsmLQWf+Wd+Sp+I
	 Yvk0jgmelO/GK0x67Ym2OTVmoxK9ZEVqQLWBq3BbX+VEe579MOdspU5IJNGAQsFd74
	 9YCvVJy+R3McDlId9W3aQiarWvWuCjibgt0kZns+dcG4WCR5LDVaAHQrSzxxRk1G1m
	 JplvVYROUUHngS7Jbhs/XANJj+0hKs3sPX65UCtfPDd+oZRn0tmPkWQ0sbKsLtEVqf
	 uX6dsbpbW+EtAbbKCfhZ7YRJZ6usOsOVAxNHS0kVuzQFBMwrmFFpVWBNejGEevyPhF
	 1qwPASBXj0Aug==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5696uub97869399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 14:56:56 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 14:57:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 9 Jul 2025 14:57:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 9 Jul 2025 14:57:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:REALTEK WIRELESS DRIVER (rtlwifi family)"
	<linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/12] wifi: rtlwifi: Use min()/max() to improve code
Thread-Topic: [PATCH 12/12] wifi: rtlwifi: Use min()/max() to improve code
Thread-Index: AQHb8Hir9ZtnQaGzb06SvmtYepoSQrQpXF2w
Date: Wed, 9 Jul 2025 06:57:25 +0000
Message-ID: <fce04c0f4ea147f9bddb9aed4314da50@realtek.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
 <20250709022210.304030-13-rongqianfeng@vivo.com>
In-Reply-To: <20250709022210.304030-13-rongqianfeng@vivo.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> Use min()/max() to reduce the code and improve its readability.
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



