Return-Path: <linux-wireless+bounces-29666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179FCB5EA3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39624304EFD1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329E31062E;
	Thu, 11 Dec 2025 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SEtTkhAJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/B9MErp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460F30FF37
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456909; cv=none; b=IXT4aCCytoojYWaivmt9qHYuFl8nvXg3nxuZbHQc8MTrW8AUdTvvs2sh8Xi+T2wwQNBD2G9TTcMO5CnDZNbPjXjbnSVMfD0Cdup6DiCI4PQUbNhzvYrD46EAdupmnqPC4Cjp8z41qz147LiMrc2C8Qz8E3o1q9T5jZuNFuZ5+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456909; c=relaxed/simple;
	bh=oNXRyBPESs9yvE1BlP4KRDL+AyRdoMYLREEBfDgQ6+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IaMKe9u8RSKA6AOQbOQy2t3ulvClZbIVlLU8PMyP1eSbHIZ3jB36XbnJHVICiumYBIkSOG5k6uxAiYDN59UWJpgX/rJzB1LhWI1X3LiYYkkHLO2JbymDECOd/W1bYxQ1K5xTXhI+O8+oFF6mKXn1qthV5YckcV6q+U7s7IS6pYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SEtTkhAJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/B9MErp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXpog932685
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rLC4Hfs92mq
	gmTgaCIdCac4V1rfZ7Iv/5eRSCUq6zqY=; b=SEtTkhAJ1YxBkPmOzOi+9efSFKJ
	nOIwhv+f26r7Ph+YLONE6CKNIwGqj+KkNWPPBIT/lO3juXYnuxGDZYgrvmrUo/f1
	7OGKaKced2XzF1fx+uBfiIE3fB8rg3HB1e4Vo8oqWHL/3bE+FFQFMk8kvenf7noq
	pPt4llOqvqhSW9e+PE0TCIUrC5q6BnxVuZ3pDplx7NjexR0N0pmuGyvBqYPU7Geh
	Bes5QFzZGcfmfDUKyKQZmhIC+O5FPF0v0/kkLDJCFkbsNtqRbc3FWbmDAYiV1ur3
	9kVRx3Af+/dgEaaACGbKGt0LE4p2NrmtPXQm7WdjLE2/HtEI62lyv/8jYrQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aym581x1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9208e1976so24079b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456904; x=1766061704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLC4Hfs92mqgmTgaCIdCac4V1rfZ7Iv/5eRSCUq6zqY=;
        b=Q/B9MErpUIBAbiWkIeJWOyYc/QIDh6OkeW50RA/xPVwabCnXMH4g5H5YA4pbZpvgdZ
         LeMBrthF8fXvqG3SX042GFMRBmvGmyghVbAARhg7n8giRNG+8249Ry7zCWWQFBzBeMCO
         QSHYrV6mbVJGQpOjDuM4UlABsVnp2cC5KbCl6VqraZhgWdZIzxEtrh6Phf3yEjZIKrJh
         sR1P5VoZxNpEp7qWdcoINr3ipd4/E8+wT53dcszyku2TAup92AigrHk/F99waQ7WXgWx
         ajzU/COMHeskG17D3yM9A2F6tLKSBQRRWtpdkOVxKmg+OquRGNnib6cbAKkq3zWvB2hc
         P6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456904; x=1766061704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLC4Hfs92mqgmTgaCIdCac4V1rfZ7Iv/5eRSCUq6zqY=;
        b=JKmZ5+5BtijcKtvnXI0ahK098Gus9ULAv87Sf5nU354WVmTUfjHX3Nrrky5UoAS231
         jBoj0EwgM3iJinBPXvUTC0KWeKR3D+M7oqfpknzAQEZFCnisp3GS3+vFuNgaZKhHWrP8
         +0v+CKccGWfZd4yROGOTOLitUwJgPaRTFhTioXmPNYOI/y7upDhnvenbR6X+VLvQ3GcG
         iT6yTyG0qPtUGm4neRDX11KEx+UWQ7XjyV5/AMnJeC3u2vVwmeknK7bXGajYqpLI7yMN
         MGaCxaZNU3s17nx15VvJyj1/f27yRQ518em00yN7PMdjfKAB19pkfzmPmYPXRYH4G+PP
         0nrw==
X-Gm-Message-State: AOJu0YxEEtMN9Eh6O4kK0sLKDoXVWsY4cF3Dd8y5FSSqsIoBzsr1YTLY
	XDW1NtQXPBjYb+98RB0VZ3JeJ7I/efFfdQtOMJQiKQ2lmVyAUCqtgHJvZX40Nmb1RcOgg6PAWBK
	s8Xc2C+R4J7pnYcakYaFkRsJgnX5r4X41M4JTgUy/7pOOFQylL9jDAtnyaOCAc9lGM3103A==
X-Gm-Gg: AY/fxX5kC3HU7mZ/xpYu8gwWhB9/DkaNErcBkUgiVrnVb18+r7dIe/4oTJhvKagSczb
	kO1oQA/JzH+4sIMItokLcrx33uycuW95kkJZokhkXvqQP/SRIGucRgc/VcjzUS2QNek24xKUGkp
	I8ec/TeFUmMfhx0bvVDbHZ3aWblQbue+u7TaLMZa9pOE+56s4k/6ZeZkYbNCPiM2RuQkLzNt5gw
	0BKJ25LDu7hJY46CjTcfoiOphg//Z/tTeEI8mKCsAdROhUPS1NrWk94hI6Vw2VxQxfWaEKtdwMh
	Sssd+lorJ8WsEf7qHmX/WvlMe6+5Qv/SpZAyUbzwvlM+LMOIsJO3z60lhVSvtSAZssLJ+2A0gKB
	2rexA0Pe111byUQI03Z2s8A0TENKJ2E+r0CoiasAutA==
X-Received: by 2002:a05:6a20:431d:b0:364:1337:647a with SMTP id adf61e73a8af0-366e2a95105mr5623359637.38.1765456903986;
        Thu, 11 Dec 2025 04:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGMo7lzlg5ZotmmT7LEkM5WqqyThDRVqEXw0Zjc/2JsMrLhWcMoW6TcPe2jjDd1LLbaaT7gg==
X-Received: by 2002:a05:6a20:431d:b0:364:1337:647a with SMTP id adf61e73a8af0-366e2a95105mr5623336637.38.1765456903518;
        Thu, 11 Dec 2025 04:41:43 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:43 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 12/14] wifi: mac80211: Allow key installation before association for EPP Peer in AP mode
Date: Thu, 11 Dec 2025 18:10:49 +0530
Message-Id: <20251211124051.3094878-13-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tR8eRuxDbDlqrh5fALOq6FtGHwcBPGrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX1w3bh0c0VLep
 YxIhH0RLr5TSwridSzPURkmRBUS+P8+L6cSsSGopvjo0eBqvXmQbm+iWO5gtXuT3vQHFCqFZ6Zm
 t6OixNXmbMjsBatXV0i4SoDrHAC1RBIcYR7wfQ9/IjV76hjxFxy1BXo3hOjrhh8zCR4SMc+6H+9
 +4klbeEh98745oftL0wTbJYpslxvT9yjnesXzd3QOzkyzyPhGKdjSWpzz9Dzi2gGB/9vf7pDiUM
 SN/YgIj4ki998CdDPw9oJlA8O4OY79l6NuCIFZRnp3r3pK5u6PH6hJ2+pZXhu9yH17VV5CsyZjD
 1OfFyxLUoSIgG3boKfbyc7mKDmJtYMxmlQFXpN6YXQGrrYDnTU72NNKaeCtZxRugoQQb0i42W36
 CpKy5wxIjPNLAqM+w5/G4DaL/IhAaQ==
X-Authority-Analysis: v=2.4 cv=FYU6BZ+6 c=1 sm=1 tr=0 ts=693abc08 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8ana9tvAL9lnQv7j-n8A:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: tR8eRuxDbDlqrh5fALOq6FtGHwcBPGrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

From: Sai Pratyusha Magam <quic_smagam@quicinc.com>

Currently, mac80211 allows key installation only after association is
completed. For Enhanced Privacy Protection Key Exchange (EPPKE)
authentication, in AP mode, pairwise keys are derived and installed
after EPPKE Authentication frame 1 processing, i.e, even before the
peer state is moved to authenticated.

Hence, for an EPP peer, add support to permit installation of keys
prior to association in AP mode.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c0e634112c6d..ac9fcac4c587 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -699,6 +699,11 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 			    !test_sta_flag(sta, WLAN_STA_ASSOC))
 				goto fail;
 			break;
+		case NL80211_IFTYPE_AP:
+			if (!sta->sta.epp_peer &&
+			    !test_sta_flag(sta, WLAN_STA_ASSOC))
+				goto fail;
+			break;
 		default:
 			if (!test_sta_flag(sta, WLAN_STA_ASSOC))
 				goto fail;
-- 
2.34.1


