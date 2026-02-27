Return-Path: <linux-wireless+bounces-32237-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGqbA68QoWlDqAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32237-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:34:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DD1B2491
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB0230CE869
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5132F747;
	Fri, 27 Feb 2026 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FpBRxcSH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4OohWO7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B732A3C8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163222; cv=none; b=DZNAYJL7KeaYOQjFm1I9PYC5L2ieT9doSG1nS2F+3qcnIttG9nuuN8tCLVcI1b4CxUXBjLHjOKhjKwFSnqiyHTN9EPuUbvo/su0BOPms8p+839pdlvJKIw2ban3EmXGBK4k6RuEY/feTdrpv7JvuC+EQ0901VJb0XqHQB/LgDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163222; c=relaxed/simple;
	bh=I/NoGpsqp0ZqEz8l2zrax4JuDLlzvdmsKINaoYV1fDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvOrsAdNKZQueH8WC3zdfHNbgyuUsnwEvwgAj2qnPQEutt/ZM2XDbdwGDOwUlnphir/D57x/r4b0rQzsSVRivuiimPEfKWt+O15kbfRW7vpvUtLvZv+EfQPZM05CzPFv/nQvlB6t+CJFw6UMtzOgmALcc9PGccblibR0yjWrTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FpBRxcSH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4OohWO7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2KObt2414860
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 03:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fthulbMmfgEPDlzeBPVe8KBnGhtcRrCDvqB
	cv6i/VHM=; b=FpBRxcSHM3bTkG8PKTjjDUYZNCBa4lMm54B/3A+aUYfZUF5LmJ7
	bZhggXwGSX25J2XARAuw0MRxMZVQVG2PtqX7KJtJXjurcNLXyrgUiNW4ZdoyvDje
	AE6EP4aXdJKcCP1akxUjQeO9Mc1UY0I6RFueEW5DFuNiGLKMdYNWXAjomb1kyxQz
	mOaoQpDhlVRNi+BgpS5Ugv4psMwv8+3Unvu2zShBysQjt3Qq2Jl+GvDGrC8XONVP
	BYo4uCXV+LKPpEW54nluxqic2v2eQ8JRliH6oL6Ba2RwZNCERura9eri71NzwgH5
	EOcRRAPmlzF56wyWg0PO5eANC216p3HWEaA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjc0gctw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 03:33:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2add1118c19so9685465ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 19:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772163220; x=1772768020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fthulbMmfgEPDlzeBPVe8KBnGhtcRrCDvqBcv6i/VHM=;
        b=Q4OohWO78kuB+1XEgTyJRbNK5S6ywH0Dok+t0p6LGyN4rVaSpMSqpXo3MxcTwh3QvL
         FKqefhX8IwlDLbDxvkphi+yhci+M0F+cmjT/kxeYeS+sWr7oOR0x/tzcjimhl7WplBgJ
         vVuY+NxDpRkChCHibetwKOfHVrSUhOsqsj7UsDCtDxbwv5v3562jQslIcI2vmUZ/Z9wI
         H6RWX+5QcoZ0xcRfaX36yhoQGuBB8bNwVfV2MMCgql6O9UiougLyPTkdkhF7w+B+gGFn
         WMwOtSZYrO8mEP1IUPettbhoJOgxlZBKGuQOuxZiJZ4Z8vl7higLq45Q62gJ0PzBGaOD
         k8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163220; x=1772768020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fthulbMmfgEPDlzeBPVe8KBnGhtcRrCDvqBcv6i/VHM=;
        b=u43bHaGXEwI8bJ/7sdYlLRMw4tVFUUz4yP8FDY2Miwpq2efhbcGaYWT2BNVpac0e8V
         4v8A5USmUHGgxrKTUgcWY3lLMFs9bmbi7khjLGx75QQJQYo/rPlMnKKVOV9ZjMhDr58D
         LBSa9q6rf6u3G5dZIUiKqlLLQFZooumQcWrG8PdKY2hA6w7PmtZ0p0efN/AuG8LIFO9t
         rRVdVMPV/zlxRR8jOsHHl/b1G9Q03yixnTalozcWiwfbcDc5AOYvXDWy/sHw+n6mhmGU
         rjGROwj8u6ndJetfQEjxBP+HUnpRLW8ymptT20mBHRp9pPrAgZBDdRfjjiAO4VTextei
         KMtg==
X-Gm-Message-State: AOJu0Ywqv54ZdVRBjvV8OkoCUxjYsO+5F4lv41c7uv/DouXcVdpvQeP4
	wopyrwzHHFzKwARGpPYQGCwRC2yd+mRbdbSBzQ5aXAUq6+jWGvlyBwM8JAJNqKg8y6V+aBngqDf
	H/jVd2nLUKGbEq/059XHML1fh07sXqUptqY+Mdv4UvuAX4K+M1rXhYvvzJmxVRlDYg8kJBA==
X-Gm-Gg: ATEYQzxwcN+dM/sld1hg4Dx2nlm0pXvSqNWYGaKsLv54H2UYlIPkRhwiiCrndgglh3b
	oojsLvUkjwB1qIUTuLFk8rP4by4tfi2EkO5AUtq4t96tn6QNeARkzw/tXvW3smlWrbdU1abO9rr
	7rO3LZg/S2smnkgq+9vbKCBbY/4imL5u7zBpsh/I/hxv64OR6IW2n2XRlDHF9r/0lOLmmqh07CK
	JaptCjjkbqAi9bQEDW3BV+FCYPeWuPjGWFU6G4yOWQ/w20BZFjBpY8Dh7N3Hv3JRQslLMtuhvRw
	5uTZtzy+sCBvv3WenGNGfpF5txoFVyXuvgLbHuyseHlQwSz/L3S57F9AOGacheBMwq4/xXU2KcG
	SvBvjMMINVUNr/DHRQ9O2i8ZIwYpdyWJjtVPVmJln+3+luwrjCRqdCq+32VtC0Scwk54vIRmOhU
	EUMQGeaM1nSFjzcNQjPCSx5hDlqXWsQkmLoIFB6104aXbF
X-Received: by 2002:a17:903:4b07:b0:2ad:ad0f:bbbe with SMTP id d9443c01a7336-2ae2e4b0a5dmr14331555ad.29.1772163219692;
        Thu, 26 Feb 2026 19:33:39 -0800 (PST)
X-Received: by 2002:a17:903:4b07:b0:2ad:ad0f:bbbe with SMTP id d9443c01a7336-2ae2e4b0a5dmr14331285ad.29.1772163219221;
        Thu, 26 Feb 2026 19:33:39 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b03ffsm51839355ad.1.2026.02.26.19.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:33:38 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Enable monitor mode support on IPQ5332
Date: Fri, 27 Feb 2026 09:03:32 +0530
Message-Id: <20260227033332.687805-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XI49iAhE c=1 sm=1 tr=0 ts=69a11094 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hQIrOB1egfdVivMeMI8A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAyNCBTYWx0ZWRfX2P/Hfmt7Iwb5
 faJD8Ngx8BA8+4lOXTwXDltavI0zTe0bUm75xJdgzw9LsymP6T8RgmC04W7g7uUNNIMPQSOOE8o
 m30LHhpsybMUa/Xta+yvvjx6Jz+i1/UKYjj5nCzVFMYTFH96itF6AYVd3hBhIxNAFagBcBYY3fE
 N7W2aAhde1kctLK+QeGtkpsZln8rEGOGY+gtAOQrs8QonoO2gem+BQb3CPogIC3Wy6k6/rKLgPi
 qnDG1K6aN29zWogOb0CHmia8WwF31DeOw9Uee8hnk7q6DXRYPfS5L7s2M8Y7Xwj8a3tZpyL+Nd6
 AzUdfyGqpm9caYenSNUnRjrhHyxnxZK5POU61ZocAm/NGfqoclwYVJ/PG+bncOWNJ/mGe69+uYD
 Buhz4q038egyFu6GojFs7ai+FwVv4C5WIK2yaKSRzZ/CSQoxBw0hsHMyG7/ZoVd4GTBEzuSQq+Y
 ix3aw0kabvZZ/gXIZqA==
X-Proofpoint-ORIG-GUID: fpue6pl4klMYXSxGEOPZXL84M1JBx2gY
X-Proofpoint-GUID: fpue6pl4klMYXSxGEOPZXL84M1JBx2gY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32237-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 642DD1B2491
X-Rspamd-Action: no action

Currently, rxdma1_enable and supports_monitor are set to false in
IPQ5332 hardware parameters, which skips monitor ring configuration
and removes NL80211_IFTYPE_MONITOR from the supported interface modes.

Set rxdma1_enable and supports_monitor to true so that monitor rings are
configured and monitor mode is enabled on IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.7-00587-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index df045ddf42da..27acdfc35459 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -617,7 +617,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
 		.svc_to_ce_map_len = 18,
 
-		.rxdma1_enable = false,
+		.rxdma1_enable = true,
 		.num_rxdma_per_pdev = 1,
 		.num_rxdma_dst_ring = 0,
 		.rx_mac_buf_ring = false,
@@ -626,7 +626,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				   BIT(NL80211_IFTYPE_AP) |
 				   BIT(NL80211_IFTYPE_MESH_POINT),
-		.supports_monitor = false,
+		.supports_monitor = true,
 
 		.idle_ps = false,
 		.download_calib = true,

base-commit: 20ad0d58517073b3b683ff786c65dd3142321707
-- 
2.34.1


