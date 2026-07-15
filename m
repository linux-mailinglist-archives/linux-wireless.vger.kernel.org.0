Return-Path: <linux-wireless+bounces-39153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OD3IGYKaV2olXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-39153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:34:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F675F72B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:34:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1");
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39153-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39153-lists+linux-wireless=lfdr.de@vger.kernel.org"
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD34030BE3C2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B003793A8;
	Wed, 15 Jul 2026 14:11:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A7377016;
	Wed, 15 Jul 2026 14:11:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124684; cv=none; b=LjC33yl3F8L/kCECvWeAhR4zNbvqi4ll6GOrZ0hiQMIirtebItrpum+HtqzPTKITc4Xf5Tcgysaf2JUTNmD4TPjhNYmeby/pjXwkzSt/X2gzjPpcQtiht0egNs/1EP3FQigpdiAuGeP8lv2NrMyxCRL6x8icILRIH/goujhsmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124684; c=relaxed/simple;
	bh=Z4B8U0jBpySK6TJjMoy90PtjZLyr7rFvGFqKYA5zQfY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p2peCkBviIs6UWXcbVTAybs644Wl37PK9wQ2abCjNLaAYzF42fEBCtoCjgN6oL6hmtTjKbszYO1JARJSpkyjrVK7CUMeB2Plul/L6ckPk0L4/ad7zxqhDAcpJb41kOhXTy1ewyYk3v6n2BLPv1HHDZq+QLGiIN+dEpjaG9ptZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from 0001-iwlwifi-pnvm-v2.eml (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAD3AUAGlVdq7jcCAA--.2192S2;
	Wed, 15 Jul 2026 22:11:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] wifi: iwlwifi: validate PNVM SKU TLV length
Date: Wed, 15 Jul 2026 21:57:50 +0800
Message-ID: <20260715135916.24417-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAD3AUAGlVdq7jcCAA--.2192S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyrKF13GF47Wryrur17Wrg_yoW8GFyUpF
	4jgF12qr4Yqw4UA340ya1rZF90y3W5K39xCFyqqwn09FZ3Xr15A3y8uFy2qr15tr48G34S
	kF4jkF4UGr90qFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-39153-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 504F675F72B
X-Rspamd-Action: no action

iwl_pnvm_parse() reads an iwl_sku_id from an
IWL_UCODE_TLV_PNVM_SKU payload after only checking that the generic TLV
payload is present.

A short type-specific payload can therefore make the three data[] reads
extend beyond the TLV. Reject SKU TLVs shorter than the structure before
accessing it.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/2026063008044943.4-ccfa108-0019-wifi-iwlwifi-validate-PNVM--pengpeng@iscas.ac.cn/
- use sizeof(*tlv_sku_id) as requested by Miri Korenblit
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index afff8d5..6daa5cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -198,6 +198,12 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 			IWL_DEBUG_FW(trans,
 				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
 				     tlv_len);
+			if (tlv_len < sizeof(*tlv_sku_id)) {
+				IWL_ERR(trans, "invalid PNVM SKU TLV len: %u\n",
+					tlv_len);
+				return -EINVAL;
+			}
+
 			IWL_DEBUG_FW(trans, "sku_id 0x%0x 0x%0x 0x%0x\n",
 				     le32_to_cpu(tlv_sku_id->data[0]),
 				     le32_to_cpu(tlv_sku_id->data[1]),
-- 
2.50.1 (Apple Git-155)



