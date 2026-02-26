Return-Path: <linux-wireless+bounces-32201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKWDLF/un2kyfAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:55:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 807291A17C5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F37183032248
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718738BF94;
	Thu, 26 Feb 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVmIP5ki";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJwBIzz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF438BF9C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088924; cv=none; b=H2mNtXw28v9mJLZO+rajpq11LgVqqagZKeaYtzbPVK5WKFakvbbISicCw1j4DZ/6uqmTbyGtgdFvAabK6+GQ8iDy8Qm7ERioPh7cl1UCWevyHyFHC2n+W4iH7eKg53oxJYvPXlIznvmV/bDfelFr6LyejMe4pQXFeKIjH1wYKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088924; c=relaxed/simple;
	bh=V4mmTWudLhbe/F5C3BeUWyx8tz+fJmW0RJcDzSVbEhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kw/zE0Y1F1bgCOzmE3kM5yTEA2loLfsE0ZZ1x/gTOzRMokx5Cjqed2M2fdH2qEEBOzDmQMvXjJXfH6r8G0LIj4OoogpjuX9gS+3Gl1XmtipC/MYwP3CrEcRV4L4UlCmMXQKSfLlT2NGlFvvYzvzwcIBRis8GtmO0adLTSj3Akc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gVmIP5ki; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJwBIzz3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V8h1918925
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WLw7lHniH9k
	/S++EYFfVFRR83lVOnO+YmBVtSwM1soI=; b=gVmIP5ki13NbOjGXkkuKRtd7xvk
	DPR29i698Ho17v3eHBX09h3Iw7tPo1js8e9W+qyJJWd1m91OIyjLHL8hkXrVCX3B
	0ocPn1yUmtrWkMCI7Fx50eMhn/nRMTCAKlPoC2l/OVwbeQDzShZZwUs/A1ZrKhra
	3CV6/Xg1Db53iAu4Q5RNJJXwbxWheBkAO0QpQtDHWFBWCniybcFO3lZjFskUDBUR
	4ks6fPTbYFC3UeFxn15OFTQeroY1AJpcL9AggofVnI+8uW4TB5JbUBksOgcg7iNY
	oYgYbN3iQ0ZPWnnR+XkdFDley0ywuSljP2njTF2jtTk4YR6nlVB7fV54gXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj4w4t78a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358f42fad0bso1798734a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772088920; x=1772693720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLw7lHniH9k/S++EYFfVFRR83lVOnO+YmBVtSwM1soI=;
        b=AJwBIzz3ax+/93KKxxrvjV287Jy148f+7Er02uXzHLP3B6iR1YmFLPjZEa3pcs8CUX
         Div5HdNFr9NL6DkEcK9RmKGRM2Bf2qmnP62FvYTYrD1TjfrIoOqSAaY4F1scgaRerAuE
         iTPIVW/GwjqQqjYq3KevQ+ATaWopWTzGON5DnlEWvIRB8jAGXGdDuaSKu7Hc26tWJWXP
         +Cr5bQdiY8DKpjYZL8G8446CGJxQPuA8z2Zh4fi81+pdbX0Nyc4a/CIJkar4EL2oKBpm
         mb52gUcupvUzx7/Z/UrXIu0kbum7MwL/LqaHAHGZuOpa7k1Bfa2kXAYGM1rNVH/ayiZ7
         Tdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088920; x=1772693720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLw7lHniH9k/S++EYFfVFRR83lVOnO+YmBVtSwM1soI=;
        b=lTvLeutaTABhlSTGpsKraSMSGhbUqYUOJjEI5r1nL5hFd5laP5lWWW7uXqWzH6a45o
         qBkup+cPf/QDil4K2w6IuE7d7iMvvQkd4EKy4jZVJ4ulzx49UuitfUyUUV/cmm648F6v
         8DW6eUkIb3wBgYZnN//OnHQL8/ESFtorOGTl9Zj9oNrY55Z1UXxKHjnK/zh+J7RZkAbH
         IVO1B3YQqOmQKOBqCi1ls3VUBgK7mdYj+4XC7EnD1gyt+0qN7XtUs4cp0m87xs+Z39Gd
         FEgv5TDqwu/8Q4JL5AsDUNpUOs8902onDFNl57P5+QoA2iw7NMjFn3+2E2/UjUelh8QD
         UlZQ==
X-Gm-Message-State: AOJu0Yy4QB9oQQDKyc8v+M+2OvEc1jyeIYHkicQPLrUBLvViRJtd+Ip0
	nfoIvehHlTH/9hVA4Z9RX1VD6WtILXlaksw0P7d0aY8J5tm593fS+um3APXcufuzJZJcXupEyD4
	W+b92TQa32YneIbbLHEyEGOe+jV292P1xZrt9Ahyx9pGXY/E+nGKZE9sLKU+jDCkTO+VLAJsH3K
	ErYg==
X-Gm-Gg: ATEYQzx428iH4XLsDy4w9Mz6T6Xl1tMVAkoUGcOCUfZyn90yi+heWOqYNe0oL+WmRIL
	KM6Uic4k5NyaTUCRYEapzh62xlmifeIlnZ8lj+F4/1t616BwY3cJGj4HcsbCsOnAWEvoA6xE+eu
	vF3wlnaFm8bxZagqmCDGcBEao2q5qImFVSdb4s25kw6vk7px9KUfAUXIHLgekxGcoYYq3AETb+R
	y94LmE/u5o9OmLav1ukTKToWhYrt80M0LFeEw0kQU/GIwUPkrUnNFcZufV+r0IVW6SBam0hXKBx
	4CwqeBD/uVJJYijl+b4b9OvJZXpq/REJ9SHTf2hcLDgDezOajNExZVNVi5Yqdn/sOFo+VLVRlUn
	Dv/oJGmrp2MPysX0dpGyG3F9LTK9+6kLHQBKcr47pHNG21EJqIY6MsA==
X-Received: by 2002:a17:90a:dfcd:b0:352:c146:dc39 with SMTP id 98e67ed59e1d1-35928c25751mr2810945a91.30.1772088920270;
        Wed, 25 Feb 2026 22:55:20 -0800 (PST)
X-Received: by 2002:a17:90a:dfcd:b0:352:c146:dc39 with SMTP id 98e67ed59e1d1-35928c25751mr2810922a91.30.1772088919706;
        Wed, 25 Feb 2026 22:55:19 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm4791066a91.0.2026.02.25.22.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:55:19 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 2/3] wifi: mac80211: Add support for IEEE 802.1X authentication protocol in non-AP STA mode
Date: Thu, 26 Feb 2026 12:24:41 +0530
Message-Id: <20260226065442.4182232-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PDqc71W0XmCANGdJqQIl4X9RtlQugBl-
X-Authority-Analysis: v=2.4 cv=IqMTsb/g c=1 sm=1 tr=0 ts=699fee59 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=M2N7uHsFz5daSXWLXKkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MCBTYWx0ZWRfX0siry4uD4SVY
 JJZH2b+LyEYJ9a/z9Pt1ET1OcyOzI3NV80KLuNXZY2vuZju0cAOvhzEMEAtDsqH1BP4IyHjWM9A
 UN7vU2O1jFpVOhjssc/PGzY+D1L3g+hRJ6q9qTkcIKiIBZOovcMxAGVLmIOagC314ztPy7fGneY
 BsKyEK+q10xFNWbrCYVBa3D4t3bAhZjvSnciHfGGPnW+as7+eYAc02kT8JtcmmHGsjBbjxOEvcE
 nwP/EZpQfyZQL/v2/GUs3XJFnmKiwQYGzdkBeGd37ZbLxAIgDB2l20MA0LMWEnXFY57nOg+u07F
 Fx3EYx5/LvBbccbS8cWk+R/6hLLnw3hKoXUpDiXKUL62QK77Lyok63Vl9fiwkbzJkWqTyVvkMfL
 wIAjpvK7K9lMNwIdE8BqC9qk9jkcDa2YgBbWKXhdk0F73F6YqaZXrl4q2n3WyDxU0JSFnWkawS3
 owIifc/NhcTetFYO+eQ==
X-Proofpoint-GUID: PDqc71W0XmCANGdJqQIl4X9RtlQugBl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32201-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 807291A17C5
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


