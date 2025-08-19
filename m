Return-Path: <linux-wireless+bounces-26446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FF5B2B7ED
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 05:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922D83B8FF3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768B1946DA;
	Tue, 19 Aug 2025 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nudl7TrM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14223741
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575144; cv=none; b=RZaw1j4c5ncjzay2liU38zezEYhebD5ObeEfVXx81FresdoGhz2+tibaUCL038jLkBpP7T6C0GHYxuPjk30dfKjyZ6WfYgLD6hAKxnhrWaxoG04pKpW7+wfxWRWbGfCKqvfoOvUsMlA/iYYueaetjMiwllrUkLal/bK5S+m7b4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575144; c=relaxed/simple;
	bh=HPtDGAxHZHO+XbCSAx7rvFx5yWq+M71iTY4o6umoGew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFMn8A6gY9w72IMElpoGEXPM740yhG+3dM+QjehDFsNq93+aNHexH5c2AjpOB63H/LnBF9UJGBAOev7LM/mRE3aY6TKB9Gpjo8VZmAI/kjh6XqBQEX+TLWKlzbmSbE4DKttLGFv/rEa1njO/WYi6Q/RWshMP9Pd+Kemwx+8shRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nudl7TrM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J3jdcV72064823, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755575139; bh=Y+H2p+UKQJlcr/GixGVunZdVfOnUhB27rQCredCLy7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nudl7TrMhoz5Hsgc/UBbQcWms9TOxZAPbdonoFe+YIPFyQV57Ug1OEB6a/8xMfC13
	 AbfU+XDnCd9IeNj/CTQnEx603Zsv5rHVg8cq1b18NMd6jirzle57jjUXLoM6tWBL+L
	 Mg+hhOmxfwE2Fk7iagYrp9wCJMjS/LdKBxIlz8HeHgL0mED79JmuH5ByZDnV1V6zq9
	 ZqDL+NDmMy1esHGLCFMJRYa5UfzAFdE9/gyuTmvltqYugGyiyn+dkTtDdmq+NOV2e2
	 r/Sh3Ca5DS3Ua7KAVvQo1sz4g2OFHDiu5yeo+4ckoeGMjg3l+HLmQHMVLURUngCub0
	 oYL9Q+cHnABHA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J3jdcV72064823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:45:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 11:45:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 11:45:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 3/4] wifi: rtw89: 8852c: update firmware crash trigger type for newer firmware
Date: Tue, 19 Aug 2025 11:44:27 +0800
Message-ID: <20250819034428.26307-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250819034428.26307-1-pkshih@realtek.com>
References: <20250819034428.26307-1-pkshih@realtek.com>
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

The newer firmware (after 0.27.128.0) uses trigger type 1. Add an entry
accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ede4c15314a8..334c33e6251d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -848,6 +848,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 80, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, BEACON_LOSS_COUNT_V1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, LPS_DACK_BY_C2H_REG),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 129, 1, BEACON_TRACKING),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
-- 
2.25.1


