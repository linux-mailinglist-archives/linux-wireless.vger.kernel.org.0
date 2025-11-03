Return-Path: <linux-wireless+bounces-28477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150AFC29D88
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 03:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AAD3AF752
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 02:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7627B357;
	Mon,  3 Nov 2025 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TeFxzFxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC94A41;
	Mon,  3 Nov 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136066; cv=none; b=Mdr2l6c3dhxt79rIsdx5Zm7nsMwWn3y+DHdk6c8z1ohzenOAxVWXe36Qcm4qCnZP9uJwVlGvPJAyHXPPS0j4qJzD9+tmsliGkrsJ1CEQA69vlwM6b6xiF4FFso/9stqwOrJAhwFlfMswpTh/JUb5EMH1YMf6veYnwakOKVuImgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136066; c=relaxed/simple;
	bh=V7q8dMbBRBJhmlhhedhlsnpQTrZWu1L0BrwBtxpkgH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPbULGGG0WJGeWzZ15SNMcRvIa88et/hnO6zRkFcfblDNRDgsVZqbbMDeLopT9M/QxSJW7yUL7SszVoh/a4gpxcYRduzptZZE2pFHaHSgnV0tWQLtiFVU5xYhPJwHBwfyBNF/+UWsnlup567FIe7TZHQAH9FwSG5MgpPDSEY4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TeFxzFxM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A32Dt932631767, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762136035; bh=oEqygZUZSObWSYBzYpNswYiI26vNwy5Iz7QvFGvSuRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TeFxzFxM9q9F2GFZe7xJrmzeL1gGdYQMb7vdqhdb5y6mN/A3tGxFGwiZJxygPxGGz
	 Entyklu2Vlu2nK6JL0pz4DsU9vIObatj+6itZDjX0BtNHtoN3M5vXOJmpxucIsQx3T
	 cfxeCA85+sVyefOeB4/WyqydgUyX4lZw9BnijCh7vvg1yfxjIhpTlRjQxT+85HPrS6
	 0gFLvOcr4KP+T1omN/eVyZXsYoQHIR3VYIs1D+ijGuVRhur0tYew6kPcTVcZ72hyoO
	 cB4zgzptBjcxBwwpvU2QRb6Eh8t8mh3jD08RuhYy5FXBCww+5tlJk+2Hz1AMa0iNy5
	 oDwO8+rE0piiA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A32Dt932631767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 10:13:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 10:13:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 10:13:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 10:13:55 +0800
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
Subject: RE: [PATCH rtw-next v4 05/10] wifi: rtw89: implement C2H TX report handler
Thread-Topic: [PATCH rtw-next v4 05/10] wifi: rtw89: implement C2H TX report
 handler
Thread-Index: AQHcSQcnNmvbei7UcEqbtRr1PbBdMbTgPNUQ
Date: Mon, 3 Nov 2025 02:13:55 +0000
Message-ID: <ae325e6c63604498b3bd2836f9662d23@realtek.com>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
 <20251029190241.1023856-6-pchelkin@ispras.ru>
In-Reply-To: <20251029190241.1023856-6-pchelkin@ispras.ru>
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
> rtw89 has several ways of handling TX status report events.  The first on=
e
> is based on RPP feature which is used by PCIe HCI.  The other one depends
> on firmware sending a corresponding C2H message, quite similar to what
> rtw88 has.
>=20
> Toggle a bit in the TX descriptor to indicate to the firmware that TX
> report for the frame is expected.   This will allow handling TX wait skbs
> and the ones flagged with IEEE80211_TX_CTL_REQ_TX_STATUS correctly.
>=20
> Do the bulk of the patch according to the vendor driver for RTL8851BU.
> However, there are slight differences in C2H message format between
> different types of chips.  RTL885xB ones follow format V0.  RTL8852C has
> format V1, and RTL8922AU has format V2.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



