Return-Path: <linux-wireless+bounces-29685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7582CB784B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 02:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8A193012757
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547451DF75C;
	Fri, 12 Dec 2025 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S1LCv8Oc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8057248880
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501776; cv=none; b=eUcv7nvDLnTNkF+FNNRYs9p8yRwx2ZFJQEePtfbb4o4ZC6Fs9tuWJZQ2jH3rrLfmqk18IZQ5itFQE9i6qM7aophaJNK9qWdA5B8VRWo+2Rf3gafbljU4NWTJzMD68os+TxWVH90tPBhOSg6FLDl1zGQayamt0Oi6YpQ2RL1nf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501776; c=relaxed/simple;
	bh=8xg0cYptMpvUSMv5UPaqryF4pQ+JEOv04CRqIfttWpw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQ861wtf/d6GBdTpc4CKVlFcg4XLpZ9Y7dOBieIgCwXNIfE5dM4kgFktpC4IStMmfPGd0Gi7MyA+J2Udk/S5SaMdiJ810V/MxzxkHkQ6m1ybxudOKx2TS+3gGK4tkSjzad6YsKVrIhfuHh1KfY1ForlwDZ70529e1voUFJoyAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S1LCv8Oc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC19SN503283782, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765501768; bh=8xg0cYptMpvUSMv5UPaqryF4pQ+JEOv04CRqIfttWpw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=S1LCv8Ocgc/F9V6MwP4cT8fG58Ak6KdfYhpyw7909ooNJ9p4lXJ1z+7phzrSZXCAx
	 N541lMg6Ug49L4YBLs0VwSYUNhb56JgUSNg/kO+J6ZMzp0zfxyuxsCvbmhg7nxodcx
	 9RjEPOv/cjLS896u1ZYkbyDhxOIdrNE9GAtY1dqjLZfAART7JJyoZGV00ZIUlo6hTK
	 qLTjxAV3QvcTLjOASrcB5/3ONTXI6Kvaa9J5pCvE9OUV6509B9xu0PugPbxi/t0AYN
	 VxF0mGTB29iXJ+TMiOl5NEGJoFqeLLEsIJylzXi68URKsyeZpLlLdjP9vRbFJ0CFbx
	 Y9We1ETiIVg0Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC19SN503283782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 09:09:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 09:09:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Fri, 12 Dec 2025 09:09:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jan Gerber <j@mailb.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852au: add support for TP TX30U Plus
Thread-Topic: [PATCH] wifi: rtw89: 8852au: add support for TP TX30U Plus
Thread-Index: AQHcawIlbGpQ0DUHf0O/pIRpVHJFrbUdMcug
Date: Fri, 12 Dec 2025 01:09:28 +0000
Message-ID: <9c49d2f7c03a4614a2fb48bddb8a27df@realtek.com>
References: <5b26cb7740894638b84fedfcad52ca03@realtek.com>
 <20251212005515.2059533-1-j@mailb.org>
In-Reply-To: <20251212005515.2059533-1-j@mailb.org>
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

Jan Gerber <j@mailb.org> wrote:
> the device shows up like this and everything seams to work:
>=20
> Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter
>=20
> Signed-off-by: Jan Gerber <j@mailb.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



