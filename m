Return-Path: <linux-wireless+bounces-38431-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8I2TOvSnRGoWygoAu9opvQ
	(envelope-from <linux-wireless+bounces-38431-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 07:39:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA86E9E18
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 07:39:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38431-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38431-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1486B300E3B5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321337F75B;
	Wed,  1 Jul 2026 05:38:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D337FF7B;
	Wed,  1 Jul 2026 05:38:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884309; cv=none; b=MWOCzT1T6hBgwePzziTpCrMQ05uES9WPq28Qlprq9t9RFCIcLcAJ1geM6WODQta8Vkj3IM+ENdhjLx1ZmYCA/+XUY++xOaS0R9A/teXvZc9FugZwLsryPT72AuCfvBlkhepv+c3FAj7LHG6tOcCNUfEOaU6i3n0NtuW355QMT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884309; c=relaxed/simple;
	bh=2sPq3wmLq+FV50dMtt62sdvcf86H5SVwNrL1pSyTf+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNAU27JmT/owGh9fxYi4LaoJzyRxilpzDa+OKZDqT/BIUaS4UDlboL9GSyQzT9xX2swGfq8D3KG+GZmAHLsk3HKfZ/Ax6xa42Y09GCV0CLuSrfW2PXV0lRJpPliCWJtDQ2LEmRGjj8uyXGZNE45pbJjQY8Ki7Rk0SjQY2oj1EDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowACXaZDQp0RqJtmHFg--.51781S2;
	Wed, 01 Jul 2026 13:38:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath9k: validate RX stream lengths before copying
Date: Wed,  1 Jul 2026 13:38:23 +0800
Message-ID: <20260701053823.49801-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXaZDQp0RqJtmHFg--.51781S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF48Zw1DZw1fXr4kCrWUXFb_yoW5Gr48pF
	WSq3WayrW3XFnrJw45J34xXF1rGa4Ig3yagFyxCw1xur1DAr98KFyxKFyUtrZ8CFWxAF48
	Zr4DZw43CFy5W3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYwIDUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-38431-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:pengpeng@iscas.ac.cn,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48FA86E9E18

ath9k_hif_usb_rx_stream() reads RX stream headers and copies payload
bytes from the current skb into newly allocated skbs. It also completes
packets that span two URBs by copying the remaining bytes from the next
skb into hif_dev->remain_skb.

The parser checked the stream tag and an upper bound on pkt_len, but it
did not first prove that the fixed header, the non-fragmented payload,
or the bytes needed to complete a fragmented packet are present in the
current skb. Reject malformed RX stream data before reading or copying
beyond the received buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 821909b8..f47b0ae0 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -571,6 +571,16 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 			ptr = (u8 *) remain_skb->data;
 
 			index = rx_remain_len;
+			if (rx_remain_len < hif_dev->rx_pad_len ||
+			    len < rx_remain_len - hif_dev->rx_pad_len) {
+				dev_kfree_skb_any(remain_skb);
+				hif_dev->remain_skb = NULL;
+				hif_dev->rx_remain_len = 0;
+				RX_STAT_INC(hif_dev, skb_dropped);
+				spin_unlock(&hif_dev->rx_lock);
+				return;
+			}
+
 			rx_remain_len -= hif_dev->rx_pad_len;
 			ptr += rx_pkt_len;
 
@@ -597,6 +607,11 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 
 		ptr = (u8 *) skb->data;
 
+		if (len - index < 4) {
+			RX_STAT_INC(hif_dev, skb_dropped);
+			goto invalid_pkt;
+		}
+
 		pkt_len = get_unaligned_le16(ptr + index);
 		pkt_tag = get_unaligned_le16(ptr + index + 2);
 
@@ -625,6 +640,11 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 		index = index + 4 + pkt_len + pad_len;
 
 		if (index > MAX_RX_BUF_SIZE) {
+			if (len < MAX_RX_BUF_SIZE) {
+				RX_STAT_INC(hif_dev, skb_dropped);
+				goto invalid_pkt;
+			}
+
 			spin_lock(&hif_dev->rx_lock);
 			nskb = __dev_alloc_skb(pkt_len + 32, GFP_ATOMIC);
 			if (!nskb) {
@@ -649,6 +669,11 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 			hif_dev->remain_skb = nskb;
 			spin_unlock(&hif_dev->rx_lock);
 		} else {
+			if (pkt_len > len - chk_idx - 4) {
+				RX_STAT_INC(hif_dev, skb_dropped);
+				goto invalid_pkt;
+			}
+
 			if (pool_index == MAX_PKT_NUM_IN_TRANSFER) {
 				dev_err(&hif_dev->udev->dev,
 					"ath9k_htc: over RX MAX_PKT_NUM\n");


