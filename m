Return-Path: <linux-wireless+bounces-30700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F62DD12691
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FB453009D4F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE383557FF;
	Mon, 12 Jan 2026 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NuUZWtFA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JHOkmkKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F73570DE
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218924; cv=none; b=CdvYDgxY62h+PVA6q6vRu4yRhHFb98zfOcBsUSdE2pabRGUXq1bVc/2vJgLDR7Jh147WOr10nUI9QodUkmfifWDvXj/GcRPKSPJ8BsLnivKk6pAINH8X3H2y5TWI9GSVzm82O373exGjs9yR0isKZWRjPcg2K9KeN/q/jAQLEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218924; c=relaxed/simple;
	bh=kUI69eF0mo9UF1F1hxOzGS47FKe7RiPQ0J39f68XvhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cc8k4J9RKJM2BF92BjOYk3KtBpSt4aAUt9cdC9FMlCQo81oZjPFo8ojRUfUC2oqtkcVaEXpS8HHskgkByQxJt7S/eDa2Z8oTkF3mWgmM/da1kUezSkQqLZrvHxZ+X3WZqmYJCQA80K3Dcw5Tk+yCR0ky/QUc20wk1F9arTaW1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NuUZWtFA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JHOkmkKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C8sIfH676410
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 11:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QiTlYrCp+242s9QM5OzpPgWjVIOQu2yqgsp
	IWqzWL0c=; b=NuUZWtFAy2ilccT4634Cla+3VKwhLoEVbGT5266bGlTAkMdSnsz
	OS4+2+IiY7wZilRDzq9prWDCHJTqKFNVU3eo7ok6RFGujfJxCq7uCBRDyctw4zqs
	A4C7pCWO3GawlFEqDWA1aX4Du3TNUiQnkDex5w12uF/ywMPUcADVYoe/IWtKPu7H
	eiXbh5D0r8G4S0ttxDNm2tYVSM6D8qqc2yftbtJmkU87GaVplScVTnygkHbl+P/1
	4RMfshmafXz3d8ztwhdPnXvGm+Bj3PFYUIwZnZ08/+Cihkv6bWMDbQu0RbSVCkff
	gHYxv1AHDaTy0GiaM2PY2yldefyCC3f/0cg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmwur8h5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 11:55:20 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1219f27037fso29850183c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768218920; x=1768823720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiTlYrCp+242s9QM5OzpPgWjVIOQu2yqgspIWqzWL0c=;
        b=JHOkmkKNEaM/Cej0V0CuesKUPLCDmGiRAN096BzwSnIV7u+IjGCnm5mt/iZHdRbTer
         3YugqAEXkCp+/YEubaLrbPolam7NK5KxYZrEd0iYyFfaxgkZNOATmrHfx/V66/reSwds
         afsyZVwujeoRJo6vIWHjZZHa1W9V/j1O5Hp2+BblsQbU//Iqz1yTPWf2gtI6ZBCwYQwQ
         0rV2W/cP90TOgZ7uWIWdQMDof6mdunG60pcpqhe2XCWZSUhkdPW7BVgAm3jdDIIyY5lF
         TwEwK1TgPvrOSSEGp6YExHxjdLoQfFH/eBZRmpStGWTGPfZwNSEBulJKWubNOGIhbGrq
         szbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768218920; x=1768823720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiTlYrCp+242s9QM5OzpPgWjVIOQu2yqgspIWqzWL0c=;
        b=VPfbEeu13akelGGCd1SynAMz8c2es8m4pGgHMZwc9K0tyLQyAcrQaqLdA/MS+D/8lg
         v6MPVeXL5vgxgej9j/7r6uor3+5Rkv6JDScm2Yl9SWwupdDNQQkGYn0C3JVaTzxFHRQW
         lfCDbvw7UM4YW2mYbpsxMw20IX73ZUIXmjHHd/9z97fxcayWCeZCEHJG6zfqBVdgnAXp
         9763YBi39ORZD+B5s0qECDr4yLK8yQ1l79wnBtDMHX1gVwQHmEmFXzQn0GOAkirDf9To
         JxJPFJUqnh3X36X3utLrEvPUqthfkaiLZWcz/t19KgIXqRYX/XWUOZw0fjvHTd0WiAk0
         CXNg==
X-Gm-Message-State: AOJu0YxgjegBK9qHRd5q+ltbbFBMdzuFidgg8KaT3OA4oDHF7Nzi2Er5
	zoB4otFlwD3BYA8fwar5E0/WyIVJft1oBPOEkO7v/mC/ET/tCQc6thNy5bPDrCB8aI6Ls2nIo9n
	kd6ZkM1X1fWVqp9Md+PK6eBpG5yiz75yvFMPYpRejhPM9XcyrI//W+nIAA2o+YEEl3N8Gq3BUc4
	1JCw==
X-Gm-Gg: AY/fxX4iHpN7YuqQrMnnY4pRPVaPOjq5chehzEKt87vB4bX2E6KKLNThrDVINDsCH0K
	XH56dVn97smC8KuzDdHmvKTaQwGhFoT0O7Bf4+YJIsRG5E4c0jkacTmQcQT2ocS15dUhhYqBUeQ
	WDWXwR+wUDtF4gXn6m1uf7Q6s+EiPut1VgRMThbGQyFHWIK2Mnwy8egQibB4eF34Q/bWU5w28h+
	dfBRGytKTn3Pr6DmnMbVCwstexl4Z2IURkFi/zPC3hzyDUNlPPtlodvsh/vhsij8eEwCSNILf3q
	hmIvdXrn6mAP8aFLyp+WG0QmbYGI9QdLLHBiLVJOWLri4vIiTfrbvnNQSN7MOyA+6rIVU7Fy81T
	XPEUGnq5veMtXtRjs1ivlOVRK7lJbOcjuIDckHIugn1n5z1ugSHxUsNc5vbJOF2LM
X-Received: by 2002:a05:7022:107:b0:11d:f682:e475 with SMTP id a92af1059eb24-121f8b5fdefmr18634406c88.40.1768218919870;
        Mon, 12 Jan 2026 03:55:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+QbeglUyaGRsFN19UkoqBVLlQgsoX1tsbGzBj0vrb7j6DAphCBQ+n89q9q+YescjN00jEvw==
X-Received: by 2002:a05:7022:107:b0:11d:f682:e475 with SMTP id a92af1059eb24-121f8b5fdefmr18634387c88.40.1768218919358;
        Mon, 12 Jan 2026 03:55:19 -0800 (PST)
Received: from hu-yintang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm25267595c88.5.2026.01.12.03.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:55:18 -0800 (PST)
From: Yingying Tang <yingying.tang@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com,
        yingying.tang@oss.qualcomm.com
Subject: [PATCH ath-current] wifi: ath12k: Fix scan state stuck in ABORTING after cancel_remain_on_channel
Date: Mon, 12 Jan 2026 19:55:16 +0800
Message-Id: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5NSBTYWx0ZWRfX4K7tr5kcDvN6
 4Ls5fT7MyogAqsMHUx+TGjkSbSlyk/iXX77lhl0soI1BnW/yvsAGg8WgIBIv7/LnIj2I3C4OCFS
 5eenY5/Divcq3B+x0JzIDhqVOYW4BiRkbplBE2XOJ0pfWvdNndYLO4cXg92HXGO2PUG2qcH2js4
 bH12qRBWRYW8mU2Kb2ThZFkCRmr6pfuSWKerPQjscd4T3QqzRJptDLwBMG/gAQB9UN5U2PIvYmG
 XvZCx2WfHzRuSSSGgtglRPg6l48OXXLItN8IFZuUjPqFYszHLI9/cMtmuarQREB1jTkMiXU3gdY
 c/mbAitaPGg9NfkKdsNgMCRoNZsgsFqNRCIHu+4vPhMUnPPJ2/E0hoj+21BH+hyev2r3FuKkQLz
 UL1oIQyCf5Px/+SlGQjB18Gd83/wNbarENu0V6siDEe0WHeRF0yXSrYgXjd3EH1WvgAw4gtFtPT
 ogpkt6qKYu/Z/bwJpBQ==
X-Authority-Analysis: v=2.4 cv=HrJ72kTS c=1 sm=1 tr=0 ts=6964e128 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SdPIdFeAA3FGzxFMktMA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: X9Ew3xJ4l_sSTAs1MWbyeltC3YuwqpMK
X-Proofpoint-ORIG-GUID: X9Ew3xJ4l_sSTAs1MWbyeltC3YuwqpMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120095

Scan finish workqueue was introduced in __ath12k_mac_scan_finish() by [1].

During ath12k_mac_op_cancel_remain_on_channel(), scan state is set to
ABORTING and should be reset to IDLE in the queued work. However,
wiphy_work_cancel() is called before exiting
ath12k_mac_op_cancel_remain_on_channel(), which prevents the work
from running and leaves the state in ABORTING. This blocks all
subsequent scan requests.

Replace wiphy_work_cancel() with wiphy_work_flush() to ensure the
queued work runs and scan state is reset to IDLE.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 3863f014ad23 ("wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan") # [1]
Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2f4daee9e2f0..7b72db3193d6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -13448,7 +13448,7 @@ int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	ath12k_scan_abort(ar);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
-	wiphy_work_cancel(hw->wiphy, &ar->scan.vdev_clean_wk);
+	wiphy_work_flush(hw->wiphy, &ar->scan.vdev_clean_wk);
 
 	return 0;
 }
--
base-commit: d0309c054362a235077327b46f727bc48878a3bc


