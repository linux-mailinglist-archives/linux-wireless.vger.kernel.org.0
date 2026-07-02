Return-Path: <linux-wireless+bounces-38507-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aTm7BcFSRmoUQwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38507-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:00:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A36586F72C2
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AuX+X7B+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38507-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38507-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C7653020019
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2147A0D0;
	Thu,  2 Jul 2026 11:59:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9747D952;
	Thu,  2 Jul 2026 11:59:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993574; cv=none; b=XME8mel+waLSRrLKmNMr93vvRekJgZ3Rkcaa89OxRMKmuXdFdWbvueB2jNS6T2b2AWJkz+C4DkHVnqTTMwhjeopuBzz7mOC+saG6nQThTK95mtddV2ze5fK9esSQArJ3OylFymJryWxvcDUxuBf/Isy9e4+IqROjYiqRrg5LoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993574; c=relaxed/simple;
	bh=p3nu3LfJBqR0MzdgjAL8czP7txlHxXyBJMve5A2GM7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA5FkeBH7JRICXJkizouF7g2x2QgL2b+e5Q8KwMbJB4gGHxoIyG7Aq3FYNUbmHcR9GG2Yf9EAOfwprqF/bZk5ZufjGayxPh2GQ5HRKYP4FAH457t1jXfU+a0xxd1Yf/DkZRk8pM1Hlr58ecwl8ligWTBjsjTrZhqwlkJc9sD1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuX+X7B+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162261F000E9;
	Thu,  2 Jul 2026 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782993570;
	bh=lhMULHhrK/P4JyhKYEVBzLqzq7fIkjDRPT2NEiPERJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AuX+X7B+ZGKKlF0QvB+rc4JwuL7saYyk3opYRSs+k1sZYLnZSrY9uTGPauHTPijvH
	 GYO0UVZr0ShjCa1upP+zsr8ByDbKerGPKPYpbyP8yo9ZaTBUCKS/QNqGl1phifCW+B
	 2/mwBnQ0k10bvNGZqJrwHVyh6pChEERCCTkeC+JdrINzF5NZCuPNK/UwY5k6RQVIyi
	 s9H91H10ShdsBWQ6YqJEN2NtfMEnYppOL26oWvRx5dWnm++g7VvnEMHEsgul/cLcQj
	 GcclN2YrD+tRpmnfszLBIWjR3Nq14IHjWTuy4hAw6LHQqp7PW4gLDqUr757h9y+79g
	 P6bJoZbiZT2sA==
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
	jenswi@kernel.org,
	op-tee@lists.trustedfirmware.org,
	apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 02/14] firmware: qcom_scm: Migrate to generic PAS service
Date: Thu,  2 Jul 2026 17:28:18 +0530
Message-ID: <20260702115835.167602-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-38507-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss
 .qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_GT_50(0.00)[50];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qcom_pas_ops_scm.dev:url,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A36586F72C2

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

With the availability of generic PAS service, let's add SCM calls as
a backend to keep supporting legacy QTEE interfaces. The exported
qcom_scm* wrappers will get dropped once all the client drivers get
migrated as part of future patches.

Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/Kconfig    |   4 +-
 drivers/firmware/qcom/qcom_scm.c | 335 ++++++++++++++-----------------
 2 files changed, 157 insertions(+), 182 deletions(-)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 9f66cc774508..a5b3344289f7 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -15,8 +15,10 @@ config QCOM_PAS
 	  TEE bus based PAS service implementation.
 
 config QCOM_SCM
+	tristate "Qualcomm PAS SCM interface driver"
+	select QCOM_PAS
 	select QCOM_TZMEM
-	tristate
+	default y if ARCH_QCOM
 
 config QCOM_TZMEM
 	tristate
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 6b601a4b89db..7933e55803dc 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/firmware/qcom/qcom_tzmem.h>
 #include <linux/init.h>
@@ -33,6 +34,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include "qcom_pas.h"
 #include "qcom_scm.h"
 #include "qcom_tzmem.h"
 
@@ -479,25 +481,6 @@ void qcom_scm_cpu_power_down(u32 flags)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_cpu_power_down);
 
-int qcom_scm_set_remote_state(u32 state, u32 id)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
-		.arginfo = QCOM_SCM_ARGS(2),
-		.args[0] = state,
-		.args[1] = id,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
-
 static int qcom_scm_disable_sdi(void)
 {
 	int ret;
@@ -570,26 +553,12 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
-/**
- * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
- *				       context for a given peripheral
- *
- * PAS context is device-resource managed, so the caller does not need
- * to worry about freeing the context memory.
- *
- * @dev:	  PAS firmware device
- * @pas_id:	  peripheral authentication service id
- * @mem_phys:	  Subsystem reserve memory start address
- * @mem_size:	  Subsystem reserve memory size
- *
- * Returns: The new PAS context, or ERR_PTR() on failure.
- */
 struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
 							     u32 pas_id,
 							     phys_addr_t mem_phys,
 							     size_t mem_size)
 {
-	struct qcom_scm_pas_context *ctx;
+	struct qcom_pas_context *ctx;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -600,11 +569,12 @@ struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
 	ctx->mem_phys = mem_phys;
 	ctx->mem_size = mem_size;
 
-	return ctx;
+	return (struct qcom_scm_pas_context *)ctx;
 }
 EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_alloc);
 
-static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys,
+static int __qcom_scm_pas_init_image(struct device *dev, u32 pas_id,
+				     dma_addr_t mdata_phys,
 				     struct qcom_scm_res *res)
 {
 	struct qcom_scm_desc desc = {
@@ -626,7 +596,7 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys,
 
 	desc.args[1] = mdata_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, res);
+	ret = qcom_scm_call(dev, &desc, res);
 	qcom_scm_bw_disable();
 
 disable_clk:
@@ -635,7 +605,8 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys,
 	return ret;
 }
 
-static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_context *ctx,
+static int qcom_scm_pas_prep_and_init_image(struct device *dev,
+					    struct qcom_pas_context *ctx,
 					    const void *metadata, size_t size)
 {
 	struct qcom_scm_res res;
@@ -650,7 +621,7 @@ static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_context *ctx,
 	memcpy(mdata_buf, metadata, size);
 	mdata_phys = qcom_tzmem_to_phys(mdata_buf);
 
-	ret = __qcom_scm_pas_init_image(ctx->pas_id, mdata_phys, &res);
+	ret = __qcom_scm_pas_init_image(dev, ctx->pas_id, mdata_phys, &res);
 	if (ret < 0)
 		qcom_tzmem_free(mdata_buf);
 	else
@@ -659,25 +630,9 @@ static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_context *ctx,
 	return ret ? : res.result[0];
 }
 
-/**
- * qcom_scm_pas_init_image() - Initialize peripheral authentication service
- *			       state machine for a given peripheral, using the
- *			       metadata
- * @pas_id:	peripheral authentication service id
- * @metadata:	pointer to memory containing ELF header, program header table
- *		and optional blob of data used for authenticating the metadata
- *		and the rest of the firmware
- * @size:	size of the metadata
- * @ctx:	optional pas context
- *
- * Return: 0 on success.
- *
- * Upon successful return, the PAS metadata context (@ctx) will be used to
- * track the metadata allocation, this needs to be released by invoking
- * qcom_scm_pas_metadata_release() by the caller.
- */
-int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_context *ctx)
+static int __qcom_scm_pas_init_image2(struct device *dev, u32 pas_id,
+				      const void *metadata, size_t size,
+				      struct qcom_pas_context *ctx)
 {
 	struct qcom_scm_res res;
 	dma_addr_t mdata_phys;
@@ -685,7 +640,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	int ret;
 
 	if (ctx && ctx->use_tzmem)
-		return qcom_scm_pas_prep_and_init_image(ctx, metadata, size);
+		return qcom_scm_pas_prep_and_init_image(dev, ctx, metadata, size);
 
 	/*
 	 * During the scm call memory protection will be enabled for the meta
@@ -699,16 +654,15 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 	 * If we pass a buffer that is already part of an SHM Bridge to this
 	 * call, it will fail.
 	 */
-	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
-				       GFP_KERNEL);
+	mdata_buf = dma_alloc_coherent(dev, size, &mdata_phys, GFP_KERNEL);
 	if (!mdata_buf)
 		return -ENOMEM;
 
 	memcpy(mdata_buf, metadata, size);
 
-	ret = __qcom_scm_pas_init_image(pas_id, mdata_phys, &res);
+	ret = __qcom_scm_pas_init_image(dev, pas_id, mdata_phys, &res);
 	if (ret < 0 || !ctx) {
-		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
+		dma_free_coherent(dev, size, mdata_buf, mdata_phys);
 	} else if (ctx) {
 		ctx->ptr = mdata_buf;
 		ctx->phys = mdata_phys;
@@ -717,36 +671,35 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 
 	return ret ? : res.result[0];
 }
-EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
 
-/**
- * qcom_scm_pas_metadata_release() - release metadata context
- * @ctx:	pas context
- */
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
+int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
+			    struct qcom_scm_pas_context *ctx)
 {
-	if (!ctx->ptr)
-		return;
+	return __qcom_scm_pas_init_image2(__scm->dev, pas_id, metadata, size,
+					  (struct qcom_pas_context *)ctx);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
 
+static void __qcom_scm_pas_metadata_release(struct device *dev,
+					    struct qcom_pas_context *ctx)
+{
 	if (ctx->use_tzmem)
 		qcom_tzmem_free(ctx->ptr);
 	else
-		dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
+		dma_free_coherent(dev, ctx->size, ctx->ptr, ctx->phys);
 
 	ctx->ptr = NULL;
 }
+
+void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
+{
+	__qcom_scm_pas_metadata_release(__scm->dev,
+					(struct qcom_pas_context *)ctx);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
 
-/**
- * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
- *			      for firmware loading
- * @pas_id:	peripheral authentication service id
- * @addr:	start address of memory area to prepare
- * @size:	size of the memory area to prepare
- *
- * Returns 0 on success.
- */
-int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
+static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
+				    phys_addr_t addr, phys_addr_t size)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -768,7 +721,7 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
 	if (ret)
 		goto disable_clk;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(dev, &desc, &res);
 	qcom_scm_bw_disable();
 
 disable_clk:
@@ -776,9 +729,15 @@ int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
 
 	return ret ? : res.result[0];
 }
+
+int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
+{
+	return __qcom_scm_pas_mem_setup(__scm->dev, pas_id, addr, size);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
 
-static void *__qcom_scm_pas_get_rsc_table(u32 pas_id, void *input_rt_tzm,
+static void *__qcom_scm_pas_get_rsc_table(struct device *dev, u32 pas_id,
+					  void *input_rt_tzm,
 					  size_t input_rt_size,
 					  size_t *output_rt_size)
 {
@@ -813,7 +772,7 @@ static void *__qcom_scm_pas_get_rsc_table(u32 pas_id, void *input_rt_tzm,
 	 * with output_rt_tzm buffer with res.result[2] size however, It should not
 	 * be of unresonable size.
 	 */
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(dev, &desc, &res);
 	if (!ret && res.result[2] > SZ_1G) {
 		ret = -E2BIG;
 		goto free_output_rt;
@@ -830,51 +789,11 @@ static void *__qcom_scm_pas_get_rsc_table(u32 pas_id, void *input_rt_tzm,
 	return ret ? ERR_PTR(ret) : output_rt_tzm;
 }
 
-/**
- * qcom_scm_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
- *				  for a given peripheral.
- *
- * Qualcomm remote processor may rely on both static and dynamic resources for
- * its functionality. Static resources typically refer to memory-mapped addresses
- * required by the subsystem and are often embedded within the firmware binary
- * and dynamic resources, such as shared memory in DDR etc., are determined at
- * runtime during the boot process.
- *
- * On Qualcomm Technologies devices, it's possible that static resources are not
- * embedded in the firmware binary and instead are provided by TrustZone However,
- * dynamic resources are always expected to come from TrustZone. This indicates
- * that for Qualcomm devices, all resources (static and dynamic) will be provided
- * by TrustZone via the SMC call.
- *
- * If the remote processor firmware binary does contain static resources, they
- * should be passed in input_rt. These will be forwarded to TrustZone for
- * authentication. TrustZone will then append the dynamic resources and return
- * the complete resource table in output_rt_tzm.
- *
- * If the remote processor firmware binary does not include a resource table,
- * the caller of this function should set input_rt as NULL and input_rt_size
- * as zero respectively.
- *
- * More about documentation on resource table data structures can be found in
- * include/linux/remoteproc.h
- *
- * @ctx:	    PAS context
- * @pas_id:	    peripheral authentication service id
- * @input_rt:       resource table buffer which is present in firmware binary
- * @input_rt_size:  size of the resource table present in firmware binary
- * @output_rt_size: TrustZone expects caller should pass worst case size for
- *		    the output_rt_tzm.
- *
- * Return:
- *  On success, returns a pointer to the allocated buffer containing the final
- *  resource table and output_rt_size will have actual resource table size from
- *  TrustZone. The caller is responsible for freeing the buffer. On failure,
- *  returns ERR_PTR(-errno).
- */
-struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx,
-						  void *input_rt,
-						  size_t input_rt_size,
-						  size_t *output_rt_size)
+static void *__qcom_scm_pas_get_rsc_table2(struct device *dev,
+					   struct qcom_pas_context *ctx,
+					   void *input_rt,
+					   size_t input_rt_size,
+					   size_t *output_rt_size)
 {
 	struct resource_table empty_rsc = {};
 	size_t size = SZ_16K;
@@ -909,11 +828,12 @@ struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *c
 
 	memcpy(input_rt_tzm, input_rt, input_rt_size);
 
-	output_rt_tzm = __qcom_scm_pas_get_rsc_table(ctx->pas_id, input_rt_tzm,
+	output_rt_tzm = __qcom_scm_pas_get_rsc_table(dev, ctx->pas_id,
+						     input_rt_tzm,
 						     input_rt_size, &size);
 	if (PTR_ERR(output_rt_tzm) == -EOVERFLOW)
 		/* Try again with the size requested by the TZ */
-		output_rt_tzm = __qcom_scm_pas_get_rsc_table(ctx->pas_id,
+		output_rt_tzm = __qcom_scm_pas_get_rsc_table(dev, ctx->pas_id,
 							     input_rt_tzm,
 							     input_rt_size,
 							     &size);
@@ -943,16 +863,20 @@ struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *c
 
 	return ret ? ERR_PTR(ret) : tbl_ptr;
 }
+
+struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx,
+						  void *input_rt,
+						  size_t input_rt_size,
+						  size_t *output_rt_size)
+{
+	return __qcom_scm_pas_get_rsc_table2(__scm->dev,
+					     (struct qcom_pas_context *)ctx,
+					     input_rt, input_rt_size,
+					     output_rt_size);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_get_rsc_table);
 
-/**
- * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
- *				   and reset the remote processor
- * @pas_id:	peripheral authentication service id
- *
- * Return 0 on success.
- */
-int qcom_scm_pas_auth_and_reset(u32 pas_id)
+static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -972,7 +896,7 @@ int qcom_scm_pas_auth_and_reset(u32 pas_id)
 	if (ret)
 		goto disable_clk;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(dev, &desc, &res);
 	qcom_scm_bw_disable();
 
 disable_clk:
@@ -980,28 +904,15 @@ int qcom_scm_pas_auth_and_reset(u32 pas_id)
 
 	return ret ? : res.result[0];
 }
+
+int qcom_scm_pas_auth_and_reset(u32 pas_id)
+{
+	return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
 
-/**
- * qcom_scm_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
- *					   remote processor
- *
- * @ctx:	Context saved during call to qcom_scm_pas_context_init()
- *
- * This function performs the necessary steps to prepare a PAS subsystem,
- * authenticate it using the provided metadata, and initiate a reset sequence.
- *
- * It should be used when Linux is in control setting up the IOMMU hardware
- * for remote subsystem during secure firmware loading processes. The preparation
- * step sets up a shmbridge over the firmware memory before TrustZone accesses the
- * firmware memory region for authentication. The authentication step verifies
- * the integrity and authenticity of the firmware or configuration using secure
- * metadata. Finally, the reset step ensures the subsystem starts in a clean and
- * sane state.
- *
- * Return: 0 on success, negative errno on failure.
- */
-int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
+static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
+						 struct qcom_pas_context *ctx)
 {
 	u64 handle;
 	int ret;
@@ -1012,7 +923,7 @@ int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
 	 * memory region and then invokes a call to TrustZone to authenticate.
 	 */
 	if (!ctx->use_tzmem)
-		return qcom_scm_pas_auth_and_reset(ctx->pas_id);
+		return __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 
 	/*
 	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
@@ -1022,20 +933,45 @@ int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_pas_auth_and_reset(ctx->pas_id);
+	ret = __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 	qcom_tzmem_shm_bridge_delete(handle);
 
 	return ret;
 }
+
+int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
+{
+	return __qcom_scm_pas_prepare_and_auth_reset(__scm->dev,
+						     (struct qcom_pas_context *)ctx);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_prepare_and_auth_reset);
 
-/**
- * qcom_scm_pas_shutdown() - Shut down the remote processor
- * @pas_id:	peripheral authentication service id
- *
- * Returns 0 on success.
- */
-int qcom_scm_pas_shutdown(u32 pas_id)
+static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
+					   u32 pas_id)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = state,
+		.args[1] = pas_id,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(dev, &desc, &res);
+
+	return ret ? : res.result[0];
+}
+
+int qcom_scm_set_remote_state(u32 state, u32 id)
+{
+	return __qcom_scm_pas_set_remote_state(__scm->dev, state, id);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
+
+static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -1055,7 +991,7 @@ int qcom_scm_pas_shutdown(u32 pas_id)
 	if (ret)
 		goto disable_clk;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(dev, &desc, &res);
 	qcom_scm_bw_disable();
 
 disable_clk:
@@ -1063,16 +999,14 @@ int qcom_scm_pas_shutdown(u32 pas_id)
 
 	return ret ? : res.result[0];
 }
+
+int qcom_scm_pas_shutdown(u32 pas_id)
+{
+	return __qcom_scm_pas_shutdown(__scm->dev, pas_id);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
 
-/**
- * qcom_scm_pas_supported() - Check if the peripheral authentication service is
- *			      available for the given peripherial
- * @pas_id:	peripheral authentication service id
- *
- * Returns true if PAS is supported for this peripheral, otherwise false.
- */
-bool qcom_scm_pas_supported(u32 pas_id)
+static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -1084,16 +1018,49 @@ bool qcom_scm_pas_supported(u32 pas_id)
 	};
 	struct qcom_scm_res res;
 
-	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
+	if (!__qcom_scm_is_call_available(dev, QCOM_SCM_SVC_PIL,
 					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
 		return false;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(dev, &desc, &res);
 
 	return ret ? false : !!res.result[0];
 }
+
+bool qcom_scm_pas_supported(u32 pas_id)
+{
+	return __qcom_scm_pas_supported(__scm->dev, pas_id);
+}
 EXPORT_SYMBOL_GPL(qcom_scm_pas_supported);
 
+static struct qcom_pas_ops qcom_pas_ops_scm = {
+	.drv_name		= "qcom_scm",
+	.supported		= __qcom_scm_pas_supported,
+	.init_image		= __qcom_scm_pas_init_image2,
+	.mem_setup		= __qcom_scm_pas_mem_setup,
+	.get_rsc_table		= __qcom_scm_pas_get_rsc_table2,
+	.auth_and_reset		= __qcom_scm_pas_auth_and_reset,
+	.prepare_and_auth_reset	= __qcom_scm_pas_prepare_and_auth_reset,
+	.set_remote_state	= __qcom_scm_pas_set_remote_state,
+	.shutdown		= __qcom_scm_pas_shutdown,
+	.metadata_release	= __qcom_scm_pas_metadata_release,
+};
+
+/**
+ * qcom_scm_is_pas_available() - Check if the peripheral authentication service
+ *				 is available via SCM or not
+ *
+ * Returns true if PAS is available, otherwise false.
+ */
+static bool qcom_scm_is_pas_available(void)
+{
+	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
+					  QCOM_SCM_PIL_PAS_AUTH_AND_RESET))
+		return false;
+
+	return true;
+}
+
 static int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 {
 	struct qcom_scm_desc desc = {
@@ -2837,6 +2804,11 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	__get_convention();
 
+	if (qcom_scm_is_pas_available()) {
+		qcom_pas_ops_scm.dev = scm->dev;
+		qcom_pas_ops_register(&qcom_pas_ops_scm);
+	}
+
 	/*
 	 * If "download mode" is requested, from this point on warmboot
 	 * will cause the boot stages to enter download mode, unless
@@ -2876,6 +2848,7 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
 	qcom_scm_set_download_mode(QCOM_DLOAD_NODUMP);
+	qcom_pas_ops_unregister();
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-- 
2.53.0


