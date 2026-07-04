Return-Path: <linux-wireless+bounces-38611-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ij1BHzteSGoepgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38611-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 03:13:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F5706589
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 03:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38611-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38611-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9AFB301AB65
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 01:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACBB176238;
	Sat,  4 Jul 2026 01:13:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C813E41A;
	Sat,  4 Jul 2026 01:13:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783127606; cv=none; b=H5ZUlSaNUTXiWATo+GsVK9sJa785h9ioWNnhfbOAnFPTutzzUgzadbwEPQiXMNpWlsf/ROlk9sLcHDrtxBDnZNfJBWGuQWsTmXd8p7Q2A4iPgecHhUyQcLKDvUBzdVJYEyGBlt+ANdwk6yaJF128E5P7+d692P+TvHFyvVkH5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783127606; c=relaxed/simple;
	bh=bv7okLfdzIEt3nHOP1lrt7QE/p52+LgFMVli6hCQ8K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stb7T5qDGAXhIjdJUe6ynF7xklr9X1loJpoqK/uMtb6jf8+OL/F0TVcOfX+qM6cO/YepIk/FK+Nwl7dRhlHu+Kpp8b3eS0Woltu8PAR6f8TGdUXJjFN0/9mOQXHMxkgIHGDxc+tdQ3t7L6Pxclzb3kT3HVWBAulR1tA3AuYNPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABXrdAuXkhqUrHEFg--.38796S2;
	Sat, 04 Jul 2026 09:13:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] wifi: mwifiex: copy only event bodies after headers
Date: Sat,  4 Jul 2026 09:13:17 +0800
Message-ID: <20260704011317.50900-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXrdAuXkhqUrHEFg--.38796S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rAF45KFyxuw4ruw4fGrg_yoW8uw4Dpa
	nxGr9Ygr4Utw1Dt3yfXF18Aw1DKa1FvF97GF1UZw1fuF43G3WSqa48KFWIgr90qwsYv34U
	tw1jq3y5Xr1UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6v3
	8UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38611-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B8F5706589

mwifiex event packets carry a four-byte event cause followed by the
event body.  The USB and SDIO receive paths read the event cause and
then copy adapter->event_body from skb->data + MWIFIEX_EVENT_HEADER_LEN,
but pass the full skb->len as the copy length.  That makes the source
range extend past the skb by the size of the event header.

Require the event header before reading the event cause, and copy only
the bytes after the header into adapter->event_body.  Keep the existing
per-path total event-size checks so this stays a narrow bounds fix.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 10 ++++++++--
 drivers/net/wireless/marvell/mwifiex/usb.c  |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1712,12 +1712,18 @@
 	case MWIFIEX_TYPE_EVENT:
 		mwifiex_dbg(adapter, EVENT,
 			    "info: --- Rx: Event ---\n");
+		if (skb->len < MWIFIEX_EVENT_HEADER_LEN) {
+			mwifiex_dbg(adapter, ERROR,
+				    "event packet too short: %u\n", skb->len);
+			dev_kfree_skb_any(skb);
+			return -1;
+		}
 		adapter->event_cause = get_unaligned_le32(skb->data);
 
-		if ((skb->len > 0) && (skb->len  < MAX_EVENT_SIZE))
+		if (skb->len < MAX_EVENT_SIZE)
 			memcpy(adapter->event_body,
 			       skb->data + MWIFIEX_EVENT_HEADER_LEN,
-			       skb->len);
+			       skb->len - MWIFIEX_EVENT_HEADER_LEN);
 
 		/* event cause has been saved to adapter->event_cause */
 		adapter->event_received = true;
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -91,7 +91,7 @@
 			adapter->cmd_resp_received = true;
 			break;
 		case MWIFIEX_USB_TYPE_EVENT:
-			if (skb->len < sizeof(u32)) {
+			if (skb->len < MWIFIEX_EVENT_HEADER_LEN) {
 				mwifiex_dbg(adapter, ERROR,
 					    "EVENT: skb->len too small\n");
 				ret = -1;
@@ -110,7 +110,8 @@
 			}
 
 			memcpy(adapter->event_body, skb->data +
-			       MWIFIEX_EVENT_HEADER_LEN, skb->len);
+			       MWIFIEX_EVENT_HEADER_LEN,
+			       skb->len - MWIFIEX_EVENT_HEADER_LEN);
 
 			adapter->event_received = true;
 			adapter->event_skb = skb;


