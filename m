Return-Path: <linux-wireless+bounces-15511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBC9D2AAB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B76B374C4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341181D0E18;
	Tue, 19 Nov 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TJoX1ZPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BF1D0DC9;
	Tue, 19 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031278; cv=none; b=QQA+14ZNiQBv4PS5ASc04HBtQschc8mI3lmNBOTJu3xdNbIsGeSwC8HjvvQGM6NTixxI6xhyxmyaLOXUil4a8+lo2QkJkbBiaz2Cb0LVZyNpY8iIyBaDpHWYC474d7l8eRQ/fmpnCn0Djiy2+sH3UStZOjT4E9XPoHmd9EiqtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031278; c=relaxed/simple;
	bh=DGl/gJjPpBm9CT7fgRU2o+1qYAL1Nznv+5BYXHQlYTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cyuuYXrJkHfbFTSoaQbkruE31xOe6Pt1kniVVyIAWEf1NF18heY6Xya0JX/T5Kz/lt1aOjuEEV/pvoCCyJzQBT8E3X5YUU+AwHG3erN90/3bEzbT3MSkwiHkk+4ov+u8bENgsj6otTyl0r6HWwBm0sN4c122H26Sp1GQqcbYMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TJoX1ZPW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7hvBX006081;
	Tue, 19 Nov 2024 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AcYOEB0NFhdQWlr9OmvFY1dYwwPZ7UBBM5ddUWgGHqs=; b=TJoX1ZPW6k4XoV8w
	tLRKf6JySVmdaYZ8D9jkZOywhrIGurv1mMvZBGrRxwWVmf00ZQE5RH6TT2S9/Prb
	PzcQ2PVYMJGTaQdkmpBtGG8jtJeGGUZQoDDRGtkQh/1rHIx+IPrwxLKaYhc+rV8D
	ieIrB4V7NBGBWCrBUg3wcjQ0/NwuhLRT2UG2GT0pI4nOSGgyJldk62D7Up+TjNkZ
	u0zN/HWNPPXRQVIfb3qLrgXToRy34uX0mTYwKB/i9lxTCmx/JSZ1qm/m5naPWDfj
	Bx94sfith/6fRK+skqiYqzXsda2D4HBpzjiNJsza1x+gykD2r+40T89i8dM+BYtw
	JPkfgw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y8k013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJFljuh016796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:45 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 07:47:45 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 19 Nov 2024 07:47:40 -0800
Subject: [PATCH 3/3] wifi: ath11k: mark ath11k_wow_convert_8023_to_80211()
 as noinline
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241119-ath11k-noinline-v1-3-4ec0a8aa30b2@quicinc.com>
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
In-Reply-To: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Nathan
 Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9NdK69iXssGbEhH_il1RCRipLQvEdYIz
X-Proofpoint-GUID: 9NdK69iXssGbEhH_il1RCRipLQvEdYIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=979 lowpriorityscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190117

When compiling the ath11k driver using clang with KASAN enabled, the
following warning is observed:

drivers/net/wireless/ath/ath11k/wow.c:672:5: warning: stack frame size (1336) exceeds limit (1024) in 'ath11k_wow_op_suspend' [-Wframe-larger-than]

This is similar to the issue found in ath12k/qmi.c that was discussed
in [1] and fixed with [2]. The issue is that clang inlining can
explode stack usage.

ath11k_wow_op_suspend() itself is a pretty lightweight function, but
it dispatches to several other functions which do the real work. One
path in particular is:

ath11k_wow_op_suspend()
	ath11k_wow_set_wakeups()
		ath11k_vif_wow_set_wakeups()
			ath11k_wow_convert_8023_to_80211()

Of these, ath11k_wow_convert_8023_to_80211() has non-trivial stack
usage, so mark it as 'noinline_for_stack' to prevent it from being
inlined in ath11k_wow_op_suspend(), thereby eliminating the excessive
stack usage.

Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
Link: https://patch.msgid.link/20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com # [2]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 827085a926b2..b6f08755129f 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -148,8 +148,10 @@ static int ath11k_wow_cleanup(struct ath11k *ar)
  * 802.11: |4B|dest mac(6B)| 6B |src mac(6B)|  8B  |type(2B)|  body...  |
  *         +--+------------+----+-----------+---------------+-----------+
  */
-static void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
-					     const struct cfg80211_pkt_pattern *old)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
+				      const struct cfg80211_pkt_pattern *old)
 {
 	u8 hdr_8023_pattern[ETH_HLEN] = {};
 	u8 hdr_8023_bit_mask[ETH_HLEN] = {};

-- 
2.42.0


