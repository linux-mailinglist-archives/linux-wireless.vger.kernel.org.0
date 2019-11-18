Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8B100051
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKRI07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:26:59 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:10636 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfKRI06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:26:58 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8NxTe015074
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:26:56 -0700
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2052.outbound.protection.outlook.com [104.47.48.52])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wad7bc1rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7uJWuqebZd80X91kWSflonD3B+T8Q1i8lRDLOKGHV9DxhSopgAzXpcDsIHVg6dNuzWWnhjXPKRfvUtUDILGBKk9FcJhKJ0Gojwpv/p4pSTuhLDL59BTUjuoctHiJmBtYd/6Dg04xAYa9JWP5cxqZEWENR5iZwRUpckia15P5wXtJKDJ4VFiV0BlsNKFRwOGRBhlqWbf4UiRBf40NoG8274CCDDs8Q/3io0wAJ4dBlb5BKVUGw0PrwpFwfN97Kjd1Qilk1+Yc1SjIQgNeISULnpOqOBNRiPJU2W+fKXYjLvlIyxUhOpQimKCHHlzTnKpp6uDNSeIdLh1rDbXaMKUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdvrTNHhKKMnUidpFvPhzQn9hXJVCe3h6fBbTrVZdVI=;
 b=YHAYT57YhQUFembzDaApdjKJKkM3tmEaGysrIM1C7ZD6VcwjZ//eEdy4hTf9t7KFhhsOkGp6liZrIvnbQDlrzlyzQNsMa+5Iugus+8ZiUPxab7QNCEEoyINs4h2fgF+0gUP0Bn7Pw6GmGcT7sN1CJfzIB/Z5Q+IFiYVS9ALWvJoXRTbPw4g42oddBLU9VfFNYnybNBMphX7F/ZXes+BRLkcpjoTC5AgPglZWzD+GugOnxojSQ4UTsNEQ9L7W4TGr6kdmomoHiSgJ5jvcV9sP2Wq4GUqXJ1VSqurJ9IHM3CrutXN1zLAGHFJdGo4Rv1LdA8ATiYLBDGXgvpd1RAmySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdvrTNHhKKMnUidpFvPhzQn9hXJVCe3h6fBbTrVZdVI=;
 b=aj8tntAqCKIvs0uGQrrf5YI8Gs7hXRfwrAI1PPELIccTqPIFw+V78coMiervBJ4yhTHehXS/8zpgk3AayImqrq4qEONsoSW4UQwNMIud2qNSyJ49GIOKGGE+Odd5xTsy7aA+Sv4dZnHuzhy2NfCXuQF+dbgD9hhobdy9Pereip8=
Received: from CY4PR0501MB3763.namprd05.prod.outlook.com (52.132.102.159) by
 CY4PR0501MB3730.namprd05.prod.outlook.com (52.132.99.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Mon, 18 Nov 2019 08:26:53 +0000
Received: from CY4PR0501MB3763.namprd05.prod.outlook.com
 ([fe80::8c7a:969e:4ab7:ffc5]) by CY4PR0501MB3763.namprd05.prod.outlook.com
 ([fe80::8c7a:969e:4ab7:ffc5%4]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:26:53 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:06 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:06 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 2/7] qtnfmac: track broadcast domain of each interface
Thread-Topic: [PATCH 2/7] qtnfmac: track broadcast domain of each interface
Thread-Index: AQHVnelnRWZLzXsMUkGxyb/eIIRpag==
Date:   Mon, 18 Nov 2019 08:23:06 +0000
Message-ID: <20191118082255.6032-3-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 683cef50-8d3d-4d13-2ae7-08d76c0089b2
x-ms-traffictypediagnostic: SN6PR05MB6320:|CY4PR0501MB3730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB6320142AB7589C1559BE2D25A34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:26:50 AM
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39840400004)(199004)(189003)(478600001)(6116002)(476003)(2616005)(50226002)(25786009)(11346002)(3846002)(436003)(71200400001)(446003)(2501003)(71190400001)(102836004)(2351001)(6506007)(386003)(6512007)(8676002)(5640700003)(6436002)(316002)(486006)(103116003)(6486002)(36756003)(76176011)(99286004)(54906003)(1076003)(66066001)(2906002)(5660300002)(107886003)(86362001)(256004)(14444005)(8936002)(4326008)(52116002)(186003)(66946007)(66476007)(81156014)(81166006)(66446008)(66556008)(64756008)(5024004)(7736002)(14454004)(6916009)(305945005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0501MB3730;H:CY4PR0501MB3763.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1z1Kv1WrKH1Igs14ea1nnnzw2A3BLP4F45nTnBfq0uIn5PAfXa4dYJwOAtaoOBpX2TpkPIRp4/OyfcVd4xEPo0+zaT6gCYDkSIQuDKPn2ZP6+zLPwJsCF5Rfv+uzm5hqOOspRzrAe91rDNxcQoHk7T5BXE8RHxJE0XfJ/impdU5+Bc1T1SdG5ZF2DY1dhyKGGtg5R/XeB2pqAZYUQPExrPEAtiaNoeNDnv45MJ/A9f/1Oy3QxMC//omvbSZo4TvorYdJrgKpwWaN4/wXwQlgXw8IYVpt5LbJbk2N9LOcRDM8M4u7M3XUb/eIL8iuzOb+wOUuiYf6TXV8pPe+NmVIrFPhTiRZ311dg2YZloicIkVYECOPuEWrZZmbJGxeCbEAQEqffG2ekXHWlJOlDzLY9pRfduW8Fpr6RELim2KMpeDbxtFQN3HYS+1Qs9ojSuI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683cef50-8d3d-4d13-2ae7-08d76c0089b2
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvX0Q4Djmh9euxTe3fF3TRZltKU++AWfn7aMBeme6GK0C71AlPA6D98TaPPJiSutsuJP0iRbOCFUjnfTy8nZSRIP6iiDndTyUpdE4v6+Dte5xs5cX8XRtWYQCmlJc5jN7xybcENgQnZ/J7AdExF4OlVgWI6q5sVAEGcRF+eYrE1HlHwlydApodiTbfOdlVKKq3EsyyHc4CXumPNelVv+2/OMI8IiB52K7PXTGjehqNQ=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:26:53.5410
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0501MB3730
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180075
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

If firmware reports that it supports hardware switch capabilities,
driver needs to track and notify device whenever broadcast domain
of a particular network device changes (ie. whenever it's upper
master device changes).

Firmware needs a unique ID to tell broadcast domains from each other
which is an opaque number otherwise. For that purpose we can use
netspace:ifidx pair to uniquely identify each broadcast domain:
 - if netdev is not part of a bridge, then use it's own ifidx
   as a broadcast domain ID
 - if netdev is part of a bridge, then use bridge netdev ifidx
   as broadcast domain ID

Firmware makes sure that packets are only forwarded between
interfaces marked with the same broadcast domain ID.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/bus.h      |  1 +
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |  9 ++++
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 32 ++++++++++++
 drivers/net/wireless/quantenna/qtnfmac/commands.h |  1 +
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 64 +++++++++++++++++++=
++++
 drivers/net/wireless/quantenna/qtnfmac/core.h     |  1 +
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 41 +++++++++++++++
 7 files changed, 149 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wir=
eless/quantenna/qtnfmac/bus.h
index 7cea08f71838..4c6eca344a09 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -54,6 +54,7 @@ struct qtnf_bus {
 	struct work_struct event_work;
 	struct mutex bus_lock; /* lock during command/event processing */
 	struct dentry *dbg_dir;
+	struct notifier_block netdev_nb;
 	/* bus private data */
 	char bus_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index 4f02159a69db..59d089e092f9 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -248,6 +248,15 @@ static struct wireless_dev *qtnf_add_virtual_intf(stru=
ct wiphy *wiphy,
 		goto error_del_vif;
 	}
=20
+	if (mac->bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) {
+		ret =3D qtnf_cmd_netdev_changeupper(vif, vif->netdev->ifindex);
+		if (ret) {
+			unregister_netdevice(vif->netdev);
+			vif->netdev =3D NULL;
+			goto error_del_vif;
+		}
+	}
+
 	vif->wdev.netdev =3D vif->netdev;
 	return &vif->wdev;
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 61bda34e2ac2..cbc56464220e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -2756,3 +2756,35 @@ int qtnf_cmd_send_wowlan_set(const struct qtnf_vif *=
vif,
 	qtnf_bus_unlock(bus);
 	return ret;
 }
+
+int qtnf_cmd_netdev_changeupper(const struct qtnf_vif *vif, int br_domain)
+{
+	struct qtnf_bus *bus =3D vif->mac->bus;
+	struct sk_buff *cmd_skb;
+	struct qlink_cmd_ndev_changeupper *cmd;
+	int ret;
+
+	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(vif->mac->macid, vif->vifid,
+					    QLINK_CMD_NDEV_EVENT,
+					    sizeof(*cmd));
+	if (!cmd_skb)
+		return -ENOMEM;
+
+	pr_debug("[VIF%u.%u] set broadcast domain to %d\n",
+		 vif->mac->macid, vif->vifid, br_domain);
+
+	cmd =3D (struct qlink_cmd_ndev_changeupper *)cmd_skb->data;
+	cmd->nehdr.event =3D cpu_to_le16(QLINK_NDEV_EVENT_CHANGEUPPER);
+	cmd->upper_type =3D QLINK_NDEV_UPPER_TYPE_BRIDGE;
+	cmd->br_domain =3D cpu_to_le32(br_domain);
+
+	qtnf_bus_lock(bus);
+	ret =3D qtnf_cmd_send(bus, cmd_skb);
+	qtnf_bus_unlock(bus);
+
+	if (ret)
+		pr_err("[VIF%u.%u] failed to set broadcast domain\n",
+		       vif->mac->macid, vif->vifid);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.h b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.h
index e0de65261213..761755bf9ede 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.h
@@ -75,5 +75,6 @@ int qtnf_cmd_set_tx_power(const struct qtnf_vif *vif,
 			  enum nl80211_tx_power_setting type, int mbm);
 int qtnf_cmd_send_wowlan_set(const struct qtnf_vif *vif,
 			     const struct cfg80211_wowlan *wowl);
+int qtnf_cmd_netdev_changeupper(const struct qtnf_vif *vif, int br_domain)=
;
=20
 #endif /* QLINK_COMMANDS_H_ */
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 9ccc17ad1176..3ba19a966c7f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -613,6 +613,12 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, =
unsigned int macid)
 		goto error_del_vif;
 	}
=20
+	if (bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) {
+		ret =3D qtnf_cmd_netdev_changeupper(vif, vif->netdev->ifindex);
+		if (ret)
+			goto error;
+	}
+
 	pr_debug("MAC%u initialized\n", macid);
=20
 	return 0;
@@ -625,6 +631,54 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, =
unsigned int macid)
 	return ret;
 }
=20
+bool qtnf_netdev_is_qtn(const struct net_device *ndev)
+{
+	return ndev->netdev_ops =3D=3D &qtnf_netdev_ops;
+}
+
+static int qtnf_core_netdevice_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	struct net_device *ndev =3D netdev_notifier_info_to_dev(ptr);
+	const struct netdev_notifier_changeupper_info *info;
+	struct qtnf_vif *vif;
+	int br_domain;
+	int ret =3D 0;
+
+	if (!qtnf_netdev_is_qtn(ndev))
+		return NOTIFY_DONE;
+
+	if (!net_eq(dev_net(ndev), &init_net))
+		return NOTIFY_OK;
+
+	vif =3D qtnf_netdev_get_priv(ndev);
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		info =3D ptr;
+
+		if (!netif_is_bridge_master(info->upper_dev))
+			break;
+
+		pr_debug("[VIF%u.%u] change bridge: %s %s\n",
+			 vif->mac->macid, vif->vifid,
+			 netdev_name(info->upper_dev),
+			 info->linking ? "add" : "del");
+
+		if (info->linking)
+			br_domain =3D info->upper_dev->ifindex;
+		else
+			br_domain =3D ndev->ifindex;
+
+		ret =3D qtnf_cmd_netdev_changeupper(vif, br_domain);
+		break;
+	default:
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
 int qtnf_core_attach(struct qtnf_bus *bus)
 {
 	unsigned int i;
@@ -685,6 +739,15 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		}
 	}
=20
+	if (bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) {
+		bus->netdev_nb.notifier_call =3D qtnf_core_netdevice_event;
+		ret =3D register_netdevice_notifier(&bus->netdev_nb);
+		if (ret) {
+			pr_err("failed to register netdev notifier: %d\n", ret);
+			goto error;
+		}
+	}
+
 	bus->fw_state =3D QTNF_FW_STATE_RUNNING;
 	return 0;
=20
@@ -698,6 +761,7 @@ void qtnf_core_detach(struct qtnf_bus *bus)
 {
 	unsigned int macid;
=20
+	unregister_netdevice_notifier(&bus->netdev_nb);
 	qtnf_bus_data_rx_stop(bus);
=20
 	for (macid =3D 0; macid < QTNF_MAX_MAC; macid++)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index e3feea31191e..75b70f0c2b8e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -153,6 +153,7 @@ void qtnf_virtual_intf_cleanup(struct net_device *ndev)=
;
 void qtnf_netdev_updown(struct net_device *ndev, bool up);
 void qtnf_scan_done(struct qtnf_wmac *mac, bool aborted);
 struct dentry *qtnf_get_debugfs_dir(void);
+bool qtnf_netdev_is_qtn(const struct net_device *ndev);
=20
 static inline struct qtnf_vif *qtnf_netdev_get_priv(struct net_device *dev=
)
 {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 59c69c0a6e06..18b2ddf39ef8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -59,6 +59,7 @@ struct qlink_msg_header {
  * @QLINK_HW_CAPAB_SCAN_RANDOM_MAC_ADDR: device supports MAC Address
  *	Randomization in probe requests.
  * @QLINK_HW_CAPAB_OBSS_SCAN: device can perform OBSS scanning.
+ * @QLINK_HW_CAPAB_HW_BRIDGE: device has hardware switch capabilities.
  */
 enum qlink_hw_capab {
 	QLINK_HW_CAPAB_REG_UPDATE		=3D BIT(0),
@@ -69,6 +70,7 @@ enum qlink_hw_capab {
 	QLINK_HW_CAPAB_OBSS_SCAN		=3D BIT(5),
 	QLINK_HW_CAPAB_SCAN_DWELL		=3D BIT(6),
 	QLINK_HW_CAPAB_SAE			=3D BIT(8),
+	QLINK_HW_CAPAB_HW_BRIDGE		=3D BIT(9),
 };
=20
 enum qlink_iface_type {
@@ -219,6 +221,8 @@ struct qlink_sta_info_state {
  * @QLINK_CMD_START_CAC: start radar detection procedure on a specified ch=
annel.
  * @QLINK_CMD_TXPWR: get or set current channel transmit power for
  *	the specified MAC.
+ * @QLINK_CMD_NDEV_EVENT: signalizes changes made with a corresponding net=
work
+ *	device.
  */
 enum qlink_cmd_type {
 	QLINK_CMD_FW_INIT		=3D 0x0001,
@@ -251,6 +255,7 @@ enum qlink_cmd_type {
 	QLINK_CMD_DEL_STA		=3D 0x0052,
 	QLINK_CMD_SCAN			=3D 0x0053,
 	QLINK_CMD_CHAN_STATS		=3D 0x0054,
+	QLINK_CMD_NDEV_EVENT		=3D 0x0055,
 	QLINK_CMD_CONNECT		=3D 0x0060,
 	QLINK_CMD_DISCONNECT		=3D 0x0061,
 	QLINK_CMD_PM_SET		=3D 0x0062,
@@ -771,6 +776,42 @@ struct qlink_cmd_wowlan_set {
 	u8 data[0];
 } __packed;
=20
+enum qlink_ndev_event_type {
+	QLINK_NDEV_EVENT_CHANGEUPPER,
+};
+
+/**
+ * struct qlink_cmd_ndev_event - data for QLINK_CMD_NDEV_EVENT command
+ *
+ * @event: type of event, one of &enum qlink_ndev_event_type
+ */
+struct qlink_cmd_ndev_event {
+	struct qlink_cmd chdr;
+	__le16 event;
+	u8 rsvd[2];
+} __packed;
+
+enum qlink_ndev_upper_type {
+	QLINK_NDEV_UPPER_TYPE_NONE,
+	QLINK_NDEV_UPPER_TYPE_BRIDGE,
+};
+
+/**
+ * struct qlink_cmd_ndev_changeupper - data for QLINK_NDEV_EVENT_CHANGEUPP=
ER
+ *
+ * @br_domain: layer 2 broadcast domain ID that ndev is a member of
+ * @upper_type: type of upper device, one of &enum qlink_ndev_upper_type
+ */
+struct qlink_cmd_ndev_changeupper {
+	struct qlink_cmd_ndev_event nehdr;
+	__le64 flags;
+	__le32 br_domain;
+	__le32 netspace_id;
+	__le16 vlanid;
+	u8 upper_type;
+	u8 rsvd[1];
+} __packed;
+
 /* QLINK Command Responses messages related definitions
  */
=20
--=20
2.11.0

