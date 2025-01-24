Return-Path: <linux-wireless+bounces-17894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE15A1B053
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 07:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E97A1656
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 06:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4C1DB375;
	Fri, 24 Jan 2025 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MxiKrEcs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07E1DB151;
	Fri, 24 Jan 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699426; cv=none; b=HJ0Nhk8mmPICzHcUflyRGDZqsS6jA4E98vhRyE6KS+hBZt+0sOX1494Q7+lajy7oGU2qjvQB8R4LHrxH5GMcZetvtM8wWiCNX0q+df5WUueBNgxhC9wX8EAzaXUsvVAPILwr2vy61sf8v6MDaloZfs6HmYdw0p8CUDneYCzufWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699426; c=relaxed/simple;
	bh=7yaGhJJCyAbgrLghMZiJldkDkbDw7QgWsxuzG0cFHMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lBmliHv+YIU40Hkc8ryMdCIndezi4C94wOvnHRV3klYu5jHcK97MQ38UmgZIz2Ggk7emBtMfYJ5P82Vuu9FxWH/tJ6pNph2yQhNwoX5pp3aKoUtpD49B84zYDH6G3+JJVvk8xTqUYeAcBFsylisw6Po3wb3rLAyyFDIZKxbfxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MxiKrEcs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O1KtL0021818;
	Fri, 24 Jan 2025 06:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V3xY83kehNGsuxhHE/Xn+Uq8fjFrhftnTVN2wtfbdRo=; b=MxiKrEcsop29Ja6L
	lpYQs7gFggsROi5vn1wO+pQpHgHPLGE9/sECdteDMJyF1NiGtVAWzflYCkBYsJ7S
	8R1jJqTf8hn4tISg2ju2djj//sWod3nAQD9cJ0fMBccVgvUCjgKs1dLFE+C32/aC
	OIFaEBgeQUPc6wGn+MLtDiwoNIip5Djk/W08LlxMqey3RYE15a9lhXS5aFOHbIkf
	7MUE3OOTsQInF5L27m2F4AIUU6porHTfNII4Y9N/OAiQfTZNwQOw972dyUEQlTOz
	EMS08z8osRMqphSsSG2r0S3NNgPdUxe0wH5LpZMUb0z0levdhwYZKNV5+RPriqc8
	Z0saGQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c147rhqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:17:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6H0F0030668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:17:00 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:16:58 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 24 Jan 2025 11:46:38 +0530
Subject: [PATCH v2 4/4] wifi: ath12k: prevent CSA counter to reach 0 and
 hit WARN_ON_ONCE
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250124-ath12k_mlo_csa-v2-4-420c42fcfecf@quicinc.com>
References: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
In-Reply-To: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5OIE8iG57mgZ8fCIJKYScaVlZly4emGj
X-Proofpoint-GUID: 5OIE8iG57mgZ8fCIJKYScaVlZly4emGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240043

Currently, when the driver receives a channel switch count WMI event from
the firmware with a count greater than 1, it calls
ieee80211_beacon_update_cntdwn(). If the beacon transmission fails, the
event will be received again with the previous count value. In this
scenario, the host decrements the mac80211 counter again, causing it to
move ahead of the firmware counter. Ultimately, when the firmware count
reaches 1, the mac80211 counter will reach zero, triggering a
WARN_ON_ONCE(). Therefore, there is a need to check the count value in the
event.

Hence to fix this, maintain the current ongoing counter in arvif. If the
count in the event does not match the expected value, silently discard the
event.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 86a1eeec64a6e173048fd92a53df6b1d2df153f2..50acdb3fc8cba95542a1220486799cfc207b496b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -299,6 +299,8 @@ struct ath12k_link_vif {
 	u8 link_id;
 	struct ath12k_vif *ahvif;
 	struct ath12k_rekey_data rekey_data;
+
+	u8 current_cntdown_counter;
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 35ebd54971a595ad5a07df09581f0ae9af38f27a..6406e6a19cb5bbb56f57fa4e87aa18e9c5f31732 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1935,6 +1935,7 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 		cmd->ext_csa_switch_count_offset =
 				cpu_to_le32(offs->cntdwn_counter_offs[1]);
 		cmd->csa_event_bitmap = cpu_to_le32(0xFFFFFFFF);
+		arvif->current_cntdown_counter = bcn->data[offs->cntdwn_counter_offs[0]];
 	}
 
 	cmd->buf_len = cpu_to_le32(bcn->len);
@@ -6916,10 +6917,22 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 			continue;
 
 		/* Finish CSA when counter reaches zero */
-		if (!current_switch_count)
+		if (!current_switch_count) {
 			ieee80211_csa_finish(ahvif->vif, arvif->link_id);
-		else if (current_switch_count > 1)
-			ieee80211_beacon_update_cntdwn(ahvif->vif, arvif->link_id);
+			arvif->current_cntdown_counter = 0;
+		} else if (current_switch_count > 1) {
+			/* If the count in event is not what we expect, don't update the
+			 * mac80211 count. Since during beacon Tx failure, count in the
+			 * firmware will not decrement and this event will come with the
+			 * previous count value again
+			 */
+			if (current_switch_count != arvif->current_cntdown_counter)
+				continue;
+
+			arvif->current_cntdown_counter =
+				ieee80211_beacon_update_cntdwn(ahvif->vif,
+							       arvif->link_id);
+		}
 	}
 	rcu_read_unlock();
 }

-- 
2.34.1


