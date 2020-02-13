Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04A915BDF6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgBMLqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:46:14 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:30078 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729511AbgBMLqN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:46:13 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBgx8I005138
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:12 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u7fc5ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHI1FX+2PO3VvpgQYVqhGn3FOJh8+cJNa+P3YwPU07FsEhUi1ztrF+Lyrp6YzgbL7GF24YjNVXhjQxw4h8ndJgq2dg0ofSxjr0W/gLz+l0o/rn7V/Zj9Y6bJm4fW6PIvbS7CsfiVR6gJXiav2gEwF+x7e5OcnUjyjO5xEB0ELBVpVjcXGFDIUPOmRcEshO4PNp63z/vnUJBe4G8d8dUosQip8u2BBW+yiou/sDaCdFbcAnHkdfFxITNQXD4BVRJ6H5GAy5KiwqoJgiFrY59vlZUOa5aeDxxKHSLXOUvRfVzxNTTdivA8nKmNEwfQwec4mmMJ3EPHTiKIj4VSP/O6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmfCGkq31scRroXJnt2yI+gDaIyg78GPeC+5BpF9yFw=;
 b=CVFjAbCHHQgO34ZThKTPQ/CNbp0CrwwVs3dQnC8jFtiIQqeGidScVaML1l+6BHQfNbR7aO77zRSn6tbUHP3lIEYRRoiNmzFjWprJQxUYKxb23m0il6R21kelsFWToPvX+QKzcebadbWfHiaWWau09Alo/WmoAXe+SzWwMcouUl5dY9r6/xswqsblHOqjqYo/6KGypjqUZIdHEYxMjJD9CcSyPp4w3/lrY2M4E3WfvQo2MgwytJQxnbwpS9l2WkcF/zMOVzOzPTAjS4516zsMPsj58pp9TmHRybIGHBd8j9jVjqh2Enwm8c21k9+rJYOvhStJ298L2OrhxMubK3X9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmfCGkq31scRroXJnt2yI+gDaIyg78GPeC+5BpF9yFw=;
 b=BX/9CzwCExr5UCXCS6yrpFZQDHx+HtS1R0BniRU3Zy68wqPyTh22b1zug6XzDw2FIx+bM+YvhpzFuIeSR+Dxdp6sHBeF5PvF3h0gmDPymdfgUtjD88XQpRKlitoW391lrepaTkQPrT6DNC8wFbV4Jkze/N2sUjfaEw2s5B0zRzw=
Received: from DM6PR05MB6890.namprd05.prod.outlook.com (52.132.248.88) by
 DM6PR05MB4585.namprd05.prod.outlook.com (20.176.79.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:46:10 +0000
Received: from DM6PR05MB6890.namprd05.prod.outlook.com
 ([fe80::a8ea:6419:e3c5:ae00]) by DM6PR05MB6890.namprd05.prod.outlook.com
 ([fe80::a8ea:6419:e3c5:ae00%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 11:46:10 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:45:31 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:31 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:7:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 11:45:30 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 4/5] qtnfmac: assign each wiphy to its own virtual platform
 device
Thread-Topic: [PATCH 4/5] qtnfmac: assign each wiphy to its own virtual
 platform device
Thread-Index: AQHV4mMYRBFgSK3BiESW42L3aWadlw==
Date:   Thu, 13 Feb 2020 11:45:31 +0000
Message-ID: <20200213114518.4415-5-sergey.matyukevich.os@quantenna.com>
References: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0129.eurprd05.prod.outlook.com
 (2603:10a6:7:28::16) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 835a532c-ee5d-4b42-d4fb-08d7b07a3aa2
x-ms-traffictypediagnostic: SN6PR05MB5597:|DM6PR05MB4585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB559705164DF75558B32343A2A31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:46:07 AM
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39850400004)(366004)(189003)(199004)(7696005)(5660300002)(8936002)(86362001)(52116002)(26005)(81156014)(956004)(81166006)(2616005)(66446008)(66556008)(66946007)(8676002)(186003)(16526019)(66476007)(64756008)(2906002)(6916009)(4326008)(6486002)(316002)(36756003)(1076003)(107886003)(478600001)(71200400001)(103116003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4585;H:DM6PR05MB6890.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRH+6PhzyYndwm15pRgBpWnP3XeIzCfhoH18JDbitGUtR6UsBnL+G6KRZ/ISn5j5nHbgcxCJXocOJz0L4X/RgxisGX5VsBtzT+RY9igQDwzYbwNjb8GzNlv3DUdPa493u90KSv+hnpBy1jSzAFvLw8MvEdN0Q4to6MAL1pHyMcFGUi93TByKxlx01pTrR272pjB3gjW44R3AMnkxTntyVw6wk/cXM3lCIh6C+9d9RkYarLcNMjTwPhaiyLkj9EqmSvUWQnzVuuG7SmUomTGIWK7UA0t+DQD4E9HRwDG6/f7rnhwLU2ktfXEuStxFA/VzXWRg8s/w2Lq5o5K8HrXyPz7IIl0fS2QhD4jaqGhZZiDeBvI5cITF+iYw5XBubPrT0+jp5LAwKmA82SK08K7BKTSXH6jxRtr+0jcLLbBGWI6x8DhIuUzD4s77tlqCwwDj
x-ms-exchange-antispam-messagedata: ezKSxA/5d6HZmomRPNLNTIAeVKDqg1owDoQGKyzMLaJLEm96XuQlSo1TiNx/FAkY3msF4Qs2ciiCWV1Fzd7gQNeEqSRZxxe5MNSnn+62SvTQhc6vRXmpNjlRs9z11ClpmKLpbQTRDvMHVnvrC25Tnw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835a532c-ee5d-4b42-d4fb-08d7b07a3aa2
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zgwjaqi42+dKlIQDo22vj5p4DHUhUgWUeIfzybrYWlSgXDLLzQGwpL4qbtsealKp6ttlP4Vsb72BCZdD+3oSlDNsJttOrVs2joiIrxBkh1QuM9nE1c/oQPeAB/Ec85+UL3nfiHyjS9iM6bPsFuO98ZIm15f9m+fcK0Vg3lMuopbioSqaMffxQ4oAj1duDLT/7Cg4yds8BRQa8o4MRaHGCd20Sr8UqNPqy7gcg7waQkQ=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:46:10.6969
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130093
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Quantenna Pearl device exposes multiple (up to 3) radio interfaces under
single PCIe function. So far all the wiphy devices were attached to the
same pcie device. As a result, all different wireless network devices
were reported under the same sysfs directory for pcie device, e.g.:

$ ls  /sys/class/net/wlan0/device/net/
  wlan0 wlan1

It turns out that such behavior may confuse various users of wireless
subsystem. For instance, it turned out to be the case for:
- Linux init systems, e.g. for renaming based on parent device
- OpenWRT configuration scripts

Suggested solution is to add an intermediate virtual platform device
for each radio interface.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |  8 ++++++--
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 18 ++++++++++++++----
 drivers/net/wireless/quantenna/qtnfmac/core.h     |  5 ++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index 722d5caefe3c..018d3ed75fda 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -1061,7 +1061,8 @@ static void qtnf_cfg80211_reg_notifier(struct wiphy *=
wiphy,
 	}
 }
=20
-struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus)
+struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus,
+				  struct platform_device *pdev)
 {
 	struct wiphy *wiphy;
=20
@@ -1076,7 +1077,10 @@ struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *b=
us)
 	if (!wiphy)
 		return NULL;
=20
-	set_wiphy_dev(wiphy, bus->dev);
+	if (pdev)
+		set_wiphy_dev(wiphy, &pdev->dev);
+	else
+		set_wiphy_dev(wiphy, bus->dev);
=20
 	return wiphy;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 9e666fac8b5f..eea777f8acea 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -431,18 +431,28 @@ static void qtnf_vif_send_data_high_pri(struct work_s=
truct *work)
 static struct qtnf_wmac *qtnf_core_mac_alloc(struct qtnf_bus *bus,
 					     unsigned int macid)
 {
+	struct platform_device *pdev =3D NULL;
+	struct qtnf_wmac *mac;
 	struct qtnf_vif *vif;
 	struct wiphy *wiphy;
-	struct qtnf_wmac *mac;
 	unsigned int i;
=20
-	wiphy =3D qtnf_wiphy_allocate(bus);
+	if (bus->hw_info.num_mac > 1) {
+		pdev =3D platform_device_register_data(bus->dev,
+						     dev_name(bus->dev),
+						     macid, NULL, 0);
+		if (IS_ERR(pdev))
+			return ERR_PTR(-EINVAL);
+	}
+
+	wiphy =3D qtnf_wiphy_allocate(bus, pdev);
 	if (!wiphy)
 		return ERR_PTR(-ENOMEM);
=20
 	mac =3D wiphy_priv(wiphy);
=20
 	mac->macid =3D macid;
+	mac->pdev =3D pdev;
 	mac->bus =3D bus;
 	mutex_init(&mac->mac_lock);
 	INIT_DELAYED_WORK(&mac->scan_timeout, qtnf_mac_scan_timeout);
@@ -493,7 +503,6 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct =
qtnf_vif *vif,
 	dev_net_set(dev, wiphy_net(wiphy));
 	dev->ieee80211_ptr =3D &vif->wdev;
 	ether_addr_copy(dev->dev_addr, vif->mac_addr);
-	SET_NETDEV_DEV(dev, wiphy_dev(wiphy));
 	dev->flags |=3D IFF_BROADCAST | IFF_MULTICAST;
 	dev->watchdog_timeo =3D QTNF_DEF_WDOG_TIMEOUT;
 	dev->tx_queue_len =3D 100;
@@ -505,7 +514,7 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct =
qtnf_vif *vif,
 	qdev_vif =3D netdev_priv(dev);
 	*((void **)qdev_vif) =3D vif;
=20
-	SET_NETDEV_DEV(dev, mac->bus->dev);
+	SET_NETDEV_DEV(dev, wiphy_dev(wiphy));
=20
 	ret =3D register_netdevice(dev);
 	if (ret) {
@@ -561,6 +570,7 @@ static void qtnf_core_mac_detach(struct qtnf_bus *bus, =
unsigned int macid)
 		wiphy->bands[band] =3D NULL;
 	}
=20
+	platform_device_unregister(mac->pdev);
 	qtnf_mac_iface_comb_free(mac);
 	qtnf_mac_ext_caps_free(mac);
 	kfree(mac->macinfo.wowlan);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index b993f9ca14c5..269ce12cf8bf 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -20,6 +20,7 @@
 #include <linux/ctype.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/platform_device.h>
=20
 #include "qlink.h"
 #include "trans.h"
@@ -107,6 +108,7 @@ struct qtnf_wmac {
 	struct mutex mac_lock;	/* lock during wmac speicific ops */
 	struct delayed_work scan_timeout;
 	struct ieee80211_regdomain *rd;
+	struct platform_device *pdev;
 };
=20
 struct qtnf_hw_info {
@@ -127,7 +129,8 @@ void qtnf_mac_iface_comb_free(struct qtnf_wmac *mac);
 void qtnf_mac_ext_caps_free(struct qtnf_wmac *mac);
 bool qtnf_slave_radar_get(void);
 bool qtnf_dfs_offload_get(void);
-struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus);
+struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus,
+				  struct platform_device *pdev);
 int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *priv,
 			 const char *name, unsigned char name_assign_type);
 void qtnf_main_work_queue(struct work_struct *work);
--=20
2.11.0

