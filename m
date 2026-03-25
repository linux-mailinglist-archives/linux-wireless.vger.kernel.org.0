Return-Path: <linux-wireless+bounces-33862-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHA9DB4jxGmZwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33862-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81532A39E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611DB304FF8F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A905405ADB;
	Wed, 25 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbWhKFgr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156093AA4F1;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461438; cv=none; b=Y9Vu7U3MMv+d2d5BJfz3fvxXNas/4PciHu0ui/LeoRLwR1cOlRK1b9ax/LM0vISYIhiXducMuvvkPgPcpdgnbPfCVS+d0odPlQeNwb7UOB52s5cVW7JgRpbbhBpQxasqjHs3zS97LpnpFJqew+vmOR98F5bNAbGISex4+bS3AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461438; c=relaxed/simple;
	bh=SRtdPBa0tcNCzl+HO0BObCvLUHh2UjsIHIIIQfNSZlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1dF474JEvq5wPhcs0VZ8rrh7NCQ87y0PbPdY958Pl8/YQrXCvazYl7zW+VoIXpIbe8dpZ7cfkVjPaZuGtZGVwiGOqSntoD87LpCN2iZgo8ytFp1HIxy6KPlMUBv6mkWabFkJASylBqaQDpTwunftVQ9nEDaZjXxh5VuNXyvX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbWhKFgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB3CDC2BCB0;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461437;
	bh=SRtdPBa0tcNCzl+HO0BObCvLUHh2UjsIHIIIQfNSZlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EbWhKFgrWvOyu1Bkls+wkgIu5jN63+7sCO7rwEl6dzagOTLNt3QI/0jXXjP3xqXVG
	 TPP1iPH1EO59Q8w7Nl0Xy2jWdTaKpBfkM85sFnTVgypGKFkIb+FWr/f0gz4RcHrQBS
	 aTArQYepo5Oc9kfzfOH2Q3dfOmZgB5U3RTfhfQ6XkQOqvT8sryJfgxjzgqoVLsvpZs
	 hpa4wyvFYwR9BwV2RddUVsuOGg5TXwA5xLfP17ErG0d/m5rY+eNWlD7Xby4cwfEqm/
	 kDOTxNakE37AWHBHB4Lh7NXwg3JCq2EPsOYJ2UZWAEABjz/upaOEMZIb16Gal2UuL+
	 WMYFGCzUevT4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE6109C052;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Mar 2026 18:57:16 +0100
Subject: [PATCH v4 2/3] ath10k: Add device-tree quirk to skip host cap QMI
 requests
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=UTkKBACGLvaXcmRbJw5uCHiS4miIsN2vwhwdC9DQ5n0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxCH78K9ly8lE2lWicWxBVkBFyYWU04No+j2Jp
 qVgJGG89FKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQh+wAKCRBgAj/E00kg
 cnP1D/0atIwyGIZK7+wVOOqpa3UaZtclm1FJLcJIQpZ5fPRlUvXpvInUN9KAOLwzDy29m3b9VWf
 /osir0ogyljci6mawtR+bRGu3Ms1Ecvt/l980YfVrVAkPiFUdADdwA9lYPoxQuLSbvO9BZIxnH2
 sUlVHEGaZoZ6K8M8dqP3jlRDwXPO1rn/JKNKw+ycc5Jvin1NhS6uT2PQc9hWXbFDZXnzBTwoeIY
 9x7PK4VpcPMDvipLkwilkJmUtPMK+hZ3+ikNJY7hFy6srUNLRqja8XS+IiA5V2V41U8h4uw/m6M
 aN+MGS9i2ornGL7s9bmrYfW656w+Sn52Nq2bixIeF5pgZtYt0QBvZq8tWZwxISlmL/9Cd8moNjR
 1OofbzQ8sAdX654u3jGYrkWUiqdk2gFUAeQgs4bbJBLa4DbViRAP7DlNkxbW1Tc0t9ChmOEC4Hw
 pVyaJVShcs2sAPbwts+pTaWkDASlnLV/vxYzg1akal7mv/xrH1uP1Fn9TwZ2M8LWf4frO4DEnHQ
 7I9d9W7oZ0tH4qEv0qFT86XDLnQKR/AMHUO0hyc1x5+waf0u4myJ+z/tDkscYAXwDYsUH0CGIW3
 MOXvPh0CQkem9Mrvz1PiLheo2mjzxq97NZj6Xq8T6XZrNqixqXHZvIqeCzUrQ2C4AfFUPRJJ761
 K89RaYQ42ci4BbQ==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33862-lists,linux-wireless=lfdr.de,david.ixit.cz];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email,ixit.cz:replyto,ixit.cz:mid]
X-Rspamd-Queue-Id: CC81532A39E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

Some firmware versions do not support the host capability QMI request.
Since this request occurs before firmware-N.bin and board-M.bin are
loaded, the quirk cannot be expressed in the firmware itself.

The root cause is unclear, but there appears to be a generation of
firmware that lacks host capability support.

Without this quirk, ath10k_qmi_host_cap_send_sync() returns
QMI_ERR_MALFORMED_MSG_V01 before loading the firmware. This error is not
fatal - Wi-Fi services still come up successfully if the request is simply
skipped.

Add a device-tree quirk to skip the host capability QMI request on devices
whose firmware does not support it.

For example, firmware build
"QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"
on Xiaomi Poco F1 phone requires this quirk.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
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



