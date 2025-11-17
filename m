Return-Path: <linux-wireless+bounces-29019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215DC6242C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 04:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD543ACCD1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635F2367BA;
	Mon, 17 Nov 2025 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="e51fiP4P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40259199E94;
	Mon, 17 Nov 2025 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351017; cv=none; b=apkk8QaIG82PGsMdrKE3S/BwHUniy+rfbk/qhlNLyj1bVsmE34MP+VrGFw7ZXDHfAQGUm97nOfT27I6pkDRIPcl6fzy4/oS9KNMlzN5EL2AqgInY2+yp0Yv4DIrEvgwc2m/aRHcvvkvh2dET/wmGyXOped1DHlyGmjLw42cVAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351017; c=relaxed/simple;
	bh=Lq/qydaz902PJ+gMOhbbqTJ/czyAPmVh4KgRXeuo45Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAqp1lRRNJVMs3Ooz+mMmKfjuuhilf0I5AvhqqFy+1Qf5CrfJzwiM7S/p+Pp/20SPNgxAUyFR16OD1xf7m0jBX/MGNWS9vV2Q14+w+Sqx6CRzoD5TYFWGvm27OFK9AwKzSpnaNlWgaWU1ben/LSeeVg9CJJHwuZgAxdCZH7zCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=e51fiP4P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH3hTxK52794143, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763351009; bh=Lq/qydaz902PJ+gMOhbbqTJ/czyAPmVh4KgRXeuo45Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=e51fiP4PPCC9Q5axCdpAEvwOIoBHLnPjrEzDkWe+BJ02VKIF/VqQVBT/q6Zj8rDOj
	 7PBjlSqJy0+5btHF7PK4isDfh73HWsQirMTM6FMvSyJKOWGd+Uk+VvFQNWPe3XdBML
	 Gt3kpeGJ8wzlmF/VBJYmdmTBn++fUxhq50xZ8+PokYxY9qsTvQp+hlAwfGnBL4f1iw
	 77uN4XD8L57hhQbkIgaUrcA+HgZRtBLZGbvEAEKFWrl/IrXuV+VVuSL8cEFRoviUBD
	 tvGdjIev4v6INTEYImwQHu3Td2SiELakKvhw/rwnft+7GsYpVG2xUQK/RPrWuv9z8A
	 GP5ucYOSymOFg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH3hTxK52794143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:43:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 11:43:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 17 Nov 2025 11:43:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rtl818x_pci: Fix potential memory leaks in
 rtl8180_init_rx_ring()
Thread-Topic: [PATCH v2] rtl818x_pci: Fix potential memory leaks in
 rtl8180_init_rx_ring()
Thread-Index: AQHcVUyVoToSNAKqIECiY7xTT6RaZLT2PfZQ
Date: Mon, 17 Nov 2025 03:43:29 +0000
Message-ID: <f952f8cecc294962a724045f62231356@realtek.com>
References: <20251114094527.79842-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20251114094527.79842-1-nihaal@cse.iitm.ac.in>
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

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:
> In rtl8180_init_rx_ring(), memory is allocated for skb packets and DMA
> allocations in a loop. When an allocation fails, the previously
> successful allocations are not freed on exit.
>=20
> Fix that by jumping to err_free_rings label on error, which calls
> rtl8180_free_rx_ring() to free the allocations. Remove the free of
> rx_ring in rtl8180_init_rx_ring() error path, and set the freed
> priv->rx_buf entry to null, to avoid double free.
>=20
> Fixes: f653211197f3 ("Add rtl8180 wireless driver")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>


