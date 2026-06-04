Return-Path: <linux-wireless+bounces-37374-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8QdCKgZOIWqiCwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37374-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:05:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 420CB63ECD1
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cSD8pd4t;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MBDUFie1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37374-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37374-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2FBD30953A4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003B1E22E9;
	Thu,  4 Jun 2026 09:58:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2520010A
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 09:58:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567138; cv=none; b=T60f5pJXCmq9wEGe0+ULEu+QyeALrWs6pNAunmcS1Xo2EZSivPi7IDZ/Vt7C1dA/uH5M1keBRHQ+iLhX9k1J2BdBNMp8O3erWljLZeEfdcd2C6sf1IOMpLACIud3vHzEq3xbXhU3lR4WtBul/17lnHS/IDzS2mJ6Z1Mro259CHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567138; c=relaxed/simple;
	bh=G3NYVeLJID/oR9sytSL3N3k6co8tEk5XVZ2CCueXaOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmBXI4uVgF0kWCYSOVHzZbKq+om1Ya+rs56Y3gLWiLbD9knJTMto7Hxr90eMahE0XqDpUmv7hMteKyfznWd8FgAnwQh7+tVGvdQ8wcq4WB5hz2a7nMxbvSuwlxaoNTojhxASHbQ56S7I23hFvIju1Vzz4WVFnEXDBxecgMbJfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSD8pd4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MBDUFie1; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6549NYbi2262005
	for <linux-wireless@vger.kernel.org>; Thu, 4 Jun 2026 09:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=muhimI+VyPQWL9gHHLyisz5qiD0UZSwxGEQ
	f6ZfTf2s=; b=cSD8pd4tqEovszlXqIUWCZ73ExCvICtcNM5DFEanOnoL0AFPyTf
	U4Ti3KctpLGmOXgG+x1jLVwecCNhhbMjVksYMl+kruJlQflcVeISqFWp9ofOiY8z
	jhgz1s/bRef1rJrQBKm5I9JS9ezAHjFinW8dqqsEhfwZ0cpvZu9jlNW/9yCzJ7dL
	UHhCOV3MJcCxjC7u83i23wmoCmh2BBMYc+ZNSHuHm/XbDPvgGEdBnwM9Y6HLymo3
	bD9ve/wq7r2Pm4TkMUwFxGoC94F7WQfHY3luEBUMX/gYu3ZVAy0SDlpBpYS9tUFh
	MWlAczkcpWeZNid2Ke0H0vJ8+BHBNLsMiXw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mkgd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 09:58:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85c530ddebso376077a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780567136; x=1781171936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muhimI+VyPQWL9gHHLyisz5qiD0UZSwxGEQf6ZfTf2s=;
        b=MBDUFie1EOvGPv9F0YfbGoJC7XQnFDUnS1Q2OKOiN1fqp/zpix3Y19pqPVFMJQeaDK
         V/lTQrfmqCgC3L8xoQfDyGKyXd+rJ+UV2RMGQefQ31zjIrf3KoQKeBURGdN54Z/XG63j
         HxMUElU0mGWNH+QJ8AhjLp3P3p+FjxymIgO4pqghfr2dEk66WRAe0gb/IK8/X/28+jdu
         UxNKVCtFoie+16cTZuFHi1BBzjZOzBJNFitgazvSZ5iqS1J+C2DmDqqFCUr9UuBrBwi5
         k3YhCRcjM1yDltqWwmd6eB2hRYgzklsRSNnXHc8yJYYOzq2OYLu+4XQfgk2zpJpyMJK4
         5viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567136; x=1781171936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muhimI+VyPQWL9gHHLyisz5qiD0UZSwxGEQf6ZfTf2s=;
        b=KWth9gZhc8Uq0Fsild9THDVcWyxNr1wDHsMxuiuegR7/UHdPIWFubJdNLgLfM4VtEm
         rX+AUcxQbJ0SDIjMbZmfEhUWepeFm8NEQYVmUaa61OYJUPjJQ2PX8cszy5xjQkePB/HD
         b1oWJAdur0XR0deIIXhVWx5h4V4YUEBIbDaQD/1DMu8q3XUg1gZ2zD9WwWpAwQTCbhAf
         i/XLJ14erIFZ2NhetMRlvg+DggcHlGIleqfhoP3VLVgEf8J4Zv6IbjEtS0UvMQVRfB2W
         G2ByC8ZCUo078MzHgobsjwqC4cnPjJ1rW1Z1gb5lmDAa7mflSSAFkpSkXkBHHRGTdE+t
         BZxw==
X-Gm-Message-State: AOJu0Yz8Yu16M0vYaydupN/8BktsM8bly2FUbvmIXftjCPZ0vuQHcv12
	QAAJzRy5BHVrNlXxbhPnQ0UBmQG7XGKEso44vxxuvQH9uLmsLgjEW9ktY4JzZIf8OG7FUvKDegu
	53YKF/F+JrAxQNb6Rk1kAQ3PFQiMq82mZqXSsATPLtVJNEFCWQ+H3HPgb442dH7f8GiODTw==
X-Gm-Gg: Acq92OGbqWJR68UY/cIQGb0ehWghhxVrybAlrXy8895nGRWAybXgsDmyBuH3Jrk4VXZ
	myeai6BFSM1j4R9QmetVhd4zaFBZQo3TDCsTj7A6HyD2yjm3cUTIVijsJ0/B53xx+LIj+zV7Rgn
	BKq55U5KcYkfG2ALFy30X8ZA3aeeP5BqU/ZIeBQ5ADaWV17+LQyECBv2ry7egQ42FNecuHowm7Z
	Tt7wTQpvzerMZXStyOueC183pYMJlSOcSTImidBD7HmRsMqFHhUCmdFDdX+GJiCtJ3twnguPOgL
	8m59RZa+Tky3lGh7GYTJUExpAclNNmSb/o5QUoUags118uvIFG2HLhnKgCRqaYFCa+G5QFlzvrW
	39EDSprRzV9HCbj/Olzt7Xt9hxRoVivG6Mle0pJNHUpJwo3YoqOv7Y0PeioHBPdTqQ+yXocuyg3
	w6TzxjDsvJ9omcr0Ngbj8cPSM4LSZLk2TAXA1YpBEZyjeAerRAH3unh6MLIF6I2rqm1g==
X-Received: by 2002:a05:6a21:9090:b0:39c:5624:ee53 with SMTP id adf61e73a8af0-3b4975f9c42mr8093035637.24.1780567135935;
        Thu, 04 Jun 2026 02:58:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:9090:b0:39c:5624:ee53 with SMTP id adf61e73a8af0-3b4975f9c42mr8093021637.24.1780567135432;
        Thu, 04 Jun 2026 02:58:55 -0700 (PDT)
Received: from blr-siroccolnx01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03387asm4881500a12.4.2026.06.04.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:58:54 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported
Date: Thu,  4 Jun 2026 15:28:31 +0530
Message-Id: <20260604095831.2674298-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gtYzA82XMe8yuR06YRQZZZfau-Ujlcp7
X-Proofpoint-ORIG-GUID: gtYzA82XMe8yuR06YRQZZZfau-Ujlcp7
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a214c60 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=LpQP-O61AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=d00PuZDYcvi_FAvzKJQA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=pioyyrs4ZptJ924tMmac:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX6qmyzqgHHWie
 rY9hm7JVBUQaJOq4MJZdAMryzZ/htvPHuNOQyXR4ifUxcboctVe6Dh6BwgzDk/hivuCEje3sQ/u
 YiMMgpUm8fw8AMpU65xB3CNjcu4CP0x/Zajb9c7PrD3CpdvGCmkuITxZhXLlNQmzsOOvJzp/d/r
 o8iR1Gfe/OfTtyRg44F/otKpFeZ3KY/ZNNFXw8kL+MwP9+er976AyA/GX66uKT4S2+HNQZsFpff
 TbnCm25YdKT536/kBFjoqaGdbOfuHM+bQMCdZWoIS9MRurXLiE2VUHsi3OnOTRkjFFycCM6ja6a
 BJe19Ya7PrDaL5ctonKDipaeva/v/1zD8c36b37Na7nVqB0dgSiWqrg4q692ODHE2wxDL1m35pG
 xp8yXtSO9zci0AdAz/Rxmn5K6mRQG4ASutswnnIc3MqgaZtAGXFj9gU2cCKHNYEFMroYN0it3ZP
 refiqXo+dZxhH21FRFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37374-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:quic_wgong@quicinc.com,m:maharaja.kennadyrajan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 420CB63ECD1

From: Wen Gong <quic_wgong@quicinc.com>

When firmware reports NSS ratio support, SUPPORTS_VHT_EXT_NSS_BW is enabled in
ath12k. However, IEEE80211_VHT_EXT_NSS_BW_CAPABLE must also be set to make the
advertisement valid.

According to IEEE Std 802.11-2024, Subclause 9.4.2.156.3 (Supported VHT-MCS and
NSS Set subfields), the VHT Extended NSS BW Capable bit indicates whether a STA
is capable of interpreting the Extended NSS BW Support subfield of the VHT
capabilities information field. Advertising extended NSS BW support without
setting this capability bit is therefore invalid.

Without this change, mac80211 detects the inconsistency and logs:

  ieee80211 phy0: copying sband (band 1) due to VHT EXT NSS BW flag

This indicates that mac80211 implicitly aligns IEEE80211_VHT_EXT_NSS_BW_CAPABLE
during ieee80211_register_hw(). Explicitly setting the bit in ath12k avoids this
fixup and ensures capabilities are advertised correctly by the driver.

This change follows the same approach as the existing ath11k fix.
https://lore.kernel.org/all/20211013073704.15888-1-wgong@codeaurora.org/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: 18ab9d038fad ("wifi: ath12k: add support for 160 MHz bandwidth")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a6e4b660da81..af354bef5c0d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8489,6 +8489,10 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
 	vht_cap.vht_supported = 1;
 	vht_cap.cap = ar->pdev->cap.vht_cap;
 
+	if (ar->pdev->cap.nss_ratio_enabled)
+		vht_cap.vht_mcs.tx_highest |=
+			cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
+
 	ath12k_set_vht_txbf_cap(ar, &vht_cap.cap);
 
 	/* 80P80 is not supported */

base-commit: 565257a857690244211d85593b2cd490ce86783a
-- 
2.34.1


