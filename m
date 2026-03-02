Return-Path: <linux-wireless+bounces-32335-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEUpGIMkpWm14AUAu9opvQ
	(envelope-from <linux-wireless+bounces-32335-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 06:47:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB151D339A
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 06:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABB68300C0F4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 05:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F489377010;
	Mon,  2 Mar 2026 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sm8Vr0fC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FF31C567;
	Mon,  2 Mar 2026 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430461; cv=none; b=lBQ1zPZiHQKVBd41GszIPglnPQTLU3VoITEIxHfaXBQNsZQz+q3Az1wrKDn/3qdSPeEzwLzw610iMpgQehtER5ROoDXlG0Z0sc7jZotBMtHKlSSPRPj7eT0HDn6CW2AdKrWXKm58c9MRvYOxJ/3o/LDJY6MTEqhpP2ScZIpCAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430461; c=relaxed/simple;
	bh=Xn+FIy5sxnFKdjGJm7bka3PVWDJ5qGK0LQpK/qixUlA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P7Lk/tRfvffB2NwwKxCARuVAmBli9zCxu9QrLvC45VvT8POuiS9H+OHmQpPIJhrxh5g05ZuRX9H5WzCVeGTc1hyetTf+toBFp2577CSgJRvGOeKErE9n+TXRazDTsZWMoAIdOXNzsQJvXkcl51E22mULFiioMSaK7FdQEC1nEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sm8Vr0fC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6225lV5f92459019, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772430451; bh=hGXVMc+RhO6LiJ4/rkaCFgzXkPwx01m7ztCsj1a8WJc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sm8Vr0fCCLX3QdknXSF+f7j9k3l8NbFAsGsE/Nl5VNz/H1NzvoUv/LGGz9Iit63cY
	 R/bNi5PRDVa9PliNMHFjjrYMm9pMgFDUghJ6zg+NGlh7i0VYnEK6VK+JYEbN2XTeNg
	 43kT8oAO/NJpZ+H/18l62eJRKxTCC/PKKPWYMIMITcI2e++4x/jqPBkLK+BRBlWe/Z
	 FB2Umab7tKe7ckbVKmtM6piCtcjYBtHk1BhUHPhchsIvKJaZ2F9BO+DsIgqnA62+el
	 F5rOCPiEP8NGJYhee1ijSMl2kQ4VOc2aSRhHm5GzFL57WvfzRo9+kCFuwwVcHOXVT5
	 RZlUbAGEYN4zA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6225lV5f92459019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 13:47:31 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Mar 2026 13:47:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Mar 2026 13:47:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 2 Mar 2026 13:47:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWavE1Q
Date: Mon, 2 Mar 2026 05:47:30 +0000
Message-ID: <c751f9505a664f6895bacecb62bc534a@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
In-Reply-To: <20260301042422.195491-1-christianshewitt@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32335-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0BB151D339A
X-Rspamd-Action: no action

Christian Hewitt <christianshewitt@gmail.com> wrote:
> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
> physical map dump intermittently fails with -EBUSY during probe.
> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
> bit after 1 second.

I'm checking internally how we handle this case.

[...]

>=20
> For context, firmware also fails (and recovers) sometimes:

Did you mean this doesn't always happen? sometimes?

We has seen similar log because of 36-bit DMA. Try below to force 32- or 36=
-
bit DMA to see if it can resolve problem in your platform.

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireles=
s/realtek/rtw89/pci.c
index 43c61b3dc969..9d003ab93c85 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3305,6 +3305,8 @@ static bool rtw89_pci_is_dac_compatible_bridge(struct=
 rtw89_dev *rtwdev)
        if (!bridge)
                return false;

+       return true; // or force to return false;
+
        switch (bridge->vendor) {
        case PCI_VENDOR_ID_INTEL:
                return true;

>=20
> ROCK5B:~ # dmesg | grep rtw89
> [    6.436873] rtw89_8852be 0002:21:00.0: loaded firmware rtw89/rtw8852b_=
fw-1.bin
> [    6.437165] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
> [    6.450228] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6f=
b3ec41), cmd version 0, type 5
> [    6.450239] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 (6f=
b3ec41), cmd version 0, type 3
> [    7.864148] rtw89_8852be 0002:21:00.0: fw security fail
> [    7.864154] rtw89_8852be 0002:21:00.0: download firmware fail
> [    7.864160] rtw89_8852be 0002:21:00.0: [ERR]fwdl 0x1E0 =3D 0x62
> [    7.864165] rtw89_8852be 0002:21:00.0: [ERR]fwdl 0x83F0 =3D 0x80011
> [    7.864173] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
> [    7.864188] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
> [    7.864203] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864219] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864234] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864250] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
> [    7.864265] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
> [    7.864281] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
> [    7.864296] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864311] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864327] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864342] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
> [    7.864358] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864373] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    7.864387] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
> [    8.181342] rtw89_8852be 0002:21:00.0: chip info CID: 0, CV: 1, AID: 0=
, ACV: 1, RFE: 1
> [    8.184322] rtw89_8852be 0002:21:00.0: rfkill hardware state changed t=
o enable
>=20



