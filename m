Return-Path: <linux-wireless+bounces-18052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36312A20422
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 06:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C3C3A5306
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17513A26F;
	Tue, 28 Jan 2025 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NFY5OOpF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F283A14;
	Tue, 28 Jan 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043134; cv=none; b=mgXVynE2FRggF9mEZWpYCteHY//OKNM8tNVSNH58c0N6WWLea6RKaq7XqIokQLjZzv3WVSMagZueBWYXPQZERRRgwwPW/hsd8f6GOo5/o32McbOYJbnrtMHZ/NkI4fdpbtefhrSA+LHgEM6H18ntgsW3oBM2lKv/PR7wQoKiyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043134; c=relaxed/simple;
	bh=GuCrYy3aSYSCGAfkY9n+4ofRW8QlXcnwExDDwwN/Bvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2Mv0X97BREDFt0dHDDDiMa+t1Qbid1/siV+L2oJyjk9QrWkhrSLgO2vkooowrLow4AuimJ9dyTbrEgU13CgDEW4zIdX/GUWSjuNhhziexMs2MYDCM87/1oeNlhe+Mq3b0TAJzci2WOnY/USpqds86ve1uzPDTu7SGKFfKos52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NFY5OOpF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50S5jJxqD4077551, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738043119; bh=GuCrYy3aSYSCGAfkY9n+4ofRW8QlXcnwExDDwwN/Bvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NFY5OOpFUM/FEVj4vVKvA4HgM+D0LeX+pJYbLIy3JhKOM9FyXCSv+gjvFCAyUuT4A
	 ixJ/RVE/AfOHCTGHz2tOPDEpzAvYPlzrBuY+LGzTfoOwJNYjludJFO0ExU7Stl3RQS
	 +PD0rfCeGAZkLlI9JV7Icv3MPMicXdvjf+XLZqiEimyAnQM5Ipj1JMdz2di4IE9v4f
	 H1MXpT+a3pYDAuE2ORFcNEon4/kUVJadUtSaNj3HSHJBCDxOrDtsdOnhRAq9J7A3rR
	 lz0tIbtamb16jWHj6YvHOj2nTNOxhg01jDLlVYvklEvTKBUcbOgh9qiY1Zlvx2E4cl
	 piYiN2PNtM//Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50S5jJxqD4077551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 13:45:19 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 Jan 2025 13:45:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 Jan 2025 13:45:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 28 Jan 2025 13:45:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Soeren Moch <smoch@web.de>, Kalle Valo <kvalo@kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: retry firmware download on error
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: retry firmware download on error
Thread-Index: AQHbcPSGmHYUKT7XkUmAJtTKPplvDrMrrVrm
Date: Tue, 28 Jan 2025 05:45:19 +0000
Message-ID: <14b014e4aca94ccaa2ad38fc39c6b86c@realtek.com>
References: <20250127194828.599379-1-smoch@web.de>
In-Reply-To: <20250127194828.599379-1-smoch@web.de>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Soeren Moch <smoch@web.de> wrote:
> Occasionally there is an EPROTO error during firmware download.
> This error is converted to EAGAIN in the download function.
> But nobody tries again and so device probe fails.
>=20
> Implement download retry to fix this.
>=20
> This error was observed (and fix tested) on a tbs2910 board [1]
> with an embedded RTL8188EU (0bda:8179) device behind a USB hub.
>=20
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
>=20
> Signed-off-by: Soeren Moch <smoch@web.de>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

