Return-Path: <linux-wireless+bounces-21813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8DA95AA8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE6172217
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73817F4F6;
	Tue, 22 Apr 2025 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GbAfqc6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2634645
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286445; cv=none; b=Q47JPoh2iafvHbBGAPWQs+erQ29McBGi7bawVMtSltYyUy0kwEMPWVdV1CY5ed/mTHjIspH6o9wDLBafH8QQEXauRxe8we4oIqPw5DvLdSBLO46PxLJ94EAMNB0ETCYn1SrKMZYTIaMwz+gTzl8dr56CRGHNlk41Fd0W74GPtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286445; c=relaxed/simple;
	bh=ZR9snSwXnk7YTCFxp0ygQ1gjFU5YtjsDnpPE+l/vCcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gkm4e8ZEk9MWPGLU/eOrQWmUX32/yTvhkUS8GXw7Ws9PTtq2EtxTuuOegZrikriECZ/MRztzRd6IvSqZOB99IYnItVGvTjVIA2Vl5nn9TM0IL4Bdr835jjC0QT+nz0H79qfR25DPws7czC25cPVGe55Sj17uU38II6TzMhpeVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GbAfqc6L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lLzS53859563, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286441; bh=ZR9snSwXnk7YTCFxp0ygQ1gjFU5YtjsDnpPE+l/vCcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GbAfqc6LpOH/P0WNJeKk6ubKQ47qWGdIAJcpHZzDWHiRngYRLBHCz26Iw3hnKHuYU
	 yjZLDYoBM9UTvam8A0JvlTkHGXQJ30JYByQVxJoYtCLS4ImxgY0BKaKYl001lowswU
	 EKD+b44XbGxFdr7BTw9eo8JLXW+HpksXm8Cx7JADq/eNoNSAhNxE5w955vMvtYrRYP
	 op6ne2jLvkNEOAfYn/kdiRJn00qzLMnwYXgpiWVe3LvsU5wCg/i5SkjKTkB2Rl0kq0
	 bOmP+vzrostZ0nT/sNZBkin+eZ1P9+6NtpK+NwAfoi9WYDKNpZoCG6OKONQ3nG3LOD
	 GetffM877MapQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lLzS53859563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/12] wifi: rtw89: mcc: handle the case where NoA start time has passed
Date: Tue, 22 Apr 2025 09:46:16 +0800
Message-ID: <20250422014620.18421-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

MCC will limit the time a role can use in a schedule according to the
periodic NoA. Original logic didn't consider the case where NoA start
time has passed. It might lead to inaccurate result. So, tweak it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b5fb5669eefe..530f8c52efe8 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -787,6 +787,9 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 	}
 
 	tsf_lmt = (tsf & GENMASK_ULL(63, 32)) | start_time;
+	if (tsf_lmt < tsf)
+		tsf_lmt += roundup_u64(tsf - tsf_lmt, interval);
+
 	max_toa_us = rtw89_mcc_get_tbtt_ofst(rtwdev, mcc_role, tsf_lmt);
 	max_dur_us = interval - duration;
 	max_tob_us = max_dur_us - max_toa_us;
-- 
2.25.1


