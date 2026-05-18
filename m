Return-Path: <linux-wireless+bounces-36586-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI/RHbfBCmoI7gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36586-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:37:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2F567CC7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B35C305697A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45F3E00BC;
	Mon, 18 May 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMPSMiB5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C423E1681;
	Mon, 18 May 2026 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089570; cv=none; b=P7/nZpDi60UmebQiudPcfz3Ljeac4gxkt0Caw1WIOnr5QV7NP6KWl9a1Vq98mWMbqs3sSMLtpMzPxperCvGe9QORybkTsq3Qzlr96Y9h5wGdRKSNTt9TOESgJOxjA8JWC3pN4nOY4MoON1Fa++ZMFb8oAQM/SulYALUc2KHPmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089570; c=relaxed/simple;
	bh=ckQppBRagJEUq09DA8fX8G/qUq46qgkJHeGZVjP6ERg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdzrMSEqcPpcvEEAr8+PX0tUdFDSAUBDIxvQGV9Ylki1cluvQnxptuJJXp7r3gxv0QK13A0GKUEKT/g+LhcRUITbrdp31WoxQCzLq3wurEYpONI3B8cteC1HM62uJurUmUSRwoXbis8xTSlJOKX/x/o2XkfInJABB4xdBtoFXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMPSMiB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F2DC2BCB7;
	Mon, 18 May 2026 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779089569;
	bh=ckQppBRagJEUq09DA8fX8G/qUq46qgkJHeGZVjP6ERg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMPSMiB5Nx8gFkeA9jC+2QNMo+dbrtaLTBc+gmoL+1KEPQqe1pEe+F4CQdJPM4QcN
	 9jUAG8J/erhE/b8eSEFlclC13SDHCt/H81PjoSNscEKgbn2QDxKFDtnQwZVwJR7HE4
	 4z8w/zEh40cycmfFb2sQJiFuhUPDxCuhrd3ekV9BmgUhJ2uyGUqPtE9djKFx1ORzLK
	 QFfIUrmHrtVTBnoFhbkEbLl7tnqid2o2NSB/roXuSDGxUyzONSd5jucJOL3URea+6o
	 b3DNUIaja8c8lHzpfxAv1iAePzpQYVW4j3H3tM4VBtLI40SuUVPj9OIudpWnG5XyD0
	 iWQJFlRhd3KhA==
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
Subject: [PATCH v6 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
Date: Mon, 18 May 2026 12:58:54 +0530
Message-ID: <20260518072856.22790-15-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518072856.22790-1-sumit.garg@kernel.org>
References: <20260518072856.22790-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FE2F567CC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-36586-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Action: no action

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Acked-by: Jeff Johnson <jjohnson@kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath12k/ahb.c   | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index d39c075758bd..2b8b87931330 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -18,7 +18,7 @@ config ATH12K_AHB
 	bool "QTI ath12k AHB support"
 	depends on ATH12K && REMOTEPROC
 	select QCOM_MDT_LOADER
-	select QCOM_SCM
+	select QCOM_PAS
 	help
 	  Enable support for Ath12k AHB bus chipsets, example IPQ5332.
 
diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 2dcf0a52e4c1..dff7fa7027c5 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -420,7 +420,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 
 	if (ab_ahb->scm_auth_enabled) {
 		/* Authenticate FW image using peripheral ID */
-		ret = qcom_scm_pas_auth_and_reset(pasid);
+		ret = qcom_pas_auth_and_reset(pasid);
 		if (ret) {
 			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
 			goto err_fw2;
@@ -485,10 +485,10 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
 		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
 			 ATH12K_AHB_UPD_SWID;
 		/* Release the firmware */
-		ret = qcom_scm_pas_shutdown(pasid);
+		ret = qcom_pas_shutdown(pasid);
 		if (ret)
-			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
-				   ab_ahb->userpd_id);
+			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
+				   ab_ahb->userpd_id, ret);
 	}
 }
 
-- 
2.51.0


