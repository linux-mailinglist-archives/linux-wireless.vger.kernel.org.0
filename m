Return-Path: <linux-wireless+bounces-36874-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGBsMHkuFGpgKgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36874-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:11:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C75205C9BD1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CD783000B8B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C237D134;
	Mon, 25 May 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IAgdrtAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FC3112AD
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707414; cv=none; b=LEcLETxSD0rAWWiIqB89c+kptQ8MmONZ/AspkzOSSA9gREFfwQLgO+PuZ485xW0Duy7YriE4FHs3+ExNzfeFoUQMuw6bzpjBw2LumCxFOM6mvkoDe+RkAD7G+D0a7Ocq30XGjqWPLmhSYbnbyb/TsfULfZOrUf2s1bqww1oLjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707414; c=relaxed/simple;
	bh=LPruvK5P4VsMAqluL02HKHf6D0OYoU0g+UKCovfPegg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqNriBbwD9Mq5EqF2sISiVbYSKsHAo1GabN1ZjeUfe5bNPVUy2rSytjShKUQuM84bwHncWyuwBKl73/lS5B2JDzoc4qwbhVtWX95k6IpLLrard/Wyl5A0tKuAso7GGT/DnaQfU3fwBPiaHzq89GtmHYIypNtwxDAVm1W4/OvwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IAgdrtAU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9ceqU1802358;
	Mon, 25 May 2026 11:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iqc/W7sSJ7k
	70czOoAGaHPWxXALZAmD3YgXV1Zheg4U=; b=IAgdrtAULh90oVuv/8sc8QY5iN0
	Do17bLhdh4tqg29N8mcGvL1nikFbMmFXr0eyYxZd6sElWTfiOId5Rb1J/8X1Erk1
	GfVr0BD6O68Hort09cm6jFInxCBa3yE43288wlctrObkVFbCLMrHE0TzTYmj3APf
	DaygQiNQFu9KZ6x/ASFAKXRd6S9xIm6CMd6/Yn7Ph5l9V1kAqNb2GynpTyBL8aU6
	0KzZlK0UP85je1kgckO5wAcvqhuj1su6WD7Bqj8BD+zatAre9LRtV5TqV8lezdkI
	sb/rl0f/BoNgi8wfaZ+cEgfbwJbswj5dIGDJPA75jluzvbS3Dhhvhzb6GlQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqg9vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PBA6Or026072;
	Mon, 25 May 2026 11:10:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajfc2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:06 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64PBA5e3026037;
	Mon, 25 May 2026 11:10:05 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64PBA5al026033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:05 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id ECC084195D; Mon, 25 May 2026 16:40:04 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Subject: [PATCH ath-next 1/6] wifi: ath12k: Set WDS vdev parameter for 4-address station interface
Date: Mon, 25 May 2026 16:39:37 +0530
Message-Id: <20260525110942.2890212-2-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a142e11 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=zWARB4F9Om_0pLQhUroA:9
X-Proofpoint-ORIG-GUID: yUYwtB6KN4viLoQwps91tL78UOlrRgqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDExMyBTYWx0ZWRfXxRioKVp8PlqN
 rzfcVOTO6jfBeSjhVU6BKdrOBd8izGlhc03n87YfgcMJU7gxM4DTmuZuGrmDAarNASU0fKCetSc
 gM3br+IyPZICdrMyN0ryFRGeqruyHnwUgrfRbC3b9RUelhso9si+hfDn6198YsS0Du4NLrbL6Ul
 tMHAQxG0gWl0D141OQnQA0QUR+ZUtFt7fLO/FqqpnY7Q7Lit4nLoldNicaGvIcYl6dXqwt16TTf
 WNUSDi6uygh9y/l5rH98fMVGG0Kc/eK5GS30f/trW9kWwniKTn5WNTWe7SUp85LkLKdpTD0bB0p
 LvZRHJdKOi9LeXwvTtEOoNWIp1gDxjH0H4jWMC5W0TuYgwKE2YeR7qhkOLwz1x6pStXW/xIRaPc
 vyUDk7Dlkd7YOtGaGd0Zr8hGCU1fRn8Qm+gQ23Hm/nA7F0K/eW7lhvvSi/24aBBt74KleQfX940
 JhXaF6oqwyFGuxzmgRw==
X-Proofpoint-GUID: yUYwtB6KN4viLoQwps91tL78UOlrRgqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250113
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36874-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C75205C9BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set WDS vdev parameter during station interface creation to enable
4-address mode. Unlike AP interfaces that set peer-specific 4-address
mode parameters after receiving 4-address frames from stations, station
interfaces must send all data frames in 4-address mode immediately after
association, including 4-address NULL frames.

Firmware requires 4-address notification for station interfaces during
vdev creation. Configure the WDS vdev parameter for station interfaces.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Co-developed-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 54081beb9a5f..2d02a6a8d54f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10231,6 +10231,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	struct ieee80211_hw *hw = ah->hw;
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {};
 	struct ath12k_wmi_peer_create_arg peer_param = {};
 	struct ieee80211_bss_conf *link_conf = NULL;
@@ -10399,6 +10400,25 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 			goto err_peer_del;
 		}
 
+		/*
+		 * There could be race condition in firmware for the station
+		 * interface between enabling 4-address peer WMI param and
+		 * sending 4-address frame (NULL or EAPOL via TCL).
+		 * Make the station as WDS while bringup itself
+		 * to avoid the race condition
+		 */
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    (wdev && wdev->use_4addr)) {
+			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    WMI_VDEV_PARAM_WDS,
+							    1);
+			if (ret) {
+				ath12k_warn(ar->ab, "failed to set WDS vdev param: %d\n",
+					    ret);
+				goto err_peer_del;
+			}
+		}
+
 		if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
 		    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
 		    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
-- 
2.34.1


