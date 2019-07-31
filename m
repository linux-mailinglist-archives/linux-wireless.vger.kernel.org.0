Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34097CF2E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfGaU6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 16:58:23 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46278 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfGaU6X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 16:58:23 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Dqb1wi7Q1zOxUSU43TIIHECFUsxGLoO9OhUbXmc24OjH3lvBUtdElqMsL6xmjstRxrkBaI6tsA
 icuxLVt8rRx6Sbrg2Na4V8gRZO8IVchOmDnJhkWh7GC+iehEYYDtZXZPIOMcpqQS4nnEVJ3d1e
 evSzYqVpO43Haweh1JQT8KuimItcKqzK8282rD2dVYCN8Prm2G+lwiFTIBJjvYz90xLXU7W8qx
 xpAv0Ie/yamsP9gSt2ef4Aa15zkeGyIzp5BV004/cFx6H/fxyBwdXMlENnrgM+eip4oI6cZkql
 7Zo=
X-IronPort-AV: E=Sophos;i="5.64,331,1559545200"; 
   d="scan'208";a="44870898"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 13:58:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 13:58:21 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 13:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtZqrMfxiZML2U99eDO33hOBt1S77ZkViUel7kmOtYEfIeuAtMvfa9hEUe9tknmQ3avbRodlcp0eIFY7ettQqCCxzgpVRIZphy2ATEaeBP1BU9PQzreIIxsZExkwgOwADxF6hhLVhex8/4Ik5myovoyUnj8w8rz6fE3H2Ib1l9KXkUJ7hs+G4HuGbq27v/JGi9+MLAxo/q59/gfozQggwU96qwb9Hibwai79F74s3PSlVEaXpu3AFaL+A17Q1MSifx41FjXsreV+bJNMa4+ErvqPRkd81qRQLapXu/8B9Wz4EPlplhCWY3hT0BVP3D16O2LSda2XZbyr4Oeoe9aV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRdY4FdATr43/b5X5M0SWoSaMDSaf5YicrEZVRuz/HM=;
 b=E1Vk34vN5/PXSN16/h+4X5BPFqJ1Ti/kO7rY5MV2pLueLsjz9O0rK/Hh26Hy/Ld95ypegcQr4xUmfWDzzdN7ZN3lwai8Zxa0ZgwxXFfalxiIrya7uUUTaX0uHfsZrVTKUTQJYt0QN8963RMjuSTe1+PipGYNPXFsiQjoSNO4H1XLxXFDah+sqRE4CYzDYLn3iScCspKZfz21CLlER84PzYY/CDnUC+CJDcXwRhkdfI4IwjUTjs00lIgBQoRZ2n1v7X2qn1CY74QnSLM3iduE+mCRMOwx7qDJTcGZfwPwigIJXiL+g4tXDjMyL0iHlAPqmrPFEv3k3CM/TrVOpN/Jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRdY4FdATr43/b5X5M0SWoSaMDSaf5YicrEZVRuz/HM=;
 b=vnmdp5UBnfC/qjKVndzOODto9Yxpjt7DrnSjgan7h6HA4YN29Q4j3l2opRrZK20FbgQPaZ+EenJvwrF2Y7exGXkQ6WrAdun1GO9JCLQ30uLD6YLILqB+cD8L+zUE/KB/hrC/vQjeg8+9bdIqwNy4+7+w3vMFRmIjzIoKGrvrAeA=
Received: from DM5PR11MB1371.namprd11.prod.outlook.com (10.168.101.145) by
 DM5PR11MB1660.namprd11.prod.outlook.com (10.172.34.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 31 Jul 2019 20:58:19 +0000
Received: from DM5PR11MB1371.namprd11.prod.outlook.com
 ([fe80::751e:92c:b069:7c65]) by DM5PR11MB1371.namprd11.prod.outlook.com
 ([fe80::751e:92c:b069:7c65%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 20:58:19 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: merge drv_handle and operation_mode wids
Thread-Topic: [PATCH] staging: wilc1000: merge drv_handle and operation_mode
 wids
Thread-Index: AQHVR+Kuc+YMxhqSE0KT1LYAs8ywDg==
Date:   Wed, 31 Jul 2019 20:58:19 +0000
Message-ID: <20190731205245.6590-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To DM5PR11MB1371.namprd11.prod.outlook.com
 (2603:10b6:3:7::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d03cc5-8e76-427f-1904-08d715f9d0fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB1660;
x-ms-traffictypediagnostic: DM5PR11MB1660:
x-microsoft-antispam-prvs: <DM5PR11MB166015BAB038F0871EDB50DB8DDF0@DM5PR11MB1660.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(50226002)(53936002)(1076003)(14444005)(256004)(25786009)(8676002)(107886003)(14454004)(86362001)(2906002)(54906003)(99286004)(316002)(6512007)(7736002)(6116002)(64756008)(3846002)(6436002)(305945005)(5640700003)(476003)(6506007)(6916009)(486006)(5660300002)(186003)(71200400001)(66066001)(2616005)(71190400001)(8936002)(478600001)(102836004)(4326008)(81166006)(66946007)(68736007)(66556008)(66476007)(2501003)(386003)(66446008)(26005)(81156014)(2351001)(52116002)(6486002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1660;H:DM5PR11MB1371.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: evB2+wRxmDR0qQc1busmWi3sEN5H4xYIcBviEJbaOGv8t96frR1LWvF49GJ/CMREhDg4r1Eb2Z+b5khR3aArogPZyrJ6cIrzIX3BKRslFpMObGs7ZY7lpUIQs3EvAsQNT/9PGZXDR+NYEAcCmqlCFUY9Pc/PCDHCHc6xTSuPiehB5evLz23kSRd5IDksp4ZQOs6OrSoXn1dhXDWUeGAMEHthN1AMxQf2z6BlxKD760WWd4XN98Wi4evkj/taxBKj62z9qk64YyOF9VgdOXnzruKbszVMCEW7izP36vV1ux8cJVYUHKRewOVreg4CwGoVNSBlqvfe1rGYUialeEjySBLXO/e3jUwHKNrnKSv97m00+Eb/gIVWea+l+qTcDKWboiS79/6iSNq38CsD/4MtziNvN7x4GJ2rkH+i2MMJJ4w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d03cc5-8e76-427f-1904-08d715f9d0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 20:58:19.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1660
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

wilc_set_wfi_drv_handler and wilc_set_operation_mode sends the same
parameters to the FW, so it's better to combine them together.

Kept wilc_set_wfi_drv_handler implementation since it sends all the
required parameters, and renamed it to wilc_set_operation_mode to be
more descriptive.

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_hif.c           | 29 ++-----------------
 drivers/staging/wilc1000/wilc_hif.h           |  5 ++--
 drivers/staging/wilc1000/wilc_netdev.c        |  6 ++--
 .../staging/wilc1000/wilc_wfi_cfgoperations.c | 24 +++++++--------
 drivers/staging/wilc1000/wilc_wlan_if.h       |  3 +-
 5 files changed, 20 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index f8646ea3b0c4..ca252a43cd8c 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -1409,18 +1409,15 @@ int wilc_set_mac_chnl_num(struct wilc_vif *vif, u8 =
channel)
 	return result;
 }
=20
-int wilc_set_wfi_drv_handler(struct wilc_vif *vif, int index, u8 mode,
-			     u8 ifc_id)
+int wilc_set_operation_mode(struct wilc_vif *vif, int index, u8 mode,
+			    u8 ifc_id)
 {
 	struct wid wid;
-	struct host_if_drv *hif_drv =3D vif->hif_drv;
 	int result;
 	struct wilc_drv_handler drv;
=20
-	if (!hif_drv)
-		return -EFAULT;
=20
-	wid.id =3D WID_SET_DRV_HANDLER;
+	wid.id =3D WID_SET_OPERATION_MODE;
 	wid.type =3D WID_STR;
 	wid.size =3D sizeof(drv);
 	wid.val =3D (u8 *)&drv;
@@ -1435,26 +1432,6 @@ int wilc_set_wfi_drv_handler(struct wilc_vif *vif, i=
nt index, u8 mode,
 	return result;
 }
=20
-int wilc_set_operation_mode(struct wilc_vif *vif, u32 mode)
-{
-	struct wid wid;
-	struct wilc_op_mode op_mode;
-	int result;
-
-	wid.id =3D WID_SET_OPERATION_MODE;
-	wid.type =3D WID_INT;
-	wid.size =3D sizeof(op_mode);
-	wid.val =3D (u8 *)&op_mode;
-
-	op_mode.mode =3D cpu_to_le32(mode);
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev, "Failed to set operation mode\n");
-
-	return result;
-}
-
 s32 wilc_get_inactive_time(struct wilc_vif *vif, const u8 *mac, u32 *out_v=
al)
 {
 	struct wid wid;
diff --git a/drivers/staging/wilc1000/wilc_hif.h b/drivers/staging/wilc1000=
/wilc_hif.h
index be1d2497cde9..3bc305151651 100644
--- a/drivers/staging/wilc1000/wilc_hif.h
+++ b/drivers/staging/wilc1000/wilc_hif.h
@@ -219,9 +219,8 @@ int wilc_remain_on_channel(struct wilc_vif *vif, u64 co=
okie,
 			   void *user_arg);
 int wilc_listen_state_expired(struct wilc_vif *vif, u64 cookie);
 void wilc_frame_register(struct wilc_vif *vif, u16 frame_type, bool reg);
-int wilc_set_wfi_drv_handler(struct wilc_vif *vif, int index, u8 mode,
-			     u8 ifc_id);
-int wilc_set_operation_mode(struct wilc_vif *vif, u32 mode);
+int wilc_set_operation_mode(struct wilc_vif *vif, int index, u8 mode,
+			    u8 ifc_id);
 int wilc_get_statistics(struct wilc_vif *vif, struct rf_info *stats);
 void wilc_resolve_disconnect_aberration(struct wilc_vif *vif);
 int wilc_get_vif_idx(struct wilc_vif *vif);
diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1=
000/wilc_netdev.c
index 68129a0ba55f..bd848fdf7f8a 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -626,10 +626,8 @@ static int wilc_mac_open(struct net_device *ndev)
 		return ret;
 	}
=20
-	wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif), vif->iftype,
-				 vif->idx);
-	wilc_set_operation_mode(vif, vif->iftype);
-
+	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+				 vif->iftype, vif->idx);
 	wilc_get_mac_address(vif, mac_add);
 	netdev_dbg(ndev, "Mac address: %pM\n", mac_add);
 	ether_addr_copy(ndev->dev_addr, mac_add);
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index e2d9efed36b0..cf661e8ab1c8 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1419,7 +1419,8 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 		if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE)
 			wilc_wfi_deinit_mon_interface(wl, true);
 		vif->iftype =3D WILC_STATION_MODE;
-		wilc_set_operation_mode(vif, WILC_STATION_MODE);
+		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+					 WILC_STATION_MODE, vif->idx);
=20
 		memset(priv->assoc_stainfo.sta_associated_bss, 0,
 		       WILC_MAX_NUM_STA * ETH_ALEN);
@@ -1431,8 +1432,8 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 		priv->wdev.iftype =3D type;
 		vif->monitor_flag =3D 0;
 		vif->iftype =3D WILC_CLIENT_MODE;
-		wilc_set_operation_mode(vif, WILC_STATION_MODE);
-
+		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+					 WILC_STATION_MODE, vif->idx);
 		break;
=20
 	case NL80211_IFTYPE_AP:
@@ -1440,18 +1441,17 @@ static int change_virtual_intf(struct wiphy *wiphy,=
 struct net_device *dev,
 		priv->wdev.iftype =3D type;
 		vif->iftype =3D WILC_AP_MODE;
=20
-		if (wl->initialized) {
-			wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif),
-						 0, vif->idx);
-			wilc_set_operation_mode(vif, WILC_AP_MODE);
-		}
+		if (wl->initialized)
+			wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+						 WILC_AP_MODE, vif->idx);
 		break;
=20
 	case NL80211_IFTYPE_P2P_GO:
-		wilc_set_operation_mode(vif, WILC_AP_MODE);
 		dev->ieee80211_ptr->iftype =3D type;
 		priv->wdev.iftype =3D type;
 		vif->iftype =3D WILC_GO_MODE;
+		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+					WILC_AP_MODE, vif->idx);
 		break;
=20
 	default:
@@ -1659,15 +1659,15 @@ static int del_virtual_intf(struct wiphy *wiphy, st=
ruct wireless_dev *wdev)
 	vif->monitor_flag =3D 0;
=20
 	mutex_lock(&wl->vif_mutex);
-	wilc_set_wfi_drv_handler(vif, 0, 0, 0);
-	for (i =3D vif->idx; i < wl->vif_num ; i++) {
+	wilc_set_operation_mode(vif, 0, 0, 0);
+	for (i =3D vif->idx; i < wl->vif_num; i++) {
 		if ((i + 1) >=3D wl->vif_num) {
 			wl->vif[i] =3D NULL;
 		} else {
 			vif =3D wl->vif[i + 1];
 			vif->idx =3D i;
 			wl->vif[i] =3D vif;
-			wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif),
+			wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
 						 vif->iftype, vif->idx);
 		}
 	}
diff --git a/drivers/staging/wilc1000/wilc_wlan_if.h b/drivers/staging/wilc=
1000/wilc_wlan_if.h
index b89d0e0f04cc..70eac586f80c 100644
--- a/drivers/staging/wilc1000/wilc_wlan_if.h
+++ b/drivers/staging/wilc1000/wilc_wlan_if.h
@@ -724,7 +724,6 @@ enum {
 	/* NMAC Integer WID list */
 	/* Custom Integer WID list */
 	WID_GET_INACTIVE_TIME		=3D 0x2084,
-	WID_SET_OPERATION_MODE		=3D 0X2086,
 	/* EMAC String WID list */
 	WID_SSID			=3D 0x3000,
 	WID_FIRMWARE_VERSION		=3D 0x3001,
@@ -755,9 +754,9 @@ enum {
 	WID_MODEL_NAME			=3D 0x3027, /*Added for CAPI tool */
 	WID_MODEL_NUM			=3D 0x3028, /*Added for CAPI tool */
 	WID_DEVICE_NAME			=3D 0x3029, /*Added for CAPI tool */
-	WID_SET_DRV_HANDLER		=3D 0x3079,
=20
 	/* NMAC String WID list */
+	WID_SET_OPERATION_MODE		=3D 0x3079,
 	WID_11N_P_ACTION_REQ		=3D 0x3080,
 	WID_HUT_TEST_ID			=3D 0x3081,
 	WID_PMKID_INFO			=3D 0x3082,
--=20
2.17.1

