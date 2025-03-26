Return-Path: <linux-wireless+bounces-20826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB70A70EBE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D19D1771B0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAC199BC;
	Wed, 26 Mar 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="unSyou4S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8A41C85
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954826; cv=none; b=GnGrKHupqaClUS8R3sZcpTbGUCN+3K377l2A3GOlWS2YKd3PvHfNVi+J4fD1yZ67zu8bo47pGNrXLpPVhhbpbbT2WRAOcLCjDMruy2AHOPLXw/UHjDssE7wb1c0lmiSgOgj+EXa4YCd49+AtD0bwgjAEMmXdV0mOXwpZLUTEQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954826; c=relaxed/simple;
	bh=u7gwGjCu4oifg3Pirw4uW695nJM7NdOvK4/QLAeneSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTjlGIVKmXyqfJ7V8kOeq7rVraoqvtZHqIj9Yk0vg4j/zLPBvHZBdQpKApQSsKLb7fDY7bqTFaWa40CBYSlQqdXfd/RwS0fb+6/YKNHLD6BuZNNwKu7Ts4LQKbOUHFezqRvmuwsIOpDB6csrjmqrO8MHYASAhnbOPWk27r+164k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=unSyou4S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q272bxC1406997, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954822; bh=u7gwGjCu4oifg3Pirw4uW695nJM7NdOvK4/QLAeneSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=unSyou4SQqIK5UvvTyneqCvQwF1X+mxRwsXUXpRtdV6bEiik+HZbAZgrNlZoYibKh
	 qTKj/fW3QXgYzzvnn0THX7LMs/ljVCxBitSM+fO27RtWtudu+dCOjEObT5dGgH/0wt
	 Ot68KGLzMP2ZgJtOXvSL5GWdMXVw625BUmmlDqdpJ0DFoBTt2XGIN2zkz47tueW9Da
	 WcW89/zGiPZrqsAeIWECV6hzS/S7KiSxksyx4IIdkqYkXmhhDPpK9YyI1uoYPFTG/W
	 rpEKrAp0lhipXP+H3Qp0sFCySHnILErWVJv/0n6iJ+svV6I1f4+b3xBgDCXNxnGU7R
	 6DLYPpsl4v4GA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q272bxC1406997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:07:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:07:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:07:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 01/12] wifi: rtw89: fix typo of "access" in rtw89_sar_info description
Date: Wed, 26 Mar 2025 10:06:32 +0800
Message-ID: <20250326020643.14487-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250326020643.14487-1-pkshih@realtek.com>
References: <20250326020643.14487-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The "acces" should be "access".
So, fix it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4be05d6cad18..8e9697679aaa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4631,7 +4631,7 @@ struct rtw89_sar_cfg_common {
 };
 
 struct rtw89_sar_info {
-	/* used to decide how to acces SAR cfg union */
+	/* used to decide how to access SAR cfg union */
 	enum rtw89_sar_sources src;
 
 	/* reserved for different knids of SAR cfg struct.
-- 
2.25.1


