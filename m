Return-Path: <linux-wireless+bounces-34728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMqcKFHd3WlwkQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:23:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC93F5E8E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4553014403
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A64334B69C;
	Tue, 14 Apr 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OzPomg8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B04346FAE
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147775; cv=none; b=OabiT0ueGMOlnITBSgaEY+iRqD4tcYsrYWBMnw/cK3RVbQryeqK+S5++Y/k5g2nYJjK70qe61XiFd4yF4qeZ7auXj3nU1wccr2e1bZE5CLAqfs5mo7Pbf9BPbZykuSSqnGNLSpM8HshQNuLdBprY/yVtAtVKeRoVwioqD0giSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147775; c=relaxed/simple;
	bh=LH0oHjaZrv9YabWkphtgoiOyo5RhUAFj04LC9wGAKc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxQryAuJi8EPWnNQNylHTVDMM/90KreWJYq/Nr/NOtaZRxJTviKXpaYXyqRVhW1h6hWhoybOrPS1+YUpFOH0pEOJF+yo6JMf1YCzq7JxJ/waOnz42ujHPY/wl6GZFF0KIzV4R/wVViFuxj+NKa5A5TxGqEY3g7rE8By17CkNr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OzPomg8K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E6MmvW61508638, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776147768; bh=q7ldYmlqksWM56t7i71EwTvTIAxC3rODu3L7xPPrk4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OzPomg8KneYggWK7yBRBlU3Q4fZMxK+vnNejoDikI1Q2Le4jCAtKE3pGS3p8KPxXP
	 AFKy518vTS0ZmubLKtJ3O6OJ850oTasQv/JtTTqufl+e6Ffssm4r5g5sWOifnqEQXU
	 2cCP1keSJjBsJGyNT4QAgVVtyBnAuv34W2KtLm12a3+VZr6Vyd5A8oHzmZOeTr9sOs
	 4DDbvCCZtFdFAtVGGSzatObPLSQCvNDvzVd0a5GYVclCrf7P4qIQ/H8pxABnUAINvw
	 J6rSZA4zSHy95uQnAqqGqJ7e98GbnWxNzwZp7rmSpLU5XErFtW3eDrPdJX/wCVElho
	 0n/vkEM0ISfvg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E6MmvW61508638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:22:48 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 14:22:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 14 Apr 2026 14:22:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <Jes.Sorensen@gmail.com>
Subject: [PATCH rtw-next 1/3] wifi: rtl8xxxu: validate action frame size before using in rtl8xxxu_dump_action()
Date: Tue, 14 Apr 2026 14:22:27 +0800
Message-ID: <20260414062229.21047-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260414062229.21047-1-pkshih@realtek.com>
References: <20260414062229.21047-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34728-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FDC93F5E8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The rtl8xxxu_dump_action() is to print action frames when turning on
debug mask. Validate the skb->len size to prevent potential broken in
monitor mode injection.

Compile tested only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index f20fade0c099..508137e4a87a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5126,7 +5126,7 @@ static void rtl8xxxu_tx_complete(struct urb *urb)
 }
 
 static void rtl8xxxu_dump_action(struct device *dev,
-				 struct ieee80211_hdr *hdr)
+				 struct ieee80211_hdr *hdr, unsigned int skb_len)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)hdr;
 	u16 cap, timeout;
@@ -5134,8 +5134,14 @@ static void rtl8xxxu_dump_action(struct device *dev,
 	if (!(rtl8xxxu_debug & RTL8XXXU_DEBUG_ACTION))
 		return;
 
+	if (skb_len < IEEE80211_MIN_ACTION_SIZE(action_code))
+		return;
+
 	switch (mgmt->u.action.action_code) {
 	case WLAN_ACTION_ADDBA_RESP:
+		if (skb_len < IEEE80211_MIN_ACTION_SIZE(addba_resp))
+			break;
+
 		cap = le16_to_cpu(mgmt->u.action.addba_resp.capab);
 		timeout = le16_to_cpu(mgmt->u.action.addba_resp.timeout);
 		dev_info(dev, "WLAN_ACTION_ADDBA_RESP: "
@@ -5148,6 +5154,9 @@ static void rtl8xxxu_dump_action(struct device *dev,
 			 le16_to_cpu(mgmt->u.action.addba_resp.status));
 		break;
 	case WLAN_ACTION_ADDBA_REQ:
+		if (skb_len < IEEE80211_MIN_ACTION_SIZE(addba_req))
+			break;
+
 		cap = le16_to_cpu(mgmt->u.action.addba_req.capab);
 		timeout = le16_to_cpu(mgmt->u.action.addba_req.timeout);
 		dev_info(dev, "WLAN_ACTION_ADDBA_REQ: "
@@ -5437,7 +5446,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	}
 
 	if (ieee80211_is_action(hdr->frame_control))
-		rtl8xxxu_dump_action(dev, hdr);
+		rtl8xxxu_dump_action(dev, hdr, skb->len);
 
 	tx_info->rate_driver_data[0] = hw;
 
-- 
2.25.1


