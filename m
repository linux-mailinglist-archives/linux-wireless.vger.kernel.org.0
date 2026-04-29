Return-Path: <linux-wireless+bounces-35564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KLpAvyk8WnxjAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:28:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241548FC15
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C12B302E784
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A83BB48;
	Wed, 29 Apr 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ei7yXUh4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YV7uk0ZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2675809
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443995; cv=none; b=Jxg8opkI8b2721zLBp09C82LWzBDBuz9+8R9o3hmlW7DWEg8Vx1gFhi00F3M6lC0toAwA7hl5QsE4WMm0Mr7wOzTb9Qc6wZMI5aDdcAdba/qKKfZJwPjRtg0vKxYpH8BRyyihl2tDBFGbnS9FZWHIidsjQe8AQIa2lsruq5FYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443995; c=relaxed/simple;
	bh=RCL7MOAl67mTlhkmQBia7gmByCdlGGmfjkDjjxiC/bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbCfwh6Ea4YFAVT6P1uDPidBFnvdtXlJUm5Ei6l7LVSGkTCoaNEmRbi5Sj7tALELGD+aBnLRWxeqciNSqqOtGA/6HWiux21JKN+YLwxMQSs03wgTqsXdMLnletlrnz0tvuPn26ZvJayTg+L6mcYgrnt38sjySal6PNup3dajHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ei7yXUh4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YV7uk0ZY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T6F6sf1283684
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8lpNft4JjjPAwhaXUeazWADioxQvsLz7fgC
	J9GWBAfY=; b=Ei7yXUh45IIjc1DIMPDPUivmywSwSLs051InXaeyBixmA+Kmxsg
	Ttjlrz5RZvxrsjuBy7l3u4sUfa+QBgkPpJWZoV6ZPQaSBtKigLpiDrYJ43lw/oAs
	pO8iyfi/2Ab7B/SH1waFsYOMRH9qYLM2wbXEXv2ANt7SSbWSeYljJkGBj/j50g12
	lg41RqEGVJyRCCIQC4aZZWI8tP+TtAUtlhowmnW3sCtg9Ei9b/xnEgnRyUHb3Zkk
	7I+MTVP6Gc1R+cto/oKPZ8D52/Lk/eJ4/FcyQysGswK56SCkmAH/8iU3SzmMy4SQ
	bhvD2faDxbOurC2Vwl3Ts2L8FmsrSidRLFg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj801bk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:26:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24af7ca99so165522295ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777443991; x=1778048791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lpNft4JjjPAwhaXUeazWADioxQvsLz7fgCJ9GWBAfY=;
        b=YV7uk0ZYn8L04vUyHINbf9gBN5NBx+4kRLbTCAer0tjlO7peDNk3hENWJziBuLCowJ
         wV08W3T6vVUBZ66Xb9y/s1SsE4vbt5/oCHRhkVK5QW2pK6exhBHDl1CAJyN0zEbN0joA
         aNAnNYk+DPcDXh5cHFUZ2g74wa62T/2FgL1MoOKlmQq5TMcMMjLdMHdWC04jOruX++xF
         mfrKrG+SMCWQJAzPozEhAWzvBWe2D7/3Fhs7MIOC1ZEotdI09QYHmM50rD5G+N7VvNOM
         U6NMpW1+PXgXz75TRc3vT6rq+j07jtdhgdC80gp/UHUt6MLAzXCuivZY9vg+1E/vU3UT
         VNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777443991; x=1778048791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lpNft4JjjPAwhaXUeazWADioxQvsLz7fgCJ9GWBAfY=;
        b=YkpJPEgiUrbtxTyP3wcN/LxEBxxsQlGMc6RDVTNMz7TaiK+pDlWTkIBrHy8UPsWYHC
         MnXltLzHcovuPedCON63IXUe1Tbl9R9aWTPFA06xW1140Noz3xCZYv/eM9TeVkHL9XWf
         Mc47W+nz7x666xNUQlAFb5CyonidRPvaMdpgwsLGI56N9Rn8lrWTBwXfPC8H7wHkHFDM
         ErweFWe7fPSP8v9StM9zoro+LPrW+qyA8KagKCcCoXx3zc37TW0vLDWzedavB4Ey6dGd
         odV5vDgv51w+UqMpG25TlULwfAq4Fs9HYkfToYYdMsYAeRV0qt6ZhubFWkqvf7zbLvae
         d0CQ==
X-Gm-Message-State: AOJu0YxNCdLgLIOXgkG70lFkaRQ0+QVXDmMgSz2nxskIwQUZ78yqiujy
	KcRNXb7H9aVGAMSqwWpTX5fbfxXWjqUtPS2Ug4/c1Riq4Yn/8vHLB83I/8UUEEnwc5wXv+ZGsOV
	qwUm3MpY088hi08y6hr/JkinqHvs7lhmW4gglSwUH595EXW46YZNFIDqp4WM4ADUy6/qJE5BW/u
	aJPA==
X-Gm-Gg: AeBDiesO9JT5CbFIy0Y9fgNn6Dt0SC1yet2Wv/Bcp2E1JOgvxumLj2Jr55JONUBnm2j
	vbsMh2o2rtGEjHY53Q8h82t4czga19iz4MinLzciXIwRIfEfz7sNnEeSNOMJ84xf6ZxQyubS9a8
	N35dbDrFAqwD435bob3XACKiS0xA+mUnWRWvnNTILXRaM10pJ4/W1WXgyWnDEllSrDOwEqFoKgK
	Jyy7fLZRfDctY4crP6LSaxexXVpMLfcBtNHyNGeWD1Y1lkL9yG6g494KLqnvfYG1jgpqqqJdCKy
	5tDSZsFZyZbmOOzK4PLLGuTWQdFpqlyk15vMsEEegyIIyLKlziySazPBNB7qqO7W6Se/vJr1b8W
	J6Go5MTA5AamPbx1heGLqUyC9Jw9Yl172tn1XeC4ItjP+JfzmkWmBwKbjIU8WAk6m
X-Received: by 2002:a17:903:1ac5:b0:2b2:ece2:bc1b with SMTP id d9443c01a7336-2b97c461ef7mr59354675ad.26.1777443991391;
        Tue, 28 Apr 2026 23:26:31 -0700 (PDT)
X-Received: by 2002:a17:903:1ac5:b0:2b2:ece2:bc1b with SMTP id d9443c01a7336-2b97c461ef7mr59354405ad.26.1777443990797;
        Tue, 28 Apr 2026 23:26:30 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887853a2sm11473255ad.18.2026.04.28.23.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:26:30 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2] wifi: cfg80211: indicate (Re)Association frame encryption to userspace
Date: Wed, 29 Apr 2026 11:55:13 +0530
Message-Id: <20260429062513.3841635-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0eUhmpnR28q1eKX7NAWvsyRrPlNkB_tF
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1a499 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=cxeXF6eX8DMR1jSa5xUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 0eUhmpnR28q1eKX7NAWvsyRrPlNkB_tF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2MCBTYWx0ZWRfX2gY5zq5neot1
 slvJVJSVR4StSKB7VouSFLBRspImfZ58t/GHd8+utBSz+oTYSXgYhrjdOKmrxefXQI7gMT/4sJa
 wDTFKt8Jo7h36iU3/nOAVArfYrCPgoux+xin4JtdL39GkWNA0VjY8oxJ/W9bH+Oz42vFf9tWRQQ
 HtXxmvKTA45VwS/19x9StM38yW/Py+K5ZoXIIMoPsWXcCGBjVjIlmf9e+rcCdY897xUl2hc9Qs7
 +twC/GQZAfC1sjjI7TnHFA7R7eh/N1NEuhYE8z3S7iwNxwoyL+LM8NMP7Sv2+coAXgngPHNMU+9
 CG1JJmuOjw15tWorNQA/2PRfCNZEWqfDIshKp4iw7BHZ4wC3WFLRh04y7FHji5PPl5jc4Eipbj1
 57/z0AfXG1xR5FaFQvDmrny8uB/GU4xyjrpYbNPIBCn8bpOy2T8mORJSk6zUWURQocCO932fu+x
 k8D30UdhgNW5cXInyng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290060
X-Rspamd-Queue-Id: 5241548FC15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35564-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
Changes in v2:
 - This is a continuation of the previous series:
   "[PATCH wireless-next 0/2] wifi: cfg80211/mac80211: indicate
    (Re)Association frame encryption in SME-in-driver mode".
   Now sending as a single patch.
 - Dropped the patch 2/2, as there is no current use case for passing
   assoc_encrypted when both NL80211_CMD_ASSOCIATE and
   NL80211_CMD_CONNECT are indicated.
 - Removed redundant NLA_REJECT entry and Updated commit message.
---
 include/net/cfg80211.h       | 4 ++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/wireless/nl80211.c       | 4 +++-
 net/wireless/sme.c           | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a40ab36b8edb..2fa8c1132bfb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8838,6 +8838,9 @@ struct cfg80211_fils_resp_params {
  * @links.status: per-link status code, to report a status code that's not
  *	%WLAN_STATUS_SUCCESS for a given link, it must also be in the
  *	@valid_links bitmap and may have a BSS pointer (which is then released)
+ * @assoc_encrypted: The driver should set this flag to indicate that the
+ *	(Re)Association Request/Response frames are transmitted encrypted over
+ *	the air.
  */
 struct cfg80211_connect_resp_params {
 	int status;
@@ -8847,6 +8850,7 @@ struct cfg80211_connect_resp_params {
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

base-commit: 7baf5857e15d722776898510a10546d6b2f18645
-- 
2.34.1


