Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D903699AC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbhDWSac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3592 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbhDWSab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202594; x=1650738594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1T+ohFwRXwiWka+DfJ3y7ZQPSHRzkH4LiilKQ8d7cYQ=;
  b=LPmEhXtjUcu6hbZnCritkTfffNDGLeViB1yCRIDrKDoxY/XcEfTBFgf8
   0u5YR8pAQAiWoo1LvmxMHKNib+624vSCanXwzKjsNTTwTTBKKGnZ6gtVe
   ifJ6XVcFKHzOEO1qHTu13qG+vHgTY1JK7zLPhHfP/WSsGZZENP1UtR7/2
   SP+BGu+CsXapOlax6Enp79N1QC+ByxMcdwls6mvXVdagrmGSy8fyrg4st
   115Mbgf8N9xYefMPbsnXo9t1z/D8UKxhT8o0IreHp+4hMhvr+PQo2McMt
   FuFRoSvA4ludUTt1ZiCLMZgRNSJ8TJ8vbeTTigaG7puojjGDgPzrHWpTh
   w==;
IronPort-SDR: NuTfEYYnnOLEXFsC9HUw52WfFXvzUtch9snzCbaWTPyEfOlvDUjFwZIyBoXM6kTjZeT+9Okv1d
 eMAS/iO8rZnMmfwz3S9kHkYuBFjWIgA1rdzBjA+jJApBrupVCuEagkwPKE3tMnIl3DZ+wBhHvk
 S+udDVRuO+OprxVNV48W3I45J669KBBbYbMnzzM/6oNTXDOeEn9pKm2eE0UtMyfOI9JdHGbbSd
 3AdO3Lvhr/PzK3Js6MWB9SbZYiNJhBbm5FFm/wykdKAa7oScd2SAlvdv/p1UGiVMvlD/1KEs5w
 l1U=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174648"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU6iJTwb7ebsdsCyZuzucnX9WAeG0PP2guUBMH1HKwrSP0wtg5paHd8qhPbXxUW84y3EzUEudj3VdMNDf+xOJfimawOo5Wb8gm0BYqhcA6CjjgoyZaIPmk8GNo1icGM+yxKlXXcAroP258exMlmU2sMN/oqPDJJ0LYtyq2VQzfRGfhBnoFsAx1F0Oz6kt4JQn7miIygGf+2GbNKU7Rit8lv0fW+EK1ehYE6pMa36udCa10017/F+OxkX9SmpiYUZTDDjW6ScztFhgracbG1C/EyGPo+0TDxTEUZqHH4vo/AjwPWf8Z8EhuAiWw3Bp8Z+/Xu5b6oTeXsIgiXFlWmDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHxkZFOj+KmlpvelcXauV31zBQOsuG0P/N3fxHDKeCw=;
 b=WFp+OzJGp8sd0PhnEvtLYyJ+SILTwn260k6xr6hHmjfyDB0gKub6jzI8D5gbljC1bA2mYhiNPfe70LHiDGY5xfruitQlO9RnR/myTpo1EQIPHiNoa+UlX0tnu2JiQgxDltoOH14NVoLXsuB01LsV6o/Qd1CAZQSzHjih40VOBfKiAM9Gz7JYFTmvNpL2noYkiQamOXqkma35QhholK7vLEeUYqqcnhTyVG1suoIU4PDDHk3HreaIfhOje1u5lKyJ/Bh6QfxzpI07C2i2LecFIbUoRXXOrNsLbhZQn28/0fk4/fEHDibiIbX9T7OFEuJkD7UTxHD7BVPFINrWC5/5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHxkZFOj+KmlpvelcXauV31zBQOsuG0P/N3fxHDKeCw=;
 b=p27n8ZVgPx8vGADdmY2Y0CWWvxmUcZO8AD7aB7Wu6ljaElGsPMs1nmeuTxLd947sAKS7Bw1WCfrFWdjZLRYloCc0QUvFtYDG/YasFSKBHlV5kkasfvUOtTzp2gv8OlfuIm9i3YHmsprEXlM9uqFDXbyq7JPF8zY5oWpRinT6JWA=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3493.namprd11.prod.outlook.com (2603:10b6:a03:81::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 23 Apr
 2021 18:29:41 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 01/12] wilc1000: move 'deinit_lock' lock init/destory inside
 module probe
Thread-Topic: [PATCH 01/12] wilc1000: move 'deinit_lock' lock init/destory
 inside module probe
Thread-Index: AQHXOG6fh5Se5HWONEeyioxi64smcA==
Date:   Fri, 23 Apr 2021 18:29:41 +0000
Message-ID: <20210423182925.5865-2-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb86589c-d1ed-427f-3915-08d90685c277
x-ms-traffictypediagnostic: BYAPR11MB3493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB349309C4B9D2E82E2864A164E3459@BYAPR11MB3493.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRHsMZMqwXFny1iQjj2Lf1bqa63X0rZrFNHSR17uF12n9uJ9iErviXbh5Hg59DDQYqTIwf1BEDIh0N73JZM1GlpOMYK590Qhwy6i0q6J7BKwMkwGhKZCPBoGK8y20c/b7jiJJdXsrNp7xvLJARedU0WJ0S7FMvAbWBxQzzhHud7gM6OXA4DybUNJrbP5EbJ4TWt4YnSLFxope5/cZLry+lEo/Fm0t4A6Qsc9+i2RtfW4gno6htCt1cH3y53H/ISL8Og7otz6PtTJl/4OQhdwWI9iNNOgdYFJUwA0Qxv+nQEGtnfxmg9jrwaxoAXIaFcogZIbDUOWwI6Soz1+u+TIYGt86piGLsqxV49en8HWAb2A+qouxIDTKRV+toAMb5TmmZNKG7nZdy9TmpoDytBuqBeyGbXGuw9t6nm2nEOpfm3oZzMByJwcqxaqwcvRFfVEq4lQjt1m7zhKlfLfuxPk0GCuo9y39ijsFqLPz3jk2STpqO0b71TWO+0/kObmpR714xauphLPKQoS4DAXSBbLBS6+DKQX0Tf2N+oYgS3o0Bgi2ioRlqLY1XrpU53VJDxlNsl0W4I8J9sictgGXViatNw/WrHXvpky/FRtrSdi4JQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(86362001)(83380400001)(8936002)(66946007)(6486002)(122000001)(66476007)(6512007)(8676002)(2906002)(54906003)(5660300002)(4326008)(38100700002)(6916009)(107886003)(2616005)(71200400001)(186003)(478600001)(316002)(36756003)(76116006)(64756008)(1076003)(66446008)(26005)(6506007)(91956017)(55236004)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?m+rLkd6eEtmpXciQ0ubbEX8E3n5mnZSU3l1DRYAQ1QUoGNntDcT7nnX4aC?=
 =?iso-8859-1?Q?quvnRxtoLXPIvix8JPaezAfC+bNuoSTraBowbZn+cubo42+mWAM+tJSyfd?=
 =?iso-8859-1?Q?fFQWJc4CCQ7xjH2tfCJ5u1e84B43cN9D+mJBQ3hFwgqFZZDVvcxrbwq/9J?=
 =?iso-8859-1?Q?rtZ4LG16pLJN9y+uova9iDsztaH1N8k1mSV5TAJ2RaoJJ4WrO/eI0nSCM1?=
 =?iso-8859-1?Q?/ByUMEcU97B3QZGloV4cV1moEjr5neeDjDMGW8/olhUouxS+2Sa47gSr2r?=
 =?iso-8859-1?Q?HoUuPqqx0FpGlXEWGm5FJzMK1Pu9Hb0TTHZeLLebpvwXUA/vs2APnBu1Dh?=
 =?iso-8859-1?Q?7mSQGcaHOmC4jDv2iG4iqH02ILU24xs6s9NNwBP/GhAUM6k9wKA8bjWQNE?=
 =?iso-8859-1?Q?41D+/mJEWJJmP1WnFi7p3kErOwckfPqjgYr/aQMmlIn18mgCqKzzdQx0tY?=
 =?iso-8859-1?Q?j8ktgF3XbP5WpxbUUzD9g5+/uZ8nosOlzh9UPx/fPrUstUaVGzvKKCEDP1?=
 =?iso-8859-1?Q?1YRGgkV21cOZqLfoqgnoYEXEFCmxEnQ11mblOPFC4uB3sVrovkfRvwJwdV?=
 =?iso-8859-1?Q?oBV8M7y1xZ1EEyjApykR6m1Vl0ZnF1MGvnY+x0BumDOBDF5Cqx0Gt5bg8V?=
 =?iso-8859-1?Q?jLfsM9QxZXgUSsuArYs5AqWiMV1nhlohIQP5corsudNh2SOjLzG5DmvRkL?=
 =?iso-8859-1?Q?CJjv+NJhZsOEaxE9Ivr5Tg0s4Fj4LqwIK8kpybjfj4JkSL/0wwQ18EZs0v?=
 =?iso-8859-1?Q?0P6sciIUT+6cTt01PMpwjr+hdU+W07/HTeM58WjEKkyH9X44VzmHqIMvPW?=
 =?iso-8859-1?Q?PFBzoSURkVJw7WshffhZM4i2Rp5qDFLHqitlc5PmdqwBVaTD4deXcsAogx?=
 =?iso-8859-1?Q?qNfkIuATmOxUEHBq7B7tC3UyNfcDo5YiByUHu0QLCEcpob0earrAUNBSZR?=
 =?iso-8859-1?Q?sXvToYUDDaVMAh1xdW30dReJyLjmVGE2bNHvmLmrkfqWyBi67OrtGfJjRg?=
 =?iso-8859-1?Q?6WLsqPo5V7zp+fWNdKd+yFESOkX41OEzFSfsJyxPuQnwsn+IXo+IWM4fRc?=
 =?iso-8859-1?Q?iQYuUs3Him/a4EVGr7fodMm2cJ0ZZXOozHZy2XQls+Ti1y69LsGXAbLJ3m?=
 =?iso-8859-1?Q?md8u1xIeTqjKTL6E3eXYSWkcZeTbntk7g8gK8ofZd7UK23erewIaADc4HV?=
 =?iso-8859-1?Q?dkMZbq1BSciu0tHbMNwcNEpUVAnatTxsKHZZz3eNoBuG40vOu9LrjuJvvh?=
 =?iso-8859-1?Q?mtHQK9P/p1uPegFpwdv8WjCdRkoG1kDcTJLfn/GEGZY4PKQrY1DttSIxz3?=
 =?iso-8859-1?Q?Ec/PelwKLD96at2xOCRTplQRVfSFi8QgnGQBPyVWf9Czncrbbkys2eDUNx?=
 =?iso-8859-1?Q?PD++1pNlVds+/brw1Imfn4SjjXohb1mQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb86589c-d1ed-427f-3915-08d90685c277
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:41.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ8yNTQVDAh5Eq/KetMvUjbajUwFogaJD1q9CEuDgNibK5MNO6V3TjvvaRS+5TuAkE1cwG6tDPw2112XxEEgCvNqH/AwXjfZVkUCmQBuHpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3493
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Move initialization & deinitialization of 'deinit_lock' mutex lock
inside driver init and deinit respectively alongside other locks
initialization. After following changes no need to maintain client count
variable(client_count) just to init/destroy the lock.

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
2.24.0
