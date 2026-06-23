Return-Path: <linux-wireless+bounces-37990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MfLeF9IFOmrX0AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:04:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E96B3F00
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:04:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AwBSxz3R;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Ak/40jn2";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37990-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37990-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 410FE3029629
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B7395AE2;
	Tue, 23 Jun 2026 04:04:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871339022B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 04:04:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187471; cv=none; b=FEKGl208Ivbtb1Bl/V+JTlAGWUnjw+YaAtpwqg8eQcign+QMAMAJGxM5fRwMl17Y20ZWPglEtjbGJzdgULW3a2DEPENcuXWVdHppqctEDwcVqlR54E9diXOkmBR3l2kotHOv8oHD0c+qA3BEJNFBPsj0zlmJ6hN1LlvcBZnQ0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187471; c=relaxed/simple;
	bh=SnrBM03AFLxRUzzwyfMPj1JvAIk8uzgQEOSpJLR/Eek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hSP1U2W7rMmdiM4D6c4BGYUbmr80o78JeDzEgcM+5a2FEYjGUOyenxPuoeOmLmJwqY+MZzaGkaBxucoNSzyH+efF/5yAjYoQoBKTV2fZOf0GG87B3DMe5dig+grzaDOP7N6X066DSutEtV21poHPkmLZ9ZDbS+vEG8pY4PcXHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwBSxz3R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ak/40jn2; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0hmcl3880370
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 04:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mgWYK/3t4tydqwON+x1o64
	YgIx5N7PNAyLLJ9nxeIqE=; b=AwBSxz3RwV+ZrVTIGqfHoM1r/0AKKSInY5dcQk
	vhk6bOP6A/HnBYB8AGAGk/tz3+2ZTEuxZcRYSX7bq43ggoP0QFMcViyqsosNhX5+
	vrC9HUlpA+7Rl7t5xwv1DpBEArUOhxJyL7dmS7kL31m+dV9xgLG/TNUaws557R1k
	0/NMmVabbaKLkndW4Am/z2yxADfcF30/z45UZtZ8qcE9rpcR2mAcSdDv1bwW+d8F
	nTLYxJHdVnBe00CXdqt1hmN9wPou/PBfEiQo/NDjlK3oFwr+dDCF3cY/rdt5hHml
	uZw1KlhCXYfpy8tMUaJLAJYYEesFi6QX6P7GKWvTpxhogjOQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn2ue3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 04:04:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8422f987f2eso8549507b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782187461; x=1782792261; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgWYK/3t4tydqwON+x1o64YgIx5N7PNAyLLJ9nxeIqE=;
        b=Ak/40jn2qppR6FPjq1uZoU74W2PiPXwlpiLbfQU9i3/6mrVxX48hdVhT9R0KACkcyi
         hcJaLypdHLVcLEwRCodEu1II3z4+A/u7qzXTspkpAaa9jHd8N8TLu2+w5hJxZoAnaao0
         zRY/qwS8aBGnHsRvh9TqnhPJZHF5XYY0u55AArHBlWrRBBV4FgcYGyAx0TsZsDg0/zaH
         g7Bit+u4n5e/gPOqC3eAVjEa+XMDdGKjau35iMfGCWKprQAXmKpig0t0SkvRc0GeMWWs
         EmHPf9kQppMhlYdFV+TC85iXd17Mui9KCwG9SYyaNoPwq1gMuSMHF5my5sGbM7RcaJ0S
         YjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187461; x=1782792261;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgWYK/3t4tydqwON+x1o64YgIx5N7PNAyLLJ9nxeIqE=;
        b=XG1LCciUWxy/DooxMNX1jAoNIBWWM6L41romk6RJiV8RYL5ZEHHpp53aOfADhUrCvH
         QGC6grVc6vpvTJiCkiSVYqmdyS+/557/WmfLbOenGblid045oMczsDgH/PXAfeN6S19U
         RupXK4BkwHVcMSiuKYHsIia/rnvRK9PbOYLi6t0xNn2+1q8YUcJf2Eia+QWfXn/mZGi0
         sYrwxMTBtJB37ncM4tAOn4ClT1kZxHcUZBI+cEAkxsSD6TP6fkVgHfKfLcipMW0nXpf7
         ympDaz2CY8bYW48qdss2DOhVWC5vw1mwzBHQB0ooUEGT91TjabEUPZ7JtQO4hyjjAHYA
         vcIw==
X-Gm-Message-State: AOJu0Yw6zacHYA6IMkvTwMwlorIBDTolcBYkYXgCzY5ydbGITddw8JgL
	graqHB+H02halhTYe+d3L4tY1N1cnz//Bgeijla1bcl5mQf19gNgGAgACFI3R9yu/l/6iBKkEkr
	3C6UDWTF3iUxQjED+0iRc4Suw3E0fxwPMYYChrsCqkD6bDBioSuToSX4VNo84u00vYl4YyQ==
X-Gm-Gg: AfdE7cnrBrBpxqKiCgnUbyhF5L8qpYthv5K9e5cZDXhEg18lTWA58FF3OiPOituEVXl
	z/uM6DgOBKvEy3PplCty8Qq6aQiKeAn/lWUYaI72e1MYrd9RuqOgCjIDG7oAe8sw26aLHpg/soZ
	Ge2d8zq8h9xwr8OG2GtwsBCA3JszxfU6BZkfQpEY0TSt9uJjBARN1t+pts2z2E1R9rb9YEbHn+P
	0cnjy6NiDbgkRcjMeSd48hIedJ3IRqKoUw/x1uGx9QVtAi0rZbiPQSwngY77oAGESIPI5jt7fCI
	2dVSi4GJkj3wc1GwXL6g0yE5JIPTsT0eatKa2//ByqH+s5H18sEtizkmbdgNci6gGIs9GMrkClP
	vhyjQUEFPvQ+kQZX5XXPRDITCz4WWfDP2Y2WUUJXtcdCTklFfSuGn3K7/Iw1rfZ5T1j9QBgvFzf
	HdTC81nkwUexZ4YG2N4pMOFAIO5d+w
X-Received: by 2002:a05:6a00:1d8b:b0:845:17a6:5741 with SMTP id d2e1a72fcca58-84595210aa1mr1311529b3a.1.1782187460843;
        Mon, 22 Jun 2026 21:04:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d8b:b0:845:17a6:5741 with SMTP id d2e1a72fcca58-84595210aa1mr1311496b3a.1.1782187460363;
        Mon, 22 Jun 2026 21:04:20 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6bf73sm9156325b3a.5.2026.06.22.21.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:04:19 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 09:34:17 +0530
Subject: [PATCH ath-next] wifi: ath12k: use %u for unsigned variables in
 QMI debug logs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMAFOmoC/x3MQQ5AMBBA0avIrE3SliCuIhatjpqEokUk4u4ay
 7f4/4FIgSlCmz0Q6OLIq0+QeQbDpL0jZJsMSqhKVKrAfWG0ZE6H8+qwtqJWsjSjbAykZgs08v3
 /OtDHhJ7uA/r3/QBPihdgaQAAAA==
X-Change-ID: 20260623-qmi-debug-log-7d07214bf18b
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: HDja-lgLDOTvmwyPhgnjqiNuguAGFqh8
X-Proofpoint-ORIG-GUID: HDja-lgLDOTvmwyPhgnjqiNuguAGFqh8
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a3a05c5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=sI5m5gy1iff1vHILgfUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfXz/9EcIToibCQ
 ZTaBwdn4PuAfNG5pbMOUBBq0FHXdxYe3R3txpUCbl41mJMjjB2weEeO4+UEawe/XjEDArmkgdN1
 Sh7nimT2Wm/KL+n3N5S13rj7nSAsWQs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX1tYVuc99uVOH
 x4l3gBtpV2Apvwv0r0pAkvcWk/tz0uu8uI6n/FbnZreICxVXWfmrlS89/BAlCpwuB+YiokQHD+2
 8Y4J6OB7GllenlTsFVLOTeWosCNqss8GE9xhgrT8CFMTuCn0TPcasZ8iCRD3SpjEpPXAbWb5CSp
 ykD2h/yKAyv6q+OVrwRmz3byr9daaHAJtUqpRCHdDHS3AAc8XH/7nfFonnLf95aRGMev5s6uy4B
 FyIPM7HqYAWgtjtP6v9BbSReiBFWwTkb+e2vtcMMH5GeBV/hMrm7XusUZGixS28z35eFS0nF/5a
 lYIPkCzl6V4Z8VqsgkFolXZXcEfpTK5bO7EwT4egdUpGJdnwcFxbJDusl0sAwxtv4rLSzHJVpZK
 4Bq8JJAAf4NiLFiPX/g4XW+WYrSjn3KScibHUUSbUZozEN5cj0pziJRWHFCyTtmAfjUDy1yu9TX
 reTPnvydfEMmLecosng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230029
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37990-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:raj.bhagat@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 145E96B3F00

Replace incorrect %d format specifiers with %u for unsigned variables
in qmi.c debug messages. Also add missing trailing '\n' in log messages
to ensure proper termination. No functional change intended.

Tested-on: Compile tested only.

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 70 +++++++++++++++++------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..b9a606c8ec82 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2094,14 +2094,14 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 
 	if (!ag->mlo_capable) {
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
-			   "MLO is disabled hence skip QMI MLO cap");
+			   "MLO is disabled hence skip QMI MLO cap\n");
 		return 0;
 	}
 
 	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
 		ag->mlo_capable = false;
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
-			   "skip QMI MLO cap due to invalid num_radio %d\n",
+			   "skip QMI MLO cap due to invalid num_radio %u\n",
 			   ab->qmi.num_radios);
 		return 0;
 	}
@@ -2125,7 +2125,7 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_num_chips_valid = 1;
 	req->mlo_num_chips = ag->num_devices;
 
-	ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo capability advertisement device_id %d group_id %d num_devices %d",
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo capability advertisement device_id %u group_id %u num_devices %u\n",
 		   req->mlo_chip_id, req->mlo_group_id, req->mlo_num_chips);
 
 	mutex_lock(&ag->mutex);
@@ -2146,14 +2146,14 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 		info->chip_id = partner_ab->device_id;
 		info->num_local_links = partner_ab->qmi.num_radios;
 
-		ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo device id %d num_link %d\n",
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo device id %u num_link %u\n",
 			   info->chip_id, info->num_local_links);
 
 		for (j = 0; j < info->num_local_links; j++) {
 			info->hw_link_id[j] = partner_ab->wsi_info.hw_link_id_base + j;
 			info->valid_mlo_link_id[j] = 1;
 
-			ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo hw_link_id %d\n",
+			ath12k_dbg(ab, ATH12K_DBG_QMI, "mlo hw_link_id %u\n",
 				   info->hw_link_id[j]);
 
 			hw_link_id++;
@@ -2268,7 +2268,7 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 		goto out;
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "Host capability request failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "Host capability request failed, result: %u, err: %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2320,7 +2320,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	ab->qmi.num_radios = resp.num_phy;
 
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
+		   "phy capability resp valid %u single_chip_mlo_support %u valid %u num_phy %u valid %u board_id %u\n",
 		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
 		   resp.num_phy_valid, resp.num_phy,
 		   resp.board_id_valid, resp.board_id);
@@ -2332,7 +2332,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	ab->qmi.num_radios = ab->hw_params->def_num_link;
 
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "no valid response from PHY capability, choose default num_phy %d\n",
+		   "no valid response from PHY capability, choose default num_phy %u\n",
 		   ab->qmi.num_radios);
 }
 
@@ -2393,7 +2393,7 @@ static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 	}
 
 	if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "FW Ind register request failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "FW Ind register request failed, result: %u, err: %u\n",
 			    resp->resp.result, resp->resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2428,7 +2428,7 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	if (!test_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags) &&
 	    ab->qmi.target_mem_delayed) {
 		delayed = true;
-		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi delays mem_request %d\n",
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi delays mem_request %u\n",
 			   ab->qmi.mem_seg_count);
 	} else {
 		delayed = false;
@@ -2474,7 +2474,7 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 		if (delayed && resp.resp.error == 0)
 			goto out;
 
-		ath12k_warn(ab, "Respond mem req failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "Respond mem req failed, result: %u, err: %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2606,13 +2606,13 @@ static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
 		if (chunk->size > ATH12K_QMI_MAX_CHUNK_SIZE) {
 			ab->qmi.target_mem_delayed = true;
 			ath12k_warn(ab,
-				    "qmi dma allocation failed (%d B type %u), will try later with small size\n",
+				    "qmi dma allocation failed (%u B type %u), will try later with small size\n",
 				    chunk->size,
 				    chunk->type);
 			ath12k_qmi_free_target_mem_chunk(ab);
 			return -EAGAIN;
 		}
-		ath12k_warn(ab, "memory allocation failure for %u size: %d\n",
+		ath12k_warn(ab, "memory allocation failure for %u size: %u\n",
 			    chunk->type, chunk->size);
 		return -ENOMEM;
 	}
@@ -2659,7 +2659,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 			mlo_size += chunk->size;
 			if (ag->mlo_mem.mlo_mem_size &&
 			    mlo_size > ag->mlo_mem.mlo_mem_size) {
-				ath12k_err(ab, "QMI MLO memory allocation failure, requested size %d is more than allocated size %d",
+				ath12k_err(ab, "QMI MLO memory allocation failure, requested size %d is more than allocated size %d\n",
 					   mlo_size, ag->mlo_mem.mlo_mem_size);
 				ret = -EINVAL;
 				goto err;
@@ -2668,7 +2668,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 			mlo_chunk = &ag->mlo_mem.chunk[mlo_idx];
 			if (mlo_chunk->paddr) {
 				if (chunk->size != mlo_chunk->size) {
-					ath12k_err(ab, "QMI MLO chunk memory allocation failure for index %d, requested size %d is more than allocated size %d",
+					ath12k_err(ab, "QMI MLO chunk memory allocation failure for index %d, requested size %u is more than allocated size %u\n",
 						   mlo_idx, chunk->size, mlo_chunk->size);
 					ret = -EINVAL;
 					goto err;
@@ -2699,7 +2699,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 	if (!ag->mlo_mem.mlo_mem_size) {
 		ag->mlo_mem.mlo_mem_size = mlo_size;
 	} else if (ag->mlo_mem.mlo_mem_size != mlo_size) {
-		ath12k_err(ab, "QMI MLO memory size error, expected size is %d but requested size is %d",
+		ath12k_err(ab, "QMI MLO memory size error, expected size is %d but requested size is %d\n",
 			   ag->mlo_mem.mlo_mem_size, mlo_size);
 		ret = -EINVAL;
 		goto err;
@@ -2884,7 +2884,7 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "qmi targetcap req failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "qmi targetcap req failed, result: %u, err: %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -2936,7 +2936,7 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 		    ab->qmi.target.chip_id, ab->qmi.target.chip_family,
 		    ab->qmi.target.board_id, ab->qmi.target.soc_id);
 
-	ath12k_info(ab, "fw_version 0x%x fw_build_timestamp %s fw_build_id %s",
+	ath12k_info(ab, "fw_version 0x%x fw_build_timestamp %s fw_build_id %s\n",
 		    ab->qmi.target.fw_version,
 		    ab->qmi.target.fw_build_timestamp,
 		    ab->qmi.target.fw_build_id);
@@ -3006,7 +3006,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 		if (ret < 0)
 			goto out;
 
-		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi bdf download req fixed addr type %d\n",
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi bdf download req fixed addr type %u\n",
 			   type);
 
 		ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
@@ -3023,7 +3023,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 			goto out;
 
 		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-			ath12k_warn(ab, "qmi BDF download failed, result: %d, err: %d\n",
+			ath12k_warn(ab, "qmi BDF download failed, result: %u, err: %u\n",
 				    resp.resp.result, resp.resp.error);
 			ret = -EINVAL;
 			goto out;
@@ -3036,7 +3036,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 			temp += req->data_len;
 			req->seg_id++;
 			ath12k_dbg(ab, ATH12K_DBG_QMI,
-				   "qmi bdf download request remaining %i\n",
+				   "qmi bdf download request remaining %u\n",
 				   remaining);
 		}
 	}
@@ -3127,7 +3127,7 @@ int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 			release_firmware(fw_entry);
 		return ret;
 	default:
-		ath12k_warn(ab, "unknown file type for load %d", type);
+		ath12k_warn(ab, "unknown file type for load %d\n", type);
 		goto out;
 	}
 
@@ -3239,7 +3239,7 @@ int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 	if (ab->hw_params->fw.m3_loader == ath12k_m3_fw_loader_driver) {
 		ret = ath12k_qmi_m3_load(ab);
 		if (ret) {
-			ath12k_err(ab, "failed to load m3 firmware: %d", ret);
+			ath12k_err(ab, "failed to load m3 firmware: %d\n", ret);
 			return ret;
 		}
 		req.addr = m3_mem->paddr;
@@ -3269,7 +3269,7 @@ int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "qmi M3 info request failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "qmi M3 info request failed, result: %u, err: %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -3364,7 +3364,7 @@ int ath12k_qmi_wlanfw_aux_uc_info_send(struct ath12k_base *ab)
 
 	ret = ath12k_qmi_aux_uc_load(ab);
 	if (ret) {
-		ath12k_err(ab, "failed to load aux_uc firmware: %d", ret);
+		ath12k_err(ab, "failed to load aux_uc firmware: %d\n", ret);
 		return ret;
 	}
 
@@ -3394,7 +3394,7 @@ int ath12k_qmi_wlanfw_aux_uc_info_send(struct ath12k_base *ab)
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "qmi AUX_UC info request failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "qmi AUX_UC info request failed, result: %u, err: %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -3426,7 +3426,7 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 			       qmi_wlanfw_wlan_mode_req_msg_v01_ei, &req);
 	if (ret < 0) {
 		qmi_txn_cancel(&txn);
-		ath12k_warn(ab, "qmi failed to send mode request, mode: %d, err = %d\n",
+		ath12k_warn(ab, "qmi failed to send mode request, mode: %u, err = %d\n",
 			    mode, ret);
 		goto out;
 	}
@@ -3437,13 +3437,13 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 			ath12k_warn(ab, "WLFW service is dis-connected\n");
 			return 0;
 		}
-		ath12k_warn(ab, "qmi failed set mode request, mode: %d, err = %d\n",
+		ath12k_warn(ab, "qmi failed set mode request, mode: %u, err = %d\n",
 			    mode, ret);
 		goto out;
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "Mode request failed, mode: %d, result: %d err: %d\n",
+		ath12k_warn(ab, "Mode request failed, mode: %u, result: %u err: %u\n",
 			    mode, resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -3536,7 +3536,7 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "qmi wlan config request failed, result: %d, err: %d\n",
+		ath12k_warn(ab, "qmi wlan config request failed, result: %u, err: %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -3580,7 +3580,7 @@ static int ath12k_qmi_wlanfw_wlan_ini_send(struct ath12k_base *ab)
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
-		ath12k_warn(ab, "QMI wlan ini response failure: %d %d\n",
+		ath12k_warn(ab, "QMI wlan ini response failure: %u %u\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
 		goto out;
@@ -3663,7 +3663,7 @@ void ath12k_qmi_trigger_host_cap(struct ath12k_base *ab)
 
 	spin_unlock(&qmi->event_lock);
 
-	ath12k_dbg(ab, ATH12K_DBG_QMI, "trigger host cap for device id %d\n",
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "trigger host cap for device id %u\n",
 		   ab->device_id);
 
 	ath12k_qmi_driver_event_post(qmi, ATH12K_QMI_EVENT_HOST_CAP, NULL);
@@ -3833,7 +3833,7 @@ static void ath12k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 	for (i = 0; i < qmi->mem_seg_count ; i++) {
 		ab->qmi.target_mem[i].type = msg->mem_seg[i].type;
 		ab->qmi.target_mem[i].size = msg->mem_seg[i].size;
-		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi mem seg type %d size %d\n",
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi mem seg type %d size %u\n",
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
@@ -3954,7 +3954,7 @@ static int ath12k_qmi_event_host_cap(struct ath12k_qmi *qmi)
 
 	ret = ath12k_qmi_host_cap_send(ab);
 	if (ret < 0) {
-		ath12k_warn(ab, "failed to send qmi host cap for device id %d: %d\n",
+		ath12k_warn(ab, "failed to send qmi host cap for device id %u: %d\n",
 			    ab->device_id, ret);
 		return ret;
 	}
@@ -4024,7 +4024,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 				set_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags);
 			break;
 		default:
-			ath12k_warn(ab, "invalid event type: %d", event->type);
+			ath12k_warn(ab, "invalid event type: %d\n", event->type);
 			break;
 		}
 

---
base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
change-id: 20260623-qmi-debug-log-7d07214bf18b


