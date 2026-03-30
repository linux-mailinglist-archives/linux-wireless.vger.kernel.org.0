Return-Path: <linux-wireless+bounces-34152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHjyI2n3yWms3gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:09:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9635527C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78F403002B2D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EA35F615;
	Mon, 30 Mar 2026 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nz2N2eBQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wu2pjJI6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A134CFCF
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843749; cv=none; b=PeXXFba+XMgDwKpjgS3CvHXKYS4eJhO4MnvNBwa9BVBFAAi/Qtq4b353Nh4kX0NXcZEezhJ50t7NYEB6Ymjd4Srq0S5gjI6dvZYZ+1PCxW2aTRfxQLOBNDfVVQ4W0IGQOMGTIenpwDq0X0jsm+uj+VkWXiX2sgU4BVi+vTHTa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843749; c=relaxed/simple;
	bh=30r3bUpgQgJ1qWP1xx7Qpy3TLPlJ9ilOKE8lNmECz2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQCwTmDsiXLjGv8eKzonK+TY3/St/zCg88dPQ1XaWk/i3BmOVwNZJKIBrsoSFzLGFbIahu5EtLO/3n27KT+b+N8zMGM1WvOse25jSOKEzLhIMIYt/k7mHZLpqPclSE1PZhbGEInqdCzbc1+vJkXQWyKKFB65cB0QdlPfX6hk/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nz2N2eBQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wu2pjJI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAhoNA581263
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=P3LarXX0vc7hut4xiv5RbMlDi9xe2Q0QL8l
	p/xZovrs=; b=nz2N2eBQthPW25zilL3ObgbfO6RZl7oXsUO1y+FelkGApci55oE
	HKA9M9mrPVVHtodOEDgrliWMsAuePZsnx6tuv2yYMozL81r7R0al2hUhsVsg/7mj
	UQ6+qshjxFJslBgHcur+wHzJ1rg7NG7tO2je039kUkpx7qTEUCgQLNNwwhmnLo3s
	ld3tqxoR9v6UPlaZR++aWy0qJPAtYpSFF09eYE7liLVj67CagKn9OHfUYo7jkNKC
	vqSSBjR8QWZRhgYCCkXKQp6zojUzqYW3snSWB2sIzI10P/4TPjB09fecu4qOMHIB
	eP+TinZrkuM4TOlWvKHAFWW0yVBStL7jZwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d65xqmgab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:09:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b258636d16so1703365ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 21:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774843747; x=1775448547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3LarXX0vc7hut4xiv5RbMlDi9xe2Q0QL8lp/xZovrs=;
        b=Wu2pjJI6tdmSTYxr0s/AeQ1mtjY5wLwSiF6iRTxOvEBHW5NF1rNahk6vjugUifIqYP
         XAlN4kB5WQ5VBwLfxzffgVD6x0k47qYY5kvdPjyvUcTPFhK8XC2dju7DQWlr/qjMwNKh
         c/7PeueyU8wxP1/SemTiOEX0v5Tw6u4PyA2INJyaHDS+gXIthWWlx88UNziJf3/sd3ie
         G45j4PRC6Kf3SgXVMjjYroYN27cMuFrsrM39V7JCzT4vbsxoVCqZPppODpce1urZvZzJ
         XCQNi8hOLtr4rXxlWNNoHbJuhhSx8DJ8X5mZni1EBfNv0tz8Q06TidLRJABlS00kBNOV
         Bkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774843747; x=1775448547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3LarXX0vc7hut4xiv5RbMlDi9xe2Q0QL8lp/xZovrs=;
        b=Diip8p6STJodgSOzeOOGdPEq+Oz5+uklf+TnhsxI9QSqLMezeuofyHxDOSNyFmpOil
         yJjNcfufdShMZ1FH+QO5DK9GKUq/tZ/7PhWtvzhBYOkQ1/e0Jk8AYJSm2h1isnI/1fIj
         265WWy10Cf9W8kb3PscGw3C4QhV9pweDe/bQ946Be4QMWWQ/n1bw0wTe7646ISHbkf2K
         zFht3YkRHxew8o2XBxjkSNucsthp6i27yRTSX7JBlabXJHccStharQcqyKf90x+dSwEz
         DCt+qZ8ObhfHCoERpdy3jVqFmcZXmyi+OD0MXGXHGsxT17kUaBpIubLL1TjinDq63Tx0
         FWEg==
X-Gm-Message-State: AOJu0Yx6YmyztQxjNhuMvmo+PuH+noxn7tnttcgVfPI2MFpKxSPBk5WP
	MhlbS4xOQeo4iGpwY+k1VbViNFIYfJgDU1pZ9Z6/EgRtr3aGvymce3Oj+dhVEF3+q9TVpHBy5zm
	56MoN8HnwgSk+huS3UkbbxM2L/2boVHv71UNRqd/PelEXgXvBI/vhwUAUq/l/Ds3TEIXZPQ==
X-Gm-Gg: ATEYQzz/IVDu3DeIoQyH9GHBbcgVlZhfuhAymgMADLly7CK+7i253vuLVeIkqFl3H/0
	v/sCIpO/y3K4dm0EtOydDHzkd35ZTz2s9xOQ8AsnZ9yQkshm512gLVloE8dFnHAsCuOoO44Niim
	CRjS1OwCYlcDj58ys0P8yJz8rAQTsshl1dpMOtlCWq762XfmoujJNnjlYeCwQqUvnmdwyuYM7wB
	drL/nW87kodRgujkQuxNpwX9H8fQlWnj33FDmE8fAPzSdqAoG28kjRuMJboMnaya7oeF7TZyV9/
	e7MUq15I9D3yGC5mYPlYE6KIUOGkcVSRrvx268cJ3K4rSY4xtKtX6krrMpvhYcOOqHATTG5gnPh
	KcPgbYq6IwRg4PJWOjdD2Ske4xgQaUEfMMIoyovjHka601AdAPsEOPQXucyA8NXzQ6RJeJDnMzE
	gP/eHHAGsnEMxijuqqBUZKeXmBnJwEjtKik5zLi5DSmvJwcO3d
X-Received: by 2002:a17:903:46c4:b0:2b2:5840:808e with SMTP id d9443c01a7336-2b25840867dmr5016355ad.10.1774843746643;
        Sun, 29 Mar 2026 21:09:06 -0700 (PDT)
X-Received: by 2002:a17:903:46c4:b0:2b2:5840:808e with SMTP id d9443c01a7336-2b25840867dmr5016095ad.10.1774843746194;
        Sun, 29 Mar 2026 21:09:06 -0700 (PDT)
Received: from hu-rdevanat-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm74863095ad.72.2026.03.29.21.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 21:09:05 -0700 (PDT)
From: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Skip adding inactive partner vdev info
Date: Mon, 30 Mar 2026 09:37:32 +0530
Message-Id: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DAfmCeqSNKG4NxnC7YXUAn8Igx_9xKBs
X-Proofpoint-GUID: DAfmCeqSNKG4NxnC7YXUAn8Igx_9xKBs
X-Authority-Analysis: v=2.4 cv=evLSD4pX c=1 sm=1 tr=0 ts=69c9f763 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=3bRBwJvXpg6Y2ZthPLIA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAyOSBTYWx0ZWRfX1JIoDGaCc9r3
 LnYX1DmqqnPf+etti1CoJLAWysc1ZrUcc6WEShM3/2+KeliyjD1C5tzvwH+Rep+QW0mjHeQ7Lqq
 eA0urnXpcrzAF+VTGeI2jFNEU8RKctuBhdI6wCSKV2KP32u6V8Mqt/RDGwyP7D3sR9Yud19GqfP
 ptSVgl9bzyt67Ssrwpm2QtCmeoWgSCFTWAWwkRl3wvG9h6wT2ISU2JscSr2CbhF3g0dP/7Pxbb1
 DDfC0RVY7QiDEUUcvdjmeGErsibc3ZCHnXKyl4HssoVRVE7SRf5hlwQV/ebWuxR9AM7bsZsRVyF
 UJyY28gJMeeWN23N9PNoEtPQom87QyXtIxUuZo6RmIPJzVLnzu1JCf1IlHSGVX4j3fFIaKjE7Rp
 lPO3DAcPGtZDeN7JVxvt4glu8Y21JLw7eSEQzhPIymhQuZzGw4dhAYSdfTWVz2g17mfwH8aVhqg
 HgtZKfwJlMeZKGnsClg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300029
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34152-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roopni.devanathan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 34D9635527C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avula Sri Charan <quic_asrichar@quicinc.com>

Currently, a vdev that is created is considered active for partner link
population. In case of an MLD station, non-associated link vdevs can be
created but not started. Yet, they are added as partner links. This leads
to the creation of stale FW partner entries which accumulate and cause
assertions.

To resolve this issue, check if the vdev is started and operating on a
chosen frequency, i.e., arvif->is_started, instead of checking if the vdev
is created, i.e., arvif->is_created. This determines if the vdev is active
or not and skips adding it as a partner link if it's inactive.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 553ec28b6aaa..c1a1b220f4dd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11131,7 +11131,7 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
 		if (arvif == arvif_p)
 			continue;
 
-		if (!arvif_p->is_created)
+		if (!arvif_p->is_started)
 			continue;
 
 		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,

base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
-- 
2.43.0


