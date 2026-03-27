Return-Path: <linux-wireless+bounces-34079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNM5Bp2ExmlALQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:22:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64267345161
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB4A3093BD1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAADA3EB81B;
	Fri, 27 Mar 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct9wVerJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32423E9F72;
	Fri, 27 Mar 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617227; cv=none; b=Gld5lSqAfK84y30nNY/8+HmwdP+czomanTzmG8nx5bOmlVt7BVlkbJgx/vrorQHzDqcWXn1QWXVuDGyc0igw5nIvuvKePDoXtOYpHWgzr7EZOvK0/TwbLHj0gysbgqySau4Lvs4fZlGevg5lnNwmo3eSqIEqgnA6aIpl5hm7g/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617227; c=relaxed/simple;
	bh=V8EnKxxkOKMl+n0R458o+2crQBk0/0O5QfRMcQ9ghTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXCF7ZFXGdVSExLryqywuKPhm0td6XsDuHa7xtndDUwWvbTJVgzddNLjIUElU66lp5vfw4U7uEYuRCNjwxo8LH6cqVP1Q813WtffESuXpWGQ+XrgMsxYP9s/k6Ypp8znB5ah1l/o4KUcPYISKLvrpI4zUJ8He6FB84R95pZ/MoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct9wVerJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B3BC19423;
	Fri, 27 Mar 2026 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617227;
	bh=V8EnKxxkOKMl+n0R458o+2crQBk0/0O5QfRMcQ9ghTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ct9wVerJYpZjtZTKkk3yjTKypxPyidSjILtk9kwESjF6apA3cQcroUOkc0R2rV+Vf
	 DausJTV0jUWw+KhHxLZaggl8+5T6KtpZ7ssPKHX6Dw7gLrMsjKMPsw4oc/sdjlRbaz
	 jAczcDUI30GPlIwc3pu7xn1SHkTR0nKFO/N8yIGsr93CPAsmzu9yRK5eJiaX78wLso
	 VWB+eG3paOsnjomzHfFnSjb6JOBC/0K7Ph7YeDneYnvu5uk+nyhOu94RR1y2NaNP+U
	 NUQQZl+flRV6LFJ4rjOPcNNYc9czeSGFocgRiFargNBniBNmzv0OVul8HGvsfEK/yN
	 cPISOsOMvF1xg==
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
Subject: [PATCH v3 10/15] drm/msm: Switch to generic PAS TZ APIs
Date: Fri, 27 Mar 2026 18:40:38 +0530
Message-ID: <20260327131043.627120-11-sumit.garg@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-34079-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 64267345161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Kconfig             |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 250246f81ea9..09469d56513b 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -21,6 +21,7 @@ config DRM_MSM
 	select SHMEM
 	select TMPFS
 	select QCOM_SCM
+	select QCOM_PAS
 	select QCOM_UBWC_CONFIG
 	select WANT_DEV_COREDUMP
 	select SND_SOC_HDMI_CODEC if SND_SOC
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index ef9fd6171af7..3283852f9a14 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -5,7 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
-#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/pm_opp.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/slab.h>
@@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
 	if (adreno_is_a506(adreno_gpu))
 		return 0;
 
-	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
+	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
 	if (ret)
 		DRM_ERROR("%s: zap-shader resume failed: %d\n",
 			gpu->name, ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d5fe6f6f0dec..047df0393128 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -8,6 +8,7 @@
 
 #include <linux/ascii85.h>
 #include <linux/interconnect.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/kernel.h>
 #include <linux/of_reserved_mem.h>
@@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		goto out;
 
 	/* Send the image to the secure world */
-	ret = qcom_scm_pas_auth_and_reset(pasid);
+	ret = qcom_pas_auth_and_reset(pasid);
 
 	/*
-	 * If the scm call returns -EOPNOTSUPP we assume that this target
+	 * If the pas call returns -EOPNOTSUPP we assume that this target
 	 * doesn't need/support the zap shader so quietly fail
 	 */
 	if (ret == -EOPNOTSUPP)
@@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
 	if (!zap_available)
 		return -ENODEV;
 
-	/* We need SCM to be able to load the firmware */
-	if (!qcom_scm_is_available()) {
-		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
+	/* We need PAS to be able to load the firmware */
+	if (!qcom_pas_is_available()) {
+		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.51.0


