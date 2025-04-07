Return-Path: <linux-wireless+bounces-21207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E4A7EC0E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F1E3B4C6F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7625DAE3;
	Mon,  7 Apr 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuH5vU+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4D25D8E3
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050516; cv=none; b=rCaETcQfW/twD3R3y3RUXhnldygwqF9uqNlLeffR9POAqJ6kcg4vv+qzWnerFjZHhw2n66ElwPp3RllkM0Z1jcEs0UjSDrnB3k64LHMJ7jYZpCgNJSmOgE6u41aRNSO0fWSoI5PN/x2+I9GYJjjY/XyynrNsXPxLmv4jx9volUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050516; c=relaxed/simple;
	bh=N4Q2PJWuhAfKBzdAFmDbrPwhxv0aR7cTpTq+LF7pe9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pj9kd30YUa2wOHcZALkj1aYhwHViEPIKundcxtu42ZLQXDM/GP45HNQ73jC9D/Bn2qJRX0TfaXDzo+QbGJArf4kRmANlziTnLqZZXH7kEaQCLwJ+WxszJ42qbj04xea0IvJYn1B6IUT5GP/oVDkgHCBk9aDOeCjAb6w8MWfTDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kuH5vU+E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dnC6009956
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 18:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wRtFH9qTygTaGiFNeyhmWD
	BRYBZEnxZC4l/kcFqqpoQ=; b=kuH5vU+EYMWqwZR6Efbh0S42A/nGPS25kDBRIE
	dXlEbL+em5TuFVQg7nw7hh9BPS6WLCWNTrH+FOiNcWP1Y/8pWLlFLbLL+qK8g5O+
	fVs4pp1loMy0jIhSB5qRp6DsjrdAJ2qGF7Lm/7Ae4TxI09fHpnaNGTiBsnLv43vZ
	xLIL9A4fPeKyRgMlDKXW29x2tQcMqD1qwIgCi0wnuXLvMtXcOTlTPU7I2Twq7jTl
	5omEOJKJu45BYbu62sds0WnDgHTSQIn05bVO7p1Y6lCG9aCaI5lUQX0I2hcs0xls
	StHOgyrqE7jgZgO3BruXEDgiFlsMEzpcG+5V7+xdDaFaN/DQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm53gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 18:28:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so4691006a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 11:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744050509; x=1744655309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRtFH9qTygTaGiFNeyhmWDBRYBZEnxZC4l/kcFqqpoQ=;
        b=Rdl+Rtxtymal9luf/NoK8iCG6KDgFE3tPOsEfpalxVfu4QMgaJouHBLZxMjng3qzNg
         ybB4tCVo9HT/RQgnLYnNzA6nnbU56D6ST492ipq9MquolP2DN1FY74jMIWUPljizq4z9
         5CqYVO1zHM256yP4oOnRG8RakBlQHJ84vyNHZQPBUUzVUalZWGFsD6g19qKHFJTznrM+
         16xg+fHVSn1ZcbblQRD61SzYwKbXUxhbWx0Knpzmj5XXxHvCbSLQe1uvSyOtGxmJElLk
         rGa7y15J5DbJLsFbwPflqJ+rg7BRkcEZ/WqBUWlBid9zeZJpGg3OdYY2tDNeMTOYjiep
         zJFA==
X-Gm-Message-State: AOJu0YwRLUdc97h6S2FSqlXOx5OUYBw+NNIfIQvZGBIi/RpMXHjjbV74
	NuYGmaBeVA0//eTbFIII5MWzDeoKVyXXPRB2XNx23TH1aLL0zyWLu608VgV9uUjovi4e/9nlw/+
	6GC2GA08hp2+n3guUwjPuuRoII6tCHHWixQvvg2rYtMR1KSvLzsxuczJVHW1DUQszsQ==
X-Gm-Gg: ASbGncv+y6MI4d72cU7GtP61szhm+fmK2509SC8YuGN984cfI3solumvAWE6KJChCIy
	jfsszc9OU5S/HGibp1ATMq1osY6TFw4CsvgJVOqdK8z68nc5k5lmk7IIzjOTmYm3LxMXPbfx+1u
	zf9RyE6OnEEw8Ovne0146tYpCAeb3Ck5KQke6x7gRm/dfAlYtic+BLRfmMjQBE9J1y9eHqqM5S/
	D64JPRDB+bxymEL7mZQeGZ1JZkAk8kYB11Te3OpvfkjtME4NIHZUJiOz3gkIc0FImgHkyV8EN/m
	FBxnXE2M6a9av/3CidZaAyc5nwFSNUP36eCAvAQONs3eCnK3BZjP
X-Received: by 2002:a17:90b:2d87:b0:305:5f2c:c577 with SMTP id 98e67ed59e1d1-306af6eaa6fmr12257114a91.3.1744050509439;
        Mon, 07 Apr 2025 11:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIkUUFJJbz5/DUqQ15ZO3tVB8cccmjhRILJ6c9sC2XH5uCBz5Q6S4AWzXEYCb3NL0aVsUrzg==
X-Received: by 2002:a17:90b:2d87:b0:305:5f2c:c577 with SMTP id 98e67ed59e1d1-306af6eaa6fmr12257085a91.3.1744050509015;
        Mon, 07 Apr 2025 11:28:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a30974sm9181431a91.25.2025.04.07.11.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:28:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 11:28:26 -0700
Subject: [PATCH] wifi: ath12k: Fix misspelling "upto" in dp.c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-upto-v1-1-23ca65f2ccdf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEkZ9GcC/x3MQQ7CIBCF4auQWTsJpSixV2lcTHGUWQgEqjEh3
 F3q8kv+9xpULsIVFtWg8EeqpDgwnRT4QPHJKPdhMNqctdUO33lPSO5ir2421s0WRpoLP+T7v1l
 vwxtVxq1Q9OEY0x7wRRKh9x+O6w5hcQAAAA==
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: B-R-vMa11-_36lm3Rq2y4Bk3wgOmfORz
X-Proofpoint-ORIG-GUID: B-R-vMa11-_36lm3Rq2y4Bk3wgOmfORz
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f4194f cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=UkFjiLiVbqrHbZXL8LAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=917 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070128

ath12k-check is flagging:

drivers/net/wireless/ath/ath12k/dp.c:1656: 'upto' may be misspelled - perhaps 'up to'?

Replace "upto" with "up to" and split the comment line so that it
doesn't exceed 80 columns.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
To be honest, I saw this when I was processing the original patch, but
I thought this was just in the commit text and let it slide. But now
that I see it is in the code, I'm fixing it.
---
 drivers/net/wireless/ath/ath12k/dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 80b9f4594dee..59f61341383a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1653,7 +1653,8 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 
 	/* Bits in the register have address [39:8] LUT base address to be
 	 * allocated such that LSBs are assumed to be zero. Also, current
-	 * design supports paddr upto 4 GB max hence it fits in 32 bit register only
+	 * design supports paddr up to 4 GB max hence it fits in 32 bit
+	 * register only
 	 */
 
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),

---
base-commit: 4bcceba241524d8d52bdadf216f9f894e394fcde
change-id: 20250407-upto-a76497324734


