Return-Path: <linux-wireless+bounces-30128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC36CDE60E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 043103008EB5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466D2652A4;
	Fri, 26 Dec 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XSuuy7vA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8F18DB26
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729762; cv=none; b=U/AB72/KgSfblKN+cuCai162KVUx/zN6rEqttiamR+zcO9as6tCUyRduc933io9FPDFCdmc2STHqNMIMGDufgD3kmnUzMxKrFej3I3eawhZhcU1C3oqzY69wjvnrgyVWwyYnvwjpDgzPE2WbgNqHd26RlkxMxjAc98MLnX5Lxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729762; c=relaxed/simple;
	bh=Xzuk3FilAuDDNOVLNRuBjODlNF9IAmBLuF6Zrzvb8JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g00ru+6tgdSjqFb4B1Ct8qFVj6M3HvF6y6Wj/BjXK7FjX0A02Hn6kkA1H8c46Vpbj+1Q9fNUWh3pn2NSFU+QRzMBYOFTGbNsW3aeHHryJlLT47Btl8KaJEYzymswP8UHQoDuM0OTo9gnnuKhAGSSAqdsaA5w0wRvX/BNDYXi49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XSuuy7vA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6FwDdA3114774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729758; bh=drtJUr522fQ3G4WNkDSNcRdtJdc/t31cD5V1Yu+Aw0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XSuuy7vABgjUy2Pkp4W4U568nHy4Wb0JENNmUFUYuLKXcYqpGO7TX+T5xS1JDt8Fu
	 z//pot7/UPfLHGUM5/JgM7wbLqXcHgELZB64cjUgU9EsXIEGN5wXJMeRvlHfyd91GH
	 FxeVANyBesE6zTxNi2gk1F9GWdY3PKleMRS2MWEK0ubEzcrdYb2Q6ZSD7jU2AfgoEX
	 2gTvtdyYqGuTKx97qQviztx5eDENeKhpiWtkF6T79ECfEq6eNGRN+XVhLSk/I1h4Cz
	 lpCKlJtafcnwwR21VlhPMLYkTH51N68dIM/Rg+4szqbb3YEDmbfta76d44DE2MgXp7
	 sPafbNOTsCDRA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6FwDdA3114774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:59 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/12] wifi: rtw89: regd: 6 GHz power type marks default when inactive
Date: Fri, 26 Dec 2025 14:14:45 +0800
Message-ID: <20251226061446.63514-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
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


