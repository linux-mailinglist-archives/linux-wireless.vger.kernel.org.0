Return-Path: <linux-wireless+bounces-5996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C9189D5B4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685A81C22D99
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE597FBD7;
	Tue,  9 Apr 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bw3546If"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6907FBC0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655645; cv=none; b=MwI4iqSur4ORgV0/Iy+qGucA2xQR/IADqL0a3Q57P2C3cqZZwa9hjm9ObvoOYm7X75+XwtEm/nknaDgethjYjfQvgpCegjcSkL5FK9609qBqIhIigrMg26vz4uw4hsadCfTs6CnqiqbV/Ej+1tw3VOs81PGkItIRH/aU2U/II+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655645; c=relaxed/simple;
	bh=LwltQ+8PgLk+bn7otqz4o+jcGofSBfks3QQVQXnQzOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lERgrIkV9XAAOAtNgHyZ2MuZLTWqloggVurfM/FpO5DHUY4QRQ/fP3z1SsY7MKdQ7wslYkWRuo+FPxzg9hMjbssyspKSojRV9BcJLnd8eKz4TlR5cpspv6pg1261fJQFS3XV113IdH11EtOiTJnhbJGJmjeR+OPQXCjL9Pb8z5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bw3546If; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4399LglZ015382;
	Tue, 9 Apr 2024 09:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=EHxdvoz
	NNFkxIEHHuprdeLKc44V98JPAOCBgiuiva+8=; b=bw3546IfYglL1JpLqe4WVoz
	EWsU4Hy2tpqUYCg3S06jf+Zk0TpQmsqw7ETB36chMjbDduKURrDpl0Dgfo9E8yXB
	A5kQRkXc6oHZTftbtTy8sFGsoAv2QS60c32egDm4uZeOodlW51CzIEtQZS2lR1JX
	NNfBH6fTuwW+bsN8XUNxHOEe7exypfIg7Riz82aaid9Dh56hsNQ8Mcv2+lTLLddH
	B2sSh1gqxJ6liUDTIwdynVcBMfZ4OogVNHpCbui1oUMvCv8ojQb/f4yl9iLkPaAF
	qOOCF+TLQK2Sq0k7zn7KEz3c1azni7GOlzPbZPGjlNEkqEhrb64WkHrkx/KTkFg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd0hw0bxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 09:40:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4399edkK016207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 09:40:39 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 02:40:37 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: handle sdata->u.ap.active flag with MLO
Date: Tue, 9 Apr 2024 15:10:17 +0530
Message-ID: <20240409094017.3165560-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jtKihB0mO-5F0vMF7A7Zo9As68xvI5yk
X-Proofpoint-ORIG-GUID: jtKihB0mO-5F0vMF7A7Zo9As68xvI5yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_06,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=953 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090061

Currently whenever link AP beacon is assigned, sdata->u.ap.active flag is
set and whenever it is brought down, the flag is reset. However, with MLO,
all the links of the same MLD would use the same sdata. Hence there is no
need to set/reset for each link up/down. Also, resetting it  when only one
of the links went down is not desirable.

Add changes to set the active flag only when first link is assigned
beacon. Similarly, add changes to reset that flag only when last link is
brought down.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
v2: * Rebased on ToT
    * Used negation of active flag as condition to set the flag only
      once instead of computing number of links every time.
    * used '== 0' instead of negation for clarity.
---
 net/mac80211/cfg.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f67c1d021812..9d2e4a7f5513 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1232,7 +1232,9 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	rcu_assign_pointer(link->u.ap.beacon, new);
-	sdata->u.ap.active = true;
+
+	if (!sdata->u.ap.active)
+		sdata->u.ap.active = true;
 
 	if (old)
 		kfree_rcu(old, rcu_head);
@@ -1486,7 +1488,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		if (old)
 			kfree_rcu(old, rcu_head);
 		RCU_INIT_POINTER(link->u.ap.beacon, NULL);
-		sdata->u.ap.active = false;
+
+		if (ieee80211_num_beaconing_links(sdata) == 0)
+			sdata->u.ap.active = false;
+
 		goto error;
 	}
 
@@ -1619,11 +1624,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
 		netif_carrier_off(vlan->dev);
 
-	if (ieee80211_num_beaconing_links(sdata) <= 1)
+	if (ieee80211_num_beaconing_links(sdata) <= 1) {
 		netif_carrier_off(dev);
+		sdata->u.ap.active = false;
+	}
 
 	/* remove beacon and probe response */
-	sdata->u.ap.active = false;
 	RCU_INIT_POINTER(link->u.ap.beacon, NULL);
 	RCU_INIT_POINTER(link->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);

base-commit: a35b36e6ee5dcf323d846ec3881159e4af90c9b4
-- 
2.25.1


