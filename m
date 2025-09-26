Return-Path: <linux-wireless+bounces-27678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F4DBA5036
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 21:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B51D3B3245
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8B28467C;
	Fri, 26 Sep 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIyykafd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1427702D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916623; cv=none; b=Fz3wYn2lwxSoREtsWqB2oonQu+fJcaeqcfw5Xxms3CqoKTyqtupHb/+xLLGBgvHWVo7uSH/xwqcShkB1EpCwwWsJ9tUwUYcLnl4bPju0hVVmZy0q/13OFODkBCSsfL6CZg488zPgK4qHayNiTCephoos0zOxFuI3wSd9e6MZ1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916623; c=relaxed/simple;
	bh=bRI3KUDxtW8vM1O9LM4ryiF2rZuxwFt/y2w4nF62M8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ku2PiaFCCFE8a3xoBDKFPk09g3RAJrk5ogLbU7AqQgyCO6mttsrUsCx9BjmawyruzMnbEWawYek1j5TX3mVuPjisAZPiKrz2dVqiuGMN1LQ1UOmmgv4J8yV8L/Ve0+m489M3zi+qBIbHf5JUgIpx76QjA9u+UV0TMBwQJKziags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UIyykafd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEX75V007065
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 19:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oF6/FqFnA+LvMh0Xi6UAYyaPVLWmg7mGj23
	gafZNgV4=; b=UIyykafd/ghHs/xCc7dlQ4A2ORuHon7xzIXr21M6lR/2KYLC9Mx
	ORjYsnhP82LozbWsVtnuN1MiRKip0J42nL1HkG31Gk8V8ZB4HyE4iLgAbpM2O6o1
	q9T209BdI0k92o7U9z5oxEl2xjyQ4INMYK04aN4TqeWPvyabCAWX/OQd6zjtjZjg
	bKTgVTKeT7VD8KVq9j5rPoRl87sDc7mvU54WM5Lvnkk7kEy6ZQSjwAaaRbE+8L9T
	5IllQoUuD2KCJmzb4fdeJFKg/a/8BA/PPTIW9powIMvHyq6A9KBf0jmx6KIRvV7l
	21yyuHrDHTtLElbZICMyCTK3zgg70fThQWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qv0e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 19:57:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dd932741cfso25541631cf.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 12:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916619; x=1759521419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oF6/FqFnA+LvMh0Xi6UAYyaPVLWmg7mGj23gafZNgV4=;
        b=VfV5esX2PqiZn0FrMM9koYmjOFAnPmFslPdQh9EAfn4Xvpti2X+ZYlBlktexLWzKOr
         odFyyhFrsNCdqhf0OQeWy6E5w0DP8rWRRmcNyOgSLLVJJd63md6Zgn9AisZxo7Q/6WeP
         DBWLFpIuyBUzMnsKokH9ZpqlPXUzOhBmCePKVDq5trGJSJQI4M4Jj4bCHvKgpCt5b9+t
         AU29gPcKgi3b+IHeKoHu8Iht6mLIuHhBtM+YPUwuDt69SWB+/9ydnbpsbcXiUl2O9jPS
         7kI8DrsWJVVHvqYzr74lnhgYRpW6T5izdYnsgaIrHNqz1Ra9IXQHTYoTxEwL0Tqfp44U
         J64g==
X-Gm-Message-State: AOJu0YzVAxYKb9WuXR+kQPmBOuH5v5M7OUxT6TpaoX3gzQ1JCXlqSfQ/
	BmXgOd/6+rDTcY48Q0UIsTMJOgMVDW9S/EgEkaT79YBylSwDQ+w6z1CMxNxMx7AvFxvrpeH2+3m
	8o+pmR85+hCGxDR3JbjALnVAJiHMaVPUOq/jaOfqqUGUZnEJJbB0pxSqKBaOR3YqeRCoKYg==
X-Gm-Gg: ASbGncuE55kwBlz5UpfLpKPN0p+wHRDGPAbn8TgGx8E8zNOq10qHnYCR2HvmPJ3gcsU
	0ApRwObp14Pni+7bYd3Qgnx3ZebZXp35bQjj/pQAvcc/44O04Su4cAVZwZAPTjk1EmI5Dh37gxo
	8zTI4dq/JL/m8jj1SotfJm2WtcRtbHQHwEh65Amymj91dYBupNs7WTwOg0JdkE9pDW5xMSLUbVf
	nqbNmEFfRYCGm0VCsrJyj/dj4CLw0v1IxfBKSwDiSfKlHcWlruq/DJ9ID96mVtsgXs0WBpa/oWP
	D6Tnt22m7pLcRhdSE1O4HyRqxU0li+mvMOVSn5+KjMq+eBfaIKtpdct9mUzKAYweLp3srRGsbN1
	Y+ONJnhNRZRi7sxcZLv8+1vOLk/Xc
X-Received: by 2002:ac8:7457:0:b0:4dc:4828:b78c with SMTP id d75a77b69052e-4dc484744d3mr59518501cf.73.1758916619132;
        Fri, 26 Sep 2025 12:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSNykquIRQHBGWc2M2srDVaTuRZ7aHcegu767xBobD6L6W84t0GrQ0qqiIwqfUSBFlJ1gZiQ==
X-Received: by 2002:ac8:7457:0:b0:4dc:4828:b78c with SMTP id d75a77b69052e-4dc484744d3mr59518191cf.73.1758916618539;
        Fri, 26 Sep 2025 12:56:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:5de9:cd6:92fe:bfb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b367b79d1b2sm317114866b.10.2025.09.26.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:56:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org, kvalo@qca.qualcomm.com
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH ath-current v2] wifi: ath10k: Fix memory leak on unsupported WMI command
Date: Fri, 26 Sep 2025 21:56:56 +0200
Message-Id: <20250926195656.187970-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WPelh2kEDfPsHxGfh_tfok43nycg8hxq
X-Proofpoint-ORIG-GUID: WPelh2kEDfPsHxGfh_tfok43nycg8hxq
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d6f00c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=_ECdSzBM4LX7PmatiasA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX8SmrOZnD1RhL
 RnHI4dSH8XdKL4Dw6S9ojjZby3F5f/MSzjRyd6oemTwTHFUdR7Q4zoN5jpsBJDakKOHzJIKMX6G
 iDk1IrLRlvtDSOXTKTq026W0AXCDTV7Pplc3+hMeiAq0F3lO4ghNNrEUBQgKY0kbQdhm3K0lDUS
 Udc26uEbKmjRyJU5/+J+3DohdRl8Gng82F3DSkBsg9tE1fUAbg5cwpA1DdwSBRpjrDu7EhkbOQq
 c3dUI6Q/VJIbt34ctMah+8WEcYINitbE6csfuhIdpuJH7DIpK11aZfg24YCdV52IAY+u3veyXEC
 Tv6tLhSHXcQPt9IV79z8c2AE0aMUuom/qb0sTec7FfUU/kw8mqh+MgX/skN30SFfXpJCzzKcgNp
 lU0SvxfviurlMnVOJWTOufzmByvHRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

ath10k_wmi_cmd_send takes ownership of the passed buffer (skb) and has the
responsibility to release it in case of error. This patch fixes missing
free in case of early error due to unhandled WMI command ID.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1

Fixes: 553215592f14 ("ath10k: warn if give WMI command is not supported")
Suggested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 v2: Fix typo in commit message (s/responsabily/responsibility)

 drivers/net/wireless/ath/ath10k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index cb8ae751eb31..b4aad6604d6d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1938,6 +1938,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	if (cmd_id == WMI_CMD_UNSUPPORTED) {
 		ath10k_warn(ar, "wmi command %d is not supported by firmware\n",
 			    cmd_id);
+		dev_kfree_skb_any(skb);
 		return ret;
 	}
 
-- 
2.34.1


