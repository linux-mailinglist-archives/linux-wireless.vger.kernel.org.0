Return-Path: <linux-wireless+bounces-32819-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MdGFDTQr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32819-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:03:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDC246E0D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71AD83027E25
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D723ECBE9;
	Tue, 10 Mar 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FlNfD9BI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CB3ECBF1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129777; cv=none; b=i24/im83m30/sqzypPcfAnvhfdTCVO5UHkpNlzp3fPTCwodGLl0Dxg4QGG+MnxC9470gJw2100xrP+uLRZZq4kGHhBaDa5jhCSuLkCqgse+JB/dM0/2nFVpmZAgFz+6TgdfGK3jvQKHaCR7v7GAeu+/44n1J5SKyheJ0jxs8cDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129777; c=relaxed/simple;
	bh=8yal0697GZWsEu/QjZtReN64oPPOimryfgiUSU1nzOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdwJIHnWOi+50xjgiQ2pvkrTiBgAxkndfNjjLrziJvIQL3FuSO4O0MmSfZmLlKM3KWuEnUS256J02xPpAihL8tiI2LfrIku21GVUWrMrp/e+BSPr8TTRXRSFOPJfmAyUh8IQ6hMqkND5rCfGx1RUhoyy47IPT9wbzuzxzOj1D88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FlNfD9BI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82spyE2211393, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129774; bh=2PRPKamk1kHWiu1NGCElAw8BeEs5U6DaEZl5WuDqvII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FlNfD9BIJEVyZOpUMwXDqCRyUKJwR40PybBVoBulwLSpoSEdR9j5+Gvn1jh14cIk7
	 zhOYjkAI9F5uSzKaM/zsr8UaHUBrpZHIj0PZhS3WtLfbH/nzCFwITp9d1iYr7qHytv
	 +l6Jbsr1rbVdVk8OgRXls3ya5VAz6ebDjXkPV74hTe1/uA6dFiMACBzG1VP0cE9j08
	 rGDCStKgOeRpH1WSQLBe9Li67ehBQruIlzrbpqneXRVUdpgdxQ+kposCyf31ewiqvz
	 X29rCcN2tJlABsQjNMtFHe+OXhZHJBENobLJeWo4TDeva0e+ps/0NrP1ujzJlQ+1U9
	 Mm/ZNGWnFu7Ag==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82spyE2211393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:54 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/13] wifi: rtw89: replace RF mutex with wiphy lock assertion
Date: Tue, 10 Mar 2026 16:01:43 +0800
Message-ID: <20260310080146.31113-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 08BDC246E0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32819-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Now, stack has introduced wiphy lock. And, the normal paths calling
RF read/write should be under wiphy lock. So, replace RF mutex with
wiphy lock assertion. Besides, in dbgfs paths, add the corresponding
lock option.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |  2 --
 drivers/net/wireless/realtek/rtw89/core.h  | 14 ++++----------
 drivers/net/wireless/realtek/rtw89/debug.c |  6 +++---
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6ab99a3577f3..18dbf3664f0a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6147,7 +6147,6 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		return -ENOMEM;
 	spin_lock_init(&rtwdev->ba_lock);
 	spin_lock_init(&rtwdev->rpwm_lock);
-	mutex_init(&rtwdev->rf_mutex);
 	rtwdev->total_sta_assoc = 0;
 
 	rtw89_init_wait(&rtwdev->mcc.wait);
@@ -6206,7 +6205,6 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev)
 	__rtw89_fw_free_all_early_h2c(rtwdev);
 
 	destroy_workqueue(rtwdev->txq_wq);
-	mutex_destroy(&rtwdev->rf_mutex);
 }
 EXPORT_SYMBOL(rtw89_core_deinit);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 01573150ab3c..ce04ecaa3a5e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6182,8 +6182,6 @@ struct rtw89_dev {
 	refcount_t refcount_ap_info;
 
 	struct list_head rtwvifs_list;
-	/* used to protect rf read write */
-	struct mutex rf_mutex;
 	struct workqueue_struct *txq_wq;
 	struct work_struct txq_work;
 	struct delayed_work txq_reinvoke_work;
@@ -6808,22 +6806,18 @@ static inline u32
 rtw89_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 	      u32 addr, u32 mask)
 {
-	u32 val;
-
-	mutex_lock(&rtwdev->rf_mutex);
-	val = rtwdev->chip->ops->read_rf(rtwdev, rf_path, addr, mask);
-	mutex_unlock(&rtwdev->rf_mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
-	return val;
+	return rtwdev->chip->ops->read_rf(rtwdev, rf_path, addr, mask);
 }
 
 static inline void
 rtw89_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 	       u32 addr, u32 mask, u32 data)
 {
-	mutex_lock(&rtwdev->rf_mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	rtwdev->chip->ops->write_rf(rtwdev, rf_path, addr, mask, data);
-	mutex_unlock(&rtwdev->rf_mutex);
 }
 
 static inline u32 rtw89_read32_pci_cfg(struct rtw89_dev *rtwdev, u32 addr)
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index aee0f25e036a..d461ffc6dc9e 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4859,9 +4859,9 @@ rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
 static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.read_reg = rtw89_debug_priv_select_and_get(read_reg),
 	.write_reg = rtw89_debug_priv_set(write_reg),
-	.read_rf = rtw89_debug_priv_select_and_get(read_rf),
-	.write_rf = rtw89_debug_priv_set(write_rf),
-	.rf_reg_dump = rtw89_debug_priv_get(rf_reg_dump, RSIZE_8K),
+	.read_rf = rtw89_debug_priv_select_and_get(read_rf, RLOCK),
+	.write_rf = rtw89_debug_priv_set(write_rf, WLOCK),
+	.rf_reg_dump = rtw89_debug_priv_get(rf_reg_dump, RSIZE_8K, RLOCK),
 	.txpwr_table = rtw89_debug_priv_get(txpwr_table, RSIZE_20K, RLOCK),
 	.mac_reg_dump = rtw89_debug_priv_select_and_get(mac_reg_dump, RSIZE_128K),
 	.mac_mem_dump = rtw89_debug_priv_select_and_get(mac_mem_dump, RSIZE_16K, RLOCK),
-- 
2.25.1


