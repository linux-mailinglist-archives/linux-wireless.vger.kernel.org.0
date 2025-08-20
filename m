Return-Path: <linux-wireless+bounces-26479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF6B2E13A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F36318963D9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233DF25742C;
	Wed, 20 Aug 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VKJaRiT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB22E3AE0
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703482; cv=none; b=Hu5YhHWsV8mHtsN4fHma1g9zZAUrzcBdtsRVCud91yaWyHl3hodZTTEbYmddKGOWgLjXQAyTgI6lEindXyF+v7K3RBRbZO6oAGkHDNqWRPA7MLt2Ql2HEMG4axwf8ADWwmA6z3zTBpYtowQpehOlXiWnvqKZseWNZYHYE8AZNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703482; c=relaxed/simple;
	bh=uiRgMUI83Zut3w5uGTBx8uIiMd94RZiiueTREO1pQxg=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=mxznv4RqmU0XVwiU00Do/RXeDrv4wK5SCuvC6ZUm+LwNddOk+Dd0LLFO3A3pg5N1e7x049uUjW6q3p13QOokKp7PFziE0Thmr7x3PPI8P3QQz0v/ocxCk+UgjDg5LMIQg/nxJKrdq4Zv/Lc8MZKmK2HtETwmcsAb9/Gm7iUwSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VKJaRiT5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA4En4024833
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 15:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ieO5QYvlXZ27cvWcN7TcUC
	qXSIjOdosqMsk86g8EQmo=; b=VKJaRiT55u+wuZYcGP8KE/vctxooO0A5jv4jVk
	RyLaRFlpfdDWcV8vhqfhsDmYS9/s3knHZ0hXB+jpgmvlWP1+5qgI2VdzwbdJyTeC
	VM1tq1ObC4n8fCKqoa4weYjQ5QhU1LFG2BNQg3YlEtYdbCdftMoPIdU96AstXT+Y
	qqbZ1nudl1vYg/fInjOgVt3Z0hQZvOxGecIJEo9wHd+e33c3dovXiPx6yiY40+lJ
	cTI1u5l3hnzIaHt4IUMtomd5+6hmP9VlJfthSTd7715YkFH8Q75a1V7c4u1WPHTy
	y0HFkkO5VCM9+Hm/rJqaD5nVr+RWOvKk16V1a7J5BRvi7JFw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52926y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 15:24:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24456ebed7bso292495ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 08:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703479; x=1756308279;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ieO5QYvlXZ27cvWcN7TcUCqXSIjOdosqMsk86g8EQmo=;
        b=tB7TFbMIhEfv6Lprro4xYCFrT3v4nGYJpobIsDo8elPIROXD7d3bGaBfQ87/Y93mzA
         xTX+EUdYEamHbUjm2jCwXeN+KOJsOqu8bPbFCIKiQY867v9ShY6As5sQm78rSbIPhkt3
         8DdhRzw/Oh8eVGVtBR5nj37DHGa/UMFndiCR2JWH0uBZ2CXy6XpAwbCbCMyNiwYv0y2i
         UsDlk8+9nsZzgM/eacgM0kUYTd/a/2EB+bS3Uau19fEoZZP+ey/jBc9Il45L6Ow2EpLh
         ue05TZEVwcwwymqExGR6IprpiD3eNcngNS7TSVqx1lpJXMvcYm/egh8/5EM/VjmtafK3
         Mypw==
X-Gm-Message-State: AOJu0YwFUhQQbb66+jkdB0RaGOV/1cpNuGq2mFLX5p7O2/iZQlt//RAT
	SSanrRXaaSn8Mz5hyS3/HeVASYUA/oiv2IqzJ3xqjKCzuYsYpDPtKUDwYodndZI5AWbxuqofzFF
	nyT0xskmVveVjuqV+1hygEppZJAAlT1IgC2k1673xvIxfiNxS4T16V+9CmaKW4ilSD7qmRg==
X-Gm-Gg: ASbGncuW0tATmpnq7aUPmNbMFZ+XHJ1Y+7PL92bqfzwoJ/CVaSbPLBZlJX8PGcY7rYb
	/d2ZRjZDhx7LI3GSzcr6FRrfwCl2hTtfq1HCCVd3960xHRqYC/W2XeM/VKE/ZD93gseN0p33Cv3
	M3fUuwdiNO6FGx84ABOqLzGAzz6WFFmLPAKPGstYrVI0+Ot+Og59jxBBrS014HnvefcobveQpQg
	XrVbwci4ic6S+87j7OT61RAWNqpdKe0rLjVjBTWu7hykSu9yWKHPkKVGku/u+uJDngyad78xQvA
	SylgQgJRf7zYAub9zg2R6oJGOHV/e4TkcM/8MJwE8fQno9qN1JNeVYjYFy0pHMq8Oqbq/6SEPjQ
	J
X-Received: by 2002:a17:903:1205:b0:240:5bf7:97ac with SMTP id d9443c01a7336-245e09d0be4mr86387525ad.16.1755703478653;
        Wed, 20 Aug 2025 08:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0VKBXRsV4LWznZ8KguG4ys3hOJb+MIIxxdAz09Ju4QNnohG2o8peVOrH0bhoqJVc9guMWrw==
X-Received: by 2002:a17:903:1205:b0:240:5bf7:97ac with SMTP id d9443c01a7336-245e09d0be4mr86387125ad.16.1755703478206;
        Wed, 20 Aug 2025 08:24:38 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed35d511sm29919525ad.50.2025.08.20.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 08:24:37 -0700 (PDT)
Message-ID: <323382be-397d-4df6-976a-89319fe97202@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 08:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath11k firmware ath-20250820
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a5e8b7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=SvOVevs7hV0f9PBrymgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: tI6HmabSE8GWBo_pRMi5-LTc2YNEmrDs
X-Proofpoint-GUID: tI6HmabSE8GWBo_pRMi5-LTc2YNEmrDs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1Wf5uFEeqPbh
 umoPNOE6zJa1RtDpU4A+JncXnXTw8TLu+ZcrVyFSWqUZpbdVcErQUNLzCuwNvuNsL1+MF4HFkop
 DcHeVCuyOr+FIhWWsKNdQ8rdyPnxLIm5YGpfPIqV8KYq8D1kqJFB/DHbQIyinD3cBmZJKgJ2ILG
 H58hRg9RKOc5Aiky243jEMRVlXT8nmYgmjdmtFOspkg9hIC+dacJIjPgp3WASLcDSULiqoQ5NSU
 qA+v5sDv17BZYKa42zU/JXLkqo1w/a2yjtDMfdlnjoqrqnQ7cdGr/fdmRSGV1J1Z/6BMRqqDOuN
 x35ykxN4LioPY8ZA+7XnGthYyXiLcjot2PJQ74zxTjl4AjtPhskv1kwLn3Unsv/Toccyusw9kAM
 9j8Zmt1P5WOJE6tCoiFibwVzobacEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Hi,
Here is a new pull request for ath11k firmware.

This adds an alternative firmware for WCN6855 that is part of NFA765,
optimized for IoT applications.

Please let me know if there are any problems.

Thanks,
/jeff

---

The following changes since commit 5dcaa87d4035f437acb9d8817d88b26932269863:

  Merge branch 'robot/pr-0-1755692386' into 'main' (2025-08-20 13:19:30 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250820

for you to fetch changes up to 71b945d2190cbaf6bebe8c1a8b0b41a71d65ec31:

  ath11k: WCN6855 hw2.0@nfa765: add to WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1 (2025-08-20 08:01:38 -0700)

----------------------------------------------------------------
Jeff Johnson (1):
      ath11k: WCN6855 hw2.0@nfa765: add to WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

 WHENCE                                 |    4 +
 ath11k/WCN6855/hw2.0/nfa765/Notice.txt | 3658 ++++++++++++++++++++++++++++++++
 ath11k/WCN6855/hw2.0/nfa765/amss.bin   |  Bin 0 -> 5005312 bytes
 ath11k/WCN6855/hw2.0/nfa765/m3.bin     |  Bin 0 -> 266684 bytes
 4 files changed, 3662 insertions(+)
 create mode 100644 ath11k/WCN6855/hw2.0/nfa765/Notice.txt
 create mode 100644 ath11k/WCN6855/hw2.0/nfa765/amss.bin
 create mode 100644 ath11k/WCN6855/hw2.0/nfa765/m3.bin

