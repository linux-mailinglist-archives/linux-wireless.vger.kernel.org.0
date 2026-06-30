Return-Path: <linux-wireless+bounces-38330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ejWFDlwQ2q3YQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:28:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07336E125D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38330-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38330-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 868F1304A87F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D539A04C;
	Tue, 30 Jun 2026 07:23:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D0EEC0;
	Tue, 30 Jun 2026 07:23:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804211; cv=none; b=CChUNtnniLVZy2M7B1RhNeldXjQmRxyzXLTOTt0JVXjnDLOgx6s171wt651zRPI76NjXkX2ZpmbLzdMTxbahjV+dqhPw8A/ESh+PRnn5/pATLoSasiHx5eovso9tz3i0F7fiWhVPWTIxg9p/AIIfmUheaNkxUxR6/3f22CpQbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804211; c=relaxed/simple;
	bh=gcpD36piaqh1fJLonFOyo9H6g3yDxK12PS8DlNgUfJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j6BfAFUSo1nBIXl/AV1XKKnxY/306LfHF0cqo3ttqmVvoz6prpfxdK0w8DK+LuBW9s+zxVMBGNIjfUpq5duyZ7eiGknJGmCHpuHSFtq0kSMjde3IAe7MqqZwVcWIAIdAWhTu2JTGaNsplGB+oNuak+cTf4GeNQQ4v+7VryLNifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from 0020-wifi-iwlwifi-validate-UEFI-reduced-power-SKU-TLV-length.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADXYQXvbkNqqWIkFg--.48592S2;
	Tue, 30 Jun 2026 15:23:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: "open list:INTEL WIRELESS WIFI LINK iwlwifi" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] wifi: iwlwifi: validate UEFI reduced-power SKU TLV length
Date: Tue, 30 Jun 2026 15:22:41 +0800
Message-ID: <2026063008051412.5-ccfa108-0020-wifi-iwlwifi-validate-UEFI--pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXYQXvbkNqqWIkFg--.48592S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWDWw4xKF45CF1ftFyrJFb_yoWDtFX_Cr
	1rAFn5G34jkw1SvrZrCrW7Z39Yyryv93Z5uw1Dt3sIgayUZr9rWryfurn8trWUKr40yF9r
	Ar17CF18J3sYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbFAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj9a97UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38330-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E07336E125D

iwl_uefi_reduce_power_parse() reads three SKU words from
IWL_UCODE_TLV_PNVM_SKU TLVs after only checking the generic TLV length.

Add the same type-specific minimum payload length check before reading
the SKU words.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 2ef0a7a..747df65 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -248,6 +248,12 @@ int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
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


