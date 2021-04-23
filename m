Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5513699A8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDWSaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62525 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbhDWSa1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202590; x=1650738590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S3RycHLprh9FaSb6TfjD9tdJys04/BnUJd0/swp8ae0=;
  b=ylo1JmgMO0QYvwFKjZmLavM1Na4JJ4lNs7bfQrO/qp/ipaUV5XPsckv4
   rkR0Rau9B3tAoAT0xPA15G9EsdHpcbkbY5iJnZRX4AkwfZ1zXLr/iaDNp
   d2XRjSdQzO6E2oo9Oekkoszml/qjqNPD7UWBf9I9ZFVPzzn3E6J7daXrx
   CIkiaQn2Q2cbIaoyzIReaqi91v2w9E/m+tzVbPL1EnL4duZN/AJVo5wwG
   AZICE9hLGLDbBlJzNdory1ber3D4IDb321Kqj0Ctwf1hPv6lhIlXLwRmM
   nLpuKbCgX69Xl4/S0ZxTgu+QLKFeNmE+M2S7YVE5lJKiaRwJi5uKhmEXI
   g==;
IronPort-SDR: ND5Ke5BW32lwcMhCmftiNaBA8gUt0brjpzUjpEmenyGll3kE0vSZBEzjpgyxaOxZmx/sc7IejP
 O1xdJ6UoSBZ4bsSP9C3Agh5QpcyDMvOelYW47979kXkkwpdsJBXjHevEzkwVildz5RITfkpMDX
 jhmZEfr7j4Uv8CqO94JzwYXi+RkceMc5hcOshOrTgarRix4ZAS7wxtXRXDrWQy6GCDr7AwbCH7
 1k17cbYLcKPu/1twpVnq8OWxdD48+16vBKPmV+aC8FuaVxj3/Pf84J2nmW253C6HwYujtBWCqd
 dBs=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="52310243"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKpJQCqJ6gWMOMKlXAu76lmi/qqtClG7ENdjzpBnAC3T6O/EwVVuo/AGNkhGxV4UAZ5ci4p98dsVimvgg2f/qJ623gy9SGzjDUrhJLRm2fiLkOPxGTAMnpGmeYeJnsn+mhw0JK4yt4qTDaHa15W6p3MW10qoO15IKwLhGemaevLRpov6Nc5YjREi9LrlwzZKNfPOsPYPEuZMBwJf0Se0EZ1kfvZh/Zjoc7ZVw37Fdm3fRWRs4Vneyct3GxqhVDvW8kTKMlIWs1yldTymmo8d0rrhebSoFErPInWPeFqIbc7rG+1cf8ZKWDMlDLmeOa5ugLX0gfXYi/yiG4zG+exEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXi3MkM6u13qPwJ/yDY/0n8D1DDqoxW+fknlF6NVNgQ=;
 b=RzN9Utwqr7EF9+wjlI8eHf8ZUbNso6GVZa0vEMrCV4drjxMmlf71b8RdpRd8hKv9bDRdaiQPbvuVkux1c+XSB+bmZJmeXLKn9pDOIVXFdgWluFtS8XFskN3EZXnNEWHtDu9qT7cXGqX9PKloZetV7bdM0M6oFSPAGd36Ln2r0P13ZD0bzGqZk5vuEH9o8dfXF9frWEZOoKnYHxVdWAmHpMrR8TOeKQgL+htlKqiLBDLk2wDz7Cq/Bw1VzKlIRM0M8X+v2uwbekhDO6qoushICfxp7ryOIlLCBFhHYPfmx1lWmdl9RpGeEsLilWvgEc+wz4nnfz7JPMQn/hDtP/lKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXi3MkM6u13qPwJ/yDY/0n8D1DDqoxW+fknlF6NVNgQ=;
 b=Tvdh7Y+GbJu9qlB/XJ9mLb0297g9gt4wLBYrVnBCDTOkkiP0d9O+hsXVDi3VNpgMsl6hQf1trJtOAcJXctfjHNNLuFNutLidbKZhB/gcQ2TKiMCh+I+b0DHUs4kkMGkqPfV0XkdR5HSddB/6ftTXh9GyeQK458heFgO+YtZn8oA=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:49 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:49 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 10/12] wilc1000: added initialized variable check before
 processing
Thread-Topic: [PATCH 10/12] wilc1000: added initialized variable check before
 processing
Thread-Index: AQHXOG6ks1bGRrdwpU+UhuTVuozaMw==
Date:   Fri, 23 Apr 2021 18:29:49 +0000
Message-ID: <20210423182925.5865-11-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 713272d6-e293-46de-028d-08d90685c753
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3318BA542C0BB33DBE4353FAE3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WGS20Gjy04VOnuLzioxjj3/iKU4H5W2+oQImGebmXYD+Y9fjTf8d494vxynDyPHrtS2IWCoN3Lrr/OXuYbm6qbhoJGYOmHoKoJiBBlx2pBLOh+fyYNMTI2OiyjpVeFoL44Sgk7Qytg6PBMTfpff12FWdab/uLA8GqICv1tcU26uQPC//Agn7kYIee4E88Vi0Tbv3zjhYwivr8nkwisvgzj+e9pDHL1YJn8WHbNCfsRYBrYlHpVjDT1b9cdb+rjtW5ZLPWeAdbU+Je6Y2MF/BYK7q0cBoKuKa4ma9x4xwGgAW18/wKUZZDpG8sm0QxXrRrMeGoPS600wGs+O9HFhuSws6j0YHCnqtW9NLtBPGpjl+FkrWZYl5WmI45CziCaD8NdjHbcnIGmoIXm99IXiLpvuAO2xrHaESPfshZyfiwm/+y2qyaV8HCoeKQWw9YBJwtmU5n8nB+45Ryul/qVYU1bVwDWQjrJkOcImxJMetO/OypL/wxybKgdBJ/0yhCL3sMwg9Z7nfJQprzbAwkPTH3GlZWY9dch3WE0XyEMeqONzSiUuEmvART6fPjYBLcRTxBgopqQ8v38sJHrU5uSIyWsmi3/abYdQZuUvUU+VgFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?LC/VNrLXsEFo+1p8heQ7tvBPT5UVDF6gKWePsZaMr/8uETAp0KgVMO1/TW?=
 =?iso-8859-1?Q?8aKHWdZM8dXpJOAK6MfpmxcPH1FeE2hqTgrZzP8dJKSqAJpYMJFveGhUq9?=
 =?iso-8859-1?Q?0nyhpXOCQx+iWfUIDV8OqGoUpfMYmBk2qnJCSM/osUK8dihxeqXwmX99h3?=
 =?iso-8859-1?Q?ru360R+Mv8stCBsJ7rGs3D4+IVUATjD3rwUa1PT4xX7sxN1zGjEN0iaNAo?=
 =?iso-8859-1?Q?ZljSei14Fg+P7CrMy3ug2EdVsPsSvHeJEbvbCTxxzGLd5aaKvshNhU/RYW?=
 =?iso-8859-1?Q?9qVcPjGL34wnnxROAWoX861blvCUwR5ftXLBpSp5RF7sg8KDwVxnF1IfJZ?=
 =?iso-8859-1?Q?78coTH5tdV1UReW0gXw5vtGYRMHuLVwe/qPUPdKzgceKm3JgI+ibsNsPYj?=
 =?iso-8859-1?Q?fKaVUcebswa69K4jICVuSO7Rf962HEvli7jSaSsWsYeRMjiK99p+lLvK4N?=
 =?iso-8859-1?Q?97bi7LBsquOQwo5TKnPqJghjJqw15L4eXTJ2vKKjL0ss8dkCZozb3dQ86q?=
 =?iso-8859-1?Q?otgMGsr9MlqNP4KnU/NnfGjRnnkgq8pwdHoqr0X91PdMBG6K1noFqjY8pt?=
 =?iso-8859-1?Q?ir1tEfcyUDbpJsk65WMPEPUpy8HeFojjBfAE8XBOyUCM4TFfOORLTB3Uyn?=
 =?iso-8859-1?Q?8QbbVQjG08quElgCnPZAAA7jF0uu0DXk0NQzN0QYELOijftFMBmqtsFg+q?=
 =?iso-8859-1?Q?cVcC5ZiKUkbA9BSy0BLgwrKL+5vMQzPAO9tMfQgJG1h/Pzb1yQdq/AdaIY?=
 =?iso-8859-1?Q?lYTrrXvnxwc5G7w6k4H1fAKF71cjgC7JjG7XpI8ZY2uVrihZpE/jUj+00y?=
 =?iso-8859-1?Q?nHbe4xOr/PReVTwS6Ai6BXcyaAjyFdfJ85LCJzZQqXCOqSfHKnIK4io6sS?=
 =?iso-8859-1?Q?3iy7wzopcff/WsJnaEArUatEs/MK1HfnvcLxrbF5rDtAEmO86d/RlznibG?=
 =?iso-8859-1?Q?4GXBQtQ51OrSXce8wWrw90h5ZO5twIOmIC6jS9A+r4RfNZScNAJDK2IUvN?=
 =?iso-8859-1?Q?A9xiI6VpHs63YrnlR/xIkhjfgd7OBv25hwSNgq+NGM0WOHK4A44lBkq0i4?=
 =?iso-8859-1?Q?4gz8UyReSHemSsDtaNsFI4DIL1aH1JzQjO8kBp/asPnzqvlshucj8Eylj4?=
 =?iso-8859-1?Q?BSLTMlkJUpQMrdScbO3m8B7H0vf8jt/HBRsKzbk5avAG9wlkQYha58f9KB?=
 =?iso-8859-1?Q?uR8Q9L/x33ZgD/ArW7AelGmnT11ER0Dhtm2CVoakg13/GNKudA/w4OVLyH?=
 =?iso-8859-1?Q?QZgyiuhmGvVvtVQ5Ph+dEjVgU2uXz/MlX7/IS7qlkDOMj2GakopW7m9cq2?=
 =?iso-8859-1?Q?WekHjrm5NnDJmtDavGbPZMLitlW74M2/yEkbdT76l/57bHgXHOMtnSDvio?=
 =?iso-8859-1?Q?zbN2AMRty/gdH+8MiiaCjGSvLB714sNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713272d6-e293-46de-028d-08d90685c753
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:49.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3IBu8NIU6VZnLNRg1sGn91DcKpkexHJL769Tr3jypNSd4D3S/csC0EnEEm6bjZ4QdbK6tSGUtl0CTgwTXWjYSG+KYon7to3xeI17jiyQgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added initialization success check before adding net/mgmt packet to Tx
queue and processing wilc_get_statistics() command to FW.

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
index 6ae5d82c6f99..0e059b889fbd 100644
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
2.24.0
