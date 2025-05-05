Return-Path: <linux-wireless+bounces-22433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7DFAA8CF5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693F77A7DC3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4771D8DFB;
	Mon,  5 May 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="lnRNcWcd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A41CDFAC
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429907; cv=none; b=PwYMg4UO6Sh9FqSRSAeJnk1jdf2lMsjnBp2hoer1RYr3FEIeQAMcr2P3/yR+9jbwUC6egI3wCPg+3oFG/9TWsr3+T1iBpg+C0Eox7wLkFmgYj7deOT1MqPUtN8LTZW2V2vKzgGg/B9xOqohjRozAin/PyRYDsBySapXdwOaSwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429907; c=relaxed/simple;
	bh=ReikMNucw7Jwc/6z6Eo9NqtVTHWkMB/isjbFA9QPMyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWm+0vhv7PhfbfS7+W4s8jaBbET5J0W69/7QL4F7umk+ZwFDn8v4EFJa/J1mKu8K9/sweiAKt4L8SXcnWLCFx8/qkn8D9cFS5gp+A/N5Y8rWyd65aUhMSqUwAfzmryVQpm86nDgqYvbTnMAbljaaF9pHOMOpzlW/zhVUCWG+1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=lnRNcWcd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457P3aP43831156, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429903; bh=ReikMNucw7Jwc/6z6Eo9NqtVTHWkMB/isjbFA9QPMyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=lnRNcWcdJXbrfYz+NAyZwFVWkefgrOjLsPeEQkjZ84Of8KN7XzVF85mTH3gRArWAv
	 UfTLcR4VNjIpXX5JJ2rDBfuIKTETjmbmvJhU/oPWcczkR2S7wShMiue9Ru1kuGCLNC
	 Gqw57fangLIicTTLjR/wRj2ZvDL2uQbiQXN+8Kq2Pe+AieRYgq/JEOpSCiYSFDC5Tf
	 lw/S+sUHLmnUw3iG/k0dyiWftQgfEMMXaJgP2VlPwtMtuL2RMNwTBzBVQNOb3G/UvO
	 YbK/kT+md+i8BjVcUT+CnP/c+lttoXxsCwJ+5mR79vAayIsZ1/GEa9QphukSmSlC9C
	 9UUph4cZ4kGlQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457P3aP43831156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: send nullfunc based on the given link
Date: Mon, 5 May 2025 15:24:32 +0800
Message-ID: <20250505072440.45113-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

The nullfunc sender function is link specific. Use core_tx_write_link
with sw_mld flag to TX the nullfunc via the given link.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c8b00f790829..c5bb3452946e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3335,8 +3335,10 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
+	struct rtw89_sta_link *rtwsta_link;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
+	struct rtw89_sta *rtwsta;
 	struct sk_buff *skb;
 	int ret, qsel;
 
@@ -3349,6 +3351,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 		ret = -EINVAL;
 		goto out;
 	}
+	rtwsta = sta_to_rtwsta(sta);
 
 	skb = ieee80211_nullfunc_get(rtwdev->hw, vif, link_id, qos);
 	if (!skb) {
@@ -3360,7 +3363,13 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 	if (ps)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
 
-	ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
+	rtwsta_link = rtwsta->links[rtwvif_link->link_id];
+	if (unlikely(!rtwsta_link)) {
+		ret = -ENOLINK;
+		goto out;
+	}
+
+	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
 		dev_kfree_skb_any(skb);
-- 
2.25.1


