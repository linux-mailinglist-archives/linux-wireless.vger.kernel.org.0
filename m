Return-Path: <linux-wireless+bounces-38664-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K777D5SBS2pOSgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38664-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 12:21:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC0570F159
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 12:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38664-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38664-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E01B23194FD0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48C42CAE3;
	Mon,  6 Jul 2026 09:27:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237B414A11;
	Mon,  6 Jul 2026 09:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330025; cv=none; b=AqILMDVtMf3uowrQwG5xqfr5WOHz3+7Je8qdYeksJntdUVO3Oqk/96FEu8lRd3ZKfBdD4bU5B2u9aJkTbBmPvrgS/4kUhbOLAUEnGitezCxf+3LQfHVvNPJphOvrpRue8Yc77Z07WC7P1zxjvALA89iW5WAmLteTWqvcTqcxozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330025; c=relaxed/simple;
	bh=1llPvU5vVQ2cYYQnB/l37/ziu5SlMcl6kCPXycMcMMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEvEkgStLer/L5gQkOrC7304IJfDBPBhh016uUBlPjvdl3ltVz8GSuCYbHPRMM7zqdqSDOhtvzEBVM9uS9F/GxdUdaIHZnsYikLw6QAIjlt8x0+mBh5vb6IYCMl+ZTBZxlYlhtT/Z21OjYtBTXABP5h7FKfFk5wR4EubgYkHJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABH5s7fdEtqUFrxBA--.35233S2;
	Mon, 06 Jul 2026 17:26:56 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Brian Norris <briannorris@chromium.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: validate scan TLV result arrays
Date: Mon,  6 Jul 2026 17:26:54 +0800
Message-ID: <20260706092654.79403-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH5s7fdEtqUFrxBA--.35233S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF47GF4Dur1rWF48Ary8AFb_yoW8Jr4kp3
	9xCFWIk34rJrn8Ca1rJF48Aa45K3Z5KFy2krZ2k34rKwnIkryrAwn8W34I9r1YqFs29ryY
	9rWFqF1UuFsrAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-
	B_UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38664-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:pengpeng@iscas.ac.cn,m:francesco@dolcini.it,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABC0570F159

mwifiex_ret_802_11_scan() indexes TSF and channel-band TLV
arrays by the reported number of BSS result sets.

Ignore TSF or channel-band TLVs whose payload length cannot provide one
entry per reported BSS set.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..7416756ada3b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2165,6 +2165,15 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 					     (struct mwifiex_ie_types_data **)
 					     &chan_band_tlv);
 
+	if (tsf_tlv &&
+	    le16_to_cpu(tsf_tlv->header.len) / TSF_DATA_SIZE <
+	    scan_rsp->number_of_sets)
+		tsf_tlv = NULL;
+	if (chan_band_tlv &&
+	    le16_to_cpu(chan_band_tlv->header.len) /
+	    sizeof(*chan_band_tlv->chan_band_param) < scan_rsp->number_of_sets)
+		chan_band_tlv = NULL;
+
 #ifdef CONFIG_PM
 	if (priv->wdev.wiphy->wowlan_config)
 		nd_config = priv->wdev.wiphy->wowlan_config->nd_config;
-- 
2.43.0


