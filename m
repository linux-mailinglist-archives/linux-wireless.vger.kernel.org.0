Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076D352681C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376785AbiEMRSK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351346AbiEMRSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 13:18:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A9AE62
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652462282; x=1683998282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QvPShWavlqycyc7emBoGM/bci8w1HSNyYRjB+2WLsK8=;
  b=dNETtf0K/8SNPJOQ6pndQmzdbZJ6BlqytjDLPyj8TXxSyP856hDbf5BH
   tz0mqnI0ssPfxclCrzxVNQVPKE8HRAwkncIQLV+AZy3/yX98jbuOXQx84
   0cDWKPo12SMFuFHZPRSwL7zhyTptTYQhhghRASZNMzhS+BMJMk70qtYtK
   SjyyUqbJ8f9HGg+WmAanUz8u3M/WcRdCpuA2CobM9ATsBSEKlChfhP/Ra
   BF5Xl5Hv+lAqN+LqebZRIVUe1PpgtZNsk4jzyRG5czrirsVSrj1ysr5Nk
   BTHEj6HeatEt221sz4HREYOYG7yqYX0F1VsNpDl3q0oy+1OX04t3xZAj7
   w==;
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="155983588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 10:17:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 10:17:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 10:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaA+cBDoUaijtpQZ+teb6sQfC/BYXqYAGzL8FROS3OqhpEQbkoGkXFLNdoQtPBQFvWjDhvIJGjRD+1gBoXqWEO7U3F4MvEwukXWRirVo3m3UrEV2hwWGi9h9xLJ4nhrvB/LP5FSK0nwT1uH6rVenjPb2zYbjRfwhTqu3AP5tOxRwidhOoyrNJXQ7zMrj57VHPAtur0tdPZuElzR5yka2qD+qMALnEr8zGn601uAVlI3172zlOVyeBs/rdSQrC4SHyWs9hUSh6vRuKKIg0qnPdQKjJ6z2GlyHOdUQWMh4bny2ATNsHiRidiLrruN+Zl6GNRkH6vFyzSW0o4iou5fzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6OPWaXFTzPjXUf2LRzjG60TuPUkZcQmmsfiZeowXhQ=;
 b=JwGuBiLnjpeBd47fb382MzVDHiwWZ3phR8wGa4I8OmC5SeDrBqqrIwUAYA5tB5QKZ/rtDKmQR4S4TbRSjJqu0YSFVJ1xVx7E8dn3q5PLYiQ+qjuXQvNGg7h4PGHvm5sMqMTu+PJj1Wqw3LOtR17qtrRr7LzMS1wbRp6WjGK7sps9PULccCfO9LCCj/HClCyT+mMH0mOUuCuHJhX/eTIfCCOd9NT6rdujU9Kxl9JA/5gsZ+bgE69unD1ZavmdryDim1VBwMyWsTmro2b+8Lg3VLLInoznaZ/UvLQimnTaGPC8AZ+kVbqj9aQfp6WhlxZlB9ZgUR/Tr16MP9gVVeC1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6OPWaXFTzPjXUf2LRzjG60TuPUkZcQmmsfiZeowXhQ=;
 b=YJnoD1xOzyVpXjkVuT5RBoWm7T1KFn3cMDbOEcD3MrAxTQvaLiAKsxbSEn7CSkbaw+nwC85sbuGBxkKbmPB1MQQkuohXxfSq2bTJiKBCiAJ8Oc05mdyyNsd0thnJdpi/MwUYjVgRyDVXTvERSVUpjigQSy+UfOGyNZMM8vBchDA=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BL0PR11MB3441.namprd11.prod.outlook.com (2603:10b6:208:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Fri, 13 May
 2022 17:17:52 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 17:17:52 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/4] wilc1000: remove WEP security support
Thread-Topic: [PATCH 2/4] wilc1000: remove WEP security support
Thread-Index: AQHYZu1gY4UNGguFWUSVWAd/9KDHRQ==
Date:   Fri, 13 May 2022 17:17:52 +0000
Message-ID: <20220513171741.26701-2-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 4676d97e-e898-4d64-a01b-08da35048326
x-ms-traffictypediagnostic: BL0PR11MB3441:EE_
x-microsoft-antispam-prvs: <BL0PR11MB3441177B42E972700D2F0B3FE3CA9@BL0PR11MB3441.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNY6T/AS0Jt73ahGpUzc2oDs0X8RcyM8GlZS/edE3W1DPUTV53v5HMMy/Qgw/PCIOIU6eYsBm4Dozthsyc2wykdfE4eS8Mej6o5mf39syt9eZkaFt9ltPXPv+LVYh2jHrSI5Mzk7mO+ElgAjlxG4ahz5WJtv7r3g4ZkjXMwZyv7SNmoYw13HGdlNJS/wv9mqef2oICQp4qDlvFRkwlO3qHzGSYOD1AX4+Rg2ahG9cVp2ykdNYsHd1+IVKalt2XKk444jiQUIHbunhv/Za9iQ8zgD/0VTtHHHw9ak1+p4byIAqoi1v3PdeEN4VVHdYmysZ2UjWma6UiTihwODi0Z+nTI54apoNMFwtGKs71FeV3Tcf1Lr+vUB1nbxW6tfcjrrUjQDO4Iu+88N+j7VCrHDdCRle9pY50iazzGf5v5JfCx0X1VBl2lTdQA4v7e1fEYEXadES93FF6rElkQVLYvmNLRCkxu0NHZ9bYjOeym5luEYOKMOKruG8kTjySC/TdRC8AOD060u5ETcw3FaHaCrpzUtC0OWLZql8rcNzlHYip4FPWxEbEbHqowV0IpLYr1Dxn6HX8nJpXFqaFBOvv0xpJ1a353u0c5I6JKmY08Ygx9He5ut9hOp4esWMTYsC0QWYwQq/5qQbsRx5JzbCU2nLitr9pMTEH3WFQ8GGZPNOyjD4DEVuzDiJVFjvoKzei4Sd8lK9RP5C7SEbiy1wkcyxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(38070700005)(38100700002)(1076003)(36756003)(186003)(83380400001)(107886003)(6486002)(508600001)(8936002)(15650500001)(2906002)(5660300002)(86362001)(6506007)(91956017)(6916009)(122000001)(4326008)(8676002)(6512007)(71200400001)(26005)(2616005)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tba7mu+s+4u08M1SPAs3HNBTz0uEOVPFwqWEpXoxo9iHN5o8fUXdHmXFaW?=
 =?iso-8859-1?Q?lBGk9Ie0HztEUASKmu7k0Tf7feRZGCw5bix1wcLEs6KCvbDLrlaXPsDIix?=
 =?iso-8859-1?Q?iOMv0S8WD+/T7KV9lnMtkHPeBRMjU2k4x6vGDvxbsmy+9AHs+M0fp/02j5?=
 =?iso-8859-1?Q?fAAmg+Muya+doSo5eD53UNhrHorOHg7SuewWhA5MJfR8L3TkL1O4ogW36z?=
 =?iso-8859-1?Q?JShvK0Af1zv5WBTOl25APcSJcKUhffM2VNiHbH1uglUKIi+g5c0JIF/Amz?=
 =?iso-8859-1?Q?4NxtGcMNqSvybJB82oda+hnc71upbX1kBO6UJ9hKKbSLGADBmGqY84UYWZ?=
 =?iso-8859-1?Q?yuFiDTyXcn+fSqIYKgjcc3g4I7nREaN7Y3PkLfIIj60TY04i8kyaIXIu2p?=
 =?iso-8859-1?Q?wrsrxuYZhnSzSmWLTUaStTP6+ng2jw+MiKpg7+Bl2gc8TcIcbqn0Dz+B7+?=
 =?iso-8859-1?Q?lqUxXa0aNX6hQ4DOOfIWL5eI3n9SXpzZjZrxcKkgUFHAR4cPdOkKphtH7M?=
 =?iso-8859-1?Q?5yd1qoMMDuwfUBk1F650m98M47/keZ+7gJifOerF3AwEyx0qtnolPYHlKa?=
 =?iso-8859-1?Q?2U+tqVeuZ+zE4PdhcbVrG2qlAZsgVGcY9pILnQP2JZ5czx9DfIug84WBbs?=
 =?iso-8859-1?Q?PIRiTK10J22jzJsn8l1UtAhacNx7m2VleTdUwcJu/tScofHUBcOMGPNLFw?=
 =?iso-8859-1?Q?4YpcLaz9ffa8i8ZPyjS8rS67eygsm5hzitDISbWKrp3P7mSTxj7yrUIJ1r?=
 =?iso-8859-1?Q?pllFzBeg9XrpZPGElhhtpeAXeO0ctnWcC9niZrZFBeOR0rmPqzblxHzlWC?=
 =?iso-8859-1?Q?+M3TSKBBLrOVoFCRkTqvqvVPouUSLk+hDlHja8Ez7aGTZowC7Rj10lAsDr?=
 =?iso-8859-1?Q?7NMqBEwEZ2puLns8CYuCUpm3j1U8Uff/AkrzxkdCKTGmzAEANrCVcHpFo5?=
 =?iso-8859-1?Q?Zor6XCpKpdnAuUdVJLj5X6sg7wLXaLO29JN8qACEO4VWJ2XBs0+PML/VvC?=
 =?iso-8859-1?Q?9OyW5EldE2zHRKVVf94iFV/MlIvd/sPTVcKTjJYKD8qqLhCTk1uyVGZn2E?=
 =?iso-8859-1?Q?2JYR8EwGkf6WmEE3n4mQSEWCUzbnZRZvhXihW3pJcs/+uZkF7k3ye9hTQ/?=
 =?iso-8859-1?Q?pcMAQPFR7KH6qzTrzyBp4nK1UWip8eD9JntIAzkx1TaVAgEtXW1a8kCD2B?=
 =?iso-8859-1?Q?ClzlrzpwY3B3w9nTxChwnSQ+hTcJOXK8zrF8B5MoE0aidIpnqFSKJQbPwA?=
 =?iso-8859-1?Q?O/MydWU3kHnBMkjGFyyCZyj2bfv2LMqWTpS7F+NtQacb/WJeozRglf9bGq?=
 =?iso-8859-1?Q?w80JvRdFOxfcvQtv5MbmJC/foJ0LQVbSbWvuanGdEUjmbHfjMhGrlTpduv?=
 =?iso-8859-1?Q?vAAJmqth+FfLQh6O1n7nbiIYrcB0NHJPmFC+PDMONDv9y10HOXjMFQ0xt9?=
 =?iso-8859-1?Q?HO0Lt371Nijf/zdUBE/LFt4XfrYk57i52dwM1oNpPhYbIKZtj2yVD9BjBb?=
 =?iso-8859-1?Q?YKBYBDsSjjmdWTTO7jLH90lbpLzybaHPVyrJ1M/7iMXgHaMAyU5C02HF/D?=
 =?iso-8859-1?Q?aE5QG2AUEGarz1e0TVMvbAv+L0OLST6LAprk3YmYZaZ2J9hUHVq0hE6HSW?=
 =?iso-8859-1?Q?7IZSeWNniF53l3C9J0fzNm0hvZk67gPa9uy7R47JNYaeQxVQ51gMhJsIPT?=
 =?iso-8859-1?Q?jk/KCiQsuuiqtb8VLqYh6oGFSr+pn11nGPWIf8Z1vtyXknvibKVpCfszMi?=
 =?iso-8859-1?Q?qc86o7+aQeenfgi2/gHXIfXPzDMEvF4VenyrzjQoy7L9x5hnG9R5/5K333?=
 =?iso-8859-1?Q?YkHiLQ68x0RYEt+vAc/+Q0c1IjV0T2vzLZnwSPGthRzs7K83qfBo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4676d97e-e898-4d64-a01b-08da35048326
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:17:52.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6atOWHG1EW090r97GM9DKV/jPpM6xg9S6oKSQL299OyvEE/DLTqFnCzFcFJDEpT35Qhwumgp17WK9EK6gfPfq6uaJgj9/vYtizGim0GQdI=
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

Deprecated WEP security for WILC driver as well as in firmware from
15.6 FW release onwards. After WEP security removal, freeup some codespace
which helped to add new features like WPA3 etc.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  76 +------------
 drivers/net/wireless/microchip/wilc1000/fw.h  |   6 --
 drivers/net/wireless/microchip/wilc1000/hif.c | 102 ------------------
 drivers/net/wireless/microchip/wilc1000/hif.h |   6 --
 .../net/wireless/microchip/wilc1000/netdev.h  |  10 --
 5 files changed, 2 insertions(+), 198 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 8d8378bafd9b..256026d57a70 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -313,32 +313,9 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
=20
 	vif->connecting =3D true;
=20
-	memset(priv->wep_key, 0, sizeof(priv->wep_key));
-	memset(priv->wep_key_len, 0, sizeof(priv->wep_key_len));
-
 	cipher_group =3D sme->crypto.cipher_group;
 	if (cipher_group !=3D 0) {
-		if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP40) {
-			security =3D WILC_FW_SEC_WEP;
-
-			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
-			memcpy(priv->wep_key[sme->key_idx], sme->key,
-			       sme->key_len);
-
-			wilc_set_wep_default_keyid(vif, sme->key_idx);
-			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
-						 sme->key_idx);
-		} else if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP104) {
-			security =3D WILC_FW_SEC_WEP_EXTENDED;
-
-			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
-			memcpy(priv->wep_key[sme->key_idx], sme->key,
-			       sme->key_len);
-
-			wilc_set_wep_default_keyid(vif, sme->key_idx);
-			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
-						 sme->key_idx);
-		} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
+		if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
 			if (cipher_group =3D=3D WLAN_CIPHER_SUITE_TKIP)
 				security =3D WILC_FW_SEC_WPA2_TKIP;
 			else
@@ -373,10 +350,6 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 		auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM;
 		break;
=20
-	case NL80211_AUTHTYPE_SHARED_KEY:
-		auth_type =3D WILC_FW_AUTH_SHARED_KEY;
-		break;
-
 	default:
 		break;
 	}
@@ -487,14 +460,6 @@ static int disconnect(struct wiphy *wiphy, struct net_=
device *dev,
 	return ret;
 }
=20
-static inline void wilc_wfi_cfg_copy_wep_info(struct wilc_priv *priv,
-					      u8 key_index,
-					      struct key_params *params)
-{
-	priv->wep_key_len[key_index] =3D params->key_len;
-	memcpy(priv->wep_key[key_index], params->key, params->key_len);
-}
-
 static int wilc_wfi_cfg_allocate_wpa_entry(struct wilc_priv *priv, u8 idx)
 {
 	if (!priv->wilc_gtk[idx]) {
@@ -552,33 +517,6 @@ static int add_key(struct wiphy *wiphy, struct net_dev=
ice *netdev, u8 key_index,
 	struct wilc_priv *priv =3D &vif->priv;
=20
 	switch (params->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP) {
-			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
-
-			if (params->cipher =3D=3D WLAN_CIPHER_SUITE_WEP40)
-				mode =3D WILC_FW_SEC_WEP;
-			else
-				mode =3D WILC_FW_SEC_WEP_EXTENDED;
-
-			ret =3D wilc_add_wep_key_bss_ap(vif, params->key,
-						      params->key_len,
-						      key_index, mode,
-						      WILC_FW_AUTH_OPEN_SYSTEM);
-			break;
-		}
-		if (memcmp(params->key, priv->wep_key[key_index],
-			   params->key_len)) {
-			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
-
-			ret =3D wilc_add_wep_key_bss_sta(vif, params->key,
-						       params->key_len,
-						       key_index);
-		}
-
-		break;
-
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP ||
@@ -676,13 +614,6 @@ static int del_key(struct wiphy *wiphy, struct net_dev=
ice *netdev,
 		priv->wilc_ptk[key_index] =3D NULL;
 	}
=20
-	if (key_index <=3D 3 && priv->wep_key_len[key_index]) {
-		memset(priv->wep_key[key_index], 0,
-		       priv->wep_key_len[key_index]);
-		priv->wep_key_len[key_index] =3D 0;
-		wilc_remove_wep_key(vif, key_index);
-	}
-
 	return 0;
 }
=20
@@ -713,13 +644,10 @@ static int get_key(struct wiphy *wiphy, struct net_de=
vice *netdev, u8 key_index,
 	return 0;
 }
=20
+/* wiphy_new_nm() will WARNON if not present */
 static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
 			   u8 key_index, bool unicast, bool multicast)
 {
-	struct wilc_vif *vif =3D netdev_priv(netdev);
-
-	wilc_set_wep_default_keyid(vif, key_index);
-
 	return 0;
 }
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 1114530d03e4..237ca348d1f8 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -41,12 +41,6 @@ struct wilc_drv_handler {
 	u8 mode;
 } __packed;
=20
-struct wilc_wep_key {
-	u8 index;
-	u8 key_len;
-	u8 key[];
-} __packed;
-
 struct wilc_sta_wpa_ptk {
 	u8 mac_addr[ETH_ALEN];
 	u8 key_len;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 71b44cfe0dfc..573750356007 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1038,108 +1038,6 @@ static void timer_connect_cb(struct timer_list *t)
 		kfree(msg);
 }
=20
-int wilc_remove_wep_key(struct wilc_vif *vif, u8 index)
-{
-	struct wid wid;
-	int result;
-
-	wid.id =3D WID_REMOVE_WEP_KEY;
-	wid.type =3D WID_STR;
-	wid.size =3D sizeof(char);
-	wid.val =3D &index;
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to send remove wep key config packet\n");
-	return result;
-}
-
-int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index)
-{
-	struct wid wid;
-	int result;
-
-	wid.id =3D WID_KEY_ID;
-	wid.type =3D WID_CHAR;
-	wid.size =3D sizeof(char);
-	wid.val =3D &index;
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to send wep default key config packet\n");
-
-	return result;
-}
-
-int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
-			     u8 index)
-{
-	struct wid wid;
-	int result;
-	struct wilc_wep_key *wep_key;
-
-	wid.id =3D WID_ADD_WEP_KEY;
-	wid.type =3D WID_STR;
-	wid.size =3D sizeof(*wep_key) + len;
-	wep_key =3D kzalloc(wid.size, GFP_KERNEL);
-	if (!wep_key)
-		return -ENOMEM;
-
-	wid.val =3D (u8 *)wep_key;
-
-	wep_key->index =3D index;
-	wep_key->key_len =3D len;
-	memcpy(wep_key->key, key, len);
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to add wep key config packet\n");
-
-	kfree(wep_key);
-	return result;
-}
-
-int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
-			    u8 index, u8 mode, enum authtype auth_type)
-{
-	struct wid wid_list[3];
-	int result;
-	struct wilc_wep_key *wep_key;
-
-	wid_list[0].id =3D WID_11I_MODE;
-	wid_list[0].type =3D WID_CHAR;
-	wid_list[0].size =3D sizeof(char);
-	wid_list[0].val =3D &mode;
-
-	wid_list[1].id =3D WID_AUTH_TYPE;
-	wid_list[1].type =3D WID_CHAR;
-	wid_list[1].size =3D sizeof(char);
-	wid_list[1].val =3D (s8 *)&auth_type;
-
-	wid_list[2].id =3D WID_WEP_KEY_VALUE;
-	wid_list[2].type =3D WID_STR;
-	wid_list[2].size =3D sizeof(*wep_key) + len;
-	wep_key =3D kzalloc(wid_list[2].size, GFP_KERNEL);
-	if (!wep_key)
-		return -ENOMEM;
-
-	wid_list[2].val =3D (u8 *)wep_key;
-
-	wep_key->index =3D index;
-	wep_key->key_len =3D len;
-	memcpy(wep_key->key, key, len);
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list,
-				      ARRAY_SIZE(wid_list));
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to add wep ap key config packet\n");
-
-	kfree(wep_key);
-	return result;
-}
-
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index 77616fc77575..c9740457ed58 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -151,12 +151,6 @@ struct host_if_drv {
 };
=20
 struct wilc_vif;
-int wilc_remove_wep_key(struct wilc_vif *vif, u8 index);
-int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index);
-int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
-			     u8 index);
-int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
-			    u8 index, u8 mode, enum authtype auth_type);
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a067274c2014..630b1e85e68f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -45,12 +45,6 @@ struct wilc_wfi_key {
 	u32 cipher;
 };
=20
-struct wilc_wfi_wep_key {
-	u8 *key;
-	u8 key_len;
-	u8 key_idx;
-};
-
 struct sta_info {
 	u8 sta_associated_bss[WILC_MAX_NUM_STA][ETH_ALEN];
 };
@@ -63,8 +57,6 @@ struct wilc_wfi_p2p_listen_params {
 };
=20
 static const u32 wilc_cipher_suites[] =3D {
-	WLAN_CIPHER_SUITE_WEP40,
-	WLAN_CIPHER_SUITE_WEP104,
 	WLAN_CIPHER_SUITE_TKIP,
 	WLAN_CIPHER_SUITE_CCMP,
 	WLAN_CIPHER_SUITE_AES_CMAC
@@ -132,8 +124,6 @@ struct wilc_priv {
 	struct net_device *dev;
 	struct host_if_drv *hif_drv;
 	struct wilc_pmkid_attr pmkid_list;
-	u8 wep_key[4][WLAN_KEY_LEN_WEP104];
-	u8 wep_key_len[4];
=20
 	/* The real interface that the monitor is on */
 	struct net_device *real_ndev;
--=20
2.25.1
