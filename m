Return-Path: <linux-wireless+bounces-19472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0CA4590C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735641889F5F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADB22424E;
	Wed, 26 Feb 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T6AYdOyq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B1258CC0
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560061; cv=none; b=YFU5LSqe/Zz147/f75VwllDvp0rmvebHZ1NR7q2r9D+6GDhfd+tc9ngpFNlaIaNQDZm9pYOJ2QrK/ZU15DEYT0/jqM9grWmPQzmjeEXwMlJ+8u/D4HQE6sdy3djdEShDqbq/3ZjFDF0DH0Rci8PnX6XiFx5g9l6ZgVqmHH3DGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560061; c=relaxed/simple;
	bh=Ya7r0FNLiVcmazO8mWhrA+bQ+hKKnFyNdmWwCuQhQho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuyZZ59AHO/Lps/C2pSb2HUlbh8Q3kgDlY1Gf969PNQZMrhB2X7yo8M2VwHv5bn8QPqSPqaF7XmGijDs9c37omshPTclGKwF/9p4BqRlB/fD4VHDsHtpLRI9VXsgxjS3aFLDmaYbamDzETx0yODfs85OT+LQLgnsAzlaPPD5Sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T6AYdOyq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q8sIe353439551, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740560058; bh=Ya7r0FNLiVcmazO8mWhrA+bQ+hKKnFyNdmWwCuQhQho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=T6AYdOyqYPN1foEOjQ3ejSP3UW9lOUrMpHIqCdyzmV1+pAqbgDVIxwE7NiPTJpyxz
	 C+qlZF+h2m/ka21dK+7I4k23pnUqw/QydW5ZjGJVn5qHhatvdNbzsAOkoHH1BnY/Rw
	 efw0aZLszkXqWllyY/du1tM3jga87CCapvbtt7Ak57hhrjOdgKI/vN74FNTuIwu9y7
	 Ck0dCefen6rTbVn658Tz4UgdKgfTU8QTVUzXm+UTPXyhp/tpvFzhU6VdV8EAGmN9gu
	 mvQ7Gf05iXmP+R1YGa16ROgtByHrgbJYcGpkA5kx0k8jUkfK1X8Ukx/W9HGOf8JtU6
	 UJn7bu6RW5JTw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q8sIe353439551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:54:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 16:54:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Feb
 2025 16:54:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next 3/3] wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
Date: Wed, 26 Feb 2025 16:53:15 +0800
Message-ID: <20250226085315.263982-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226085315.263982-1-pkshih@realtek.com>
References: <20250226085315.263982-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The format should be "%08x". Fix the mistakes.

Fixes: d60e73e5dd70 ("wifi: rtw89: fw: load TX power track tables from fw_element")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1965a62746c2..15d6bda1fcf0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1099,7 +1099,7 @@ int rtw89_build_txpwr_trk_tbl_from_elm(struct rtw89_dev *rtwdev,
 	bitmap = le32_to_cpu(elm->u.txpwr_trk.bitmap);
 
 	if ((bitmap & needed_bitmap) != needed_bitmap) {
-		rtw89_warn(rtwdev, "needed txpwr trk bitmap %08x but %0x8x\n",
+		rtw89_warn(rtwdev, "needed txpwr trk bitmap %08x but %08x\n",
 			   needed_bitmap, bitmap);
 		return -ENOENT;
 	}
-- 
2.25.1


