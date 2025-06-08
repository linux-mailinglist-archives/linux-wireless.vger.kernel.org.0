Return-Path: <linux-wireless+bounces-23829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E296AD1283
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jun 2025 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E2F3AA750
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jun 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7B2110;
	Sun,  8 Jun 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYDvW2cV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892C20AF62
	for <linux-wireless@vger.kernel.org>; Sun,  8 Jun 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749391438; cv=none; b=hmSN5f9nJ91fLVm5alJzshSLjXm8voIIrt5Kcsi6yOGr65f6fq/IgnHLcBWvp6l3bNY5mbnu4Otn+XltjOvVLXl3ClkTHVGmtScLhv0qWYKJ7pVQ2IEXLqOUzsJx2shPjrEW6+mSsTyD/MhFTYl6ZOziR/xyWp7iCgzQLkhjcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749391438; c=relaxed/simple;
	bh=zO8HVbPqaZN9vOCCmhzGivm/eOiO5t3HD78V4tyxEx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQiAQNM5P1IDlBAJT1T5LjhdQr5QrTmexMt2AY6leliehOtyscpmNC4YECaPkFfktkzy1bgxsUnmfYDhFtiXtrXG/Mrzbnx9A9GOLq+yUVi3ywQL9rihsrQPSPmGEDaVMzlc3tkP6z+r1+awLjkb+8+STgb/g+iXcMnTQO0LKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYDvW2cV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558AU42m007604
	for <linux-wireless@vger.kernel.org>; Sun, 8 Jun 2025 14:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EVals8Tw+m+ZN6oepZj1X0MocR43CqX2MHM
	KS2qPv4s=; b=QYDvW2cVurNpk21Rj8UxQhuOhDajhzw6FFjZNNIdTY8jknDEDxp
	Y33aLf8EOfePFDkJxH8fOSwB8I01EF06+fCAdi5fF1sdkjLNxJNcPDJLaVUfb3YY
	UZco2F3Awiu4tfLX2j1WTSC6qkXVVtZqYQhDtpENL2mDjUIbV2fp6vF51EtNY5mV
	Sh7G5pYSz6qg2Aq9pElCuQKD9B4Vppij8158izJQ6u30uob37Vcacv4hGeLk8Yw4
	IIX1Ywug1x+jt4A2VcND3EYM0x7ZsPoPaVIp64KSEso7hnZAz9zuE6TJ60AEU/++
	4UjWl48whXXtIuejsj5bD1rj0zgr/9dxf5Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474crku55g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 14:03:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73bfc657aefso2455247b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 07:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749391416; x=1749996216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVals8Tw+m+ZN6oepZj1X0MocR43CqX2MHMKS2qPv4s=;
        b=QvRh0Hpf6cuocPk4rHIpf8Ff3rSqmXtaNpQAEH+BSC5aYS3DP/UrDU0TeyrJAteQpA
         hu+GVC9R/+wmUuBQcP9AxCE4e2T3CewtGFleltxIBhNIjO4rOpCxSIYSwCCRBgAr7TZh
         9aEkA+2XASNsBdHuznsTQRs4CZRNzzQEFszaRXJUXDxocB0BIFd6YxyY8h6Z89AB7Whs
         PTxy9NF/6nmqEDbJcMByrh3gTnLckRQX/xXbhWthGF3owUCao18D3wqKDHn4odXYjyXv
         MMs1Myg3nxya2UFwAlqLlnpFWNw9EN4b3ty0A+V2DoNQVXQoW1Xc9z058vfMwczgAzVa
         XOMA==
X-Gm-Message-State: AOJu0YzHO6Wl/Vd0tERC43VVsLWRWkydlJIE3rTDnEkZdNsQuHlJpPnF
	+GezlJrWwiiy4r0Nw1sqv2qqrnOMiy6hCMkoqJpP1wdlW21vKkVlFJNS47pPZaHrz+cOOuQlhna
	YmUy51yYtCiL/13jx7pw7/QwaVQ42Eka7SlVf6GTLwPuijq2TxOrltwYkDf4enFpZ4BAWOA==
X-Gm-Gg: ASbGncu3r2WEzWgaPteb+fJCDjiW0Y1ArBTEZIs3OHQouJF99P1sZUhak3hC+4Dt5Wq
	FJlj6Ru7ENJ7PE5y4XzQ5RTQvMjElZ3rVz3ArN5pKYIMvjL9Q5uf6yss6lcOLea3L8yr28jGSda
	4/u+YLTnW72c7zNKbpMvdQbG6/IrbYKbXp8rBuvEUXMLpPd2RPOUWwCPco2Bl4BbkGaPJy7F/H7
	PQrV/hDvVN0CvjZgkPHaZbEzGtwvfA0qE5qWs7p4taMVJdObCDJNS+gIUrKn2+Bwql6XtX9OQUk
	7gctuHmoUtYLj5KZSJ21EskkwUtBmomV/uCwH8+rnlIq2XxLs5orZ1iXIz8hjUT7+9T1ZYmFQiJ
	sinf77alXZN0OAqAeaTVEPwX1tANAY2bkF7vvisXm
X-Received: by 2002:a05:6a00:2e07:b0:747:cffb:bb37 with SMTP id d2e1a72fcca58-74827e808a9mr13373507b3a.10.1749391415767;
        Sun, 08 Jun 2025 07:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO9E7Ghlf0/XL2a4+GRcTtwLjKWUBHJ6aBQT2UzhP65LDZ4Iz9/i1Chf0J5uhzDUP/l4nqOA==
X-Received: by 2002:a05:6a00:2e07:b0:747:cffb:bb37 with SMTP id d2e1a72fcca58-74827e808a9mr13373469b3a.10.1749391415349;
        Sun, 08 Jun 2025 07:03:35 -0700 (PDT)
Received: from hu-rkaliapp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af383b0sm4087950b3a.22.2025.06.08.07.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 07:03:34 -0700 (PDT)
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: update radar_required in channel context after channel switch
Date: Sun,  8 Jun 2025 19:33:24 +0530
Message-Id: <20250608140324.1687117-1-ramasamy.kaliappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dsLbC0g4 c=1 sm=1 tr=0 ts=6845984a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=XDfhRDRBBAOICC7ghhkA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: VCh0myW_zKDghJF4tWYQ-RitPI_oSSga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDExMiBTYWx0ZWRfXz6bXg9svf8IH
 0eYBqXuUY2IEueWvQYq+Qibckk1dSN5Imu+EEjdbyEp55Y+A9RMEk4qtc1Fvz0CwvzoUKwgC+AQ
 ogVkoKMfnoNfaRdp7x8LzjAjQTf/Los6Ojelnp0LrwL2ju7QVipg/y6e0D7GEypSCTwsQy3ezSx
 e4KyrOeRJEAk7Y90Y9DtYz84dpvZ/m1LfxDDF08t5XD120W69EHcRCLWINl7e7H6HxEU/A+gq3t
 3oSmiNi+nBCEy+9/+rF0P4w71Kxh+eLbNagPHWCw5y0f0wPr5En2B9RWZHv57bGDzFrb14A/Qyz
 XPPAldCeQ8Jt5hEqUEJe0716pGsQrkRK+G3WuvY+PQu/OwQ+pQ34NEdvCk7nul4UTSx7LyeiPXp
 SLVqmZXmGfdGc2MNzco32Pl9lltvtiI4OafiYb7T3jsiDtykXAJrbKYFwPnBGM1C2xBI4g/q
X-Proofpoint-ORIG-GUID: VCh0myW_zKDghJF4tWYQ-RitPI_oSSga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506080112

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

Currently, when a non-DFS channel is brought up and the bandwidth is
expanded from 80 MHz to 160 MHz, where the primary 80 MHz is non-DFS
and the secondary 80 MHz consists of DFS channels, radar detection
fails if radar occurs in the secondary 80 MHz.

When the channel is switched from 80 MHz to 160 MHz, with the primary
80 MHz being non-DFS and the secondary 80 MHz consisting of DFS
channels, the radar required flag in the channel switch parameters
is set to true. However, when using a reserved channel context,
it is not updated in sdata, which disables radar detection in the
secondary 80 MHz DFS channels.

Update the radar required flag in sdata to fix this issue when using
a reserved channel context.

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
---
 net/mac80211/chan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 3aaf5abf1acc..e0fdeaafc489 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1381,6 +1381,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 		goto out;
 	}
 
+	link->radar_required = link->reserved_radar_required;
 	list_move(&link->assigned_chanctx_list, &new_ctx->assigned_links);
 	rcu_assign_pointer(link_conf->chanctx_conf, &new_ctx->conf);
 

base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.34.1


