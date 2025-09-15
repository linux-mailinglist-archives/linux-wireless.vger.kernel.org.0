Return-Path: <linux-wireless+bounces-27289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 010CDB570B8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89282189D0D2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC62C08C8;
	Mon, 15 Sep 2025 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OlyPxD9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367302C08B6
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919285; cv=none; b=fjqcZAKuZFsifHfhHmp71vNvM2juBGwTWJKFlICyz9ZgWG99zaa7ZrIo7TefSXOVDU1fA0j0nNorvdIAkeBS1zBQIrb9nldYGrTnhxkl0/kp7Q0kBBXRkxlyZDPJbiaVRaE8bFvmDpJbtrwO71r8mkbbhmHXb84J/J+OAKyT85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919285; c=relaxed/simple;
	bh=MK5E6cHajHb3tH8QnDkNDd2QkIjWQD4SZpxJSjA7XHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJYUfSJKtnjYXZsqL7rMozq0T56yn2JaZICpz/Rvkk+uOE78oWB9DDnNSjT3YljhV+rSQlq5QVi0jZiXtHpBQ3EHb8CbjKrS6wNBdjCCmzm6GTmfAclJoWiHcENQLaw3jMZX/MdvZ925WsBSUwsy/m2zKyZhBeLIf005nj+QUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OlyPxD9+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6se7kB593530, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919280; bh=VJ+QtfyZfsS+IQQcocOdbMTaRybuixs5XEeiLsIjKEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OlyPxD9+HK7gxxTxfqLwMj+rT1FMTq3KHiunUHKhGHUyG7/x9Lan+6WnrXtb+PkS6
	 hVv13QrqWZ1KMVWhcxSQN+zGpuhfQOfdxloTmpPoaZPzrmQQSnquXqViapBXGpFuq0
	 h0zBAnddSC7GuZ84+30CtADkqTLK/HZLhOuxUYpyqASBgi03W52iJsSkrOEptnSLm+
	 G2bcQBEyYXkKW1V5e66TLKJpPVlSjoG66BDRSwpWlfzV7755j2KXDuODKoUDeFGyeg
	 gPr7UQSUmEuqFMpVfrXfX4PziOIywm1MQwWVhzatC+QieYoihKwZD5JCgjowKpeLUX
	 T4bpPh/bX8jiw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6se7kB593530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:54:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:54:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:54:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/11] wifi: rtw89: debug: support SER L0 simulation
Date: Mon, 15 Sep 2025 14:53:29 +0800
Message-ID: <20250915065329.38911-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

SER (system error recovery) can deal with different crash types by
different levels of processes. Now, add a debug function to trigger
MAC error in purpose for SER L0 simulation/verification. And, extend
dbgfs fw_crash to accept different parameters.

    # simulate MAC error (one kind of SER L0)
    echo 3 > fw_crash

Normally, FW won't report SER L0 cases to driver. Instead, they will
be handled by FW directly. If unfortunately FW handling fails, SER
will rise to L1 and be reported to driver.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 64 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h   |  5 ++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index a37cdd73ddc3..3dc7981c510f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3563,6 +3563,58 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_dbg_trigger_mac_error_ax(struct rtw89_dev *rtwdev)
+{
+	u16 val16;
+	u8 val8;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	val8 = rtw89_read8(rtwdev, R_AX_CMAC_FUNC_EN);
+	rtw89_write8(rtwdev, R_AX_CMAC_FUNC_EN, val8 & ~B_AX_TMAC_EN);
+	mdelay(1);
+	rtw89_write8(rtwdev, R_AX_CMAC_FUNC_EN, val8);
+
+	val16 = rtw89_read16(rtwdev, R_AX_PTCL_IMR0);
+	rtw89_write16(rtwdev, R_AX_PTCL_IMR0, val16 | B_AX_F2PCMD_EMPTY_ERR_INT_EN);
+	rtw89_write16(rtwdev, R_AX_PTCL_IMR0, val16);
+
+	return 0;
+}
+
+static int rtw89_dbg_trigger_mac_error_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_CMAC_FW_TRIGGER_IDCT_ISR,
+			  B_BE_CMAC_FW_TRIG_IDCT | B_BE_CMAC_FW_ERR_IDCT_IMR);
+
+	return 0;
+}
+
+static int rtw89_dbg_trigger_mac_error(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	switch (chip->chip_gen) {
+	case RTW89_CHIP_AX:
+		return rtw89_dbg_trigger_mac_error_ax(rtwdev);
+	case RTW89_CHIP_BE:
+		return rtw89_dbg_trigger_mac_error_be(rtwdev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static ssize_t
 rtw89_debug_priv_fw_crash_get(struct rtw89_dev *rtwdev,
 			      struct rtw89_debugfs_priv *debugfs_priv,
@@ -3578,6 +3630,7 @@ rtw89_debug_priv_fw_crash_get(struct rtw89_dev *rtwdev,
 enum rtw89_dbg_crash_simulation_type {
 	RTW89_DBG_SIM_CPU_EXCEPTION = 1,
 	RTW89_DBG_SIM_CTRL_ERROR = 2,
+	RTW89_DBG_SIM_MAC_ERROR = 3,
 };
 
 static ssize_t
@@ -3586,6 +3639,7 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 			      const char *buf, size_t count)
 {
 	int (*sim)(struct rtw89_dev *rtwdev);
+	bool announce = true;
 	u8 crash_type;
 	int ret;
 
@@ -3604,11 +3658,19 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 	case RTW89_DBG_SIM_CTRL_ERROR:
 		sim = rtw89_dbg_trigger_ctrl_error;
 		break;
+	case RTW89_DBG_SIM_MAC_ERROR:
+		sim = rtw89_dbg_trigger_mac_error;
+
+		/* Driver SER flow won't get involved; only FW will. */
+		announce = false;
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	set_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
+	if (announce)
+		set_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
+
 	ret = sim(rtwdev);
 
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index d94d73e50e93..ed1d958bc49e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6262,6 +6262,11 @@
 #define B_BE_PTCL_TOP_ERR_IND BIT(1)
 #define B_BE_SCHEDULE_TOP_ERR_IND BIT(0)
 
+#define R_BE_CMAC_FW_TRIGGER_IDCT_ISR 0x10168
+#define R_BE_CMAC_FW_TRIGGER_IDCT_ISR_C1 0x14168
+#define B_BE_CMAC_FW_ERR_IDCT_IMR BIT(31)
+#define B_BE_CMAC_FW_TRIG_IDCT BIT(0)
+
 #define R_BE_SER_L0_DBG_CNT 0x10170
 #define R_BE_SER_L0_DBG_CNT_C1 0x14170
 #define B_BE_SER_L0_PHYINTF_CNT_MASK GENMASK(31, 24)
-- 
2.25.1


