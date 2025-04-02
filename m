Return-Path: <linux-wireless+bounces-21059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4BA788B0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 09:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F35B16FBD4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0A233701;
	Wed,  2 Apr 2025 07:11:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B8231CB0;
	Wed,  2 Apr 2025 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577872; cv=none; b=JFJrwQ/dP61KgVN0KoefD1zw08UFPI8imA+CDB2sloM4UpVaXLHAnOQCejaQLYRIszFsiYMe1A/7ZFavq9oPDZvbhTZGC0Abk8jL/3Mp0V1DG75wJk1hwHDPesXj5lv8/I01JPUQVKz/aTIdpfSFwQIyrI//xgMHhufTa6u/d3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577872; c=relaxed/simple;
	bh=XQlBs4MWg6zV4rM+kXg/Gqvvzm2T9P4VGZapl0Pr2sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNxboLAK7b17RHCRqb+ZuWOE0OFWwnCqD/tpzNcMpLgiEfbg2VaBn0lcZr3YO1srXejwCylvmeSmANfKusbpxt2DpXJ2ggPb7kYB0CvO3a/178CYGqUHTFfQumpsDAjb/OdpvEnZKUxmkDJJltcCVBCmr+WceeyqazAqoESYf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABH7v4C4+xnizYWBQ--.19487S2;
	Wed, 02 Apr 2025 15:11:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: pkshih@realtek.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl892cu: Set limit for pwdb_all
Date: Wed,  2 Apr 2025 15:10:40 +0800
Message-ID: <20250402071040.3155-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH7v4C4+xnizYWBQ--.19487S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF15Jr4DCF1DZF4UJr4fXwb_yoWkWrX_Cr
	W0qF9ava47tw1UKF43JFW3urWI9F1DX3Z5G3y2qrW3C3Z0qF95Zr4Sva45GryUWFyvkFs3
	GwsrJFyrA348ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjSdgtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkAA2fszLMcGAABs8

In _rtl92c_query_rxphystatus(), the return rtl_query_rxpwrpercentage()
need to be checked. A proper implementation can be found in
_rtl8723be_query_rxphystatus(). Add a value check and set the limit of
pwdb_add as 100.

Fixes: 666e8457fae4 ("rtlwifi: rtl8192cu: Add routine mac")
Cc: stable@vger.kernel.org # v2.6+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index a76f2dc8a977..e2145f284ec0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -641,6 +641,9 @@ static void _rtl92c_query_rxphystatus(struct ieee80211_hw *hw,
 			}
 		}
 		pwdb_all = rtl_query_rxpwrpercentage(rx_pwr_all);
+		if (pwdb_all > 100)
+			pwdb_all = 100;
+
 		pstats->rx_pwdb_all = pwdb_all;
 		pstats->recvsignalpower = rx_pwr_all;
 		if (packet_match_bssid) {
-- 
2.42.0.windows.2


