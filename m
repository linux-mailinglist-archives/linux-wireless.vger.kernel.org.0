Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD228759AB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfGYVbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:31:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41144 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfGYVbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:38 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: P5wpaA/gMZQi1vFGGjzSw1SoylT/voIUsFNkvoAZ7TUMLOLbOHuJ2n/85bRhiz55jk4lZ9RZY/
 hYXjC2z7JMlso5Ie8GJ+A14dpwR0CS5VtzRzEs0coCnHZQfIW2HhucaRI7POBY0KJqIuExx7kz
 SAgIjfQDwy4E4RIG5O9UlfYKWMcmtpjMBDDmEJ3pWAPMTSa7eG2B5xB7sYx6BvSFVRnw6cicGP
 f/2lDWey+0H199jP6Jyx8KyDXr5HYN75GjpS9XbYySfShzmSHVW1TaO5VGbeb168GKdUxwnwbj
 98o=
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="42013692"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 14:31:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 14:31:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 14:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEIYZwtoMXzyDIKi8MLQ3omI/JvKKfFGPAFSIiZTnF3tUdsNbQG/aBO2F49vz5yQOV9Dm1Rr6l7J2zCJD7/chytIOA4TU7++uiONwDlRqtQI9TSJEXALr1cK2HHqnhKCORW0UU69E0tZ70pw88PyKBiS5RdnDYRMk0iNVP1pxFR+h5VOeYSJgDstDA7JOGwv+ojW8LiutIZQbbD5EaK39ygLNSt0wMz7QVp/2kMcZvU16hkliRCxyRjszuagi3oCpdskUwPhLpYBx5F6q78dlafbN/4o2ct8mEKoRWlvm4o5meX5AECwZTYOf1QK+68ohpvQHtpiVAR3gUbxbM3Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw5/tydGLOV2Am76N9CUgYHZV+HqWjFMZB3ghfhDhAA=;
 b=E98GrvANI3MdrptMHNyCvHKYXdcTQsQ1/tyDthpDw6HT+C5boz05pB5S/y7LclXn5BnfwbppmysOinm71KF3Gh2aPBmsLPOOrh64E9Xdz1N7R/l+SvNQoefIAyxxPbEPYfNMlLCaFaKY+yRdTmKZQqCwXiOWozld4lV+6t5diHoSVebiv86dLO6X99sO2KwNumYyftBZrOQ8ZEwCEDiPMF3Z0KoORw7961Vf+KR6mXIChcpm1/kzqUZupXrVFqAMzdmQ/L9+bNj1PjxXgP1cA6rXf8a1JdXA2uPGcx6+sDegqgvGVzvAmMxtK+PfyoXKfSL7ZyfwiLtJJmcDKltZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw5/tydGLOV2Am76N9CUgYHZV+HqWjFMZB3ghfhDhAA=;
 b=PHcHNxFbZ7wi1DJAejTam7VQ6D8A9091V8kAnScA3HNzK4Zh19a4tDEvGo/5Bw74lDDudxWwOXgXzSRuy3EH4NdNNdjl2v4fUZ6S+kvh8lVxXPOcF4OGjEUucUxwuoI6KY0uL20nW5V43/1Dx+q0umgivNNyVR8gFczbr1wCHN8=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 21:31:36 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 21:31:36 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH 4/6] staging: wilc1000: avoid overriding powersave state
Thread-Topic: [PATCH 4/6] staging: wilc1000: avoid overriding powersave state
Thread-Index: AQHVQzBVoN2TYYOHTku0fkunV/xJ7w==
Date:   Thu, 25 Jul 2019 21:31:35 +0000
Message-ID: <20190725213125.2810-5-adham.abozaeid@microchip.com>
References: <20190725213125.2810-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190725213125.2810-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: MWHPR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:300:ee::26) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a6e212a-b4b2-4ba3-3ebd-08d711477851
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984EFD92FF025624D8431828DC10@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(43544003)(189003)(199004)(11346002)(2616005)(476003)(102836004)(386003)(446003)(486006)(6916009)(2351001)(6506007)(66946007)(186003)(99286004)(2501003)(76176011)(26005)(316002)(52116002)(5660300002)(66446008)(256004)(305945005)(6486002)(25786009)(64756008)(66556008)(66476007)(53936002)(1076003)(107886003)(71200400001)(86362001)(71190400001)(4326008)(14444005)(68736007)(478600001)(8936002)(6116002)(6512007)(14454004)(50226002)(8676002)(5640700003)(81166006)(81156014)(3846002)(2906002)(6436002)(66066001)(54906003)(7736002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QGv4no77C2hlCmln15Iue6Dyoanj3mclhlSYY8ChFwvvEBKktu9kwqiUy8iupSGXZYjQ1kXqNYiGU9RxIISuvFshr66bsqykR6BtuIfEyDtpoKwKWHKqrEHx4IJlHhQwXNv2pbgXFmbqD3I7R56jmPdGLzrjsrEOAuaKV4TLwD5ArHcPOG6NLPYmxrHZpzWbGqxfT1mUhL7drtKoXtK1Blw9X2UNMR74QYtC79KllYgi9JDtb74gpCL/belv8quoShV/aaxwDPDVo1TsBORp6dhVghkiHTIeKLmRYfsfFhzXjzNob0Q34LTuZJkhuziC8ulQBjekiFo3WmLKd63AmEnnYTYlqF2ddBZh49zHP1yXvJTEwI719ZOLC5uaYHCph3UC6z5ir4j8di6wncVYhzO4zBrFixz0YoF2ZzwJD8g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6e212a-b4b2-4ba3-3ebd-08d711477851
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:31:35.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

Don't override powersave state with respect to the open interfaces and
let the firmware take care of when it's appropriate to do so

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_hif.c               | 11 ++---------
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 15 +--------------
 drivers/staging/wilc1000/wilc_wfi_netdevice.h     |  1 -
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index 611f842d2836..16ff610c6a5b 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -679,8 +679,6 @@ static inline void host_int_parse_assoc_resp_info(struc=
t wilc_vif *vif,
 	if (mac_status =3D=3D WILC_MAC_STATUS_CONNECTED &&
 	    conn_info->status =3D=3D WLAN_STATUS_SUCCESS) {
 		ether_addr_copy(hif_drv->assoc_bssid, conn_info->bssid);
-		wilc_set_power_mgmt(vif, 0, 0);
-
 		hif_drv->hif_state =3D HOST_IF_CONNECTED;
 	} else {
 		hif_drv->hif_state =3D HOST_IF_IDLE;
@@ -704,14 +702,11 @@ static inline void host_int_handle_disconnect(struct =
wilc_vif *vif)
 		handle_scan_done(vif, SCAN_EVENT_ABORTED);
 	}
=20
-	if (hif_drv->conn_info.conn_result) {
-		wilc_set_power_mgmt(vif, 0, 0);
-
+	if (hif_drv->conn_info.conn_result)
 		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF,
 					       0, hif_drv->conn_info.arg);
-	} else {
+	else
 		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
-	}
=20
 	eth_zero_addr(hif_drv->assoc_bssid);
=20
@@ -767,8 +762,6 @@ int wilc_disconnect(struct wilc_vif *vif)
 	wid.val =3D (s8 *)&dummy_reason_code;
 	wid.size =3D sizeof(char);
=20
-	wilc_set_power_mgmt(vif, 0, 0);
-
 	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
 	if (result) {
 		netdev_err(vif->ndev, "Failed to send disconnect\n");
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index 6ac0fe58ceed..716c60d0f962 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1394,8 +1394,7 @@ static int set_power_mgmt(struct wiphy *wiphy, struct=
 net_device *dev,
 	if (!priv->hif_drv)
 		return -EIO;
=20
-	if (vif->wilc->enable_ps)
-		wilc_set_power_mgmt(vif, enabled, timeout);
+	wilc_set_power_mgmt(vif, enabled, timeout);
=20
 	return 0;
 }
@@ -1425,9 +1424,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
=20
 		memset(priv->assoc_stainfo.sta_associated_bss, 0,
 		       WILC_MAX_NUM_STA * ETH_ALEN);
-
-		wl->enable_ps =3D true;
-		wilc_set_power_mgmt(vif, 1, 0);
 		break;
=20
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -1438,12 +1434,9 @@ static int change_virtual_intf(struct wiphy *wiphy, =
struct net_device *dev,
 		vif->iftype =3D WILC_CLIENT_MODE;
 		wilc_set_operation_mode(vif, WILC_STATION_MODE);
=20
-		wl->enable_ps =3D false;
-		wilc_set_power_mgmt(vif, 0, 0);
 		break;
=20
 	case NL80211_IFTYPE_AP:
-		wl->enable_ps =3D false;
 		dev->ieee80211_ptr->iftype =3D type;
 		priv->wdev.iftype =3D type;
 		vif->iftype =3D WILC_AP_MODE;
@@ -1452,7 +1445,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 			wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif),
 						 0, vif->idx);
 			wilc_set_operation_mode(vif, WILC_AP_MODE);
-			wilc_set_power_mgmt(vif, 0, 0);
 		}
 		break;
=20
@@ -1461,9 +1453,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 		dev->ieee80211_ptr->iftype =3D type;
 		priv->wdev.iftype =3D type;
 		vif->iftype =3D WILC_GO_MODE;
-
-		wl->enable_ps =3D false;
-		wilc_set_power_mgmt(vif, 0, 0);
 		break;
=20
 	default:
@@ -1485,7 +1474,6 @@ static int start_ap(struct wiphy *wiphy, struct net_d=
evice *dev,
 		netdev_err(dev, "Error in setting channel\n");
=20
 	wilc_wlan_set_bssid(dev, dev->dev_addr, WILC_AP_MODE);
-	wilc_set_power_mgmt(vif, 0, 0);
=20
 	return wilc_add_beacon(vif, settings->beacon_interval,
 				   settings->dtim_period, &settings->beacon);
@@ -1836,7 +1824,6 @@ int wilc_cfg80211_init(struct wilc **wilc, struct dev=
ice *dev, int io_type,
 	*wilc =3D wl;
 	wl->io_type =3D io_type;
 	wl->hif_func =3D ops;
-	wl->enable_ps =3D false;
 	wl->chip_ps_state =3D WILC_CHIP_WAKEDUP;
 	INIT_LIST_HEAD(&wl->txq_head.list);
 	INIT_LIST_HEAD(&wl->rxq_head.list);
diff --git a/drivers/staging/wilc1000/wilc_wfi_netdevice.h b/drivers/stagin=
g/wilc1000/wilc_wfi_netdevice.h
index 704e4d572695..7e7ce9471f67 100644
--- a/drivers/staging/wilc1000/wilc_wfi_netdevice.h
+++ b/drivers/staging/wilc1000/wilc_wfi_netdevice.h
@@ -261,7 +261,6 @@ struct wilc {
 	struct device *dev;
 	bool suspend_event;
=20
-	bool enable_ps;
 	int clients_count;
 	struct workqueue_struct *hif_workqueue;
 	enum chip_ps_states chip_ps_state;
--=20
2.17.1

