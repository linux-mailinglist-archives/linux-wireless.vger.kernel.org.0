Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D557BB07
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiGTQDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiGTQDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF74E848
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658332991; x=1689868991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6GeNeXNnf2XNG5PrpvpfFeFyv0XZ4/Bpehgtvo+QziY=;
  b=QC1P+d3G4STGqlUUKHfD6NB5bM9HH8+V81Wcoexf9y6612u1zE/WgjyR
   FGt8TxICHJul4nAg7XDBO5R8aB5TNEUCkKng2BSJB5jNdv91G7UMJJJ0Y
   bAQSikezn+zH7Af6ef6t40OVSdhF4QnFTCLbPC71uKZP7vMTT0dr/vq7h
   Fthk+xJhS09PVzgRwyerJOmyhF78gm4x7Iuxfk5Pjgnn4vm1Her0YRnI1
   rRpOtmyU5syDzpBXXZFxmEhupBg7O5+MTRa3W+VtTM/8k1KQ3slsGzWLd
   LgxoHdvSSp+6QrupOAK4Wcjw5KdRRj9tWzoRiFBGWwbnbWsbPLUyrEk//
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="172930050"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk8zdUxs1IzM+IpG424mkBLjdzfMt6CIeJNc7jHkLdWWkAwVGy5Es2elEa5WkHX+qtCwglxWg6+kqiPBD+ucN+rHF1NJ4h7ngKfcg+BaaGKIP/uH0VkwRmwovgX/dtsBQDdFOPyHbhKa+XBqoPbPGnrDpVWj3KXAoEzh5dRZxWYsEBahPy4JnswqIUyZjNDllrVr3qLAaHtRGIvM/LzAmFs7B3brR8A9re9QgLT/AQrPH9+psI5BebYga+cSdI0wmKx9EXIYC7ZatxuGEwKBRN0NX0oIM7ErXp1eVDl+Oxg0PXYUmiSd3/NERF16U2RQ0oAUHe4oDmKvVw28ozCk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpoM0WdmcqLjGW7pFDSsROZOGguNTpK7JnHUMsK/XDw=;
 b=HiVH3f9wAgMTZw2PQuCIVE2v8/PUFgU0rK3piWjvNqXXuMqREXLdPURtjyZ5krdbIDR1DSRLzjTcPCGD37b8Ve3CSKQDXjUKMDSEsPJ15eePHcrdecLt0J2V0cWr9+xn+nhuXB9KCFO+HgI30iCYBh35u1ST9nq8pp3eyqh9zH/cOPUetEuwUaQJtIDMcOEW0EK7yw+kYHtOBKSTKtwAHyMcLrJ6FFgzs1MFpKAQ3FpyLBFS5yz0nTKG/c5vEk/yvJ7AgBYR0+xShPn86DhZ5v3P4XJLY4KtibZ9NB2fYDArNjmgECStmGgaNXgNZ+41P56jY+mf7+iBUOeUQrR0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpoM0WdmcqLjGW7pFDSsROZOGguNTpK7JnHUMsK/XDw=;
 b=Vssf5dGc3zNwuDAn8mzKFRJS6RHEJAj+gu9bKkECRaHqTmpnV7NBahVC1Qpkm/So+Yro7x7lBP7ihHcZrvJfWMdkQqKrrC/Hah158Ov9jnberiAkOV+F8IkbtQo6nUxjnVxZyHSU+iJcyFmaAEGnaY51PZTjwN0O3pCC7C2JGnM=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:07 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 8/8] wifi: wilc1000: use existing iftype variable to store the
 interface type
Thread-Topic: [PATCH 8/8] wifi: wilc1000: use existing iftype variable to
 store the interface type
Thread-Index: AQHYnFIyORgkEhzKqUiaORlNMx2lfA==
Date:   Wed, 20 Jul 2022 16:03:06 +0000
Message-ID: <20220720160302.231516-8-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: e5f61f84-7924-4b67-dc2f-08da6a695614
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWOE4h2vES2lV0g6Ne1/UDxGBuVmSCyFEWtFTIscoVqz8eCFHjA14SDaFAVK41U0w7H21IAcDiC7ehw8CG2gOQ5KWDrYQaqGG6UKP5AP99q1K3sykWzrR9FpbjQfkASXNpSutTaW0AB0Tg9dRzutm8IEqRnzaXHJ96sCqADNDbuzAU1YNHeCJro7YGqLPrb8IUhufz50WS9E8fyok+VH36KJ7ZJnO5xSOtQSjSM4bEtka0Iq0guAk4UDpK/aW5+DyB9mJDF0etcGGIUF9kqSPZXVEPUpxueAamcDDQWZsFvlEk9JwPK3gpOsdx/QozRBRONfh4vwRmWJsvGj0cbwEedzU+JDWgCIBZWQ6iMZgIG2MPHo7IZl79gYmFJ9S9dy/fdlDWxN2kTQgxr//Muc/EFNI5bYZHQiUyCd9F1XWTuOmBvrDJVi8Zg7AT/ZOoSGi3JtgqiQJFyQJMkEkCvVaeB5KuWCmHpZVBymFGQPJF+x0VStqEXVRxRRwQNwhRp+DHgerbR2nf9a995hgrCHTwrpsFgGNA3Qcd0/p3Vu14kuy2AJ33rabDnF659YD4rCU1MzuRoRorDMGIKe8DxjgnVCbH6kvXnf/m3y66rfR8C2vcuZEKKISzaWqLMrPYddmmM9DZjXWAFhhxDYEP7AgPMOsMW0NQM0eT6YnmHbvI3PboNhaW/08avSRAOM/j3g+V+/1+8BZwJkvsERmCgJ6lOVj7VhjvoT0X/k3Do9DGVFB2VtNDcy4I/Nl1FHIn0Cdf7MgJNCVmQzfDUT+LslYnZ4oR6DRGrE4Q+fPD4gE/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hnKrxWT7UQ7qAoiQP6g8Fm98Rpw7pYt4rFRJjH5fC/juQ/Tc96SA4b+iLG?=
 =?iso-8859-1?Q?ANO0vGSy4UOp6Drlwzz3nLYJqQUn0MVdzDggZaow6P1DDvYLGpe/BuvjJF?=
 =?iso-8859-1?Q?05aH6vtS8md5pL0zuSgjMcRpWTUY100GE/Rd6fxPGZnnApNdRvI37txKuO?=
 =?iso-8859-1?Q?HsIGhTeLstF+8OQ+wtm8pFQvem94z+mpPMPPdI2w9Nysvyu30bBsgRzOkH?=
 =?iso-8859-1?Q?xRB80FrwbWAZO9eZA6M23X32f2gPmU2gu44a/mDUyQzCcZPlHur+OiwmBc?=
 =?iso-8859-1?Q?nN+6O73onS390U70TpmBYOv6Pbbm/r8NMcgjwv5UPKh1rgtnXaDPqHG4Pl?=
 =?iso-8859-1?Q?D3Nkqsvx34dt0Wlxmcw5QHL0FjxjUeX+c1pjSr+ykcqa+j/H+SN7GfK/ZO?=
 =?iso-8859-1?Q?MQSm64Ed8xvVavhZ3cM1yn7dC02lxAODSgMbIDkADzTVIN+ITgQ2N7duzc?=
 =?iso-8859-1?Q?WZ4XLYrIxwAJwhaZr8PVsB1AxQ5Q6IDOa0TXZzHFnM4AEz4Ed6S5m8n3D3?=
 =?iso-8859-1?Q?kx8J3hS0ysn0UDbt8wKnKK1Qs2GPg+9i+A6q3bsWd8F9znvdi6+U0GDq7d?=
 =?iso-8859-1?Q?YNBkIv/XNiyTLsYHmJlMiQpwWZQp8GX528a3USEuHqZTKpOjSztux+datr?=
 =?iso-8859-1?Q?OsAU67WnN/OwCbVTsjZSFUZuoAv8b31gH8AIl+nYBXocw5divk91XUuofC?=
 =?iso-8859-1?Q?tdzlPgG/jQzFNDXw8rndaPsPGcqOrmMcCsUQsS4ShTluPypRZV9PTMmJXH?=
 =?iso-8859-1?Q?LZ5TTgk1LEfwF9AgmN26C2c2qtLh3awlOJScVeQ2kw2EV0w36vrJnS0TyP?=
 =?iso-8859-1?Q?u2imDqXhvY6FibKpcbRQMzA+4pcrzEr2JiydyI3jSrAXU85RCnR2fgEiNJ?=
 =?iso-8859-1?Q?qEsf2G/uyiGpJ+WZixfD+s7ujt2Cbyts0duewhHcngai/PsB6yzB0Plc4A?=
 =?iso-8859-1?Q?9u7xwF9X7WVWd/5VY+rGad0BmkfUICYFcrrX+fR+ABKCHS5XeDNWHuwrMe?=
 =?iso-8859-1?Q?GvOJhqyWNfQMEWfdq/8+23eSrU+Ckzn4IofZjgoW1C4gg7Ghtiu9vSAZb/?=
 =?iso-8859-1?Q?0wwz+AJjonVGxLrkyIezjaQogvjlCmMs5XijHWo4XDH1eMdDxS6dgrHtMR?=
 =?iso-8859-1?Q?kRkWHEJiJGs+zBADjCi4hvQWTOhkBtiyYW2HDJgRWYJ0HGHGfVpL1MeEaA?=
 =?iso-8859-1?Q?rNM22VnSrmU2H8sCOhfoxWz6VrSQnwVxkDhl9YvST6t5RJfZEmh7ajXuek?=
 =?iso-8859-1?Q?hpbkTCEIY3jV5Q3CfaSDnS9XDfIvz+LQwMUcuCe80xdHLodLqhrUd0vgCK?=
 =?iso-8859-1?Q?9YGz3KIkw0Kjo+mMbAq3KgIlgh/aJxYhzNluW9Er1GVRofCD0JZK/rHIDk?=
 =?iso-8859-1?Q?huh1tbUZ/sRBszmgJe74+GbMwgVVHbbPeMcOWRMX1V74Zpn+HmBrBfJQla?=
 =?iso-8859-1?Q?mPSUp/m8bJlXCfH1gMeBhGlt0iFTXSLmZ6R2exiJS1gvEi5QKuwygk2Xur?=
 =?iso-8859-1?Q?3uuvZ4lzq7ea/gDv7Jm4VKpLX5zARiyeBhSlPInGe/b1MF8sbLEvFSk+0R?=
 =?iso-8859-1?Q?UWyjXs9Ski/vgbBdRtKRipBcYbMwzBep1SgGz30Q084oLiBHumCLZC6FFl?=
 =?iso-8859-1?Q?2DeGKq1R3npZBJKJSwcXMr7OS6KGTjyTVWlPve9BXruFXkzPKJFmU6oRel?=
 =?iso-8859-1?Q?Sy0EZ0/mlmUv7chQhqQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f61f84-7924-4b67-dc2f-08da6a695614
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:06.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/6Oeh7GvJ6MLg2iYwJ9tQ/U9extOJXeAGPNlD/UGLxwsAjeRox4x//giHOQD2/H0j1e+9iBhwqQ1OIpTKfv5iJT0v0vVyMDScrSC9zYMDw=
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

For consistency, use an existing 'iftype' element which was already
having the interface type. Replace 'mode' with 'iftype' as it was used
for the same purpose.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 6 +++---
 drivers/net/wireless/microchip/wilc1000/netdev.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 2de5838a4426..9b319a455b96 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -97,12 +97,12 @@ static struct net_device *get_if_handler(struct wilc *w=
ilc, u8 *mac_header)
 	struct ieee80211_hdr *h =3D (struct ieee80211_hdr *)mac_header;
=20
 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
-		if (vif->mode =3D=3D WILC_STATION_MODE)
+		if (vif->iftype =3D=3D WILC_STATION_MODE)
 			if (ether_addr_equal_unaligned(h->addr2, vif->bssid)) {
 				ndev =3D vif->ndev;
 				goto out;
 			}
-		if (vif->mode =3D=3D WILC_AP_MODE)
+		if (vif->iftype =3D=3D WILC_AP_MODE)
 			if (ether_addr_equal_unaligned(h->addr1, vif->bssid)) {
 				ndev =3D vif->ndev;
 				goto out;
@@ -122,7 +122,7 @@ void wilc_wlan_set_bssid(struct net_device *wilc_netdev=
, const u8 *bssid,
 	else
 		eth_zero_addr(vif->bssid);
=20
-	vif->mode =3D mode;
+	vif->iftype =3D mode;
 }
=20
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc)
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index 822e65d00f53..43c085c74b7a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -177,7 +177,6 @@ struct wilc_vif {
 	u8 bssid[ETH_ALEN];
 	struct host_if_drv *hif_drv;
 	struct net_device *ndev;
-	u8 mode;
 	struct timer_list during_ip_timer;
 	struct timer_list periodic_rssi;
 	struct rf_info periodic_stat;
--=20
2.34.1
