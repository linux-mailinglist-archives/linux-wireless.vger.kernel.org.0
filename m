Return-Path: <linux-wireless+bounces-10163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6C92DD4E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656411C21788
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028A7383;
	Thu, 11 Jul 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CjEsfRXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B136C;
	Thu, 11 Jul 2024 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656796; cv=none; b=lhQEXamC5A8KJAz/C2hUGCnm3r2T7lP81F0KuNBnsSlxhOh1DeKKpG4m0VsV9fvz01Lggz+p9NyTWQjfjyo3NGqhtEKMLuDI0EYqCkNntpqdnmbqpK/3VlIasv1fRvHOwppj6yGuF/RYaFpTogjze/9JUT4Wpy3Wai8OTWl9ikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656796; c=relaxed/simple;
	bh=UtDt4LUfmyajo8Xa1uLEKN3Hah6yNHzOqbokGMBQnJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q593zVVV6FzUnyrwI68ZlTnbJ6tenYTzIu/lkUiz6vaPX3/SMjIaoqatep+gbbElRvEnSJrX/k6fA0GUXk0lnnG7VarbdTKpapXLEgiZXkUpp7uwzI/kOsAZtX5m7ogzHrdmtYxSJlrKg7iOlFzaaOhRvIhF+SNOURBcQGkZgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CjEsfRXu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46B0D39q82658278, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720656783; bh=UtDt4LUfmyajo8Xa1uLEKN3Hah6yNHzOqbokGMBQnJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CjEsfRXunhcAEzkoFogu9pGD7SXmz7uDkT3Xuj2N8sQg7XTABRMuckeZW8xpCNyoC
	 ihUaP0htPawVnUqFFI6e+v8LHnWVW5GUdU315woY7yyAsiEMHivkBpVy8XfM8rZB/F
	 PjP83agtXBpmTZxzTA1zNc0XL+P90bLPBGlad+TDj+bNoCy7/Xe6z5SQaqUDkz1cxi
	 A2CJByqqNA1oJMACl6aL9WZqiWkLOzK6cDrW8cn+6pPEOcxhYo3g3nqVgWd4/8g+9D
	 N3aWfvF/FcZwWxGivKIz59idw3dTL9R0yf3Ikux/n16C0mGSxJZiqahl2pJc/R7DFe
	 DNJ3/nbaDC4xA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46B0D39q82658278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:13:03 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 08:13:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jul 2024 08:13:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Jul 2024 08:13:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thorsten Blum <thorsten.blum@toblux.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: chan: Use swap() to improve rtw89_swap_sub_entity()
Thread-Topic: [PATCH] wifi: rtw89: chan: Use swap() to improve
 rtw89_swap_sub_entity()
Thread-Index: AQHa0vwSHFsha+UcbkOo1WiJogX7JLHwp9bg
Date: Thu, 11 Jul 2024 00:13:03 +0000
Message-ID: <3fb72f1fd0594f8981075ee0f3fbb0f7@realtek.com>
References: <20240710190426.709964-2-thorsten.blum@toblux.com>
In-Reply-To: <20240710190426.709964-2-thorsten.blum@toblux.com>
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

Thorsten Blum <thorsten.blum@toblux.com> wrote:
> Use the swap() macro to simplify the rtw89_swap_sub_entity() function
> and improve its readability. Remove the local variable tmp.
>=20
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
>=20
>   WARNING opportunity for swap()
>=20
> Compile-tested only.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

The same patch [1] has been applied.=20

[1] https://lore.kernel.org/all/20240529020244.129027-1-jiapeng.chong@linux=
.alibaba.com/


