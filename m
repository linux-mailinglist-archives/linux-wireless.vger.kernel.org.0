Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353CA100052
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRI1I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:27:08 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:31106 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfKRI1H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:27:07 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAI8QnCP010305
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:06 -0700
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2055.outbound.protection.outlook.com [104.47.32.55])
        by mx0a-00183b01.pphosted.com with ESMTP id 2waf9fmcxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljEVtVeNGaCNObce1lsbwvzxNDZydoD5AZpj97v28aVkkv6LoAjX3JMUUk4ixh2VQZm7ZfbByjIFIzzvx4VGzP425KDSBCtUK7jj8tsk5nlrNtfgwSNJlzCZ2Bqy089t/ALj3IO6sfDZ0C3U8mHP8D03jdhnpp+nbEm/M7fUt7xMN9tCaQemiFxhRizjpyXuJzhVx4PXIIFa7fv+ptzCgHEPtjZGxnM8kDENppVtm5y8/w/Ylr6E4kRMbvN4dmIXfpmVbujJiBiaORn+J7QgpX64TVmeRABrDfemA5llzO6xQQApqjXFQyYSNqJT7lvHYtyO7b+ns6wqNCFXIs9t0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBNKvRNvp8Zha2QucmYhsu48xVVkDGBXKWvwg8ybNqs=;
 b=bEq9LaL5/CvH+AS210/p4fA8jYUg1XRlRoKIVA6ir5DtGuWoJCTD/TRkTirbFOLzj7AzaY3FDEPazVTw1ZLof0q4tYcVygsUV6VQOJdwrATn0jDySoSqxeBByVpL8vepjqXS8/T/gsDErGF65J+cqVY1QwkwE9N6p7SItlkOO1bidDaECysvLDdHwHetjlMVp7L6K+ukOJEDX0TcBYrQ/BprzQMK/JVXMsChzZWvV7sEWkAeKqRA2ztjm77zfe4y0/0Jz2nNvsBh6SJn6vxPmRvvEyWfzTSX62k8XUx+ogSn2daEhWrBN1zEay1qLKrB2lDG3Jd3cE639kGFyksB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBNKvRNvp8Zha2QucmYhsu48xVVkDGBXKWvwg8ybNqs=;
 b=Dzbx5LpkF0MJaBCQcApXys/0qnuPwPAb3lwdW5Rkoh5X7jVsQdhR1I7WVct7z+TqbyMkmZf51hZba4y9Hyr1qyGUwjaiD4ZdLWqMUzAI/CutXMWvYNqAW8CppoKbVfFrLhq/9G5wdQIh6j0TxZBT2cgr3zATQb7h8MNjxq95oHk=
Received: from DM6PR05MB4075.namprd05.prod.outlook.com (20.176.66.159) by
 DM6PR05MB4187.namprd05.prod.outlook.com (20.176.67.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.9; Mon, 18 Nov 2019 08:27:04 +0000
Received: from DM6PR05MB4075.namprd05.prod.outlook.com
 ([fe80::5cfb:e35:2d06:b51e]) by DM6PR05MB4075.namprd05.prod.outlook.com
 ([fe80::5cfb:e35:2d06:b51e%7]) with mapi id 15.20.2474.015; Mon, 18 Nov 2019
 08:27:04 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:11 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:11 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 4/7] qtnfmac: advertise netdev port parent ID
Thread-Topic: [PATCH 4/7] qtnfmac: advertise netdev port parent ID
Thread-Index: AQHVnelpnzg40VYOU0+vG+wFVvyC5Q==
Date:   Mon, 18 Nov 2019 08:23:10 +0000
Message-ID: <20191118082255.6032-5-sergey.matyukevich.os@quantenna.com>
References: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e98a1ad-3e7b-4146-36f9-08d76c008c40
x-ms-traffictypediagnostic: SN6PR05MB6320:|DM6PR05MB4187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB6320B5DF3872C04B419A5038A34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:27:02 AM
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(39840400004)(376002)(189003)(199004)(86362001)(2351001)(386003)(11346002)(446003)(52116002)(76176011)(6506007)(186003)(478600001)(7736002)(436003)(2616005)(476003)(6916009)(103116003)(26005)(14454004)(102836004)(6512007)(5660300002)(99286004)(1076003)(66946007)(8936002)(107886003)(14444005)(2501003)(81166006)(81156014)(305945005)(486006)(2906002)(8676002)(50226002)(71190400001)(5024004)(256004)(5640700003)(71200400001)(4326008)(3846002)(6116002)(316002)(36756003)(66066001)(54906003)(64756008)(6436002)(66446008)(66476007)(66556008)(25786009)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4187;H:DM6PR05MB4075.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kr2p4p3zvrLxcOdetwobMmnNHYA5FBd09aYlkzHL8HNxZi8KqGIJjWeOxrK752wCsMm5Q5U5Rq0k3HenIkUfvGfu0EMw3+yMcb35G3vzgYup484MW2A7gmRtOIevUInBUqrUYKa0zpdy+04wq9FSZXnny6MfrEaPwIb+KrC4le1ySPC9OpISQj/ETtyOzbE5+UgkQWtpAnuLoZE4kpsa4F0ROj1VbnfDjsS2DLo1QqyTQE74dQUUIIxbQmQ259GdrNr54M0leHdzxg+8yFEPJSJmTMLEsRSjBxvQkRmV5/ivy0bzwHYQVL1G99UdAIaQURG7N2JvIXKs2MPcvv5LdKvYU9HScdIrzcI5UEUl+5F4e7EsGE/8bhw9PiBRef0I0+udOuAbwlJ38ApAjewGo1iIhUFbOevSvLB9HPUmrzmuJwYDE4HfAFuBmVMthPXD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e98a1ad-3e7b-4146-36f9-08d76c008c40
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwsZWbqQ5t7Km4UXYUqpl30+CoR1oPF8MTyY0cQFf1b56dfG5plWTCjMDQYbY7NIoPkMs/xD5IKah2VZdEHE3sZBKplBXeXvo3Z8ENh75Y3FXgL5z5MoK2Qy55em9GB0OyColjGaOGMuE56GtS0G3wcQ6NnxyjyjqiCr5RJCYLqxly6urZ5en8kIPAjv/3iyQPoUM9NVlzqKGs6ckmLZaQ==
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:27:04.4710
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4187
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180076
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Use MAC address of the first active radio as a unique device ID.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/bus.h      |  1 +
 drivers/net/wireless/quantenna/qtnfmac/commands.c |  5 +----
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 20 +++++++++++++++++++=
+
 drivers/net/wireless/quantenna/qtnfmac/core.h     |  1 -
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wir=
eless/quantenna/qtnfmac/bus.h
index 49372d42e471..87d048df09d1 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -67,6 +67,7 @@ struct qtnf_bus {
 	struct mutex bus_lock; /* lock during command/event processing */
 	struct dentry *dbg_dir;
 	struct notifier_block netdev_nb;
+	u8 hw_id[ETH_ALEN];
 	/* bus private data */
 	char bus_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index cbc56464220e..1c1b377932cf 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1242,10 +1242,7 @@ qtnf_cmd_resp_proc_mac_info(struct qtnf_wmac *mac,
 	mac_info =3D &mac->macinfo;
=20
 	mac_info->bands_cap =3D resp_info->bands_cap;
-	memcpy(&mac_info->dev_mac, &resp_info->dev_mac,
-	       sizeof(mac_info->dev_mac));
-
-	ether_addr_copy(mac->macaddr, mac_info->dev_mac);
+	ether_addr_copy(mac->macaddr, resp_info->dev_mac);
=20
 	vif =3D qtnf_mac_get_base_vif(mac);
 	if (vif)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 7300ab407cd6..a709e378928d 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -204,6 +204,21 @@ static int qtnf_netdev_set_mac_address(struct net_devi=
ce *ndev, void *addr)
 	return ret;
 }
=20
+static int qtnf_netdev_port_parent_id(struct net_device *ndev,
+				      struct netdev_phys_item_id *ppid)
+{
+	const struct qtnf_vif *vif =3D qtnf_netdev_get_priv(ndev);
+	const struct qtnf_bus *bus =3D vif->mac->bus;
+
+	if (!(bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE))
+		return -EOPNOTSUPP;
+
+	ppid->id_len =3D sizeof(bus->hw_id);
+	memcpy(&ppid->id, bus->hw_id, ppid->id_len);
+
+	return 0;
+}
+
 /* Network device ops handlers */
 const struct net_device_ops qtnf_netdev_ops =3D {
 	.ndo_open =3D qtnf_netdev_open,
@@ -212,6 +227,7 @@ const struct net_device_ops qtnf_netdev_ops =3D {
 	.ndo_tx_timeout =3D qtnf_netdev_tx_timeout,
 	.ndo_get_stats64 =3D qtnf_netdev_get_stats64,
 	.ndo_set_mac_address =3D qtnf_netdev_set_mac_address,
+	.ndo_get_port_parent_id =3D qtnf_netdev_port_parent_id,
 };
=20
 static int qtnf_mac_init_single_band(struct wiphy *wiphy,
@@ -565,6 +581,10 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, =
unsigned int macid)
 		goto error;
 	}
=20
+	/* Use MAC address of the first active radio as a unique device ID */
+	if (is_zero_ether_addr(mac->bus->hw_id))
+		ether_addr_copy(mac->bus->hw_id, mac->macaddr);
+
 	vif =3D qtnf_mac_get_base_vif(mac);
 	if (!vif) {
 		pr_err("MAC%u: primary VIF is not ready\n", macid);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index 75b70f0c2b8e..116ec16aa15b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -74,7 +74,6 @@ struct qtnf_vif {
=20
 struct qtnf_mac_info {
 	u8 bands_cap;
-	u8 dev_mac[ETH_ALEN];
 	u8 num_tx_chain;
 	u8 num_rx_chain;
 	u16 max_ap_assoc_sta;
--=20
2.11.0

