Return-Path: <linux-wireless+bounces-19451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84CFA45311
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABE017B953
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1772185AB;
	Wed, 26 Feb 2025 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="r02xa+kV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B110A1F;
	Wed, 26 Feb 2025 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536828; cv=none; b=T3xvTf9mDr0iMECC7+ZDMzdLST+p0nzXJwSQ/xC3U3ZL5vKf/g7oDVRw891FqarCcjwBm4CGZzI8C8nvM0gbWDLLCw05yvKTPgvvnvcl7Wf4m6kBhWHA6g5kjGo4GbsbvHGMDdsZyAnk3Ou6NmzayirdndKZ0wRU/e7hkyC4BWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536828; c=relaxed/simple;
	bh=42GiZ4kFSP5aM5fm/VTsG+1wE/ptnJAiNkOO6SOOXoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYgwltIk1tNS2/abXkiRW+THMwM7rgRmTsfpQBvpTBB5gGLmGT7ZBTnzuQD8qxI0yJhqWYJ2YaKfZE9VeGSwWH4AEtpsm/7sGXGhik3sbCAGHztQJkNnS+rweIv6/jE+zem3MUfVnxRXRjiAnqBcirSD7C3SxMSKUNtLcnWRbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=r02xa+kV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q2PpqwE2918653, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740536751; bh=42GiZ4kFSP5aM5fm/VTsG+1wE/ptnJAiNkOO6SOOXoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=r02xa+kVf9gFC5q1PjiPir/D16+G4obqIqyooBtpxdgLslUThfZMPjRVeL4BinUCM
	 A78MXJsHZleFQjRHRGH/5l3KEWQOmG4PItNw3bmsy6ctXsTzYNmAVjYkx/Lsh/rCj2
	 Vpwkf2iP+iyzt2V4odJ86jexczqZMSBYb5reQLdrVc2BOM9JdiSOeKDaLJ+aqKb3ZE
	 Pp1lNfQTOcfM+svvc6IeQOOYIr3NPzja/HUo+1IrVUvh7CbV6jcBk8tMxfdj/WPPze
	 e3cTKYQcr+ow1V+rofVRle8xJ9+/FYqG6RFZ+2lv70asrsEOdyXENYZSHbBjEmQ3t5
	 8jaJlHIrlvfEg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q2PpqwE2918653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 10:25:51 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 10:25:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 26 Feb 2025 10:25:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Wed, 26 Feb 2025 10:25:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "sean.wang@kernel.org" <sean.wang@kernel.org>,
        "nbd@nbd.name"
	<nbd@nbd.name>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
CC: "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "deren.wu@mediatek.com"
	<deren.wu@mediatek.com>,
        "mingyen.hsieh@mediatek.com"
	<mingyen.hsieh@mediatek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        Sean Wang <objelf@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"
Thread-Topic: [PATCH v3 1/6] Revert "wifi: mt76: mt7925: Update
 mt7925_mcu_uni_[tx,rx]_ba for MLO"
Thread-Index: AQHbh+ZwZzsI8zHrMUGXLhsf7QBx67NY20bQ
Date: Wed, 26 Feb 2025 02:25:51 +0000
Message-ID: <29528aa271d140bfba1888db02404572@realtek.com>
References: <20250226003556.82644-1-sean.wang@kernel.org>
In-Reply-To: <20250226003556.82644-1-sean.wang@kernel.org>
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

Hi Sean,

sean.wang@kernel.org <sean.wang@kernel.org> wrote:
>=20
> From: Sean Wang <objelf@gmail.com>

The "From" doesn't match one of s-o-b. I suppose here should be Ming Yen?

>=20
> For MLO, mac80211 will send the BA action for each link to
> the driver, so the driver does not need to handle it itself.
> Therefore, revert this patch.
>=20
> Fixes: e38a82d25b08 ("wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_=
dev for MLO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>=20





