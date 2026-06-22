Return-Path: <linux-wireless+bounces-37987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QEB2ORjHOWpgxQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 01:36:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCAC6B2D66
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 01:36:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="TCD/J15H";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37987-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37987-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0320630234EB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173735AC00;
	Mon, 22 Jun 2026 23:36:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098235836B
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 23:36:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171407; cv=none; b=SoK/hUdxzx0mYeTmysm9KByojxUqndqqBK9hn3FeEyKLKIFEVYWfieBqpUiUPlCPCTHVRdPW6nmgDlU8nXx+oVeh5AzwvWYIsN4pxRgzTNyrEzbvWm56wEW+ca+gaY0vMHDVHAOfZLKfyALLoym95WsMieC6FgLw/u/s7JGGlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171407; c=relaxed/simple;
	bh=V5mqFqzJYewcSQfXSAuToyRlLLnZXuepRM5FnJMkCqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/R6ujfIScwEEi3a3EGwoapOoUvJ6yX+7PJwN8MwdHo6dxb+BTVNeAiJUHA3RYGVq84Uxc0xkeR6KLbFgfuwu5KCt+khe1NlqATIAXjD6kQpoGddaOaiSlvwsjN5jd5AJ4RsHOpi2gtazIpfDbMsz2klrrG6mclWrQQwmK4xpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCD/J15H; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJb9iO2122402;
	Mon, 22 Jun 2026 23:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CiouGYuxTuGJYsco6K35t5h0eQYCcOGYZHD
	w+wiw/9U=; b=TCD/J15HdvM1Bc3JnLoXqfLa6N/q/CV5yL+KC1XA8ffWc/b8eBQ
	YYwaqXlPPvYkBNjkWEGZh8fEFQ1hrlrAZubZ2P+joPmIgjAfboTzjhJOq+9jhJhp
	Qf4TNyYfYg2NCiBJfQ2uBICTkpsH9C5hMO+n7q8fyFueZxe2FPBPTKpqPiUPx1IX
	i/LO3GJeeh0VVLQToM2ebYkfMqwCwqZZwu95GK57A2QoCtswTZj918oQBnShkoCO
	ByytZjvys03R5oweIMeB3Y/v7D0BO0v1DdFgGMzz8wlBOUIlRODATzjaVZtfyERd
	0vYEzaCTTjQQbdtDz6tew5yxEiOlX2gi7EA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n42453-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 23:36:41 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MNabfL017841;
	Mon, 22 Jun 2026 23:36:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4ewkxjbws9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 23:36:37 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65MNaaFO017835;
	Mon, 22 Jun 2026 23:36:36 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 65MNaaho017829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 23:36:36 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 1971E4190B; Tue, 23 Jun 2026 05:06:36 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Set IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param
Date: Tue, 23 Jun 2026 05:06:35 +0530
Message-Id: <20260622233635.1532083-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyNiBTYWx0ZWRfX8NlCLEKZohin
 7OVKEI6/NA0BhOw50aJ+V4Ts2BHG/RmKwZbyHUK2UQOrK2kNybwD8mmw6bAPYeMCMNySzQRrtwX
 uvXwdDjZdIwDM+jNVjoJLk+9yOdkFAk=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39c70a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=qXU80byQgJiTIr4dmD4A:9
X-Proofpoint-ORIG-GUID: x_90IDJUYtc0V_XBysFWtbC3KI7Rsv7T
X-Proofpoint-GUID: x_90IDJUYtc0V_XBysFWtbC3KI7Rsv7T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyNiBTYWx0ZWRfX2ZxnDlGUiS/n
 TMYuzlLAgS+BfhRw6VwlUX8m7CLiYG4OBRAY30zzLZUhtcpECO0rzSowc2YFtvUDgJI+w6C8vy6
 WaH+94utybfsqFYTcNvMwcH4VOYqryXxA41PUq9b8DOijinyjtsHUWzeSDy4c3iodZayLcBctgq
 9Isit3cfnHRPYJHxRQA/5n3x88lrBOlshk/0VttNRExVICV8h8e4KvqGNTI2BbxwzqA94YYXKwd
 5uyylMnC9KztqRntq299mR8RyT66QsX064JSyyMuu2NaJ1IbNYq9/jZ+RjS19dyE8Q1alTzYEBe
 /nzvLQ8B3g/8RyMhBU7bZnKxaKpxkJ3xhvxgx80zNPgYwLPbHo9fyLaKhCiNLwyylWCeuyTpG8K
 JjgBt2dv45FjFLFva4e/3Z81OUDjtZ7+uVcCCXfY6h+iMkczIuOvGfZ/nmuW8H4LgXSuC1dhlx/
 /We7K2Jue0GTWZ12xwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220226
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37987-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tamizh.raja@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CCAC6B2D66

Currently, IEEE80211_OFFLOAD_ENCAP_4ADDR is set when
IEEE80211_OFFLOAD_ENCAP_ENABLED is present in vif->offload_flags
at the beginning of ath12k_mac_update_vif_offload().

However, if the WMI vdev set_param for tx_encap_type fails,
IEEE80211_OFFLOAD_ENCAP_ENABLED is cleared but
IEEE80211_OFFLOAD_ENCAP_4ADDR remains set, leaving the flags in
an inconsistent state.

Fix this by setting IEEE80211_OFFLOAD_ENCAP_4ADDR only after the
tx_encap_type has been configured via the WMI vdev set parameter.

Fixes: 729cad3c3c9e ("wifi: ath12k: Add 4-address mode support for eth offload")
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af354bef5c0d..2d539da83361 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10117,16 +10117,15 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
 		vif->offload_flags &= ~(IEEE80211_OFFLOAD_ENCAP_ENABLED |
+					IEEE80211_OFFLOAD_ENCAP_4ADDR |
 					IEEE80211_OFFLOAD_DECAP_ENABLED);
 
-	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
-		vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
-	} else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
+	else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_RAW;
-	} else {
+	else
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
-	}
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, ahvif->dp_vif.tx_encap_type);
@@ -10136,6 +10135,9 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	}
 
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
+		vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+
 	param_id = WMI_VDEV_PARAM_RX_DECAP_TYPE;
 	if (vif->offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED)
 		param_value = ATH12K_HW_TXRX_ETHERNET;

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


