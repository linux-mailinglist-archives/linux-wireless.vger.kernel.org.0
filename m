Return-Path: <linux-wireless+bounces-38663-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hfJrO4iRS2quVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38663-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:29:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26470FD83
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38663-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38663-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FEAA34F94B5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826442F717;
	Mon,  6 Jul 2026 09:14:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5ED42F70A;
	Mon,  6 Jul 2026 09:13:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329247; cv=none; b=lSrSiCjcCiBlcWK0b/3RdIxmoVYDnBBddIcCCoB5CSQ6jURijbw6bK7dxt91N1WlqD/heupsw7FUYBpfWA+GJa6/ujsijudUA4wqB1zTzhxgSGmcbsG9/mF/2szUR/HyRTvLLBLgi9SizWjl8AGKtALOs3Ydw2pLYp7+gOfK/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329247; c=relaxed/simple;
	bh=8U38Wo1yDeq1AEa9Z6+EHawdJW4ftiDefYJz4JS0AZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bb+qZZSkmQHiigCsQ3k1cRi/iLWrJO3Wt19LwLdWSqoghGrAccbPEEPfZ3QAJsfagOSHg94UzzgCJUs3vg2Fld4ZpcE7k95Zjo1YeCfhbnm6ER/Z4fu3nz44P6cCRDI842Sw6GHI0DaIP6T1RLB/WAfI1cmHjVeChRgM7PF+Njc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABH5s7McUtq4f3wBA--.35093S2;
	Mon, 06 Jul 2026 17:13:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Brian Norris <briannorris@chromium.org>
Cc: Pengpeng <pengpeng@iscas.ac.cn>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: validate rate scope TLV length
Date: Mon,  6 Jul 2026 17:13:46 +0800
Message-ID: <20260706091346.76985-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH5s7McUtq4f3wBA--.35093S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DKrWfJF17KryUXF1UZFb_yoW8AF1kp3
	ySgws29rs5JrnrCw45AF18Aay5K3WIgFy2kr4q9a4rGanYkw1UXFy7KFyjgr4UtrsrKFWS
	yw1jqr1xX3ZIyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6v38UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:pengpeng@iscas.ac.cn,m:francesco@dolcini.it,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38663-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A26470FD83

From: Pengpeng <pengpeng@iscas.ac.cn>

mwifiex_ret_tx_rate_cfg() verifies that a TLV stays within the command
response, then parses RATE_SCOPE as struct mwifiex_rate_scope. The
type-specific parser also needs to prove that the declared TLV payload
covers the bitmap fields that it reads.

Check the RATE_SCOPE payload length before copying the legacy bitmaps,
and require the VHT bitmap area only for firmware API version 15 where
it is consumed.

Signed-off-by: Pengpeng <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 85512f526c5f..5b7399038d5d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -260,6 +260,7 @@ static int mwifiex_ret_tx_rate_cfg(struct mwifiex_private *priv,
 	struct mwifiex_rate_scope *rate_scope;
 	struct mwifiex_ie_types_header *head;
 	u16 tlv, tlv_buf_len, tlv_buf_left;
+	size_t rate_scope_len;
 	u8 *tlv_buf;
 	u32 i;
 
@@ -276,6 +277,14 @@ static int mwifiex_ret_tx_rate_cfg(struct mwifiex_private *priv,
 
 		switch (tlv) {
 		case TLV_TYPE_RATE_SCOPE:
+			rate_scope_len = offsetof(struct mwifiex_rate_scope,
+						  vht_mcs_rate_bitmap) - sizeof(*head);
+			if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15)
+				rate_scope_len = sizeof(*rate_scope) - sizeof(*head);
+
+			if (tlv_buf_len < rate_scope_len)
+				break;
+
 			rate_scope = (struct mwifiex_rate_scope *) tlv_buf;
 			priv->bitmap_rates[0] =
 				le16_to_cpu(rate_scope->hr_dsss_rate_bitmap);
-- 
2.43.0


