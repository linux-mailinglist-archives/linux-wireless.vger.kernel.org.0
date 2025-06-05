Return-Path: <linux-wireless+bounces-23779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12247ACF557
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D3E3AB9BF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333627815C;
	Thu,  5 Jun 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mAN+pzXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B81275869
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144450; cv=none; b=Xis5RFaPH+p56pSu78vJdAX/ki+z743vQfvUf521GF+VdaLyEIAyao35VkSB7eBCY1AQrWDofHAal8wG8AW6/Nz6nquqld185iHgqmLvKcbAYXPhjGA9sM+8p8uqS+gU8OhWVHFntC7E6zFFNHE5T+UcmRcwJo6kAUe8NC1Mhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144450; c=relaxed/simple;
	bh=dhkkN14WgrUSmUyToafAh2FH0ICjxxpgvf6bFXL0f4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LZEtZXe5sZBgqL2EyyksRoYTAF74Dq9EHEisU14MQvSZO59PQoH8TR5izZfENWwnQ7LXWwWmnnX/jx72ddks5HF+UDxLnJH98ZpSxW5AV0gNyPXPa10tt/LjJKQHTdYl9NP7qXgHMdfm+JJvzN2Y8KbkHh1QVCJZv7BRtkl702M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mAN+pzXT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55586Vtu013521
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 17:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3xm6VfkW3b6R38nakzaF1b
	bb+wxJ3bDtlf6fYnH8p0s=; b=mAN+pzXTJGnZmz6vpc4N99ETncv0WEUDRZfqIU
	1D1gSo9quyNrZmgOT5xChLi+cfSz6gqeaWO8BSNjGw6hgus75I1tGQ5jUP2Lueo0
	S2V7lRjr6OzVucm26L9jQ378pBe4xNVmFy+ijV7IWW96VDho4/Yx58IKv63MLzSF
	lI4yRMLai/jhLly5duCJwJB8Gb57FeWmoNH3e1OWq36p6I0L/HLi2EOpoUZOx1i3
	jWSvOglXv5QozxII9s7lfK9VfF/LYF5maf10rQ36FoB7fPZh63YOQmZZ5EBWmGyB
	jHdjibXScpRMy4UecsX2UvLG5jY7NXeTAbV+JCWhojo+7mMw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8nt46t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Jun 2025 17:27:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c37558eccso758381a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Jun 2025 10:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749144447; x=1749749247;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xm6VfkW3b6R38nakzaF1bbb+wxJ3bDtlf6fYnH8p0s=;
        b=VN2J1iIEmu9lxLfv/HMZyVH27H5e7Rs7aMNGI834/5LZM2m9ywMCuw2Sc3w5keBVTX
         5sM9ACN+JHsEY6r1mkTnH5mPqipdpPJzWGggFIRqVJ1K6cDCwMXaZ+c1u3fRgjq0GknN
         A4QZDpE6ijeE9mdOGgqgyx5ISztthsmQ1yqQuihE2zcmTqxpFTrTt7fmjvxaZEgLsOSd
         VMOrbZW0znK8UA79+29I6Z4ieNVG4YaNAdPcQeWSKbLHJoypao7YPj8VlK1UditQR3uP
         GCyFdn6V1vQL0XPYTKwEhvI30FRAyJjYS/VX4eUmKdREJdKfH23P9jik2eNZ+bzUuB3w
         44VA==
X-Gm-Message-State: AOJu0YyLQK+1SGokbUvW7U61Fj0/4XOETPIHEmaDeaxZ7+7i5HOKfl3K
	WJykwblxsuDmIrzWgH4zyEx7W4/KgQozRsE/i5/qPE/9DTmOesJ4vD0mJSaI1S8k9nUXw0/UueY
	AyVqM9DJi0ZrLZvY1xdJrbZXzBmdhMoHehghsZdvDiLPK7jyz3bRYinrGwyk7cictDwwGXA==
X-Gm-Gg: ASbGncuc9uQo3xomsCEWi2TYkxmPG+7bBkOGv4ZkMqsZtONkpAZlqUuHsldvjN5Jd3M
	47tEM7lwBzBrRn3QRPtQ450nn7Gs6MY2ftBXHylgQz183GJC/Vr7/GCtTqCeBZbOCv5LAvsnQA5
	CE+Mm2gqRBXKIkickx2rj5YPFylwpHBKTa5kgfkVYCGMD6StuxGiJvg6xVxoON7N2hGHW0TEp7k
	+o+U1C3QesYYziK96SgqYczBW7o3uE/5QJiKjKbg3xONFKkKtuJ2KwLS+JRG10X6wmaF0syvUT3
	5b2OtTRwpqMQYcYY75PAKaiFxyrPNt3eS0jyPEHBW+w3J/+KDUg2fysyl7A=
X-Received: by 2002:a17:90b:2745:b0:312:ec3b:82c0 with SMTP id 98e67ed59e1d1-31347077370mr763373a91.29.1749144447246;
        Thu, 05 Jun 2025 10:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1HoQdeZlqYAmREaJI3cP23fIbpezAsHxgeEHIl1GsrF8SpIDQpOWIH7S6MY29Twac+yzaog==
X-Received: by 2002:a17:90b:2745:b0:312:ec3b:82c0 with SMTP id 98e67ed59e1d1-31347077370mr763341a91.29.1749144446832;
        Thu, 05 Jun 2025 10:27:26 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f44c28sm11096a91.23.2025.06.05.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:27:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 05 Jun 2025 10:27:22 -0700
Subject: [PATCH ath-next] wifi: ath12k: Fix hal_reo_cmd_status kernel-doc
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-hal_reo_cmd_status-kdoc-v1-1-e59f4b814b88@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHnTQWgC/42OQW7CMBBFr4K8xiix40Sw4h4ViiaTMbYgdusxE
 RXK3XGyZdFuRvr6eu/PSzAlTyxOu5dINHv2MZRQ73cCHYQrST+WLFSlTNVWjXRw7xPFHqex5wz
 5wfI2RpSorQZllO7QiEJ/J7L+uZm/BGQnAz2zuJRmACY5JAjoVvPaTeDDCjnPOabf7Zu53tA/h
 +da1tKiaq3t2iMOzTkyH34ecMc4TYdyVvP/NGQ63So9NsYcPzWXZVneNmhgMTEBAAA=
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: mX4XIBC0vixfElKRYQ3my9N20azt4K3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1NCBTYWx0ZWRfX7U8yXMMK8ZNb
 xJbEMFiVzKwNeN6pgUQGsF6iroslYYNBbhRPia5P7R5n7odP0rOP6lzGeD6HFbewpvqe5DvRIIO
 Y0Vl/FnWt0o3R6A5zjk3s/txsviYdUXqgBQ1rOlroaVC4qPbGawZH6A46ZWa62W78PFTNiFijK6
 mucwnqikKIApOqpXUudxGkWSVs49H+MfQ8lFgusxPTz1hEa+GMNy2rh5wVjaP/v7lH6DLsEQxwB
 TOAQShGQTwxaMHAbCUp7or3TXCL82YqYlP8UR4iQ6Qr0rYWiGfmmgMowvQ5H+oYxyWjP7lW0Yv1
 Q5p5CXWmqkoB4hL310DbJsHI6CM/kQ8PD6J+qbs1WcPfRwM9cO3wgeagH8bKoudgfbvfI7npsOg
 HOjKkwg/vU6E9bFTzHedyVYgf3qMaXr9hhPTxhWfyfBRCxkL1EfEoKdRBg/sMy+fGXoUfY9U
X-Proofpoint-ORIG-GUID: mX4XIBC0vixfElKRYQ3my9N20azt4K3k
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=6841d380 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=jmxE7Al2yye8V0ZPzYwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=742 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050154

Currently a warning is reported when running:

% scripts/kernel-doc -Wall -Werror -none drivers/net/wireless/ath/ath12k/hal.h
Warning: drivers/net/wireless/ath/ath12k/hal.h:596 Enum value 'HAL_REO_CMD_RESOURCE_BLOCKED' not described in enum 'hal_reo_cmd_status'

Add the missing description of HAL_REO_CMD_RESOURCE_BLOCKED.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
Note that although HAL_REO_CMD_DRAIN also does not have a description,
kernel-doc isn't complaining. Furthermore, my analysis indicates that
HAL_REO_CMD_DRAIN may actually not be required, so after that analysis
completes I'll either remove HAL_REO_CMD_DRAIN or document it.
---
 drivers/net/wireless/ath/ath12k/hal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0ee9c6b26dab..c1750b5dc03c 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -585,7 +585,8 @@ enum hal_reo_cmd_type {
  *			 or cache was blocked
  * @HAL_REO_CMD_FAILED: Command execution failed, could be due to
  *			invalid queue desc
- * @HAL_REO_CMD_RESOURCE_BLOCKED:
+ * @HAL_REO_CMD_RESOURCE_BLOCKED: Command could not be executed because
+ *				  one or more descriptors were blocked
  * @HAL_REO_CMD_DRAIN:
  */
 enum hal_reo_cmd_status {

---
base-commit: c3910de7bab78afbc106206aed5ec8e79458fbee
change-id: 20250604-hal_reo_cmd_status-kdoc-c3f3a25237c5


