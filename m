Return-Path: <linux-wireless+bounces-32553-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FB9BgGsqWmtCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32553-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:14:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F2215400
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB3C7300F799
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D43CA4B5;
	Thu,  5 Mar 2026 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpXwMxoQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZxa2JSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08783CC9EA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726882; cv=none; b=Eilx/93Pz4qIP0IvAjwrA/lq3eotewRkJU5MDs5/yAyxLOZCOSUTobrPq8Y8ZkNgjPgDTFUiaVQfyeZUBS0uno/QT1Zv6p7U3kOFaAHIwmB/MiStUl3IKAmd3agzQvSuw+4Hmr161awL3jdNfMSXOcyOQs7YdGzCqUcqkjvCUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726882; c=relaxed/simple;
	bh=ZUkLjV3jVkOSVgaqlSblvYUJxuPjKdDIAw58OAVksCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMPs0mkUKW12fly6EAgD+62ZlwRJnprVgr9uRTv5cLQiJCSzK/7lDZ8cn4FVF9R35B4YfHnZ70aSBCl4yFt5B3wOlMhaOXXMn+qRgHYA5a/AteEwHESpHWyb9K8iUAGrmHDw/J3kJAKoG3IkocEyuYN0QhpTVlRdkZOpjI/G3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpXwMxoQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZxa2JSS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625CNCAc720360
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bBTVaygCIOW
	1j0KcFryQQ1bMVC6nz/uj/ElfHllOocY=; b=LpXwMxoQCC9wS0q7fEomMFybB32
	H+t9U5QpA7OkrwesAAGAu1S12vqTp2EwDSzqpU/Wduo6OZ2Sr50zL8lMflY7A3r7
	613A/nxcwOIjYqP8PkMSqNI5fFh8KI2JJ30lHOAfP5nTD+o9/zRW7h/tDKylT9P8
	vmla/jihIl/vKOYN8GNVBGp83raoae/10CuLlyWHGx1GUGCFt4amLPXIevB0Xg5B
	ygQJblxdTBDCSfEVz6Xt6irGTKfgykOegCiMj4KhFwKtByRVIiHVXb7IA6wjXl3f
	qINJnak6kJIjksepgPbAIcQmWrtdlA3uw8/twnP2Cxj7ZMIgAYa2x4XE/XQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq9srgqxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:07:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae57228f64so45774695ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726877; x=1773331677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBTVaygCIOW1j0KcFryQQ1bMVC6nz/uj/ElfHllOocY=;
        b=bZxa2JSS1l0yNn+35ITjbgHi+fCgk9D0/HkqVvi/HkUbHt0XbsDNd1PTI9lNB2KW9z
         gr5LPXysc9itqWZH6jSh8oDw2SMe0kRYdI+KmQavj9Xgd1KFT5HAYod99U3V+AjVmXt9
         iM/cNRX9DwbURxt3FP0qQVxCoPTXnEWeM4/2Za501Et1ciSkgt9u6R3Jypn9fI9YFVwv
         wpDWi8XhVugCj51DSmLsXJc69SyM8Z7FUlaTJBo5lB4BMZ710F239iTuTYJXpQISKGue
         AdO/jxKIx1lrR+ES0RvsjBKaMbo+DSoRD8fFLp2HqNdfe1X4rs84V84HF9gqqpZfo6tv
         4C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726877; x=1773331677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBTVaygCIOW1j0KcFryQQ1bMVC6nz/uj/ElfHllOocY=;
        b=WfinrYyxkdO4hDC4szlgcZwThvTRwE5fz5meiE+JGsVqGGcv/TDrz7XZCYe2BBoRtK
         WDohXRTR+VZIc3N0A8ey6a6RGv4PiYMtMJRhD5Vearg7QVGfSz1UAzmQ15nU0vro/Srf
         //9c/isgzjWJD7zVh2vNhx1L/X7tBwFkZTd7zfXFFHszDMGZuKuI7f1SfHI2YXAN+gmh
         qH0JLqhl2FNcidaE1xOOHHyyngW9pCHU+fySdO1ClOiNFIx4uQQ5wpz56/e/gxIs1kkT
         ym4jAfndCX4KRabemF3Wm98IOM5X7gUZiL41qogny1rBKbojILpnk4d3y6BGke3gphNM
         hInw==
X-Gm-Message-State: AOJu0Yzl/3l2F2sXMwdDo1RnqELU08uMuS1Ic+iD0x6I0LVECma3GXDF
	Llkb4evgkW1mJHy6MSgWbtTlnOvXtyGoD6JVnlSLBlPLvlCklT9SM9S3ttQjceiQIwr2CbZRlkq
	hrzfnIqCGQjbhEkzIuJScSttsmCOCf7xY2K5ytsbTOwARrE421eA/nA5pxZNqK22thSRjN+57YZ
	Lk
X-Gm-Gg: ATEYQzw/sDgO5bDIiQtd6Iz5qcnjmOxMtLO+qrOMHU7qR2esLPkcbdTJG4eep6/f/Vi
	BZdhLx+/dDg9OPJ8kjZnMXE2QaKFaVlJTV7KC7OtSrRYUeqK78raDoUktBaZOv2PAGdBZep0UQn
	onl67B4YAv5Iwx/vYxykPJ3x/yjib3/74BIFeJU6m7ZHqtfnWOWIj9gA1kearp3/TyCLV4p/vuF
	xwYL2i6KOIbr1zq5TBCQgPxZisEX5qSa3CVQ0+LlEwarW9PgucwtDcO7z7/a9xRjgBk6SXEcv2H
	T9WuuRxjlJhL4r40anWOqNXZPvmtml2IOR7x8PF3OfboyCXAbjP9KjM3DHn0E7wtvm26xB7VoJQ
	6y+Ax23+/VvC/19ASmYtobXWoylx/7AyDWbZGb/ANZ/ZLFmYRBPFyIxU=
X-Received: by 2002:a17:903:8c5:b0:2aa:daf7:84f6 with SMTP id d9443c01a7336-2ae6abdd127mr60685515ad.55.1772726877145;
        Thu, 05 Mar 2026 08:07:57 -0800 (PST)
X-Received: by 2002:a17:903:8c5:b0:2aa:daf7:84f6 with SMTP id d9443c01a7336-2ae6abdd127mr60685155ad.55.1772726876607;
        Thu, 05 Mar 2026 08:07:56 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:07:56 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 04/15] wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR operations
Date: Thu,  5 Mar 2026 21:37:01 +0530
Message-Id: <20260305160712.1263829-5-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a/I9NESF c=1 sm=1 tr=0 ts=69a9aa5e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=rV0gjk4EqPhYWALXcA0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: jo4o8qSdTrf6-ZQThPgMqjJ3yG2XeGwA
X-Proofpoint-ORIG-GUID: jo4o8qSdTrf6-ZQThPgMqjJ3yG2XeGwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfXzRJYtAO47YHK
 vFqxwAeIznk6+BKbY2/W361ljbQ37gKNtZOTY4wwe+bTNKPEFCMzncVP0xv9wglifXudmh1QN/B
 gGUjeFPuFRAJ8+JxcP0FNBJ9DYw1XxwKVtAGJ8LY1NIW8sni1biUUYdVkBBVGN0DE0vQIVcOP1E
 cV/5Oa7BS9T/arNrNbM3xL1YhviiGVczEBk7RL8sCSjrWK4hEQqFulBlPNaWWfL5tT+fbKlZKTy
 PoIEsLxFSFFCPmrzhqtJBkvALz/89G3RfntYQFYsuQdab5Fo567kIbyOcbSosg0lonOxtvJQ94a
 6fiSJAjImk/K+xnLEGVPrHwFBv5Vzq2HtSUmBRN32CTgRzF+5jfDNL9sjfKJ7Ek7zSlbNGMj8TQ
 +MtISTeZukxEYeLT9m5lTjHW9RwLcrh0NLNw0AFJ2F7PSDcoyrmdmDQUBDQuka33+BTiVV1kXLc
 pU4Zu+kEc+sJrFdCUZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: EA1F2215400
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
	TAGGED_FROM(0.00)[bounces-32553-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a new wdev-only interface type NL80211_IFTYPE_PD to support
Proximity Detection (PD) operations such as PASN, key install and
peer measurement operations. This interface type operates without
a netdev, similar to P2P_DEVICE and NAN interfaces.

Implement support across cfg80211 and mac80211 layers with key
management gated by the NL80211_EXT_FEATURE_SECURE_RTT feature
flag, management frame registration and transmission capabilities,
and proper channel context handling where PD interfaces are
excluded from bandwidth calculations.

The PD interface provides isolated functionality for PD PASN
and PMSR without affecting existing network operations.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h |  2 ++
 net/mac80211/cfg.c           |  2 ++
 net/mac80211/chan.c          |  2 ++
 net/mac80211/iface.c         |  6 +++++-
 net/mac80211/offchannel.c    |  1 +
 net/mac80211/rx.c            |  1 +
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 ++
 net/wireless/core.c          |  1 +
 net/wireless/mlme.c          |  1 +
 net/wireless/nl80211.c       | 27 +++++++++++++++++++++++++--
 net/wireless/reg.c           |  3 +++
 net/wireless/util.c          |  4 +++-
 13 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 49f4704ce627..b1f0e72ec953 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3671,6 +3671,7 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_PD: PD device interface type (not a netdev)
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3692,6 +3693,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_PD,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ee64ac8e0f61..dac211f9a438 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -713,6 +713,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -3183,6 +3184,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		}
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4447cf03c41b..00cbb13fb74b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -473,6 +473,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			continue;
 		case NL80211_IFTYPE_MONITOR:
 			WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
@@ -1414,6 +1415,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2..b647c6394b28 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1369,6 +1369,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 		/* no special treatment */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1489,7 +1490,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 						FIF_PROBE_REQ);
 
 		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-		    sdata->vif.type != NL80211_IFTYPE_NAN)
+		    sdata->vif.type != NL80211_IFTYPE_NAN &&
+		    sdata->vif.type != NL80211_IFTYPE_PD)
 			changed |= ieee80211_reset_erp_info(sdata);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  changed);
@@ -1504,6 +1506,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			break;
 		default:
 			/* not reached */
@@ -1935,6 +1938,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 5f398d38d1c9..04c6031dc46b 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -898,6 +898,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		need_offchan = true;
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6c4b549444c6..ed3f7e3094ea 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4621,6 +4621,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
+	case NL80211_IFTYPE_PD:
 	default:
 		break;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b2e6c8b98381..2fa81fb57093 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2121,6 +2121,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
+		case NL80211_IFTYPE_PD:
 			/* nothing to do */
 			break;
 		case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index d9d4e043bb39..31b621de3f9b 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -796,6 +796,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -919,6 +920,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 23afc250bc10..67a603129c42 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1420,6 +1420,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_PD:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 5cd86253a62e..6d13093ce449 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -939,6 +939,7 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			 * public action frames
 			 */
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 		default:
 			err = -EOPNOTSUPP;
 			break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2d22fd405c39..293fdd07ac7a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1711,6 +1711,11 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 					    NL80211_EXT_FEATURE_SECURE_NAN))
 			return 0;
 		return -EINVAL;
+	case NL80211_IFTYPE_PD:
+		if (wiphy_ext_feature_isset(wdev->wiphy,
+					    NL80211_EXT_FEATURE_SECURE_RTT))
+			return 0;
+		return -EINVAL;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_MONITOR:
@@ -4739,6 +4744,7 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	if ((type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN ||
+	     type == NL80211_IFTYPE_PD ||
 	     rdev->wiphy.features & NL80211_FEATURE_MAC_ON_CREATE) &&
 	    info->attrs[NL80211_ATTR_MAC]) {
 		nla_memcpy(params.macaddr, info->attrs[NL80211_ATTR_MAC],
@@ -4795,8 +4801,9 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		break;
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 		/*
-		 * P2P Device and NAN do not have a netdev, so don't go
+		 * P2P Device, NAN and PD do not have a netdev, so don't go
 		 * through the netdev notifier and must be added here
 		 */
 		cfg80211_init_wdev(wdev);
@@ -10537,7 +10544,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	wiphy = &rdev->wiphy;
 
-	if (wdev->iftype == NL80211_IFTYPE_NAN)
+	if (wdev->iftype == NL80211_IFTYPE_NAN ||
+	    wdev->iftype == NL80211_IFTYPE_PD)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->scan)
@@ -13954,6 +13962,11 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 		      WIPHY_NAN_FLAGS_USERSPACE_DE))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_PD:
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_RTT))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -14017,6 +14030,11 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 		      WIPHY_NAN_FLAGS_USERSPACE_DE))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_PD:
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_RTT))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -14142,6 +14160,11 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
 					     NL80211_EXT_FEATURE_SECURE_NAN))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_PD:
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_RTT))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1c5c38d18feb..fb7eaee734b4 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2411,6 +2411,9 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_NAN:
 			/* we have no info, but NAN is also pretty universal */
 			continue;
+		case NL80211_IFTYPE_PD:
+			/* we have no info, but PD is also pretty universal */
+			continue;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 0a0cea018fc5..d558c4bc00f0 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1186,7 +1186,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 
 	/* cannot change into P2P device or NAN */
 	if (ntype == NL80211_IFTYPE_P2P_DEVICE ||
-	    ntype == NL80211_IFTYPE_NAN)
+	    ntype == NL80211_IFTYPE_NAN ||
+	    ntype == NL80211_IFTYPE_PD)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->change_virtual_intf ||
@@ -1250,6 +1251,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			WARN_ON(1);
 			break;
 		}
-- 
2.34.1


