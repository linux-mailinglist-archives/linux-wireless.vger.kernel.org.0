Return-Path: <linux-wireless+bounces-35357-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANZZB80072kw+AAAu9opvQ
	(envelope-from <linux-wireless+bounces-35357-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:05:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB147076B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACDE230430F0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74B3B47F9;
	Mon, 27 Apr 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgaN450e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F93B3C01;
	Mon, 27 Apr 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283945; cv=none; b=i2MSl/VssJy+3/ME3mLze4ROSu7BDC6jjLFZ/cWfyEhuka4TpbQte+6k1TFFwenZbuH3CjxgjmXV+iIvm3UTyv3A1JjYPMdoHlszqc2b2U0PHrcsDbewkK0o+n5vqqBAAf4L0taXtvwF8qWAohdnLVTq/Eq33bSOy3lyod1D1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283945; c=relaxed/simple;
	bh=Ni6+wg4CR6E+75Ru3q2zrAVZ+Yap1oo6S9oO07k3EVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJHnauLybz2HEYl3Ykkguq1BFl7yakm9hudZp9P0Z1q+BUSIk7eF+Wc/eTDjWshUw0OD0JEgPbMQ1TgqsbS+Gstzn7bvJJ6f1O+yL/H0z5KaiW4zDNbXLPlfLQ+jMaTzmqFvDBYUX+glAGLtli4IW+XzOAp2RjMIHE4Su2CgyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgaN450e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12E8C19425;
	Mon, 27 Apr 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283944;
	bh=Ni6+wg4CR6E+75Ru3q2zrAVZ+Yap1oo6S9oO07k3EVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgaN450e0h0ICI9z944ifTNLQJwmjEeYSEBdBvF6ZqC3UIoeruB+X2ZUV5qh7oF0D
	 HQsUx5Ea47XQdP9M0cn3MTvrUhqYrPLKyc9xwOF/eeqGJJ3wbY0I/lsyqdgKavMu8R
	 V87hh8KKO6fLOWdtH5LwZMVnc3J+BKY+4fK+HyYkZ2SVexOLUCVCXxWIezNaz//2JN
	 4q25yPh1sIPUwqQdxbFNnjWS8Un3M81YhQ+Rsytemwd1aIsW1fB7gyWXrjKCroFdFr
	 i3yzSzpTjx7MeY/DAxQBsulaB7HEoVJ7EFvTbNOWsbo95O3HZgO6PwaB4a63b3DODk
	 J5MyXpUV9LaSA==
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
Subject: [PATCH v4 11/15] media: qcom: Switch to generic PAS TZ APIs
Date: Mon, 27 Apr 2026 15:25:59 +0530
Message-ID: <20260427095603.1157963-12-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427095603.1157963-1-sumit.garg@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15DB147076B
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
	TAGGED_FROM(0.00)[bounces-35357-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Along with that pass proper PAS ID to set_remote_state API. As per testing
the SCM backend just ignores it while OP-TEE makes use of it to for proper
book keeping purpose.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
 .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
 drivers/media/platform/qcom/venus/Kconfig     |  1 +
 drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 3c803a05305a..f54b759c18aa 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -1,13 +1,14 @@
 config VIDEO_QCOM_IRIS
-        tristate "Qualcomm iris V4L2 decoder driver"
-        depends on VIDEO_DEV
-        depends on ARCH_QCOM || COMPILE_TEST
-        select V4L2_MEM2MEM_DEV
-        select QCOM_MDT_LOADER if ARCH_QCOM
-        select QCOM_SCM
-        select VIDEOBUF2_DMA_CONTIG
-        help
-          This is a V4L2 driver for Qualcomm iris video accelerator
-          hardware. It accelerates decoding operations on various
-          Qualcomm SoCs.
-          To compile this driver as a module choose m here.
+	tristate "Qualcomm iris V4L2 decoder driver"
+	depends on VIDEO_DEV
+	depends on ARCH_QCOM || COMPILE_TEST
+	select V4L2_MEM2MEM_DEV
+	select QCOM_MDT_LOADER if ARCH_QCOM
+	select QCOM_SCM
+	select QCOM_PAS
+	select VIDEOBUF2_DMA_CONTIG
+	help
+	  This is a V4L2 driver for Qualcomm iris video accelerator
+	  hardware. It accelerates decoding operations on various
+	  Qualcomm SoCs.
+	  To compile this driver as a module choose m here.
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 5f408024e967..856fa6a79064 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
@@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
 		return -ENOMEM;
 	}
 
-	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
+	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
 		return ret;
@@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
 						     cp_config->cp_nonpixel_size);
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
-			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+			qcom_pas_shutdown(core->iris_platform_data->pas_id);
 			return ret;
 		}
 	}
@@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
 
 int iris_fw_unload(struct iris_core *core)
 {
-	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
 }
 
 int iris_set_hw_state(struct iris_core *core, bool resume)
 {
-	return qcom_scm_set_remote_state(resume, 0);
+	return qcom_pas_set_remote_state(resume, core->iris_platform_data->pas_id);
 }
diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
index ffb731ecd48c..574172724e8f 100644
--- a/drivers/media/platform/qcom/venus/Kconfig
+++ b/drivers/media/platform/qcom/venus/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
 	select OF_DYNAMIC if ARCH_QCOM
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select QCOM_SCM
+	select QCOM_PAS
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	help
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 1de7436713ed..3c0727ea137d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -12,6 +12,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/sizes.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	int ret;
 
 	if (core->use_tz) {
-		ret = qcom_scm_set_remote_state(resume, 0);
+		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
 		if (resume && ret == -EINVAL)
 			ret = 0;
 		return ret;
@@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
-	    (core->use_tz && !qcom_scm_is_available()))
+	    (core->use_tz && !qcom_pas_is_available()))
 		return -EPROBE_DEFER;
 
 	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
@@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
 	core->fw.mem_phys = mem_phys;
 
 	if (core->use_tz)
-		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
+		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
 	else
 		ret = venus_boot_no_tz(core, mem_phys, mem_size);
 
@@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
 						     res->cp_nonpixel_start,
 						     res->cp_nonpixel_size);
 		if (ret) {
-			qcom_scm_pas_shutdown(VENUS_PAS_ID);
+			qcom_pas_shutdown(VENUS_PAS_ID);
 			dev_err(dev, "set virtual address ranges fail (%d)\n",
 				ret);
 			return ret;
@@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
 	int ret;
 
 	if (core->use_tz)
-		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
+		ret = qcom_pas_shutdown(VENUS_PAS_ID);
 	else
 		ret = venus_shutdown_no_tz(core);
 
-- 
2.51.0


