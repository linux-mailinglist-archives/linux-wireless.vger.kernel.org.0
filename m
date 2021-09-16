Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD540E3DD
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbhIPQwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:52:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34431 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbhIPQul (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810961; x=1663346961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E+fKYXhPpZ5rdm/yN7T/BYLkT8SFnvSX23T2wCPJcHY=;
  b=qcXtBr8Q6qXzC9VLysNL9Ne45eC7GDmZBKXf+2TC97zW8F0lBcb5BWcL
   asUv21cgJ/kZM6GJn2zDXw3vNMRcz1yF104g8nYM8U4TJ6wcgeL4oUkxg
   JYD/m6g859hiddX9KIoqarMGESTSMUK+0Q5Alb6rKsDhLx4z1rqPru0yU
   HLu96CXwaH1Pc/ZjrST4k9NSKuTj6y0IJRBda2IWu6WMhsc+7f1sbB/D5
   gyHfttnwOyOsFEVhHJhXatQJZQ4UnWDOgRJUfNgwl8YqIX5RhMij2xzOd
   cwXe/EcQeFXB4wvkQ3LxUOh0g2I3XjjGYp365l9iuPSFm+jxC8rVAdU0D
   w==;
IronPort-SDR: PzYVRgAbO+Jy/1r6gTv+ibf83eYXcsHe9q1wpUObyssnL7UpRxbroEvgHMn/I/hRQWWBmr/MUr
 O7Ch5jtQWk6XGu+FMsJVYbQvZ0+xPuOWDI/gvuN2lT6/pWeMqk5u7fw4cfMLdQP34GjVXsn99K
 byzPOlzlv09lGmQvg9HCJz6+zsLvTVnwZanuR/GOD2l9mwlDRilb8/Ff/6GwhBkZVPBiVD1ASs
 +p8DcnU+vw+qfPDJqqhkxChy8lJE6GI3dF63yezB2muLtem+777HAKf2xZkwgdV4PqKc9hOg9a
 /moGS0dxYFxk+odahlsP/8g+
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="144413533"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 16 Sep 2021 09:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFj5+8tmTjreIYu+WHBVXsEqUqfQ8aE6gAblFs3w+QjMKYqxwG77V3b7U1ZpdfJkgqoglwvpcnSs7yqNQi1TXOx7Ak6xIYGxQhoh6b5aw/x/o12Kp5e+N79YUL8oyUfX2yyiYnxRm5ftF960jucDcBF9nyHlCs1iGuQqZvJ7bifmQaCZHdTKHC8RQZ/dqvll3Xou+XC70UrxnPucoihdyPWN60BxvfiNsOF35NBUqOn0glXw0SgUxkc70Xb3Sm4WHCB3aFJfgjWrv2PJTkgw1RAy4rryEK46dPT1uVzkL5tXY9JpgKO/T7lDGtfUVJ1zJp30T6uiZleP5j2BPevWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TaYqxODhF/hf47W5KjpDrfQ+J9Jiu8vq2mtaA3L6T5Y=;
 b=bkgTCt3qrWIpZWq5tU2rynVF4nT5lxBdpzj0P8/7od3jDi2j5P5HzdNyq2sfuSqf2dlCuLEW0MDjoZpFKfL7ym71I8uYcyaYp+tatTW7zJAcdBnmfSgChw1+nlM0SLjBOSdWQU7lTpp69dJHUaM+pXjtM4BSrdqBnDnZVKY5avUjej5SfjNTdxQDFjDboj6lHx5Mpw0K8xucvnSEZ4KR20PZUs0YAMhDniltFP5yOCy0sjy0891KUoH36TpWwnfPZqwWPACpZIZAJCEKC5Rub7wTAxLb4bMJS/r3/MF4+PpG/d8GOx+sa4QRfNldnknn/ImkKjAoUc0epDdEzYeLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaYqxODhF/hf47W5KjpDrfQ+J9Jiu8vq2mtaA3L6T5Y=;
 b=KaIiaPGgbvzVEYSGAc13jJuZ5DVYIhm9wATXzbIGuD8f72bb8z8Togmh0HiNv38ANTGmwJPK5MT75l9hvC9e7cMSoIEiG1yYtlSiVW8U1//rxGX38Uj2f5m/TC7egX/7hSCdlLTJmwfQcNHBbvmXfETSccJ/5JqJVqoHoOCrNCY=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:17 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:17 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 01/11] wilc1000: move 'deinit_lock' lock init/destroy
 inside module probe
Thread-Topic: [PATCH v2 01/11] wilc1000: move 'deinit_lock' lock init/destroy
 inside module probe
Thread-Index: AQHXqxrJxDjNG40dJk6FUWrJpJ0RwA==
Date:   Thu, 16 Sep 2021 16:49:17 +0000
Message-ID: <20210916164902.74629-2-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee3b3eb1-2a8a-4dac-7f9a-08d97931ec6a
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB519703B325A7A246F2062D19E3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAooHnnjoSjYHNG4ALFFaI2LULr9FBtyMAN48RneJm9JqUnMS1qQNtP0Z6DqrfPA6mzp97h7NJEQLWP8wrsomFOqBtQHfufxBEPNbn9yCy5de9DZngzdVeABEAGCW5cH1YdMOt7uLC+c/RSXyyjDTQX7TQjJiJpy6hwY0YgmnzEwBkzR804iCa05xXbX3b1LuKrBcSRXr7ecqF6AvCdvpk34mtllaBkvQqsrNUlvb4g784tXB68ycqNl+pgQbmltVFnGzUsCgApz/Dulkb+7OoLvmvpSef2Q3xNx8duqEHOOjQV+aYYdQnMTRUFjFaFQIby9aye3LgI/31zzRXIisCN+ppx78v6mp0JZEDo8PryRZQG1LW6IA2vUY+LBL3e6sj4QbE6uodQTMTz8d8pGyby4OPT1XzjroGR+BJs06LmSunb0/+oOmQy0z4yWT1qU9waCj5+MDgGQ2xI+nRfSJoIqW+7cb5z09RocVSI2DEpPQR6PmeABWU9ggfcCmtpew0EGffSwKF+GVlhzbvDLSSbEGgu6RkXME0LUpme76sKjyqSftTTPbc6zSiEhLxUlyClH0NoThVLlXcO2JmKFznWL7zjMMxOGJb9J2iIMpgUDidQ1A4SeRmV1aqmkZ4Oxr7+xOL2YfCcBF/zDR519of0MRdnJ3TQ/Vv3xx0xtq0yFJ5LZmDt/HKV7g2hi+MlzLzwN/uGwMlLVn/ZP++hpug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hS7uZ7fpRt+n65lLplURc2J9i/TGQ+FwUAe5dzbA9TFQE+RLP9paJd+fTl?=
 =?iso-8859-1?Q?acj/9liRsxyA82vTyGDD1Rlo+TIIhBaPmMTW12ZiauiWUqVN06j4e//NKR?=
 =?iso-8859-1?Q?CjA2dURTsAjEU+Zt2drOnzzILPoYCdQ5uKvF3iLHVpHm6s8bQYJHZgsp9x?=
 =?iso-8859-1?Q?7ID9eUNO+PCXaU9/bRvlqShea8mRr/JiRdsY/zgRbDcXFMA4WzeZo3sgGz?=
 =?iso-8859-1?Q?6JpoaDSyVoOkl29hkShbAHcc4d8kzX2w9vLUIZZPRyh8Kf7HlnZcD5BeMF?=
 =?iso-8859-1?Q?ybqWPi729Sc/DkONyhxHAIMUZ+2kZMxF1D8+Lw5B2VCnOYxmTOoPbVQIZe?=
 =?iso-8859-1?Q?0q6q5zoQ7CZ9aFzJ157MWHceMTqM5qGXbVS7g3minN/ISaEx9KrS82pJ5A?=
 =?iso-8859-1?Q?btfs0DB7x7XjeVCansP8SL4g8KLICC0tSs/sBz+7U/RoPJIsZt4rM/4I1k?=
 =?iso-8859-1?Q?gLZ6QBrb48HAgcg6RpZqSDSCBpyQA/UMOtbJx8ntB6RpvSABrGYJvc+UaC?=
 =?iso-8859-1?Q?fcXKejm2kIZG+2tEXQFLm6RjBFSKc4FEb8PtrjtiLoOVTpjbx8awoSCdA8?=
 =?iso-8859-1?Q?Ksc+h5M7Q5Xgst5Cv9A8rA8QRSgLBV1gRGt7x//2Yb71odMwpyBryoTlXT?=
 =?iso-8859-1?Q?zDbtZLuaiPZ8qPfbWXz7VO+oChkt0nkVaPSvBolKADpsxcIg2LbkiLhXI1?=
 =?iso-8859-1?Q?H8MdFCwWsWG4H3ilubHmVpK/lPmD2ZS9WwVWXnYxQZjzTPU+rkiaYfD++S?=
 =?iso-8859-1?Q?1ydt8f7qjj8klL499+wfnpf5G/W0QpqwDRzAYo8obgMDxa22Kw6NyaZZnj?=
 =?iso-8859-1?Q?FddP75JFzI/JjMU5W1q9HLn9zy300vVW16Sl1X6DfeG2dHuaLeWPkxgsxD?=
 =?iso-8859-1?Q?BNtqDKcsG2+TZCgIfsi6r6YZeneUUzChmdCaUpnlOp3f0rsqJS38Cdotsb?=
 =?iso-8859-1?Q?opY9ez6y/s8JP7RRHm/XDY3HlfQi5e1VxR5UV2OLjyNJwMSGnZwH+jT+v7?=
 =?iso-8859-1?Q?46Aelw9rDPQgLUVTWmbAXquYxrVVyMbMTduC3c5xiXeQm3PYzxIhNCJ9Df?=
 =?iso-8859-1?Q?8AsXTB8VYDHKXrViSNBZvotJ1zVtK0ml5gUIHobj2YxAwkHAh1ETi4biPq?=
 =?iso-8859-1?Q?2BpGlwnmkV0L0gAFFHLrxGNITywNWTV8fcJGVCjVgWtgZ6FE96Z+3xBXaH?=
 =?iso-8859-1?Q?r7ll+a3mMWkXdWum4eGAXkQPYvIMvWvIOb+DWLEZlHhfgLe3YMCrzz55wQ?=
 =?iso-8859-1?Q?merRzt3lTcndy6STSvpnKxrGogbhjaJszv6e7QriCB3be0mIHaOoLHUjgX?=
 =?iso-8859-1?Q?OPpHgilhQsj4L9Qks66JAHy8O9t0At4cucB/EmBAhfJk0M3iz6z+YDlxKM?=
 =?iso-8859-1?Q?om6RR4Sulc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3b3eb1-2a8a-4dac-7f9a-08d97931ec6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:17.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fubJcmE2vwpybmf0zsLNPEoPckWt7xa1A9ypcKn53rPN23VGWIom3j7Rgp5Sr3enW+Sq+YSWLU2HLUdouwgnYLYgidMF9otUCTMC4mSU0Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Move initialization & deinitialization of 'deinit_lock' mutex lock inside
wlan_init_locks() & wlan_deinit_locks() API's respectively alongside other
locks. After the movement, the client count variable(client_count) which is
used for lock init/deinit is removed.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 ++
 drivers/net/wireless/microchip/wilc1000/hif.c      | 7 -------
 drivers/net/wireless/microchip/wilc1000/netdev.h   | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 96973ec7bd9a..530a768547cc 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1683,6 +1683,7 @@ static void wlan_init_locks(struct wilc *wl)
 	mutex_init(&wl->rxq_cs);
 	mutex_init(&wl->cfg_cmd_lock);
 	mutex_init(&wl->vif_mutex);
+	mutex_init(&wl->deinit_lock);
=20
 	spin_lock_init(&wl->txq_spinlock);
 	mutex_init(&wl->txq_add_to_head_cs);
@@ -1701,6 +1702,7 @@ void wlan_deinit_locks(struct wilc *wilc)
 	mutex_destroy(&wilc->cfg_cmd_lock);
 	mutex_destroy(&wilc->txq_add_to_head_cs);
 	mutex_destroy(&wilc->vif_mutex);
+	mutex_destroy(&wilc->deinit_lock);
 	cleanup_srcu_struct(&wilc->srcu);
 }
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index a133736a7821..497a49a182ef 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1494,7 +1494,6 @@ int wilc_init(struct net_device *dev, struct host_if_=
drv **hif_drv_handler)
 {
 	struct host_if_drv *hif_drv;
 	struct wilc_vif *vif =3D netdev_priv(dev);
-	struct wilc *wilc =3D vif->wilc;
=20
 	hif_drv  =3D kzalloc(sizeof(*hif_drv), GFP_KERNEL);
 	if (!hif_drv)
@@ -1504,9 +1503,6 @@ int wilc_init(struct net_device *dev, struct host_if_=
drv **hif_drv_handler)
=20
 	vif->hif_drv =3D hif_drv;
=20
-	if (wilc->clients_count =3D=3D 0)
-		mutex_init(&wilc->deinit_lock);
-
 	timer_setup(&vif->periodic_rssi, get_periodic_rssi, 0);
 	mod_timer(&vif->periodic_rssi, jiffies + msecs_to_jiffies(5000));
=20
@@ -1518,8 +1514,6 @@ int wilc_init(struct net_device *dev, struct host_if_=
drv **hif_drv_handler)
=20
 	hif_drv->p2p_timeout =3D 0;
=20
-	wilc->clients_count++;
-
 	return 0;
 }
=20
@@ -1550,7 +1544,6 @@ int wilc_deinit(struct wilc_vif *vif)
=20
 	kfree(hif_drv);
 	vif->hif_drv =3D NULL;
-	vif->wilc->clients_count--;
 	mutex_unlock(&vif->wilc->deinit_lock);
 	return result;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index 86209b391a3d..a39c62a20f04 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -264,7 +264,6 @@ struct wilc {
 	struct device *dev;
 	bool suspend_event;
=20
-	int clients_count;
 	struct workqueue_struct *hif_workqueue;
 	enum chip_ps_states chip_ps_state;
 	struct wilc_cfg cfg;
--=20
2.25.1
