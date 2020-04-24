Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A01B7321
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDXLb7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:31:59 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:11480 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726668AbgDXLb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:31:58 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBQRdu008499;
        Fri, 24 Apr 2020 05:30:13 -0600
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-00183b01.pphosted.com with ESMTP id 30ka133vcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 05:30:13 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHZmxXmIT1uC/gq1vcwsOp/fPMPgFAH/HNajpH+DguHfz2lrgyn9mY55vHA6JwBHHSry7TFXq7lFi6cZ/VDpcXkoZ+bq7iV2mAyalPd72VmGYAa7zcsAazlqsGGI1bjT8jYkBgBlRYcLcZrkOKlrOYp+LPn3lKsMhDuh7FRj4iDMV+oRlUtvBMGpayQd981+2GEa2jfVj/4j8nB/R+QgnA5HeY0ti4EkSuKlGICHTdcev/ZlScqu4TqBgt7jR1Wz4I3N03H3+7XxkHAMzpHI4X+sk2JYTmBmHUZRODQLTw1JLdtVP1WpG8p04AJk9phCIDRQC4IwGbSp8JlG+XCR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvNQ9fd/ZvtOVklE7YbQDz1waeW1ol2i5FyFoS4+s/4=;
 b=hiTkK1T7GJBsAkHURU8kxHhkOsehnRxGboFOSmfYHKMfa3tDBcaubm3BumHs9UzLLsYe6y3gk5z99z1R4McPdOiQbVOm77ReD79Fy6dKLI/UJiU7tW9wSoiSYF82em+3dYZXThLS8IX9KjEw4nBv5QMhKCvlY8IAz8LW9Y+bK7hf9pW7zsAoCWNNUxxhJRjYmFU5JCLIAlKZAXXpZoiYAYlcQB/D7RRe5lmAbeI4AVS9GU2ENdx3aELxWMalwln0KrrRu/ExNnz9HfUwWw7JtfaL8o8rekwe9pxAHEa+/V6W5JkzroLADucGLOeP0hQucylYDeYylfkv9uu+AEx1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvNQ9fd/ZvtOVklE7YbQDz1waeW1ol2i5FyFoS4+s/4=;
 b=T/fW7ulOm6lpEs6HQOUMdo6v0+Lz4CV+LHWmebswlKIRs8pG/Chr1g6DYu6/bp7ER1/KL992e6R+Tg9A3Y5VkkZsRuH/wkMslFMe4ogm9iilkA3NpjtN5j9OgOZDdMCTkuMYnYlgdst4Y8f4o6YxBzGYfweTpQ4ASE6lLRMTICU=
Received: from DM6PR05MB6266.namprd05.prod.outlook.com (2603:10b6:5:11d::32)
 by DM6PR05MB6506.namprd05.prod.outlook.com (2603:10b6:5:126::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.5; Fri, 24 Apr
 2020 11:30:10 +0000
Received: from DM6PR05MB6266.namprd05.prod.outlook.com
 ([fe80::459b:9bb3:1d3:a613]) by DM6PR05MB6266.namprd05.prod.outlook.com
 ([fe80::459b:9bb3:1d3:a613%7]) with mapi id 15.20.2958.010; Fri, 24 Apr 2020
 11:30:10 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3160.namprd05.prod.outlook.com (2603:10b6:903:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:29:17 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:29:17 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2 2/5] mac80211: fix variable names in TID config methods
Date:   Fri, 24 Apr 2020 14:29:02 +0300
Message-ID: <20200424112905.26770-3-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
References: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0087.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 11:29:15 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c51bc5ef-072f-4fc6-9c45-08d7e842b938
X-MS-TrafficTypeDiagnostic: CY4PR05MB3160:|DM6PR05MB6506:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB31604802F49584B541D1C7C5A3D00@CY4PR05MB3160.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 11:30:06 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB6266.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(366004)(39850400004)(26005)(2616005)(4326008)(2906002)(956004)(478600001)(6916009)(16526019)(36756003)(8936002)(186003)(107886003)(7696005)(52116002)(6666004)(54906003)(316002)(6486002)(66476007)(66556008)(66946007)(81156014)(1076003)(5660300002)(86362001)(103116003)(8676002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3ZG1eHKnSodVYdCij0sw90hy0DxeCXoRTLooV6hBbzPeLNaRTHMgSIUZgo4M7uka6q4oMNU351RIfKo1lX0Oj7INPxow2rDnMmfzYNGgIfD/0HAWUdjxx7bgwmuNsoQYiDIUCy0eVMsEfENedRzEbDR9Kf058vrpx4IIPHsA87oJVI1Rj4SwUIUkCt5PVWXYUTtrO6dMlqk2k9UeZc6mihYOhme4Oon/4zV0DIG8hlCq6NyiiKP/nEUGHRrGun+XJ8njc9yGC/GiFRNft7FVDtSjdQ5aLRtvbG/OsCR21L66gJIguiZf6+k9oJ/JglJO37uV1q/zTsgTj5Xg/v5Je9Ybh3dRpyjsDHo+T7vpHW/Ub0xFfhn7HFclP3LJf4K8QxA98PYFDPAKB2xiR56kvI95b5BNPqWM5wpvkDtXc3iBE7pOOookJzQxFWV1gJh
X-MS-Exchange-AntiSpam-MessageData: QdVTFcJmCP1F+ylQMAeDuQxxGMNnDkaepvG2qAzcTbN+jLa9Jcf+nPNd7FCD8P+/rmbw2zwZnrzKSIVgbbpVX3c1b1rfjtTkxs2Ciwkcjnfksqusj1kB+IfpZx1VjRnB+o96Awjuu/Wr1Ikw2ibLdnsvNBseZBgDoPeHgp1/PFnd+t+JuzkXdVgZYH1/aVL849aVZs+tb+WQwIf6GNwMa5KNjRG95Mx2Efmr2HbiMSzwIMRtTO/mVEQnf+LFFY4j1y1fx2j0QEd3fX2MQnSqINZFM93AGM5PPPTOT+teI811y8wVWlEIi2eWlIsl3pK7plLxk+GPouYcheHqsE/A6x0O1KmkEJAT5CHVYJ4GxOIAAwUFsJWxERrtMXIChtZEMDTGHTkAhYhElm9oFZGFMSTbXiDE+dzj+cAEV68wf6bINj0Zhi2mA3IbatZbIGz6qOWnWphRZp25ulW9X2qslDh11yIQIfMCEfjeMY9R7pBox8UpAkWyA/MyxNdiYwb8AKbifEAW5lpyUZHd/F11wOVYWc4rqYXzU0KS09ByV6ESq93P8VTrBzdV61CYt4ghIAUZHyR8jmTSY0LSELJsJ0oLHfV+b0jm6WSt5TmGyNkVQrG0xTPKr9LPvhIkV8ySE7DQeW2CwBLiy4ufiDlvQaXuy9ooDX6WIgYPF0ZuNfZOoOoZ7jwfKxrDw7WOmf8kB7mqn12fXfCTVdIOg+YLBm3WlznZs02MzEO5AOhT6M6C4VUvfc7xTwLDCMEy2ZFJmDY7EncbCvxPfEHS8ljQdhnUwAGahaVEzmChoV5dsAM=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51bc5ef-072f-4fc6-9c45-08d7e842b938
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+jWXKUTJr4gJcIm20JcNOpFR2IqC/nGblHPMQ4RozMMvvJ5BS+l8N0XpzcsFCyDEnwsksDMxv7zua029Q+35YOsyxlFhKrCN+5X2os6DZ7Q9VQuwnJYETjc9o+7SyNKNfctMy95QbXoYwEClYDykcHxpvHp5OB9OtsarwrXMoQWfwl0uQ20ACJRxnoJyzGGLa40ZkR7wlOQnaml2v8fBg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:30:10.7952
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6506
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=1 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240091
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
index ae3e06375a28..608c2b034804 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3933,7 +3933,7 @@ static int ieee80211_set_tid_config(struct wiphy *wiphy,
 
 static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 				      struct net_device *dev,
-				      const u8 *peer, u8 tid)
+				      const u8 *peer, u8 tids)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
@@ -3943,7 +3943,7 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 		return -EOPNOTSUPP;
 
 	if (!peer)
-		return drv_reset_tid_config(sdata->local, sdata, NULL, tid);
+		return drv_reset_tid_config(sdata->local, sdata, NULL, tids);
 
 	mutex_lock(&sdata->local->sta_mtx);
 	sta = sta_info_get_bss(sdata, peer);
@@ -3952,7 +3952,7 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
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

