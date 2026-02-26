Return-Path: <linux-wireless+bounces-32221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCJLKjSaoGlmlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:08:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B56251AE30B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8780930A5762
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D031429811;
	Thu, 26 Feb 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jDpSctCG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HSastzLI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEC42980D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132187; cv=none; b=Ww5NG50VDwKCfJ4LQqaAWPk5gaT4RZ3G88KB15rZ46+5OZY+eVl+QMyuiLcNeAcR/do+6oKfB7fhwXUndYC+4jt5dnPnarNlxn5OwLjDSd+DjS2UHR8sdJK7VAg0H6+zZPH60rqimc0gBdmW3gnYmErwAWoRikoMNpYLdOQmsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132187; c=relaxed/simple;
	bh=V4mmTWudLhbe/F5C3BeUWyx8tz+fJmW0RJcDzSVbEhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSmAJ99Onqo8bDK+uaCajZFWAW9/71cxfiT3EWGxOF+tOptqwR//fmiezSSKyB0Zc1Gl7JhC/008HR9a/FAO9wVGAI1Z5HwHwNnXK6/Y2YaDWYdkIEShTfKhGyE3uCjI7vORahlDGiG91wUvWJXR2u+2OR+9ttKIEIJn6J4vgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jDpSctCG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HSastzLI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIrSDc2807366
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WLw7lHniH9k
	/S++EYFfVFRR83lVOnO+YmBVtSwM1soI=; b=jDpSctCG39T7iqJcaw1JUfJMl63
	hOWMod4m63bcYo1dsoOkI7+RfschlsMgHIQvIXVv7I8+ELBxjPXtA3U1+Outo+hT
	mXwWeRQKzjAww3+nHWRgAqQzIaPai3PI46QH5qYioZL0IYWivhT04D4fYgqk66YW
	tbzpSQyghbRFZ7fW84iZsZrwEBpCtnmbhXLV63AIRg9rM9+iqXY5HDfI6NFvQHzz
	CQYLWHGado9cEwNxPWrESHLVRaIorIRWu8lnAebyFvrpRoosz7efOQ48iJDT66qF
	QpWqySUe+BC6s4KHiVdvJA1/E7dih47j7LO0psKsNerdjubusybvrmFJ6Ew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur00c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358ffccebf1so1163925a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772132184; x=1772736984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLw7lHniH9k/S++EYFfVFRR83lVOnO+YmBVtSwM1soI=;
        b=HSastzLIamh4Xq8Sh/oIuwLDW2HJagowM0IskLLG7xjC78z3idPeF34UABOiWxruJj
         2yZkjkMQWSwwmoK5cUH7Hkw0222vTBn/n3bVFaAHnxqRzVV5UTWs1tvjGApsoFbpqw78
         /fXn2hDDbQaQl7vcQlNM8SLDa476IQjwv82EObQdINDUNkYLJrx3Ezwb8988GFGLJDek
         ry9N25gs00DMf3o+E3yLUhJp8kvaufUCCuSA9lB0EBYk1xkGAYqz2mYZLRcKXaoUjaHS
         kyfze8SVRawfrgZcYJ8ea3uXdGQoF1XHp+HFFQxMCtZkwd4wFwOsYE6lc9lgvZi9mCss
         V1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132184; x=1772736984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLw7lHniH9k/S++EYFfVFRR83lVOnO+YmBVtSwM1soI=;
        b=N4t3fvshSbMb6A0Yo7MsWGqpQTjKU6oqK4d+Se905o7r68aWeuI6HMGnemsZypkrsm
         kClu3gWIFuNvrqVTXeTRBEUdvU2suAyhwPJTsRmwqRK+66euTNxCewfyjyORo6Ttk1Hw
         ocHrHhJp0ApLsSqcB655TOY57HRaHN7x8dupBerGPJ1AB0IvumS83dTMaAfTW4ub4qqx
         Su+b4JU5Yla/n1/ohjKsk8uHfObtlSia4Ms8oQ/Cc/KQCh4E4tTeUucG6hmgl2aR9sw6
         rbvEmik2LVc8icvqaxbyv6yY/42hDYx+Wclw0Y7NA6nTHZk1cOR9PoWThLPkSHFVD5xK
         2SJA==
X-Gm-Message-State: AOJu0Yw2/B/DXBWgSxk/3jMtlK99XW5IAjML4p3UPypCpERM3KfFKbfa
	5W7vF9R3+QQB0U9Z1VRPHgWUSBSSXIm93Mr7SXdfkzIthK/OIXiWS5LPVluJ1kGYgqxOwoo6Cxr
	pIuL4FU0fJbK1yrzdjzGe/XK0pAbDQ5aMiwRnvcqVKTmtpZkrKkZfNqqJHOKXbEJbgkou7dROu3
	3CcQ==
X-Gm-Gg: ATEYQzww5aI/XaDazWeHgf8sWNS/9OyGtveG3nbH7RZEXar9L8W7vmNMJeFOoaQiKs6
	3wExN5kAC/UHabpJWN0BSTqyyLgF07ec/lMFJA4wgq8sECt1RWKW9wMfZha/R9JluyHuz/TFLkJ
	7hLYSrSLMzjp8D7MK91oLkVaCI/axjxs+gOw7phxqu3T2ydIsSE/FpPll+pFKD4bas/UqI01LPT
	RJUzWsauFp7prUsRrwjLDbUmqKMWNBf+UvOVXLFRKqOJCk201FKkKoHEP8tLTRiv+8vk3ZE53H7
	cVVIrSx5t6RK+Qec4avkFPXihytTvudxT1I2K+tkKSUnpOg/uMHLYvjAZmP31ZQHvjHXU1DC/ug
	qvC673LHSnvLtFV4rdcxWtNnKssQCfKwsvF9zpPxlaqXYFFbTvqFiRw==
X-Received: by 2002:a17:90b:54c8:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35965cf3a81mr132771a91.28.1772132183917;
        Thu, 26 Feb 2026 10:56:23 -0800 (PST)
X-Received: by 2002:a17:90b:54c8:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35965cf3a81mr132753a91.28.1772132183369;
        Thu, 26 Feb 2026 10:56:23 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm6375579a91.2.2026.02.26.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:56:23 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 4/5] wifi: mac80211: Add support for IEEE 802.1X authentication protocol in non-AP STA mode
Date: Fri, 27 Feb 2026 00:25:52 +0530
Message-Id: <20260226185553.1516290-5-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
References: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q5YpACuCssOF73cYFD3lKgsHl3bYvVdQ
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a09759 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=M2N7uHsFz5daSXWLXKkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3MiBTYWx0ZWRfX3rOlIHVJ/srW
 S+l/WILsdh+9JLCemwUfFhDWIWdF+2tEpbqe+0rArP0MbTUSSrVuI5wPrqE3/TfWdkZU6Wdg5I/
 o0PQZb1XGad2AQMLIHv0ed8ZvgX5urG/vEdLLyUqjJebnYbjZbN5NIju4Q8lZr2GhDZmd44+GQI
 EDU/yD16bsr08cuC8Z6yq1m+BojFHy7L76QQw9Foq7fANwUwLBUdmBjB1vGJPwq3J+/nGmmXhIV
 HNXuHtqtST2RIYoS9MF+sPMTtWl1sdpghfDzGgkI9INyHr0DqzGIUgbgMWBy/kCxSZW05pEurrr
 Fun3UBa0fBdBIVRhdOuHx+r+XF+WM8eDI+6EdoTGTHcckothNyWCe8p2CynP7YTAF0iYsmTBbRX
 fIBpgC2ELMo7j4ydQ4wtoMv5kNBIklLui0J49Zj7GZjhMHSF7o8PffzZ/Z++s+skvd1qE1mCnG8
 CRwO/J6AEKUDdv8l8sQ==
X-Proofpoint-ORIG-GUID: q5YpACuCssOF73cYFD3lKgsHl3bYvVdQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32221-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B56251AE30B
X-Rspamd-Action: no action

Add support for the IEEE 802.1X authentication protocol in non-AP STA
mode, as specified in "IEEE P802.11bi/D4.0, 12.16.5".

IEEE 802.1X authentication involves multiple Authentication frame
exchanges, with the non-AP STA and AP alternating transaction
sequence numbers. The number of Authentication frame exchanges
depends on the EAP method in use. For IEEE 802.1X authentication,
process only Authentication frames with the expected transaction
sequence number.

For IEEE 802.1X Authentication, Table 9-71 specifies that the
Encapsulation Length field as specified in Clause 9.4.1.82 shall be
present in all IEEE 802.1X Authentication frames. Drop the frame in
the mac80211 if the Encapsulation Length field is missing.

After receiving the final Authentication frame with status code
WLAN_STATUS_8021X_AUTH_SUCCESS from the AP, mac80211 marks the state
as authenticated, as it indicates the EAP handshake has completed
successfully over the Authentication frames as specified in
Clause 12.16.5.

In the PMKSA caching case, only two Authentication frames are
exchanged if the AP identifies a valid PMKSA, then as specified
in Clause 12.16.8.3, the AP shall set the Status Code to
WLAN_STATUS_SUCCESS in the final Authentication frame and must not
include an encapsulated EAPOL PDU. This frame will be the final
Authentication frame from the AP when PMKSA caching is enabled,
and mac80211 marks the state as authenticated.

In case of authentication success or failure, forward the
Authentication frame to userspace(e.g. wpa_supplicant), and let
userspace validate the Authentication frame from the AP as per the
specification.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/linux/ieee80211.h |  1 +
 net/mac80211/mlme.c       | 78 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 1bf806f85372..3651b2e6c518 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1508,6 +1508,7 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_SAE_PK = 127,
 	WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING = 133,
 	WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED = 134,
+	WLAN_STATUS_8021X_AUTH_SUCCESS = 153,
 };
 
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e83582b2c377..a073451b0c94 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4920,7 +4920,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 				   struct ieee80211_mgmt *mgmt, size_t len)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u16 auth_alg, auth_transaction, status_code;
+	u16 auth_alg, auth_transaction, status_code, encap_len;
 	struct ieee80211_event event = {
 		.type = MLME_EVENT,
 		.u.mlme.data = AUTH_EVENT,
@@ -4929,6 +4929,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		.subtype = IEEE80211_STYPE_AUTH,
 	};
 	bool sae_need_confirm = false;
+	bool auth_fail = false;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -4945,6 +4946,15 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	auth_transaction = le16_to_cpu(mgmt->u.auth.auth_transaction);
 	status_code = le16_to_cpu(mgmt->u.auth.status_code);
 
+	/*
+	 * IEEE 802.1X Authentication:
+	 * Header + Authentication Algorithm Number(2 byte) + Authentication
+	 * Transaction Sequence Number(2 byte) + Status Code(2 byte) +
+	 * Encapsulation Length(2 byte).
+	 */
+	if (auth_alg == WLAN_AUTH_IEEE8021X && len < 24 + 8)
+		return;
+
 	info.link_id = ifmgd->auth_data->link_id;
 
 	if (auth_alg != ifmgd->auth_data->algorithm ||
@@ -4960,7 +4970,24 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		goto notify_driver;
 	}
 
-	if (status_code != WLAN_STATUS_SUCCESS) {
+	switch (auth_alg) {
+	case WLAN_AUTH_IEEE8021X:
+		if (status_code != WLAN_STATUS_SUCCESS &&
+		    status_code != WLAN_STATUS_8021X_AUTH_SUCCESS)
+			auth_fail = true;
+
+		if (!auth_fail) {
+			/* Indicates length of encapsulated EAPOL PDU */
+			encap_len = get_unaligned_le16(mgmt->u.auth.variable);
+		}
+		break;
+	default:
+		if (status_code != WLAN_STATUS_SUCCESS)
+			auth_fail = true;
+		break;
+	}
+
+	if (auth_fail) {
 		cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
 
 		if (auth_alg == WLAN_AUTH_SAE &&
@@ -4997,6 +5024,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	case WLAN_AUTH_FILS_SK_PFS:
 	case WLAN_AUTH_FILS_PK:
 	case WLAN_AUTH_EPPKE:
+	case WLAN_AUTH_IEEE8021X:
 		break;
 	case WLAN_AUTH_SHARED_KEY:
 		if (ifmgd->auth_data->expected_transaction != 4) {
@@ -5017,8 +5045,37 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->auth_data->algorithm != WLAN_AUTH_SAE ||
 	    (auth_transaction == 2 &&
 	     ifmgd->auth_data->expected_transaction == 2)) {
-		if (!ieee80211_mark_sta_auth(sdata))
-			return; /* ignore frame -- wait for timeout */
+		switch (ifmgd->auth_data->algorithm) {
+		case WLAN_AUTH_IEEE8021X:
+			/*
+			 * IEEE 802.1X authentication:
+			 * - When the full EAP handshake completes over the
+			 *   Authentication process, the responder sets the
+			 *   Status Code to WLAN_STATUS_8021X_AUTH_SUCCESS as
+			 *   specified in "IEEE P802.11bi/D4.0, 12.16.5".
+			 *
+			 * - In the PMKSA caching case, only two Authentication
+			 *   frames are exchanged if the responder (e.g., AP)
+			 *   identifies a valid PMKSA, then as specified in
+			 *   "IEEE P802.11bi/D4.0, 12.16.8.3", the responder
+			 *   shall set the Status Code to SUCCESS in the final
+			 *   Authentication frame and must not include an
+			 *   encapsulated EAPOL PDU.
+			 *
+			 * Both conditions are treated as successful
+			 * authentication, so mark the state to Authenticated.
+			 */
+			if (status_code != WLAN_STATUS_8021X_AUTH_SUCCESS &&
+			    !(status_code == WLAN_STATUS_SUCCESS &&
+			      encap_len == 0))
+				break;
+			fallthrough;
+		default:
+			if (!ieee80211_mark_sta_auth(sdata))
+				return; /* ignore frame -- wait for timeout */
+
+			break;
+		}
 	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
 		   auth_transaction == 1) {
 		sae_need_confirm = true;
@@ -8457,6 +8514,10 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	} else if (auth_data->algorithm == WLAN_AUTH_EPPKE) {
 		trans = auth_data->trans;
 		status = auth_data->status;
+	} else if (auth_data->algorithm == WLAN_AUTH_IEEE8021X) {
+		trans = auth_data->trans;
+		status = auth_data->status;
+		auth_data->expected_transaction = trans + 1;
 	}
 
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
@@ -9114,7 +9175,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (ifmgd->auth_data &&
-		    ifmgd->auth_data->algorithm == WLAN_AUTH_EPPKE)
+		    (ifmgd->auth_data->algorithm == WLAN_AUTH_EPPKE ||
+		     ifmgd->auth_data->algorithm == WLAN_AUTH_IEEE8021X))
 			new_sta->sta.epp_peer = true;
 
 		new_sta->sta.mlo = mlo;
@@ -9374,6 +9436,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	case NL80211_AUTHTYPE_EPPKE:
 		auth_alg = WLAN_AUTH_EPPKE;
 		break;
+	case NL80211_AUTHTYPE_IEEE8021X:
+		auth_alg = WLAN_AUTH_IEEE8021X;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9399,7 +9464,8 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
 	if (req->auth_data_len >= 4) {
 		if (req->auth_type == NL80211_AUTHTYPE_SAE ||
-		    req->auth_type == NL80211_AUTHTYPE_EPPKE) {
+		    req->auth_type == NL80211_AUTHTYPE_EPPKE ||
+		    req->auth_type == NL80211_AUTHTYPE_IEEE8021X) {
 			__le16 *pos = (__le16 *) req->auth_data;
 
 			auth_data->trans = le16_to_cpu(pos[0]);
-- 
2.34.1


