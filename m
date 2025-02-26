Return-Path: <linux-wireless+bounces-19452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92352A45314
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1831E18909AC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B39155C83;
	Wed, 26 Feb 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GaMr4gz9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379142070;
	Wed, 26 Feb 2025 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537034; cv=none; b=GtqQublfYCG/HrpwmWqZQO2/+peduo8u8LttcUOnwida3MKEU+eB6erIJBGdf3+1gJXwE2btVyu/6BPOte3ggguWKgX22V5gyA+x/EBbIUr2r3ViI2+GftjFGFgDtoMo20rnpiZPH+3loOKAi3UXCUWxFTj8ASBfxGjuLuqet2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537034; c=relaxed/simple;
	bh=+90yNPjsMEWcUbvNlu4BZgb5cOPVUBBZJc5R9mmwxaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3/LXwz8E5GMRSGdcEO7GGtbZVev+uUguQHd6bnM1F+UddoM0RB8gDTVj2mJq0VIz6k2SfXCst5itBm47eVEZZgG26HLDZlKvQXLmYrhu6/zhWKN+N0ThLqWgmOjsIhKdhOF5tMG7dCOENLUgKFhA0nbV3bLSr0xDBvchyxlM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GaMr4gz9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q2UAP402922898, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740537011; bh=+90yNPjsMEWcUbvNlu4BZgb5cOPVUBBZJc5R9mmwxaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GaMr4gz97cIBxI3fq9ODf5M0x7phGSvO0BpE/q1wkBvHhIqZcjfu72y/TaIvplJs2
	 eWo0J25LY0RPS4HgTumHE+wMP3ozKi0DNihShMJyQd1DVQTjZXsANnFfvpmnlzZbwS
	 pYLZGDOqfLQdgvil5YGQbR/cYNQ//MM3fndwKKzdS4qxzFPg/5Lvi9SuUHWmVkQw3R
	 IooK6g7gfS0Oc/h56xYlIVNA6rSQJ4x6f8teyzvStQkzYdG6t2rUoSuQoEynEAQvYi
	 oIPTYZtAMKbvJ3DWwWvy/w+0/yVzF/u4lOSqXqZWh37D9cG3/BPt0nGPn7Os+9dDdP
	 5bXHB0rMl6SZA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q2UAP402922898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 10:30:10 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 10:30:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 26 Feb 2025 10:30:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Wed, 26 Feb 2025 10:30:10 +0800
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
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] wifi: mt76: mt7925: fix the wrong link_idx when has p2p_device
Thread-Topic: [PATCH v3 2/6] wifi: mt76: mt7925: fix the wrong link_idx when
 has p2p_device
Thread-Index: AQHbh+aUICP8KIOQfU6sKUM7AN9pCbNY3Hfg
Date: Wed, 26 Feb 2025 02:30:09 +0000
Message-ID: <f48ecd507a4b403fbdfc7166aeb6b10b@realtek.com>
References: <20250226003556.82644-1-sean.wang@kernel.org>
 <20250226003556.82644-2-sean.wang@kernel.org>
In-Reply-To: <20250226003556.82644-2-sean.wang@kernel.org>
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

sean.wang@kernel.org <sean.wang@kernel.org> wrote:

[...]

>  .../net/wireless/mediatek/mt76/Makefile.orig  |   42 +
>  drivers/net/wireless/mediatek/mt76/dma.c.orig |  994 +++++
>  .../wireless/mediatek/mt76/mac80211.c.orig    | 1793 +++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h     |    1 +
>  .../net/wireless/mediatek/mt76/mt76.h.orig    | 1876 +++++++++
>  .../mediatek/mt76/mt76_connac_mac.c.orig      | 1196 ++++++
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    4 +-
>  .../mediatek/mt76/mt76_connac_mcu.c.orig      | 3200 +++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/dma.c.orig  |  314 ++
>  .../wireless/mediatek/mt76/mt7921/init.c.orig |  326 ++
>  .../wireless/mediatek/mt76/mt7921/mac.c.orig  | 1121 ++++++
>  .../wireless/mediatek/mt76/mt7921/main.c.orig | 1838 +++++++++
>  .../wireless/mediatek/mt76/mt7921/mcu.c.orig  | 1357 +++++++
>  .../mediatek/mt76/mt7921/mt7921.h.orig        |  561 +++
>  .../wireless/mediatek/mt76/mt7921/pci.c.orig  |  497 +++
>  .../mediatek/mt76/mt7921/pci_mac.c.orig       |  348 ++
>  .../wireless/mediatek/mt76/mt7921/sdio.c.orig |  322 ++
>  .../mediatek/mt76/mt7921/sdio_mac.c.orig      |  142 +
>  .../net/wireless/mediatek/mt76/mt7925/main.c  |   14 +-
>  .../wireless/mediatek/mt76/mt7925/main.c.orig | 2209 +++++++++++
>  .../wireless/mediatek/mt76/mt7925/mcu.c.orig  | 3506 +++++++++++++++++
>  .../wireless/mediatek/mt76/mt7925/mcu.c.rej   |   35 +
>  22 files changed, 21690 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/Makefile.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/dma.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mac80211.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76.h.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c.=
orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c.=
orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h.or=
ig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c.o=
rig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c.=
orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/main.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.orig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej

Obviously add wrong conflict files.



