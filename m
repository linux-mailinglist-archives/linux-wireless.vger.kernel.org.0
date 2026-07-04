Return-Path: <linux-wireless+bounces-38612-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RJlYAmVeSGohpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38612-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 03:14:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6BE706590
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 03:14:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38612-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38612-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCA7A30281B9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A918CBE1;
	Sat,  4 Jul 2026 01:14:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688B13E41A;
	Sat,  4 Jul 2026 01:14:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783127650; cv=none; b=TpqVR03CROgnxQzSzbKYJuTHKpkkQGS7D8pU3JeguwEWru3rrzO6LpSmnCJpeVxK507tdZijsAluoXS7msoKXcjkCIyslHMFu3tkI2IJukX+uu/LgnyW60AwnHr4cjxqqH0GGfgt5q1buJWBNe/vl5hxmpYFDBhkpbJbxqqKNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783127650; c=relaxed/simple;
	bh=y70suMnSrLowLnpx1oDu5t8tpqtkgitUDfjbcMHcXZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpktYNRY/o1HjKgGDZj7to7azixNygAVRiiEcoz3Ty8v0fs/57VjVIfLFMwEjtPUWCNpggG5QMXFdeb4YYHAahmsUi8KTFRKYkfxRUdFHD3Ds6vVmYHBMvYRQ/5w0WHl84WmvrL/da2BbWZC42zX7FJyknMMRV4WJ19h8PhodLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADHNeleXkhqCrbEFg--.53225S2;
	Sat, 04 Jul 2026 09:14:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] wifi: ath9k: validate WMI response length before copying
Date: Sat,  4 Jul 2026 09:14:05 +0800
Message-ID: <20260704011405.55089-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHNeleXkhqCrbEFg--.53225S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47tw43Cry3Gw4DJF4kCrg_yoW8uF1xpa
	yYvrWavr1qvrn7JrsxZr48XF95Jan3Xa9xGay3Xw1rAr95Cr1FgFyFgFyjq3yDXF4aqrWx
	ZF4jg3WrCwnYk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkKsUUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-38612-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F6BE706590

ath9k_wmi_rsp_callback() removes the WMI command header from the skb
and then copies wmi->cmd_rsp_len bytes into the waiting response
buffer.  The response length is expected by the waiting command path,
while the skb length comes from the device response.  A short response
can therefore be read past the end of the skb data.

Record malformed short responses in the WMI state and return the error
to the waiting command path after completion.  This avoids both the
out-of-bounds read and the false-success case where callers would
consume stale response data.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 16 ++++++++++++++--
 drivers/net/wireless/ath/ath9k/wmi.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -206,8 +206,16 @@
 {
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
-	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
+	if (wmi->cmd_rsp_buf && wmi->cmd_rsp_len) {
+		if (skb->len < wmi->cmd_rsp_len) {
+			wmi->cmd_rsp_status = -EMSGSIZE;
+			goto complete;
+		}
 		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
+	}
+	wmi->cmd_rsp_status = 0;
+
+complete:
 
 	complete(&wmi->cmd_wait);
 }
@@ -300,6 +305,7 @@
 	/* record the rsp buffer and length */
 	wmi->cmd_rsp_buf = rsp_buf;
 	wmi->cmd_rsp_len = rsp_len;
+	wmi->cmd_rsp_status = 0;
 
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
@@ -356,9 +362,13 @@
 		return -ETIMEDOUT;
 	}
 
+	spin_lock_irqsave(&wmi->wmi_lock, flags);
+	ret = wmi->cmd_rsp_status;
+	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
+
 	mutex_unlock(&wmi->op_mutex);
 
-	return 0;
+	return ret;
 
 out:
 	ath_dbg(common, WMI, "WMI failure for: %s\n", wmi_cmd_to_name(cmd_id));
--- a/drivers/net/wireless/ath/ath9k/wmi.h
+++ b/drivers/net/wireless/ath/ath9k/wmi.h
@@ -157,6 +157,7 @@
 	u16 tx_seq_id;
 	u8 *cmd_rsp_buf;
 	u32 cmd_rsp_len;
+	int cmd_rsp_status;
 	bool stopped;
 
 	struct list_head pending_tx_events;


