Return-Path: <linux-wireless+bounces-35835-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMUvD1ST+GmwwgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35835-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:38:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936324BCFB8
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6018D30277C9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08493D3009;
	Mon,  4 May 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0KtfO2W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ig4gLZE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE66361657
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898272; cv=none; b=Bgww0dgkfe3+epqfMfQLbgGA9ofqtAzgxYBL7ycYVw5c0JWd8On59z+rjW4bLLfwvDhfFopmky+NwX01HtBEMACG2zO8O6kfYdBnm+qCeem1Jva9Xc3e1Qb2rOg7y/wFHpGc1C3y1vS1KjO9xtzMdqcNpzkrddroNPo3k02Estk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898272; c=relaxed/simple;
	bh=IVPJ7rut3u3r8keOoQEN5TKdL+Kq50IGyGhzfOnYzYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHIl2e/cExnmbaf9vvzYg4mjLM+pyBCfDWjffPg+bq8q/0zG/zCi5dLQJ6nfjdXcxzw9998fo28UBlUG2qQZxGCE3tSEh5qUVEVY+nM/azSiap/EiBd/+mPXXjdBGkJ6+PlKRf4nrWRGKEVW+lCVTqg90vYJlF4KtwAoY5cC4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0KtfO2W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ig4gLZE7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B48pg770837
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 12:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IK7rxWcIa2+
	P+7Q2FBnguPbeCtkibTCryKgf3WoaZoo=; b=f0KtfO2W7tspwtWVeXFC+NeRI95
	rn1wLtaDQm0iza6z56z3H9+XGb/FshtiitRhuW9c2mfMgwjMgzP9HgI1y6nTwzS0
	Px1aLhVJ/Wz/5mvCXOvj/PmtcJLAuvWQQDckN5lGFPckpv3ZMu1/F5+BATrmd2wD
	bCcSbNKks6uf1yT56w3HEkrNkbXU4bNPLR8A9nLybz6d70lVtl80HiQAiK1R2SV9
	UuOfndP+JBQgKbRVJAsbxLq2SAAJxKa4HMEgPTS8oXxSXxPnGeE+A+UtwT5NBxDI
	POF8RwdiDq8WNPq3ITqPUBELRHZBakvYbp6F+fsExW0vAgYY0yuXCFGaPhA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejnk2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:37:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso5625025a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777898270; x=1778503070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK7rxWcIa2+P+7Q2FBnguPbeCtkibTCryKgf3WoaZoo=;
        b=ig4gLZE7MqTDWKklT6o/SR+ccpaDPPKyoKsuqixxD/MUMK+c5DVJHgk29Br1lDWGyy
         h+PQJ2UXwMzNujh3v4vFbYSMTop7Eq0iaSzJuHPUdVW0YdAFMwkZGcw55V3hnya5f+Hq
         LQ0KkNfhW+5oXnBv8R/rWxKFrwALK4nWQV5HJGrEfncZcv5uc1ziArpSl1Bs4WrT4kym
         2AgtZIbWSY5N15D7ThjJi1cpRCj4LT+A+l8KXUJ4wd5UK/bFI00nT0QurePrjhHNY507
         ZSP/rbNg8ufnM2HU2mE8DK9aFxMyS01+I+LmHkKCSDXz850fyrETNtvI1HvJBhBZQXpP
         xlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898270; x=1778503070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IK7rxWcIa2+P+7Q2FBnguPbeCtkibTCryKgf3WoaZoo=;
        b=RQ1b58ZJCi/h1Ih6n1of4C7KVaOXUCX3nLGIDgenuJ+9WUieCUeNVAL1J+e8/Azc52
         AfTzvca9TL/2x8G296z7vJk0MHN0kUJUIovnrVQOcCEFM//fn+wSjAa0jkh41Oi5+uYH
         X1xxwoVslUX9xVa0jv+NTnv33UChw5tapwRdF/eFFyt6CPRvjuE1AZbt2uVGizQcnUZy
         56pICktpQBvBGJusBZLvA3SBoKHL8x6bAyRSm0smxiPYSgWorl2q5/1ryCqxFPkX1PdZ
         tpa5Yjd8JzKPxknl9Uk3ZtuixI3U/RwJdKx24l9MyzkeHNEDDjJnUSBmngML8WJs4nWt
         3TZg==
X-Gm-Message-State: AOJu0YyLzFIPN0cIsZn5VFUAoJYAcBHQRZZ3v5Wwis0DrhI7ziImdn8Q
	eRzdm7PyL+QX+S4Shb/zxGC9BOOHygD4nqYCrwggNF5XA11967FBFXplJdk5ztUFeiK7dEUrKuH
	rGLPI8hx5SK4rSrLZ4P1iwptSdIoyxHUroOAI8DJCzyaE7953Z3N+R3BMVwBeMWJeSXefyg==
X-Gm-Gg: AeBDieslEUfOigzt35bzv4izpjiYp6x49GG8SypzDa+HLhZp6ZYWj3llDCz78WxDjTW
	vXs4zqC7+UnRbAgDSL/Fl2NMA4XeCiZqA9u3Mn/rwsu/2jAF7uwo63h4L8oyNeytu9rfN9VJcMQ
	0Jv0lGVMXUwBPv0Jp4ussSSE6UpnWaTIve3kgLf5YMdiHj2DGRr9RGK0IyPhPW07dF/5K67H9Qo
	t/QTkt6DmBZ8L/jDNGETxv3aV6zaK2IyLSGnirk7PzTiPOoEvw1OJlPPs8zdl+U2dTC0VkBVs28
	w64JDgt9rdRWwkU1LQ2DRSHHfFbg0UByQ+hpH/EcyBtSo4YOZvKmkXwuW7NNcj3JwetLwg3jbfn
	NqQAu5EPM/jadJLWB9cdF8SLlH2scb8Rtu86hPL6TFCSXSzQGYpcWIiSIPN6SacFJ
X-Received: by 2002:a17:903:320e:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b9a4520795mr129072795ad.24.1777898269600;
        Mon, 04 May 2026 05:37:49 -0700 (PDT)
X-Received: by 2002:a17:903:320e:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b9a4520795mr129072635ad.24.1777898268971;
        Mon, 04 May 2026 05:37:48 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6ac32sm107505145ad.83.2026.05.04.05.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:37:48 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 1/2] wifi: cfg80211: indicate (Re)Association frame encryption to userspace
Date: Mon,  4 May 2026 18:06:23 +0530
Message-Id: <20260504123624.529218-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
References: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzNCBTYWx0ZWRfX6QjfFDHxsNvs
 A5hEKBnIrNU2iGDsb5od+hoIptXQK2PIv8weQGo/dQrtxhb9Q/w07QCGutwvw3FUIVabu2mm9mX
 wnUucbl2KJDqZ1ddr7svEJhdWSAx3rdQU21vl5zvUZTQ6v20vabXs6WWCJzp33W4uY3b6LP36yO
 34DQhUzoXRyVE1xyR8B9NsMz3VZ1otshUNsCkPAajmxo0RoZYlVyyYFLmsErP/0ulhyA/4babrS
 in4aN9iEpypbkxvUnZgx0ZDaTG7pcefPJj3ajqZt4RFa1ECI06/CXKvGjD09clxp4p5yhMt53xo
 6HtLHcJyKOktHIamqqs/w0vPcWEy+E1xoAdxIznLHK3eobkXZ2i0s1/wUquLtG9be7MR8v5MBGj
 dg053ha2S6mRzSMUEoUj0mlho3uzsbk4zhJwv5Hj14HG6vA459sBwjgG/ziHkqXqNbqnoVb+NFT
 byYOXO6pmYePHQiFa9w==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f8931e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=cxeXF6eX8DMR1jSa5xUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: PEen2l9ADy2mFveQLoR9K3pGovMrPnOv
X-Proofpoint-GUID: PEen2l9ADy2mFveQLoR9K3pGovMrPnOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040134
X-Rspamd-Queue-Id: 936324BCFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35835-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
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
corresponding field "assoc_encrypted" in cfg80211_connect_resp_params
to indicate that both the (Re)Association Request and Response frames
are transmitted encrypted over the air.

For mac80211-based drivers, extend cfg80211_rx_assoc_resp_data with
the assoc_encrypted field as well, which is then propagated to
cfg80211_connect_resp_params.

Pass the flag to userspace via NL80211_CMD_CONNECT event.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 6 ++++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/wireless/mlme.c          | 1 +
 net/wireless/nl80211.c       | 4 +++-
 net/wireless/sme.c           | 1 +
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a40ab36b8edb..5e1ca0fb614e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8305,6 +8305,7 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  *	as the AC bitmap in the QoS info field
  * @req_ies: information elements from the (Re)Association Request frame
  * @req_ies_len: length of req_ies data
+ * @assoc_encrypted: indicate if the (re)association exchange is encrypted.
  * @ap_mld_addr: AP MLD address (in case of MLO)
  * @links: per-link information indexed by link ID, use links[0] for
  *	non-MLO connections
@@ -8319,6 +8320,7 @@ struct cfg80211_rx_assoc_resp_data {
 	const u8 *req_ies;
 	size_t req_ies_len;
 	int uapsd_queues;
+	bool assoc_encrypted;
 	const u8 *ap_mld_addr;
 	struct {
 		u8 addr[ETH_ALEN] __aligned(2);
@@ -8838,6 +8840,9 @@ struct cfg80211_fils_resp_params {
  * @links.status: per-link status code, to report a status code that's not
  *	%WLAN_STATUS_SUCCESS for a given link, it must also be in the
  *	@valid_links bitmap and may have a BSS pointer (which is then released)
+ * @assoc_encrypted: The driver should set this flag to indicate that the
+ *	(Re)Association Request/Response frames are transmitted encrypted over
+ *	the air.
  */
 struct cfg80211_connect_resp_params {
 	int status;
@@ -8847,6 +8852,7 @@ struct cfg80211_connect_resp_params {
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
 	enum nl80211_timeout_reason timeout_reason;
+	bool assoc_encrypted;
 
 	const u8 *ap_mld_addr;
 	u16 valid_links;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 072b383d7d3c..e26d65c1b737 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3142,6 +3142,13 @@ enum nl80211_commands {
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
@@ -3735,6 +3742,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME,
 	NL80211_ATTR_NAN_PEER_MAPS,
 
+	NL80211_ATTR_ASSOC_ENCRYPTED,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index bd72317c4964..d196b5c086cc 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -38,6 +38,7 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 					u.assoc_resp.variable),
 		.status = le16_to_cpu(mgmt->u.assoc_resp.status_code),
 		.ap_mld_addr = data->ap_mld_addr,
+		.assoc_encrypted = data->assoc_encrypted,
 	};
 	unsigned int link_id;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cf236307cca9..b96f2f7f67d2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20660,7 +20660,9 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
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


