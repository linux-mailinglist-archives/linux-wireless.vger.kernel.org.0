Return-Path: <linux-wireless+bounces-32176-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDZhHBrinmmCXgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32176-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 12:50:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E5196E3E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 12:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2653303A133
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA339449D;
	Wed, 25 Feb 2026 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyKWrY+3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVwtQr0Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D053ACA59
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020174; cv=none; b=qhPFZ2k6Y59C8tW0pVjMmabI2tbTLwjnFRBB+xG4dONcFrA+BmJEZklfAi+i1OwNdI3B74zeupBysE73EdpMjFlM0h8CCKft9RYyZzaWKZyX832xb8TBq8Na0833dE7KjFuWeU/ApO3QBZzf7HEdbaaBXAJO1pdiWOYA/h88IeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020174; c=relaxed/simple;
	bh=XsaQyR4cgUPLh+0snsHlbwwGOxFsmQOfnGqzXsQyQDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E2wsVd9HimL8nLSun5LRW19yvvXYMNTfFmT7YXe+0MKJoJzdTy6y7m35ouUr0FZx4gVvT90X7IYVoJepeJ2Rn70LAEmEZocEgdgzMpbtTJ/rlnduMlccf0MWCHoCnz9JuYOwQApZu7OM6VFwFn4iRnfb8Ux8nlNxC458TJv7er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyKWrY+3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVwtQr0Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PB3Q8F1512005
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 11:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GMadxPYeeGMAc9obR7DlAd1ejOg9CPu2y0r
	OMiz3SwQ=; b=lyKWrY+3Bx7tF533llt3wYhAEzcW1VXg7i41i2JcuLdbROzAGwf
	GW4RQCJCyZTWMeRF3OHtsvXR5ZbswvKCac02HjHxA54q6l2rXj6DNBkMxlklkTNz
	6qPlsrQlMT/R1wBL0/KSXlhbMIvr/Jwoi2nkObDhOGm+HKNFTj7q9sgLif6xO445
	w+WcH/hkJ1jnordEKcQKeoTkE4ZSJwI41Y20X2rtUHWwYxJguchkm0c/qHiQDkmO
	rlK6dz0F0jGk8fpuE++KRnAUyjDwJN5hty6JyCxJ48BnjxSssGCl+7m34vg2JKD9
	CVypFLDxA2WGdHitYmzd20FiJMDQxZqrzQw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf03ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 11:49:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35626b11c51so5209392a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 03:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772020169; x=1772624969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMadxPYeeGMAc9obR7DlAd1ejOg9CPu2y0rOMiz3SwQ=;
        b=gVwtQr0ZZB1QUd45ionutlfzLbAdCIqGzPVrA3zMDH3uJG1N04+H+Naqkj4mKg5Dyn
         7fWLxxE6tkURFB15LsvFDpfb8VpF1eMo3A5LvneiycSKTQ6Uv1lU1CD3f+MAFsleELG7
         BJ6cEkWf3lEPEGa/s/DUYK54ftLLkw1xytyL/wZBa+MFgZaiu8hQu3Lzd8KajSZVsdRT
         l/uWMdDRfjmlHMQyuc5MesV2z3JPZnnx/nnhcwxTqH6lQaxU7jscCDWKv5RwxpFPykvA
         +X7MmU9loC17A4jxZNIyDQgfTR+ozGx/rONO/38FjvFgx+S9xr9Vg0WyWkhN5W3HkekS
         5ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772020169; x=1772624969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMadxPYeeGMAc9obR7DlAd1ejOg9CPu2y0rOMiz3SwQ=;
        b=A0FCLDKbBteriBKGJ037fh6eGg9irZVvGNNkdY5L75R1y5dqG+67Tsdvv5PQj9NuWn
         raOY6BCVbM6inonLPBLLg7IsuJe41RLHShiO3Z4B7Rwa6pcPapMyMq2nFyCBE+nPZbKe
         sqpsO0sr1A7MgHo6/97TzEiUdgS0A63gYBzgRUNgDY4Oy4iZrDVv2I0VE6QWkPfQlEcj
         pfwWysQKkXDIHt0XrsiRmCKroyprTJRxnEl4JElzvke965Dzgh1psrZg6YaoOdTDWxsW
         iKMR2j22EAQQL1S+ThW0KG+9leT6nZvr1FGypjPg+SIUaeHn1mgH4YNOD+VjO9vWLhv0
         2DXw==
X-Gm-Message-State: AOJu0YyQufMI0Zl88sla9z42qUdlyMApMOlS0xcW8JTW2BrFVEx6Q8z4
	fo99DsVIF3f2Va5CtYrXZIKN08yEeabswqnEONeZ7bI3lLUCrQWLkewo445wIwEKNBe+mynj92m
	uMFnjzxPp7+KenRyFBE0nLe50xpUazUkAMBjba2aU5UthLs+VWer5z9qqfG8qyB1lHSLtXXUh64
	eNpQ==
X-Gm-Gg: ATEYQzxjPTTcu6hl1g4Vxd9xx0ipVrKwTjHOo0BwtnLU7I1y36GtmczNyIsnsd0Ts2n
	ugVBtCy+L8KV5ZxXdmrAHOz+RhEf+QqYqXD9YrUEHnIEU9+7AHAdE7igqJSPgs+1TKg9hPpxU5E
	GcxGrUGkO+pX1+KEdRKREK3coDzjwqsOzscQFlWrDpsyEWQvwwSwaz7q7EOEQTs7kpx9qSfnpmx
	jxOvXO+2cX5DDpr3H+0w7/nKX2CCYtaOmOCEzAANaLp5CZYf+C7MRUTACLL/6Yaty3NLPp6qha0
	AjAKrrZEucqdeRWeL0H4RkWiP3Y1xdpxATD1VNafrSNQmV5hHMNS68UY7Ri8zmg0H+5XSyT9QbS
	QZco36iBpYqjwbMOKjUew014ixt1teMg8iwxRKTygq1D49SNcLmepmexDY3oM5ciSd0EYe1gD4y
	sSYhwowZ9LH698nWjC1MsIUUGXJpQiUm87oHZxMev/fRPCug==
X-Received: by 2002:a17:90a:fc43:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-358ae8d7510mr13284789a91.32.1772020169556;
        Wed, 25 Feb 2026 03:49:29 -0800 (PST)
X-Received: by 2002:a17:90a:fc43:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-358ae8d7510mr13284781a91.32.1772020169075;
        Wed, 25 Feb 2026 03:49:29 -0800 (PST)
Received: from hu-rrajkuma-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35901977ec3sm2923537a91.7.2026.02.25.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:49:28 -0800 (PST)
From: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session
Date: Wed, 25 Feb 2026 17:19:12 +0530
Message-Id: <20260225114912.966266-1-reshma.rajkumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KgwGv15EMG6IusOMcTMbhlXNu9XnvOjL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDExNiBTYWx0ZWRfXyAkF+JDK08e8
 wVZvF3RQmbAl9PVpnLC4OjzCZ4hizcGVBGOy4oY/q+ma1eMPUCtNDmVXq2K0s0uG42jIV0EDHAU
 +FOPr8J6fhNudeOXqMeS+b8d+SalNk45yQHmjUv8b+WqWzJp3PosJze0ZiieLk7G3lyrbBwxyWx
 uOYvRElUaDUhQ5Qsf/GrpziRtEHu8gT/CNtyn3/fmlCgar06jM5Ff8LdkGuTvlb4SBLZKQDWPjU
 kL6as+DIFxP441oOAsF4MfNc8btoQbBANCHLNt7ik8Tski5JKj4d7gvpLQ2d91O11MttPfWj7gY
 BdDKm6jcOXDgk+hf6PukfiYjsCsTTgOzf7aJ8FjZJ9h5tiVeCEICcgi8pGy0Wg182DyG2j3JMR1
 174sDN9lVDM2eAP/vDNo9AFokxeOjQmm/GdpyE5dJsb+5o7AhlYJuGbMLcaJ/QqLHZ0qOXDKHpO
 Lsf8593MBx2/5whyzyg==
X-Proofpoint-GUID: KgwGv15EMG6IusOMcTMbhlXNu9XnvOjL
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=699ee1ca cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vkfXM0Oplov9zySb:21 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=HdHnenrRhoasRur6LLcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-32176-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reshma.rajkumar@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C66E5196E3E
X-Rspamd-Action: no action

With traffic ongoing for data TID [TID 0], an ADDBA request to
stop AMPDU for the BA session was received on management TID [TID 4].
The corresponding TID number was incorrectly passed to stop the BA session,
resulting in the BA session for data TIDs being stopped and the BA size
being reduced to 1, causing an overall dip in TCP throughput.

Fix this issue by passing the correct argument from
ath12k_dp_rx_ampdu_stop() to ath12k_dp_arch_peer_rx_tid_reo_update()
during an AMPDU stop session. Instead of passing peer->dp_peer->rx_tid,
which is the base address of the array, corresponding to TID 0, pass
the value of &peer->dp_peer->rx_tid[params->tid]. With this, the
different TID numbers are accounted for.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a32ee9f8061a..640f752eaa03 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -735,6 +735,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
+	struct ath12k_dp_rx_tid *rx_tid;
 	struct ath12k_link_sta *arsta;
 	int vdev_id;
 	bool active;
@@ -770,7 +771,8 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 		return 0;
 	}
 
-	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, peer->dp_peer->rx_tid,
+	rx_tid = &peer->dp_peer->rx_tid[params->tid];
+	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, rx_tid,
 						    1, 0, false);
 	spin_unlock_bh(&dp->dp_lock);
 	if (ret) {

base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1


