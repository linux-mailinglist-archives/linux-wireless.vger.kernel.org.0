Return-Path: <linux-wireless+bounces-38329-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lFbiIfVvQ2qsYQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38329-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:27:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0FE6E122F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:27:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38329-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38329-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F2B4303BB33
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2BA37DEA2;
	Tue, 30 Jun 2026 07:22:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900332B9A9;
	Tue, 30 Jun 2026 07:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804167; cv=none; b=FMiZAeKwYN1jLEXX2wQvEE/QR86fqjJCzvQk+R5YYGetg0xj8cSlVh0oa9Mv9enJfF7qDWgko+qYNXKVBCgkPyEl0bNiukyJcFy5NSGKtIAlRWuJv6eHt1GhhNB9GEbQZbEIPTsBvI6I+fL/edqcstOcBiYv5nxk714Ms6O9V1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804167; c=relaxed/simple;
	bh=UsRoU0V2pJqQkgePAQkYQptBaGH3Waj8mtrnWUsCAYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LdJwE4w76gb6mF9mj0pHLMi/e85FTszL/zIkWGg7S7YF+2tPoYRG8dUJK9+/YmNbUgBL+V/I5iJxkbNPg6ikyhPXWkyV1hZibeKBeTX+KBxY42Pg+RuBjaaFRuKKuplnZ+4Khj66pmEfTrxeFfD+YEnz3/liZPc5UN4DfOGENyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from 0019-wifi-iwlwifi-validate-PNVM-SKU-TLV-length.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAXbhHBbkNqo1okFg--.15101S2;
	Tue, 30 Jun 2026 15:22:41 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: "open list:INTEL WIRELESS WIFI LINK iwlwifi" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] wifi: iwlwifi: validate PNVM SKU TLV length
Date: Tue, 30 Jun 2026 15:21:31 +0800
Message-ID: <2026063008044943.4-ccfa108-0019-wifi-iwlwifi-validate-PNVM--pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXbhHBbkNqo1okFg--.15101S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3WF1xJFyxJw47JF17GFg_yoWDuFb_C3
	4rAFn8GryFkw1avrsrCrW3A3s0vryv9as7uw1Dt3s3uayUJry2gryFvFn8JrWDKr10yFZ3
	Arn7Cr18J3s09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbFAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb3rc3UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38329-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD0FE6E122F

iwl_pnvm_parse() reads three SKU words from IWL_UCODE_TLV_PNVM_SKU TLVs
after only checking the generic TLV length.

Add a type-specific minimum payload length check before reading the SKU
words.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index afff8d5..f61e69b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -198,6 +198,12 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 			IWL_DEBUG_FW(trans,
 				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
 				     tlv_len);
+			if (tlv_len < 3 * sizeof(__le32)) {
+				IWL_ERR(trans, "invalid PNVM SKU TLV len: %u\n",
+					tlv_len);
+				return -EINVAL;
+			}
+
 			IWL_DEBUG_FW(trans, "sku_id 0x%0x 0x%0x 0x%0x\n",
 				     le32_to_cpu(tlv_sku_id->data[0]),
 				     le32_to_cpu(tlv_sku_id->data[1]),


