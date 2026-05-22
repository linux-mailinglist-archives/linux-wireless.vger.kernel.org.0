Return-Path: <linux-wireless+bounces-36808-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOpRA7dIEGrzVgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36808-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 14:14:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC825B3ADA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 14:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 017BB306A442
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33998371888;
	Fri, 22 May 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ7Xijj8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573F36AB54;
	Fri, 22 May 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451286; cv=none; b=D/8uXmKQk3X14DJgNS/+kDOYevAWwKNMeqR7GOyv7HCVD8OUOW5jJHr0E87OpgQbJsQzPX5SeQF7IQXFih2OnREqpku6WulKVIXPQcLddXdbcgnJuV3vGcK9y4uoENBPxHC5dwTsJP+u6vTp+UIi9AoT7aY0Omz/rxdcLBY0Db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451286; c=relaxed/simple;
	bh=hlN1hCpURwgHwy46nJjY3ORPlby1pQQpbYYWFKac9kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR2bTXSn9CD7L5ztCrU7BwizGeADpPk7A5jw8T7jjPtIS7dz2BZ18SMAogwyH+Jy80u33XDk/MNlp0r66KFmnzPj/2hK0qryxTqTFIv8FRcLklQin4NE4+v4pDKdeK0lhsnBM4EYbXVeHj2JvOK8HAavfABtXt2m29ai68dL3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ7Xijj8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00DE1F00A3D;
	Fri, 22 May 2026 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451284;
	bh=ZCHoGWx+Adose3IpObYd/ijLzlYjuIe3MHHtRdiEKVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RZ7Xijj8L5LyNQUz0tIqPFlA2eSfHAuiUbulCW5wxwq0DDS0vi0Mroatwr7PqwKbN
	 XTn7Um5O8zAbP6owkQhqDgyYo4MU3Yej/1N0DMUf0/b+4VdHASYkkUmZhT0bytuZEU
	 BveIB0hfrWZjR6LDKJrl8nszVER7fw0j8b6zuVkY5pgIuQJ/WJa5fRZZbamW/ocTLN
	 F4v/Vvo776E/f7iW+6/w4qIPmpOlUipR5f/dPhKzI5kNLaYL1NStBTUlhPU6/9sL+U
	 t0Rtap1zlWBb9LxjB9mKfzxwuzo4Y25Pc2MM3DZLheEg+I+KpNcFDYc6jrIClK7zPi
	 xO9XEIPUMY0Ow==
From: Sumit Garg <sumit.garg@kernel.org>
To: andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
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
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v7 05/15] remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
Date: Fri, 22 May 2026 17:29:26 +0530
Message-ID: <20260522115936.201208-6-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522115936.201208-1-sumit.garg@kernel.org>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-36808-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0EC825B3ADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Since qcom_q6v5_pas depends on MDT loader for PAS firmware loading, it
has to be switched over to generic PAS APIs in this commit to avoid any
build issues.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c  | 51 +++++++++++++++--------------
 drivers/soc/qcom/mdt_loader.c       | 12 +++----
 include/linux/soc/qcom/mdt_loader.h |  6 ++--
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index da27d1d3c9da..847249c28c1b 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
@@ -118,8 +119,8 @@ struct qcom_pas {
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
 
-	struct qcom_scm_pas_context *pas_ctx;
-	struct qcom_scm_pas_context *dtb_pas_ctx;
+	struct qcom_pas_context *pas_ctx;
+	struct qcom_pas_context *dtb_pas_ctx;
 };
 
 static void qcom_pas_segment_dump(struct rproc *rproc,
@@ -196,7 +197,7 @@ static int qcom_pas_shutdown_poll_decrypt(struct qcom_pas *pas)
 
 	do {
 		msleep(QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS);
-		ret = qcom_scm_pas_shutdown(pas->pas_id);
+		ret = qcom_pas_shutdown(pas->pas_id);
 	} while (ret == -EINVAL && --retry_num);
 
 	return ret;
@@ -212,9 +213,9 @@ static int qcom_pas_unprepare(struct rproc *rproc)
 	 * auth_and_reset() was successful, but in other cases clean it up
 	 * here.
 	 */
-	qcom_scm_pas_metadata_release(pas->pas_ctx);
+	qcom_pas_metadata_release(pas->pas_ctx);
 	if (pas->dtb_pas_id)
-		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+		qcom_pas_metadata_release(pas->dtb_pas_ctx);
 
 	return 0;
 }
@@ -228,9 +229,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 	pas->firmware = fw;
 
 	if (pas->lite_pas_id)
-		qcom_scm_pas_shutdown(pas->lite_pas_id);
+		qcom_pas_shutdown(pas->lite_pas_id);
 	if (pas->lite_dtb_pas_id)
-		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
+		qcom_pas_shutdown(pas->lite_dtb_pas_id);
 
 	if (pas->dtb_pas_id) {
 		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
@@ -250,7 +251,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 
 release_dtb_metadata:
-	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+	qcom_pas_metadata_release(pas->dtb_pas_ctx);
 	release_firmware(pas->dtb_firmware);
 
 	return ret;
@@ -310,7 +311,7 @@ static int qcom_pas_start(struct rproc *rproc)
 		if (ret)
 			goto disable_px_supply;
 
-		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
+		ret = qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
 		if (ret) {
 			dev_err(pas->dev,
 				"failed to authenticate dtb image and release reset\n");
@@ -329,7 +330,7 @@ static int qcom_pas_start(struct rproc *rproc)
 	if (ret)
 		goto release_pas_metadata;
 
-	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
+	ret = qcom_pas_prepare_and_auth_reset(pas->pas_ctx);
 	if (ret) {
 		dev_err(pas->dev,
 			"failed to authenticate image and release reset\n");
@@ -339,13 +340,13 @@ static int qcom_pas_start(struct rproc *rproc)
 	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
 	if (ret == -ETIMEDOUT) {
 		dev_err(pas->dev, "start timed out\n");
-		qcom_scm_pas_shutdown(pas->pas_id);
+		qcom_pas_shutdown(pas->pas_id);
 		goto unmap_carveout;
 	}
 
-	qcom_scm_pas_metadata_release(pas->pas_ctx);
+	qcom_pas_metadata_release(pas->pas_ctx);
 	if (pas->dtb_pas_id)
-		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+		qcom_pas_metadata_release(pas->dtb_pas_ctx);
 
 	/* firmware is used to pass reference from qcom_pas_start(), drop it now */
 	pas->firmware = NULL;
@@ -355,9 +356,9 @@ static int qcom_pas_start(struct rproc *rproc)
 unmap_carveout:
 	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
 release_pas_metadata:
-	qcom_scm_pas_metadata_release(pas->pas_ctx);
+	qcom_pas_metadata_release(pas->pas_ctx);
 	if (pas->dtb_pas_id)
-		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+		qcom_pas_metadata_release(pas->dtb_pas_ctx);
 
 unmap_dtb_carveout:
 	if (pas->dtb_pas_id)
@@ -406,7 +407,7 @@ static int qcom_pas_stop(struct rproc *rproc)
 	if (ret == -ETIMEDOUT)
 		dev_err(pas->dev, "timed out on wait\n");
 
-	ret = qcom_scm_pas_shutdown(pas->pas_id);
+	ret = qcom_pas_shutdown(pas->pas_id);
 	if (ret && pas->decrypt_shutdown)
 		ret = qcom_pas_shutdown_poll_decrypt(pas);
 
@@ -414,7 +415,7 @@ static int qcom_pas_stop(struct rproc *rproc)
 		dev_err(pas->dev, "failed to shutdown: %d\n", ret);
 
 	if (pas->dtb_pas_id) {
-		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
+		ret = qcom_pas_shutdown(pas->dtb_pas_id);
 		if (ret)
 			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
 
@@ -484,11 +485,11 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
 	 *
 	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
 	 * or not and if it is not having then we pass NULL and zero as input resource
-	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
+	 * table pointer and size respectively to the argument of qcom_pas_get_rsc_table()
 	 * and this is even true for Qualcomm remote processor who does follow remoteproc
 	 * framework.
 	 */
-	output_rt = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
+	output_rt = qcom_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
 	ret = IS_ERR(output_rt) ? PTR_ERR(output_rt) : 0;
 	if (ret) {
 		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
@@ -746,7 +747,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	if (!qcom_scm_is_available())
+	if (!qcom_pas_is_available())
 		return -EPROBE_DEFER;
 
 	fw_name = desc->firmware_name;
@@ -838,16 +839,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
 
 	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
 
-	pas->pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
-						       pas->mem_phys, pas->mem_size);
+	pas->pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
+						   pas->mem_phys, pas->mem_size);
 	if (IS_ERR(pas->pas_ctx)) {
 		ret = PTR_ERR(pas->pas_ctx);
 		goto remove_ssr_sysmon;
 	}
 
-	pas->dtb_pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb_pas_id,
-							   pas->dtb_mem_phys,
-							   pas->dtb_mem_size);
+	pas->dtb_pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas_id,
+						       pas->dtb_mem_phys,
+						       pas->dtb_mem_size);
 	if (IS_ERR(pas->dtb_pas_ctx)) {
 		ret = PTR_ERR(pas->dtb_pas_ctx);
 		goto remove_ssr_sysmon;
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


