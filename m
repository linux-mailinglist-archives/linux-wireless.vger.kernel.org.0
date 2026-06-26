Return-Path: <linux-wireless+bounces-38173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D6gQAIiAPmpTHAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 15:37:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB36CD7D3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 15:37:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eQgLoypa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38173-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38173-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED933077152
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72F3F65FC;
	Fri, 26 Jun 2026 13:35:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E683F6600;
	Fri, 26 Jun 2026 13:35:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480950; cv=none; b=mh3KDQWLh/pJCgtFObpjTYdM522jlHHc2u7xF13D47j5H6YWbukILlpQ7MUigIK/84JQ5Uwj6MAH96JsmqHgu/IKtqed6lgxPIgE0h9CmsFe8zWWgKysgnxnycuF04AYXU19yrojItESvIwoic2Cvr61j4dDBc5HG0BFkpRtMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480950; c=relaxed/simple;
	bh=CE2EppqGdEe2YE5lfeqBgXYAsWGPVuizmQHhUNyx3hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4lh3U6ZHxBFpzUT/oq9ubshqIo4g9Jy3XJyZDS4z8K1ATOj2PUW5Z2SEyNeqWhtYfEKMyoVZtRbnS/TX62U0X31nUcrDcgyZPEZoeMBTsQk91EGNNnIWI+qOwxYyglGXY26W45de4yyE92rxQOHwZAqPuMuqnQQ0oby4PZIxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQgLoypa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F07A1F00A3A;
	Fri, 26 Jun 2026 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480948;
	bh=/5pxdsYPVGsLK+VsH2JvDdRJHBRJLp5Yq9vECrKlrEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQgLoypa+pxfVN0WXrgW/UePE054sS0kDBbJTOhv+lJDhlyUtCL+JyPAvjx3UboL1
	 82bKMmYgG2AY/OYkdA//qnJASoASFa8Rc59yntCZVfGFl+o8dZEO8lKL2nzWEv8AnZ
	 WSWRkCb81wLu1wUqn2HOUnEwLa9UiTq1emJYijQsc3RlXnctN6DpH2TlfJ+pICIPdo
	 jzNKbZDTpGZP0XxFRBHLVzjjgM9eJvA2n5EKomfQ2Wq2MGWdy2Y4X6v8fSsT1230p6
	 Obluj5tafkQhf901UvP033uvnMPV244YqC5vmGqDOUABO8g0ZpzK/gYWWg64fHqEhX
	 e1vjx9qTHOHLw==
From: Sumit Garg <sumit.garg@kernel.org>
To: andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
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
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
Date: Fri, 26 Jun 2026 19:04:21 +0530
Message-ID: <20260626133440.692849-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626133440.692849-1-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38173-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qua
 lcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FCB36CD7D3

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Qcom platforms has the legacy of using non-standard SCM calls
splintered over the various kernel drivers. These SCM calls aren't
compliant with the standard SMC calling conventions which is a
prerequisite to enable migration to the FF-A specifications from Arm.

OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
support these non-standard SCM calls. And even for newer architectures
using S-EL2 with Hafnium support, QTEE won't be able to support SCM
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

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/Kconfig          |   8 +
 drivers/firmware/qcom/Makefile         |   1 +
 drivers/firmware/qcom/qcom_pas.c       | 291 +++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_pas.h       |  50 +++++
 include/linux/firmware/qcom/qcom_pas.h |  43 ++++
 5 files changed, 393 insertions(+)
 create mode 100644 drivers/firmware/qcom/qcom_pas.c
 create mode 100644 drivers/firmware/qcom/qcom_pas.h
 create mode 100644 include/linux/firmware/qcom/qcom_pas.h

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index b477d54b495a..9f66cc774508 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -6,6 +6,14 @@
 
 menu "Qualcomm firmware drivers"
 
+config QCOM_PAS
+	tristate "Qualcomm generic PAS interface driver"
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
index 000000000000..bc6c42f2b3c6
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_pas.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
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
+static struct qcom_pas_ops *ops_ptr;
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
+	if (!ops_ptr)
+		return -ENODEV;
+
+	return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_init_image);
+
+/**
+ * qcom_pas_metadata_release() - release metadata context
+ * @ctx:	pas context
+ */
+void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
+{
+	if (!ops_ptr || !ctx || !ctx->ptr)
+		return;
+
+	ops_ptr->metadata_release(ops_ptr->dev, ctx);
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
+	if (!ops_ptr)
+		return -ENODEV;
+
+	return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
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
+	if (!ops_ptr)
+		return ERR_PTR(-ENODEV);
+	if (!ctx)
+		return ERR_PTR(-EINVAL);
+
+	return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
+				      input_rt_size, output_rt_size);
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
+	if (!ops_ptr)
+		return -ENODEV;
+
+	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
+
+/**
+ * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
+ *				       remote processor
+ *
+ * @ctx:	Context saved during call to devm_qcom_pas_context_alloc()
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
+	if (!ops_ptr)
+		return -ENODEV;
+	if (!ctx)
+		return -EINVAL;
+
+	return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
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
+	if (!ops_ptr)
+		return -ENODEV;
+
+	return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
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
+	if (!ops_ptr)
+		return -ENODEV;
+
+	return ops_ptr->shutdown(ops_ptr->dev, pas_id);
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
+	if (!ops_ptr)
+		return false;
+
+	return ops_ptr->supported(ops_ptr->dev, pas_id);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_supported);
+
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
+void qcom_pas_ops_register(struct qcom_pas_ops *ops)
+{
+	if (!qcom_pas_is_available())
+		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
+		smp_store_release(&ops_ptr, ops);
+	else
+		pr_err("qcom_pas: ops already registered by %s\n",
+		       ops_ptr->drv_name);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
+
+void qcom_pas_ops_unregister(void)
+{
+	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
+	smp_store_release(&ops_ptr, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm generic TZ PAS driver");
diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
new file mode 100644
index 000000000000..8643e2760602
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_pas.h
@@ -0,0 +1,50 @@
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
+	int (*init_image)(struct device *dev, u32 pas_id, const void *metadata,
+			  size_t size, struct qcom_pas_context *ctx);
+	int (*mem_setup)(struct device *dev, u32 pas_id, phys_addr_t addr,
+			 phys_addr_t size);
+	void *(*get_rsc_table)(struct device *dev, struct qcom_pas_context *ctx,
+			       void *input_rt, size_t input_rt_size,
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
index 000000000000..65b1c9564458
--- /dev/null
+++ b/include/linux/firmware/qcom/qcom_pas.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
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
2.53.0


