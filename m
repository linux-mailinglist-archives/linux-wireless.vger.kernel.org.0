Return-Path: <linux-wireless+bounces-31587-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGMbAFd9hGl/3AMAu9opvQ
	(envelope-from <linux-wireless+bounces-31587-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:21:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB4F1CD9
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 617133002D35
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2D35581F;
	Thu,  5 Feb 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjU0PcY2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E59dpqHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15A2DECBA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290512; cv=none; b=FHJi1oWVuEt7mqNYvngQyn4fNNXXab1JHAQ3NBZTnJeBC+wdTGNmM9j5oyrJazJieWg4Kr1p5wcokUIkdJ+ctOEpEpsTczpCYSIkPDfJP+/Q/mWhD0sp1xP9+D0MyC/nZKcuIMBGFxFZHz/s9alYHyUfXtrSYHi3Dj5kEOSd5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290512; c=relaxed/simple;
	bh=F0fuR0Ru6mBAObukQNWFKNbIUaU0ddTfVK398YgowpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAfqzL1AiImH9tOmw+sYzbIHzuAHgs+SwtzkwPn/E8HC4pJVTty11scBdCO0wqn0MOSgMFLbJSUGyueGGs9Pmwu6SfDf4VOrKnfEHXUdOvrsQWvtym+XOt1wt0OFWfD+0K5jUAUnhUah3rXrb/OBc7/mxWVnHG1FRUyOLnm7+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjU0PcY2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E59dpqHH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615B5qgQ2759475
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 11:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4lKvpojeIpZdBmzAJXiaKEglkbSeV/F5/K0
	AWrCTyq8=; b=YjU0PcY2Uo8ltm9LBBtMVSTfX4luGHxvAjIHmv9SyRXXS04NynV
	XcNzR6etb5vXCFHmeQMxmubiupFjzogZ6VTL+CPjgbAiK1bSaVFRK1lT4vu/nRTi
	dL60anC9Rzqzea0vGZEhiId/+NUef2XhkFxr4pEUeZCTWGVdRGOMZXXpi7DQ8pnj
	wjaFnhnS9WhcAeyH9J2WVsGk0fQkzW3PLIPuBXFlAnHdznwTdPTZ06D4/5Sm0JW0
	WI3NvsTS3Pu22P+RjfZ+fvoeT1pbCveI9i8WOqDsKkgdRTSiWziYszRWSBAklR4H
	hJ/OAHCjXtU+xk1BZKyOKK0TqRtBuSaCxIw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4jpd1fsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 11:21:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3547cd89bcfso1864902a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 03:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770290511; x=1770895311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lKvpojeIpZdBmzAJXiaKEglkbSeV/F5/K0AWrCTyq8=;
        b=E59dpqHHrbbKZlEKtYR6KyVa6Nme8XJda8b6Juvnt/Wh9nZhFWESUgvuG+fICH2d4p
         FWi20PbcshDVsmUfmGC+hhGb+mYhfbebjXsW55c9b2Wvr8kR6hoHoNJ7q8Q1GuU3GjmT
         Zl4u2rAJbRQfOUFP9pUahfewmrUPhQL5ae6zdiv8UcaX5fIp/fnD/lit56Z5CvS9FhRw
         9DUxQrdGfpHsb60n2iaTEXxkr05DeC7BqXcyNtyfpHtcK5SISUy+RBN+hMiXOJhAltzq
         xXlSLiSvjTnjlGvWT3/D0qkhIgTkrOH3vkvcKj51fSIUrZXehmPFlpF24dG5F8a0ViZx
         hJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290511; x=1770895311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lKvpojeIpZdBmzAJXiaKEglkbSeV/F5/K0AWrCTyq8=;
        b=VUL0qNro8O913z8Ih/UT+2TGHUzkdNuEjX2mc8LVj555hqr/a8s0lK6pmdMUM2dkcp
         6M1BKKDzXURBr+/cEe4g/zKkTWH7qFsi3gLO2mkmMowU1SE/gXGoRtAlbJYJZxDdS7x0
         DCBQMFXaZsYbkXTY5xrTIPCE/9SmIrzkhw8shPHX5ptO6ZIED8r56GzJ+zarCDfKELVp
         GgWauKysc8kfDF4R/S7/I4DkrW0fD+jyPx0+Meg9kKgZZZc74OyRLalBnGgJcKsiZ8yM
         MkoMjNywKwBEULcLwj3EpnL3HUv90kbbnArvSbTxjuuRu5UAOwXXJDnPIVmYtImyPL1J
         0pSA==
X-Gm-Message-State: AOJu0YzgFicM9sTsGqhDSO/HaiP0/+iClgPL9elTnYd5g5VLq+3zlgHk
	7XdX7rNZY5rZtKV6xoK4uElUqQSqFZeZOq/YSHHoW8OFAp8kJ3f78a7PRNpYL3GpFBAcri8MPSR
	TABhswrkvcB9yLMLsL7aVhTPAC4OUz1brCcCuXQ0sWl2kOO+c4CcyTHyr+gDoSHBfc018wQ==
X-Gm-Gg: AZuq6aJFWCDnl9cLBzdQrmu7w+xsA4Sf7X5iEbGq3U1Xlje2KUM3QI491RKd2Q7Z7vc
	dsIhQJXBOjg/xoVIJBIt1ka0L0zh3/7gsBfSyV9Mweg0nvEvFO1lp7GjDmweNWYE28oRogirGs3
	iJA3ci2YyqMgfEcV1kfnuxySU9vYf3tFPT/gd975pj7OaIg2jXuli7g22sR2gz2hL2xmczmjXXw
	KCQQwwMAG3R4syi5vN0bWyaFmCVcMVh8UQ9jfPgmEjsqMFDlzeje3zZJ9nkCKnrIjNWG6z9+Kym
	PQtcWcs/MAVHGXb2f7VTGz5AX2R83Hs61GwX1PU9CF9dpEMEPccKNrDl+fIApa7u93PKd+lOpKW
	9EoVHrWwfPWwV1n1p3XmporOJpyK5Uiy8V+ysItzY0JO4RjicJjSrZYyKbCKgnFXTQQ5q14MdOB
	gdMFauQrpzS82165G8d1y1ciw=
X-Received: by 2002:a17:90b:4ecb:b0:354:9b26:cdf8 with SMTP id 98e67ed59e1d1-3549b270926mr2422281a91.10.1770290510879;
        Thu, 05 Feb 2026 03:21:50 -0800 (PST)
X-Received: by 2002:a17:90b:4ecb:b0:354:9b26:cdf8 with SMTP id 98e67ed59e1d1-3549b270926mr2422269a91.10.1770290510440;
        Thu, 05 Feb 2026 03:21:50 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16401esm5651998b3a.4.2026.02.05.03.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:21:50 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH wireless-next v4 0/3] wifi: cfg80211/mac80211: add support to handle incumbent signal detected event
Date: Thu,  5 Feb 2026 16:51:43 +0530
Message-Id: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4NCBTYWx0ZWRfX+YD6HNbFrw15
 nTB/dgegc6sfvccJGZu4+viv0thWiP2maX2G/QuTH8jenT0AbvrI7lkP2uVD+x6w/73cdbXX3Dl
 teNm5wBdVR13OkmUt33SFn3hMdJPGDTSnUeHHtiGEGmAx2AAIJQQw8VIhqglGYIvGNkfpR5UwF1
 grZkk+LDTQkgpzpgEh8HIlzzPGSK668AmkjSoUEppVJhuyxmytXwlaVDpG3FBurAIlGtksS2TK1
 Gc1PkJx7vTeFrJT5c51GEFWikyfP2FRE7xoeOjMNJe/Oe6lElZplD/rHtNSI02+HLZ3p53Q8kuX
 8DIPwv6jKkdSD46QvBNwb4FZi9siZqblGBtONsvLpSWuGFZFa5Cbx/BhRSfB/Rjdhp5igic5waP
 QgHf4k3i11UZvgtCi5oKa2jfbsy3GEKoPrYz4jQsPEuG2is4hWdAnEEeziv5JFt5ZE73UpAdluO
 ipyoNXkQHbTT5B5MBqQ==
X-Proofpoint-GUID: VlJPCqcQlB1-06D3lhIWeW-fqhC-0aTu
X-Authority-Analysis: v=2.4 cv=d7j4CBjE c=1 sm=1 tr=0 ts=69847d4f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1P1qi0jZ29cQl9APfZwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: VlJPCqcQlB1-06D3lhIWeW-fqhC-0aTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31587-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0AFB4F1CD9
X-Rspamd-Action: no action

This patch series adds support to handle incumbent signal interference
detected event in 6 GHz band. When an incumbent signal is detected by an
AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
vacate the channels affected by it.

Driver is expected to call the newly introduced API with required
information to notify the interference detection. This information will be
ultimately sent to user space via NL802111 command. User space is expected
to process it and take further action - vacate the channel, or reduce the
bandwidth.

Aditya Kumar Singh (1):
  wifi: mac80211_hwsim: add incumbent signal interference detection
    support

Hari Chandrakanthan (2):
  wifi: cfg80211: add support to handle incumbent signal detected event
    from mac80211/driver
  wifi: mac80211: add support to handle incumbent signal detected event
    from driver
---
Changes in v4:
 - Restored gfp_t in cfg80211_incumbent_signal_notify().
 - Dropped incumbt_sig_intf_bmap from ieee80211_chanctx_conf and passed
   bitmap directly.
 - Updated trace/call path: api_incumbent_signal_detected() to take bitmap
 - Simplified hwsim: removed helper struct.

Changes in v3:
 - Removed the workqueue mechanism in ieee80211_incumbent_signal_detected(),
   exported the cfg80211_ function that sends the NL80211 command and called
   it from ieee80211_incumbent_signal_detected() directly.
 - Renamed nl80211_incumbent_signal_notify() to
   cfg80211_incumbent_signal_notify() and removed the gfp argument from it.

Changes in v2:
 - Updated the kernel doc of NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP
   to include details of how it interacts with puncturing.
 - Rebased on ToT
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 +++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  2 +
 include/net/cfg80211.h                        | 23 +++++++++++
 include/net/mac80211.h                        | 14 +++++++
 include/uapi/linux/nl80211.h                  | 19 +++++++++
 net/mac80211/trace.h                          | 26 ++++++++++++
 net/mac80211/util.c                           | 14 +++++++
 net/wireless/nl80211.c                        | 40 +++++++++++++++++++
 net/wireless/trace.h                          | 19 +++++++++
 9 files changed, 190 insertions(+)


base-commit: c30e188bd2a886258be5facb970a804d8ef549b5
-- 
2.34.1


