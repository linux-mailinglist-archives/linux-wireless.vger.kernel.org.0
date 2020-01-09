Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF5135A16
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgAIN3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:29:30 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:35850 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731054AbgAIN3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:29:30 -0500
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 08:29:29 EST
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009DEiqp017503
        for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2020 06:18:54 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xaptfb6nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 06:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2ZDnuKeMDOarUodZqeM079sUASL42UIbheZob0OrrDiAxs+AY7eVeA5sR0PJfduhUATw79Rn2gtx4tylARNA96lx73EImR17a2DtlabhRJSxIAitU+2BFf6qO7L1HhFm87drYOcJgnbF+KtimcaGHkFtmnPvGL5aIhBo5woQ1W2V5+uVX9U6+yTcjvaEMTWwlggXt/362GerJ505TA6yL9dT1oLPz7V1LsRJ+/WT4tuWgK2LDG61NYVjdxzato5PtyuiDP1nOpijuJPJjcG0FB0m8NHkIZtNfhC/KFtdLjdOoN5MQwPLySid6/Zv8Ai4kwl49+ZQR9mHCN2Z41LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/9dxbRQlH8B8BeaO+B50YmjF7ZDlJj48R7ftTGiFf4=;
 b=PPI33VbIvk2YGF89g8Yw9c/GG1lFG75GEiyQgXecjXJcwDJwDXkWnBfyM9LFl7JEZ7YA6wWh8oPIKoWeXy5EC4HKSiok1tGRbTp4NBKJ1QuI/xGY5sT4iiJInSqMX99tq4crvl6TcolllLKx5i+5oIiYq9I0hs+qYJDemiUf2L4LNrOY3+YOirZ6nXyPW00egfb+PjpILBWu/m+hVvvjJJVrfYG6v7qvDQSD0zgcPoJZ43Wnwzu+lS3tqNBv7dL6LzfCl1W08poO8Z69xI9DdDiSHeRI3AkNKy8PZ0YwilTThz3XOTArLo38xxvEcCb8sBPDN8THfHbiPnkk8lkjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/9dxbRQlH8B8BeaO+B50YmjF7ZDlJj48R7ftTGiFf4=;
 b=R9oGgCTB8pi/k+bRuOuFG4hIad4LJBWTj6ovEsrvSNHq/uaCyCk0v8oDbNUdHKYQsgcqMGl9EPfqKp6MfziDFL0IOwRLw9HxzSCd/AFWkbmuO2OlR/NJ/RVjWjxBC3Fl/NTn8lQvVC0f4OW8Qij+0D3vnfZD33lRa9A2b8BAE50=
Received: from BYAPR05MB5014.namprd05.prod.outlook.com (20.178.0.80) by
 BYAPR05MB6167.namprd05.prod.outlook.com (20.178.55.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Thu, 9 Jan 2020 13:18:52 +0000
Received: from BYAPR05MB5014.namprd05.prod.outlook.com
 ([fe80::e44f:c766:5203:4dc3]) by BYAPR05MB5014.namprd05.prod.outlook.com
 ([fe80::e44f:c766:5203:4dc3%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 13:18:52 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4637.namprd05.prod.outlook.com (52.135.114.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Thu, 9 Jan 2020 13:18:10 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 13:18:10 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 3/5] qtnfmac: control qtnfmac wireless interfaces bridging
Date:   Thu,  9 Jan 2020 16:17:53 +0300
Message-ID: <20200109131755.7729-4-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
References: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0901CA0053.eurprd09.prod.outlook.com (2603:10a6:3:45::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 13:18:09 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57fae75-5844-491f-1dc2-08d795065fa2
X-MS-TrafficTypeDiagnostic: SN6PR05MB4637:|BYAPR05MB6167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB46379CB7057DDFDC44341068A3390@SN6PR05MB4637.namprd05.prod.outlook.com>
X-Moderation-Data: 1/9/2020 1:18:50 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39850400004)(376002)(199004)(189003)(1076003)(8936002)(81166006)(316002)(54906003)(6486002)(107886003)(5660300002)(2616005)(86362001)(956004)(36756003)(478600001)(103116003)(81156014)(6666004)(66556008)(8676002)(16526019)(6916009)(66476007)(2906002)(66946007)(26005)(186003)(7696005)(52116002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6167;H:BYAPR05MB5014.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkMy2lNkl5gk8TeyyKJ+pSujzU3mQLOr7ttdvstnNFuH+H/0bn9MpA3WUmAVHh+WX0xKzI6QNeSiXfHpe50fTHkOWCGsnHLxxrKqCCens4U67Ng7/FiaKI+K2aNwC544FhSJ9O5JNmBWsKN8h1xFkkV60lT9Bp/3kbAJEqaanwslIrd0XpXzUZG0ZuFcQmy3FNrAgwB2XBxzxrLh5vPfwMpnVfQKaDeaCBVSk82V6zWyzocZpu2nWvR7Fuz/jNZzChoiwfsOHkprHcTmGKxahn+0zVk0PIAzoqi5pv6hSL+q7jYgaqyKZAuDzofUINZNj7y/wdKVpxVIF3HzEh8vSJRI5APFJvvodf3KxqrwDmGsHOtn36f2GjVhruPC6oPCvCvJCqiiLJClVsK9BPnT+0RFqGi1rFhRg5uM9aRBo459rS22QxFOFRiWUQmTqPmC
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57fae75-5844-491f-1dc2-08d795065fa2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko3F72a88iKJbkVUOwgKu4RubkYhcuABQnQVK66rfH2ohUVR+rLLJtRg9T/Zo6qOst3M6MHGbJqDMetcYg8CjRTYc2CnE7cARcgEt8ls4FYSf/tJRfM8DVk0pDgtYM1CqwMHkrpc3v7hhYa27KJ4T4Av1vFnfF8paOq1deg0wc3aOMy98+MQWAdvugLOSeIL+VtDr8Xwl0cXg3UCDNNH/dSkKUAIKMHv2Mf2IbBWnMY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 13:18:52.8062
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6167
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 suspectscore=1 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bridging qtnfmac interfaces is possible only if the following two
conditions are fulfilled:
- firmware advertises proper support with QLINK_HW_CAPAB_HW_BRIDGE
- kernel is built with CONFIG_NET_SWITCHDEV support

Otherwise adding qtnfmac wireless interfaces into the same bridge
should not be allowed since packets flooded by kernel may break
internal forwarding rules between interfaces.

This patch disables adding qtnfmac wireless interfaces into the
same bridge if no support is provided either by card or by kernel.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c | 52 +++++++++++++++++----------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 9bd4c8f98308..d723438732df 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -225,9 +225,6 @@ static int qtnf_netdev_port_parent_id(struct net_device *ndev,
 	const struct qtnf_vif *vif = qtnf_netdev_get_priv(ndev);
 	const struct qtnf_bus *bus = vif->mac->bus;
 
-	if (!(bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE))
-		return -EOPNOTSUPP;
-
 	ppid->id_len = sizeof(bus->hw_id);
 	memcpy(&ppid->id, bus->hw_id, ppid->id_len);
 
@@ -665,12 +662,24 @@ bool qtnf_netdev_is_qtn(const struct net_device *ndev)
 	return ndev->netdev_ops == &qtnf_netdev_ops;
 }
 
+static int qtnf_check_br_ports(struct net_device *dev, void *data)
+{
+	struct net_device *ndev = data;
+
+	if (dev != ndev && netdev_port_same_parent_id(dev, ndev))
+		return -ENOTSUPP;
+
+	return 0;
+}
+
 static int qtnf_core_netdevice_event(struct notifier_block *nb,
 				     unsigned long event, void *ptr)
 {
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
 	const struct netdev_notifier_changeupper_info *info;
+	struct net_device *brdev;
 	struct qtnf_vif *vif;
+	struct qtnf_bus *bus;
 	int br_domain;
 	int ret = 0;
 
@@ -681,25 +690,34 @@ static int qtnf_core_netdevice_event(struct notifier_block *nb,
 		return NOTIFY_OK;
 
 	vif = qtnf_netdev_get_priv(ndev);
+	bus = vif->mac->bus;
 
 	switch (event) {
 	case NETDEV_CHANGEUPPER:
 		info = ptr;
+		brdev = info->upper_dev;
 
-		if (!netif_is_bridge_master(info->upper_dev))
+		if (!netif_is_bridge_master(brdev))
 			break;
 
 		pr_debug("[VIF%u.%u] change bridge: %s %s\n",
-			 vif->mac->macid, vif->vifid,
-			 netdev_name(info->upper_dev),
+			 vif->mac->macid, vif->vifid, netdev_name(brdev),
 			 info->linking ? "add" : "del");
 
-		if (info->linking)
-			br_domain = info->upper_dev->ifindex;
-		else
-			br_domain = ndev->ifindex;
+		if (IS_ENABLED(CONFIG_NET_SWITCHDEV) &&
+		    (bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE)) {
+			if (info->linking)
+				br_domain = brdev->ifindex;
+			else
+				br_domain = ndev->ifindex;
+
+			ret = qtnf_cmd_netdev_changeupper(vif, br_domain);
+		} else {
+			ret = netdev_walk_all_lower_dev(brdev,
+							qtnf_check_br_ports,
+							ndev);
+		}
 
-		ret = qtnf_cmd_netdev_changeupper(vif, br_domain);
 		break;
 	default:
 		break;
@@ -772,13 +790,11 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		}
 	}
 
-	if (bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) {
-		bus->netdev_nb.notifier_call = qtnf_core_netdevice_event;
-		ret = register_netdevice_notifier(&bus->netdev_nb);
-		if (ret) {
-			pr_err("failed to register netdev notifier: %d\n", ret);
-			goto error;
-		}
+	bus->netdev_nb.notifier_call = qtnf_core_netdevice_event;
+	ret = register_netdevice_notifier(&bus->netdev_nb);
+	if (ret) {
+		pr_err("failed to register netdev notifier: %d\n", ret);
+		goto error;
 	}
 
 	bus->fw_state = QTNF_FW_STATE_RUNNING;
-- 
2.11.0

