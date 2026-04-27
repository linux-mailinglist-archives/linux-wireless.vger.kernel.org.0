Return-Path: <linux-wireless+bounces-35380-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC41Mjd872lKBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35380-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 17:09:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A8474ECA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14DFF3006900
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D413290B0;
	Mon, 27 Apr 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6ktyN+N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EsqyZGFl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D834328611
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302565; cv=none; b=KHjvfu0BjhzyxKq+Ge8qAfmkLuviglcA75lDj3JOgytbNKXi50QVwTPOqMtCF29Z7Ow8MdTNHRMkEPEl/g4iyWOjZbXqMSaZPUTaQunHU7/PAXG38GvFxbMRTldiJF7ai//vs/kltdyZ6MvZuZon9uUaeXPKwaKLmCu4j2GCEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302565; c=relaxed/simple;
	bh=+keKg14/P93p5K6O1g1BDCUcQPi3ztQLTrJG+tgEjaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQ2hbfgvABEmH5UPtr0o8gc4xHjevCEJb75QJSEyERrBWd2ffS7f6boSkmhpEmxkEAPe8Hh1xhXhq4Xm6wS9OHIUrMLSWS/LvHNiSHFUHtNLoICYQrRdjZ1KYJyEKrV1ozgp6gy9BQWFArefVEtL2Lz7iNpUWqaUWGb+j6AGwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6ktyN+N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EsqyZGFl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RC5dZF2006212
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XCJn6+bqCYr
	J3mm+9ZIxwmrKHBg8rwiv8OyYGkgqaHc=; b=Y6ktyN+NogAiHE7zgE9qC1fyLtS
	M+krZUMZTdjwyQmFQEflTA4PKA4yzd61rAZIKwBGSGunvYYrhHlmFO64Suw35DnI
	GpxtybkdlsfiM0XB5HTpRCHqyAKRKzYfY9yFjbUvIcaYBvJYjRidyLdMZq84LyPe
	eg/V3EE4wJ0Q2XJYKEGHWZYrTUd/J515E42nCeKwMJjFvr+zAzm1XKvtCOLZC3wJ
	QsRz6mi1dW09gc0FF1S6d2/4UNlwDjZOswj1bGBhzX31GGBqCAuJj5mBipBX/RPW
	8amybFd5iG4uuRuWkX6Dd3Z612iYDhqUJFvUZtwnfUq1V70UwJZ5l9kN02g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkgp3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35daf3d3030so10838912a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777302560; x=1777907360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCJn6+bqCYrJ3mm+9ZIxwmrKHBg8rwiv8OyYGkgqaHc=;
        b=EsqyZGFlSyhVR8n7VouJDsyVzfdTeB3N+q/LBZR9sUpjPlJ0ATh+ZJndmx27i9UvHj
         oO6dGMOkvR4+w3lRQspOWjNAxYCCxa+inQ7H83AQ1JzOP7shMvTj4ntqpoJuqFVKj25/
         irgpIDxMLDuKkwsdVi/6oGt/C2gPnYHV1EEeNjb5YxsB0gsRl5b2dR/CifRE0Q906kPo
         3vAc2JTrJ81XbjJmsmlze2KB/R8BxcAYDRw95Je3v04AwTgiAMumCzdUtyQpnmbr7+UR
         j38EJqsKs22IgZa/Uuk5OPOXBW+shPWaxtQLcGm33eeXTGWFcDV3OXRkipXMqwrXr5Tr
         5vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302560; x=1777907360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XCJn6+bqCYrJ3mm+9ZIxwmrKHBg8rwiv8OyYGkgqaHc=;
        b=CwrorgJvZAZwFUwmNu4aZ0SWBy3wumJZmOx2sElC3+UiI11DW8x2Dl6Ya8WDFWBMOk
         dVIuL06+/4bf47sSMU+GgCCkJAI3g5vt/op++tvg4RDmVEKIxc7UT4f3hFqiPngWB2r2
         t0D01eo6AwxSnyZRk+55rzJbEoAPe7kvJTWeVilD7pJyQEu7f2OacrAwR/3h01lw9BmI
         pRFE9NSeV4K+pJUX3LOjUedrxtu+lYAyjAJBgk8rz3YSyLCTqUy1DzpZ5ekjuejgtyZp
         SMtLLVhLjA7nQD0h2bHZiSzhrginBY1ZQcCvvKKeTjmhZdMzuzhAPAIIDQWw9S8ps1pM
         WyGg==
X-Gm-Message-State: AOJu0Yy+zf9DZy2nvV0IJ1ddZuXYdBEr6IFEWR0s5C7inNtAa14FOTA2
	tiENILRhb6bt8/Bp0ZJ42b7uJWYIgw8aJbOTJEoNva5y78n14JiCbk28zgm18LAisjDlygJrAZJ
	udNfgd7tz+oONG/yUtzgCB2olM7+4Phhh6p+9TLGg/KIAV5jXo37m/HtKujV4szMnvcW8OA==
X-Gm-Gg: AeBDieuSXTZtkHt1PycK8cubJN4Dzw3AtWgwK8IvcmdCeH8BX1/TbBsYbLx6ti6m1ny
	JOcqZvCkQbGfxcN8Hs+yfpLnFQpLALwV8OjSfI5saAugqunitMq2lexSRyIty8ZphZdfb1TGt5s
	qxQSXlvfnadxL78xVjguUuHGmyHusVOs/lgbyjVSmeVGy/Dcvf/8GuwTj8burBohjG6UkPksLmQ
	yGR5cSwpj3z360up/J1afSMCPdsf7bAp27UmXVf9Ti4ethrB66/p3nzCR3PlvNpSPWjeAMj1c34
	69JPxQqps65tXlMGr5S/Gj17U5yZcGKwZ2ouLRxBm/TQ5PB3YfjQmYErG3mYDaDGrjM+V7vVvEz
	L1RQCKL1+DhPUNHmzXYkf+hztHRc8Sxkq43bFiftl7Ekv+daX7tf/mOoJwLweFep1
X-Received: by 2002:a17:90b:5112:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-361403f4e8cmr43368416a91.9.1777302560117;
        Mon, 27 Apr 2026 08:09:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-361403f4e8cmr43368377a91.9.1777302559522;
        Mon, 27 Apr 2026 08:09:19 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm31471363a91.3.2026.04.27.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:09:19 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: indicate (Re)Association frame encryption to userspace
Date: Mon, 27 Apr 2026 20:37:34 +0530
Message-Id: <20260427150735.2391680-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IF1m4_9ggH9RpPC2QHC-RQAVvDqymBtR
X-Proofpoint-ORIG-GUID: IF1m4_9ggH9RpPC2QHC-RQAVvDqymBtR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE2MSBTYWx0ZWRfX7uzRbq/eV8ZM
 I9ydNbR6xHqY6j5Jo0wD4NJMXsKgPMccjuA3ZufwWfC9mQTuBQEIhfj3iO6baDXpNebu5+d2fNg
 vdbj4up7hDIgf7qkk/Y1MUo52zDExZDCufwvrOfqsU2mPpuC/ez9ILQIJwI8792jiCRIVKCA2sG
 Fr/NYxVYg+YGHM8m+5OeqSsEhHNW/Hx+a5daGycr8A2iCfdtFndEyLvDxu/0goLAWXTivuM4owU
 R4iWAmwonlbsrmpttPC2/uqSrOCtbBupkKOuX/PcIxf5gCKGcSrFpM6ooLcg1tG4zRto7M3Kanj
 txKxyxpmu8wCvPAkjdDbZ8ZIdh8WPQbizJoJnZKFe9liz813HPgfoTu4xXk8gkV04N5WW3AWhSd
 QhL3yrjOyFOXtOmh6v232ZGyO3DxQ+laBD1XPVJeX7ZlYyvr7F+wqGorKz05m08aC3L9FA4IxPF
 8pA0toes2gX01v4LejA==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69ef7c21 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=cxeXF6eX8DMR1jSa5xUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270161
X-Rspamd-Queue-Id: C37A8474ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35380-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

In SME-in-driver mode, the driver handles the entire (re)association
exchange. Userspace (e.g., wpa_supplicant) currently has no explicit
indication of whether the (re)association exchange was encrypted,
making it difficult to distinguish EPP (Enhanced Privacy Protection,
IEEE 802.11bi) associations from non-EPP associations.

When (Re)Association frame encryption is used, the (Re)Association
Response frame must contain a Key Delivery element as specified in
IEEE P802.11bi/D4.0, Table 9-65. Userspace must process this element
only when the (Re)Association Response frame is actually encrypted.
Processing it unconditionally for unencrypted frames leads to incorrect
behavior. Without an explicit indication from the driver, userspace
cannot determine whether encryption was used and whether the Key
Delivery element is valid.

Add a new flag attribute NL80211_ATTR_ASSOC_ENCRYPTED and a
corresponding field "assoc_encrypted" in cfg80211_connect_resp_params.
The driver sets this flag to indicate that the (Re)Association
Request/Response frames are transmitted encrypted over the air.
Pass the flag to userspace via NL80211_CMD_CONNECT event.

Mark NL80211_ATTR_ASSOC_ENCRYPTED with NLA_REJECT in the nl80211
policy to reject any attempt by userspace to send this attribute.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 4 ++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/wireless/nl80211.c       | 5 ++++-
 net/wireless/sme.c           | 1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d3639ff9c28..b29fcb4e1a4b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8835,6 +8835,9 @@ struct cfg80211_fils_resp_params {
  * @links.status: per-link status code, to report a status code that's not
  *	%WLAN_STATUS_SUCCESS for a given link, it must also be in the
  *	@valid_links bitmap and may have a BSS pointer (which is then released)
+ * @assoc_encrypted: The driver should set this flag to indicate that the
+ *	(Re)Association Request/Response frames are transmitted encrypted over
+ *	the air.
  */
 struct cfg80211_connect_resp_params {
 	int status;
@@ -8844,6 +8847,7 @@ struct cfg80211_connect_resp_params {
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
 	enum nl80211_timeout_reason timeout_reason;
+	bool assoc_encrypted;
 
 	const u8 *ap_mld_addr;
 	u16 valid_links;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3d55bf4be36f..66af29dddb4c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3140,6 +3140,13 @@ enum nl80211_commands {
  *	association response etc., since it's abridged in the beacon. Used
  *	for START_AP etc.
  *
+ * @NL80211_ATTR_ASSOC_ENCRYPTED: Flag attribute, used only with the
+ *	%NL80211_CMD_CONNECT event in SME-in-driver mode. The driver should
+ *	set this flag to indicate that both the (Re)Association Request frame
+ *	and the corresponding (Re)Association Response frame are transmitted
+ *	encrypted over the air. Enhanced Privacy Protection (EPP), as defined
+ *	in IEEE P802.11bi/D4.0, mandates this encryption.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3733,6 +3740,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME,
 	NL80211_ATTR_NAN_PEER_MAPS,
 
+	NL80211_ATTR_ASSOC_ENCRYPTED,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..30c737376389 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1076,6 +1076,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME] = { .type = NLA_U16 },
 	[NL80211_ATTR_NAN_PEER_MAPS] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_nan_peer_map_policy),
+	[NL80211_ATTR_ASSOC_ENCRYPTED] = { .type = NLA_REJECT },
 };
 
 /* policy for the key attributes */
@@ -20588,7 +20589,9 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 	      (cr->fils.pmk &&
 	       nla_put(msg, NL80211_ATTR_PMK, cr->fils.pmk_len, cr->fils.pmk)) ||
 	      (cr->fils.pmkid &&
-	       nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, cr->fils.pmkid)))))
+	       nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, cr->fils.pmkid)))) ||
+	    (cr->assoc_encrypted &&
+	     nla_put_flag(msg, NL80211_ATTR_ASSOC_ENCRYPTED)))
 		goto nla_put_failure;
 
 	if (cr->valid_links) {
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 86e2ccaa678c..b451df3096dd 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1066,6 +1066,7 @@ void cfg80211_connect_done(struct net_device *dev,
 	}
 	ev->cr.status = params->status;
 	ev->cr.timeout_reason = params->timeout_reason;
+	ev->cr.assoc_encrypted = params->assoc_encrypted;
 
 	spin_lock_irqsave(&wdev->event_lock, flags);
 	list_add_tail(&ev->list, &wdev->event_list);
-- 
2.34.1


