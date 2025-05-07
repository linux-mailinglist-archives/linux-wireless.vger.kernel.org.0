Return-Path: <linux-wireless+bounces-22719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99276AAEC6F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848A517DDB0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7128E5E5;
	Wed,  7 May 2025 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFQnCJsN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4028B4FE
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647337; cv=none; b=oL1juCvjcDp7gJRiozNDjb6Tc4arsCWqMt7tCuoruZ1zo/IqOX/56+xDWMolnfCKsmmuU/P+dlu3B50JssJIePg3ys76cgUhrXMFhn8mJ/MoTrNmoCd1pumID0vw5hqpYJSZyXYUadvg44TFNcjJaQozSGv2S26IPIDghkzeno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647337; c=relaxed/simple;
	bh=DODJJFKAhK7xStBh93pNxexokuN9iaW2516cshf1GGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYCeAQi0qGKPbIXnuMQAYxPD43DwHyHRcVJ4GJ0Eluuu9bQRTTUuKOx/zkqEShBC+vNru6mGvmrJXE2NFOESM4TamD1V/VMBNnnlj/W19wkMKoga8VUS93pi8ywqKk5nHbHqEaBUtTbHJ4tZ08wSdpDK4h16/GK/U6Nd9PDkXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFQnCJsN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547Ai9xW020068
	for <linux-wireless@vger.kernel.org>; Wed, 7 May 2025 19:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ZziIjb4eIKb4RMBUaFtWOtuHPf/ab5yqngn
	ph2mU+vk=; b=FFQnCJsN304aDXA/CS6zeRzDXvz5YXdmL1SdM2OEhylhGY5QsxF
	vE8i9UVF3p5dyig6fwy/LRsl8YRL0/JHl3Mjr+YD40H+GeaLwmiPio0PT0jk5sv/
	kl0DqvYk18CUz7KDGncKwvaI7K92Il0LF+2H7fbXmIyiVwksWB2x2nqjfRgqp+og
	+avQbxXEjtTKdUM8JT7tZkMLri3EzwIETcmtqLCpeR1kNsGPV470Rqky8z7Jj17h
	xRUMVUoXnrf7vojGEWdUucUfIS4JU+Q6pN2LkifvT2PgJ/hCjnwcfxh+DYFB1aSM
	8GbIqVMJNmrY3suRl/gy4gNevhgmCkgWnwg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9epcd6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 19:48:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af8d8e0689eso232856a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 12:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746647333; x=1747252133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZziIjb4eIKb4RMBUaFtWOtuHPf/ab5yqngnph2mU+vk=;
        b=sq9PjVyv4Jg2NmS7OLJgxZq92cS7jZmas2/NCvBMkuMrStaGImFbPLTFX8cPyPnHg5
         Kp1oLwIPHiXtUPnqNWhXBCqGlnY/IvMkVGsznN7g27GHmZgD6ujJo4smV/2Phr88ZWJP
         J66BlmQvhvbw5KF53pTUMglOSBs+PXjMD/eSyRUTe2kse30T56iNdDoRIlRNfEaS6/vN
         XAmkUn/LJ+sFiw2FTpsqkdqegvT+knVYiqHY0MrN9VnLKrhdBRFTEUM+nnvvuPZpKCSP
         Xb8rFedzxR+iUXj8yimnaHu9TNHu7hJQ7K5xfCTxX4gSgxvmWznsaECO7qcv7Qs4t4T4
         IOSQ==
X-Gm-Message-State: AOJu0YzCTVOFIzurbQ8hHV05pa5mB+8PtOVwQeSFnJfPmSfM805dqhO4
	fTZukG18NAElKfS0AA63adrVnTw08ImUkF7WLcIs63DMXq9DarZwsouulZI3lylMGg41HL9TkbT
	x0APlrvoCeUeVBjz+JgNHD4FJXptM/U1r5UJgPHPWJeRSm+WafqJnrfuv5S6PSfqVCA==
X-Gm-Gg: ASbGncsVWAFtLSTPr3y38n0BigwEnzrIWga2NpPl/VvxcT+fmw9330SIElZxgimW93e
	AF+M7AaR3C9/XV+jxfRtISHSEgQvuuIg8aVDzUvwCZjQl1Dqu9m0nbYZuUCXHWnSBE9uwhq+8du
	0ZrljOFUYnWo5vU4EIHB38RWQ4d3sIzxacqxqW14nxftXIamhxa3cN5KjHQ67LVTXDpAJ2oVPV6
	s4EJejxZI1yr4Ji1HPCxTHJ56P4c+ArcIbZp97xW5+vx+Gf92WoYba/bxGBCPVL5rlRyGL7vs/F
	rJ/ABgB5kNmGtI7WDu820jkwCYdb+c2jBmU28NHKnCdXxD6rfiPAnPk8wBbaKciQZ/cT1NNIOCA
	XjZUyE8wrsSMNK8RpMuEfVndudfeoxQ+owMtScafb
X-Received: by 2002:a05:6a20:d50d:b0:1f5:8eb1:d5d2 with SMTP id adf61e73a8af0-2159af6137emr767209637.13.1746647333357;
        Wed, 07 May 2025 12:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLoZ6f9Csaou1V/4K4TAsHQXsdeYVfCOp6u4J22tKsl5aiJy7k++4Hpx/WDC+8eAWbpJXZug==
X-Received: by 2002:a05:6a20:d50d:b0:1f5:8eb1:d5d2 with SMTP id adf61e73a8af0-2159af6137emr767189637.13.1746647333029;
        Wed, 07 May 2025 12:48:53 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3920074sm9972704a12.11.2025.05.07.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:48:52 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-pending v2 0/2] Add split-phy scan support in single wiphy
Date: Thu,  8 May 2025 01:18:30 +0530
Message-Id: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=681bb926 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=1ZOo-ZK77t7PqXeEs4UA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: OGqUJGowbGuTEuy-AvZmFijvKrbQHMDK
X-Proofpoint-GUID: OGqUJGowbGuTEuy-AvZmFijvKrbQHMDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE4MSBTYWx0ZWRfX7UX+OmXmPwDR
 0DwrxJOVLv69h+WBRf7M6Kbx7wUr9E8zqV+NldK0rJSCC0hj6niG1eNYI4VffIal0GIJaJIeSQP
 1H2IegCx6qjo84zISKxKpRRB/Rqj/Y3/x6Q7SbESQXMCenuKBV0wzjsXH+NpaK8hXzKhA+qOT0V
 N+rm7CmXCMksiLexDJj+HHSCyXCzwUowFmk2Ny9jUTnN+DQd8+WTVoccZXuhUwUNRDWrzP/5dFm
 5B/oiHLvx5Nn33naFq5fLlIJu6nWaq894/dsiqCcp5+mg9vOEGVkNZeK1V6WPhRf4UjqCN8ctmd
 RN4GYoI3bEI1lJmOSDslA0dxE2i9ggX0HUHFi0YrGO3upLZ7Ybw7wr1ZbW5Ge7LDssWWKG0+rtW
 hpNgILcsMvLdN3aVL2MVBnahnUOj7nSEbYOrrK+iBwRwwabMPzgp//qfom/GNBjjsIGGhl7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070181

When two split-phy devices having supported frequency range in same band
(as mentioned below) are combined into an ath12k HW group, they will be
part of same wiphy and hence the channel list (wiphy->bands[]) will be
common for all of the radios (ar).

1 - 2.4 GHz + 5 GHz Low band
2 - 5 GHz High band + 6 GHz

When a scan is triggered with frequency list containing frequencies of
both  5 GHz low and 5 GHz high, mac80211 generates a single scan request
to driver with both the frequencies. This is because mac80211 splits the
the scan request based on band.
This results in driver scheduling scan for both frequencies in same radio,
as driver always assumes that the scan request frequency list from
mac80211 only contains frequencies for one radio.
Split the scan request frequency list based on the supported frequency
ranges of radios in a band and schedule scan to corresponding radios.

Since the scan request is split in ath12k driver internally, wait for
all radios to complete their scan and report the same to mac80211.

Rameshkumar Sundaram (2):
  wifi: ath12k: Prepare ahvif scan link for parallel scan
  wifi: ath12k: Split scan request for split band device

 drivers/net/wireless/ath/ath12k/core.h |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 197 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h  |   7 +-
 3 files changed, 160 insertions(+), 48 deletions(-)


base-commit: 889c2406b1c5e92bb83a5eb798f4966e302d2a51
-- 
2.34.1


