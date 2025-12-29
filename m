Return-Path: <linux-wireless+bounces-30158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF63CE5C7C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2859D30006E0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E781FBEB0;
	Mon, 29 Dec 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iwAfcHrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBC224F3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977845; cv=none; b=sM1ylYKWrTwskiJ863NSIauuGu3Tl8mRRRdndKGNhOWpqkai2+fq5K754jFa6eJVjWQlfYuEHyP8LCN1xRMZFi2vE7g5CP7obj7lKBffwdrotlzgQb6Az1zO853MqMDGjEcuOke1PQ5eBQgvZWF3m50ruA9RH144KMJlHtVc4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977845; c=relaxed/simple;
	bh=Xzuk3FilAuDDNOVLNRuBjODlNF9IAmBLuF6Zrzvb8JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvqctMfY2kgHBWy1lYQxrvvI9FKou0PD5pGuFQfse2Aow1QropjqAjpy3Z2Sbs8oaiZ2AKDCCAU1xM2fkO6ScHvP84/COiMEt5w83uW3WN9XJIIoGyWJpqaifPveUMaOqQSLsXMKOsdRIpWdTOKlQHRDnxzZKLWlWRe6ps4PP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iwAfcHrR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3Afs36283527, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977841; bh=drtJUr522fQ3G4WNkDSNcRdtJdc/t31cD5V1Yu+Aw0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iwAfcHrRTgd++IldBl2ks4IcAWQFH7i8p7oxTTnWbv5WytVJTSpelR+EokSp9J8rK
	 mHFRecrX5RHSzzlZrF82UDQtC96Wktx50cI6jS0NObIeF6aPT/9KIu8Hm4C/+Zq4WI
	 +LUe111OgrN7XXv5ApIL/IyPnrbD5qqrs22YIk0EI3HlOIL4Vz21BXLSnzp9zP1osW
	 4+lD27NO4f6vJzwJhCmOIj0y2TyFg4p/CCSX/AtRKqOYurwcKAsNSsl/lkGGQuLpLQ
	 sdpCjwgQyNWyLsjlP0Gtk2n4U43XJqG2SetMw+XxRMz45L9QByeZqyw0uKG9HEs0DW
	 drfB/i9we8cPw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3Afs36283527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 11/12] wifi: rtw89: regd: 6 GHz power type marks default when inactive
Date: Mon, 29 Dec 2025 11:09:25 +0800
Message-ID: <20251229030926.27004-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When inactive, 6 GHz power type has been assigned to the default one,
but missed to mark the local control variable, dflt, true. Then, this
might let some 6 GHz power info of disconnected APs keep being taken
into account under certain cases.

So, mark default when inactive.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 209d84909f88..c3425ed44732 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -1142,6 +1142,7 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 		}
 	} else {
 		rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+		dflt = true;
 	}
 
 	rcu_read_unlock();
-- 
2.25.1


