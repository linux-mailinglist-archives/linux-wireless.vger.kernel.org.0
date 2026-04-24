Return-Path: <linux-wireless+bounces-35261-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMMkLUEb62lTIgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35261-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 09:26:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F045AB36
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26FC1300FEE5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E732AAC6;
	Fri, 24 Apr 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ot5XaMBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7B31E84E
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015590; cv=none; b=oZL1HOUP/4RL11Sgw9Y2DpesQ12luU4DXnoBvgBReGm8Qh1rb7lFUFN8Qsk2XWngzzmidxIG7qCBVUjjxdemRfzKvfVCwDEx/IbfNeGGK31zUEwz3tdma5oeDqyETe3YjzsOyWPi17Kk6T2uMt7B3K4Xq0p34aPscVkJ5g8Zqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015590; c=relaxed/simple;
	bh=N4NAKeEhgT2hnRoP349IiJI2FEW0+KJ/W7053GPtJl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/X3ivLIJ8Q4nIjwii+kTrY0c1SsSACtRQFdztras1/41JB+e/zyopNw4D810/RXljLO2wCMeArIeoufd/13xN9Y7/TkIDXkLRABBXlAm6bHOZn3WRQYnNRuFYipfaERYQ4TxdeGOKY/iuz/yBcVIb0gqvsaUDdMA+zWlM5wLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ot5XaMBP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63O7QPfyC417397, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777015585; bh=JQocv4mxZyyDV4zs3GVqlxt9kZPeY5Zmpaw4wkLGDj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ot5XaMBPJMu2CXqmgtmK3qKwm8esxUQ6XBShVEGHt8dMXXhuPsOsfWA+VnqGryiuT
	 620eGEZOsvgZx6D5ILtiZCetnapCRD3vMwdLnL0HbA1006WUEfOvuvQj0lWkU1EjaA
	 mNchWf3Pu9VqZaVpuP8G0aj0BvHhxbYgGEOvi7m3UPkYzM8fMA5QKjopEEmdp8Hcr5
	 ugN6RuamDr3OcHup+Kv1f5hetscuQNeYSV95I+zXRJdk4cdhEVR6XtAkq2sXbvm19k
	 R60zVa+HCSS50zkeMGIufbGGebuatU6ey9NDFZSxnJH1RhbmBDSoAGX5woXDPyk2ta
	 0STbjuIhEwX5w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63O7QPfyC417397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 15:26:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 24 Apr 2026 15:26:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 24 Apr 2026 15:26:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 24 Apr 2026 15:26:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <dian_syuan0116@realtek.com>
Subject: [PATCH rtw-next 2/3] wifi: rtw89: disable HTC field in AP mode
Date: Fri, 24 Apr 2026 15:25:51 +0800
Message-ID: <20260424072552.59220-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260424072552.59220-1-pkshih@realtek.com>
References: <20260424072552.59220-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 1F2F045AB36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35261-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

Disable HE QoS HTC field when operating in AP mode to resolve
interoperability issues with some stations.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 70feab97dccb..ca3f8e356434 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -931,6 +931,7 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 				 enum btc_pkt_type pkt_type)
 {
 	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
+	struct ieee80211_vif *vif = tx_req->vif;
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_link_sta *link_sta;
@@ -962,6 +963,9 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 	if (rtwsta_link && rtwsta_link->ra_report.might_fallback_legacy)
 		return false;
 
+	if (vif->type == NL80211_IFTYPE_AP)
+		return false;
+
 	return true;
 }
 
-- 
2.25.1


