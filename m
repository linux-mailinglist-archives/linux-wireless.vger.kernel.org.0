Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8922052681B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358545AbiEMRSH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbiEMRSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 13:18:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21885326C0
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652462278; x=1683998278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+atr0/0MXTn7B0bydlEGXJeZuoDpzYPQdLS76n4uN5k=;
  b=mfo9pIHQEpE0wcWISdyxviqsM/0s+XAtuX2EJzUnV3y2+ECoQ9uW9372
   0MDrtYw5IryYAPbohMOqlZ6ZCraGVPZjSTLS7hcdWo7IVtfgksfYMF9CR
   x2jCfgELMd+vPC2tfcEKOJs/E3WtqZ1svohLoX4GQIkSX7oGCK+TBE2V6
   ZHbwSKNW1RPQ3yUxMdsl+MzVEwjPP7p58pAK3EpIwMjHIsSLXFQj2jSv7
   nItHxuMpcgXptNMLV1FhtcyrohY+tTp+XH5JdeYj/cYO7j9wopVKHQ1WX
   uFfum61qfcSMS4FdMiEEbo0xrVUtR6IWZJOCQp9UUxqw6PUtpIaf+8qqH
   g==;
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="159001882"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 10:17:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 10:17:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 10:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbGqXfW+/ZQEDzC9kt0SKCZzZO5L2C6NY4ttVgjTacgm/8TAuzwkcTApm9fHQ5TzJz1ufYXtN1/ON3svKLFnqwG/Lj0nzdj8f73qua40HMzV/i77mVHv3LTp2Goi1cayVs1XZu2gV3+0G1SZfQZznM+mBr9DMj5h4CxVgk9VOY9NtyZHWfFSEywM1Lk2n5rhPKXc7WYlcYcOuufjUVoNKD491cyC9YeC2llUDG0GBxYxrDW2rbYvK4jr56CtMn/GaVyEE/jVMCxuqibD41JExik6nRiO9/2u3jvRCfkKjv8qX8Q8Cd9KlfcUfqRhB/g5q3rKqrDFsxZUY60VEwATCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/RbBnx9MuTxXy3AIuE07M1tgT9K4llkesdWxxCcjfc=;
 b=cQbPzQpIPlBTOTeKlGnBS3jrCIhEVvPxar03Cr5G9WZ1FwinnBoFsWgpvTT+b69YY4rObjSQVUiLLVaVK8GGH2TO7VpKJPKlkH9p/uZb5FexRwF8+tla6NCVF66Q6/vlmJCi2Gb120Sewlmoud9h7PqHi4rdvyn/bkzqeVtvvnavhzzA8bWo3+0UOOG07Kw5nqJh9+Und2OZNSWaysjkU4v4gZUU4DscO24Vk0VXi8AE8L7Ajm1zoiMlGdQaqO731vrLo36V8vgcYZEp3VVJBkz1+xPal56uSQrSBUiPvNqWAJyZvlHgKLQN7aYO6tEQEKjLLiPjNJYAdidViBdDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/RbBnx9MuTxXy3AIuE07M1tgT9K4llkesdWxxCcjfc=;
 b=lpDbmuHGp+iD3iObPvZEB2mRO1FXFYCCt6dj3D5uGdPKGr8Tb8Fd6IkTHeiZerg5481i5S85oKAUU8PTF8UYapJrVJLBJQkn95m8/HJ37oTpnBr9fM/SbsGWAsLh4bNv2t7fYnbq4a61PnUrlam8/Qo1QlTLdhDyX8a0DMXkCyk=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BL0PR11MB3441.namprd11.prod.outlook.com (2603:10b6:208:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Fri, 13 May
 2022 17:17:54 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 17:17:54 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/4] wilc1000: add IGTK support
Thread-Topic: [PATCH 4/4] wilc1000: add IGTK support
Thread-Index: AQHYZu1hJJjmsiHpeEmcVGKRcWaKSA==
Date:   Fri, 13 May 2022 17:17:53 +0000
Message-ID: <20220513171741.26701-4-ajay.kathat@microchip.com>
References: <20220513171741.26701-1-ajay.kathat@microchip.com>
In-Reply-To: <20220513171741.26701-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce9f3116-4485-42ca-a61a-08da35048468
x-ms-traffictypediagnostic: BL0PR11MB3441:EE_
x-microsoft-antispam-prvs: <BL0PR11MB34415523E3A9E9F4D175C1FAE3CA9@BL0PR11MB3441.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kBOycjdQmokVeDsBhADexS1pS8H6NH1v8RgEm+4rqxMPQTrs2ANBwPPKWjhfml65kFdyr417FutRBAa7cf6pW8xc21bPwiqMxt/cBheUIwQ0bFdiml6bq4EMfYTcxWBZm4wrw4Mnc+Y2DuQdvFKpECy267C3uuy2rlZ0hNZQ59XOxpuuwiqJ3YBRFOSxEN73rsn76jBdSFrpXpfUX2W6pGLEZN3YW8FbzxflhYKfAXnTSoE/gvRhQKOQ0eDTm6173Zm7BGmABHbPd8eDSNuzn+LLlOQhT0eu9+Ih6f1TDkOh4b2ps0RKhjYY0xGpdjGs/YTYqJ8XR9J1Qaeja9in7fzttLJT8KaNPmCpfiIZ50m0xbJ8xHqJtDDURy5/lLj3a/Kt611ewO32O5Jewm4/jqlyn/rjz74kIKB7YuK2WaUqJI9KL9n7R1mRKB8Kvq7H8/tquMTZPXS6BLCraFcHPJHudrsPjHtEz/WrlpO7VWjidCIt6usUK6U3MtNd0DDkNCmeXTCiiD6b7xPdgUKQ/ja6IOnHympbFJ789Nh/SGWJAjiFpiHiHLnm3+06T+b5u08whB3JX8DwsSisYnyEfn1MNT9mAn6Ez2fioHUaRbWsJA5u/lSVHXwLKn//a6v5zoS0jJhU8Sd2QP/BAvcu+LUXDO7bgw9aux5j7gbwQHHOkTJNV6oLJnBiNihvgUO2F+stHcGC1jtNn6lHUCqdgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(38070700005)(38100700002)(1076003)(36756003)(186003)(83380400001)(107886003)(6486002)(30864003)(508600001)(8936002)(2906002)(5660300002)(86362001)(6506007)(91956017)(6916009)(122000001)(4326008)(8676002)(6512007)(71200400001)(26005)(2616005)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eHdPZ06A2NsjIWVIdRidFQ7/jSfU591YAX6rH3aK0NXyFaUtCBVE4hUQa5?=
 =?iso-8859-1?Q?MBROmtzN4WqUo2t7EO9S3DyeImMpQjaNl20YKiy2pppMrkYw0sKFcVrgJ4?=
 =?iso-8859-1?Q?sYpl514ClknBq8Rg1UgwoZy+LzHramnWoCpc2q3eKbJO9JPIr6vlc/8YFe?=
 =?iso-8859-1?Q?bwkwto9LTnv8TBCVGyH6r/BkglTP//F2UA9IokmiKFQF6m6KzvPBIoj5dQ?=
 =?iso-8859-1?Q?gDNziUxHYA0XGqYxozHvXOjYX1/2nblvkB6j4I7JIeZHhfIlKBoqBQdbtP?=
 =?iso-8859-1?Q?fYsC2Likr3dNzyG9AX/wZsu/BsIlXskm3gVbv4XEqX0LRGvz3CUzXpfLoj?=
 =?iso-8859-1?Q?xvp8F3RwCGz/l40HpwaF1TeFUc6KIsrvDyzrq74bLoqmuUIl1O3/dwQ9FW?=
 =?iso-8859-1?Q?6QjD8Akdxl/2dZWERjmnHMuNiYBvDZ6ycEode21/dVFPoJe2hX7+KPojy0?=
 =?iso-8859-1?Q?mwvrojO2Fzk6FeWG072DFpxaPU8/LAYiOnuDWlbUPPRCEmU7XvpKRrTsqy?=
 =?iso-8859-1?Q?DpVvdBxVUFwxWN5uSYJNVq7Mgd3HZ8bDOekBp3ZE5D5WMTxxZWiNAAXOV0?=
 =?iso-8859-1?Q?LpFN0Aa6zUVnxiWron2EqvkHvXaKpuqJubS1Hmi6yIqTKzLPeVEDMbfa+s?=
 =?iso-8859-1?Q?BEOi2lqvznuEQPgPS2oZBWwRswpRiEkscskTKklEwPS3JRQ9FXKNYdVlRX?=
 =?iso-8859-1?Q?xq88ZKBU2e4rdnQd92LRPXDTFXichOG5XzGyooI0M/oTplB8UCso3EhKNe?=
 =?iso-8859-1?Q?DNOTuH3BuMpw/bPkj/07knG/18yq2QOjpiz+707NOv6iITK1MBX8dNpkIo?=
 =?iso-8859-1?Q?R3lKXEaYnc8v5ySDWe8rdJCg9tRsVOKYKHtaRoqGbrXg6bryWKxcNf4Pb2?=
 =?iso-8859-1?Q?9qf3FBLkaPNXxMuz+4b8XguYy1jLFHwcsoKDtcA+PpQ9FzDu2gv+H6h/kn?=
 =?iso-8859-1?Q?QQB2QKugds1Tv3gFSYl7e4ZVS56VX982fJh7tMR9S1xr1uKLIrxz53cT4W?=
 =?iso-8859-1?Q?YVaFenR9Y2jodxXiioc96qI0OQGgrFx850ttYgEloXXQnA2bRSUK33MUyi?=
 =?iso-8859-1?Q?qDshwrz/Jl+CMGSKalt460tNi+GI97AfUlc6Ik4+FeM5YA+UPHKq6Jd2nz?=
 =?iso-8859-1?Q?5n1L7GB1Gn3zMiByEBz+AMn0vmxv9zEnrdU8VC8a4sSfHemuN6dUd8d29e?=
 =?iso-8859-1?Q?pCIB1lIu2GMHOfHTV+8CsijbIsxX+DbMaoSnoNktpDgYvY/qoXI5kezcVO?=
 =?iso-8859-1?Q?90boOH2XIljR+LKgMdNKp/8ycM9CLtMC6c8H6T9ylUAesD7j8Qcf+5MMau?=
 =?iso-8859-1?Q?NPQ/Xhd1JTNj5rHZEjmdNIo0EVPxETAesRcjG1ARdx8l7pKqU+beqi4Oa/?=
 =?iso-8859-1?Q?xfrXD8BlHYFR1c1DN+cSXXds0wp/DjODbLG+RAcW4adwjqL0KrZfIH4/aA?=
 =?iso-8859-1?Q?0p/XD5zH6SB0iON0Z3p8a+pdjrYlqfdw6VW2rjjX23FIeqF72aMLDGqzJw?=
 =?iso-8859-1?Q?FgsQ3XuxKd0+gCcpDp5gCRIBxIrgruUaCrh37z6Bag+2Q6PA1VKGqk52YK?=
 =?iso-8859-1?Q?zuRSktDk2rm/sjIlc9fMJdqC9bNNVHSUpdBB9N0ei8/gHJi3gsEx2AarFj?=
 =?iso-8859-1?Q?QXJwLLB1NtBcj8aAVMc/kaFpREpbRCvUL6KUzrLxhko0D6gIi4w1qqWlPE?=
 =?iso-8859-1?Q?55AnxZXTdFL4zyblridcZuxJ4U0n3uy5TnbxqWxVlNh5ZcAuK28vZ/sHpt?=
 =?iso-8859-1?Q?Ij4ddNdFoIkal2+9sXqxcAxMIZhy8PcuLwzVmXyaM2cqkSQSdjlD/d/vTR?=
 =?iso-8859-1?Q?VlnQtdTRbGOWsRQ9TBANaKLb4GKFyHzi0D7rAWH4ECtZBM468Zvs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9f3116-4485-42ca-a61a-08da35048468
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:17:53.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMQ8K1n7AEFHmTDhfxjKT7o7wjlCCqTCZkNqeXjzCESiHl8sBMg/LceW/TNuoU0iNAoIprkOPGzd6V3Ch+bzq10MDnRgmzr3QEe6ScqS34I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3441
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
