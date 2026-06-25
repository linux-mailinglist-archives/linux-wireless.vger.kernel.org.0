Return-Path: <linux-wireless+bounces-38082-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 18/lLADIPGrerwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38082-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2816C2F5F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=rME+WTl0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38082-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38082-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 908703028C03
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 06:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786027707;
	Thu, 25 Jun 2026 06:17:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D32E7367
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 06:17:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368250; cv=none; b=Dka8j8Z8QLkiw4vj8tBEtdDgfkSxl9bvFNTolS6C2dozUPyGUddGmi2Z4KKgTU6LlFS5DRgUaYrn7WCXnGCbRk5ahlDqjb5JwxdGgvpoTAtojq4SDkdQUie74+g8BzCgClfZcxhhG5cP4ORaJJt/t8TlnMcbfdcQgwEmr4fxeho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368250; c=relaxed/simple;
	bh=AENJB3+EFjMiMwElfxA7lhLZ48yiapoC0VdYVaWULgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZOLtCyzWvRVGlqCV3rhWk3gXqO1JQkD26AkFNzAvKZGw0W+eNZNQ12lkdO3YQCOt7Y4AInRfIZDEE88YfZR9YyKMs56Mp1sdSJpYW1UIamRpeYrOh/l29LWnTPpDGOedzzgF5u+ROv+utphsqHJVieicYUnEbxTm+jaTaXVKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rME+WTl0; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65P6HPupC584505, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782368245; bh=XBhCdOO18GoG0WG1ZxB+9U5haosEik5Nnfy2oe774FA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rME+WTl0G8OfHFJTA8DthU3SsSvP6JT+tRTlWZSqwBtFc2WsIyC+EspQMyPVh08bn
	 w3uTkCyWzG03+KfUuiQ7zhNkmChN4WgNQ3TFAECP4dnHADE+V+HFgAaEGNtooQrgYf
	 qjKDERExcGUL+qbHB94pKiW9GUkqwRg2dSaBAGfCgQkyEAH8OoQ+B1snYTLTb6s+92
	 HyqWeLRDE8wky4Ilb0LutOhTzP8LdCl/HaESVlxSY0fPgPVuO7Oszyr+Cv6+gCPrA2
	 tRnY1yesV8tle4w7UW4dPFyZL42JtpL4CALoMETj50Evo03JihNHsYiOOXEs2uAKou
	 Qvroayq1dv+kQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65P6HPupC584505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:17:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:17:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Jun 2026 14:17:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/10] wifi: rtw89: wow: add QoS control field to WoWLAN ARP response for MLO
Date: Thu, 25 Jun 2026 14:15:44 +0800
Message-ID: <20260625061545.44808-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625061545.44808-1-pkshih@realtek.com>
References: <20260625061545.44808-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38082-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:timlee@realtek.com,m:dian_syuan0116@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C2816C2F5F

From: Chin-Yen Lee <timlee@realtek.com>

Some MLO APs expect WoWLAN ARP response frames to be transmitted as
QoS data frames and may discard frames that do not contain a QoS
Control field.

Add a QoS Control field and use the QoS Data subtype when generating
WoWLAN ARP responses for MLD vifs. Keep the existing frame format
unchanged for non-MLO connections.

This allows WoWLAN ARP responses to be accepted by MLO APs while
preserving compatibility with legacy APs.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 31 +++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5d335105b589..f40c2f1c4dd7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2928,6 +2928,7 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 					      struct rtw89_vif_link *rtwvif_link)
 {
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link->rtwvif);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -2935,26 +2936,42 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 	struct rtw89_arp_rsp *arp_skb;
 	struct arphdr *arp_hdr;
 	struct sk_buff *skb;
-	__le16 fc;
+	bool with_qos;
+	u16 fc;
 
-	skb = dev_alloc_skb(sizeof(*hdr) + sec_hdr_len + sizeof(*arp_skb));
+	with_qos = ieee80211_vif_is_mld(vif);
+
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[arp_reply] with qos field: %s\n",
+		    str_yes_no(with_qos));
+
+	skb = dev_alloc_skb(sizeof(*hdr) + sec_hdr_len + sizeof(*arp_skb) +
+			    (with_qos ? 2 : 0));
 	if (!skb)
 		return NULL;
 
 	hdr = skb_put_zero(skb, sizeof(*hdr));
 
+	fc = IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS;
+
 	if (rtw_wow->ptk_alg)
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS |
-				 IEEE80211_FCTL_PROTECTED);
+		fc |= IEEE80211_FCTL_PROTECTED;
+
+	if (with_qos)
+		fc |= IEEE80211_STYPE_QOS_DATA;
 	else
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS);
+		fc |= IEEE80211_STYPE_DATA;
+
+	hdr->frame_control = cpu_to_le16(fc);
 
-	hdr->frame_control = fc;
 	ether_addr_copy(hdr->addr1, rtwvif_link->bssid);
 	ether_addr_copy(hdr->addr2, rtwvif_link->mac_addr);
 	ether_addr_copy(hdr->addr3, rtwvif_link->bssid);
 
-	skb_put_zero(skb, sec_hdr_len);
+	if (with_qos)
+		skb_put_zero(skb, sizeof(__le16));
+
+	if (sec_hdr_len)
+		skb_put_zero(skb, sec_hdr_len);
 
 	arp_skb = skb_put_zero(skb, sizeof(*arp_skb));
 	memcpy(arp_skb->llc_hdr, rfc1042_header, sizeof(rfc1042_header));
-- 
2.25.1


