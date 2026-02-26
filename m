Return-Path: <linux-wireless+bounces-32220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJcbCImZoGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:05:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFB1AE29B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCC6130775D0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8793426D17;
	Thu, 26 Feb 2026 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/Dj7f1n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERtVWizr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7542B754
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132185; cv=none; b=oJAM5Qg4/aqa7fwMNKWFIKNYEP0r0Y/PBHXf2AbFHM++ZEDNqxAdspquWI5rKRo8aseGWYmLRK9oOZPcQ1zbYsztXorgHUF9bRh5kCaRy3xzba7abmz0VtvZy+OOq9VacKn/gZEUIVQUdkefseIUab72cy1YUhCFZKzokP/30qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132185; c=relaxed/simple;
	bh=nYLUPjQsUeHRXlv9mqgkugWR7ewpD5xIvamPrGw0hO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zv4lF4uhBdg3J/JbD1c0wl2YItTaiOQZKf+mK341gc6oAnXp1oVGwvNLLGQlKppI4fNlCEYdJExLdGLNtHCGu3ASlDZHwGq5EdiqM5cdpOqDLrBYdBL0/7QwjiQjShpyLO+rrpjH7m9Z+pEvOEqlZUC/a3hN1UIyafgGrPeWuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V/Dj7f1n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ERtVWizr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHEexG1200400
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/w8WYOKrZSWjh2BiqV2N6C2kB4wMP4bR1sTRH7W8Vs=; b=V/Dj7f1np5r4vVtB
	eHRVVfwF+tbw5iytTIGks8RsqBu16coz2IXGV+G9VcLvZGf5oE5aCjgAKTDwxDHe
	HZ0iYdvrBXn79ZATQIaVM4f61GwybFqjsfSXFB5Oj+n62kDfu6FwFaRgSyTUD2rD
	ivzXoq2b5u1afjcs4rrbfTOpVMqpwj3FRdGxhAYOJjH9lNDsBimpEnk9eoGPdVk2
	q9H324uXiH84bW0aUjF/nCF0joOF8QArVJ1SoVo0BFEydh5O+wyx1BKMQwpasLGO
	lW+O07ra3TSAFNEVNumvsoHYymu8D5ZY2yGj5Zsi9eNJpJ4CwGuEfwDB9TIHDuJH
	I39FvQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8u1rt4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso946204a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772132182; x=1772736982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/w8WYOKrZSWjh2BiqV2N6C2kB4wMP4bR1sTRH7W8Vs=;
        b=ERtVWizrS+ngjDBbdF1qVVnFJswJkG1fa8lKxofsnZGKH0P3tcIbwkURxC6S9jZ5OI
         HUTdwFviXsgQoACeHfl8kOZ2mpjnopfYbwx8M8pLxaFjnaqux15X/wdBpxB7x1j2xADa
         5LL6Kaoi74flGd80CPfRZSSOg/aIHUDyBLZSBouEpaYa3RDFzVjwQaovRAYXtX7r/WYG
         m7ieJ6x7WSLfWFOUxRmM3INJcMZAqe9XK69uyi3+BXbf9Dhn/dKSN/JrKpXb4MChgf1S
         oXaa5tU05ixe5vU0n8HXiSGCsfLM0RdawBOVDQ6OjsIX1svUIFlbYCBqaZyLKUoMh/v7
         Pu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132182; x=1772736982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/w8WYOKrZSWjh2BiqV2N6C2kB4wMP4bR1sTRH7W8Vs=;
        b=V7i5TL+x4demlqJEe5JRbiPu5caPGJLEmc7+X+snCTiMLJlo79lNSi2XZZ3pTMKucj
         EWKI6KBhdQ8JaMkS/zIdDXQarAsSWgt58AMyoDCvtlBDuFh1vzub5Mn/WbOqB+HEAvlM
         IWh7bjI8Kczek9A+8et39e7OEHU5eANkeHckBMMg9N0Yz/d9eEDiQDILn6Wg7VQpFjE4
         6SET1vL3t9b8MA4zahXMwUXsKTnJJtIDSdQux+Xr3sYfoor5Ny10Zubd3kb3O/sIDGrz
         KoCTXfOUm+RxB3No/QCQ7UDQyZ2Fpvup3cbBXLslFVyyaaa8qLgCKNEUpLKLuvZfcwKx
         1IjQ==
X-Gm-Message-State: AOJu0Yw7GdckcIoz8xlm44sCX9oWixZK/W7K18m1vxyBU6pvySsioAAL
	1GIVmB+TfteXG2qmEGjCWpGwzA1XzMQj2My2sfYWtx4TUwDOv9ca+RGDCahosABRuUzs54xG59U
	NR5U+1WRIi1UCNlzm9siXg6kisPDhpxnJ4x7rTatmBW7mbx3623OUIq0b2JhXIx2dbWBUOw==
X-Gm-Gg: ATEYQzwNhOEDZ+xUo17oVgb6PF+SjIAUKY64D9jNPWlu4BjQ143Ywh/T2flTZKafLYe
	CQ5ses5Ul97/I/nRhZGX/v2rwtwkME5WUQNNHUlclmc2yexl9XlKhtHPxpkBhiuyO6iANe1F6T7
	fu9rnebYAraRW/ayfhWQgWaEpp5u0L9fqHN8jL8SK8BtOmk59fstMemMW9sHwltfsvOXtec0DZR
	ORTjSS6V13DvVR+Z7NO/Qc1UFR5qv1Ij5Y09lUNDIci/XL6Cy0y6AOyRctySCh0d2307jgISRCZ
	n0D62vg/6D6n9DOPJDJe1B9poFSftpc0ZJgISOaP9eOvVGLZxNWMZCOKyf0rqUIPnNhYli8/5Wa
	I0kasN4nePEF5GjmZKCPDjWBwPH7D4JXjhmRBZWjVzu5uuL4KxV8o+A==
X-Received: by 2002:a17:90b:4fcc:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-35965c17f60mr165629a91.6.1772132182054;
        Thu, 26 Feb 2026 10:56:22 -0800 (PST)
X-Received: by 2002:a17:90b:4fcc:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-35965c17f60mr165612a91.6.1772132181374;
        Thu, 26 Feb 2026 10:56:21 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm6375579a91.2.2026.02.26.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:56:21 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 3/5] wifi: cfg80211: add support for IEEE 802.1X Authentication Protocol
Date: Fri, 27 Feb 2026 00:25:51 +0530
Message-Id: <20260226185553.1516290-4-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
References: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3MyBTYWx0ZWRfX6ByVn/4BbaS5
 NuGUN4SD87H7m1wDpcZFKgW9O9yz60CXOQQf+ySXtHo6aRn2/PC4VZ+mg9wMjZj1cRVr8jJVlxs
 yAM1a5ADILf870fnfnnTLnhoDnEhPN7Jv6g7+X029SvK/1lav8n5worSBYzSWwStfsWD/JY8INv
 ov6zmB/BEhbpgvy9Qsnp2olUndjXi/TIGwyBhONkxHr7kdjhivNmTt3UwMcxcXfhAKFVIEbGZnI
 Hc7mwthP5/6r95r2K0tw9dEUpCafZtWtz4R7LkhU4SoJGfg0qf0n5Ux58iokXy4JIaqG/JmiPv3
 S/FEQZR3niZTeON/eHC4JJC/G55DzauEhar8VLV8BCdR3t9MqaKJIuha1vlVJYdl5YW69xYcsLZ
 RLFfmvJhlJpJKxiptXfD0ueaUsQm8jR6ildMs+eaZmoP+EkFozgzIiU976Mc23Q7+3JXVlzP7ua
 oD4abPpicNqmsrvgJVg==
X-Authority-Analysis: v=2.4 cv=O780fR9W c=1 sm=1 tr=0 ts=69a09757 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Gjt06254oa6de200CNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: HUXOnHbLgI4TVKIQQmQyMfBRdr0A4dL8
X-Proofpoint-GUID: HUXOnHbLgI4TVKIQQmQyMfBRdr0A4dL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32220-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CBFFB1AE29B
X-Rspamd-Action: no action

Add an extended feature flag NL80211_EXT_FEATURE_IEEE8021X_AUTH to
allow a driver to indicate support for the IEEE 802.1X authentication
protocol in non-AP STA mode, as defined in
"IEEE P802.11bi/D4.0, 12.16.5".

In case of SME in userspace, the Authentication frame body is prepared
in userspace while the driver finalizes the Authentication frame once
it receives the required fields and elements. The driver indicates
support for IEEE 802.1X authentication using the extended feature flag
so that userspace can initiate IEEE 802.1X authentication.

When the feature flag is set, process IEEE 802.1X Authentication frames
from userspace in non-AP STA mode. If the flag is not set, reject
IEEE 802.1X Authentication frames.

Define a new authentication type NL80211_AUTHTYPE_IEEE8021X for
IEEE 802.1X authentication.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/linux/ieee80211.h    |  1 +
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0aa2fb8f88de..1bf806f85372 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1358,6 +1358,7 @@ struct ieee80211_tdls_data {
 #define WLAN_AUTH_FILS_SK 4
 #define WLAN_AUTH_FILS_SK_PFS 5
 #define WLAN_AUTH_FILS_PK 6
+#define WLAN_AUTH_IEEE8021X 8
 #define WLAN_AUTH_EPPKE 9
 #define WLAN_AUTH_LEAP 128
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f71850906..6802e6884800 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5466,6 +5466,8 @@ enum nl80211_bss_status {
  * @NL80211_AUTHTYPE_FILS_SK_PFS: Fast Initial Link Setup shared key with PFS
  * @NL80211_AUTHTYPE_FILS_PK: Fast Initial Link Setup public key
  * @NL80211_AUTHTYPE_EPPKE: Enhanced Privacy Protection Key Exchange
+ * @NL80211_AUTHTYPE_IEEE8021X: IEEE 802.1X authentication utilizing
+ *	Authentication frames
  * @__NL80211_AUTHTYPE_NUM: internal
  * @NL80211_AUTHTYPE_MAX: maximum valid auth algorithm
  * @NL80211_AUTHTYPE_AUTOMATIC: determine automatically (if necessary by
@@ -5482,6 +5484,7 @@ enum nl80211_auth_type {
 	NL80211_AUTHTYPE_FILS_SK_PFS,
 	NL80211_AUTHTYPE_FILS_PK,
 	NL80211_AUTHTYPE_EPPKE,
+	NL80211_AUTHTYPE_IEEE8021X,
 
 	/* keep last */
 	__NL80211_AUTHTYPE_NUM,
@@ -6795,6 +6798,11 @@ enum nl80211_feature_flags {
  *	frames in both non‑AP STA and AP mode as specified in
  *	"IEEE P802.11bi/D3.0, 12.16.6".
  *
+ * @NL80211_EXT_FEATURE_IEEE8021X_AUTH: Driver supports IEEE 802.1X
+ *	authentication utilizing Authentication frames with user space SME
+ *	(NL80211_CMD_AUTHENTICATE) in non-AP STA mode, as specified in
+ *	"IEEE P802.11bi/D4.0, 12.16.5".
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6873,6 +6881,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 	NL80211_EXT_FEATURE_EPPKE,
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
+	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f8..3258ef2e3631 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6542,6 +6542,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 					     NL80211_EXT_FEATURE_EPPKE) &&
 		    auth_type == NL80211_AUTHTYPE_EPPKE)
 			return false;
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_IEEE8021X_AUTH) &&
+		    auth_type == NL80211_AUTHTYPE_IEEE8021X)
+			return false;
 		return true;
 	case NL80211_CMD_CONNECT:
 		if (!(rdev->wiphy.features & NL80211_FEATURE_SAE) &&
@@ -6563,6 +6567,10 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 					     NL80211_EXT_FEATURE_EPPKE) &&
 		    auth_type == NL80211_AUTHTYPE_EPPKE)
 			return false;
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_IEEE8021X_AUTH) &&
+		    auth_type == NL80211_AUTHTYPE_IEEE8021X)
+			return false;
 		return true;
 	case NL80211_CMD_START_AP:
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
@@ -12077,7 +12085,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	     auth_type == NL80211_AUTHTYPE_FILS_SK ||
 	     auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
 	     auth_type == NL80211_AUTHTYPE_FILS_PK ||
-	     auth_type == NL80211_AUTHTYPE_EPPKE) &&
+	     auth_type == NL80211_AUTHTYPE_EPPKE ||
+	     auth_type == NL80211_AUTHTYPE_IEEE8021X) &&
 	    !info->attrs[NL80211_ATTR_AUTH_DATA])
 		return -EINVAL;
 
@@ -12086,7 +12095,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		    auth_type != NL80211_AUTHTYPE_FILS_SK &&
 		    auth_type != NL80211_AUTHTYPE_FILS_SK_PFS &&
 		    auth_type != NL80211_AUTHTYPE_FILS_PK &&
-		    auth_type != NL80211_AUTHTYPE_EPPKE)
+		    auth_type != NL80211_AUTHTYPE_EPPKE &&
+		    auth_type != NL80211_AUTHTYPE_IEEE8021X)
 			return -EINVAL;
 		req.auth_data = nla_data(info->attrs[NL80211_ATTR_AUTH_DATA]);
 		req.auth_data_len = nla_len(info->attrs[NL80211_ATTR_AUTH_DATA]);
-- 
2.34.1


