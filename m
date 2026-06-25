Return-Path: <linux-wireless+bounces-38081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXmNG/bHPGrbrwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4D6C2F50
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=qklmls2D;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38081-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38081-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D82430089B0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754AA2E7367;
	Thu, 25 Jun 2026 06:17:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BB27707
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 06:17:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368243; cv=none; b=hY33uGcdtkKLszt0g80aW6wdSEhzvrzVKMfsCUANHolfno54L623LywHzs3VwRv0z+2KW8Dsh/lRwVAVhCA3I1Tr91nrXXvOm9M6K6PH72wD8VWV2tB92BULifs+j7hwfe1hf1p7C0Y8Jz508kSgm2NjFi4J7ZgOHhRCAPqCwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368243; c=relaxed/simple;
	bh=D/B8T4pxyWcQrHvr+l1ppAexUUlyMRF+OGlPFW0o8To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xzh2LcmUQ2gdFlQ6smaOe5cAHo0O4iRim/7io7l/a/H8dEh+yUEvj2JtNQrtrEaWAaqdGYKEhbZ+TeH/rNoZ0nN34Wx97ee0335FDATv0HFc1oeFFxoZ64UdShPivLEb73hgmNAqLzE62DU25tM6KKX1nj2WAuDRMDcb0qnibAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qklmls2D; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65P6HKpcC584486, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782368240; bh=xGoZrkDeGc/qKnsBTj9tKPDuABkJaIjJo3bmKSqxoTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qklmls2D1htWZU8XHb672cX0a3GwpQe1FNnkJ4N/Z2rD1xHl1nWMX6f3ISVlc4XKQ
	 Yt+2MJucGDk0n+GWdry3DGXW9OQ85ocSe0oOhyMbH0HthqkOh/9JuNt+2MpPBmn/04
	 Pv50fL2Tiii8vq35y5sEweYv8BbfSlBBHCplP0DhOMFLqmP9GnxQKqHm4MNRY+8x3V
	 oKRr4Emt5BQNUPG9Oa1wGINYXrjrSS6DrLgsXPxaQGlA6hLQJLba92zNEswA71N6n/
	 6ATvbW8AenOH+AeuGs1PCxfYQqWghaqgmCRJm50Xh8roYP+1X4ALRNpm0QI4+lTTFs
	 vX/HYKJ+WzLPw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65P6HKpcC584486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:17:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:17:19 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Jun 2026 14:17:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/10] wifi: rtw89: wow: use MLD address in WoWLAN ARP replies for MLO stations
Date: Thu, 25 Jun 2026 14:15:43 +0800
Message-ID: <20260625061545.44808-9-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38081-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20D4D6C2F50

From: Chin-Yen Lee <timlee@realtek.com>

Currently, WoWLAN ARP replies for MLO stations use the link address in
the ARP hardware address fields.

As a result, peers may learn the link address from the ARP reply and
use it as the destination address for subsequent traffic. Some APs may
not forward frames addressed to the link address, causing connectivity
issues.

Use the MLD address instead when generating WoWLAN ARP replies so peers
learn the correct address for MLO stations.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4f5995f2cb13..5d335105b589 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2967,9 +2967,9 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 	arp_hdr->ar_pln = 4;
 	arp_hdr->ar_op = htons(ARPOP_REPLY);
 
-	ether_addr_copy(arp_skb->sender_hw, rtwvif_link->mac_addr);
+	ether_addr_copy(arp_skb->sender_hw, rtwvif->mac_addr);
 	arp_skb->sender_ip = rtwvif->ip_addr;
-	ether_addr_copy(arp_skb->target_hw, rtwvif_link->mac_addr);
+	ether_addr_copy(arp_skb->target_hw, rtwvif->mac_addr);
 	arp_skb->target_ip = rtwvif->ip_addr;
 
 	return skb;
-- 
2.25.1


