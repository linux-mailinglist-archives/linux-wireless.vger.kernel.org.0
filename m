Return-Path: <linux-wireless+bounces-26259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60218B20903
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793332A36F6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D02D46A8;
	Mon, 11 Aug 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GIie0QgX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7FDF6C
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916026; cv=none; b=CZjrPjq544I9xbPAHQRfM00xUXhLiI222wYYbwmd8qBjco6I/HHoKWzOXv1Dg6FeOJgPtNYiUKGmp1IUMNetOH3o+iYcibMXfh50rvyo+RReGFtI5zSBXVHII+rWcX0Mni/mnOPHFIPT/nAgaQBzruNeGCUqJytry36QoowaTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916026; c=relaxed/simple;
	bh=07NubfRz3qcR5mPh0sq7i7cihMLrZp+FsSWFXc3GNNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhWrXgilsSfDA5T8tMQpS9Y5Pzy2q5pJu2Wg594PiVZguGONVXxJIe5t/PCZLVjLVDMyvkM0eC4341JrrrSgH1/V05i0aT5JFVj2vVf2VH54g7bBJ7RTvsh86WeocLDbhF15V97K3QK76QT0eRzPv+3yYqhDT+OTwxNY3E9TOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GIie0QgX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCeM8e9074070, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754916022; bh=qWOE/x7/rM9vvfLsVhSxMpFEth0NIcl4lIsw+znLfEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GIie0QgXEaADDYqQuPVBVlLtUkqIGkdxkjxvvF9ErWewew8cHpl1e15fjDfk670Iu
	 ZpSHp0ftQ335BH6dnIj2tvdzs5dGaBLLTh8JTiZOPISgXJiPj1OwtwYb1WQV/T9JkT
	 IPhJ8LK3qQH30epk6+RijXUW7hGEVadW5dWeyu0tcf19DXaVGS5U4qLi/3WzeEQknC
	 7llWKs+MGAK2xerkfwPfI+zW3CwyKO8fCA7Cpkqph8OZa7MggpsAxkL8608QzEfgHU
	 Kn2GKwHDzNCR1G0d0AFZ6y9c9jDpXu+2sU8LVsGduyPWwZjI/EOZCVljtqUjh3nH9g
	 7EHw2kZI7ZhYw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCeM8e9074070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:40:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:40:22 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:40:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 6/8] wifi: rtw89: 8852c: check LPS H2C command complete by C2H reg instead of done ack
Date: Mon, 11 Aug 2025 20:39:34 +0800
Message-ID: <20250811123934.15614-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811123744.15361-1-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Chih-Kang Chang <gary.chang@realtek.com>

8852C after FW 0.27.128.0 driver check LPS H2C command received by FW
using C2H reg instead of done ack.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 398d8ab98f63..ede4c15314a8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -847,6 +847,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 80, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, BEACON_LOSS_COUNT_V1),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 129, 1, BEACON_TRACKING),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
-- 
2.25.1


