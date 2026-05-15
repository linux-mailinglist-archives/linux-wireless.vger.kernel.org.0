Return-Path: <linux-wireless+bounces-36447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIGYOUh7BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B854888F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304F0307829F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192B1DF26E;
	Fri, 15 May 2026 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KIoySa1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7293282F1B
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809527; cv=none; b=vCok0aC46gOYXKnu3NfzGk/2bJp+vRsgxuhldfDo1efyhzfnNHOh0UOUURuGIuOD9fP1GpbbjcgUGMZ0XTzZtPiNuwnngBlpilbGQItR8btbWqKPL0dXEmRPs6sCcQqsRvYQd2CK6WL2jlpM0H2YfU1qZ59Daf34zub+aMnHnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809527; c=relaxed/simple;
	bh=x9Fv1XP4hqZTeb0FSixOdBGuk3KTWN7t2tJHTCozBwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKrBvWR3jAJEvtmElEbi8w1xkBLICx82V/hhD8qgM6nyXPIXDISGOmaSb6uN/SKBL3eQ24QOXwcH9AYV9HrF0ZGa3qPHYf2Ai76UfIFtr5XFPr9ZlzsSerIKKrOjA7465BtVA3Ffp1GJUKOtw6FhNKdtZNxccNFBiYrHDABw9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KIoySa1K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jOQq92587261, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809524; bh=iKKvHSq6CPkK4jAUNXYaywuXfhEAI2tLkd9Z242pS3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KIoySa1K1kqOBq8qcEwdVKm6LIneuBV0uLqhkdmBDSHFcUc9Y1GfTgsHrTzphCEqY
	 NLf9sWtHOHmKny5YH+nkdZ7P5lB20Wkt3LGb2ny4MXt4ATWIChYPy/FdD+xzZsiXY9
	 HjvhxTrV6Z5C7m0MM0njkApwTl3EMbctI7ZR3TDHmLuQojugrItE+eiKKGRgEO7z3U
	 B+VCIaSFlHgbR8/8dTJctitRt/GBCgNuXaZvZpzri7BXQSuXyXFn2wDsq6KLrddfH/
	 pWJCfIrYocCyCeHEEqkAivjrw/1+4NGyNGoecQZAQjI3yWDrCX1/dX9PMbcNr9YelO
	 EFAIp69ccfRVQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jOQq92587261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/13] wifi: rtw89: wow: send ARP reply packets instead of Null packets to keep alive
Date: Fri, 15 May 2026 09:44:28 +0800
Message-ID: <20260515014433.16168-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 7A9B854888F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36447-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

From: Chin-Yen Lee <timlee@realtek.com>

In WoWLAN mode, the firmware periodically sends Null packets to the AP
to keep the connection alive and prevent the AP from disconnecting the
client due to inactivity. However, it was observed that certain APs,
such as  TP-Link Archer BE800, do not recognize Null packets as
valid activity and still drop the connection. Replacing Null packets
with ARP reply packets effectively resolves this compatibility issue
and maintains the connection.

Specifically, while the firmware typically handles standard ARP
offloads by dynamically modifying target IP/MAC fields, these
keep-alive ARP reply packets are pre-filled by the driver with the
DUT's own MAC and IP addresses for both sender and target fields.
In this case, the firmware transmits the packets as-is without
further modification. This approach ensures compatibility with APs
that require valid Layer 3 traffic for activity monitoring while
simplifying the firmware's processing logic during WoWLAN mode.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 29d8d13d11fe..eb5683d64461 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2958,6 +2958,8 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 
 	ether_addr_copy(arp_skb->sender_hw, rtwvif_link->mac_addr);
 	arp_skb->sender_ip = rtwvif->ip_addr;
+	ether_addr_copy(arp_skb->target_hw, rtwvif_link->mac_addr);
+	arp_skb->target_ip = rtwvif->ip_addr;
 
 	return skb;
 }
@@ -9617,7 +9619,7 @@ int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtw
 
 	if (enable) {
 		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif_link,
-						   RTW89_PKT_OFLD_TYPE_NULL_DATA,
+						   RTW89_PKT_OFLD_TYPE_ARP_RSP,
 						   &pkt_id);
 		if (ret)
 			return -EPERM;
-- 
2.25.1


