Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703511B0784
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 13:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDTLhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 07:37:24 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:55096 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726209AbgDTLhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 07:37:23 -0400
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBU0LR030896;
        Mon, 20 Apr 2020 05:35:39 -0600
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00183b01.pphosted.com with ESMTP id 30fxf83wnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 05:35:39 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA0v7xPiq6vdtcYlkte7z71Ccd52czYx9r7EsiNhm/eFt91Ner3h7M5+QxyJUPOdaXFHqTUbIlCfcTM/aHcMdWXXfzxLjcCb/ls5Bnd/D1uAvD6keRRSzxaFS18PhfYM7c1CCdBRjl8h/v3/uzfnIQIccCd20+iPekU3lQjqdGf1aYq/UGNsCj7VA0czSsvmPGjqx/9Qk9p29XgFlWMHkYXMH1hJwPFIOr2OXrRLFRPS35O7VWoIjrWfhUBVbyyCWvPy31Jao9GixI1yD0hhud9TJt3IFhlZd+9hhKN3Kjo4vjuur3VNQAm6GWGHWPtu4lw/Dn6+He/nh3QwSugKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXqCTIlBY7Tv8BOLHhomYbCbxRLXDCA3sKnQplGXzsw=;
 b=gRyv+NbcMaUznVM1NAsBykXMhCMQF9QouT/4fWXiepQ3bm6a/jVNxAXRaIXP7viYW8MXprOfk6D4zfOrnBo3DIrBxRKkIA9ilKxSzSD4T2RsAm3DELWUfC71bRzhwF6apOw+61aOjw61EBKyFFYeBm43I/WJurPInIqJdhniYh2ALMvo7+ugVH7YAy8IlkI3fXRsRsnZgzqTc4whdq7qLCct6G+wQuMEKgBEZDWzWXEBHLTKN2sccRxBfMG3RWyOzWLPM2IFxGR8UVOyz7gsKHpQLQWpsmKbOKeiMqKU1rDeV6m0o+OqXNuwRmm4BCnXEW/GXssacBVsYS5wHlPKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXqCTIlBY7Tv8BOLHhomYbCbxRLXDCA3sKnQplGXzsw=;
 b=ntBquT+348a6VPF/LPOv9pIOnxiVDgjsLxzUA25FQ7FYT8TFxSv05oj7HkWI9T8NdRwGJ6+IJiC97/HF3M2d5QNAjYJbDAonu4mleFSkStxD6mEeib3eoDLeuwHfHHjFtUEuMUeBBYRCQvkkIbKhenW9QhNpq9DiUptvLhLR2vY=
Received: from BYAPR05MB6439.namprd05.prod.outlook.com (2603:10b6:a03:f1::19)
 by BYAPR05MB6711.namprd05.prod.outlook.com (2603:10b6:a03:ec::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:35:36 +0000
Received: from BYAPR05MB6439.namprd05.prod.outlook.com
 ([fe80::50b9:31fe:560:6eba]) by BYAPR05MB6439.namprd05.prod.outlook.com
 ([fe80::50b9:31fe:560:6eba%4]) with mapi id 15.20.2937.012; Mon, 20 Apr 2020
 11:35:36 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3605.namprd05.prod.outlook.com (2603:10b6:910:51::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:34:51 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:34:51 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 2/4] mac80211: fix variable names in TID config methods
Date:   Mon, 20 Apr 2020 14:34:35 +0300
Message-ID: <20200420113437.16998-3-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0101CA0012.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:34:49 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f7567e-17aa-45de-d476-08d7e51ed683
X-MS-TrafficTypeDiagnostic: CY4PR05MB3605:|BYAPR05MB6711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3605FF8AD1B6DDFE03E790DDA3D40@CY4PR05MB3605.namprd05.prod.outlook.com>
X-Moderation-Data: 4/20/2020 11:35:34 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6439.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39840400004)(376002)(346002)(396003)(136003)(6666004)(54906003)(107886003)(4326008)(26005)(66946007)(1076003)(6486002)(7696005)(52116002)(66556008)(66476007)(36756003)(478600001)(2616005)(81156014)(8676002)(103116003)(6916009)(316002)(2906002)(186003)(16526019)(86362001)(8936002)(5660300002)(956004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbxWBo0gW3m+Jk+F2udBnEBlNL6+4zwbe3zsAHvV3oZum4cIRUKyAATc4XcrRBTgYJqFFk1EeHh6QauVlBOYke7e3dQ9ZPJQHB6IfQQGYi9Ww78vEE/0beDLaW00LT3B+0OMwVb+WVbVKIqpCdmtsr8A7onZ6ClLE4hBwvNLPgxyZagAd0UQ40BldYoaBlv/YM1bRLhNIZOWF5z3Y0xYYO20kydryndmVTDigHz474hD/dH4qy1D6eH5tnRbhtxocIM1SDdz7dM1ikx+MawhIwfdRCklEua973wJ7b/nCXEVpFG3HOxg3XaW6yijh/5PZw6xDTWefNJH335PjLttMAvLFuoJFsrlgLAH7AOdTUdvgNGScn89k12ftJ2ZNCBEMMLS6hErbDPP9LqRINpO3Q+rEFeRfEjtnRc6m5xZI3dwtHbr6XOTgXsw1yoxGYb+
X-MS-Exchange-AntiSpam-MessageData: fHO2so6pGmh16To5FR1pVa17xsmm2YZVDSvoFupNESw3+bXXXlspjb/4u78eR/9HvtF/ycKJIdx6ps8mth/+a9Isod5232lKWPCBR09t7s0WDLbhZB5maYJYDXWHvT2U5huiu9bbbrFceyuujlNnwF+c4408j67WGLfujFoCqNHXioU4LHz2PgVCyuDjfa5cSq3GjYybU0ZHPHB0D15BploPYQohHqR30EbGxgaDPNJmpyiqqVvaviBvUMJLAxHSTh2gKYtbzzal59RnnXI2dYqFDa08XH8qHfSlunLPXdnZoj3rq4AoDyA+fDrIzT2V0XIP0uEFAolodrpQ9cVpvOxuWSwIlc8bS1BvJ7IAcbW1MwPxYOdD2G/flCXoMI4/Vm6EFj1o/14Awa0fdCKPI/VRgpIn8bMVBF+K4Q1kK9mRymajRgo8CU7cw5UkKtCU9ROkcIbZf4aL7bCA1RZIAWrY2cWeXBhv8KeEf2w+DAvLJ/ANchDz79/GfUNLus+xAJ0MMzIZ/477p++sFCyrogNmHj9VVHBZKVx+2mF0YbIhaFLcXh1Kz+5muqPNvePUQ6Hq6OGBykb4/tK8hRAVGfgxitHkX3XDEbcgCVqqjugy7lEPb32hp5QmvP0wGQHKEH/FBh34r33HK1pxfH7Df0HUnpdcRuWztoH5qQ0ujR6M7bFvKpGEShLJK8vKjsjIoMU6z2XjBC1CqmcJb41UAosFSDwA9Ob9sIyCeQvASNo6ejcXbqp623y8gkHsGgKCa+YW6f8rjAu/Kts7C1Ibrh9gUyiUyXta7LacXi5DleE=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f7567e-17aa-45de-d476-08d7e51ed683
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ssx+t49tkqornFHWvLphF947K1TBubTQ4qQpT0YNoqjS5+M2ByNLzxoT75DucQN1c5S54VUSWqhHrf5HseJd9ug1sPNNrQnW81JX4sOM7Amyic4m8X728J4sDtI2fSrhhj6fzXBCZF/wGHlo3T2NpwAXw5UzF9+YY+tdzJCRrtYp8532nCL+3k73kTyqtdffa+EHEJs2uOkMdrR9QKPIx1wLBYb+JPLPSgEZ9kBMV0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:35:36.7817
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=985 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200104
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix all variable names from 'tid' to 'tids' to avoid confusion.
Now this is not TID number, but TID mask.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 net/mac80211/cfg.c        | 6 +++---
 net/mac80211/driver-ops.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0f72813fed53..e8ec658a3c7b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3925,7 +3925,7 @@ static int ieee80211_set_tid_config(struct wiphy *wiphy,
 
 static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 				      struct net_device *dev,
-				      const u8 *peer, u8 tid)
+				      const u8 *peer, u8 tids)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
@@ -3935,7 +3935,7 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 		return -EOPNOTSUPP;
 
 	if (!peer)
-		return drv_reset_tid_config(sdata->local, sdata, NULL, tid);
+		return drv_reset_tid_config(sdata->local, sdata, NULL, tids);
 
 	mutex_lock(&sdata->local->sta_mtx);
 	sta = sta_info_get_bss(sdata, peer);
@@ -3944,7 +3944,7 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 		return -ENOENT;
 	}
 
-	ret = drv_reset_tid_config(sdata->local, sdata, &sta->sta, tid);
+	ret = drv_reset_tid_config(sdata->local, sdata, &sta->sta, tids);
 	mutex_unlock(&sdata->local->sta_mtx);
 
 	return ret;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 3877710e3b48..de69fc9c4f07 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1375,12 +1375,12 @@ static inline int drv_set_tid_config(struct ieee80211_local *local,
 
 static inline int drv_reset_tid_config(struct ieee80211_local *local,
 				       struct ieee80211_sub_if_data *sdata,
-				       struct ieee80211_sta *sta, u8 tid)
+				       struct ieee80211_sta *sta, u8 tids)
 {
 	int ret;
 
 	might_sleep();
-	ret = local->ops->reset_tid_config(&local->hw, &sdata->vif, sta, tid);
+	ret = local->ops->reset_tid_config(&local->hw, &sdata->vif, sta, tids);
 	trace_drv_return_int(local, ret);
 
 	return ret;
-- 
2.11.0

