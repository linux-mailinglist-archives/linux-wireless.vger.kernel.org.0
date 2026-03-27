Return-Path: <linux-wireless+bounces-34082-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GbcLcSExmmhLQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34082-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:23:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65459345199
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D05E5309406F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EC3EBF36;
	Fri, 27 Mar 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9juw8yy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8821FF4D;
	Fri, 27 Mar 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617274; cv=none; b=ixlEWbM6RMecg8ohGBQUFIaxlbBqbufwNp0mNLNrDk4rkTUgnUXQakNZFt8UhuZs6pYIp6xEu2uJKd6LNcuxnCtLAl+lrz8RVk6kUzkUh+lFdV9fMSR7zZ1f12mUfKVZn9BOlev+LH1CzRZ/Ku29g0D/7acw6fACzfoKzn/KpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617274; c=relaxed/simple;
	bh=PORzigzNzARQEhp1SDYRDkBvlWdX2APPwjAd2bLyF00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLDs1ztYcbICY7m9KXB0oQWutsuQM7QEw4mmjf6E6V4I56Hh39PR8ZuLfEkchoZkcsdxVLTJGmqCp9dCADiAKnD8S/6jL1XRoh6NBF0/y37XrvNZb9jstcIvCudMXuVpblMhifw6Xqkndsbb5uC2N7UQKuvXyfhmUkXau2uNFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9juw8yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FA3C19423;
	Fri, 27 Mar 2026 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617273;
	bh=PORzigzNzARQEhp1SDYRDkBvlWdX2APPwjAd2bLyF00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9juw8yyFJ/Ut/V0zjyL/q3zX/15Xs9Z0qPeuN2V7bMoOSM7SfMejk+/iAM92YBBy
	 8/I9Hr8kmeeza3gLvvcuXj1Fxcr65brcsgMx/RzkAIjqs9u58+5HrE8+v7QKeBCyY8
	 SXmUvmaD+7jZUmSdoZGtb38nrHlvi/vmbmRMYEg0KkVHJP+WcR6QE7nGVStdGBzHB3
	 4S93RAHXM7hiGnj0H5aNHvkFm8nX010FjvgcggswvBGscY7AH95/+ivc9sPccI+o4H
	 WsxSQF3DUDkSaFzJJArQoXcPiwLnNUEtKyukCNYn2GnnbJ8AnMCuGWsjktA3l74xhz
	 AV2ABpl/LXzjA==
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
Subject: [PATCH v3 13/15] wifi: ath12k: Switch to generic PAS TZ APIs
Date: Fri, 27 Mar 2026 18:40:41 +0530
Message-ID: <20260327131043.627120-14-sumit.garg@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34082-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 65459345199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Acked-by: Jeff Johnson <jjohnson@kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig | 2 +-
 drivers/net/wireless/ath/ath12k/ahb.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 1ea1af1b8f6c..549d0bd77f07 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -19,7 +19,7 @@ config ATH12K_AHB
 	bool "QTI ath12k AHB support"
 	depends on ATH12K && REMOTEPROC
 	select QCOM_MDT_LOADER
-	select QCOM_SCM
+	select QCOM_PAS
 	help
 	  Enable support for Ath12k AHB bus chipsets, example IPQ5332.
 
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


