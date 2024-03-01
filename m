Return-Path: <linux-wireless+bounces-4288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21386D9D5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 03:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DBC1F234F8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8B3FE23;
	Fri,  1 Mar 2024 02:40:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94703111B1;
	Fri,  1 Mar 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260804; cv=none; b=Mmb6/gjM+Ntwob2HyFLQtyNaWRYbngHXa0vd6CklpHUulz4LFgzbri7j+dWYdqgOX4UbuHDxRlVwRsuAsE8qKwQ6zDoRcV5/HRwxDlSe7aiIJ4i4DLW1ScgWonoiPhjlL5w8zrgR8mE0rbJLwZnHewGShs8CW8VcFKvNVSfiGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260804; c=relaxed/simple;
	bh=mzlSvE6AWICY+6PZEGOgIZHaFZlV5OfnyQzS0L/OnpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eobO28gbtZBqBRmRVxAlq9bE+LEEvGkdBh8viK6/9jgV0/JtN1V5vw30T5rNnllbgZnFBxoSmLWH8ZG5myqHkDaUfHBSX4bwm3Vdy6sCUTqVXRX1hDgu5N6xsuDU+wHCEMXjqoPFJrmoj83m/G1+OsC9OopWdE6dghp113zdMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4212dkFvB1842368, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4212dkFvB1842368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 10:39:47 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 10:39:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 10:39:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 10:39:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz"
	<megi@xff.cz>
Subject: RE: [PATCH v2 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Thread-Topic: [PATCH v2 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Thread-Index: AQHaadijiHxJ3ZY9zEij6pSUhmlExrEiL2ow
Date: Fri, 1 Mar 2024 02:39:46 +0000
Message-ID: <bd42b630eb504f6b9e1dd38cfd217a5d@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-10-fiona.klute@gmx.de>
In-Reply-To: <20240227235507.781615-10-fiona.klute@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Wednesday, February 28, 2024 7:55 AM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@linar=
o.org; linux-mmc@vger.kernel.org;
> pavel@ucw.cz; megi@xff.cz
> Subject: [PATCH v2 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
>=20
> This driver uses the new rtw8703b chip driver code.
>=20
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For SDIO
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

I have reviewed v2. Only small comments. Thanks!

Ping-Ke


