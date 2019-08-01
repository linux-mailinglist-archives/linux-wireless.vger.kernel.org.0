Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313827E3ED
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfHAUPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 16:15:15 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:20237 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHAUPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 16:15:14 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: zQjdJZ+aKbJOPiKrXp98J+RcMeGPBM6aljDu3/GxVzVvjqoflhP88ehGrbDkT2YaI8qbp0n3nZ
 1icczom9PXFcT8sSZzsTxj9x9qB3Ai7Zx8mbZU83+kcRP25b/qSh5HjLCXn9n2gyRcE+BctOwc
 RyoXEzGgfMF5Xx8n/ZLp7tRIvKCVhJAVAnq6Ico/Cko/ZiLpxRfggRTo6Q1YFI27HwV1WurfxA
 0ftMNtBTb/p4HKDtUFgL7YocDk1kEjqyw3OhPRNqh28dpugDgl0KcJwGChdMdiBT8T430H5+AT
 xic=
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="40664135"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2019 13:15:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Aug 2019 13:15:12 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 1 Aug 2019 13:15:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHc7VA6bRDbeRBujFLYEn9ciIFiPchGfw1lnB4n+afTs70JCn+yr1qI7oEsJtVEkC1ZNmtCxkQejD+7PawFK5R+UUiWqfYgJEH8X+EIRfCr5R/71OjRYtGJR5a7p5/w4wWgXZhvmFZPOSuxA3f5CX+6pmgIZ45PizNdoYIVXdcQpq4wKRjqntCJoKybOka6ITXCHYMCXaaSR5vzFSuyjfFxR6Mqy20frPccnaD/VgBa/FtNTfU7YTOuMJDYPbJ72Nf1twPlKv7jXuSNz2ZnZDWbtAKZusAdsIqxqCshGNjxryQSPHLKC+leWKKeeQcJjuPbx6EIIle5aqtWpvaSe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5qdf/zvMDgxa/+TzcTLNliTmSCoi0Dy8C7wCtBUI1s=;
 b=m9Jus97SkPMr8Jb5J+4n+z7dqFMzvJSCleFHwqzR0Eb5ObhiN1BwJTs6iR1mgZ+PKhTkoxiVV4mzg60yZbyfUWiF5nGT4/opMs06AqSA0gi8aizGcHl/4rueEAvc0jDu3RymdPI0kOuXC995OZlRbc4saTs6e7mmrrEIW/sw1d3hKPm8m+xeXxf0ilqezTLXgNMyWCVPw7S64Y45bzfL61JhNgUQYLAVgt3lMT6MXRSmLIrSHRQn1TcZEjpBC79SM8zk6AFM2XzXjOtu8+hIMp7VDnaNvQvEYdUuU1hVRQg8fiw5hiM38xG42R7UZW/blwy8iIRONzDrYZgnmuG7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5qdf/zvMDgxa/+TzcTLNliTmSCoi0Dy8C7wCtBUI1s=;
 b=Ps8BjawmoM3nEHvqNQFadmzRPzQbjZ2MoTx4ouhSgjQwBA5gDizVSGO3QOUr7AM4toPMYVXxwO3vF/K31O5ZvEfSw9g5yZofB+hvDuhw5r083gxTH2A4FdiEkvjlEvZPqyLbXexUfXAXAf8tqKBqxtLxS6oFmZQIWZt6VW8C8rY=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1486.namprd11.prod.outlook.com (10.172.55.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Thu, 1 Aug 2019 20:15:11 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336%2]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 20:15:11 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH v2 1/2] staging: wilc1000: merge drv_handle and operation_mode
 wids
Thread-Topic: [PATCH v2 1/2] staging: wilc1000: merge drv_handle and
 operation_mode wids
Thread-Index: AQHVSKXS7pnT+nHwCUmwCSCtgUyn8g==
Date:   Thu, 1 Aug 2019 20:15:11 +0000
Message-ID: <20190801200909.12605-2-adham.abozaeid@microchip.com>
References: <20190801200909.12605-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190801200909.12605-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64117445-7ef2-47e3-dfea-08d716bcf4a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1486;
x-ms-traffictypediagnostic: MWHPR11MB1486:
x-microsoft-antispam-prvs: <MWHPR11MB148634798B4EDADD6805F4108DDE0@MWHPR11MB1486.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(189003)(199004)(8936002)(81166006)(8676002)(50226002)(54906003)(25786009)(6486002)(107886003)(6436002)(486006)(256004)(6916009)(14444005)(476003)(68736007)(446003)(11346002)(4326008)(66446008)(66476007)(102836004)(64756008)(2616005)(5640700003)(52116002)(66946007)(2501003)(14454004)(386003)(76176011)(66556008)(81156014)(86362001)(66066001)(2351001)(99286004)(6506007)(7736002)(305945005)(36756003)(316002)(5660300002)(6116002)(3846002)(478600001)(6512007)(26005)(71190400001)(186003)(1076003)(2906002)(71200400001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1486;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o+xCi8c+ukDOoQFw5IWybxGk7/+Z5FwnM6gN1N9USOGFcNxoW+46Ofu7i5ej3mmicaF3dCTxoq06YZ6FFCmhS/XQxKCVIK95bC5cTkNdQc9zOMxWjewUAdUZ3EZmwObd/ztDCO7b/E/h2PknA/JlvEWnV6AVehw7sF6U/AS4D/RDdR6H1OosorroV2E4mEpd+P+BQATUF6FXZzTp2/ElLVxTJBAVv+uBC9JX9LmgaBqLQv0rLbDUBV6QrBeDST2yS399Ufu1oQiDnBQQYm6L4+28Hp8lkvaSQN4xmVSEKS4LvrjdeuIdLSB4+SbR4E9KNBfhe3KX1893cPXKMBlyQF/CjEpoD6SLNOLK33UdIuhaAv9lLR1eMS1GTnI0v+zIhvu8T144pTk/Vbs8icAhFM7xF2L/tVO5NFULIKH+rhc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64117445-7ef2-47e3-dfea-08d716bcf4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 20:15:11.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1486
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
 drivers/staging/wilc1000/wilc_hif.c           | 32 ++-----------------
 drivers/staging/wilc1000/wilc_hif.h           |  5 ++-
 drivers/staging/wilc1000/wilc_netdev.c        |  6 ++--
 .../staging/wilc1000/wilc_wfi_cfgoperations.c | 26 +++++++--------
 drivers/staging/wilc1000/wilc_wlan_if.h       |  3 +-
 5 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index f8646ea3b0c4..2b4c83b225a4 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -1409,18 +1409,14 @@ int wilc_set_mac_chnl_num(struct wilc_vif *vif, u8 =
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
-
-	wid.id =3D WID_SET_DRV_HANDLER;
+	wid.id =3D WID_SET_OPERATION_MODE;
 	wid.type =3D WID_STR;
 	wid.size =3D sizeof(drv);
 	wid.val =3D (u8 *)&drv;
@@ -1435,26 +1431,6 @@ int wilc_set_wfi_drv_handler(struct wilc_vif *vif, i=
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
@@ -1630,8 +1606,6 @@ int wilc_deinit(struct wilc_vif *vif)
 	del_timer_sync(&vif->periodic_rssi);
 	del_timer_sync(&hif_drv->remain_on_ch_timer);
=20
-	wilc_set_wfi_drv_handler(vif, 0, 0, 0);
-
 	if (hif_drv->usr_scan_req.scan_result) {
 		hif_drv->usr_scan_req.scan_result(SCAN_EVENT_ABORTED, NULL,
 						  hif_drv->usr_scan_req.arg);
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
index 68129a0ba55f..57510400f243 100644
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
+	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
+				vif->idx);
 	wilc_get_mac_address(vif, mac_add);
 	netdev_dbg(ndev, "Mac address: %pM\n", mac_add);
 	ether_addr_copy(ndev->dev_addr, mac_add);
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index e2d9efed36b0..f3b12f3b6d61 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1419,7 +1419,8 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 		if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE)
 			wilc_wfi_deinit_mon_interface(wl, true);
 		vif->iftype =3D WILC_STATION_MODE;
-		wilc_set_operation_mode(vif, WILC_STATION_MODE);
+		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+					WILC_STATION_MODE, vif->idx);
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
+					WILC_STATION_MODE, vif->idx);
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
+						WILC_AP_MODE, vif->idx);
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
@@ -1659,16 +1659,16 @@ static int del_virtual_intf(struct wiphy *wiphy, st=
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
-						 vif->iftype, vif->idx);
+			wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+						vif->iftype, vif->idx);
 		}
 	}
 	wl->vif_num--;
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

