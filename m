Return-Path: <linux-wireless+bounces-27798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CEBB65B4
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1166F4E3925
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B123313E;
	Fri,  3 Oct 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvfZLa39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A918A6B0
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483340; cv=none; b=S/JmuOYCPjEB8HkEN9/whHe8XuMjFAZFiGjp/mJHHsvZpm86hlqrInBy8ZGmYpmQcxF/1t3z0hWOyL5lSH+gJS454YU+XkeI9fDEmsv7AIc1UikTgDwcsf78ajxyILjJMplfzGAUI2638cAxZYiHqcwlKUYPF2eCLeudbxUyCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483340; c=relaxed/simple;
	bh=AH/nHz+1MIH99fdQBqny72jjNxvvyMZ253OUMipFMbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O1wSyVeaHKTmhdXwBt6Fen0c+ZlwKPARPv3HODScmeyXA2xZeI82kOsRrSMUL5lCGOkK/V2yJ+DRoH3DDLAe2oC3icLR+rXqBocWKAv4hE/Vx3t2BPe0ai95NfbGcfpMh2PXMiQjc0f6OsN4kv/jgadoxVDz/n3C1bVAg3jW9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvfZLa39; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Lg5Jt031548
	for <linux-wireless@vger.kernel.org>; Fri, 3 Oct 2025 09:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eAemtbgiKnGZ8kMpTp3zhWsl1b5CeySwvky
	0wCZURIk=; b=ZvfZLa39vF/bJpbWqfXHX53h6ceW5hT9L6NWVt69/CoellsPpKb
	C6Fsq8boezKZ2nzJu0d/nYyf5MHS5Yqh4V7AubziwGPl6HoTyb7TQhWuk51YZNJh
	eW4Kp6nIuePqWXbG7zE4SX21Exfj3WQKR2fDBuvRxtdSrjBhwWT60ENwymZ+2los
	fa5iZNTe8XV8uy+eSwgp3D63iHYepOfj+ZyXdCA7tm4IXFf3AWxI6y+yXnP5UzcS
	csfzgB8+BxXSqD/BCwwVxT82NOQymoUp2LiKnXKYa6wpWZwhFDBvyh6dJ30IT3Ah
	hC8zlCvjT2wcelXlqnyl/+0XEB0Y29TOHEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vracd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 09:22:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-332560b7171so2812340a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483337; x=1760088137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAemtbgiKnGZ8kMpTp3zhWsl1b5CeySwvky0wCZURIk=;
        b=Oepoh+kTPzNv8JuNSmfv9GeeIaspHHXAFAXeh7EfInilvo2d9Om5FceyYubEV4G7Wx
         R1ZIYp0e8Zdq8M6k09pm9/aUzCvXgKMRPWGq+0VUGYSD5OTVXmkKqnqP5wIJ/WB9b/e1
         QKVoX6i9vPVEBqoLsNOsf+U61AVs9soSW+e27l448dXW//7f4EJ/gzG3IZn3ZFLwdX8Q
         vX7ecobkZB0LakxH3/897iXsbbI/IwU+TXyAEnsI1RnbWzTna9Me0VYjUXISNk2kEbFw
         M+uVovZy4wk2e1f+y1BnGONca2iux4xyRop4GSmOOkMEXZfaj1up6TNFhkEFcvdcv23Q
         dnaA==
X-Gm-Message-State: AOJu0YyN6vziWQAfiES/E6A4IsCjh6N7Zq7HTZXEHppL7kTeAI4BfpNu
	2jt7XsNISHhy8tUG2NDohXWg+xI1Kxv1ewuhcSHXmenQtdo6Iyg/ArSFfNxTdzKY30JJ1jSoOGZ
	Nsh7o8ucRHwYV8oA2iEOhrY6hKR9bL2lWDyrOuJrKCa5SMiUwRYQwmuYVDZgVrjZsm6pzEJ7MtW
	Erxg==
X-Gm-Gg: ASbGnctbz6LG4vWc6mSv2ywTyHnSFrFDx5tW4WFzbkobL/Aa3RSsRswqkNuzQtIkbuq
	A/zFdIWTA6GS/ZT5fwIjjQ7j8Ylux1vOBLJSMCqXfB/pjvPlKn0/ESvjQRTDI4hO+v5qX7PGAhk
	y/OTUs1oibcFnq/RtMXUGIGBovGhde1CCBgIw88aJUroo9IcFpRNBlYEWfhDHb4uZ/LxCRz9kz6
	8zbw0AmkMS/4Ic1FOqk+LOATD+wWnfpXiiSe4ken2s/1a0FdclxhsCpzMwZ0Qj/EhTqebK7y0Iw
	OOFk5+f0M4NNXryfhA6IOs1rSOoaMXJItNsAOpSIyV5e30Fggk43MlihH5MhbfBxcFt7gwuklte
	U//KE3bsPfRXN/rbmOsX2p9jRmTJ/fhjeX0u9hU+jnYWM83Dth/DyGN/UG8vJL7Hiyyz+FS3Y5A
	==
X-Received: by 2002:a17:90b:53c8:b0:335:29a7:70c9 with SMTP id 98e67ed59e1d1-339b5103bbemr7557120a91.15.1759483336437;
        Fri, 03 Oct 2025 02:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE++fOzCHYyl3Hq3nGoJf/XYgJr8ljpAJ/rqIW893Q954dGzczcWn5dM8qIOHAliUi13gB3Qw==
X-Received: by 2002:a17:90b:53c8:b0:335:29a7:70c9 with SMTP id 98e67ed59e1d1-339b5103bbemr7557095a91.15.1759483335912;
        Fri, 03 Oct 2025 02:22:15 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701bf31sm7443042a91.19.2025.10.03.02.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:22:15 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH ath-current] wifi: ath11k: avoid bit operation on key flags
Date: Fri,  3 Oct 2025 14:51:58 +0530
Message-Id: <20251003092158.1080637-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GTj2lJoWPtgIL9NvzZk_Vp1K4TyIjwt7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX9noDnSQb3Bni
 gz0IQq5HBMtHZ7GFvCXVDkChjCMplLfhcP285AyooD1WQUFZW2pEyJoIV8ijz8sWWj+Cy0o4RM7
 atySshdeFSDQSIykBkE8CuHQHWJQu+TcZXCQ6U/QuM0vfjIJtkiRe5AreD8q/BovKOBcpqgFPry
 jIIgwCjPMFvdi3UvobT27krmloekrtraPMbAp2Wx10a7r88eHh2xPRA6+6FAgcXCMMI+aMb4g9w
 AvH6iv5cmfU93mb5TlNa1/lFAA9mcuesTvqrphE4KC44ZRckbh4+1NaP/b7rZ+adLC/pCuAnAC6
 7HEnTcibrOnX8DK12XVhbUmz0QsOvU5uLfGOI+DC4HZjMkZtlUw2by6V/Q/tBlzG/5w1LpqrPwu
 a1Dm1NNBupxg++GIWP+3DwWa2jJkjQ==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68df95c9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=oTA4yqJY_0P6YRJvVYcA:9 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GTj2lJoWPtgIL9NvzZk_Vp1K4TyIjwt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

Bitwise operations with WMI_KEY_PAIRWISE (defined as 0) are ineffective
and misleading. This results in pairwise key validations added in
commit 97acb0259cc9 ("wifi: ath11k: fix group data packet drops
during rekey") to always evaluate false and clear key commands for
pairwise keys are not honored.

Since firmware supports overwriting the new key without explicitly
clearing the previous one, there is no visible impact currently.
However, to restore consistency with the previous behavior and improve
clarity, replace bitwise operations with direct assignments and
comparisons for key flags.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/aLlaetkalDvWcB7b@stanley.mountain
Fixes: 97acb0259cc9 ("wifi: ath11k: fix group data packet drops during rekey")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 106e2530b64e..b022e1403c0a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4417,9 +4417,9 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
-		flags |= WMI_KEY_PAIRWISE;
+		flags = WMI_KEY_PAIRWISE;
 	else
-		flags |= WMI_KEY_GROUP;
+		flags = WMI_KEY_GROUP;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
 		   "%s for peer %pM on vdev %d flags 0x%X, type = %d, num_sta %d\n",
@@ -4456,7 +4456,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	is_ap_with_no_sta = (vif->type == NL80211_IFTYPE_AP &&
 			     !arvif->num_stations);
-	if ((flags & WMI_KEY_PAIRWISE) || cmd == SET_KEY || is_ap_with_no_sta) {
+	if (flags == WMI_KEY_PAIRWISE || cmd == SET_KEY || is_ap_with_no_sta) {
 		ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
 		if (ret) {
 			ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);
@@ -4470,7 +4470,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			goto exit;
 		}
 
-		if ((flags & WMI_KEY_GROUP) && cmd == SET_KEY && is_ap_with_no_sta)
+		if (flags == WMI_KEY_GROUP && cmd == SET_KEY && is_ap_with_no_sta)
 			arvif->reinstall_group_keys = true;
 	}
 

base-commit: 58a0a7a45feaf4538841afe8e251737bf7c56607
-- 
2.34.1


