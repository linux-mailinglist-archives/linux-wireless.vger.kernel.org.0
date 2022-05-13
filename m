Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5434452681D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358943AbiEMRSL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbiEMRSD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 13:18:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EEDE96
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652462282; x=1683998282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IhT2NfWmxVRWlbfqSlP/fzKzzP1qCdcO0mVCpmGEZa4=;
  b=s97vtcCjyva9KOBdLJTt6ttyziWtnRWtXR9KXGawn5b/ZkpWT4nnm8Gf
   HERBZYlgmtLfFkgi0dCcuKIgLFp0Tn/tlBLGM9KmwcsGafTSn8s2lK/LS
   iBlOwannFLXXAmItIW38U3LVksI48Qn6FKdATC7JRHN5hUGRSDWvVeC7m
   CMa5rrf6u78nqsJqdGFsTHkHY0ZmOvftdXWdnOl3ae+OgOhmWi6gm5vGS
   0o6kcTT7hRFBY7qulu2VyaL0AwX8nilNC/KxJY2HrwmZ8mjsRsIBydO5u
   VIhsCfNccdTzHBVyULMPslf/f8Gtbcd7EctZIY1XGbBwvNUDwlsWPEEZX
   A==;
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="155983590"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 10:17:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 10:17:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 10:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXiZFgG9x5F/X1NleH/9T/gXzHPtZco3m9+imrw0OmKDEw0b8oHC+/6xwfoQol0ZZO1nBVFFtOwz/Ub5Tn//VMdnL5qLJEsqOFQDDyGB4AoIFAhJHhhrNecN+5mNdSntYXMLJfvGrCMZiT8o947jOLFKKi4gi9xEpdF3DHF84Nnwc/vCzG6gFSIV8Tt3Pj+ki58gDHcacjiO9796oGD6rdxxzh6hrQMneieCR0YMd10x33kOyEdpciSgA7w7ktEMGDDsDGgh2zacioMqLs421zhmgkCSshXinN5SgNSnZathK+N6YZQQSqZ7rhy4VDbE1mb8m+Yd6eCV8qEa0i07jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCan1DL3Ze61y1TL9Q5Wr8xTbYicK6XEQjhlsYqKI2I=;
 b=Wdm5soYdiX4GR7XFCYp+VuQ24mktLuBCg0B2RLQ/616igCeXXpRdgMOBC2CAsXykZLRKN/zzGBw2paUIIKIiNYehNe2eWzuhH3O/WESgP1kfo+BZcv4+SeAtY1imlffNKOV8opEAw6TqlwQ5LqQ4B901Wcg+KMA/6bFrFgFG/68fpjILuWbNZ/jqc8lG+WCM3PxqjMXGeyAnHJOEP47pqLaSxwB64PUVgmgO4NoEVy5CSRu2CpMPiNLOtc+wk8X0CW0UxkHKhtit2FzSPHbfDVIjcHVpV/LgLu1fV3uFgXJb5Z56OFY7ARpnnzTXh1+6/0npQPVToE895m86l/JK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCan1DL3Ze61y1TL9Q5Wr8xTbYicK6XEQjhlsYqKI2I=;
 b=cZXpm6y2nVvt0C2bx6AGOZcVDnVwIxTwIkcA4z+phkZOR3BBQRba9YBpALKAX7p6z3I/1ttcE4eOIlihZsP2FublFyzJxlqLdmKmWheB5z8g8hiR6IiEbBaR9Hs8blrzuMBS3+7Ie3VQ5/fQZRVrCTOs6wOM5BtdxD+ocjykazU=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BL0PR11MB3441.namprd11.prod.outlook.com (2603:10b6:208:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Fri, 13 May
 2022 17:17:53 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 17:17:53 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/4] wilc1000: add WPA3 SAE support
Thread-Topic: [PATCH 3/4] wilc1000: add WPA3 SAE support
Thread-Index: AQHYZu1h0NW5KIWnr0OKB0zhecXd5Q==
Date:   Fri, 13 May 2022 17:17:53 +0000
Message-ID: <20220513171741.26701-3-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: e80b7827-8f73-41d5-baf1-08da350483a9
x-ms-traffictypediagnostic: BL0PR11MB3441:EE_
x-microsoft-antispam-prvs: <BL0PR11MB3441AFDC41EE75E6F6A8777DE3CA9@BL0PR11MB3441.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +j4izPdkDyI8s4MvXHhQ6RFKtCDMqPXKCL/ZGDHHeh9Fptwrg52O5hMyZ8c/mXnspTzZCZqp8IkwWIuNmi9955gO6i2RaC4QYI8YYUwyabnPSzC5syv9JaT43NPzbS4YIhhuXV2dX7WS1sNaQmed2xxPjBau3gGAZJURmAh2yYWhzNVdlWIh2bqwhoy1oQ+fL5WVUmUAAyr7tyPSgpyZzSZ+2OXbxOMpm9x2spg/vdtWDyUcnKz2hc0UycwhRpAHXH+u5+/tCB74YwgtjYNZP8mzmiadDdik8IGMuMDravlNu1wm1GWcMMJTxr1YiuUK6vecsZk0v6cf+uJut2E9SBQjFvD0UXuruyOje/UixTO1+/QRYg9hAzf8UzIJISE1rQYzRsZB0uu6bpLV8j8fAwnjX1hfvCdoAQ4zBnHKZBIhneladITl61NFQxc0uhpV+M/vjZ7OqV6+Q/oE6d7q+laZAeWU6KxLeFqQgxkDTSJPRG/HJvmOQTxpMftXAQCaNpFcJiLOVeBKNMMi5JKiJ0d0edMSjo1U6E3kuGKSm0TAdI6AGKUBH7dWh92F03Cj5FBis2MfcSHpBNzYaTKsnHb6zd1YOkZXk0xFs2nj85YlypqSZboyWThlLif9GVFvnKrg+WzGaROHzyPZeQZ5ZiosOofBkdxZyoGJxiSchK6ILEHMmdmYPwq+80HSikBvW7q2Ftkn8aQ66uZYTkudXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(38070700005)(38100700002)(1076003)(36756003)(186003)(83380400001)(107886003)(6486002)(30864003)(508600001)(8936002)(2906002)(5660300002)(86362001)(6506007)(91956017)(6916009)(122000001)(4326008)(8676002)(6512007)(71200400001)(26005)(2616005)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qHRd08xOubOoPeAoOO97SXTsYeagVeY0e2+234fluG9M8QlU+l9SryUaK6?=
 =?iso-8859-1?Q?LEoEPpX5v2kpVmJnREB0UsDacXOyuu/25rg7fzGy6xoKzLDDM7LhrOKT8H?=
 =?iso-8859-1?Q?btwIGlg+dYyP7a03k9lsrDHzj6Cp4AFqxFqT/a0ePANAIRxYK53ztNC2D9?=
 =?iso-8859-1?Q?21U3xU/7VHdG0HnzljWkPkTSfkGK6PWSU4tI1ScqZP+Hm8VQOEUDcYc7+C?=
 =?iso-8859-1?Q?AdKx2YwSuryNdBhQFjEkbahWI8NL0vtlCMeBL30camzHdmrfkGC2i02jCh?=
 =?iso-8859-1?Q?+PyWhGGA1UzymYmuwsqLb2p2rrcz+j8u7nO3a+DlJtgw/nbMgG9yoGtqdc?=
 =?iso-8859-1?Q?kEBtLANL6dXUJAlbyqUHcBvwSLI9z9KgapflZlVyw5nJEjfv6kxjhYgRV1?=
 =?iso-8859-1?Q?Q8nZbQnSBIs6ML07hCHKwttJ+TQnKR2po4KMsMfxc57//yl2aioR3fOCGA?=
 =?iso-8859-1?Q?cOtQnHhoWhWYpsHvB8QpdZ5pDO6VSHynZzyorb8V2DYU1Yh2hA9viV5l8l?=
 =?iso-8859-1?Q?RvHsdUT482y8224D3X9s8x6peI59XlpWSD5CYJ6RTyJRg/nCyELb48SOne?=
 =?iso-8859-1?Q?kdUi1IBd9+VSPdRJjdQHe0qMsXaZfEMYI4Qf7hVCPYZ3UjatVr32gZ1PO+?=
 =?iso-8859-1?Q?646QUKLdYuX6Czopo1V/M++ZKBYO5OQibrpA7RstNfOiKp4AVKBBtGRmKz?=
 =?iso-8859-1?Q?ldtQIwcw86TeWkMxI/MikEOlzLm7pH9jijmpPNqlb0d2Z9UQJufdqFK+uH?=
 =?iso-8859-1?Q?iBaWO/wMbyB+oK8WR9gbxSKNVHxeR+p0pM8jADBD1t17zGBrA7nomA7rv2?=
 =?iso-8859-1?Q?5dvK45g6+FhYbtNcvwMXhxx1/quqJRZzRtKeschJz+gO4pdw9kwHgP/UmT?=
 =?iso-8859-1?Q?BuicOjXUuuLtsoll6jHQ462yJJiMH+MyloS4dUu5djW5Cg2rT2rI+in8PP?=
 =?iso-8859-1?Q?fymCw4DJhoVfXRZnAnXxDNMQMzgX2xph2W2F/QjA8X4g0ry8OtuAjFHmSb?=
 =?iso-8859-1?Q?aBvqIP5eMfY/v/sbc5EQTKDu/5rqLvnmlLVK0CEE/KcT2TNkcU26c+CHbx?=
 =?iso-8859-1?Q?VCmEiiND1ADI/RrIZI/FPR6W+YLt0A2XlIkS8lCwzVfrw0GmKyvZIjOnTq?=
 =?iso-8859-1?Q?6oq1QbIFaaqP4xglU85BTYcDq8iVA/8LX2+gIjA7dQdoeqaGWGu6oZdxJd?=
 =?iso-8859-1?Q?fFjAQKYyDA3TL5U//ieZrp89gLb7Xqy5eSKkP8nl7BOap7c0VS6P5OVXNf?=
 =?iso-8859-1?Q?oXIxW+r9Zxc+SfBPBlNcrOd6ZHO+w1XBji/kPNT9c8oAujQ3EuJ3IUpUPD?=
 =?iso-8859-1?Q?5QHpVnIO1NfKRQ4qmrG28QOLudUtaAGvvSSKZ14jX7Sf8iouhl1/Ato0xb?=
 =?iso-8859-1?Q?IiL18LUdTFlITkSTDHLZYD4pwbKBNapWr6GV58u2QKwH7tP6i3ol5dTvof?=
 =?iso-8859-1?Q?3TaVQBTTJunORx43o4/mlkOZbdCDW1U6MtX+Q6mM4F77pQ/1Wnnms1994P?=
 =?iso-8859-1?Q?viIWIKOr7stbPdBQ0ToXaSjbZUHLrURcSmm0vzEX9+dib9S8IvJAvL1WTz?=
 =?iso-8859-1?Q?zCtkRZ483UYmkvfQ7gSsc526s0bnLRqNKk+17xb5KRXBk1/Km/iINL5KL7?=
 =?iso-8859-1?Q?DCqBT0xnX52CGfZXZQvyXSA7W0upPZezes8LwanlqXQnC6oiosHMSaRai8?=
 =?iso-8859-1?Q?fRJfO0kAW/mq3GXtfVQQ5vlnvQh3HqeH1uVma0SdgYAnGutu8+nf7XLDOi?=
 =?iso-8859-1?Q?rta4k7GbWp64i0IOOKLVUO8PAjY5vSMJQOE9F0beU2vBgnPImYV8+JvW8g?=
 =?iso-8859-1?Q?IH5FIbk6jfq7H0D4wzqmpD1R3Mp7CA995e713fqz+JRTl0d3Tu+l?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80b7827-8f73-41d5-baf1-08da350483a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:17:53.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oORap9RMHJObgVPnSLhRD6IzF4Tvvm4FZUxzn34IA5VEUNgaJjJdy5zFmz2njHInyjPr4Be1cv4QcjHvSX67u0s+pcQWPufopH7a1/z2hQ=
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

Enable SAE authentication for AP and STA mode. In STA mode, allow the
driver to pass the auth frames which are received from firmware to
userspace application(hostapd) so that SAE authentication is offloaded to
userspace.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 62 +++++++++++++++++--
 drivers/net/wireless/microchip/wilc1000/fw.h  |  9 +++
 drivers/net/wireless/microchip/wilc1000/hif.c | 44 ++++++++++++-
 drivers/net/wireless/microchip/wilc1000/hif.h |  3 +
 .../net/wireless/microchip/wilc1000/netdev.c  | 13 +++-
 .../net/wireless/microchip/wilc1000/netdev.h  |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
 .../net/wireless/microchip/wilc1000/wlan_if.h | 10 ++-
 9 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 256026d57a70..ea59ce9fd991 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -20,9 +20,11 @@
 static const struct ieee80211_txrx_stypes
 	wilc_wfi_cfg80211_mgmt_types[NUM_NL80211_IFTYPES] =3D {
 	[NL80211_IFTYPE_STATION] =3D {
-		.tx =3D 0xffff,
+		.tx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4),
 		.rx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
-			BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4)
 	},
 	[NL80211_IFTYPE_AP] =3D {
 		.tx =3D 0xffff,
@@ -350,6 +352,16 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 		auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM;
 		break;
=20
+	case NL80211_AUTHTYPE_SAE:
+		auth_type =3D WILC_FW_AUTH_SAE;
+		if (sme->ssid_len) {
+			memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
+			vif->auth.ssid.ssid_len =3D sme->ssid_len;
+		}
+		vif->auth.key_mgmt_suite =3D cpu_to_be32(sme->crypto.akm_suites[0]);
+		ether_addr_copy(vif->auth.bssid, sme->bssid);
+		break;
+
 	default:
 		break;
 	}
@@ -357,6 +369,10 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 	if (sme->crypto.n_akm_suites) {
 		if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_8021X)
 			auth_type =3D WILC_FW_AUTH_IEEE8021;
+		else if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_PSK_SHA256)
+			auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM_SHA256;
+		else if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_8021X_SHA256)
+			auth_type =3D WILC_FW_AUTH_IEE8021X_SHA256;
 	}
=20
 	if (wfi_drv->usr_scan_req.scan_result) {
@@ -905,6 +921,18 @@ static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf,=
 u32 len, u8 sta_ch)
 	}
 }
=20
+bool wilc_wfi_mgmt_frame_rx(struct wilc_vif *vif, u8 *buff, u32 size)
+{
+	struct wilc *wl =3D vif->wilc;
+	struct wilc_priv *priv =3D &vif->priv;
+	int freq, ret;
+
+	freq =3D ieee80211_channel_to_frequency(wl->op_ch, NL80211_BAND_2GHZ);
+	ret =3D cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
+
+	return ret;
+}
+
 void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 {
 	struct wilc *wl =3D vif->wilc;
@@ -1090,8 +1118,14 @@ static int mgmt_tx(struct wiphy *wiphy,
 		goto out_txq_add_pkt;
 	}
=20
-	if (!ieee80211_is_public_action((struct ieee80211_hdr *)buf, len))
+	if (!ieee80211_is_public_action((struct ieee80211_hdr *)buf, len)) {
+		if (chan)
+			wilc_set_mac_chnl_num(vif, chan->hw_value);
+		else
+			wilc_set_mac_chnl_num(vif, vif->wilc->op_ch);
+
 		goto out_set_timeout;
+	}
=20
 	d =3D (struct wilc_p2p_pub_act_frame *)(&mgmt->u.action);
 	if (d->oui_type !=3D WLAN_OUI_TYPE_WFA_P2P ||
@@ -1158,6 +1192,7 @@ void wilc_update_mgmt_frame_registrations(struct wiph=
y *wiphy,
 	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
 	u32 presp_bit =3D BIT(IEEE80211_STYPE_PROBE_REQ >> 4);
 	u32 action_bit =3D BIT(IEEE80211_STYPE_ACTION >> 4);
+	u32 pauth_bit =3D BIT(IEEE80211_STYPE_AUTH >> 4);
=20
 	if (wl->initialized) {
 		bool prev =3D vif->mgmt_reg_stypes & presp_bit;
@@ -1171,10 +1206,26 @@ void wilc_update_mgmt_frame_registrations(struct wi=
phy *wiphy,
=20
 		if (now !=3D prev)
 			wilc_frame_register(vif, IEEE80211_STYPE_ACTION, now);
+
+		prev =3D vif->mgmt_reg_stypes & pauth_bit;
+		now =3D upd->interface_stypes & pauth_bit;
+		if (now !=3D prev)
+			wilc_frame_register(vif, IEEE80211_STYPE_AUTH, now);
 	}
=20
 	vif->mgmt_reg_stypes =3D
-		upd->interface_stypes & (presp_bit | action_bit);
+		upd->interface_stypes & (presp_bit | action_bit | pauth_bit);
+}
+
+static int external_auth(struct wiphy *wiphy, struct net_device *dev,
+			 struct cfg80211_external_auth_params *auth)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+
+	if (auth->status =3D=3D WLAN_STATUS_SUCCESS)
+		wilc_set_external_auth_param(vif, auth);
+
+	return 0;
 }
=20
 static int set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *dev=
,
@@ -1590,6 +1641,7 @@ static const struct cfg80211_ops wilc_cfg80211_ops =
=3D {
 	.change_bss =3D change_bss,
 	.set_wiphy_params =3D set_wiphy_params,
=20
+	.external_auth =3D external_auth,
 	.set_pmksa =3D set_pmksa,
 	.del_pmksa =3D del_pmksa,
 	.flush_pmksa =3D flush_pmksa,
@@ -1732,7 +1784,7 @@ struct wilc *wilc_create_wiphy(struct device *dev)
 				BIT(NL80211_IFTYPE_P2P_GO) |
 				BIT(NL80211_IFTYPE_P2P_CLIENT);
 	wiphy->flags |=3D WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-
+	wiphy->features |=3D NL80211_FEATURE_SAE;
 	set_wiphy_dev(wiphy, dev);
 	wl->wiphy =3D wiphy;
 	ret =3D wiphy_register(wiphy);
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 237ca348d1f8..9449c5d0b472 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -110,4 +110,13 @@ struct wilc_join_bss_param {
 		struct wilc_noa_opp_enable opp_en;
 	};
 } __packed;
+
+struct wilc_external_auth_param {
+	u8 action;
+	u8 bssid[ETH_ALEN];
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	__le32 key_mgmt_suites;
+	__le16 status;
+} __packed;
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 573750356007..5d9d3aba737c 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -306,7 +306,10 @@ static int wilc_send_connect_wid(struct wilc_vif *vif)
 		netdev_err(vif->ndev, "failed to send config packet\n");
 		goto error;
 	} else {
-		hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
+                if (conn_attr->auth_type =3D=3D WILC_FW_AUTH_SAE)
+                        hif_drv->hif_state =3D HOST_IF_EXTERNAL_AUTH;
+                else
+                        hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
 	}
=20
 	return 0;
@@ -665,7 +668,12 @@ static void handle_rcvd_gnrl_async_info(struct work_st=
ruct *work)
 		goto free_msg;
 	}
=20
-	if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP) {
+
+        if (hif_drv->hif_state =3D=3D HOST_IF_EXTERNAL_AUTH) {
+                cfg80211_external_auth_request(vif->ndev, &vif->auth,
+					       GFP_KERNEL);
+                hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
+        } else if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP) {
 		host_int_parse_assoc_resp_info(vif, mac_info->status);
 	} else if (mac_info->status =3D=3D WILC_MAC_STATUS_DISCONNECTED) {
 		if (hif_drv->hif_state =3D=3D HOST_IF_CONNECTED) {
@@ -710,7 +718,8 @@ int wilc_disconnect(struct wilc_vif *vif)
 	}
=20
 	if (conn_info->conn_result) {
-		if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP)
+		if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP ||
+		    hif_drv->hif_state =3D=3D HOST_IF_EXTERNAL_AUTH)
 			del_timer(&hif_drv->connect_timer);
=20
 		conn_info->conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF, 0,
@@ -986,6 +995,31 @@ void wilc_set_wowlan_trigger(struct wilc_vif *vif, boo=
l enabled)
 		pr_err("Failed to send wowlan trigger config packet\n");
 }
=20
+int wilc_set_external_auth_param(struct wilc_vif *vif,
+				 struct cfg80211_external_auth_params *auth)
+{
+	int ret;
+	struct wid wid;
+	struct wilc_external_auth_param *param;
+
+	wid.id =3D WID_EXTERNAL_AUTH_PARAM;
+	wid.type =3D WID_BIN_DATA;
+	wid.size =3D sizeof(*param);
+	param =3D kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -EINVAL;
+
+	wid.val =3D (u8 *)param;
+	param->action =3D auth->action;
+	ether_addr_copy(param->bssid, auth->bssid);
+	memcpy(param->ssid, auth->ssid.ssid, auth->ssid.ssid_len);
+	param->ssid_len =3D auth->ssid.ssid_len;
+	ret =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+
+	kfree(param);
+	return ret;
+}
+
 static void handle_scan_timer(struct work_struct *work)
 {
 	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
@@ -1647,6 +1681,10 @@ void wilc_frame_register(struct wilc_vif *vif, u16 f=
rame_type, bool reg)
 		reg_frame.reg_id =3D WILC_FW_PROBE_REQ_IDX;
 		break;
=20
+        case IEEE80211_STYPE_AUTH:
+                reg_frame.reg_id =3D WILC_FW_AUTH_REQ_IDX;
+                break;
+
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index c9740457ed58..f1a0a1f042ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -47,6 +47,7 @@ enum host_if_state {
 	HOST_IF_WAITING_CONN_RESP	=3D 3,
 	HOST_IF_CONNECTED		=3D 4,
 	HOST_IF_P2P_LISTEN		=3D 5,
+	HOST_IF_EXTERNAL_AUTH           =3D 6,
 	HOST_IF_FORCE_32BIT		=3D 0xFFFFFFFF
 };
=20
@@ -202,6 +203,8 @@ int wilc_get_vif_idx(struct wilc_vif *vif);
 int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power);
 int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power);
 void wilc_set_wowlan_trigger(struct wilc_vif *vif, bool enabled);
+int wilc_set_external_auth_param(struct wilc_vif *vif,
+				 struct cfg80211_external_auth_params *param);
 void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length=
);
 void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)=
;
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 3c292e3464c2..6fdd16e9bf6a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -835,15 +835,26 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u=
32 size,
 	}
 }
=20
-void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size)
+void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 {
 	int srcu_idx;
 	struct wilc_vif *vif;
=20
 	srcu_idx =3D srcu_read_lock(&wilc->srcu);
 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		struct wilc_priv *priv;
+		struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)buff;
 		u16 type =3D le16_to_cpup((__le16 *)buff);
 		u32 type_bit =3D BIT(type >> 4);
+		u32 auth_bit =3D BIT(IEEE80211_STYPE_AUTH >> 4);
+
+		priv =3D &vif->priv;
+		if ((vif->mgmt_reg_stypes & auth_bit &&
+		     ieee80211_is_auth(mgmt->frame_control)) &&
+		    vif->iftype =3D=3D WILC_STATION_MODE && is_auth) {
+			wilc_wfi_mgmt_frame_rx(vif, buff, size);
+			break;
+		}
=20
 		if (vif->priv.p2p_listen_state &&
 		    vif->mgmt_reg_stypes & type_bit)
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index 630b1e85e68f..a0d9e981500e 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -185,6 +185,7 @@ struct wilc_vif {
 	struct wilc_priv priv;
 	struct list_head list;
 	struct cfg80211_bss *bss;
+	struct cfg80211_external_auth_params auth;
 };
=20
 struct wilc_tx_queue_status {
@@ -278,7 +279,7 @@ struct wilc_wfi_mon_priv {
 void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size, u32 pkt_offs=
et);
 void wilc_mac_indicate(struct wilc *wilc);
 void wilc_netdev_cleanup(struct wilc *wilc);
-void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size);
+void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)=
;
 void wilc_wlan_set_bssid(struct net_device *wilc_netdev, const u8 *bssid,
 			 u8 mode);
 struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 48441f0389ca..f3f504d12873 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -968,7 +968,8 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc,=
 u8 *buffer, int size)
=20
 		if (pkt_offset & IS_MANAGMEMENT) {
 			buff_ptr +=3D HOST_HDR_OFFSET;
-			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
+			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,
+					 pkt_offset & IS_MGMT_AUTH_PKT);
 		} else {
 			if (!is_cfg_packet) {
 				wilc_frmw_to_host(wilc, buff_ptr, pkt_len,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index eb7978166d73..b45e72789a0e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -305,6 +305,7 @@
 #define IS_MANAGMEMENT		0x100
 #define IS_MANAGMEMENT_CALLBACK	0x080
 #define IS_MGMT_STATUS_SUCCES	0x040
+#define IS_MGMT_AUTH_PKT       0x010
=20
 #define WILC_WID_TYPE		GENMASK(15, 12)
 #define WILC_VMM_ENTRY_FULL_RETRY	1
@@ -423,6 +424,7 @@ int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
 netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
=20
 void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size);
+bool wilc_wfi_mgmt_frame_rx(struct wilc_vif *vif, u8 *buff, u32 size);
 void host_wakeup_notify(struct wilc *wilc);
 void host_sleep_notify(struct wilc *wilc);
 void chip_allow_sleep(struct wilc *wilc);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index 6eb7eb4ac294..18f13b5643e8 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -85,7 +85,10 @@ enum authtype {
 	WILC_FW_AUTH_OPEN_SYSTEM =3D 1,
 	WILC_FW_AUTH_SHARED_KEY =3D 2,
 	WILC_FW_AUTH_ANY =3D 3,
-	WILC_FW_AUTH_IEEE8021 =3D 5
+	WILC_FW_AUTH_IEEE8021 =3D 5,
+	WILC_FW_AUTH_SAE =3D 7,
+	WILC_FW_AUTH_IEE8021X_SHA256 =3D 9,
+	WILC_FW_AUTH_OPEN_SYSTEM_SHA256 =3D 13
 };
=20
 enum site_survey {
@@ -176,7 +179,8 @@ enum {
=20
 enum {
 	WILC_FW_ACTION_FRM_IDX =3D 0,
-	WILC_FW_PROBE_REQ_IDX =3D 1
+	WILC_FW_PROBE_REQ_IDX =3D 1,
+	WILC_FW_AUTH_REQ_IDX =3D 2
 };
=20
 enum wid_type {
@@ -789,7 +793,7 @@ enum {
 	WID_ADD_BEACON			=3D 0x408a,
=20
 	WID_SETUP_MULTICAST_FILTER	=3D 0x408b,
-
+	WID_EXTERNAL_AUTH_PARAM		=3D 0x408d,
 	/* Miscellaneous WIDs */
 	WID_ALL				=3D 0x7FFE,
 	WID_MAX				=3D 0xFFFF
--=20
2.25.1
