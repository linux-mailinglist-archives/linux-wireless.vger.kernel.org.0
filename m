Return-Path: <linux-wireless+bounces-33854-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCl0FC0TxGmfwAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33854-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:54:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15B3296DE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E27D3047AE4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360493F7874;
	Wed, 25 Mar 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6Pb8YqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B463E0235;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456878; cv=none; b=aHHYig6rPw4MzQ41H78uEHGZcjza+RhXqVdCfS14J3Jv1Klv4A0ho2MMKKsiVC9JcOx4iP8MIzzGGSJAZiveYhqNPvGWeTJCZIz2K8kEE6ixZCJN+A+hTb/jcgPn2qmbZqjZGmfApPE9TZukD1aOTzRHwLGdeSJNlbL31u09oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456878; c=relaxed/simple;
	bh=auYVa+3l24BisqYHUroL4iq3oDJLZATuQvB9Q7Bb+LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4n/tH+0udoPrrTtxhi8k7Txijt8v6FjP27V7S9nYAQp3Rz/dtlzBgwZe1IPMJJQFR/7wcjG7s4KgRuhXFZFEflB++KB50Zx6roQrJN1xJ5Hd8wtaBs8EQ1Ry8duYum8naqqZ4PgMI+blxZz4dixDW8y97ajpYBONbI+Fip5Dlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6Pb8YqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C59ACC2BCB2;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456877;
	bh=auYVa+3l24BisqYHUroL4iq3oDJLZATuQvB9Q7Bb+LM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j6Pb8YqCOlZSfNsFagvhK47zvEKY7bWh7Sn7MVmaWh2tKKaEirV1Z95eb9L4yGKYw
	 pzdMj+XnhwAto3w7oSkcKPywdzjeEkbHhJnseWiMvWZqH8kRLxi5QoMOUt0m6ts7Hv
	 jbYIS5FLBdKz4cPTmrA6H8lDSFttUR3k//TIgy+wQfsnI7ZPZ8OUyxXwjSbPIRX+Pv
	 4H6yBm6iciRhX3NBF6QmO2KI8wS2eO91E6P8pYAHT0cyvg4vtdoL2Yx+ueaOP9ifx/
	 0FuT89urfLR3KFOU1OkJQEviRwVrZEFO8d/qVRVFDJnVnO2IUI3bu/lAI0p3zENFKt
	 yu6iWoJhPh9Dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5920109C043;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Mar 2026 17:41:13 +0100
Subject: [PATCH v3 2/3] ath10k: Introduce a device-tree quirk to skip host
 cap QMI requests
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-skip-host-cam-qmi-req-v3-2-b163cf7b3c81@ixit.cz>
References: <20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz>
In-Reply-To: <20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Paul Sajna <sajattack@postmarketos.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=zduhmi7M53CiNDhpnd/UxVSeff3VorLQBqTI4Nh5rZY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxBAsricF0IftT2NeNw1Yuu7Qi7iezsb/5SpV/
 BgONR0OiXCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQQLAAKCRBgAj/E00kg
 cmnbEACckc0Tpfu2hVTQN1sZFx/yaaL1GbxZ0hXnHFkdzxQwJDVW/lgSjuYfyJCQcnwU5Nnz+Lp
 P2sZEY6bYTvg6uYOS2eM99d5yQl9QnB9OaglGU9C90ZCKmVVJT4m4WvvAZ2bQHXu3gWN9p0zHVw
 ckMJ7hXK7xLdSFJTprmWRYNLHvkAzrnO6k/6s7YIfM/hXXMY9h/hyZqtnfBjoJxoGqOvHXCcg4X
 5x9VFKB2M4CMSh7Q3wSS9CKHLZAjhivIqFw7jFowjK4fAqstlBnvFSLGSaO167TMNXA0GpyERNJ
 f093MYWb2tIY5UG34SKx9Rl1GknDQY7Dty5r+jDjG5IzngGI0b1iIbfNPwiENz4JVeL7aolulFc
 G0lxz0I64iMo6DF9gAaq1Bm8bMPNIDi2AeHrSJQsz6wfwfXWm+w9yGtPGYb4gxGmFo5OtKqexFU
 NDkwMCnPanGLixrBjWJAcPEyPl4taWzt7cUCt6NzF3uehQcWWy1phZoIqPugWOqoS4xxSAsM+tD
 /tCPCNAFnRhaX3JqwACAkl2Sdb6ittGtXJ6dqR/Zj2NIJL7grm4HWugFtHXV7qGXJOJkWz/DSRU
 2x6eVLKfG9e0Jnxa7XcLFS5Wyrdw8wNIRWf31xuhwFk1ScctO7YhYGg7+l7X5WHsRrGU4SDwhLJ
 4WALCKtnZkdDq8g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33854-lists,linux-wireless=lfdr.de,david.ixit.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[david@ixit.cz];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:replyto,ixit.cz:mid]
X-Rspamd-Queue-Id: CD15B3296DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

There are firmware versions which do not support host capability QMI
request. We suspect either the host cap is not implemented or there may
be firmware specific issues, but apparently there seem to be a generation
of firmware that has this particular behavior.

For example, firmware build on Xiaomi Poco F1 (sdm845) phone:
"QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"

If we do not skip the host cap QMI request on Poco F1, then we get a
QMI_ERR_MALFORMED_MSG_V01 error message before loading the firmware in the
ath10k_qmi_host_cap_send_sync(). This error message is not fatal to the
firmware nor to the ath10k driver and we can still bring up the WiFi
services successfully if we just ignore it.

Hence introducing this device-tree quirk to skip host capability
QMI request for the devices with firmware versions which do not support
this feature.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/net/wireless/ath/ath10k/qmi.c  | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
 drivers/net/wireless/ath/ath10k/snoc.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index eebd78e7ff6bc..e7f90fd9e9b83 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -808,6 +808,7 @@ ath10k_qmi_ind_register_send_sync_msg(struct ath10k_qmi *qmi)
 static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
 {
 	struct ath10k *ar = qmi->ar;
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	int ret;
 
 	ret = ath10k_qmi_ind_register_send_sync_msg(qmi);
@@ -819,9 +820,15 @@ static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
 		return;
 	}
 
-	ret = ath10k_qmi_host_cap_send_sync(qmi);
-	if (ret)
-		return;
+	/*
+	 * Skip the host capability request for the firmware versions which
+	 * do not support this feature.
+	 */
+	if (!test_bit(ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK, &ar_snoc->flags)) {
+		ret = ath10k_qmi_host_cap_send_sync(qmi);
+		if (ret)
+			return;
+	}
 
 	ret = ath10k_qmi_msa_mem_info_send_sync_msg(qmi);
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index f72f236fb9eb3..3106502275781 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1362,6 +1362,9 @@ static void ath10k_snoc_quirks_init(struct ath10k *ar)
 
 	if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-8bit-quirk"))
 		set_bit(ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK, &ar_snoc->flags);
+
+	if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-skip-quirk"))
+		set_bit(ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK, &ar_snoc->flags);
 }
 
 int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type)
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 1ecae34687c21..46574fd8f84ee 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -51,6 +51,7 @@ enum ath10k_snoc_flags {
 	ATH10K_SNOC_FLAG_MODEM_STOPPED,
 	ATH10K_SNOC_FLAG_RECOVERY,
 	ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK,
+	ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK,
 };
 
 struct clk_bulk_data;

-- 
2.53.0



