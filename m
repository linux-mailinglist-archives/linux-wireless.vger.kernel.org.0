Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA2532A02
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiEXMGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 08:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiEXMGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 08:06:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165118350
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653393991; x=1684929991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KsH5sYE2u2YRHQc9eXQt5Tfd+tPOiENJz897/d76V4Y=;
  b=L/KQdHu8hbTVu41OrrHJ9ReQVZHWldgH0bQomlw2Wg9DbWa29Hyj2uM8
   5xYa5h6MPCVCZgwl2N0KkR6gxGsPrlifeYXRYr2FBxwTtfned0y9NE9hp
   TQK0Q6e2bAMjWD/FhEwcHKpB03H1vmxr46prvC6NDS/ZzaQZOhtXZC41A
   7+RXYN86m7u8rpgHzyA8Ej7UQ+rkTe52k91jQbHa7QUB8F43LxXVBi1+j
   oYCx/vnaFPPlNvUIfJR2EtXlBWvdn81YDXXCivSAhFJM8ib7i+okqI+ZG
   faWxmU0BUR5Lku8smD39S2BV0kZwBuw7bMVfgvTEfaqPjXcEAOfpmgWGd
   g==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="174813214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2022 05:06:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 24 May 2022 05:06:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 24 May 2022 05:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfyrMv8wGYBmoInTNxJes/v0Kt/04Rfh5doXlJrOHITrgxmTsFSjoykiarViPgZ5pjcuJlLNGrK9KUuztQgE+jYdbKATD4nEvnLzddA+MqccyFjlJpja2l6PpeM9Muc2qeRRVC/aIq3WISghG2bQbQ+J5aJiY8ZfqEDOKDVvhqGixU4TGJUg7c1y7IbyUOkfaYwPpU3DxmpizI6Z4FW5OnoCPxbdyESvujZTQ1gS8f1yA4oUYiIwPNZR8wwR80HprcROiVk6frPHRRKMt4Ldvvu/uaWzYInsEwx2cP0G7bGc+mft5bqyvH2LMQJ4044zDV9vHL/V83sfXpP825dt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH34q5DUTaS4NO+saZpHmJDS1O8nIf305oT33HboKPY=;
 b=TOOmPC3v5nSIFs/tWolRQDjUNOAbha76cYEpYNJo755SBklYvc2qkoH0qnfevvScDL8WxbJBBYI8rQvCcWdss9odY1Vf1zQpPP3G3Adk8GJlvZPMa3jp9lur4njcUo3dAePSWTkMlfhvj3tg1IyJdqSN4+lc0YWTWfXE6rfpFJ9p9ckG3lEt/CZX4Wa8yGZEMQiO3p75fyldIg+nn9tMf4RYPIEgbYV4fmu/W0RUaidkBt8xLY05w3ryxaJaLKdCdTF6+Ly5JTYYFM5V74t3hpVQ72GNMMxeApt+xgupXoCjoVsiq5Dm5P7pTQb26wqTOBkjpVaLK9evdaiQjEQ5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH34q5DUTaS4NO+saZpHmJDS1O8nIf305oT33HboKPY=;
 b=KtIs5bRaYmOBIlXS97ILMxWEwmsKGnYbvTg8u6TFqC34pbD+DkYSYKIiPPx/8S+5bM5RZNWG1YQf/p7OXdhdlEutgGLvpu19vd6Ka1LmiohJj2QDrQRAgeUVmcXPngNft1UgL3vVPzUvjbaCe+LLV6R9YCvUKkY6Iz2bRDDID+I=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:06:20 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:06:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 3/4] wilc1000: add WPA3 SAE support
Thread-Topic: [PATCH v3 3/4] wilc1000: add WPA3 SAE support
Thread-Index: AQHYb2au9j/HVVIQJUaDvl60vbhx4A==
Date:   Tue, 24 May 2022 12:06:20 +0000
Message-ID: <20220524120606.9675-3-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 90d0eda7-aee6-4fe7-ca7c-08da3d7dd0bf
x-ms-traffictypediagnostic: CH0PR11MB5412:EE_
x-microsoft-antispam-prvs: <CH0PR11MB541208A0E03787C30EE11510E3D79@CH0PR11MB5412.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rsYmxEXS5h1Ag3Op1VhWxTr9FklShbKQx0XsryWOBtG4By1Px+xrTHeuFu2kr1Ss5S/IXD1gU8ssVqjImANpmjIUquGK0Mx4dzCt2jq3d/Ac9MN577s4XXJfs6N4Y3c2GyiKCS3pDTxDqTYIxJH9Ds/e/V4xzoI4lUrensIkI4qdu9rdzQW2If4jFHMTRFnTmItLMCk42IOqkpeoYLI5qzVlWOkIY1D9Q7f8rW59zHZpypJgIRRAsLPw2RP8QM5/f+PybP+tLLN2onV8WT6CnbK7hCAxfwopw5xf63E925kKStyynQDxOAxPPjPjIoVceJoNA4gKAYPRDe8QgVw7JqMT4+52vUBjIXFX4iH9y19bSEC6DFLkkOKow4FFbvlZGnz/5EeOpedQlw8fd8qnIV6uOPCfae8YIU35JYwljExADrQFnC/v3HWq1XUrdCOPoXwnZwQEdRmWsBER5eXdnijEBNS6CWeJR2im6YLsxhxIW414BKrOYs+wQZdX+YJ5PJOLGobLZiy9ofwQiDDa3bIHaQRdCzp8I+uikd6RN82tCR1uW+cawK1tKYJGT+xlz233mDXFnctikMwPMDlYO2jWk1OC8JqNiU5dgyfwfu4c8IQVYzFyv0L3b54V+UTypAo+Zljg/XJW2T2aQ19No/46oVY6Tx9qdxkTVUkCWC5AgWJABwx5B3yO849hWWVXMz3dlZRxgsSwCv0SVTdWqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(83380400001)(2906002)(30864003)(8936002)(1076003)(2616005)(6486002)(5660300002)(86362001)(508600001)(26005)(107886003)(38100700002)(38070700005)(36756003)(316002)(122000001)(8676002)(4326008)(6512007)(66946007)(66476007)(6506007)(186003)(66446008)(76116006)(91956017)(64756008)(71200400001)(66556008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QXI/CFMgbmBtWprerq68kixz6fRIURVyaz+rLv+xXaSiHPoOQfA05RmXyM?=
 =?iso-8859-1?Q?I1rE6GTpI84Q3QUmzeDCH2K9sI+h+/zlnOVCrXnRuBm/eAu2eF2kQYraYy?=
 =?iso-8859-1?Q?gVdLHM+LHoREjVg/NIZ+CTvEaXg2pCEuhmKxbG4DVMAk0X1m+OaiLTHnS1?=
 =?iso-8859-1?Q?efKTFNns9jhO8TofhSFAfvtCGgUTVmp3SJvkTnNQIJkh7Q3mrnfFH/ZBib?=
 =?iso-8859-1?Q?9FVZi/vM+pcjjIRxamHqAPkFJUgkGL2t0yEy+cV4CabBVbIIM45btCcC/c?=
 =?iso-8859-1?Q?TrCVAhAX3+ouwJyZ2g8wFGLi5APM0lHj44SPVvlQt/BLfumw+iNEMfL9kd?=
 =?iso-8859-1?Q?97rFXCbdbSQvNGr4j+lr8PFh4zxAsuCrcrECXhJwFEVIhIvPtFRJKTcv8v?=
 =?iso-8859-1?Q?3Po7FpYQH29a62bVeQhjl4WhUDNCPdVOYtkMY6JA9MkWlZCunjAkgbVuL2?=
 =?iso-8859-1?Q?1WTEoUxb44wHJbLTkY9ZwO9pxw/MLzCpdL31QjN1paCrzm/mOvupUR/ER7?=
 =?iso-8859-1?Q?eit6urTA+BbYjFCM9RW+cpPjc79Bi/KTPEHEYPlfDan7LjSZOVneZ+f+3N?=
 =?iso-8859-1?Q?i6w67UJZFh2qfUunnVhrR180EtU2pxb6MdIhWzZI7qR5cjBXo2k+uYn3T9?=
 =?iso-8859-1?Q?3U3MCopoE1s49MvSRW3mbhh6NSIZkUXTikCVUoX9RCdMNzzKHp1wkRN4AI?=
 =?iso-8859-1?Q?LuDgncL4PTAM2T6eHQr64UvcRPyTsGBX6WyHm5ykS8CDRjS1CpnganOiER?=
 =?iso-8859-1?Q?dHCGUUJyI1Xqf4hfSNPsFAx6RU9YXUfAAM3OD6ZClN8mSIamwWk3eisheX?=
 =?iso-8859-1?Q?CnE/yc2tApW1xZmIPQHRfx8HUbrX5j3bivQ4v9xr9XNFlrt3T5Wzy1oMzU?=
 =?iso-8859-1?Q?fWhLhiMQsnLHb4n3+oRx2qAVcwXbGzD9K6zUAhozNdMG153u+E0CheGf7z?=
 =?iso-8859-1?Q?7UpWo7zRv0sIERBd4tPEmJZJSS3MphV3sKiJw/94j2UZ2rS1EnQwRrlUGH?=
 =?iso-8859-1?Q?2O+UDVIPi1SWQVKWPMgze/I4NhACMOtAMvPuHYiaEprPPjJXLBcmk9qpwn?=
 =?iso-8859-1?Q?+I4cEDpk56slU1VoYSpGavsBNSZ5HdfpIeLzyMz9hh9GoLWL+oyNUNQSqh?=
 =?iso-8859-1?Q?poEvNhErlnM8hiWIdTnvtUPCBszL0Xazl4gRztqXLadC3TVZvYASC/jNqT?=
 =?iso-8859-1?Q?ohQvUulAlSmfmHSNk5a2e+VbF/d4AVCfujKNon5tWuRanLwD/REmRvH5/U?=
 =?iso-8859-1?Q?hnvCwFRXJUd9QAj5Y0SI0HNrkddw3aRIyMB/N4nvJwp8Z8Zxnuj2wjFX9k?=
 =?iso-8859-1?Q?ZX0J2ie1XiiE4fSDrj/YNgOnCBIv1KqenRw0WmJOjok70crurJ6f6djyWa?=
 =?iso-8859-1?Q?GR31hTYDCA0zxHCjXpyakzBCvwSt4WHviyiGW6eWzAIqyYiCPLtlJTYp/b?=
 =?iso-8859-1?Q?TLOwxWajJ+OC7sX4CnfOnnx/QT7yHCS7CI8Uk2sAL5nLTO7UaP+fTM/k6n?=
 =?iso-8859-1?Q?fikgeFTIq87jEWjAv20cQVHAQg7yofRikgHwLZwLDR1cPkEl/D5HgWAMDg?=
 =?iso-8859-1?Q?8TQm0pYcG8TwtH33cn70qF/axHKVgX1wcDO/h+f7Bao+lqzIy+X9LgKRUu?=
 =?iso-8859-1?Q?ZkVD6fIQYW1GRLU1p2GV/V3Cs3GA0MXRgFlTPVVNIUPZk8Wkva0LDvySD+?=
 =?iso-8859-1?Q?qFcrwMtPXcC+VgfBzGPi/0yl/Xya7Zv9PK0Viz1wnaI9O/nngWAVTYniJR?=
 =?iso-8859-1?Q?55iDUTeLD2Of2+d1iPX9wZLY+iVzVqaM965T/Zarm75STaftFKmrU7fIEC?=
 =?iso-8859-1?Q?HtKd1G9xhcSz3v8RqMQ7hF4/N82ZZJ9eMgsdecZfsYaSdlr74fk1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d0eda7-aee6-4fe7-ca7c-08da3d7dd0bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:06:20.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32plqAyosUjgud2JOhiNObTY9yIlTLT/BhjXYPiSTbe3uoGk3SxRnDMq1EC0tzgnkqxDjt9XMurAv0AxAA4ciFTTbD8p2Ghv7kqivZHFFyw=
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

Enable SAE authentication for AP and STA mode. In STA mode, allow the
driver to pass the auth frames which are received from firmware to
userspace application(hostapd) so that SAE authentication is offloaded to
userspace.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---

 v2: remove unused variable reported by kernel test robot

 .../wireless/microchip/wilc1000/cfg80211.c    | 62 +++++++++++++++++--
 drivers/net/wireless/microchip/wilc1000/fw.h  |  9 +++
 drivers/net/wireless/microchip/wilc1000/hif.c | 44 ++++++++++++-
 drivers/net/wireless/microchip/wilc1000/hif.h |  3 +
 .../net/wireless/microchip/wilc1000/netdev.c  | 11 +++-
 .../net/wireless/microchip/wilc1000/netdev.h  |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
 .../net/wireless/microchip/wilc1000/wlan_if.h | 10 ++-
 9 files changed, 133 insertions(+), 14 deletions(-)

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
index 3c292e3464c2..fcc4e61592ee 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -835,15 +835,24 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u=
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
+		struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)buff;
 		u16 type =3D le16_to_cpup((__le16 *)buff);
 		u32 type_bit =3D BIT(type >> 4);
+		u32 auth_bit =3D BIT(IEEE80211_STYPE_AUTH >> 4);
+
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
