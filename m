Return-Path: <linux-wireless+bounces-35850-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNoeCT6b+GlgxAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35850-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:12:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8714BD990
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 260B43010710
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96E3D9DAB;
	Mon,  4 May 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krk5vaBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210793D88F9;
	Mon,  4 May 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900122; cv=none; b=F8oEDus8CTmT6vbSxDZ6fs85wdLD4TdQcQVQbfJkUHTaObB7/6DPdcEXT5IpF8k43eJJWV+WF80Ar85c0IIyXmOwSl4yoXBvy8AVOv/iG7X7gaV0DjzSz3NbvFXNSdQiQYscKoZFgGEr7M7g1peayWatAGaBHES+gCVKXCdBjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900122; c=relaxed/simple;
	bh=FG2/FsoSV0x9y2GjvjXsSkB395WB+qmJH+LemxYt8Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIhDSlZeuoJ/ds5KWBVvAaPQcF18apgBAUcGvVWXFag4mXYrxuPq9V2Fyb+wz3S8wAuuWd9OJTlXOA964gyIDW+SM0mgp1m6yFPoEWlVHeSLXai7E4KGmg2+15ZfZjpL2g4nuDH9XtXTghvD+tH5DIMrEV/+t9tYy8TzUH/L+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krk5vaBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5115AC2BCB8;
	Mon,  4 May 2026 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777900121;
	bh=FG2/FsoSV0x9y2GjvjXsSkB395WB+qmJH+LemxYt8Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krk5vaBs6Xtl116nQ/8HTRq9FD7HZDVDDet/HCeOxOoJxXyvarYjccMSsK7ZwrByK
	 FhAsLx9o3VD2Xqm4/FJmwWOm5YGc3LHnFJruN2njYdTTxRAAT9BLUo+Ys2fHe5vSKr
	 GA81kCoAu7Gw/+dQrYFS8Fo5SJ8s8gUKFdMJJBtN92xn1KdTOplPlPJDZHe82iImkd
	 0MicZeeWAji2lu0BRuWMqgWLTvXMThSBtyjda3LPtkpoQdyqm7/yidX7Wi2U5xWwIF
	 2UjZOMmD3/T+Yuswuc5oG9TuiQWxRxFJ4U0ZeKEGPM3qfQknAZKLlxvDwW9U73mM8w
	 r9WKysqPrWKEA==
From: Sumit Garg <sumit.garg@kernel.org>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com,
	sean@poorly.run,
	akhilpo@oss.qualcomm.com,
	lumag@kernel.org,
	abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com,
	bod@kernel.org,
	mchehab@kernel.org,
	elder@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jjohnson@kernel.org,
	mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com,
	jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org,
	apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v5 07/16] soc: qcom: mdtloader: Switch to generic PAS TZ APIs
Date: Mon,  4 May 2026 18:35:54 +0530
Message-ID: <20260504130603.1474043-8-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504130603.1474043-1-sumit.garg@kernel.org>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C8714BD990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-35850-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email]

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch mdtloader client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c       | 12 ++++++------
 include/linux/soc/qcom/mdt_loader.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index c004d444d698..137992456b71 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -13,7 +13,7 @@
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -229,7 +229,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
 
 static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 			       const char *fw_name, int pas_id, phys_addr_t mem_phys,
-			       struct qcom_scm_pas_context *ctx)
+			       struct qcom_pas_context *ctx)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
@@ -271,7 +271,7 @@ static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		goto out;
 	}
 
-	ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len, ctx);
+	ret = qcom_pas_init_image(pas_id, metadata, metadata_len, ctx);
 	kfree(metadata);
 	if (ret) {
 		/* Invalid firmware metadata */
@@ -280,7 +280,7 @@ static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	}
 
 	if (relocate) {
-		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
+		ret = qcom_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
 		if (ret) {
 			/* Unable to set up relocation */
 			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
@@ -472,7 +472,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
  * firmware segments (e.g., .bXX files). Authentication of the segments done
  * by a separate call.
  *
- * The PAS context must be initialized using qcom_scm_pas_context_init()
+ * The PAS context must be initialized using devm_qcom_pas_context_alloc()
  * prior to invoking this function.
  *
  * @ctx:        Pointer to the PAS (Peripheral Authentication Service) context
@@ -483,7 +483,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
+int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
 		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
 {
 	int ret;
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 82372e0db0a1..142409555425 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -10,7 +10,7 @@
 
 struct device;
 struct firmware;
-struct qcom_scm_pas_context;
+struct qcom_pas_context;
 
 #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
 
@@ -20,7 +20,7 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  phys_addr_t mem_phys, size_t mem_size,
 		  phys_addr_t *reloc_base);
 
-int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
+int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
 		      const char *firmware, void *mem_region, phys_addr_t *reloc_base);
 
 int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
@@ -45,7 +45,7 @@ static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	return -ENODEV;
 }
 
-static inline int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx,
+static inline int qcom_mdt_pas_load(struct qcom_pas_context *ctx,
 				    const struct firmware *fw, const char *firmware,
 				    void *mem_region, phys_addr_t *reloc_base)
 {
-- 
2.51.0


