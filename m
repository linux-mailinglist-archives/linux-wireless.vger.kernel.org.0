Return-Path: <linux-wireless+bounces-23238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C2ABFBD7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E45A208F7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65E25EFB8;
	Wed, 21 May 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5E5m+hw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848027AC43
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846783; cv=none; b=sqD8FJ1kHn03jfvidygR801u4LG/EFSMDD7za6sDbNIXA9+twqbABwiV+ayNsuGfBIYRRmxzauW3DzHCEW1XJwOTCCD96WJFY1crLPawc4XNiPE7WBprRnxE3qt9USLcJ+uFLpjMohPlPHZzO7VkHhc1OP4xdOMGjbPf5soOTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846783; c=relaxed/simple;
	bh=a22Xg679k47dJlTeZgzeacgRfyEdxBCUNrxpYMuHuYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKU2yNUtnb+cPc93kMTCW0qy41kiwRfzR7Wj0thrH88mvkuIrz1Y+VF0xjnoNHRTnCAR9IoO7LB3NNYZFdYm8iFirYV2Q7+X+hH4de8B4eH0r/BF1m0m1qe6Gy1KW8A882tZNLqk1iFsl33A5M525a+sfxJJ35iJlKpYfrhb/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5E5m+hw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XOu4031739
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9N7o8Gtv5VKo7HD4i4yWeR4Voh2e4WFUyOnmq4cK5Mg=; b=U5E5m+hwpB0BYvuy
	/RGutLbzB2Mkhg+HM8NieZCdUzAhRoxukoR0MkRILP8sWVxk1wkgensqHYZfAhRP
	5FMB0g4GGFbydQBgjdOTeoq+R+v3PFaRyBz6dpskMJM7APmX2DL73eR+ghQY8UQ2
	1kGWvf3L2nuuO5WuOa/7L5q1oYk93zPDFe+oIU7pAWHwOPdfLmkGjXld1sdg4muY
	IMCxTL/w5DgL/Y/x+tRmouuCK+6FAIvSd/U+PZ8S12K8/J6wzB5cfFwQoDqVNWQc
	Bm0tdhDE4Iy4Nr+QIs2FvsuONBDXCv42N3R25AjyK6CKvjDWPYbgVTk3sXgL9z7+
	SC5New==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c22778-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:59:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30ebf91d150so5300962a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846780; x=1748451580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N7o8Gtv5VKo7HD4i4yWeR4Voh2e4WFUyOnmq4cK5Mg=;
        b=eoueHxjkvmV2z0Hm0fTuBc6WHlMPoBeOvzEg+k6xATMHSiXcf/4qaS/37byRlAAyjJ
         PVeHftwuywaDN1el9Zbpu41qmqGO0GhhTW3HSxotvWsMspywXvU8QRSsFFxeoyu6yFUc
         yGzScM5eTgiOzT2XueHUigGKUZmZG8eTGvmppWW2oASnFtl3Hin98ESjLg+4AuS9gn9H
         3eO0C1w7Z7QnrWr6m1loUMQeemMIeUCTGNqRm39VB5bI+tNEF788UZTrgBIZCXbjjw88
         qohA75mqLMW1yz/BC8KG/ggnFU9dk++ElN61O+VulB1X61BLf63iPmtnEQYGygQsqhdC
         0Bww==
X-Forwarded-Encrypted: i=1; AJvYcCWuvvNJOAPxKAQdzuECjV7WW9Zg5+yX8cukdjkbbPf+P3mN9Ej0sVNvytymoO0HQxdLVxB24J4Q2msGl7N7xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4KzoKtkGq3YNrmmhc5Mc+lagLgg4cMYC1MquFO65RJlbEy08
	wt6MrMsXNjVWWUDc/FcE7SvwkbDM6vEnRI6ybFPG36EyOVwgNC+XTCcuDud0kVJKylGe+e15Axk
	FQ3yZtcirobY37J6CiFoW4YI0viZrwfD7O7l5zhQn3R0TyTqVLU+mwyTSx34JAjp9PzKZDg==
X-Gm-Gg: ASbGncseYNhmN3EN7G7Bw9z+6cNbztxiUvc7tJwRTymnHM5upnl9LxoogOsXdlyBL1r
	+gaZK/WMx1FIHGSLMIp2YZI5esJrWZWISNDvCrIDkrS4tobBBV1v7339e/ip+vf02Dzk3GnJMxy
	1lFjakIUWpbwMVhVC0rxIEfc9btO4xrGpJm0aMlDg6Jtvql9gRwfstARGJfpMVJgdvDHBo/zd6G
	uO9QyeFkhvKw/q8ej9dA0kAHbGyF/ILDtAAUiK8j6xwq92CEwuArPYMS5FrFCgf0+W3abnrtAtI
	nBkYU2Kycta4nNf4kEkCyt9dJfrCqBvjy1KbcBkYbrKye/mPOEAaOTHXF+rv+wghGI/+ErFqaRV
	t82HLCYtuq4XhMQAVugND86LqEkAsheR2pUNP
X-Received: by 2002:a17:90b:574c:b0:30e:37be:698d with SMTP id 98e67ed59e1d1-30e7d5bb328mr29656797a91.31.1747846780547;
        Wed, 21 May 2025 09:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZc+dVjzwwaVBTS3Tt9uMHWT6AEG+rnU+TbXB/vJXuImTmE61jp67BAaSi5VwpwBCimgRn6Q==
X-Received: by 2002:a17:90b:574c:b0:30e:37be:698d with SMTP id 98e67ed59e1d1-30e7d5bb328mr29656776a91.31.1747846780054;
        Wed, 21 May 2025 09:59:40 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365c4ee3sm3875055a91.18.2025.05.21.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:59:39 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 21 May 2025 22:29:29 +0530
Subject: [PATCH ath-next 1/3] wifi: ath12k: fix regdomain update failure
 after 11D scan completes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-ath12k-fix-ah-regd_updated-v1-1-9737de5bf98e@oss.qualcomm.com>
References: <20250521-ath12k-fix-ah-regd_updated-v1-0-9737de5bf98e@oss.qualcomm.com>
In-Reply-To: <20250521-ath12k-fix-ah-regd_updated-v1-0-9737de5bf98e@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kang Yang <quic_kangyang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2NyBTYWx0ZWRfXwYqFuovHu9Vc
 Va2G5I93wtG7J9tIaILQ6aQJqK/m2SpzobhpI7asW31RZWf+Y720tCV1IqOVA4gsdqHPYphN4gt
 aNXrrws6yCcbFGnXnPjKeEM6n3BpSsX68OaNGeZQJfjyO2O+hjjjBxiqK8oL579CjNdj8+oLJPm
 fHIvlurHF3b7ICxn4iUsaCB3hhTIT9Q6KnrO5paf+wqIviL4cQu+zwuj+cToIumG8NaYlfWJEr/
 AwiAPF7srIZt/VKc8a114SK5EwKBpFFTVy9GpDdoWPZ2EUYdqc1UtTcMj9+8HCXQHQVbBJnGso0
 Hx6+bQXmabs06GPqBpQPerJ4iWhl4/l957cQLsr2oc6MJELmz8vOyjc1Q6lDSnFVodaEQOGbdoR
 YBZOnOdIaIfjQG8wm8yoQZWKhWqt/hf7ituLvu4aChpVVT13fotm4UqORNPv2vF1sTig+GNf
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682e067d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KP9DAE7PHRlDfdeWwEUA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: P4EvQk7314BfSCfqKiqpzedD9KfCmiFR
X-Proofpoint-GUID: P4EvQk7314BfSCfqKiqpzedD9KfCmiFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210167

From: Baochen Qiang <quic_bqiang@quicinc.com>

In the current implementation of ath12k_regd_update(), the ah->regd_updated
flag is used to ensure that the regulatory domain is updated only once per
radio. During MAC registration, this function is called to push the default
regulatory domain to cfg80211. At that point, the hardware state is not on
and hence ah->regd_updated remains false.

However, after commit 4c546023d71a ("wifi: ath12k: update regulatory rules
when interface added"), ath12k_reg_handle_chan_list() is invoked when an
interface is added, which in turn calls ath12k_regd_update(). By this time,
hardware state is on and consecutively ah->regd_updated becomes true.

Later, when the 11D scan completes and a new regulatory domain is received
from the firmware, the host attempts to update cfg80211 again via
ath12k_regd_update(). But since ah->regd_updated is already true, the
update is skipped.

From the user's perspective, this results in a failure to connect to 6 GHz
APs, as the default regulatory domain (the only one pushed to cfg80211)
does not include 6 GHz support.

To resolve this, reset the ah->regd_updated flag when handling the 11D
regulatory domain update.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: 591de41d7008 ("wifi: ath12k: add 11d scan offload support")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 72e7730c7694bc7a5fdcf007fee1310bf67b5654..60e2444fe08cefa39ae218d07eb9736d2a0c982b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6125,6 +6125,7 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 		ar->state_11d = ATH12K_11D_IDLE;
+		ar->ah->regd_updated = false;
 		complete(&ar->completed_11d_scan);
 	}
 

-- 
2.34.1


