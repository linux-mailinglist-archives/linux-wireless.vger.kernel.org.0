Return-Path: <linux-wireless+bounces-28289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF45C0B9EE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 02:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA71118A156B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 01:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C931C84B2;
	Mon, 27 Oct 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnMYINSV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D218C02E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529769; cv=none; b=mPZyJn41YjOkEIl9DZci/MSzpC9GpMTaYHx3DTL5/zvhBMP9z5wG7monfaGDaqSB7JaN2chfQ52LyPh15zRBZ5WPsaO5cwaHeCpY+Q6kQCcELgQNwpKKfsJffzaW1OSRX3nt6Vfdxcg6rni6RxXV0W5AqqkC26vv70vWDUjwREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529769; c=relaxed/simple;
	bh=8A6UNTVQJ617yuuLQYsGdQAAi5PS0DaKJ9F0Lc4f398=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KTyct5wLTRjT28Pepx5a6E99nYJjyLKH+q8oVRpTUs8pIZfH+jwiFcSXXNFgAuggImIbBWYweAXVWBeR2V+184QKrDTDKqkEWAzX8Sp8zmeACwEnAAfLh1rM4AUzPQrgbnGQnsCGV0cwtoR53Vxw+dlluAzGoKSRs7m8layPuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnMYINSV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R0iaZB1258841
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 01:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MuPdK376HGXmgMfDF91SNm
	DDDEoWU1qzKfRPb+hJCr4=; b=XnMYINSVU3iI7o2KJKWTe0nIOu7jspl+Tqb0zU
	iNGbdr/UGWzMKmOMQVUEGqE9Fz7w8D6qrUkLsD5JKs2FppGrTAxz3f1WgR1FNJmj
	YYG/yUl3AMdoeCKzQfY753Nx+7n6rTFJdsFzWvyvfsUK7w0DkWfv79ZrVJhGw1yQ
	M4WdBUlX8Cghi86foeBfYOtljGQ9oXx+i4UxRJl9uH0vA277w7VvRdYL5z22fAOn
	uNgkMIgDE7KBQjHzPw+VEZZsPUe7k/TslPVWIDGpIH8lQYsTV7uEm0B745TWwkHL
	veIoMEJQG2ovOTxSLN5OChfAawJQifZOOzFl1DrJUDPA7MCw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1ud1r9fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 01:49:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a26a53a4faso3174841b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761529766; x=1762134566;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuPdK376HGXmgMfDF91SNmDDDEoWU1qzKfRPb+hJCr4=;
        b=rB8MTCe1aQYe//wEpof2BO6q9aQZipMfztls+HgX+IGFKcJbr9pkH/r0qvahGYJ5zE
         +SF9gpD3D/OsS3nTHtBP55QV8EelwGmniHJsvS0trrRQXmSkDPEPUkf3kjC30Yz89Ku+
         PiWybSrnFK8Dp3t3eI01f3R6BWc8W+/o5UORJSzHt9K9CoQoIukpBBVV5OsMOxFV4UJE
         OwDHUJJOXMKKw7ImUH2oNp1T4+VwnIbl9XqgBHgPe+dSFI8ucMWTE3vQG3XM4Ubah+vt
         oCN6lWGKLks21SRVSo9Akcag9TD4Q8qoV64jn0dHsHq503gu3odpbi27nWo4lwg3w+Qf
         oJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE7PP1QGaLx80wtHTjmaF3ZcFjTcsHhL7uuWRTehy1g2b8KP/AeelYCiPUIE4bMEy7gY8AHeARQPF0pK7/5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyC3ei1vde+cI1xPVOl2pobeQIwOx5cnicmYy8nNuRSW1b4Cl
	V1oa1ScZ7TwI/ws5ewT+lNgxHtL0TqDEpypItDcmPLjkuoMOzWLIw1R+YiC4ndeD/w1uluUmxno
	QBEtwjywrWg9Wg4Iycf74HXwy1f6qAulYrsp3VV2Ka0RMnlLyVnOvZM0ctNlg2zN5TQ7VFQ==
X-Gm-Gg: ASbGncuSiqEBxNHkP8SdF+i2P6H9/G/0aeTOrTyjT+I9jZW7ligPi4++NAaG8i3MqB5
	9HzZMWMaNhnenLY2QXF0CyYByVJSI68Al97MTRrEx1vF097YmgoOIaA2wnH5IGob0m3LY4b5Rlf
	FhIge7Qz0XzG5hGKEIonS5GhdAX8foZSoQTfob13IWWdusRxKwWj+JJbL/Yz5ZqpH1eTpf4kulm
	9tvRQ20WeiLCQoMn22C6sFVnC6FlXG44i1IjQVAqmK4SrOOWvV3YRjGmMV/pxAiJ69rmRV/WHZV
	hwADH/VVLz1YnNy2WZVGwZHGNZ5rBbDWxpV3xCzHzWPcsIDnCdZzGnmwyY4JMzwbcicjqZHc7OC
	i8xDL9l1ps11jTXwi8VNEIteP1WJK890umjZ0FR0hCATfiLceymX1
X-Received: by 2002:a05:6a00:3e10:b0:781:15d0:8840 with SMTP id d2e1a72fcca58-7a220a1ab68mr38116869b3a.7.1761529766010;
        Sun, 26 Oct 2025 18:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+mqB25bQNFWbd2XSV2k7TA/8rJVvtb0wxpf/4AFuQ/E6+qSYyldl2lwymGpfMqXfIXqDKGw==
X-Received: by 2002:a05:6a00:3e10:b0:781:15d0:8840 with SMTP id d2e1a72fcca58-7a220a1ab68mr38116853b3a.7.1761529765537;
        Sun, 26 Oct 2025 18:49:25 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e554sm6136588b3a.18.2025.10.26.18.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 18:49:25 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:49:12 +0800
Subject: [PATCH ath-current] Revert "wifi: ath10k: avoid unnecessary wait
 for service ready message"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJjP/mgC/5VOSw6CMBC9Cpm1QzoV4mflPQyLSltohBanhWgId
 7chXsDNS17ed4Vo2JkI12IFNouLLvhM6FBA2yvfGXQ6c5BC1iRkhSr1JJ6YvYYTTmEYnO/QOo4
 JfwmptD5frLCaashFExvr3vvIHXIe25nZ+ARNFnsXU+DPfmCh3fLP1kJIqPSRHkrTSdvqFmIsX
 7Ma2jCOZQZotm37AvxyKJLoAAAA
X-Change-ID: 20251024-ath10k-revert-polling-first-change-2add89f0fd15
To: Jeff Johnson <jjohnson@kernel.org>
Cc: klaus.kudielka@gmail.com, yannick.martin@okazoo.eu,
        andreas.tobler@onway.ch, mathias.kretschmer@fit.fraunhofer.de,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAxNCBTYWx0ZWRfXyl8mj45kdZnt
 E0aUB1QEKnAE7SJb3+ZWNX/alrkppzQSNu72j5JLJHwXfrWnOyfc9gv4tEmXoa1bi0G++0GtaTM
 e/l+ObVOA1s7Zcfc7JUorKrUksbsTlbnWLh56mf6G+5x9PQfh01naqUybkP3zYNf6/jtrrZ6kWM
 ccJmlfP3hGUfl+xk1x6dGaCIjlKdP9Vb+T5t53BXJhYL6KG4g3IgjdrUKvdK5yB61l0feuFVeaO
 yNyfn2rD5KbdwQNvs5wRBGUrLDfCwFfMmLfujs4LIj2lJOsw8fBXfpUjKX4Tbk0S8hfadUKanGM
 vo2/AM1LQiCNajY9KskVANxstPHh0gYQ2CC9Ibxl2SPeVBfnum9ct/5F9lSRzplTLR88ROKKQYx
 rPsRYgd9d1t/l8Jw5c5QL/aycUHfAA==
X-Proofpoint-GUID: -CLLMabuWUg6ra-dpsaaa4iYzBeeto0m
X-Proofpoint-ORIG-GUID: -CLLMabuWUg6ra-dpsaaa4iYzBeeto0m
X-Authority-Analysis: v=2.4 cv=UqNu9uwB c=1 sm=1 tr=0 ts=68fecfa6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=TM4VhvQv0bBXhhio0rIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270014

This reverts commit 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a.

Although this commit benefits QCA6174, it breaks QCA988x and
QCA9984 [1][2]. Since it is not likely to root cause/fix this
issue in a short time, revert it to get those chips back.

Compile tested only.

Fixes: 51a73f1b2e56 ("wifi: ath10k: avoid unnecessary wait for service ready message")
Link: https://lore.kernel.org/ath10k/6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com # [1]
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220671 # [2]
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 39 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index b3b00d324075bd1b82c76f2d93cf4e2a79ead769..b4aad6604d6d9d95b918d0a077f5d1511bc249ad 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1764,32 +1764,33 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
-	unsigned long timeout = jiffies + WMI_SERVICE_READY_TIMEOUT_HZ;
 	unsigned long time_left, i;
 
-	/* Sometimes the PCI HIF doesn't receive interrupt
-	 * for the service ready message even if the buffer
-	 * was completed. PCIe sniffer shows that it's
-	 * because the corresponding CE ring doesn't fires
-	 * it. Workaround here by polling CE rings. Since
-	 * the message could arrive at any time, continue
-	 * polling until timeout.
-	 */
-	do {
+	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
+						WMI_SERVICE_READY_TIMEOUT_HZ);
+	if (!time_left) {
+		/* Sometimes the PCI HIF doesn't receive interrupt
+		 * for the service ready message even if the buffer
+		 * was completed. PCIe sniffer shows that it's
+		 * because the corresponding CE ring doesn't fires
+		 * it. Workaround here by polling CE rings once.
+		 */
+		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
+
 		for (i = 0; i < CE_COUNT; i++)
 			ath10k_hif_send_complete_check(ar, i, 1);
 
-		/* The 100 ms granularity is a tradeoff considering scheduler
-		 * overhead and response latency
-		 */
 		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-							msecs_to_jiffies(100));
-		if (time_left)
-			return 0;
-	} while (time_before(jiffies, timeout));
+							WMI_SERVICE_READY_TIMEOUT_HZ);
+		if (!time_left) {
+			ath10k_warn(ar, "polling timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		ath10k_warn(ar, "service ready completion received, continuing normally\n");
+	}
 
-	ath10k_warn(ar, "failed to receive service ready completion\n");
-	return -ETIMEDOUT;
+	return 0;
 }
 
 int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar)

---
base-commit: d5d9da878287cb30199defc6941b695f33f9236b
change-id: 20251024-ath10k-revert-polling-first-change-2add89f0fd15

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


