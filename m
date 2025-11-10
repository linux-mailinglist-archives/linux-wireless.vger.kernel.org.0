Return-Path: <linux-wireless+bounces-28714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F4C44D10
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 04:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4ACCE34603E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 03:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9515ECCC;
	Mon, 10 Nov 2025 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ryuh8VAg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841D54918
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743797; cv=none; b=k2ZFHd5wkqjubmw1+72HnxHS8RMLr3/cJFYjG2+Kr/HhC3tklNE4TVbum7EtaJ/wXaB8deMJAUAFZRBnfHZfrRwouy96vCD0JZsLl+4nUCoi4OpEMa+gaVGEvLaFZKqRvag1T6j5G6Ob9i5WG8cOr919tF9a35SwujMSV6g4ErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743797; c=relaxed/simple;
	bh=CaoogGrl0PAOi1ROMQBc+vl3ErVXIW2CC5YYm9CaxFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgJ1WaP3xFqzKNTPcsnhq3uTR9gN3TlNckTcVqi6Y9KYkQxqwUltT82NAy1xPyMTM8dAmAEHLOzsquDUSSoscBk0Z7ke3s0ltxNQlkuHoO4kx8uf8SAK77qD/MDvkb58K1DHgVdW1jyAqVrQnBJfUd7JkamoXpyRY3CqaIBWNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ryuh8VAg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA3364P0738589, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762743786; bh=CaoogGrl0PAOi1ROMQBc+vl3ErVXIW2CC5YYm9CaxFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ryuh8VAgxfAcYLa/wAbew0kqq5VfWrGF0LbR4h7NP1j5K3DwhmRlcASGoPWmJyBeI
	 9duuMU9NuzPZ25tHomVNGtmPP/6PJMbZs8QX2NDF/hG2Q2Ez1LT0F4igzWD88SiH2j
	 a2Dbfmq0985KPTXXeNbsJV1rVBzdJeFiuIQ2Ihfwz+60WssZvdwCeruEj2BfAmBd1y
	 N83BZ4gW0WybvxU+vXwDJmCk4j8F7DcjxEY1a6iRpSOTPDZqFjT5uNlsVR8v3Yzl80
	 0FtdhZHKDv7XZo9ksCozNmSEVVPcbEkhpS7Hc4bj5TRCvQdvwfhjVlVueSZebOXIjj
	 ZNWzanGGs/z6g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5AA3364P0738589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:03:06 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 11:03:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 11:03:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 11:03:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] rtw88: 8822b: Update firmware to v30.20.0
Thread-Topic: [PATCH] rtw88: 8822b: Update firmware to v30.20.0
Thread-Index: AQHcUc0WpSvFGsRUuU+F+4O1ZZ4LurTrOKeg
Date: Mon, 10 Nov 2025 03:03:06 +0000
Message-ID: <aa1a0c67256f416584c9099496cc2aff@realtek.com>
References: <20251109230315.6899-1-zenmchen@gmail.com>
In-Reply-To: <20251109230315.6899-1-zenmchen@gmail.com>
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

Zenm Chen <zenmchen@gmail.com> wrote:
> Sent: Monday, November 10, 2025 7:03 AM
> This firmware was extracted from the vendor driver for RTL88x2BU
> v5.13.1-30-g37e60b26a.20220819_COEX20220812-18317b7b from
> https://github.com/RinCat/RTL88x2BU-Linux-Driver
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

I confirmed the binary is identical as release version, so

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> Some people said this firmware fixed certain problems [1][2], so upstream=
 it.
> Only tested with RTL8822BU, NOT SURE IF RTL8822BE/RTL8822BS WORK FINE
> WITH IT.

I tested RTL8822BE and no obvious fault.=20

Look back into vendor driver, all interfaces use the same firmware, so I
think it will be fine.=20



