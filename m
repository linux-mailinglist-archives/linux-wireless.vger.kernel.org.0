Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26B532A06
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiEXMGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 08:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiEXMGb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 08:06:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A414114D04
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653393988; x=1684929988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+atr0/0MXTn7B0bydlEGXJeZuoDpzYPQdLS76n4uN5k=;
  b=zLltXAS7/gso5o0LzTkd8nDpg0JmAkSYH6cGnJ1owLl7d6z9A0x1exRU
   D0bomEJbT/6DapyFB+2NGykEFBHTLKI7ZINEqFDtcshZnfw+Dm3ynhmxm
   Uot/OIfsyB/nTWXkZ64iCAoT9e1h/bPKPlrgqsA20TM/kuSdtHgU/Xt9v
   Am3W+8eCJ6MWKwIVhbN6cCmrpzOa5A9MGrzYx6D+OfFFpLOMgrxdtSu+E
   CzE0G1dK9h7GepZYSueJrzZxXrcHfnG1uT8SGg6vKKdTsllKTTa5yuFAX
   fGnzVzqyKVVSd2QNDjRiKSiRL9qXTOO875p8qoio7VQHetSTXyJ33OUWU
   w==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="174813211"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2022 05:06:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 24 May 2022 05:06:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 24 May 2022 05:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFhtRxzG8Wx248HbiQx9xUUMo14Shw4pDipRhCfEJJmNgl65x7+Warid78z4m/+j3nWMHqCn591QO/2+qkleaex3u6/3e23BxZobmuKAsfCeKEPWvk1trvL2eUArbtq/vya6XvKSnVxtyONIJrwsgu0q9VD1UxgbzUSo1siNpQqb9d0A9plFXkbAASV3wZI+D1KwqGUmL7yF8Tt71V13SMtdlXAFvZaRXoeHsvnIc17SG8004K6BY6vAq/eZ3R2fY46OpRUfUQcm7BhBkpW76dozo8vXAj8K03nSN5hUgdKh+PqW/hSlv/BlNbVGGfdDKaJfywb7h9aLsD67rotdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/RbBnx9MuTxXy3AIuE07M1tgT9K4llkesdWxxCcjfc=;
 b=UbLqrKbHnQwWbhsKQy0aGoiWsGIk1wksLU19ZX9zuV4yzdgT4I5bbPdTjzYvKKXwZw7vM7ZCORPJe+xa+1U1JfBy1BJcLM1MkZJcNHiqN6E5VvwIVZ2WVRyQeM4rIzsc/zzu7W2IzmjV0xE+rwj1WM20Eeqk1ASWUMHkUpRIxDS58RSC096WeFRu4a51/C3i4aoi7f0m/lbDkoU1ZsvaZnvljB5Ig0CUGJ5KPZrmj24ZGDDPhNPM39Vs07xICn7ypzJCbaKcdP0+85cY93SdMC7cWBFh0kwVC2FH1IT6V42va7jrF1Oo/W+HxSwDa1RGKBARpuQABSV6Mc7mUpKIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/RbBnx9MuTxXy3AIuE07M1tgT9K4llkesdWxxCcjfc=;
 b=IBc+GXfXo4EpeNi1kgwnZvll7uIPbL69FpdGfUDsjzzuV9CxwMVFu3LUgtoYVUMZBjAuy4V2YDT2mzMHt+WhNjzvcsHp6FLwojZE6N3+GWN0HCnDhKw59/dkVx4te442BU0IZfHxHNkwJgnrgklTSFrafCFEcyZn9nW4Gz5gd+s=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:06:21 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:06:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 4/4] wilc1000: add IGTK support
Thread-Topic: [PATCH v3 4/4] wilc1000: add IGTK support
Thread-Index: AQHYb2auW9f8DZDbGUG0dS+gu75M8A==
Date:   Tue, 24 May 2022 12:06:21 +0000
Message-ID: <20220524120606.9675-4-ajay.kathat@microchip.com>
References: <20220524120606.9675-1-ajay.kathat@microchip.com>
In-Reply-To: <20220524120606.9675-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4d17769-541d-4b4c-55c8-08da3d7dd11f
x-ms-traffictypediagnostic: CH0PR11MB5412:EE_
x-microsoft-antispam-prvs: <CH0PR11MB541234B12F4295668EE8C28EE3D79@CH0PR11MB5412.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeQxt+mfoE5Ck2hCQW+PcRImyPBPClWXVH7RC7RaRCrY29b/6wdcIqMT71yeSZ8S/FZBf9QR6mS7PdydEtxqmwDqlNjSE5BFHERU27nS4w09lwT1g96Vkw1FkcamBpPsufDtQarYc+x5ScCWgaNkCR+JZz16Q1jMFWu0k3eby7Y9hM7BkDmDFcMzM6QVD+o3BwWDHesmLVfoeJ7xB5kdd4PZBX8ZU2ad8bIcv5RhRavh9jt5ciyVh+mj62hoU5Jp3WKXJBDN9f2j9GLQjuvWsbD/iofpOEvcAbW9uCdxkfPThirNOn+siR2SBIZO61Gn3FAg9RkAYy+gBwOPXVFtwBL2Lzesybu1i7vjl3NjTjL9+hUoQ0PALW+IT/G3NRd/UC/Uj0nnAiNsGUBPt8lmRmgFTPIb5NgwslOsrHxbO6khhnR2j310Ek1FQ9NCQ8AG0IFUnfxlPtR6ZDTMujHY1XdQyncRthgQSrAFyXV9aVnSOnvHN0O4j0oHuuQjc0t5CuNa/kVbGDpzG3P2SUZvJzKulz9Y/3ikwMGh9rqLHATgMyGu8O6vWbLeXqKFSBjl39PkPNXh9mZxtDwWr0s7CiPjV0NagBouhIHNlSuF8fYGyzvuZdqa3MQ/NBQEVXP1hHbNSo1OJUXphoSTDKLQg2Wf8klVTal0yFDboUU09aBWh65A0So/Odfstzurq/lqtJ16ykHckctzauXs0pFqPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(83380400001)(2906002)(30864003)(8936002)(1076003)(2616005)(6486002)(5660300002)(86362001)(508600001)(26005)(107886003)(38100700002)(38070700005)(36756003)(316002)(122000001)(8676002)(4326008)(6512007)(66946007)(66476007)(6506007)(186003)(66446008)(76116006)(91956017)(64756008)(71200400001)(66556008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mNsaVZL3qy/Msh5j2ABO241CTbJK8+u1cV9FGFmSRiV2JgZM4VCTFG4U7x?=
 =?iso-8859-1?Q?hI361QZxh/3OMJjcROZt2fRO9HtD+hUi93E1vDviPAo97CNsCFzYs1lxnU?=
 =?iso-8859-1?Q?Ib6HwwVh5DuM8WBfE7N8VREfnhsF6aORw4tCI/gye7A4BrC626pA0zaYTn?=
 =?iso-8859-1?Q?81uwNiSbKC+DbeRvYDM4PFsCB+xuiMOFvgOIhGNnpALhy94NwN0/CXXQQK?=
 =?iso-8859-1?Q?ssWYtuCCA/txeboL+5wKR4x+k3fdi1/Sx5pyaopJD+lNVrTGC94pAPCo1n?=
 =?iso-8859-1?Q?AiTMmLQNBi0S2GHetEpBIkt0YeG4V+J1tWXFBTyKptnBC9+YTrSpM1fCHR?=
 =?iso-8859-1?Q?y9cOZsTDwK4xClzQgxYtMRduXpjiGEX2gi89S3NsQkZkw80VgSA+qsCvRs?=
 =?iso-8859-1?Q?UI+VBKFykI8z11r16U/z/akCLN3c2KshSKc5TQHjN/PwcdvDG1tnyD87cl?=
 =?iso-8859-1?Q?McIjdeb3uSzNQFa4RXyBSGTD00kLzt62tTNnVhkjcRhPb2Bk5PTmAgH/lV?=
 =?iso-8859-1?Q?hXNM6ganxXY6AdZSoWsmF1uxxFxHmd4tNmN0/tx2G3WtOdb/4CVP8O2FqM?=
 =?iso-8859-1?Q?RuQmVLWR8SyuVX10lIuHeXSJKMhnfLurGsqlRhFWbxUc46vKAYbEghUeui?=
 =?iso-8859-1?Q?/DST/vFlYdsRfNZL3b7/kfzV9071eqtMw2wBUtSbADhVUYkKVyI2QkxU6W?=
 =?iso-8859-1?Q?HzFWhBmko9AOOvWVj6W6fpstJbg6ktFwl27OYEUDlEKSK9pg+Nwi7QzUdr?=
 =?iso-8859-1?Q?47WarkZIzgn9kUIj46z7bmhbTwiooqXIhbsnucOoLLbjqQG43uz1+RlZ2H?=
 =?iso-8859-1?Q?0WzwLuFneZT1wtr3cD9A8qXFV0ljBUj071mA0ZPH0DTIBx398EQMMztDzH?=
 =?iso-8859-1?Q?vfvh5MN2aaCHJHOjURjUHnJxdkz8dOMqkYkAEmHaf+fXuArJ3hbcV0pTjN?=
 =?iso-8859-1?Q?/LuH7Go8J4cJB6B5CzsKCHc+EGsQXCBsqMaA75qBk87GnMdyMVeNjxesfY?=
 =?iso-8859-1?Q?1SYnOSHCDEGrvkKbxskSv8YHQrrSSJWxgIvqN4/o3xFuyjZvmfairq+6J+?=
 =?iso-8859-1?Q?hWKpgzO1fByejchjSytsys+KhPWdhF3+HqkDm19lEWBdI3xBHik1JaGD5E?=
 =?iso-8859-1?Q?jRs7B1ZkTWbW2YmzD/C2p3Pnb73hlPSUlxqJSFDsd6i4BAtUi73GjPIQiU?=
 =?iso-8859-1?Q?8KLrMNU1eIsIjVhEOmRgul5LzOZo9UeHZQJYwJDpWthw9Bo+qdT8LYfxw0?=
 =?iso-8859-1?Q?Z+sUe6o2e/WKQzq0os4jSqhKXcJUiHrejhzq/ISLCFQkzaDRtbu08sfHHs?=
 =?iso-8859-1?Q?Eh4MlKdctiGQ5Z214Wrvmz+2exW6t6nbnaGBdpSY+Lcclg5jS8doE4kS/T?=
 =?iso-8859-1?Q?3Bmd0JXztxM5h7otlgk238BK8bv3VtwJC69WXOM5IVqOfaPYAml6i+UGqh?=
 =?iso-8859-1?Q?5OsV95f5Pu6JUGjjeuRAOaic6V11zGkQf+zq4pkTSYHICBXLiBDbPgza2k?=
 =?iso-8859-1?Q?yYfW0Eo/jKJLryqm1ml4v871uKiVhbo/bAJIk1edINrWaHNr1ES0ZdotPv?=
 =?iso-8859-1?Q?Shn7KHiHD7yIg6jmd6EuQ48YPMuBnR4/xAxGwkxjOZ46GRNiq7OQRZE5wa?=
 =?iso-8859-1?Q?LKL1CeW0eu14ZrT1oio7/Tr3odZeGny8knQnRCNm4aYjOv8uxkFi12VuCK?=
 =?iso-8859-1?Q?9b7gL6nna7cLTPSYPTWSBUXT4v62SH3IVavbS2a6dJZEE9HOB9ssJ+qJQH?=
 =?iso-8859-1?Q?mgfNw/Ltuq6SimV6btAwucwSmSL5V94LhoY0kitZMQDvg3LGEItnwVPTH8?=
 =?iso-8859-1?Q?Zs0PRDKvGX3stL1x1S8u6FsutEihSX3WVakn+CkH4YBkpjRpQxDc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d17769-541d-4b4c-55c8-08da3d7dd11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:06:21.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRn/GvstMnNGcegv5OPzWCDSFq4tiZ02mFOuXaFDdCC7P/OEYZmwbKIdPjO7ZHR4RRiX2bBZ9bOiON2YfwHGCZOnbhn/uQutMLetf1za4jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5412
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Add support to handle IGTK keys which are required for MFP to FW. Index ID
4 and 5 are used to store the IGTK key.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 114 ++++++++++++++----
 drivers/net/wireless/microchip/wilc1000/fw.h  |   8 ++
 drivers/net/wireless/microchip/wilc1000/hif.c |  56 ++++++++-
 drivers/net/wireless/microchip/wilc1000/hif.h |   5 +
 .../net/wireless/microchip/wilc1000/netdev.h  |   1 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  10 ++
 6 files changed, 171 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index ea59ce9fd991..1ac4684fab25 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -307,6 +307,7 @@ static int connect(struct wiphy *wiphy, struct net_devi=
ce *dev,
 	int ret;
 	u32 i;
 	u8 security =3D WILC_FW_SEC_NO;
+	enum mfptype mfp_type =3D WILC_FW_MFP_NONE;
 	enum authtype auth_type =3D WILC_FW_AUTH_ANY;
 	u32 cipher_group;
 	struct cfg80211_bss *bss;
@@ -416,6 +417,13 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 	wfi_drv->conn_info.arg =3D priv;
 	wfi_drv->conn_info.param =3D join_params;
=20
+	if (sme->mfp =3D=3D NL80211_MFP_OPTIONAL)
+		mfp_type =3D WILC_FW_MFP_OPTIONAL;
+	else if (sme->mfp =3D=3D NL80211_MFP_REQUIRED)
+		mfp_type =3D WILC_FW_MFP_REQUIRED;
+
+	wfi_drv->conn_info.mfp_type =3D mfp_type;
+
 	ret =3D wilc_set_join_req(vif, bss->bssid, sme->ie, sme->ie_len);
 	if (ret) {
 		netdev_err(dev, "wilc_set_join_req(): Error\n");
@@ -495,6 +503,18 @@ static int wilc_wfi_cfg_allocate_wpa_entry(struct wilc=
_priv *priv, u8 idx)
 	return 0;
 }
=20
+static int wilc_wfi_cfg_allocate_wpa_igtk_entry(struct wilc_priv *priv, u8=
 idx)
+{
+	idx -=3D 4;
+	if (!priv->wilc_igtk[idx]) {
+		priv->wilc_igtk[idx] =3D kzalloc(sizeof(*priv->wilc_igtk[idx]),
+					       GFP_KERNEL);
+		if (!priv->wilc_igtk[idx])
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
 				      struct key_params *params)
 {
@@ -531,6 +551,7 @@ static int add_key(struct wiphy *wiphy, struct net_devi=
ce *netdev, u8 key_index,
 	u8 op_mode;
 	struct wilc_vif *vif =3D netdev_priv(netdev);
 	struct wilc_priv *priv =3D &vif->priv;
+	struct wilc_wfi_key *key;
=20
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -594,6 +615,26 @@ static int add_key(struct wiphy *wiphy, struct net_dev=
ice *netdev, u8 key_index,
 					   key_index);
=20
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		ret =3D wilc_wfi_cfg_allocate_wpa_igtk_entry(priv, key_index);
+		if (ret)
+			return -ENOMEM;
+
+		key =3D priv->wilc_igtk[key_index - 4];
+		ret =3D wilc_wfi_cfg_copy_wpa_info(key, params);
+		if (ret)
+			return -ENOMEM;
+
+		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP ||
+		    priv->wdev.iftype =3D=3D NL80211_IFTYPE_P2P_GO)
+			op_mode =3D WILC_AP_MODE;
+		else
+			op_mode =3D WILC_STATION_MODE;
+
+		ret =3D wilc_add_igtk(vif, params->key, keylen, params->seq,
+				    params->seq_len, mac_addr, op_mode,
+				    key_index);
+		break;
=20
 	default:
 		netdev_err(netdev, "%s: Unsupported cipher\n", __func__);
@@ -611,23 +652,34 @@ static int del_key(struct wiphy *wiphy, struct net_de=
vice *netdev,
 	struct wilc_vif *vif =3D netdev_priv(netdev);
 	struct wilc_priv *priv =3D &vif->priv;
=20
-	if (priv->wilc_gtk[key_index]) {
-		kfree(priv->wilc_gtk[key_index]->key);
-		priv->wilc_gtk[key_index]->key =3D NULL;
-		kfree(priv->wilc_gtk[key_index]->seq);
-		priv->wilc_gtk[key_index]->seq =3D NULL;
-
-		kfree(priv->wilc_gtk[key_index]);
-		priv->wilc_gtk[key_index] =3D NULL;
-	}
-
-	if (priv->wilc_ptk[key_index]) {
-		kfree(priv->wilc_ptk[key_index]->key);
-		priv->wilc_ptk[key_index]->key =3D NULL;
-		kfree(priv->wilc_ptk[key_index]->seq);
-		priv->wilc_ptk[key_index]->seq =3D NULL;
-		kfree(priv->wilc_ptk[key_index]);
-		priv->wilc_ptk[key_index] =3D NULL;
+	if (!pairwise && (key_index =3D=3D 4 || key_index =3D=3D 5)) {
+		key_index -=3D 4;
+		if (priv->wilc_igtk[key_index]) {
+			kfree(priv->wilc_igtk[key_index]->key);
+			priv->wilc_igtk[key_index]->key =3D NULL;
+			kfree(priv->wilc_igtk[key_index]->seq);
+			priv->wilc_igtk[key_index]->seq =3D NULL;
+			kfree(priv->wilc_igtk[key_index]);
+			priv->wilc_igtk[key_index] =3D NULL;
+		}
+	} else {
+		if (priv->wilc_gtk[key_index]) {
+			kfree(priv->wilc_gtk[key_index]->key);
+			priv->wilc_gtk[key_index]->key =3D NULL;
+			kfree(priv->wilc_gtk[key_index]->seq);
+			priv->wilc_gtk[key_index]->seq =3D NULL;
+
+			kfree(priv->wilc_gtk[key_index]);
+			priv->wilc_gtk[key_index] =3D NULL;
+		}
+		if (priv->wilc_ptk[key_index]) {
+			kfree(priv->wilc_ptk[key_index]->key);
+			priv->wilc_ptk[key_index]->key =3D NULL;
+			kfree(priv->wilc_ptk[key_index]->seq);
+			priv->wilc_ptk[key_index]->seq =3D NULL;
+			kfree(priv->wilc_ptk[key_index]);
+			priv->wilc_ptk[key_index] =3D NULL;
+		}
 	}
=20
 	return 0;
@@ -642,11 +694,20 @@ static int get_key(struct wiphy *wiphy, struct net_de=
vice *netdev, u8 key_index,
 	struct  key_params key_params;
=20
 	if (!pairwise) {
-		key_params.key =3D priv->wilc_gtk[key_index]->key;
-		key_params.cipher =3D priv->wilc_gtk[key_index]->cipher;
-		key_params.key_len =3D priv->wilc_gtk[key_index]->key_len;
-		key_params.seq =3D priv->wilc_gtk[key_index]->seq;
-		key_params.seq_len =3D priv->wilc_gtk[key_index]->seq_len;
+		if (key_index =3D=3D 4 || key_index =3D=3D 5) {
+			key_index -=3D 4;
+			key_params.key =3D priv->wilc_igtk[key_index]->key;
+			key_params.cipher =3D priv->wilc_igtk[key_index]->cipher;
+			key_params.key_len =3D priv->wilc_igtk[key_index]->key_len;
+			key_params.seq =3D priv->wilc_igtk[key_index]->seq;
+			key_params.seq_len =3D priv->wilc_igtk[key_index]->seq_len;
+		} else {
+			key_params.key =3D priv->wilc_gtk[key_index]->key;
+			key_params.cipher =3D priv->wilc_gtk[key_index]->cipher;
+			key_params.key_len =3D priv->wilc_gtk[key_index]->key_len;
+			key_params.seq =3D priv->wilc_gtk[key_index]->seq;
+			key_params.seq_len =3D priv->wilc_gtk[key_index]->seq_len;
+		}
 	} else {
 		key_params.key =3D priv->wilc_ptk[key_index]->key;
 		key_params.cipher =3D priv->wilc_ptk[key_index]->cipher;
@@ -667,6 +728,14 @@ static int set_default_key(struct wiphy *wiphy, struct=
 net_device *netdev,
 	return 0;
 }
=20
+static int set_default_mgmt_key(struct wiphy *wiphy, struct net_device *ne=
tdev,
+				u8 key_index)
+{
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+
+	return wilc_set_default_mgmt_key_index(vif, key_index);
+}
+
 static int get_station(struct wiphy *wiphy, struct net_device *dev,
 		       const u8 *mac, struct station_info *sinfo)
 {
@@ -1626,6 +1695,7 @@ static const struct cfg80211_ops wilc_cfg80211_ops =
=3D {
 	.del_key =3D del_key,
 	.get_key =3D get_key,
 	.set_default_key =3D set_default_key,
+	.set_default_mgmt_key =3D set_default_mgmt_key,
 	.add_virtual_intf =3D add_virtual_intf,
 	.del_virtual_intf =3D del_virtual_intf,
 	.change_virtual_intf =3D change_virtual_intf,
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 9449c5d0b472..5c5cac4aab02 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -54,6 +54,14 @@ struct wilc_ap_wpa_ptk {
 	u8 key[];
 } __packed;
=20
+struct wilc_wpa_igtk {
+	u8 index;
+	u8 pn_len;
+	u8 pn[6];
+	u8 key_len;
+	u8 key[];
+} __packed;
+
 struct wilc_gtk_key {
 	u8 mac_addr[ETH_ALEN];
 	u8 rsc[8];
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 5d9d3aba737c..4038a254465f 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -271,12 +271,19 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u=
8 scan_type,
 static int wilc_send_connect_wid(struct wilc_vif *vif)
 {
 	int result =3D 0;
-	struct wid wid_list[4];
+	struct wid wid_list[5];
 	u32 wid_cnt =3D 0;
 	struct host_if_drv *hif_drv =3D vif->hif_drv;
 	struct wilc_conn_info *conn_attr =3D &hif_drv->conn_info;
 	struct wilc_join_bss_param *bss_param =3D conn_attr->param;
=20
+
+        wid_list[wid_cnt].id =3D WID_SET_MFP;
+        wid_list[wid_cnt].type =3D WID_CHAR;
+        wid_list[wid_cnt].size =3D sizeof(char);
+        wid_list[wid_cnt].val =3D (s8 *)&conn_attr->mfp_type;
+        wid_cnt++;
+
 	wid_list[wid_cnt].id =3D WID_INFO_ELEMENT_ASSOCIATE;
 	wid_list[wid_cnt].type =3D WID_BIN_DATA;
 	wid_list[wid_cnt].val =3D conn_attr->req_ies;
@@ -1143,6 +1150,36 @@ int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk=
, u8 ptk_key_len,
 	return result;
 }
=20
+int wilc_add_igtk(struct wilc_vif *vif, const u8 *igtk, u8 igtk_key_len,
+		  const u8 *pn, u8 pn_len, const u8 *mac_addr, u8 mode, u8 index)
+{
+	int result =3D 0;
+	u8 t_key_len =3D igtk_key_len;
+	struct wid wid;
+	struct wilc_wpa_igtk *key_buf;
+
+	key_buf =3D kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+	if (!key_buf)
+		return -ENOMEM;
+
+	key_buf->index =3D index;
+
+	memcpy(&key_buf->pn[0], pn, pn_len);
+	key_buf->pn_len =3D pn_len;
+
+	memcpy(&key_buf->key[0], igtk, igtk_key_len);
+	key_buf->key_len =3D t_key_len;
+
+	wid.id =3D WID_ADD_IGTK;
+	wid.type =3D WID_STR;
+	wid.size =3D sizeof(*key_buf) + t_key_len;
+	wid.val =3D (s8 *)key_buf;
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	kfree(key_buf);
+
+	return result;
+}
+
 int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len=
,
 		    u8 index, u32 key_rsc_len, const u8 *key_rsc,
 		    const u8 *rx_mic, const u8 *tx_mic, u8 mode,
@@ -1932,3 +1969,20 @@ int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_p=
ower)
=20
 	return wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
 }
+
+int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index)
+{
+        struct wid wid;
+        int result;
+
+        wid.id =3D WID_DEFAULT_MGMT_KEY_ID;
+        wid.type =3D WID_CHAR;
+        wid.size =3D sizeof(char);
+        wid.val =3D &index;
+        result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+        if (result)
+                netdev_err(vif->ndev,
+                           "Failed to send default mgmt key index\n");
+
+        return result;
+}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index f1a0a1f042ca..d8dd94dcfe14 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -108,6 +108,7 @@ struct wilc_conn_info {
 	u8 bssid[ETH_ALEN];
 	u8 security;
 	enum authtype auth_type;
+	enum mfptype mfp_type;
 	u8 ch;
 	u8 *req_ies;
 	size_t req_ies_len;
@@ -155,6 +156,9 @@ struct wilc_vif;
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index);
+int wilc_add_igtk(struct wilc_vif *vif, const u8 *igtk, u8 igtk_key_len,
+		  const u8 *pn, u8 pn_len, const u8 *mac_addr, u8 mode,
+		  u8 index);
 s32 wilc_get_inactive_time(struct wilc_vif *vif, const u8 *mac,
 			   u32 *out_val);
 int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len=
,
@@ -210,4 +214,5 @@ void wilc_network_info_received(struct wilc *wilc, u8 *=
buffer, u32 length);
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto);
+int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index);
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a0d9e981500e..822e65d00f53 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -129,6 +129,7 @@ struct wilc_priv {
 	struct net_device *real_ndev;
 	struct wilc_wfi_key *wilc_gtk[WILC_MAX_NUM_STA];
 	struct wilc_wfi_key *wilc_ptk[WILC_MAX_NUM_STA];
+	struct wilc_wfi_key *wilc_igtk[2];
 	u8 wilc_groupkey;
=20
 	/* mutexes */
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index 18f13b5643e8..df2f5a63bdf6 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -91,6 +91,12 @@ enum authtype {
 	WILC_FW_AUTH_OPEN_SYSTEM_SHA256 =3D 13
 };
=20
+enum mfptype {
+	WILC_FW_MFP_NONE =3D 0x0,
+	WILC_FW_MFP_OPTIONAL =3D 0x1,
+	WILC_FW_MFP_REQUIRED =3D 0x2
+};
+
 enum site_survey {
 	WILC_FW_SITE_SURVEY_1CH =3D 0,
 	WILC_FW_SITE_SURVEY_ALL_CH =3D 1,
@@ -661,6 +667,9 @@ enum {
 	WID_LOG_TERMINAL_SWITCH		=3D 0x00CD,
 	WID_TX_POWER			=3D 0x00CE,
 	WID_WOWLAN_TRIGGER		=3D 0X00CF,
+	WID_SET_MFP                     =3D 0x00D0,
+
+	WID_DEFAULT_MGMT_KEY_ID		=3D 0x00D2,
 	/*  EMAC Short WID list */
 	/*  RTS Threshold */
 	/*
@@ -750,6 +759,7 @@ enum {
 	WID_REMOVE_KEY			=3D 0x301E,
 	WID_ASSOC_REQ_INFO		=3D 0x301F,
 	WID_ASSOC_RES_INFO		=3D 0x3020,
+	WID_ADD_IGTK                    =3D 0x3022,
 	WID_MANUFACTURER		=3D 0x3026, /* Added for CAPI tool */
 	WID_MODEL_NAME			=3D 0x3027, /* Added for CAPI tool */
 	WID_MODEL_NUM			=3D 0x3028, /* Added for CAPI tool */
--=20
2.25.1
