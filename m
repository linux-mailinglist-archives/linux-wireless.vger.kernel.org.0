Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A840E423
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbhIPQzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:55:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34431 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbhIPQwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631811081; x=1663347081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E7/VJTemAKmx4QX7PmjUd6Ns5GQOhLDgrcY9E2FK77Q=;
  b=Ls9Vy9ehJ3wBx83f3yGz+ZtmKJC7cRWjxT5zb9eV4g8jwxapH5zi7keb
   OUgADaW1+8RWshXR0mh3Nd/8ffYQmjRI/pf2P8KNi/C+U8O2S3ME//4H2
   x76ejlT2bA+CcBFfFlw9tAvOz4svHDBqPNJLhvq7KXRxpyObayAwo7nAX
   W4kVwMYX3M03EtZYacSaC4rv6R7jXOF3oMMmbP0rJGe0eO4uYVC9DzveA
   eXukrwW+lwTpGcOwR94aJcocQUICFr9k9rC5cy5zJzHpmEBcT5Z3m5sfV
   HlXec+OxiD/g/FbmbufhliwthpWbNUi037SZzouIA9Wy4MzD9V/FXM/mQ
   w==;
IronPort-SDR: i+9UVPTFwUfV6rohwad8OZ9wlNfkG0v59OKc80FGq7yVWst9goGzsZ3Ow3YirifxoJCEruPbvA
 bH9aEEy1FHasKwZsHuNPVxhHS78Mv2yhAfp03FpfZb9fTAU6qErC49i3EzlId81BwMTZSt+r1q
 /ZBSyxVsvcyhv+jfsiA+0QMFju7VWV6jhQQwizs1I0g0nDg8cWi9ahLlvpAZ3Kqbhf8yQlbg6U
 g6WqnMplxOFRBSFRXUvY5jkewYw1aXrrAa6hMc/CdTtCXdx1JBdmCNIk3ZfQ5+YJmAprGsq7aw
 KrG1qmWc9DBvHJB++vX6w6Lm
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="144413620"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCVXXJHglpuIP7cCiF31ZVkQF+U3+5JbcVFdxIvZeNNM5ZfUg8k2+ZQcDjVyXnzWm7wjh6qKFQ+dpbhgUaixTVdo23ZCtA5n/feM+dXXMF1sP+fK67Mjj0GMBqqHf67iOx7Xi2VMQzw3oQHiUEMvxiXCAdQ6qZUwZWGwiLSPe+JVn32sPfSEeoDPG/K8Rmc27DEniG9/PkgqSxIRreb9MZe5fMWBnR00kCgW/GHMvCPRqmE/dVxe9NnmoGU/1n4lTtEXVYXH+obNFo3ikFr5rn4FjO+x9zQxHkAYIMtm2MkDiX66w3Rp6ADjDJ/NGymLOCTNzv9LRKY68px0xYtG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13y8K55xgPs44YuU/qwIYCcifdyk7ZBRpoQNW6vmzRc=;
 b=XYj8Zikt/Pay3ECtzVSzGAREpiykt2r/2ANwUVHZyZ5/OmCt9UBtFe1/QKkS+Hyb1nILDiFGQonGJix/PTtxGMYqUbw5i/oZKsOG1++rEPB4ZnT7CLO2k7WauKZCGViQhbYP7w2LjEy1IasYudEOIf8zxwXU+GJlXCki/R9wgcqbQdyDLwEdGqlu+9DYxOduoAfgSwaxlJVuWs80iZstQBY04yAe3f/EUMX3Z51GOrBSA45mhPUq7YRDIcY3yrClHvZzZfe0nOlkpqs13pI48hhBd6GeTRW85qa30tlENDN2+Nup0swVJ5Ho5h0yIPnJUBkN5J8TuJtFm/K0VJGVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13y8K55xgPs44YuU/qwIYCcifdyk7ZBRpoQNW6vmzRc=;
 b=Tj7rgLDHR1JUE0WZ1YXveskVqjP3kda3mDpDsFMn5toJeiYza/djaETUD3THgJpmV5ywdMe/YLNMBeiiw5olUrKf3xXe0T0BAX2+BShOwGh5imX6I+PAybhWn7bSDQZ+VD29SUnKZj7Gu3ZXOB9+uZWz3Y9teE1g9X/S0/LcxjM=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB3990.namprd11.prod.outlook.com (2603:10b6:a03:18d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 16 Sep
 2021 16:49:22 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:22 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 09/11] wilc1000: add 'initialized' flag check before adding
 an element to TX queue
Thread-Topic: [PATCH v2 09/11] wilc1000: add 'initialized' flag check before
 adding an element to TX queue
Thread-Index: AQHXqxrM213mtmxsUU2Uht1acpP20Q==
Date:   Thu, 16 Sep 2021 16:49:21 +0000
Message-ID: <20210916164902.74629-10-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3f1dddd1-a4ed-42a9-265b-08d97931ef16
x-ms-traffictypediagnostic: BY5PR11MB3990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB39905A9FF192817DDB5A405DE3DC9@BY5PR11MB3990.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkhIepxSgMQzhCjOeEDCLEbgn/nwkVicWeAxCvndg5PT0VrQ7/3i5ynpYtXzI9ylPh/j3aIZfGvPgqAZfyq5EhKYsXDBlqj39UpNQRABWQ00coTBlrtpN70wOZyaGstqgdCDPKK4h/nLrSfNSouuNcBKxs2XrwhJwUrk2tq2pn17cJbUplppYSfSIR31gyyv2dQsxCu9IdcmYn2yJRyuVnPSZwmo+uRgfMQ4Fd81I31M7DdAfblrHCuMn+KQYMI+2L7BZ2VPMnnUu7+7ctjCfemdgI/LQ6r7jYG4V4N1XWtOLRjDSTcDTrFXPkNJSpIATg6ufsMkr8goA6uKnDNmJYlB28HfYPalqZfmwHuxbWZi61X7ezfbrHjpuHlEXDphWWa2Rx9QoYfVZIch1qHzmqXQWam9E9rYmwOftOsDJ8osPI9JY+VMkZFrttxrw0KY5c/hgEWzXcDJKri4EIX6Hj9xC7J++1yZeSITZgRarQnNCcNJ7Dk7INu20f9avrNSgsaimYfKci36t8y1lzL0KR6o2avZccuTzEXzmfkzQ01nkXmMaFa2vLd5+tLGAtp6QmoBkU/oRiIVW5ecmSkD50uuEYV0eiIxEwvZUWeudT+95m3rpSi5gnjge/MAsnSfydYYl+QfUYRoUhCoIC4O1ljsyH89fKsYGGgv+LNvjlkHy0LIqcJChxGus90RbZMbvoDFq16dvoFHjQdQJYOKIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(64756008)(38070700005)(38100700002)(66476007)(6916009)(8936002)(76116006)(6506007)(71200400001)(66446008)(2906002)(4326008)(107886003)(8676002)(66556008)(5660300002)(186003)(66946007)(1076003)(122000001)(54906003)(316002)(508600001)(6486002)(6512007)(2616005)(86362001)(26005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zwm0Ry8tM3P2Ewd2aCiUk4PKNc9AInFPc/Cf757VVnHWIELZimk5fKhT8h?=
 =?iso-8859-1?Q?+XieOLZhsfGMNtAh0REHcgeM9AcipOcG9OD6HIT6P0BEjCeso4VeeiikAI?=
 =?iso-8859-1?Q?GjsNOOZr3tzCaZt+QRkqeok9v9SBxykxyfA7wteKrlNsH0KlZtwrjhiF+m?=
 =?iso-8859-1?Q?AePBUYZ93rV0dWkH8HGlwsIvV6qE8mk0BT4WG2Y9hR/snKx4ztKYoG2x1g?=
 =?iso-8859-1?Q?TOZDMjwZBoCHElRyC/SR/zswTazwxoFiaetpCTKb/jfNsDiEGaT2YlZ1Zq?=
 =?iso-8859-1?Q?a7+GI9CakH97ITqzlszmLWrkE8X0UA3GB/b9Ge5sfLmv1GwJLFuKFzx/GC?=
 =?iso-8859-1?Q?2pWLP7zpIe88hWQMOH0/YQ7+YPETXhNodr8grNw19okXI3na6CzeZD6/Hn?=
 =?iso-8859-1?Q?MQSB+IO3b6m6lOM4xGJ0CvQbIji44eeEYQHv1LypiAFBhAyo1AjFlCtnF7?=
 =?iso-8859-1?Q?2mdNPaZD/ZxRKJPn36rRtwelK7SNIQeY9TzGGZQGteWIzL/v5TUgyR8pmK?=
 =?iso-8859-1?Q?LlGsorWdQjRY2/DZB4dBplEbhooqaMsQotSQgOtuUFE0HBPCvI35m8XzBh?=
 =?iso-8859-1?Q?ov6UVTK8xjKbC6wXxk3vX133ZX/6ekg1ISFo4ZaVCZu14Ks1n1VSBioiqV?=
 =?iso-8859-1?Q?xdEtW5x6+rSA7H8jLT/bB+Subwz8v4SpMYA8jRWjDdOUdDLlE6re6obNbb?=
 =?iso-8859-1?Q?7OVbpdmnZtbEYJMhZkH6+QKbYYt5q/SdBIrqkqzjEr10j70YttGWpjo8cs?=
 =?iso-8859-1?Q?GojIUcrijNege5ZfOaHk2b5CfBmPTT3Acx1F911Ckwv5G0k/zsAr06EJ0O?=
 =?iso-8859-1?Q?g1TRxbLGfOzGBIXp8xCkW906VTD2KVT7roXz0BzuURFM8aFlrEk3XfTD1f?=
 =?iso-8859-1?Q?W8YCMRfsz+lh3RVqsyUr8s4yK027rgE9h8eCLv/mvZU7CYFeXPoSt944Tq?=
 =?iso-8859-1?Q?vPY+9JHv7k0IJJfPJZXsBUqzdyQDW6HyF4an0nWOBs8KFXIoWe4K1Dj6ct?=
 =?iso-8859-1?Q?ZSSG49+8IurGeHeV3eJkrCfv99UUufwZBD+l7tTrTZHmL/pjI+ogc7jloU?=
 =?iso-8859-1?Q?jk6JIqTJldozaBsGUNlRpGod6cIMmnub9UDomd9KXhUft8aQuaMRnlixVB?=
 =?iso-8859-1?Q?t7usnUZTSlHuh14p5abH0e0ahbrhqUKX8jI3xNZH+GemQ5L9bmXSJgqk/c?=
 =?iso-8859-1?Q?/orX1xe2nifBxjZ++vuUMprxIetMU2KbFLopztMvumMzsOwWz9DH4Uqxva?=
 =?iso-8859-1?Q?EGZ598K/FfFHxHQhI70JUOYvOprAEzC/6gKKbUi5zrKVrhaPSKogAjFjin?=
 =?iso-8859-1?Q?gQcINPIHRl8eRPsGiw7D7OCrMrQ2aqV446vmv7uADgu3IEhW8WTgZl+ydW?=
 =?iso-8859-1?Q?BdESyVq4cp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1dddd1-a4ed-42a9-265b-08d97931ef16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:21.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54blTtq1upL9KWuK/OAsaUNAvuW/e3QGPOqd9VvEXBkqKpmG7J9dEvR/03heeYjTWy4n8Qe3EvkvTJR0M+YjqLJj8scQZviSHyda5VxNdXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3990
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Add 'initialized' variable check before adding net/mgmt packet to TX queue
as safety check before passing the commands to the firmware.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 4 ++++
 drivers/net/wireless/microchip/wilc1000/wlan.c     | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 91a471f3b1c8..dc4bfe7be378 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -728,6 +728,7 @@ static int get_station(struct wiphy *wiphy, struct net_=
device *dev,
 {
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc_priv *priv =3D &vif->priv;
+	struct wilc *wilc =3D vif->wilc;
 	u32 i =3D 0;
 	u32 associatedsta =3D ~0;
 	u32 inactive_time =3D 0;
@@ -754,6 +755,9 @@ static int get_station(struct wiphy *wiphy, struct net_=
device *dev,
 	} else if (vif->iftype =3D=3D WILC_STATION_MODE) {
 		struct rf_info stats;
=20
+		if (!wilc->initialized)
+			return -EBUSY;
+
 		wilc_get_statistics(vif, &stats);
=20
 		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_SIGNAL) |
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index de5287cd8652..ea81ef120fd1 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -427,6 +427,11 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
 		return 0;
 	}
=20
+	if (!wilc->initialized) {
+		tx_complete_fn(tx_data, 0);
+		return 0;
+	}
+
 	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
=20
 	if (!tqe) {
@@ -476,6 +481,10 @@ int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev,=
 void *priv, u8 *buffer,
 		return 0;
 	}
=20
+	if (!wilc->initialized) {
+		tx_complete_fn(priv, 0);
+		return 0;
+	}
 	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
=20
 	if (!tqe) {
--=20
2.25.1
