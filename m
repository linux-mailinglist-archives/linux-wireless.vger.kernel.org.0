Return-Path: <linux-wireless+bounces-26390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854BDB274D2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 03:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BC77B1299
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830E2877D6;
	Fri, 15 Aug 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WS6Z9hB9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01B2877D8
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222317; cv=none; b=aOpkjgcslXP9Zttj7HK942Lt2pLWsbqCFl7SUsmsyqifKELTK1R9xD+nIHmXpuTuCRSjQRtKJzLKfHC4X6QEiHoWbfv3b3qKsNroRuv5hRUlLkfUDgBw7JAGhjWJ73KN17smBgaVbcUn4HmO3wHhw571VKYz1AmRxgBXO456F8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222317; c=relaxed/simple;
	bh=9C+DX3EjRe1T7uh1I8bTX1sVz7A7ptn5lWEATQDBYMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fe41JKdEpfk9bsqo7N2bJVghGFa2MIArqKnyMnxHXVCJMLePKzyLccSeewvQJIkpVMEw7LGJkxdgEO9GDWY5haLyPvi3e6vlzF8vIjusYstTyjhTdppbM++n2QxYOeOUYNvqNIfMvLiU/CHbEwI5rbAC9dIlTXBuhfspJavgzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WS6Z9hB9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHemAR020736
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4P3lXv4/uPA7E/VgfMVu1U
	mSqEzdZA+CkvLhRV6TU5U=; b=WS6Z9hB9e8LqSb8eKL6cdbY78dkdRjMB29jJWu
	FhiSmMzhbfAU7LDHmHQG2Q9zA5/bGGUK4LgbRSlagB7QQTGac+8nd5EA9tmQc2c2
	Ab5pgA+3V4NxDkxRJ36D1Qtr7iA5gvOAaeB7YNi6Zg+oE8he9a5eIYixr/W9NAdI
	SHh7CqKgfnTBPr7///9hwabIeF63aOuGVQkKbsBSxDwrGB/4XXe7YG0wjuG1/e/b
	2y6vxjNC+KUI2Qd9/0Fx9aCcdOgAp3/NpnU1a2O+BQGl+45YlBDdHV2dOXyRkZtl
	4ZUomUKDLJAIZJamQSiK2D/AXbuhKpoXAkhiNompT9C6IE+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9t1vhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f440f0so15583485ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 18:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222314; x=1755827114;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4P3lXv4/uPA7E/VgfMVu1UmSqEzdZA+CkvLhRV6TU5U=;
        b=uJyX8FFrdx9bLwWW5bI9om4BTe/LICMfFFTXS9ZaF+z2aonuQSr4I0v9X9PyF9NK/N
         cj+EemYxbUX9aroJIqHuL91gK8RkI9UL4TMkI1DI7TrJtoodLfSZoEfYXHQPIyryRa7S
         R3pp+GeQhUYNIIr82mpzTv+Q7JTyp7OLyXITYCv45NFV5BD0H7oMzkqqyETDSGfOSN9M
         T7b5tejb35NAWxNl5grZqDwuh3c+MtbeeWG8e2WwfE6IskH+pN6VQy/WPfpmCCqsBmG/
         SyBIM3INRDJrOyL0rOgcfXd0D2/kgv1FNWrLdOC9Jvvbbys4hOSp5kKuw7E6Zjd7847v
         NZGQ==
X-Gm-Message-State: AOJu0YyxoF1JlZX//Y1Os2NA8ha1Rt/299mkviGgvoGHGAYIFEzIf0Cb
	t6g8e0cpLBoZsf6FHoBBT8F2ZNMIHZiN/rVOXzXefz0nhfqluZv6qDvgRmzShK62Eb1QcCLk3IX
	p5+zqrv3W3Z5kNWhq7LmmAXYbnXrLcArc2kVNR4CLrCgXwoQ+Qk0NOzagEU4uPjLPddDuxA==
X-Gm-Gg: ASbGnctk+8JELaqgX9Sh82xG2RaL3izjYg9/KHWDtlG/fXG4w+Yuk0cD7UObnJFI4ev
	cnQCBmpvolt06m9vdzkY4OSdsXKTguJatfMfKX2iiMg4qwSicFKPoEucYKMovTGLQ3OhhWeDb5t
	aU5gv6CY2jvfvPLNhsCUJJlq8AdJqIfxzO2xky7/Ln9A/dlhdTyAhzaTnldgv0qDy1mM5x6lq+j
	MmThezJpRIXMH4Ktb0QCoJV349k2tOw/HmKvJD/I2fBNSRVEBHttDRIM5zvx0z1Hjf/Afh/d2gc
	bzX/MaGEE6kviKPjernfcCq+uwTY1H9VXtLCTq0gAMBqsKRiar6LuYxM/0Y1EoJOZBT3ZXf7Ro9
	Pb72wJreKx9LsW3I/
X-Received: by 2002:a17:903:3c6f:b0:23f:df56:c74c with SMTP id d9443c01a7336-2446d715b0bmr4579965ad.14.1755222314395;
        Thu, 14 Aug 2025 18:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqjJ5BnUL+tpWpRnC86E4QXEbco0IbzESSL4M5fmEVPbzVuES86olfGCLzLuwlUQ8m/AAbsQ==
X-Received: by 2002:a17:903:3c6f:b0:23f:df56:c74c with SMTP id d9443c01a7336-2446d715b0bmr4579565ad.14.1755222313913;
        Thu, 14 Aug 2025 18:45:13 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:13 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath: downgrade logging level for CE
 buffer enqueue failure
Date: Fri, 15 Aug 2025 09:44:55 +0800
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiRnmgC/5XOSw7CIBCA4asY1k7Do1p05T2MCwqDJVFQaKum6
 d3FxoULjbohmUzm+xlIwugwkfVsIBF7l1zweWDzGdGN8nsEZ/JMOOULKhkH1TZggm/hoqKH4EE
 joD932CFY5Q5QKqmQW22YQpKZU0TrrlNiSx7XHq8t2eVN41Ib4m1q92zaPzPie6ZnQIGu6sWqE
 lyglJuQUnHu1EGH47HIz9To+b8uz67Of6+MZrYq8YMrXt3yB1dkV9SCLtFaI+v6jTuO4x3/AR2
 UkQEAAA==
X-Change-ID: 20250812-ath-dont-warn-on-ce-enqueue-fail-4a8ae2fcd1ae
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689e912b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=nBwn2dWH28VFQPEByrQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Qx3nKac2GXDxTJgja14LNj3XKcQbkleV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX4K7/f8t8LXgA
 nP1VeSkhPc2oR3aDfULdiSJMFJZllpuZw96mAXFY5qIc8QbsUuK+rIMmzHNQQXdVyUBbsgdfmXo
 fW5ebKI8QZd4z64cZp0Wo0iLHPbeiR4xOhTGcCKt0T/Cv7aE/jZBkSaBrYknhI0apfRjR/19Qx7
 y9kg+lcCbsJW+tDEZCqvip1q4Rf/hLsZq3PsUdCjUdwTt4llJSN3tWrm8Jv93XDVA88X95OJYm4
 trIyNsmQ4FDgfVmEdNkqyoUAA+8hxwRP9VDgsFMFHcgVAfUPXZgpd7qAdccYK3DkWTJDwuPtMkJ
 xt6QDAKHaolmsHDaMOopLC/XZmnnoqaVpxDN5cU/O0q7A8/apQ6huz2+tRHnPy44aig/WXo3P3/
 trEJn542
X-Proofpoint-GUID: Qx3nKac2GXDxTJgja14LNj3XKcQbkleV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

The CE buffer enqueue failure won't cause any functional issue, downgrade
logging level to avoid misleading.

Also fix an incorrect debug ID usage for CE.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (3):
      wifi: ath11k: downgrade log level for CE buffer enqueue failure
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath12k: downgrade log level for CE buffer enqueue failure

 drivers/net/wireless/ath/ath11k/ce.c    | 3 ++-
 drivers/net/wireless/ath/ath12k/ce.c    | 5 +++--
 drivers/net/wireless/ath/ath12k/debug.h | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
change-id: 20250812-ath-dont-warn-on-ce-enqueue-fail-4a8ae2fcd1ae

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


