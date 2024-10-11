Return-Path: <linux-wireless+bounces-13886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407799A42F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA56F1F2305F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB316426;
	Fri, 11 Oct 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WeOMHyMU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62920C473
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650906; cv=none; b=ZtLLtS36GHzZeOJ3+kB8l5bEJQrHiW5klhIkMBTcg1fBPtMDOTVoEeQrR1KYokxV3hP7TZwRr/wwNmDc6TKA1rspytUoPxHSzh+/+xPXHhl6xXfRX8f42eixH62IPEyTX4tO9FrVcw9+cgpF+eXmXQov3m7LRA7s4Bp67dNOE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650906; c=relaxed/simple;
	bh=vgy+5V/OzVsVcKCJaXxia5jUasAUB0GHm1wAAk4D7cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GbYvBHLqZu4jJIcTQxaBidWaocbvSA/krrR4rVA0vuxDVcQxzZ15KIZ0mTZVSdxO1VmctsBTGLR3tt4yiU4uz7Mn+8FdudxJ/fO6duVjRv32ri7qp87uDDrT+GtJ0zTQtq0Fdf/7KaAXZGR07RosKTabr1qYueTccZu4V88fSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WeOMHyMU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49BCm8nqD3833369, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728650888; bh=vgy+5V/OzVsVcKCJaXxia5jUasAUB0GHm1wAAk4D7cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WeOMHyMUrVphP4+TSD1KLEoNtUG8ePY79218GW8DJQ2YzNevs1QM3egUPe+fzk0Tr
	 HtrbT1e7TAeHUwzwKs/X/j0NsFGV4kOCv6IfTndSA90C3mwLFhGxMyZhMb/3Q1te+D
	 plwzL7WCLhxUeILg2xj4fqVL6htrmCCgwSrdMWjDiUTIiQd+xVp9uwiQBCVD977lFI
	 v5/oVYWIjLzKgmKbLW6F5moBX0g/Xz0k/NMPY3O+/YB/kNFBIQcP1Afksklpw88z4T
	 XsNq3yqOfRqcQclc9ZNGqi4PgJ+yRNT/5anQBBKC6mSCfzFCVnvxUGKSbkIoT7YYoo
	 eJdQS9ZYJreAQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49BCm8nqD3833369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 20:48:08 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 20:48:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Oct 2024 20:48:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 11 Oct 2024 20:48:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
Thread-Topic: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
Thread-Index: AQHbGbIPC7VnZnD73kWpzFtG8qPKSbJ9i+CAgAPqFIiAAA4HjA==
Date: Fri, 11 Oct 2024 12:48:07 +0000
Message-ID: <03756ec20f5043f0a4ccce028b3de8f8@realtek.com>
References: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
	<3731c7452dbf48f8a35e982d08963ba8@realtek.com>,<875xpy7szh.fsf@kernel.org>
In-Reply-To: <875xpy7szh.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Kalle Valo <kvalo@kernel.org> wrote:
> Yes, let's take this to wireless. And you don't need to ask me, just
> mention that this should go to wireless tree and assign the patch to me :=
)

Understand and assigned. :)


