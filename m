Return-Path: <linux-wireless+bounces-27632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A8B99F55
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A654C64F8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5828E2D541B;
	Wed, 24 Sep 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQ0wGTC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABE1D47B4
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718848; cv=none; b=S8/JWlpfghilJ8FEigMTGXWaCJnSzquoUSHI5MaPxQw5U7OT4ECqQG9RT5MjDdzdT6S/z/qfnjm339G9ia1tluKleZ+WNRmRH5G+D0LJArJxWIAbwiVEiMFzbzrpN+ogf+udAHmny5NxtwEal8C4qpougSykZweJ/wyBevbNQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718848; c=relaxed/simple;
	bh=3IH7LQ5emoDAbboaMCyuAcH//ESqOAhqYF+W6fbiu08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkQFNPJ0W+T4JcC2rkJDh07cv+dJ4l0/JNZiXqrG3MqEUjV8uZs1ItndOF1F20Xz7KLGJbqGUe792aKlkfOhMkvEHwalnLPN5OjlFYOOJHOF64reASn3wbQN/f6kpFQX8SZkx1j9H6az03Ceo/lun/nmqpofV+koxs53r3AEvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQ0wGTC7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCdgqs021486
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9/tLFpuoba5oWkFVeSAHO88zHOd3TvdB4iz
	NWyYVs1w=; b=lQ0wGTC7XoWjvbVfV+A7TzkkwtbZ4QRET5bYHNIRiVktl2crB01
	9mXuYKvvkcW99/HNm5X6Vf4wD0MbjgXI7RUJ2z3Vzb0gj0ubOgs2EXdEfpBysEcl
	i9vbMoafvEB9K6SqSnyMbF/tLs1jNg89bdHcS8mefAwcbNtd+5Ztyb/6a4cwKvh4
	6/NVu97YqFAEXF0rcpLmxVe1MIrSzSS1tS84QBQ//mazjkctY0+l4ydbInz+bZtg
	VTKJt8gusoYW/npZcgBXYGZaaYvylsRVLxfBmjkk230lyMDYqemjYEscai7Nz4Ma
	kI9avrmjt4ZgYiKG3KRCYQQWMWfYat+F2uQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budabxgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:00:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b55118e2d01so4312228a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718844; x=1759323644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/tLFpuoba5oWkFVeSAHO88zHOd3TvdB4izNWyYVs1w=;
        b=d+KGsSVUseu4CHT2A0SMS99a4dpGCLJqT8KJkOLWCpchiJ+LxE4cT/2hgveCEDGEsh
         kvCzkEfc/rgwAwBUng2yFfHMDczfRwb2LXl5YaJbLkkFZcnHUulZFsTZjQwOSlMxQ465
         3ypUFPUYXi2Fivfs6lTlQiFxAmNOOXhm1BjrKlwm5MoSWxP4sCTFfrkPW3lfDlu9QZRt
         vY4wCD9vSQuNyN847EojjGJQ1f1o+nsAvEYHs/30Dn8xXk3/b4194MJheNs1gVvAe8Vn
         dlZeBJwwD7KlvmiEa5fLGtMEkJuhg5Ny5B29TRiLcQn3YWCgpA/3L55slFNetH/JByvg
         CqMw==
X-Gm-Message-State: AOJu0YxBHs4pGry1IQgqR1yMiqhCo4S9g4dt41SJg6q/K/J5/wBHMQAo
	QAFzd39P82sA0+XkiAE3ZUfDnh+5lO9morfJv5h0AcXa3mAhjb0+dDl0r6NZIdoMmhw85MOuXB2
	yYAsSYbGzgKOQ0sur8BVRulglH/9sIgCgOcyIqOk9CEoM6FMWIJVnLHBuzsW4AYNU0It/KQ==
X-Gm-Gg: ASbGncu+G280K8jge4WoCpexsdQnGYAxp/jesNXzLmPhRVti858DgfJsbxs0M0aaXTd
	+8wsJnyNRqDqgBSLqGr0yjeU0imAaGOdlzS6/dLLo+hRsT0AvnS7zdSm7h1X+YVXtNCboW5ajG9
	XTNwHmA/IlkreqTFILjDZOy7ixxweFL3Yz/dfF8rLRsJ7MrXG9a9Ju3ajBHOgIByc5OBGBwXSBF
	Wc7sXkHTkPvk8421esOhtSb+jZ+GgAUkiPfdZMmT14RYhMGcXmVIAB+KtkX3V+kl4ZD4+sveiKk
	3VvOIchzy+HcZJj8GxrfC+bXrSArSPMmavVw/wjwCieTA7K8TIseILc//ipTP69KXaIxfXjdq+O
	CYzcgHecfhy+UdA5L0hs07tJy1Hh/k174Rgj9oveCt3vfvmVO5r0jkKz1vZpzJ/M=
X-Received: by 2002:a17:902:e5d0:b0:267:f7bc:673c with SMTP id d9443c01a7336-27cc678573amr68444765ad.44.1758718843526;
        Wed, 24 Sep 2025 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnTsbdkxIvOZjvhLS6YHKQ3WGSbY0tHoisdinofH9nxgMiG0eYasrFh1hQhdFKaEXjW8Phew==
X-Received: by 2002:a17:902:e5d0:b0:267:f7bc:673c with SMTP id d9443c01a7336-27cc678573amr68444005ad.44.1758718842320;
        Wed, 24 Sep 2025 06:00:42 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26989844036sm182323915ad.31.2025.09.24.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:00:41 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aloka Dixit <aloka.dixit@oss.qualcomm.com>,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: reset FILS discovery and unsol probe resp intervals
Date: Wed, 24 Sep 2025 18:30:14 +0530
Message-Id: <20250924130014.2575533-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nNGTecptgYUl870_ltMxIi1nvMPq-mxj
X-Proofpoint-ORIG-GUID: nNGTecptgYUl870_ltMxIi1nvMPq-mxj
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d3eb7d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=GIoCXPmBiaAohYgo0agA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX5rc7UKd2fKK5
 jl7RBFyhuBLKl0U0ccpTrzdW/yIu6IZBwFzrzQ81KeB26vF6fafW70uej1LrqoZJdOaUgdkixwD
 k1B2lESX3JYP12r6FUMjncvwbRSuqNlWhQhG5iCH7MbdFw2q3UHZ8TuYlF+Grb9Hh4n+Wl5bNUJ
 dBBaYpHI7N+XbKa2+wZfRKAKvnQ7wdll4SCC3t82B/Ga2yNZe3GQmDVvjZ34su/G8tx5qBv6QMm
 BxJ1DnGvqktmO1KkDEdg+FkZQot1gy2Fy8Dlf+MI8GIDtfT5S28mB9u/6YkNlGrckeEyHuHhtR0
 pPcvoKEyWJN+KIt1yecabXvzfNW44qNwY8866YjCR0FeB9NedMW4OEFEl0OM0Z54m4BOlJnhq0m
 1Rt9cy8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

When ieee80211_stop_ap() deletes the FILS discovery and unsolicited
broadcast probe response templates, the associated interval values
are not reset. This can lead to drivers subsequently operating with
the non-zero values, leading to unexpected behavior.

Trigger repeated retrieval attempts of the FILS discovery template in
ath12k, resulting in excessive log messages such as:

mac vdev 0 failed to retrieve FILS discovery template
mac vdev 4 failed to retrieve FILS discovery template

Fix this by resetting the intervals in ieee80211_stop_ap() to ensure
proper cleanup of FILS discovery and unsolicited broadcast probe
response templates.

Fixes: 295b02c4be74 ("mac80211: Add FILS discovery support")
Fixes: 632189a0180f ("mac80211: Unsolicited broadcast probe response support")
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9aca1c3c097..c52b0456039d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1876,6 +1876,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
+	link_conf->fils_discovery.min_interval = 0;
+	link_conf->fils_discovery.max_interval = 0;
+	link_conf->unsol_bcast_probe_resp_interval = 0;
 
 	__sta_info_flush(sdata, true, link_id, NULL);
 
-- 
2.34.1


