Return-Path: <linux-wireless+bounces-26986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E246BB4303B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 05:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2601BC6944
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 03:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB4B281357;
	Thu,  4 Sep 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HE7JT6Hx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C227FD46
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955239; cv=none; b=cIkwcG50b9GRHy5W+xMlKY60+6HBI28iIYXIct2ZO9eBV4CLjWnDOV+zgxCmR0LxbXVCtnTsy+r8GTH0PJ/EbBtl4fMlzHLSKmapggeJNYDSvFDd6fkgP5MhOL2e8xQnTpNFNsMEylXVxnFxpKX+QREsd1x0HNPB5yu7XkiNRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955239; c=relaxed/simple;
	bh=QWvVnpySlAM7/C3jJ4DpLgpzXy4XeBj+V/r04c7k1bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZUW/4+04mHBCMpAZm73uTMkzdEv6D0/F67xqVfiSmlYCiCvFvNh7Qxj3O7nlyXAiEo0oH3bx6bcLVU9KcJEKwBoqMOuxIOHqQ0Gm45D7jQWJFBU+BxR/9Jdh+sSu9FvQSyGYTBNgzrE0yovTubN6ZnBkC/79cZF9af9TjJbMirk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HE7JT6Hx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3d09a0e8893c11f0bd5779446731db89-20250904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gkBOdO/yHM0OSioJ3xLSP7FVBinfICtJku8Tde8YbO8=;
	b=HE7JT6Hx4w+Ihr5TjzLBfcnST65Vtw0RZ2FmmNB8W82VLFeRsprd878skw8aSOaBFXgoZsBoBHbu0uDZAXdvCpM0OCSjQY3x77e8fAXoob7TKXbNcH9tiylN8ayrQ/IbMf/PJxwHgISlky3k1tUKzkal+ZQDR9Jf1PvwqV3qnv0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2a1c7f46-2d68-4072-b45b-513c8355a0ae,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:b2e9ecf7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d09a0e8893c11f0bd5779446731db89-20250904
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 274795863; Thu, 04 Sep 2025 11:07:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 4 Sep 2025 11:07:03 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 4 Sep 2025 11:07:03 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 0/4] wifi: mt76: fixes for mt7925
Date: Thu, 4 Sep 2025 11:06:45 +0800
Message-ID: <20250904030649.655436-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Ming Yen Hsieh (4):
  wifi: mt76: mt792x: protect state->cc_* counters with cc_lock
  wifi: mt76: mt7925: prevent NULL vif dereference in
    mt7925_mac_write_txwi
  wifi: mt76: mt7925: prevent NULL pointer dereference in
    mt7925_tx_check_aggr()
  wifi: mt76: connac: synchronize token_count access in
    mt76_connac_skip_fw_pmctrl

 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 9 ++++++---
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c  | 4 ++++
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.34.1


