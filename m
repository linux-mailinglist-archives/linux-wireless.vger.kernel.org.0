Return-Path: <linux-wireless+bounces-38632-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DEmaGGkaSmp2+QAAu9opvQ
	(envelope-from <linux-wireless+bounces-38632-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 10:48:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C3709862
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 10:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38632-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38632-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55EC63003348
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604E383C89;
	Sun,  5 Jul 2026 08:48:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBC280035;
	Sun,  5 Jul 2026 08:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241317; cv=none; b=IkU3g0vAnTi8e3mVKd/NxJFKkC9RSOMBsygIDp8Ia3r2VBF4uhqFCigDHywmKgVb75oU5Dv1nrsZLdQa7GVTnIvZVeJaDSVKIatd96PlbGX4X3Z7S+YLstf//OYM98LS4W6NP1OfnLUGRGTi/W9P8BXaAoMUBEdUv7VSCxOu7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241317; c=relaxed/simple;
	bh=++yvwX86IvFQQRYZYwBLB7d1Rt3wwQs2ASLT2NR/8as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMUnoV5ApygdDbwW2Lc+/Y0qgnc7Vhx2AAc44sob7ejLEgc6DS8OkJwP77FQRFUFEHOT5vjhdyCen/tlQWx/1bMFp+vMQAOJPN4XyI83Uo5V0EFpELAY7pj9OyK7ZPhKDh8f6ZtxIMpB8Jc+IWzteiBlxkguilQ4x7MFWd3tt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3fABaGkpqAMX8Fg--.56098S2;
	Sun, 05 Jul 2026 16:48:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] wifi: rsi: validate beacon length before fixed buffer copy
Date: Sun,  5 Jul 2026 16:48:24 +0800
Message-ID: <20260705084824.68105-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3fABaGkpqAMX8Fg--.56098S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKr48AryUGr18XF1fZw1xGrg_yoW8JF1Upr
	WUGw47KrZ8JF43Kw4Fga1fuF1rtas3G3s7CrW3t3y8urWSy34rZr1Dua4UXrn8AFZ5CFW3
	Zr4ktFy5Kr1aq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUa9akUUUUU=
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
	TAGGED_FROM(0.00)[bounces-38632-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E23C3709862

rsi_prepare_beacon() copies the mac80211 beacon frame after
FRAME_DESC_SZ into a management skb whose usable tailroom may be smaller
than MAX_MGMT_PKT_SIZE after alignment.

Validate the beacon length against the actual tailroom before the copy
and skb_put(). Leave ownership of the management skb with the caller on
error, matching the existing rsi_send_beacon() cleanup path.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -431,6 +431,7 @@
 	struct ieee80211_vif *vif;
 	struct sk_buff *mac_bcn;
 	u8 vap_id = 0, i;
+	unsigned int tailroom;
 	u16 tim_offset = 0;
 
 	for (i = 0; i < RSI_MAX_VIFS; i++) {
@@ -479,6 +480,13 @@
 
 	if (mac_bcn->data[tim_offset + 2] == 0)
 		bcn_frm->frame_info |= cpu_to_le16(RSI_DATA_DESC_DTIM_BEACON);
+
+	tailroom = skb_tailroom(skb);
+	if (tailroom < FRAME_DESC_SZ ||
+	    mac_bcn->len > tailroom - FRAME_DESC_SZ) {
+		dev_kfree_skb(mac_bcn);
+		return -EMSGSIZE;
+	}
 
 	memcpy(&skb->data[FRAME_DESC_SZ], mac_bcn->data, mac_bcn->len);
 	skb_put(skb, mac_bcn->len + FRAME_DESC_SZ);


