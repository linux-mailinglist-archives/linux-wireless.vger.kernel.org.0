Return-Path: <linux-wireless+bounces-28555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52556C33960
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 02:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 250784E3D8F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB523D561;
	Wed,  5 Nov 2025 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fmy5tI/1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6DEACE;
	Wed,  5 Nov 2025 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304814; cv=none; b=eAXF6hmRwPwgXM1r1whSrbprgZC/fuwzieuk7dtmHxQfL+ahyW/EyOuFA9b3tEbA54y5G9Has5Rfm89zmlBqc6DPwMjBIDv/83DiB3FUPQLmlF0mvlH3PSilQSlBP170CJjpqJsa9Z7qVbZ6sqKazU26dOTqhfkFcKAPcvkm8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304814; c=relaxed/simple;
	bh=mzW8exVlwSL0+ps9LiYrWlxxNnat/tVGKcorUqaDSTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPHdc422QzAHIahq90duFIjpVhqEBFo4GFs2+jRZdE0QvLMzHf5+tctQn43nuHNDjJhnCnP8RerbKtf6N5NwhyUkv48tol6aJ42eEXh/Wi99GEGhv2G2osYZCgIwgq5FMjKY88Nv6jLCeyGLP4+Q3OuNIHJ9PpD1b4EQHZ/DAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fmy5tI/1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A516QMc8117020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762304786; bh=aassnsD4V/aPkF/oTQQZfWF/isV7IoM5r9Buy5P4E7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fmy5tI/16uNdjN+oZe3gBxNGmNF8FHPithdU6IRETrz1yEgTepDbcTJFFnfXSYsTS
	 IemrsWT02lEsyoEyECgsJSLpXSsV8eK1Q4m+FC+/YyzVjMXBUmD421+36Q4P79vJQI
	 /SXe7+Blf7L/wZ4+yTdHgsKECmyD4vEmClTCK3mQOdcFGcv7ZBELqZF1R8qBIKd9TF
	 LBAr+w1aBkYj0AabNRmQcmNmPXZqIdaurt4jO2ke5elvxyFgdL7zSQfj2AjDDPDSua
	 QYHX27rtnW8Wr6Ve/Xo1wKzR/e7Bwg35sYgtL2cgdtqoGHfQcs83+TPns7uWQ2mrJi
	 z7YGUW0hJg7dA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A516QMc8117020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 09:06:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 09:06:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 09:06:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 5 Nov 2025 09:06:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v5 08/10] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next v5 08/10] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcTZN9x0UCDjIlN0CeAbAWejCWpbTjRY5Q
Date: Wed, 5 Nov 2025 01:06:26 +0000
Message-ID: <b4d6d329b6fb46f1913e31f9e0bdb5a1@realtek.com>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
 <20251104135720.321110-9-pchelkin@ispras.ru>
In-Reply-To: <20251104135720.321110-9-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
> report to mac80211 stack whether AP sent ACK for the null frame/probe
> request or not.  It's not implemented in USB part of the driver yet.
>=20
> PCIe HCI has its own way of getting TX status incorporated into RPP
> feature, and it's always enabled there.  Other HCIs need a different
> scheme based on processing C2H messages.
>=20
> Thus define a .tx_rpt_enabled flag indicating which HCIs need to enable a
> TX report feature.  Currently it is USB only.
>=20
> Toggle a bit in the TX descriptor and place flagged skbs in a fix-sized
> queue to wait for a message from the firmware.  Firmware maintains a 4-bi=
t
> sequence number for required frames hence the queue can contain just 16
> elements simultaneously.  That's enough for normal driver / firmware
> communication.  If the firmware crashes for any reason and doesn't provid=
e
> TX reports in time, driver will handle this and report the obsolete frame=
s
> as dropped.
>=20
> rtw89 also has a new feature providing a TX report for each transmission
> attempt.  Ignore a failed TX status reported by the firmware until retry
> limit is reached or successful status appears.  When there is no success
> and the retry limit is reached, report the frame up to the wireless stack
> as failed eventually.
>=20
> HCI reset should stop all pending TX activity so forcefully flush the
> queue there.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



