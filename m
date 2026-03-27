Return-Path: <linux-wireless+bounces-34083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIZGIQWFxmmhLQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:24:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1855F3451FC
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CC93318BB16
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D873EC2E6;
	Fri, 27 Mar 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTXxTsEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D43EBF18;
	Fri, 27 Mar 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617289; cv=none; b=KsEqtOQTxA8y79b6KkMAH0JMFD4KNrOrW4miLpyFJGylTHVgLPsbJrGvrS0Z/ndqlKtmt6STXxqb/AOC86cX44m1pvmbvjbPx1M8LxNGhqj/G3T4zo8lob/ucOtlVcoIOeRnjbipzt7vcAViJqaxIYGVcD/gnq+73eyrK4pRY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617289; c=relaxed/simple;
	bh=wBpqb+b+onESX4SquyR+YxtxMUWXKrdgQMDFcmay1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYI+Q3lULbkR/RQhZZPJjYzTzcLeE1ZQWgMZItApSTRApwVtJ7ZdXB0jiEOyck0FFY/DRvb7mY3VFdxU8KPn/n9t1/DZ6N2M5PQIfpucNHXSSXerMMx37aD1eJF1tb4lpa5hnip+VA9r8IJByZfLs2wi97aKV4bVUiEtgfiXPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTXxTsEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84377C19423;
	Fri, 27 Mar 2026 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617289;
	bh=wBpqb+b+onESX4SquyR+YxtxMUWXKrdgQMDFcmay1FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTXxTsEquX7MVJve4XKB5C/PYbgvWTkn2aM3+w9IM+zIFjv5o6++f4lZJ19EqcY3T
	 FsUoMQPtkGh3iaDkg/Fbwevxn1Ny7c2OZ6/CvrGlUb6RWrNL0byfx1m4d/v6ZUgJMQ
	 /Y4Roe+x7dZxSER481ZrRsw08eYaSraeoRYe3EcVCuiTDyvmozHEo1Tt7bDdM0ZfQK
	 0qcwH5IYPF+MIBL5AfUwEqvu9j0tHL7/mICIs3l4Sum8OPvNaBUGmlmiWb+j3H4YNP
	 T1d0APqx6+YvRRAo87YIKdJH7F+j5hU6JibLEwdFsAP6x9U1sTw2SXMorgw93C206P
	 LxW9KEW6pYeBg==
From: Sumit Garg <sumit.garg@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
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
	harshal.dev@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 14/15] firmware: qcom_scm: Remove SCM PAS wrappers
Date: Fri, 27 Mar 2026 18:40:42 +0530
Message-ID: <20260327131043.627120-15-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327131043.627120-1-sumit.garg@kernel.org>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34083-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 1855F3451FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Now since all the Qcom SCM client drivers have been migrated over to
generic PAS TZ service, let's drop the exported SCM PAS wrappers.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 143 +++++--------------------
 include/linux/firmware/qcom/qcom_scm.h |  29 -----
 2 files changed, 29 insertions(+), 143 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index ab802048a719..555642f3ccdd 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -554,26 +554,6 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
-struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
-							     u32 pas_id,
-							     phys_addr_t mem_phys,
-							     size_t mem_size)
-{
-	struct qcom_pas_context *ctx;
-
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
-
-	ctx->dev = dev;
-	ctx->pas_id = pas_id;
-	ctx->mem_phys = mem_phys;
-	ctx->mem_size = mem_size;
-
-	return (struct qcom_scm_pas_context *)ctx;
-}
-EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_alloc);
-
 static int __qcom_scm_pas_init_image(struct device *dev, u32 pas_id,
 				     dma_addr_t mdata_phys,
 				     struct qcom_scm_res *res)
@@ -631,9 +611,9 @@ static int qcom_scm_pas_prep_and_init_image(struct device *dev,
 	return ret ? : res.result[0];
 }
 
-static int __qcom_scm_pas_init_image2(struct device *dev, u32 pas_id,
-				      const void *metadata, size_t size,
-				      struct qcom_pas_context *ctx)
+static int qcom_scm_pas_init_image(struct device *dev, u32 pas_id,
+				   const void *metadata, size_t size,
+				   struct qcom_pas_context *ctx)
 {
 	struct qcom_scm_res res;
 	dma_addr_t mdata_phys;
@@ -673,16 +653,8 @@ static int __qcom_scm_pas_init_image2(struct device *dev, u32 pas_id,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_context *ctx)
-{
-	return __qcom_scm_pas_init_image2(__scm->dev, pas_id, metadata, size,
-					  (struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
-
-static void __qcom_scm_pas_metadata_release(struct device *dev,
-					    struct qcom_pas_context *ctx)
+static void qcom_scm_pas_metadata_release(struct device *dev,
+					  struct qcom_pas_context *ctx)
 {
 	if (ctx->use_tzmem)
 		qcom_tzmem_free(ctx->ptr);
@@ -692,15 +664,8 @@ static void __qcom_scm_pas_metadata_release(struct device *dev,
 	ctx->ptr = NULL;
 }
 
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
-{
-	__qcom_scm_pas_metadata_release(__scm->dev,
-					(struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
-
-static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
-				    phys_addr_t addr, phys_addr_t size)
+static int qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
+				  phys_addr_t addr, phys_addr_t size)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -731,12 +696,6 @@ static int __qcom_scm_pas_mem_setup(struct device *dev, u32 pas_id,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
-{
-	return __qcom_scm_pas_mem_setup(__scm->dev, pas_id, addr, size);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_mem_setup);
-
 static void *__qcom_scm_pas_get_rsc_table(struct device *dev, u32 pas_id,
 					  void *input_rt_tzm,
 					  size_t input_rt_size,
@@ -790,11 +749,10 @@ static void *__qcom_scm_pas_get_rsc_table(struct device *dev, u32 pas_id,
 	return ret ? ERR_PTR(ret) : output_rt_tzm;
 }
 
-static void *__qcom_scm_pas_get_rsc_table2(struct device *dev,
-					   struct qcom_pas_context *ctx,
-					   void *input_rt,
-					   size_t input_rt_size,
-					   size_t *output_rt_size)
+static void *qcom_scm_pas_get_rsc_table(struct device *dev,
+					struct qcom_pas_context *ctx,
+					void *input_rt, size_t input_rt_size,
+					size_t *output_rt_size)
 {
 	struct resource_table empty_rsc = {};
 	size_t size = SZ_16K;
@@ -866,19 +824,7 @@ static void *__qcom_scm_pas_get_rsc_table2(struct device *dev,
 	return ret ? ERR_PTR(ret) : tbl_ptr;
 }
 
-struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx,
-						  void *input_rt,
-						  size_t input_rt_size,
-						  size_t *output_rt_size)
-{
-	return __qcom_scm_pas_get_rsc_table2(__scm->dev,
-					     (struct qcom_pas_context *)ctx,
-					     input_rt, input_rt_size,
-					     output_rt_size);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_get_rsc_table);
-
-static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
+static int qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -907,14 +853,8 @@ static int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 pas_id)
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_auth_and_reset(u32 pas_id)
-{
-	return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
-
-static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
-						 struct qcom_pas_context *ctx)
+static int qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
+					       struct qcom_pas_context *ctx)
 {
 	u64 handle;
 	int ret;
@@ -925,7 +865,7 @@ static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	 * memory region and then invokes a call to TrustZone to authenticate.
 	 */
 	if (!ctx->use_tzmem)
-		return __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+		return qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 
 	/*
 	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
@@ -935,21 +875,14 @@ static int __qcom_scm_pas_prepare_and_auth_reset(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
+	ret = qcom_scm_pas_auth_and_reset(dev, ctx->pas_id);
 	qcom_tzmem_shm_bridge_delete(handle);
 
 	return ret;
 }
 
-int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
-{
-	return __qcom_scm_pas_prepare_and_auth_reset(__scm->dev,
-						     (struct qcom_pas_context *)ctx);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_prepare_and_auth_reset);
-
-static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
-					   u32 pas_id)
+static int qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
+					 u32 pas_id)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_BOOT,
@@ -967,13 +900,7 @@ static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_set_remote_state(u32 state, u32 id)
-{
-	return __qcom_scm_pas_set_remote_state(__scm->dev, state, id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
-
-static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
+static int qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -1002,13 +929,7 @@ static int __qcom_scm_pas_shutdown(struct device *dev, u32 pas_id)
 	return ret ? : res.result[0];
 }
 
-int qcom_scm_pas_shutdown(u32 pas_id)
-{
-	return __qcom_scm_pas_shutdown(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_shutdown);
-
-static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
+static bool qcom_scm_pas_supported(struct device *dev, u32 pas_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -1029,23 +950,17 @@ static bool __qcom_scm_pas_supported(struct device *dev, u32 pas_id)
 	return ret ? false : !!res.result[0];
 }
 
-bool qcom_scm_pas_supported(u32 pas_id)
-{
-	return __qcom_scm_pas_supported(__scm->dev, pas_id);
-}
-EXPORT_SYMBOL_GPL(qcom_scm_pas_supported);
-
 static struct qcom_pas_ops qcom_pas_ops_scm = {
 	.drv_name		= "qcom_scm",
-	.supported		= __qcom_scm_pas_supported,
-	.init_image		= __qcom_scm_pas_init_image2,
-	.mem_setup		= __qcom_scm_pas_mem_setup,
-	.get_rsc_table		= __qcom_scm_pas_get_rsc_table2,
-	.auth_and_reset		= __qcom_scm_pas_auth_and_reset,
-	.prepare_and_auth_reset	= __qcom_scm_pas_prepare_and_auth_reset,
-	.set_remote_state	= __qcom_scm_pas_set_remote_state,
-	.shutdown		= __qcom_scm_pas_shutdown,
-	.metadata_release	= __qcom_scm_pas_metadata_release,
+	.supported		= qcom_scm_pas_supported,
+	.init_image		= qcom_scm_pas_init_image,
+	.mem_setup		= qcom_scm_pas_mem_setup,
+	.get_rsc_table		= qcom_scm_pas_get_rsc_table,
+	.auth_and_reset		= qcom_scm_pas_auth_and_reset,
+	.prepare_and_auth_reset	= qcom_scm_pas_prepare_and_auth_reset,
+	.set_remote_state	= qcom_scm_pas_set_remote_state,
+	.shutdown		= qcom_scm_pas_shutdown,
+	.metadata_release	= qcom_scm_pas_metadata_release,
 };
 
 /**
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 5747bd191bf1..a0a6bc0229c4 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -64,35 +64,6 @@ bool qcom_scm_is_available(void);
 int qcom_scm_set_cold_boot_addr(void *entry);
 int qcom_scm_set_warm_boot_addr(void *entry);
 void qcom_scm_cpu_power_down(u32 flags);
-int qcom_scm_set_remote_state(u32 state, u32 id);
-
-struct qcom_scm_pas_context {
-	struct device *dev;
-	u32 pas_id;
-	phys_addr_t mem_phys;
-	size_t mem_size;
-	void *ptr;
-	dma_addr_t phys;
-	ssize_t size;
-	bool use_tzmem;
-};
-
-struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
-							     u32 pas_id,
-							     phys_addr_t mem_phys,
-							     size_t mem_size);
-int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_context *ctx);
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx);
-int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
-int qcom_scm_pas_auth_and_reset(u32 pas_id);
-int qcom_scm_pas_shutdown(u32 pas_id);
-bool qcom_scm_pas_supported(u32 pas_id);
-struct resource_table *qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx,
-						  void *input_rt, size_t input_rt_size,
-						  size_t *output_rt_size);
-
-int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx);
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
-- 
2.51.0


