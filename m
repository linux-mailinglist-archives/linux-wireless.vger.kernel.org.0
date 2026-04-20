Return-Path: <linux-wireless+bounces-34997-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EKfEYOg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34997-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB7426948
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844963011C49
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA63783D4;
	Mon, 20 Apr 2026 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vnhz6vBb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFA377006
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656494; cv=none; b=JTSWRsczvUWuxNGp3LnNSVzxetFirFZ17IqCECJ4DFX5HQj/end4Al0k9r6q9rrw9ATdCGaRRCTbZQWSAHNf9LSH7pLgQlm5H0OjCXUH+Aq7Hbarfp4rjC7MURmkHxsCCPxrRDic3u7oWJHYln1LRCcURmJmb2yLohQ7Z1xq7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656494; c=relaxed/simple;
	bh=WNE0PRbSleLyAWoO9ucrIEdRjF30dH0GFj45AI+HvSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+Ml7MKAI3UVzR1NdbgX2uIyyi6srdHBi45wASg3U7Lxuz7J/s+PdLq6VENMXefFrjPh+uD3OstKBbZ7dfc6YEsyyBM7Qypl5ZmKVAC3tHi800g8y4QLnLIpM/Lp5O2Es6HgdEjz314GYtgCDjTQYWpmsNWcjvOc47L/Y42lJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vnhz6vBb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3fUozD426718, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656490; bh=CR+WqwCh5pBvLjVysAfAEJVYWHrVyAh/3vKWyK0G4FU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vnhz6vBbMNp5KMRN7Kwe0YeOhTssMkHxsSoZRCFL7NF7froVuZc/zH2CloQQeuPIn
	 jx1GDDSlpSmH9mek5J8vBGu4Amc16LMoWaMFbsSatGicRv8MlBRAXOSiGNgUG1C9B2
	 rzlN9pML+8o26CROhU89qX78sZLTieMRfFUEgZYOhHXGIrVOblXKclCGuP+Wwrwx/q
	 Zekk/t3YOozklxWisxybz4FJyIMlOwlQxrKdjnmGLtLJ9GbXeJphfdGHRkPlTevL0/
	 /eXpBxyFGl0Nq/7cX3r+3Fo+JSnoc5mF5yDvvco1Qsbnb/T0fqz1rLuuFUWkkd9pWd
	 XhtPFWR+qyoLg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3fUozD426718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:30 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:30 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 04/16] wifi: rtw89: debug: disable inactive power save to reduce bus overhead
Date: Mon, 20 Apr 2026 11:40:39 +0800
Message-ID: <20260420034051.17666-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-34997-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7FB7426948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johnson Tsai <wenjie.tsai@realtek.com>

This helps avoid excessive bus traffic and I/O overhead on
slower HCIs (e.g., USB, SDIO) caused by frequent power state
transitions.

Add RTW89_DM_INACTIVE_PS to the disabled_dm bitmap via debugfs and
check it in the rtw89_enter_ips path. When set, the driver skips
entering inactive power save and returns immediately.

Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  | 1 +
 drivers/net/wireless/realtek/rtw89/debug.c | 1 +
 drivers/net/wireless/realtek/rtw89/ps.c    | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4a05a8dbb9ed..4e920472c8aa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5179,6 +5179,7 @@ enum rtw89_dm_type {
 	RTW89_DM_TAS,
 	RTW89_DM_MLO,
 	RTW89_DM_HW_SCAN,
+	RTW89_DM_INACTIVE_PS,
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 02386d1d07c6..ebe3b1f9c39d 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4348,6 +4348,7 @@ static const struct rtw89_disabled_dm_info {
 	DM_INFO(TAS),
 	DM_INFO(MLO),
 	DM_INFO(HW_SCAN),
+	DM_INFO(INACTIVE_PS),
 };
 
 static ssize_t
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 125cf14fa581..31bb5dcd284a 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -234,8 +234,14 @@ void rtw89_enter_ips(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_vif *rtwvif;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	unsigned int link_id;
 
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_INACTIVE_PS)) {
+		rtw89_debug(rtwdev, RTW89_DBG_PS, "skip enter IPS due to disabled_dm\n");
+		return;
+	}
+
 	set_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
 
 	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
-- 
2.25.1


