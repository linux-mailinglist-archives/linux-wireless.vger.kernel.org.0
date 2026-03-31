Return-Path: <linux-wireless+bounces-34203-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHVaCI9Uy2moGQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34203-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 06:58:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAE363F43
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 06:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F35AA300D4E7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 04:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D2363C6F;
	Tue, 31 Mar 2026 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHcBOVFD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="La0RAbTb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0DB363C4E
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933129; cv=none; b=DwgW8yAqE87S0YBZep/0eo75zZLu+XGXYuYGJKrVyr1K2cWSbk5ACvvqAICJb5OiOROog9+W+IT3r7noIyPNumvu7/N8qZuoKdKwbSIL22M5TmevliI6+L2yAqdRh/IS6IawwMLN77eTLuSlAj0Sz8y0OdW9CpMNs2geTv2eu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933129; c=relaxed/simple;
	bh=RJZTCLNcBEnuYy4/OJXZxuIembGdLXbW/b1fSYgFmTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXYQ8q/aHwn4o4Fuq+vFF4fbVd5DkkiYxRMrudcmsFbIGIlQMUmah5k7juEwYQiWL+fvI0HzL7foSoQQmq+eaKg/EnkpuZAV/w/s9ekOe1Z8O0UgEjhtQn/H8fiPAsBO1iHk/WbK1YMFs00l6dcnlPUvwGOwMCczSCcSqCbpUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WHcBOVFD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=La0RAbTb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4VQxi4054054
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 04:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jRrcy+J6cPpHqZ3Vyyipw5B80AzMdJH3CJV
	ClohJ1z0=; b=WHcBOVFDtwVVTfH8uvblUxUD9jW95iyqTsDjFJYPPThRuQpBiz3
	cBehW6FJw0xZlBVwZMAfRTt3MN5qhHGQew6ZwVyhOmMt5t+EdehbLob6c7RloJq8
	hgvX79GeV1rr5EPaBDUVm8vkSkzbqmfcGmGVBJFsivdkqdcphYrzfrxcMI8/oqju
	q8oHn81sv/FpV+J/WV+AOGfNYNIkGOiGHy25ArviwvfTH9vnEsvNuZL9umeH6NHo
	RtrDwOZPWB1FJoD7rRsbfnu+yvJdwDV+mEuKjaQszzocI36RXgV8bTHVltZydiGr
	+rcDepP6XvQ0P4wE74rIQTNWOd76g7BzWAA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx39qr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 04:58:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-829b7ed8964so4871678b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774933127; x=1775537927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jRrcy+J6cPpHqZ3Vyyipw5B80AzMdJH3CJVClohJ1z0=;
        b=La0RAbTbR2D0rXcW2K8CoBuMCOUQyn+sk19V847/O7ZLzoJZo5CjKkFhKbMcx4Rp3w
         STvjM+u6B1Hyvpl91ZpilsXwMjIzxbvZ8abIYxDSk1SOnz/vr1nf/T+5pquEsqV0BYNX
         blq4Oh3K0GPODRAzyhD5WX8Z5uxd7pXa9FvwesNtf/2UU+IdD0E4QiML0TEn/f4+//TT
         TnWE/7UJStV7w/ZG2hHNFH6ZYkXmA4fpg/Uvp4jLHcin0L0UDojdj2ydoEUyvO5NV0mP
         9PeYMcabiK4pgoUKnrbYV5rYU35svPSGs5+wxH+4dK+Hbs+DEQfwTfsTg6Qkq5l0SGL6
         somA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933127; x=1775537927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRrcy+J6cPpHqZ3Vyyipw5B80AzMdJH3CJVClohJ1z0=;
        b=igp7G38M/L0D52VufBaEAsJotId2PCUSBHnWJko6UDClZXcw1otOsWBY9NfZ5yZ6BQ
         eO7qU4JaGeOq4hvCvhoxO5/2k8Zj9vPdtzVXqm8PNGmCeEsjdhOaJPDS/DPpXmbKDBit
         EoDVsbzGmQvtVJBcdPNIAHt9NO58iie1E2DU1nNn1AiLNorQ9YW3p8d7YJWJpRrSYIEA
         78Mye8amFrjNMnueIbejisXwXC+uSFhdFxiuxhyPLWqAkN/UrSV6ZGsjpoAhRbhaRZUl
         ppFWgRj+CG+hAZjbMietyer1Z8/61UJHD+0oxJvt5pbioCfprlEtQ+uyG1Kkq7T5UwvA
         awoA==
X-Gm-Message-State: AOJu0YzPQ0Wqx3sTSljKz8CZsdlTG+kRKXH25aEMr41GwkCBNw6tqaoO
	eteAG2UgEsdOslCz8pZwAI2rKufZPJfIAE8NyLIut+mZ+bsizq7fXc31yOUj8gUYRIJY8yOxEJv
	j/49AB1C49Yw+sRObE9XadFI+3NHUyF2JveyeE/oLNSAWckbx0TTigkQL1QN/GkFunNRVSw==
X-Gm-Gg: ATEYQzwi+eWMmsvicqEBF26d4Xke6t5U9a5qOqflJgDNUBb3gd7CQCP+TnqbDPlXHlA
	1WV4if/wWzvNXpUhoLo2JOjieRyL3ArmaXXoESkHm1Ue0mhCQMmiRiJ6HNW6AXBm0fAwhjqGO5q
	5IHEx8s70/8ZyF77DHuJXTVI2/sD8Z1BTWjPqMWHW0NpZeNgj22045WB+wJQ1eVhx815ZMKMZgJ
	7kPKq/ZkXuEeb9VNYpWxjwUd1RNpGdpOZya0oGB2A2ZTrLdTInFH/GA3FTgVTqn2bpTkm+7KLM9
	seyNx3+8C3CQv07IBdr/Q9MEFKDn2X8Gn+97uDWJYuAF+rErT+94xqqPX5xRBgiAMSqzXKDYgPo
	isIFjmjeLV0+DLtWn8nRBv8OdKO7uRseAueWuJT+1zUfPluIEJGBMrR2sON6TGvqJzOwabTqkQ0
	Yb+0Bt1zVp48Ue1jBt83KL01sIJe5S2EuvWlvhL8ecqoGzlvIM
X-Received: by 2002:a05:6a00:94ed:b0:82c:24a6:2e41 with SMTP id d2e1a72fcca58-82c95eba78emr15039966b3a.21.1774933127086;
        Mon, 30 Mar 2026 21:58:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:94ed:b0:82c:24a6:2e41 with SMTP id d2e1a72fcca58-82c95eba78emr15039941b3a.21.1774933126501;
        Mon, 30 Mar 2026 21:58:46 -0700 (PDT)
Received: from hu-rdevanat-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8625269sm10437635b3a.53.2026.03.30.21.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 21:58:46 -0700 (PDT)
From: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Rename hw_link_id to radio_idx in ath12k_ah_to_ar()
Date: Tue, 31 Mar 2026 10:28:34 +0530
Message-Id: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cb5487 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=s4PFe5N8Pvec04coFb0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: bxCZ8fSEMagOr6KWh3rMofndNw3JDowU
X-Proofpoint-GUID: bxCZ8fSEMagOr6KWh3rMofndNw3JDowU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0NSBTYWx0ZWRfX3sTfEr+fmBXD
 dm0M5n+ZpILTN+HY/vbqGWQcs8rbFEetPsi/M5RSelZHk/02Zez1/SuAXqQI0dL83L+KEAApE5G
 NCcDpKftZnZDyQazkZWQKyxBX7iais7AOGA+JsHi42IeNRTi7HKGqD1C3FKHR93ogUB2JUmGWH+
 q4FrwfYDMAlBA9UOtxDKW5LlsYBjPT9UpcAfXnpEWUFn0jheAq1WzEbG5MkAj6SOgTdWsQd52Fm
 psK9BAXz5g5jMs2TzDl4/Tp1hXRi+c6b2elpS3HPs1OelbMr86mlmZIg1aanlhqCovzDJF8SsV/
 dQxy0WwSVef+vDKS3fNZlz+evoBGiT2p/h0ew7iwkuScUc6wyW5EKQTnDFJbcv+xaDwfhEUfS/p
 twHGCluFFCMrP/VlsKd007xE+nH3C7x7X0P74+Pud/PNFg9uY4av/cpMFAIDXhdYF5EH2kcps2y
 6NWSySCplEGlWER4Y/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310045
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34203-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roopni.devanathan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1BCAE363F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ath12k_ah_to_ar() is returning radio from the given hardware based on the
radio index passed. But, the variable that radio index is received at is
wrongly named 'hw_link_id', which points to the hardware link index that
comes from the firmware. This affects readability.

Resolve this by renaming 'hw_link_id' to 'radio_idx'.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..5eff86827e9c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1366,13 +1366,13 @@ static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
 	return hw->priv;
 }
 
-static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 hw_link_id)
+static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 radio_idx)
 {
-	if (WARN(hw_link_id >= ah->num_radio,
-		 "bad hw link id %d, so switch to default link\n", hw_link_id))
-		hw_link_id = 0;
+	if (WARN(radio_idx >= ah->num_radio,
+		 "bad radio index %d, use default radio\n", radio_idx))
+		radio_idx = 0;
 
-	return &ah->radio[hw_link_id];
+	return &ah->radio[radio_idx];
 }
 
 static inline struct ath12k_hw *ath12k_ar_to_ah(struct ath12k *ar)

base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
-- 
2.43.0


