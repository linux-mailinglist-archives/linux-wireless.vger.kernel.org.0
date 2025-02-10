Return-Path: <linux-wireless+bounces-18672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C01A2E1BE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1F31885E80
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 00:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E95AD2C;
	Mon, 10 Feb 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NqUt8P7G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557348F49;
	Mon, 10 Feb 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147305; cv=none; b=EwLqM718N0+sT72PyIKH57ajz7qhRyMZs90F5pVo6oOfGbOCfjMspZUjk6vhwVBlvx+dYyfKJtRFufJCkLfbwYjWGM5AnUC84N6dfbiAfBqlIWFCiW7CUbqpVgO5h/oVOu/J0nqN7U30FeDCfGh9m9xps9kfdqJQgsJ/SLpz7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147305; c=relaxed/simple;
	bh=KKvJwv/1kq5mF8ZtnlLKAz9MPFThYJ9I6SabWafH1mM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E2Byot9QadybVknEbAK2Fe41+dqXd3AuE3MMi/fXnsyZ0rpdkw5YKd28x/3qYWGG50Hv1UVscp2Z0dUZypPnCCerYF2K/ifulz8gtlhhBhsfijxSaBr5YOhWrwT3xGJ8oKjNebv/xS1nvurhQ0Htc8wTr/kmlAcsycGen0ZKzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NqUt8P7G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A0S6J501315859, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739147286; bh=KKvJwv/1kq5mF8ZtnlLKAz9MPFThYJ9I6SabWafH1mM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NqUt8P7GvLL6V8uogrY04EY0q0qSp33rqKuBn3q2l/YTTmIRBNewO0J39qscoz7PR
	 H90+AAkHV0TNJql2GfNgdbxmXXKHBcPX4FJdZnQDPH8/1NjbRaZ5uF+UdWlNjO2zro
	 bjcohXtZl7CiERusHh5ScQlGuVOLe8gTBKxigFoLfnXL+L6YMk6Ja0TWvYTWSt9AhU
	 Nwe7S7SSfdTwylo7r3glS8fHhOkObVwOtdMTbLkNNrGQRDZAEnCOOBfRvCnMOZb7nQ
	 aAVLDbshADaptz6zV1TrXLOL2iVrXBSwevsk9fsuSFUFFq4FKUE36e4UCEloEu7uet
	 9XLDoUVBUgm5w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A0S6J501315859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 08:28:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 08:28:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 08:28:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 08:28:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrew Kreimer <algonell@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH net-next] wifi: rtlwifi: rtl8192de: Fix typos
Thread-Topic: [PATCH net-next] wifi: rtlwifi: rtl8192de: Fix typos
Thread-Index: AQHbeHCiBXmrjmRhyEKJoU1kzj62i7M/s8Ww
Date: Mon, 10 Feb 2025 00:28:05 +0000
Message-ID: <d525ed7b3b564238b25b0f3653f20067@realtek.com>
References: <20250206082457.9148-1-algonell@gmail.com>
In-Reply-To: <20250206082457.9148-1-algonell@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Andrew Kreimer <algonell@gmail.com> wrote:
> There are some typos in comments/messages:
>  - althougth -> although
>  - asume -> assume
>=20
> Fix them via codespell.
>=20
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

To be unique subject, I will change it to=20
" wifi: rtlwifi: rtl8192de: Fix debug message typos of phy setting"

By the way, patch goes to wireless-next instead.=20



