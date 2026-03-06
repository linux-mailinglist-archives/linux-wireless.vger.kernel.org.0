Return-Path: <linux-wireless+bounces-32641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOb6KnezqmkhVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:59:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCBB21F60B
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CFA130CE85F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5E381AE3;
	Fri,  6 Mar 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn4myBjV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797135839C;
	Fri,  6 Mar 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794449; cv=none; b=m0X5JE+OO4EFAY6Ozd9Kg/AMmYEX74Ukn8rTrIt0ZY+6kdp7S2EHYql0tQ9T7IyIbkfYbnzB0ynX4oT3W5hj9nvLmAIJZFkgb1oPCe/QQistN7NGyHIVONmZ/xnaUIsGwaF+7IVIzFgLx6bSilafGEIdEkxIgpkv5RxTRtDlQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794449; c=relaxed/simple;
	bh=sJp0nhky3OW7VRFP+5bMf/+H0tk5v6P5LyNIeY9Qg7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2pC0d1iOjj7R77n52nXflIZhVl/HXp/5uikRomMQUrzZdfO3quV7PccMffsGNAixNKf8ROiYCTVj2zvOdKm3M2fRATGWRaNayBXio/SbPmMLLLa0095blXc+YAQ3PxwKIduosWekZyO7BoPeh2t5RP/+jmu3DFo2hFCzV5eGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn4myBjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8373EC4CEF7;
	Fri,  6 Mar 2026 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772794449;
	bh=sJp0nhky3OW7VRFP+5bMf/+H0tk5v6P5LyNIeY9Qg7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kn4myBjVyn5ncfQez7F6l9zZawgFFK/rU7xv3g2KeOreZDgUPEhC1AixKvsYhH4He
	 7Ogw7BmF2Gsb0uRci9OtTuMPQutLlbZCDfW4b1GK5BKUSX0IVgQ1+PH51KS2w0hb7n
	 FdTfcPQERmNQjhUAxxVEMiY9bdYwgB8OXnDtA7Ao7wQjaep1cEXkdoBODm9WKSq/0z
	 gI+NMKICX6M05nkb+QvDgO/pgze30a8cBzSYW/GygCUVLaByCCB33j3Uzfh1ChyGn3
	 Jv1Ab+CzfS+pWNnC4kPIqXB6vHeeGdOkEl+IacEI7EepuSXkCWZAJDzf8/1ecxhUUu
	 B/mOYmo1N09sw==
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
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 13/14] wifi: ath12k: Switch to generic PAS TZ APIs
Date: Fri,  6 Mar 2026 16:20:26 +0530
Message-ID: <20260306105027.290375-14-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306105027.290375-1-sumit.garg@kernel.org>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DCBB21F60B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32641-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 9a4d34e49104..935f893d04ef 100644
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
@@ -415,7 +415,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	}
 
 	/* Authenticate FW image using peripheral ID */
-	ret = qcom_scm_pas_auth_and_reset(pasid);
+	ret = qcom_pas_auth_and_reset(pasid);
 	if (ret) {
 		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
 		goto err_fw2;
@@ -478,9 +478,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
 	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
 		ATH12K_AHB_UPD_SWID;
 	/* Release the firmware */
-	ret = qcom_scm_pas_shutdown(pasid);
+	ret = qcom_pas_shutdown(pasid);
 	if (ret)
-		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
+		ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
 			   ab_ahb->userpd_id, ret);
 }
 
-- 
2.51.0


