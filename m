Return-Path: <linux-wireless+bounces-38175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E447KyCBPmqLHAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 15:39:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298326CD878
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 15:39:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dyBQUmX0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38175-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38175-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0424301496A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D973F6C25;
	Fri, 26 Jun 2026 13:36:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F93F58F7;
	Fri, 26 Jun 2026 13:36:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481016; cv=none; b=fZUSQc45rpNqQExeJEUX8aQ/jtlTU/tnU+SW+5jx3WaQ4QkmGYYpTu3CzRKQskH2/mWgXVtAyXYz6IzpUJ7lF8BRCT33WgmWTKpy3Fso0bkGrC8Sp0O8Tvh2VidEsdwpw1+6whvYs/1Vjg8j9YVSuqYN4ZPWPfAHQ7AjnYN0zw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481016; c=relaxed/simple;
	bh=vII9zRVy/c/ZWOQmkFaMyQZmXigryYxEhu1/VztBp1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGic3DwJ5cLhuXpuu6rvaGADA9fqKiDmZ2kEFBRAZ+OhzyXGAg6B3x4YRwoBwll3QD9Vnq15sNWHyN2JpM+0dM2DwpYszlOOvZn/iDBS7NRKkMqaLjo9o4XvvtW7ciHbVNsZYuXmqLiaoSfxSHdeznOFFlc3ouS+EF9JUiZXNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyBQUmX0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692531F00A3A;
	Fri, 26 Jun 2026 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782481014;
	bh=C3tnhErcqfUgRNenAhCDvQqdn7GnFd0QafkAZPTxngg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyBQUmX0hWBVOTHptp89mhDrMadkCSxarT4ylLrycnhH6KUuHErl9qWgf7KXuarzZ
	 UA0C4+oN30Tc0fL9twRI0+9KI3v136nsmzwnqpaVuwuuEszbo1noskmZ1wSY45yc4Y
	 Rh1GLwJOdu4iooflLe9G7g7YknViqbrEgX2+qABUyMVLoKUHXTzi/JLNTGjsa7Du23
	 vHSZEu/ZjYCol3cEZ3pG2IL04yZNnj/XvXkaIV+jy9QohlhZkfUw1lkSfUYcuo44fO
	 K/lypQ5gNj2V3BBJuFRHc7zz2P0bqwOf3RniesY5MENUtZOAp+/19aJfgOlyA3g5eJ
	 5f8KwQJQ3rH0g==
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
Subject: [PATCH v8 03/14] firmware: qcom: Add a PAS TEE service
Date: Fri, 26 Jun 2026 19:04:23 +0530
Message-ID: <20260626133440.692849-4-sumit.garg@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-38175-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qcom_pas_ops_tee.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 298326CD878

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Add support for Peripheral Authentication Service (PAS) driver based
on TEE bus with OP-TEE providing the backend PAS service implementation.

The TEE PAS service ABI is designed to be extensible with additional API
as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
extensions of the PAS service needed while still maintaining backwards
compatibility.

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/firmware/qcom/Kconfig        |  10 +
 drivers/firmware/qcom/Makefile       |   1 +
 drivers/firmware/qcom/qcom_pas_tee.c | 477 +++++++++++++++++++++++++++
 3 files changed, 488 insertions(+)
 create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 732a0bff7d9f..b851bcc592be 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -14,6 +14,16 @@ config QCOM_PAS
 	  backends plugged in whether it's an SCM implementation or a proper
 	  TEE bus based PAS service implementation.
 
+config QCOM_PAS_TEE
+	tristate "Qualcomm PAS TEE interface driver"
+	select QCOM_PAS
+	depends on TEE
+	depends on !CPU_BIG_ENDIAN
+	default m if ARCH_QCOM
+	help
+	  Enable the generic Peripheral Authentication Service (PAS) provided
+	  by the firmware TEE implementation as the backend.
+
 config QCOM_SCM
 	tristate "Qualcomm PAS SCM interface driver"
 	select QCOM_PAS
diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
index dc5ab45f906a..48801d18f37b 100644
--- a/drivers/firmware/qcom/Makefile
+++ b/drivers/firmware/qcom/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
 obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
+obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
new file mode 100644
index 000000000000..a2ba3af05a50
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_pas_tee.c
@@ -0,0 +1,477 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/firmware/qcom/qcom_pas.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+
+#include "qcom_pas.h"
+
+/*
+ * Peripheral Authentication Service (PAS) supported.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ */
+#define TA_QCOM_PAS_IS_SUPPORTED		1
+
+/*
+ * PAS capabilities.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ * [out] params[1].value.a:	PAS capability flags
+ */
+#define TA_QCOM_PAS_CAPABILITIES		2
+
+/*
+ * PAS image initialization.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ * [in]  params[1].memref:	Loadable firmware metadata
+ */
+#define TA_QCOM_PAS_INIT_IMAGE			3
+
+/*
+ * PAS memory setup.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ * [in]  params[0].value.b:	Relocatable firmware size
+ * [in]  params[1].value.a:	32bit LSB relocatable firmware memory address
+ * [in]  params[1].value.b:	32bit MSB relocatable firmware memory address
+ */
+#define TA_QCOM_PAS_MEM_SETUP			4
+
+/*
+ * PAS get resource table.
+ *
+ * [in]     params[0].value.a:	Unique 32bit remote processor identifier
+ * [inout]  params[1].memref:	Resource table config
+ */
+#define TA_QCOM_PAS_GET_RESOURCE_TABLE		5
+
+/*
+ * PAS image authentication and co-processor reset.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ * [in]  params[0].value.b:	Firmware size
+ * [in]  params[1].value.a:	32bit LSB firmware memory address
+ * [in]  params[1].value.b:	32bit MSB firmware memory address
+ * [in]  params[2].memref:	Optional fw memory space shared/lent
+ */
+#define TA_QCOM_PAS_AUTH_AND_RESET		6
+
+/*
+ * PAS co-processor set suspend/resume state.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ * [in]  params[0].value.b:	Co-processor state identifier
+ */
+#define TA_QCOM_PAS_SET_REMOTE_STATE		7
+
+/*
+ * PAS co-processor shutdown.
+ *
+ * [in]  params[0].value.a:	Unique 32bit remote processor identifier
+ */
+#define TA_QCOM_PAS_SHUTDOWN			8
+
+#define TEE_NUM_PARAMS				4
+
+/**
+ * struct qcom_pas_tee_private - PAS service private data
+ * @dev:		PAS service device.
+ * @ctx:		TEE context handler.
+ * @session_id:		PAS TA session identifier.
+ */
+struct qcom_pas_tee_private {
+	struct device *dev;
+	struct tee_context *ctx;
+	u32 session_id;
+};
+
+static bool qcom_pas_tee_supported(struct device *dev, u32 pas_id)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_IS_SUPPORTED,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = pas_id
+		}
+	};
+	int ret;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS not supported, pas_id: %d, ret: %d, err: 0x%x\n",
+			pas_id, ret, inv_arg.ret);
+		return false;
+	}
+
+	return true;
+}
+
+static int qcom_pas_tee_init_image(struct device *dev, u32 pas_id,
+				   const void *metadata, size_t size,
+				   struct qcom_pas_context *ctx)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_INIT_IMAGE,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = pas_id
+		},
+		[1] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		}
+	};
+	struct tee_shm *mdata_shm;
+	u8 *mdata_buf = NULL;
+	int ret;
+
+	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);
+	if (IS_ERR(mdata_shm)) {
+		dev_err(dev, "mdata_shm allocation failed\n");
+		return PTR_ERR(mdata_shm);
+	}
+
+	mdata_buf = tee_shm_get_va(mdata_shm, 0);
+	if (IS_ERR(mdata_buf)) {
+		dev_err(dev, "mdata_buf get VA failed\n");
+		tee_shm_free(mdata_shm);
+		return PTR_ERR(mdata_buf);
+	}
+	memcpy(mdata_buf, metadata, size);
+
+	param[1].u.memref.shm = mdata_shm;
+	param[1].u.memref.size = size;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS init image failed, pas_id: %d, ret: %d, err: 0x%x\n",
+			pas_id, ret, inv_arg.ret);
+		tee_shm_free(mdata_shm);
+		return ret ?: -EINVAL;
+	}
+
+	if (ctx)
+		ctx->ptr = (void *)mdata_shm;
+	else
+		tee_shm_free(mdata_shm);
+
+	return ret;
+}
+
+static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
+				  phys_addr_t addr, phys_addr_t size)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_MEM_SETUP,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = pas_id,
+			.u.value.b = size,
+		},
+		[1] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = lower_32_bits(addr),
+			.u.value.b = upper_32_bits(addr),
+		}
+	};
+	int ret;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
+			pas_id, ret, inv_arg.ret);
+		return ret ?: -EINVAL;
+	}
+
+	return ret;
+}
+
+DEFINE_FREE(shm_free, struct tee_shm *, tee_shm_free(_T))
+
+static void *qcom_pas_tee_get_rsc_table(struct device *dev,
+					struct qcom_pas_context *ctx,
+					void *input_rt, size_t input_rt_size,
+					size_t *output_rt_size)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_GET_RESOURCE_TABLE,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = ctx->pas_id,
+		},
+		[1] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
+			.u.memref.size = input_rt_size,
+		}
+	};
+	void *rt_buf = NULL;
+	int ret;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
+			ctx->pas_id, ret, inv_arg.ret);
+		return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
+	}
+
+	if (param[1].u.memref.size) {
+		struct tee_shm *rt_shm __free(shm_free) =
+			tee_shm_alloc_kernel_buf(data->ctx,
+						 param[1].u.memref.size);
+		void *rt_shm_va;
+
+		if (IS_ERR_OR_NULL(rt_shm)) {
+			dev_err(dev, "rt_shm allocation failed\n");
+			rt_shm = NULL;
+			return ERR_PTR(-ENOMEM);
+		}
+
+		rt_shm_va = tee_shm_get_va(rt_shm, 0);
+		if (IS_ERR(rt_shm_va)) {
+			dev_err(dev, "rt_shm get VA failed\n");
+			return ERR_CAST(rt_shm_va);
+		}
+		memcpy(rt_shm_va, input_rt, input_rt_size);
+
+		param[1].u.memref.shm = rt_shm;
+		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+		if (ret < 0 || inv_arg.ret != 0) {
+			dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
+				ctx->pas_id, ret, inv_arg.ret);
+			return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
+		}
+
+		if (param[1].u.memref.size) {
+			*output_rt_size = param[1].u.memref.size;
+			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
+			if (!rt_buf)
+				return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	return rt_buf;
+}
+
+static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
+					 phys_addr_t mem_phys, size_t mem_size)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_AUTH_AND_RESET,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = pas_id,
+			.u.value.b = mem_size,
+		},
+		[1] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = lower_32_bits(mem_phys),
+			.u.value.b = upper_32_bits(mem_phys),
+		},
+		/* Reserved for fw memory space to be shared or lent */
+		[2] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		}
+	};
+	int ret;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS auth reset failed, pas_id: %d, ret: %d, err: 0x%x\n",
+			pas_id, ret, inv_arg.ret);
+		return ret ?: -EINVAL;
+	}
+
+	return ret;
+}
+
+static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
+{
+	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
+}
+
+static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
+					       struct qcom_pas_context *ctx)
+{
+	return __qcom_pas_tee_auth_and_reset(dev, ctx->pas_id, ctx->mem_phys,
+					     ctx->mem_size);
+}
+
+static int qcom_pas_tee_set_remote_state(struct device *dev, u32 state,
+					 u32 pas_id)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_SET_REMOTE_STATE,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = pas_id,
+			.u.value.b = state,
+		}
+	};
+	int ret;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS set remote state failed, pas_id: %d, ret: %d, err: 0x%x\n",
+			pas_id, ret, inv_arg.ret);
+		return ret ?: -EINVAL;
+	}
+
+	return ret;
+}
+
+static int qcom_pas_tee_shutdown(struct device *dev, u32 pas_id)
+{
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg = {
+		.func = TA_QCOM_PAS_SHUTDOWN,
+		.session = data->session_id,
+		.num_params = TEE_NUM_PARAMS
+	};
+	struct tee_param param[4] = {
+		[0] = {
+			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+			.u.value.a = pas_id
+		}
+	};
+	int ret;
+
+	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret != 0) {
+		dev_err(dev, "PAS shutdown failed, pas_id: %d, ret: %d, err: 0x%x\n",
+			pas_id, ret, inv_arg.ret);
+		return ret ?: -EINVAL;
+	}
+
+	return ret;
+}
+
+static void qcom_pas_tee_metadata_release(struct device *dev,
+					  struct qcom_pas_context *ctx)
+{
+	struct tee_shm *mdata_shm = ctx->ptr;
+
+	tee_shm_free(mdata_shm);
+	ctx->ptr = NULL;
+}
+
+static struct qcom_pas_ops qcom_pas_ops_tee = {
+	.drv_name		= "qcom-pas-tee",
+	.supported		= qcom_pas_tee_supported,
+	.init_image		= qcom_pas_tee_init_image,
+	.mem_setup		= qcom_pas_tee_mem_setup,
+	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
+	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
+	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
+	.set_remote_state	= qcom_pas_tee_set_remote_state,
+	.shutdown		= qcom_pas_tee_shutdown,
+	.metadata_release	= qcom_pas_tee_metadata_release,
+};
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
+{
+	struct device *dev = &pas_dev->dev;
+	struct qcom_pas_tee_private *data;
+	struct tee_ioctl_open_session_arg sess_arg = {
+		.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL
+	};
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(data->ctx))
+		return -ENODEV;
+
+	export_uuid(sess_arg.uuid, &pas_dev->id.uuid);
+	ret = tee_client_open_session(data->ctx, &sess_arg, NULL);
+	if (ret < 0 || sess_arg.ret != 0) {
+		dev_err(dev, "tee_client_open_session failed, ret: %d, err: 0x%x\n",
+			ret, sess_arg.ret);
+		tee_client_close_context(data->ctx);
+		return ret ?: -EINVAL;
+	}
+
+	data->session_id = sess_arg.session;
+	dev_set_drvdata(dev, data);
+	qcom_pas_ops_tee.dev = dev;
+	qcom_pas_ops_register(&qcom_pas_ops_tee);
+
+	return ret;
+}
+
+static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
+{
+	struct device *dev = &pas_dev->dev;
+	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
+
+	qcom_pas_ops_unregister();
+	tee_client_close_session(data->ctx, data->session_id);
+	tee_client_close_context(data->ctx);
+}
+
+static const struct tee_client_device_id qcom_pas_tee_id_table[] = {
+	{UUID_INIT(0xcff7d191, 0x7ca0, 0x4784,
+		   0xaf, 0x13, 0x48, 0x22, 0x3b, 0x9a, 0x4f, 0xbe)},
+	{}
+};
+MODULE_DEVICE_TABLE(tee, qcom_pas_tee_id_table);
+
+static struct tee_client_driver optee_pas_tee_driver = {
+	.probe		= qcom_pas_tee_probe,
+	.remove		= qcom_pas_tee_remove,
+	.id_table	= qcom_pas_tee_id_table,
+	.driver		= {
+		.name		= "qcom-pas-tee",
+	},
+};
+
+module_tee_client_driver(optee_pas_tee_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm PAS TEE driver");
-- 
2.53.0


