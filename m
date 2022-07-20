Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90D557BB06
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiGTQD1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGTQDZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E554645
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658333003; x=1689869003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R03sb+ZaZad6NY1khhOewSS+WEbj8+gxGdhSEn1JSPs=;
  b=ijrXcaJ8guKilTeH5a5VkkKr37jyn9/dg5qjvnr/qSVSF8/oHmBFze9c
   w3E7aAdnCos2zpu/pWqae31T82K+VEa/W69YdczZrvZAr/dOpUb/ag5xr
   Q3LW/u5eM5AR8YhtLaWCma8J7gdqhxjlvRRK8nxsg2frDPQjiUOUNs5nf
   0QmnVeWyNkTF7vA+MfOxq35MSd7n7AmdSq7rXZNjenC1XX/aZPuqGMbeK
   3z9MEgw9B4Vmh4hh3diPD8eSPp++XjvFsEf0NHr5akWOsv417dq2g925M
   BXVrNPp37Nnj59duByYSIclHRQFz0IDcq4BkJ9+ZhMPhkg6imDlbf+Q1O
   w==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="173122945"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwwYWG0EOhXrgNKUJ+l7XuwbAj1bMMNpbaVeaert23WaLgItFpTFUMWyrPM+Rj7HqwAWt2CkVNA56f/sQYfIMSh38iAPgiylmAgIxAojTGX5jfusMcBxJ9p57aJ/R+lXcPLC+MieQsFdN97Nr6f8tGhcsHLGauxYaxpa9T9yP2jeJX2uQH5p9ovNzHoreZh+eQnrvV49dZ0TkJjSyvDKbB2LdeCRnYMybppa+Uqa+jkLFCZabt12olYwZX4op62dvLiiWL3YQv9naUlTy0PatbqYIuJg/8Oyszwy2gSchtvNqpgdeMKzDwSm2iDVteX6nIgq8kLZb8KRDkhLukK64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul0JnRGNo4mONJrOa15zsWgRBRo+LPdW6qS6vE4ryLY=;
 b=fM/TYHUoSQ5h26c4etiXvqR0ZihD+RLVLEOA9wCLRX1TKbtCkXOowJCBrnshQunMaG3NlJTHr9PB25oi/hcV7baauXunJck7hChMxOTOeVwIg1q87KyjQFqQF3BrB2UErV3FUTP8DOzDy/rzlAo52t6qkoBzW9ciuXaPaskrmbhiS/ifQMR7I231VPre74+R9/i++mAfwkFipJoEJZZ6/G3Xoa4GcziV531uMPYmGT8PZekGuHWv7BU5rCzhv7xzxvpBnokBxAXUxz+XzHPjGWZuf89sj+ZY+acgI+LvzC3mqdWttUiZosse29FxoZPPvuSR/dBPgcHuxUPJH6maFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul0JnRGNo4mONJrOa15zsWgRBRo+LPdW6qS6vE4ryLY=;
 b=d4arEQvyOZfZwq/iCgfYeHiVvPvPBNXKKGLONHR8rOKllqHykTvOvRmz+VPau83EOhsn5pHm/2c2v/nOHOxJ1x79RJV5Y8fGR6ZQYG8iBNlsKUCswPqT9b6I/8fM1mLuT0RF9JS66nAm23L5GzTigKy66xrMeMgLwFjxvT2XksM=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:06 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:06 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 6/8] wifi: wilc1000: cancel the connect operation during
 interface down
Thread-Topic: [PATCH 6/8] wifi: wilc1000: cancel the connect operation during
 interface down
Thread-Index: AQHYnFIyKXBWLfJKwUmhG/brPRejYQ==
Date:   Wed, 20 Jul 2022 16:03:05 +0000
Message-ID: <20220720160302.231516-6-ajay.kathat@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
In-Reply-To: <20220720160302.231516-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 747d0cee-905b-43b0-902c-08da6a695562
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgpHEZbnepjUXjjzYU1PRcTQRFWS59iHEa779BZ72ybFL77UCdzNK4ai3OENuUnwvrSSNlC0HxKRX5dZ73R3hSpj4hsPeIO2ycEeeU6kwYJr2+3ZGkyIY0YTufxTGXGCZm8Dd6FHgz3mcJzQvcRAAN+bSPpGFsO/BRarT9h76MIODzdLDV55YnoPleNvvzU4HAZQGDpwFS3nAVaH0NlIFZh8TDxx++jSkM6BJLf7s2p8CQj0xvZYwuWMQIh8s4mGTg1rb/BH6vuffZ7Ewh5JxYz8IUIn/Qoo1Lh1MDWMzQqBSgat2CRqJvG3KT22BDy9Lxt54KhtBp52NT6sD4q+fDhx3VCVcSkOhk6qPP/T/thrcj2JQJmSRhE1AA/3nLpT/RVwn4jpxd/z4dRv6v9aga/Jrp3tlFvIuXZUUB2ZgzQl2RQz3JeniNW0g/Ic5evl+Tm/nJ5ms7r4fb+SmVc1fxbXRUjFk8f+jDvZUE0WODvDSoIcjfylNkrGQ9gt9Ydc6iCiNetEJwBWoKmSo5gN3ic6LVCMcOoeP5MLMYlAxMnc9mRlypv3uAmjBQRM1Tij0N2rpPCpLYvdbHer0NLN+px5iQm86kDq/pjvrSRW1XV9FA/hyMndaoDYQ/lxHNc69JlcfUVAC0IVIiiwgi26Es8ChoE0WLRNuQBkOIlh/MV1/jE0p36ZmqAYsvc6FFrW1jabzkIRSPVlMR7bWlTjx75j/XufyFKGNWHwsPJasYblctp4kJrgMu0uesGPkju7MoV7DWoTzyBD/g1wL4lMDj6GJmSUxqLuTjSJvR5mCSU3/TY8k4rVvch47c9e4Oql
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?slYrI1Y28Snj4QR8wMO38rZjUqo/qockoNJg5pHYMZH9t9qVxp5qitW1n4?=
 =?iso-8859-1?Q?JRQXN/IeBmcVwFFTxZvxUScv1fwBLO7GV+Kx9sZ8SzCtuXdNO1AXGdVnAW?=
 =?iso-8859-1?Q?cdVwdm6kqf1Eu87Q1LYyI959mNOoJASxQqQafDvctdzawtG3jEoINJVOFs?=
 =?iso-8859-1?Q?9Iiqlq2betBfTOjpMdNRDoFHWHzE13Z2Jx0q6FN1pgI7SzGraBHNkk3Xf4?=
 =?iso-8859-1?Q?zQkzX7eal6GucC3tQdDiS5XhNwyhWi4+XCIg5+wEtOVIgYlUvmhSNuw9aj?=
 =?iso-8859-1?Q?jkCBLKJg8yQ1Q/Lj6zQNbg+htUPGUTQ9bPQea36VZ/lTuIQFNaL0k7TbRa?=
 =?iso-8859-1?Q?9kyaS1zCIGGyNHUzib6xHiccluhGw0i7nG6eQYljReodsciyFK3zbfbKKK?=
 =?iso-8859-1?Q?PoOtLBxU5rJwCLxf9CsC/R09GF/YsHZF3QUmypInobmL1KTPomsXtGLXUz?=
 =?iso-8859-1?Q?a64ipEQvFkx4DENMkc/dEAr6UBZdXm9ksNeVnTUHkKwb3+ab8BPMTpsATa?=
 =?iso-8859-1?Q?wr09USxmUJRHTiJzSTNCT0lwRvriadY7iQXEH8oxM3PL3xEYMPYNhLAa8c?=
 =?iso-8859-1?Q?9icM7B9RaAiEmBRPLaVvWnjQNKb15V5Qb/S35OCJSwdjwvwoyle+nKE1nl?=
 =?iso-8859-1?Q?CwfqQzSw36+FJqbyoll4Wiv485YoKWKunya+Djt9KL34JBt/GsXobwh82z?=
 =?iso-8859-1?Q?+2oLqSpUiNJZFTxQB4MoIWIZIQmROO8HVWJ24PwzUKBNwzTsTDHJqF4aBc?=
 =?iso-8859-1?Q?gMFMdeY6sjkE90aZ/Pr69ytw/aehaXEqbpRC+d7b1+8GwXnWbDScGBuZML?=
 =?iso-8859-1?Q?zPo/R3AsXLglEorIY6wScqBKWnqBcnvP8FI1czWP3z1omS3fylQQlu/IIq?=
 =?iso-8859-1?Q?8PzaXHGyFYEf0zCe4Yd3JzvvbF6lFFHiKuwxFoxciTOi7K5jFlN+DejIhh?=
 =?iso-8859-1?Q?oBV2GSJmOsonGBN/AJzWnSMD/shvRe4frEfK37oXMTVesNH5HA+jeAcBQ0?=
 =?iso-8859-1?Q?/1jW4RBdWA5zmSwkYULBz8ZLoccI61o6n8mGfe+bTqa77GJchy4C8uS7mB?=
 =?iso-8859-1?Q?K0na8VfNbhAVy3hg8aYbCFuwhKL2lXNUybBUa1O08iqnpex+kcczP+O6i2?=
 =?iso-8859-1?Q?50CtZEbqP//jlu4anYxKSK00bDmEYmF/J3I9VDTDnRd1vuhHJTroyN3R3w?=
 =?iso-8859-1?Q?jBFimEBqm4KLK5QU9KtsC9ghaCW30m4MbvlxTp3Psf4Po9DRQlDdNTOgRS?=
 =?iso-8859-1?Q?Z9Ntk7NkR3p+X0FG/MmsrDn9oVsMF8kgaGa0Qpo0fU9Se0noLlttwY58zN?=
 =?iso-8859-1?Q?dofr8gAqTXlZokzhnLq1qTDk+LkEOTthZNxzYh2LqKqokWEwSU8iDngHId?=
 =?iso-8859-1?Q?tuogI+5UuV43/hjh9gJNrD57wwC7ajNedGjpMg0yKLM8u5gPrWJir3DU6H?=
 =?iso-8859-1?Q?CFdg6iPhHCmcp8h8VGqRYmvMjmtGX6Hi0rFUVGde6Q8YihtzQkkbR+xDjN?=
 =?iso-8859-1?Q?wllY/uCvCc4WqHIfut8vzwIkFbj4pqpnGCYvaXWtxPl8EfHtC5dj9/iccS?=
 =?iso-8859-1?Q?oEIc/UlK8sRW2VraM5ESFO2MFAx8z/zC37YaWz6SxpSZMJPvWWGGY6U1rC?=
 =?iso-8859-1?Q?T2jvtXD+Fgqy4nKC6gAG2SbhWfM+WWswC4L8q5XRoi2PFP9gAgBy4Dj7u/?=
 =?iso-8859-1?Q?jNgprtyw12LCaiQUhMM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747d0cee-905b-43b0-902c-08da6a695562
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:05.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhcjZAQoXnFwbyELOjXxAhxSX39cDY6YaAT1Opx7PitY83edn+s/51+NtVlHZ+hbZAJ/VFiH+oVXpsX7pFwibNait/vMaZ0xYh9VQVxLOqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Cancel the ongoing connection request to avoid any issue if the
interface is set down before the connection request is completed.
host_int_handle_disconnect was already available, so renamed it and used
the same API for 'ndio_close' cb.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c    | 6 ++----
 drivers/net/wireless/microchip/wilc1000/hif.h    | 1 +
 drivers/net/wireless/microchip/wilc1000/netdev.c | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 021e0db80bd2..b89519ab9205 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -635,7 +635,7 @@ static inline void host_int_parse_assoc_resp_info(struc=
t wilc_vif *vif,
 	conn_info->req_ies_len =3D 0;
 }
=20
-static inline void host_int_handle_disconnect(struct wilc_vif *vif)
+inline void wilc_handle_disconnect(struct wilc_vif *vif)
 {
 	struct host_if_drv *hif_drv =3D vif->hif_drv;
=20
@@ -647,8 +647,6 @@ static inline void host_int_handle_disconnect(struct wi=
lc_vif *vif)
 	if (hif_drv->conn_info.conn_result)
 		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF,
 					       0, hif_drv->conn_info.arg);
-	else
-		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
=20
 	eth_zero_addr(hif_drv->assoc_bssid);
=20
@@ -684,7 +682,7 @@ static void handle_rcvd_gnrl_async_info(struct work_str=
uct *work)
 		host_int_parse_assoc_resp_info(vif, mac_info->status);
 	} else if (mac_info->status =3D=3D WILC_MAC_STATUS_DISCONNECTED) {
 		if (hif_drv->hif_state =3D=3D HOST_IF_CONNECTED) {
-			host_int_handle_disconnect(vif);
+			wilc_handle_disconnect(vif);
 		} else if (hif_drv->usr_scan_req.scan_result) {
 			del_timer(&hif_drv->scan_timer);
 			handle_scan_done(vif, SCAN_EVENT_ABORTED);
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index d8dd94dcfe14..69ba1d469e9f 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -215,4 +215,5 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u=
8 *buffer, u32 length);
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto);
 int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index);
+inline void wilc_handle_disconnect(struct wilc_vif *vif);
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 7879446f282f..2de5838a4426 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -780,6 +780,7 @@ static int wilc_mac_close(struct net_device *ndev)
 	if (vif->ndev) {
 		netif_stop_queue(vif->ndev);
=20
+		wilc_handle_disconnect(vif);
 		wilc_deinit_host_int(vif->ndev);
 	}
=20
--=20
2.34.1
