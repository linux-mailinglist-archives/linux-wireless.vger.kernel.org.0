Return-Path: <linux-wireless+bounces-26245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3BB2034E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 11:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4931677BB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206002DCF74;
	Mon, 11 Aug 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvPopkPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994A2798FA
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904415; cv=none; b=GOaaWclQ2EYMVZ6Rk/rsGv/ollIrMmpFY1nVFZ/TGYBfpyu+2HuGI5N8q6o/gw/k/9s+13vTOAqFsHRluw0pspC8etsZXReWjXxR88UjB+DjI30/n7NT6dlGJ+fFB+yaytBcHvFXYFXvhA5uk/DFzmJ69poQ1x7GSthe01vdPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904415; c=relaxed/simple;
	bh=+Jn84KhDH5JdiT/uUB9NAEewloBck7n4PYNux60R0aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HVP/+U6HQj1WaFKbSb6AhgnR9WXfkf7WGGh9iS1TVBaF2wlG8Fe7cN4P+rmcSIXOXhpqESjdOjMwfe+GoDJa4BYXxCRyXKEiZvAvFVoSfWxWxBXczP5BGuV68oSh5J4dlBb4Mb5a/57qx98LdejPRfo7HBH8xdo0GFoPlZgQBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvPopkPD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9M1Bf019100
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 09:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CQPpOmZCkWntibNDeZA3Oh
	vcnLM7mE0auXLL4JL2KE8=; b=XvPopkPDYFoer9PRjH7nxiyjqJ9uJBqvniz6G3
	rxxZ8tzr7QO3+LKhNVYXuaeTjGPb/ntAnqokDayZfDkj8j3NOtE1gK0Nai498oW9
	pze4+XISscyvhllrvIF6GANVdwzd6HaJyD9/G0Xk+gfwzSg4XGTozPwVjiapv+28
	keq60LNaIinPdW8UmEdYglU5hRl+ybmo+/WQkx6uJZNgvuJT6nFWybO/NXFwSYac
	Xmx38tHyFfhNWMdFOvUFnF8AKRb6gqEa5J+zFZN0m468JhBZGHCpNa/gGslaLy1p
	nWCDTU3rW3MNdiK6eHAT6qQuchzgu05tPBQ6ZtdmLMiAaG5Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj43thj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 09:26:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-240012b74dfso31178385ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 02:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904412; x=1755509212;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQPpOmZCkWntibNDeZA3OhvcnLM7mE0auXLL4JL2KE8=;
        b=NDTiDC+XCyFm0J21KNmz3Z4yDqFWOUgODy4rX14TIxHwvtPrpFAYOR/y4uwBcZE/Yt
         8yADwo1T3oVrKSaxEqhHY8c4YCdOC9RtMuE/rAGyoCJA7Ps4hcMi3ywJHe2MN+TYgzJg
         fKK+RLwRtVCUbnUPbCW8YcwTGJJZOsk70MvY2c4UVn5L2d0U7EU7ZVv6vF+NxDYn89LG
         PCz3rOEVE0pQj14pJ3NRDq3ocWfspRTlH2JI7E2vPBeuR3QG3mQz5VRWs1x0Vh4n0nLU
         HfiNAFLTUsAIDketOFk561+k72i6+9wzL9KIP+Nfh0/6nEKTElbCcm8yP1dD10bnAqqx
         P44w==
X-Forwarded-Encrypted: i=1; AJvYcCVGYnh9UEYwq2czH+9GrCAZhqr05YX5JPBFxSgNJWJ44+xywZVg4q0F4qny57aBpGTMQ9wUk/kUh6rumw4Qqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLK+CBMsU3lPFlABS0Hf21P14Gup/07p41DCMOYfzqorB3TauP
	V5O0DkXGRxtJiGByedR5LcvYnVFBJssqcCIs83yCZKFNXToNHwxdvR1C2xJVmDQmr7EoW5TyAII
	j8wazdvzdyL/vGWTQVG3bn4IBsDPaCTGjdgf1Ag52pwEZWQCD0YiNJN+pRCIRUJ1Ea5kB6RinPU
	PcCEDv
X-Gm-Gg: ASbGncttKGy6EMDtLCnC6Nk1ivLohnbSi4wgmGFrhlbxvkRshgS9oWRdOK4812Wm0jb
	bUpbc3inkzSkBHLqmjMgGpHcopJTn00HTeu1hoP+70yFYPVl4oweO0hHXz1HqjEEdmDG9qeMwow
	h8jmqKTWN16sR8ynOPmue2fBgGa9DDoUpAt6iQZL/BZQgHM+oRMHuNjwLejZ0aGbeSLSb1oTuXK
	IvfKNziZ4k9a4tsSQZI21JbOzV59DwPq9vqAfP2A0R9oolI0zZsPmyW66cjkIrgkzQbpDJzl3KD
	DMuX/+c3Yf8MaXuBvEiu74R3maqMpz/mZCq62IoRjtCFiyn1V2roXDFNjPYkiG1EdvAiT2uKWQs
	PyqI/Lpy5rJjpNbEAkA==
X-Received: by 2002:a17:902:ec89:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-242c21dce5emr200859335ad.31.1754904411732;
        Mon, 11 Aug 2025 02:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv4VfSrPpmI4rTjy7szf5KU+m0hImvSmhqNQsa45lSoD5gt6acMlPIQBIsBIaMqJW5fw/yjw==
X-Received: by 2002:a17:902:ec89:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-242c21dce5emr200859025ad.31.1754904411226;
        Mon, 11 Aug 2025 02:26:51 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612864b5sm14277228a91.28.2025.08.11.02.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:26:50 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 17:26:45 +0800
Subject: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for service
 ready message
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFS3mWgC/42NQQ6CMBREr0K69pP+UgRceQ/j4gNFGrXVFiqEc
 HcbVi5MdDPJZDLvLcwrp5Vnh2RhTgXttTWx4C5hTU/mokC3sTPBRc6LjAMNPfIrULC6hdEY1Sj
 vyc3wIj0AVa0sMdvLincsMh5OdXra+CcWr2DUNLBzXHrtB+vmTRxw2/90BASEFqOpyASRpKP1P
 n2OdGvs/Z7G2ARBfELxF1REaCMliRqzsi7yL9B1Xd8nji7IMAEAAA==
X-Change-ID: 20250730-ath10k-avoid-unnecessary-wait-a9d48136490f
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX3rSNznFLB3Ib
 EjaxIHC3jAGLwgUEgNy8LHP7ydFjX+MrVsseDrJ5sIKsi/fiPQCCOeCZDvcMPOqo2D2jVD9L9q5
 Xd4Wc2ALAM+9tCpQ1obLnrfqsKZXna34Wycemh0RoPajuF0w3iwFrgm+8rIlkNR4AzdalAvcuR2
 zkAfkt+0dvVHEI7twQrxn++G3cPaX7Et11x/TpAAENdEnW7ezvTzCX1PltQn1IdVoBkCm6PLYSc
 Ia3fW0Y6VKxnr43SZfM+sxXwe2pFPkoGcOXVumPKkYjJA3wjL2mv8b1lFwkKrkyCNBej+9o5dyT
 h+V2bgsqkJZx9MJQc4/9wGZFkzW5NfigQlIGWv5RBzanZ1cMDhRBmxaX5jttZY0fnPc0tBSnxRg
 u0BzSEkz
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6899b75c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=h8RaaEB6tyxFYfTmgIUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: BLKhJ6PzVvBk3Ny0i92-89q6zyRrPOI1
X-Proofpoint-GUID: BLKhJ6PzVvBk3Ny0i92-89q6zyRrPOI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
failing") works around the failure in waiting for the service ready
message by active polling. Note the polling is triggered after initial
wait timeout, which means that the wait-till-timeout can not be avoided
even the message is ready.

A possible fix is to do polling once before wait as well, however this
can not handle the race that the message arrives right after polling.
So the solution is to do periodic polling until timeout.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1

Fixes: e57b7d62a1b2 ("wifi: ath10k: poll service ready message before failing")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/all/97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 39 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index cb8ae751eb312109f74985580065c3b9d3806d51..e595b0979a56d3110ce0acf534e718a4a1f36a0b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1764,33 +1764,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
+	unsigned long timeout = jiffies + WMI_SERVICE_READY_TIMEOUT_HZ;
 	unsigned long time_left, i;
 
-	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left) {
-		/* Sometimes the PCI HIF doesn't receive interrupt
-		 * for the service ready message even if the buffer
-		 * was completed. PCIe sniffer shows that it's
-		 * because the corresponding CE ring doesn't fires
-		 * it. Workaround here by polling CE rings once.
-		 */
-		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
-
+	/* Sometimes the PCI HIF doesn't receive interrupt
+	 * for the service ready message even if the buffer
+	 * was completed. PCIe sniffer shows that it's
+	 * because the corresponding CE ring doesn't fires
+	 * it. Workaround here by polling CE rings. Since
+	 * the message could arrive at any time, continue
+	 * polling until timeout.
+	 */
+	do {
 		for (i = 0; i < CE_COUNT; i++)
 			ath10k_hif_send_complete_check(ar, i, 1);
 
+		/* The 100 ms granularity is a tradeoff considering scheduler
+		 * overhead and response latency
+		 */
 		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-							WMI_SERVICE_READY_TIMEOUT_HZ);
-		if (!time_left) {
-			ath10k_warn(ar, "polling timed out\n");
-			return -ETIMEDOUT;
-		}
-
-		ath10k_warn(ar, "service ready completion received, continuing normally\n");
-	}
+							msecs_to_jiffies(100));
+		if (time_left)
+			return 0;
+	} while (time_before(jiffies, timeout));
 
-	return 0;
+	ath10k_warn(ar, "failed to receive service ready completion\n");
+	return -ETIMEDOUT;
 }
 
 int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar)

---
base-commit: 0f79768f8d665b43b77967d38b5df6ccebe8cb57
change-id: 20250730-ath10k-avoid-unnecessary-wait-a9d48136490f

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


