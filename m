Return-Path: <linux-wireless+bounces-33052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LMdJzBdsmkZMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:29:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B507C26DAD7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3B1B3014F59
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36638238A;
	Thu, 12 Mar 2026 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq9rVoeP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539F317170;
	Thu, 12 Mar 2026 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296932; cv=none; b=fKb29TWtTXQpfozJxtA5+ToIloZlYnXCig4TzAzYfT0snQEpBgC3AxGrQTAGPAJnAgbScSI3bdxxa+3LHZemEgnZREWBR09hwM3uKYMcygEIIgt/euPYS4GRBEQrW92wCtvOfXYcomsxSBDFGX+a5GXs3BJTV2yjdNebVeZJ3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296932; c=relaxed/simple;
	bh=3KEoOVG76eAU86T1OlKTBlOP2+juKXkWft8EkAGw4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq0+tjg9XrLX5BVuijNEt7tXt614S0Bw5YzW7/OdZ6xd0qktu68Ri9t4acD5YURjUGrS5tOPBJFSbswUo06ELO894YabUx8kr461Nt2OFTrXyqsQxerrwnXSzOQ3pnbPtkx6ImSip7t8bP9x4P6jNTNGTU4qgtCFLtd/3psyYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq9rVoeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9308AC4CEF7;
	Thu, 12 Mar 2026 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773296932;
	bh=3KEoOVG76eAU86T1OlKTBlOP2+juKXkWft8EkAGw4Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tq9rVoePVwddpg6WPDNCfFHyAgzsMLHRtcxOaobNhyQRYTnxYChH7McuATKc6Ckzj
	 RVWpb4cMpJDBZ0bZj1AMpU/4/hPtB/gP+cEfcs9OFtPfU5HYRpzvvOSUyEE0Vfnv/X
	 uo45YL90GqAxZJbSDclCaWutgRde/HyqDMMa0HhS9Q2F2Ea2gAP2+rUfXXYlHYGOEB
	 Rirn8MnyNkMMUEtf6vX/ahjkjv6F1nnMJBhtKCOOx0EIHmu7vmQA7YkvO0kO8iwYrn
	 qKHWruhLNzRRO4ukAzvI72pE1luvAehtRXsSRppqx5Zh3VHJuP/b0D4rzk+lccW3xg
	 8PKHSNYeEP1zQ==
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
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
Date: Thu, 12 Mar 2026 11:57:43 +0530
Message-ID: <20260312062756.694390-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312062756.694390-1-sumit.garg@kernel.org>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-33052-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B507C26DAD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Qcom platforms has the legacy of using non-standard SCM calls
splintered over the various kernel drivers. These SCM calls aren't
compliant with the standard SMC calling conventions which is a
prerequisite to enable migration to the FF-A specifications from Arm.

OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
support these non-standard SCM calls. And even for newer architectures
with S-EL2 and Hafnium support, QTEE won't be able to support SCM
calls either with FF-A requirements coming in. And with both OP-TEE
and QTEE drivers well integrated in the TEE subsystem, it makes further
sense to reuse the TEE bus client drivers infrastructure.

The added benefit of TEE bus infrastructure is that there is support
for discoverable/enumerable services. With that client drivers don't
have to manually invoke a special SCM call to know the service status.

So enable the generic Peripheral Authentication Service (PAS) provided
by the firmware. It acts as the common layer with different TZ
backends plugged in whether it's an SCM implementation or a proper
TEE bus based PAS service implementation.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/Kconfig          |   8 +
 drivers/firmware/qcom/Makefile         |   1 +
 drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_pas.h       |  53 +++++
 include/linux/firmware/qcom/qcom_pas.h |  41 ++++
 5 files changed, 401 insertions(+)
 create mode 100644 drivers/firmware/qcom/qcom_pas.c
 create mode 100644 drivers/firmware/qcom/qcom_pas.h
 create mode 100644 include/linux/firmware/qcom/qcom_pas.h

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index b477d54b495a..8653639d06db 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -6,6 +6,14 @@
 
 menu "Qualcomm firmware drivers"
 
+config QCOM_PAS
+	tristate
+	help
+	  Enable the generic Peripheral Authentication Service (PAS) provided
+	  by the firmware. It acts as the common layer with different TZ
+	  backends plugged in whether it's an SCM implementation or a proper
+	  TEE bus based PAS service implementation.
+
 config QCOM_SCM
 	select QCOM_TZMEM
 	tristate
diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
index 0be40a1abc13..dc5ab45f906a 100644
--- a/drivers/firmware/qcom/Makefile
+++ b/drivers/firmware/qcom/Makefile
@@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
+obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
new file mode 100644
index 000000000000..beb1bae55546
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device/devres.h>
+#include <linux/firmware/qcom/qcom_pas.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "qcom_pas.h"
+
+struct qcom_pas_ops *ops_ptr;
+
+/**
+ * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
+ *				   context for a given peripheral
+ *
+ * PAS context is device-resource managed, so the caller does not need
+ * to worry about freeing the context memory.
+ *
+ * @dev:	  PAS firmware device
+ * @pas_id:	  peripheral authentication service id
+ * @mem_phys:	  Subsystem reserve memory start address
+ * @mem_size:	  Subsystem reserve memory size
+ *
+ * Return: The new PAS context, or ERR_PTR() on failure.
+ */
+struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
+						     u32 pas_id,
+						     phys_addr_t mem_phys,
+						     size_t mem_size)
+{
+	struct qcom_pas_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->pas_id = pas_id;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(devm_qcom_pas_context_alloc);
+
+/**
+ * qcom_pas_init_image() - Initialize peripheral authentication service state
+ *			   machine for a given peripheral, using the metadata
+ * @pas_id:	peripheral authentication service id
+ * @metadata:	pointer to memory containing ELF header, program header table
+ *		and optional blob of data used for authenticating the metadata
+ *		and the rest of the firmware
+ * @size:	size of the metadata
+ * @ctx:	optional pas context
+ *
+ * Return: 0 on success.
+ *
+ * Upon successful return, the PAS metadata context (@ctx) will be used to
+ * track the metadata allocation, this needs to be released by invoking
+ * qcom_pas_metadata_release() by the caller.
+ */
+int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
+			struct qcom_pas_context *ctx)
+{
+	if (ops_ptr)
+		return ops_ptr->init_image(ops_ptr->dev, pas_id,
+					   metadata, size, ctx);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_init_image);
+
+/**
+ * qcom_pas_metadata_release() - release metadata context
+ * @ctx:	pas context
+ */
+void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
+{
+	if (!ctx || !ctx->ptr)
+		return;
+
+	if (ops_ptr)
+		ops_ptr->metadata_release(ops_ptr->dev, ctx);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
+
+/**
+ * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
+ *			  for firmware loading
+ * @pas_id:	peripheral authentication service id
+ * @addr:	start address of memory area to prepare
+ * @size:	size of the memory area to prepare
+ *
+ * Return: 0 on success.
+ */
+int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
+{
+	if (ops_ptr)
+		return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_mem_setup);
+
+/**
+ * qcom_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
+ *			      for a given peripheral.
+ *
+ * Qualcomm remote processor may rely on both static and dynamic resources for
+ * its functionality. Static resources typically refer to memory-mapped
+ * addresses required by the subsystem and are often embedded within the
+ * firmware binary and dynamic resources, such as shared memory in DDR etc.,
+ * are determined at runtime during the boot process.
+ *
+ * On Qualcomm Technologies devices, it's possible that static resources are
+ * not embedded in the firmware binary and instead are provided by TrustZone.
+ * However, dynamic resources are always expected to come from TrustZone. This
+ * indicates that for Qualcomm devices, all resources (static and dynamic) will
+ * be provided by TrustZone PAS service.
+ *
+ * If the remote processor firmware binary does contain static resources, they
+ * should be passed in input_rt. These will be forwarded to TrustZone for
+ * authentication. TrustZone will then append the dynamic resources and return
+ * the complete resource table in output_rt_tzm.
+ *
+ * If the remote processor firmware binary does not include a resource table,
+ * the caller of this function should set input_rt as NULL and input_rt_size
+ * as zero respectively.
+ *
+ * More about documentation on resource table data structures can be found in
+ * include/linux/remoteproc.h
+ *
+ * @ctx:	    PAS context
+ * @pas_id:	    peripheral authentication service id
+ * @input_rt:       resource table buffer which is present in firmware binary
+ * @input_rt_size:  size of the resource table present in firmware binary
+ * @output_rt_size: TrustZone expects caller should pass worst case size for
+ *		    the output_rt_tzm.
+ *
+ * Return:
+ *  On success, returns a pointer to the allocated buffer containing the final
+ *  resource table and output_rt_size will have actual resource table size from
+ *  TrustZone. The caller is responsible for freeing the buffer. On failure,
+ *  returns ERR_PTR(-errno).
+ */
+struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
+					      void *input_rt,
+					      size_t input_rt_size,
+					      size_t *output_rt_size)
+{
+	if (ops_ptr)
+		return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
+					      input_rt_size, output_rt_size);
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
+
+/**
+ * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
+ *			       and reset the remote processor
+ * @pas_id:	peripheral authentication service id
+ *
+ * Return: 0 on success.
+ */
+int qcom_pas_auth_and_reset(u32 pas_id)
+{
+	if (ops_ptr)
+		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
+
+/**
+ * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
+ *				       remote processor
+ *
+ * @ctx:	Context saved during call to qcom_scm_pas_context_init()
+ *
+ * This function performs the necessary steps to prepare a PAS subsystem,
+ * authenticate it using the provided metadata, and initiate a reset sequence.
+ *
+ * It should be used when Linux is in control setting up the IOMMU hardware
+ * for remote subsystem during secure firmware loading processes. The
+ * preparation step sets up a shmbridge over the firmware memory before
+ * TrustZone accesses the firmware memory region for authentication. The
+ * authentication step verifies the integrity and authenticity of the firmware
+ * or configuration using secure metadata. Finally, the reset step ensures the
+ * subsystem starts in a clean and sane state.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx)
+{
+	if (ops_ptr)
+		return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_prepare_and_auth_reset);
+
+/**
+ * qcom_pas_set_remote_state() - Set the remote processor state
+ * @state:	peripheral state
+ * @pas_id:	peripheral authentication service id
+ *
+ * Return: 0 on success.
+ */
+int qcom_pas_set_remote_state(u32 state, u32 pas_id)
+{
+	if (ops_ptr)
+		return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_set_remote_state);
+
+/**
+ * qcom_pas_shutdown() - Shut down the remote processor
+ * @pas_id:	peripheral authentication service id
+ *
+ * Return: 0 on success.
+ */
+int qcom_pas_shutdown(u32 pas_id)
+{
+	if (ops_ptr)
+		return ops_ptr->shutdown(ops_ptr->dev, pas_id);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
+
+/**
+ * qcom_pas_supported() - Check if the peripheral authentication service is
+ *			  available for the given peripheral
+ * @pas_id:	peripheral authentication service id
+ *
+ * Return: true if PAS is supported for this peripheral, otherwise false.
+ */
+bool qcom_pas_supported(u32 pas_id)
+{
+	if (ops_ptr)
+		return ops_ptr->supported(ops_ptr->dev, pas_id);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(qcom_pas_supported);
+
+/**
+ * qcom_pas_is_available() - Check for PAS service
+ *
+ * Return: true on success.
+ */
+bool qcom_pas_is_available(void)
+{
+	/*
+	 * The barrier for ops_ptr is intended to synchronize the data stores
+	 * for the ops data structure when client drivers are in parallel
+	 * checking for PAS service availability.
+	 *
+	 * Once the PAS backend becomes available, it is allowed for multiple
+	 * threads to enter TZ for parallel bringup of co-processors during
+	 * boot.
+	 */
+	return !!smp_load_acquire(&ops_ptr);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_is_available);
+
+/**
+ * qcom_pas_ops_register() - Register PAS service ops
+ * @ops:	PAS service ops pointer
+ */
+void qcom_pas_ops_register(struct qcom_pas_ops *ops)
+{
+	if (!qcom_pas_is_available())
+		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
+		smp_store_release(&ops_ptr, ops);
+	else
+		pr_err("qcom_pas: ops already registered\n");
+}
+EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
+
+/**
+ * qcom_pas_ops_unregister() - Unregister PAS service ops
+ */
+void qcom_pas_ops_unregister(void)
+{
+	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
+	smp_store_release(&ops_ptr, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm common TZ PAS driver");
diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
new file mode 100644
index 000000000000..4ebed22178f8
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_pas.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QCOM_PAS_INT_H
+#define __QCOM_PAS_INT_H
+
+struct device;
+
+/**
+ * struct qcom_pas_ops - Qcom Peripheral Authentication Service (PAS) ops
+ * @drv_name:			PAS driver name.
+ * @dev:			PAS device pointer.
+ * @supported:			Peripheral supported callback.
+ * @init_image:			Peripheral image initialization callback.
+ * @mem_setup:			Peripheral memory setup callback.
+ * @get_rsc_table:		Peripheral get resource table callback.
+ * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
+ *				reset callback.
+ * @auth_and_reset:		Peripheral firmware authentication and reset
+ *				callback.
+ * @set_remote_state:		Peripheral set remote state callback.
+ * @shutdown:			Peripheral shutdown callback.
+ * @metadata_release:		Image metadata release callback.
+ */
+struct qcom_pas_ops {
+	const char *drv_name;
+	struct device *dev;
+	bool (*supported)(struct device *dev, u32 pas_id);
+	int (*init_image)(struct device *dev, u32 pas_id,
+			  const void *metadata, size_t size,
+			  struct qcom_pas_context *ctx);
+	int (*mem_setup)(struct device *dev, u32 pas_id,
+			 phys_addr_t addr, phys_addr_t size);
+	void *(*get_rsc_table)(struct device *dev,
+			       struct qcom_pas_context *ctx,
+			       void *input_rt,
+			       size_t input_rt_size,
+			       size_t *output_rt_size);
+	int (*prepare_and_auth_reset)(struct device *dev,
+				      struct qcom_pas_context *ctx);
+	int (*auth_and_reset)(struct device *dev, u32 pas_id);
+	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
+	int (*shutdown)(struct device *dev, u32 pas_id);
+	void (*metadata_release)(struct device *dev,
+				 struct qcom_pas_context *ctx);
+};
+
+void qcom_pas_ops_register(struct qcom_pas_ops *ops);
+void qcom_pas_ops_unregister(void);
+
+#endif /* __QCOM_PAS_INT_H */
diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
new file mode 100644
index 000000000000..ef7328ecfa47
--- /dev/null
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QCOM_PAS_H
+#define __QCOM_PAS_H
+
+#include <linux/err.h>
+#include <linux/types.h>
+
+struct qcom_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	void *ptr;
+	dma_addr_t phys;
+	ssize_t size;
+	bool use_tzmem;
+};
+
+bool qcom_pas_is_available(void);
+struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
+						     u32 pas_id,
+						     phys_addr_t mem_phys,
+						     size_t mem_size);
+int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
+			struct qcom_pas_context *ctx);
+struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
+					      void *input_rt, size_t input_rt_size,
+					      size_t *output_rt_size);
+int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
+int qcom_pas_auth_and_reset(u32 pas_id);
+int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
+int qcom_pas_set_remote_state(u32 state, u32 pas_id);
+int qcom_pas_shutdown(u32 pas_id);
+bool qcom_pas_supported(u32 pas_id);
+void qcom_pas_metadata_release(struct qcom_pas_context *ctx);
+
+#endif /* __QCOM_PAS_H */
-- 
2.51.0


