Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8557C7D0721
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376294AbjJTDs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 23:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346903AbjJTDs0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 23:48:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B5D6D;
        Thu, 19 Oct 2023 20:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRsiYkBRwYEISV0mMtD8nJSl6GK2DudrD2EBQG3+sN9y4GohpbXbrpXdEwy7KVfeqFdeM0Z40Cm9/14/nSrTOC+VEtNwQF+KALV6WYHT5llKrW4Fq9HebW1+ReAE3KBYd5X+d6FoBWNe82MyQDuzBM1kVbIU7rzF3Us5nBMUgvtAtcD0Q5QoNRF2IeMV0OiRbjRfT1NxRAD+Wk1Dkuk2Yk4jOUdbuTvxdQIax163mKp3arM1w4XCM1LTuKchAuTMY5WDOsY77uibbc8lhq7qVcSUnj+o5sWOn3QSKdiKR9HnlCF/xgpw3NvkIzRPkGT+gN3TyB6QULEq3ovohrr8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWRcRKmudbqI0qax2S4mo8MMj1VvT9eC/WKABK8rIuU=;
 b=ZwGqSqIsw5TG+w4B6eViCpm6W1O2OI6YFQr7HPzdvCuW2BwAwvXEVMAWMkn6zTXqbkBjwfCbCZeRU/2MDNaxzC2vZ6HcXUl7jm+GVgH2P6JPDkl+g14RFtQDTpfSgofeonWkW9vW2UhnVAvAEqpHe1T1F+0A4eyUHhr3D5iG7tKgtHSy9fp8T2XLIny0Hva9lDo+gPz5g4tZj19ssRYgmuwUcsh5YKzYXaUjxe/7zeInD/vagecmkGPCAM7YtUkJ/bwUPA91670hEoxiYd8bGDJf+jG568UbCi8QF6CAAX+SoONnsMW3eJfTOQBqYQqnXPN0SUWcECS2TJyMmggcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWRcRKmudbqI0qax2S4mo8MMj1VvT9eC/WKABK8rIuU=;
 b=ESPEU+zYGvwHjCgfCnaz5oTs7SEDR14Funhzm05uM4QXgseAHKx2SUWW4pzAPOVeljFdwmjWG1zkcgmp5W0qqJuXc5cZPZYTM3xSjzkSQXKjoVhOiHuITo2iWhUtwPXSXb/yjcVAqXK2zL0WuiZWn4Y6OerNnyGhIc9Yksj0XFo=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7069.eurprd04.prod.outlook.com (2603:10a6:800:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 03:48:18 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Fri, 20 Oct 2023
 03:48:18 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB9638C940D962456E3CFC9977D1DBAPA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH v6 3/6] wifi: mwifiex: fixed reassocation issue for WPA3.
Thread-Topic: [PATCH v6 3/6] wifi: mwifiex: fixed reassocation issue for WPA3.
Thread-Index: AdoDCEJxeqzS6xZwTgO7r0FJr3DzXg==
Date:   Fri, 20 Oct 2023 03:48:18 +0000
Message-ID: <PA4PR04MB9638C940D962456E3CFC9977D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB9638C940D962456E3CFC9977D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7069:EE_
x-ms-office365-filtering-correlation-id: 0a19f5d0-4237-47d3-19cd-08dbd11f65f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqiAaTNomxCmNJtmUoFX/m5xYIWNs1jN1uWtFEtStHsH6gsFsfgt4jPfy1RgTWCpLdloO44tZ40c8aj28Nfn8aUMFkDSWwgWdOVu6nuOoFCSmFLwNP/1/dHlqFNw0C63GbxVmdqon7ncTcyOan4/OsShB4hm0QQgeEMwkBQtr2zGAEdYoc7uPjScvHx00jOJ2/iJMliNLHO+ew8kR0SHrfV/QIyO+VIZrX54uQEA6qlCxu0VXbrbIVVNLj5onYBYt+zHwOAh/qvx2vy+5b6N5X6k5cOJWP0fFkfOrArzoTdWugoDVMl9+vm7Yi+R8jRi6K5Y5IZFffJUnhEJDaN/4YtACFWXTzqorGO/xwW2XjVlmjzwed9p/xu27gsRRKKSC2EoK1mHOT1SziuKmjTIY2kwcFSntusu6c5/UuxblUpvi/BXUd8xv0WBSJMh5Azqmk7hVd1J7ZBCFPGAB29QaOSybAlGdfTvOLLI0GCXeeu0LQckgh2NZUhes6BnHL4N5PX/POAQvbTPAXp9pVzLyJVOkfELa3MMpNbgoFTLGjdXeu6AScyBpkkEAxefpssIhItMTCtxjsQV31Px8MAoNm1Ujpt+Qu4Bg6OAQfQhGc8grg5WTTxVOuAYjYlH4Csq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(38100700002)(41300700001)(4326008)(5660300002)(8676002)(8936002)(52536014)(86362001)(33656002)(2906002)(122000001)(478600001)(83380400001)(9686003)(7696005)(26005)(71200400001)(6506007)(316002)(38070700009)(66946007)(76116006)(54906003)(66476007)(6916009)(66446008)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TNAOIhXvU0xmZTH030DM/P32GTPIhQNHLoBFiOlinidjzbt4ixfKmELlwzg?=
 =?us-ascii?Q?4vhgyj67Jt4MP1J6ejVjxFBLcoSkpuKx6ZWr83Ku1s4hxdm9tIukBIy/14/C?=
 =?us-ascii?Q?hmDjBGOd6NhnkQAMwpYXk/gn0xpEKD0UF2QQMqZfpxGsGqghGKldIinOZrGO?=
 =?us-ascii?Q?0BME7SwA01X2dltvsN7pA7vq2tSeiCoVnXAkLp3YUMkGCdd0FQ2QD4bTZ3Jw?=
 =?us-ascii?Q?LPsMy60JKUZs7y6smyukRI5RWsgDs2RzBHV28FOZOU8DUXgmH/O3htCdFchd?=
 =?us-ascii?Q?3GW5A7DVTpprs9v+0aZD3VofLabYB6dNaA24l9+T9jd24OiuUhP8hotdwXlF?=
 =?us-ascii?Q?kBcbHFdvYysC4h+srs/nhpd6hFD7YQadyLdimnnaTpHOQgUZ7E9vuLDl13aT?=
 =?us-ascii?Q?n4sTvPHHJAZNAkahWoN8RP2fAutZFrRsCDeOxxN2DNWKay0tAWWyEwNhUCxo?=
 =?us-ascii?Q?gRQi8scjxkcOKh0DIexUj91ZF6zv5aArYRot6ZBJnrps9/GUzZ500UkLB5DG?=
 =?us-ascii?Q?dY0GeYH7clKhENR/0xIdIeLqXh6FnyQtrTVU215v4X8pq4NQb9QbBlOVbWD5?=
 =?us-ascii?Q?kGeGqoloXx20x+RsYOpmnLblzh0mCIW5PtJHD0Bw2OYtfg68H/yRplHYwGPV?=
 =?us-ascii?Q?frO9ArXYQk8oGT/ryeroFT/VRBNKwob+3fHF4YzKHp61eO9JF4drLM7dbHS2?=
 =?us-ascii?Q?Px+9Qx3Hd0BQh88umx1yEFEYuHrJazv2AFEu4J7Z8f6w/EWQfzBzc5sYDnNr?=
 =?us-ascii?Q?U17b+ohHMAfIH88Um6oGwOmJDEhj5G1Fv3Zo2TEGvD4XblBBFm9e+dbS2kwa?=
 =?us-ascii?Q?Cvj3d+JYr/hhhOZx9AM6jWc2alMOHmfsPDtkWIra7yHGNhJYAQXYi8prOXXP?=
 =?us-ascii?Q?Vhi/gG7Q3waKM4GUXlnmDU+0DBvoMBwbnmr1b94CrhdvGuApHPGK8sjrqQUp?=
 =?us-ascii?Q?ERmvPsVHI7pkxsrPEV8mavb/1z8y6R0hLv1cmgdZQFN/14e9pEFDepu0XVXb?=
 =?us-ascii?Q?zmxmiA4Ihjjnks73UDKFQeGpDcVaJAcNth09tKIWtmh0QqTGIvjMIOV7PvF/?=
 =?us-ascii?Q?z9KDWoEF3tlEBo8/ZRR4dYhng9xeaMt9+miPAMC0VBvGUz8yNUa9/JOBB3E/?=
 =?us-ascii?Q?GJb+d79WJOCAhNz8OHZieZra6ZxYy3h3409ChxE2FDTpM1M4ZN4Dc3Gw1OtX?=
 =?us-ascii?Q?8VQ7/JIBo7npAeEXnY52cL/vNloM4OtRlkPMoLkmLkoJkKL744REIj6HDdqJ?=
 =?us-ascii?Q?Fl5IOtLwwBt8uY0CGEvEA9uaZtGPXruKja9XYvTEKKYK+GS6JI1U1Rk0J7KF?=
 =?us-ascii?Q?R3WUoLOmpU/56Uz4p5qohloy/sWJylNFF+8fx9f260diOiME/3rAtHtv7qzl?=
 =?us-ascii?Q?qxefWgxx/b73DGf4i+FoDpvqK3G49P5rp66CUZNfa2ohEJpy3HdgSGUj52yF?=
 =?us-ascii?Q?Bc3U6FDJr/K50pS+aN4k+sCzmiraPaH9pZIvkq7Oqx/43FuQ4dBwq/bHi2XH?=
 =?us-ascii?Q?tVqjYDcO+c2Yu558ILuhYtLgAhrGEI0itN+YFZM9VgLpt7tK7yXkFHDdLOGi?=
 =?us-ascii?Q?EGmWmXzAYJEtjnZtNSFxRKdoW8LzMGN0lBNZeAmt?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a19f5d0-4237-47d3-19cd-08dbd11f65f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:48:18.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Gd5ZLNpi4Dhy6bBJY+ZdwpfGbC8abUoWG9L9pWCdWqFgcpI0f+buUQYyli0NLPuWpViKbU5hoGTgh6XVSOf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_000_PA4PR04MB9638C940D962456E3CFC9977D1DBAPA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This issue is related to resatart/reconfigure AP.

When AP is restarted or reconfigured, wpa_supplilcant will use cached
PMKSA to do association to AP.
Because association failure does not report to cfg80211/wpa_supplicant,
wpa_supplicant will always use cached PMKSA to do assocaiton.
Connection can't be established under this way.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 25 ++++++++-----------
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 18 +++++++++++++
 drivers/net/wireless/marvell/mwifiex/init.c   |  1 +
 drivers/net/wireless/marvell/mwifiex/main.c   |  6 +++++
 drivers/net/wireless/marvell/mwifiex/main.h   |  3 +++
 5 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index 3d59e6a441b9..a21310f3807c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4395,9 +4395,6 @@ mwifiex_cfg80211_associate(struct wiphy *wiphy, struc=
t net_device *dev,
 	int ret;
 	struct cfg80211_ssid req_ssid;
 	const u8 *ssid_ie;
-	struct cfg80211_rx_assoc_resp assoc_resp =3D {
-		.uapsd_queues =3D -1,
-	};
=20
 	if (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_STA) {
 		mwifiex_dbg(adapter, ERROR,
@@ -4433,13 +4430,13 @@ mwifiex_cfg80211_associate(struct wiphy *wiphy, str=
uct net_device *dev,
=20
 	req_ssid.ssid_len =3D ssid_ie[1];
 	if (req_ssid.ssid_len > IEEE80211_MAX_SSID_LEN) {
-		mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
+		mwifiex_dbg(adapter, ERROR, "invalid SSID - aborting\n");
 		goto ssid_err;
 	}
=20
 	memcpy(req_ssid.ssid, ssid_ie + 2, req_ssid.ssid_len);
 	if (!req_ssid.ssid_len || req_ssid.ssid[0] < 0x20) {
-		mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
+		mwifiex_dbg(adapter, ERROR, "invalid SSID - aborting\n");
 		goto ssid_err;
 	}
 	rcu_read_unlock();
@@ -4466,25 +4463,25 @@ mwifiex_cfg80211_associate(struct wiphy *wiphy, str=
uct net_device *dev,
=20
 	memcpy(priv->cfg_bssid, req->bss->bssid, ETH_ALEN);
=20
-	mwifiex_dbg(priv->adapter, MSG,
+	mwifiex_dbg(adapter, MSG,
 		    "assoc: send association to %pM\n", req->bss->bssid);
=20
-	cfg80211_ref_bss(priv->adapter->wiphy, req->bss);
+	cfg80211_ref_bss(adapter->wiphy, req->bss);
=20
 	ret =3D mwifiex_bss_start(priv, req->bss, &req_ssid);
=20
-	if (!ret) {
-		assoc_resp.links[0].bss =3D priv->attempted_bss_desc->bss;
-		assoc_resp.buf =3D priv->assoc_rsp_buf;
-		assoc_resp.len =3D priv->assoc_rsp_size;
-		cfg80211_rx_assoc_resp(priv->netdev,
-				       &assoc_resp);
-	} else {
+	if (ret) {
 		priv->auth_flag =3D 0;
 		priv->auth_alg =3D 0xFFFF;
 		eth_zero_addr(priv->cfg_bssid);
 	}
=20
+	if (priv->assoc_rsp_size) {
+		priv->req_bss =3D req->bss;
+		adapter->assoc_resp_received =3D true;
+		queue_work(adapter->workqueue, &adapter->main_work);
+	}
+
 	cfg80211_put_bss(priv->adapter->wiphy, req->bss);
=20
 	return 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wi=
reless/marvell/mwifiex/cmdevt.c
index 311af5f40c3e..16777af50097 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -924,6 +924,24 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *ad=
apter)
 	return ret;
 }
=20
+void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter)
+{
+	struct cfg80211_rx_assoc_resp assoc_resp =3D {
+		.uapsd_queues =3D -1,
+	};
+	struct mwifiex_private *priv =3D
+		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);
+
+	if (priv->assoc_rsp_size) {
+		assoc_resp.links[0].bss =3D priv->req_bss;
+		assoc_resp.buf =3D priv->assoc_rsp_buf;
+		assoc_resp.len =3D priv->assoc_rsp_size;
+		cfg80211_rx_assoc_resp(priv->netdev,
+				       &assoc_resp);
+		priv->assoc_rsp_size =3D 0;
+	}
+}
+
 /*
  * This function handles the timeout of command sending.
  *
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wire=
less/marvell/mwifiex/init.c
index f86a527fd7ca..4326e03a66d3 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -223,6 +223,7 @@ static void mwifiex_init_adapter(struct mwifiex_adapter=
 *adapter)
 	adapter->cmd_resp_received =3D false;
 	adapter->event_received =3D false;
 	adapter->data_received =3D false;
+	adapter->assoc_resp_received =3D false;
=20
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wire=
less/marvell/mwifiex/main.c
index 3bebb6c37604..1dac77946813 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -365,6 +365,12 @@ int mwifiex_main_process(struct mwifiex_adapter *adapt=
er)
 			}
 		}
=20
+		/* Chekc for Assoc Resp */
+		if (adapter->assoc_resp_received) {
+			adapter->assoc_resp_received =3D false;
+			mwifiex_process_assoc_resp(adapter);
+		}
+
 		/* Check if we need to confirm Sleep Request
 		   received previously */
 		if (adapter->ps_state =3D=3D PS_STATE_PRE_SLEEP)
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wire=
less/marvell/mwifiex/main.h
index 83449ad84d15..ae4b44ad6c50 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -615,6 +615,7 @@ struct mwifiex_private {
 #define MWIFIEX_ASSOC_RSP_BUF_SIZE  500
 	u8 assoc_rsp_buf[MWIFIEX_ASSOC_RSP_BUF_SIZE];
 	u32 assoc_rsp_size;
+	struct cfg80211_bss *req_bss;
=20
 #define MWIFIEX_GENIE_BUF_SIZE      256
 	u8 gen_ie_buf[MWIFIEX_GENIE_BUF_SIZE];
@@ -915,6 +916,7 @@ struct mwifiex_adapter {
 	u8 cmd_resp_received;
 	u8 event_received;
 	u8 data_received;
+	u8 assoc_resp_received;
 	u16 seq_num;
 	struct cmd_ctrl_node *cmd_pool;
 	struct cmd_ctrl_node *curr_cmd;
@@ -1104,6 +1106,7 @@ void mwifiex_insert_cmd_to_pending_q(struct mwifiex_a=
dapter *adapter,
=20
 int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter);
 int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter);
+void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter);
 int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
 			     struct sk_buff *skb);
 int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
--=20
2.25.1


--_000_PA4PR04MB9638C940D962456E3CFC9977D1DBAPA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IlQxAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAADQzM0JDOTAz
Q0FFNTdCNENBMjYzQURCODQ5RDZFNzRCAF0HAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCgAUAAMA
MAASAAUAVgEBIIADAA4AAADnBwoAFAADADAAEgAFAFYBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAEEAAABbUEFUQ0ggdjYgMy82XSB3aWZpOiBtd2lmaWV4OiBmaXhlZCBy
ZWFzc29jYXRpb24gaXNzdWUgZm9yIFdQQTMuAHwVAQuAAQAhAAAANDMzQkM5MDNDQUU1N0I0Q0Ey
NjNBREI4NDlENkU3NEIAXQcBA5AGACQ5AABaAAAAAgF/AAEAAABRAAAAPFBBNFBSMDRNQjk2MzhD
OTQwRDk2MjQ1NkUzQ0ZDOTk3N0QxREJBQFBBNFBSMDRNQjk2MzguZXVycHJkMDQucHJvZC5vdXRs
b29rLmNvbT4AAAAACwAfDgAAAAACAQkQAQAAAAkLAAAFCwAAox8AAExaRnXxujRpYQAKZmJpZAQA
AGNjwHBnMTI1MgD+A0PwdGV4dAH3AqQD4wIABGNoCsBzZXQwIO8HbQKDAFARTTIKgAa0AoCWfQqA
CMg7CWIxOQ7AvwnDFnIKMhZxAoAVYioJsHMJ8ASQYXQFsg5QA2Bzom8BgCBFeBHBbhgwXQZSdgSQ
F7YCEHIAwHR9CFBuGjEQIAXABaAbZGSaIANSIBAiF7JcdgiQ5HdrC4BkNR1TBPAHQA0XcDAKcRfy
YmttawZzAZAAICBCTV9C4EVHSU59CvwB8Qvw6jISQGgEACAEAQpQIeG+IAlwC2AcQhiQInFzGICN
H4EvCXAb4WZpZwhwQRngQVAuXGwLgGXzCoEkxFdoCfAkcSJEH2OHHFEFsSPJZCwgdwqw+l8iEHAL
UAMQHlACMCfg+wMQAyB1EgAb0ADQJaALMEEkxFBNS1NBIvJkJSMQYQQQb2MHMHRp1wIgIvIkiEIF
kGEpQisaPmYLcApAJFEq4AeRbm8bBUAJcHAJESLyY2ZnwDgwMjExLyf4KKIeLCS1MCwo5AdAd2F5
uwQgKUggKl8LcBiQbiSmWxtBGFBjK4MooScFQGLfGeAmUgJgBAAzonUdwBuxbnQhsjLhJK1TJCAY
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
AG4AeABwAC4AYwBvAG0AAAAAAB8AHgwBAAAACgAAAFMATQBUAFAAAAAAAAIBGQwBAAAAXAAAAAAA
AACBKx+kvqMQGZ1uAN0BD1QCAAAAgEQAYQB2AGkAZAAgAEwAaQBuAAAAUwBNAFQAUAAAAHkAdQAt
AGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAHwABXQEAAAAmAAAAeQB1AC0AaABhAG8A
LgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAAAAsAQDoBAAAAHwAaAAEAAAASAAAASQBQAE0ALgBO
AG8AdABlAAAAAAADAPE/BAQAAAsAQDoBAAAAAwD9P+QEAAACAQswAQAAABAAAABDO8kDyuV7TKJj
rbhJ1udLAwAXAAEAAABAADkAAO0GQwgD2gFAAAgwtsN0QwgD2gELACkAAAAAAB8A2T8BAAAAAAIA
AFQAaABpAHMAIABpAHMAcwB1AGUAIABpAHMAIAByAGUAbABhAHQAZQBkACAAdABvACAAcgBlAHMA
YQB0AGEAcgB0AC8AcgBlAGMAbwBuAGYAaQBnAHUAcgBlACAAQQBQAC4ADQAKAA0ACgBXAGgAZQBu
ACAAQQBQACAAaQBzACAAcgBlAHMAdABhAHIAdABlAGQAIABvAHIAIAByAGUAYwBvAG4AZgBpAGcA
dQByAGUAZAAsACAAdwBwAGEAXwBzAHUAcABwAGwAaQBsAGMAYQBuAHQAIAB3AGkAbABsACAAdQBz
AGUAIABjAGEAYwBoAGUAZAANAAoAUABNAEsAUwBBACAAdABvACAAZABvACAAYQBzAHMAbwBjAGkA
YQB0AGkAbwBuACAAdABvACAAQQBQAC4ADQAKAEIAZQBjAGEAdQBzAGUAIABhAHMAcwBvAGMAaQBh
AHQAaQBvAG4AIABmAGEAaQBsAHUAcgBlACAAZABvAGUAcwAgAG4AbwB0ACAAcgBlAHAAbwByAHQA
IAB0AG8AIABjAGYAZwA4ADAAMgAxADEALwB3AHAAYQBfAHMAdQBwAHAAbABpAGMAYQBuAHQALAAN
AAoAdwBwAGEAXwBzAHUAcABwAGwAaQBjAGEAbgB0ACAAdwBpAGwAbAAgAGEAbAB3AGEAeQBzAAAA
CwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAFIUAAAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAAe
AAAAYQBjAGMAZQBwAHQAbABhAG4AZwB1AGEAZwBlAAAAAAABAAAAGgAAAHoAaAAtAFQAVwAsACAA
ZQBuAC0AVQBTAAAAAAADAACACCAGAAAAAADAAAAAAAAARgEAAAAyAAAARQB4AGMAaABhAG4AZwBl
AEEAcABwAGwAaQBjAGEAdABpAG8AbgBGAGwAYQBnAHMAAAAAACAAAABIAACACCAGAAAAAADAAAAA
AAAARgEAAAAiAAAATgBlAHQAdwBvAHIAawBNAGUAcwBzAGEAZwBlAEkAZAAAAAAA0PUZCjdC00cZ
zQjb0R9l8R8AAIATj/JB9IMUQaWE7ttaawv/AQAAABYAAABDAGwAaQBlAG4AdABJAG4AZgBvAAAA
AAABAAAAKgAAAEMAbABpAGUAbgB0AD0ATQBTAEUAeABjAGgAYQBuAGcAZQBSAFAAQwAAAAAAHwD6
PwEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfADcAAQAAAIIAAABbAFAAQQBUAEMASAAgAHYA
NgAgADMALwA2AF0AIAB3AGkAZgBpADoAIABtAHcAaQBmAGkAZQB4ADoAIABmAGkAeABlAGQAIABy
AGUAYQBzAHMAbwBjAGEAdABpAG8AbgAgAGkAcwBzAHUAZQAgAGYAbwByACAAVwBQAEEAMwAuAAAA
AAAfAD0AAQAAAAIAAAAAAAAAAwA2AAAAAAACAXEAAQAAABYAAAAB2gMIQnF6rNLrFnBOA7uvQUmv
cPNeAAAfAHAAAQAAAIIAAABbAFAAQQBUAEMASAAgAHYANgAgADMALwA2AF0AIAB3AGkAZgBpADoA
IABtAHcAaQBmAGkAZQB4ADoAIABmAGkAeABlAGQAIAByAGUAYQBzAHMAbwBjAGEAdABpAG8AbgAg
AGkAcwBzAHUAZQAgAGYAbwByACAAVwBQAEEAMwAuAAAAAAAfADUQAQAAAKIAAAA8AFAAQQA0AFAA
UgAwADQATQBCADkANgAzADgAQwA5ADQAMABEADkANgAyADQANQA2AEUAMwBDAEYAQwA5ADkANwA3
AEQAMQBEAEIAQQBAAFAAQQA0AFAAUgAwADQATQBCADkANgAzADgALgBlAHUAcgBwAHIAZAAwADQA
LgBwAHIAbwBkAC4AbwB1AHQAbABvAG8AawAuAGMAbwBtAD4AAAAAAAMA3j+fTgAAAwATEgAAAAAC
AQCAE4/yQfSDFEGlhO7bWmsL/wEAAAAuAAAASABlAGEAZABlAHIAQgBvAGQAeQBGAHIAYQBnAG0A
ZQBuAHQATABpAHMAdAAAAAAAAQAAACIAAAABAAoAAAAEAAAAAAAAABQAAAAAAAAAAAAAAP////8A
AAAAAAALAACAE4/yQfSDFEGlhO7bWmsL/wEAAAAcAAAASABhAHMAUQB1AG8AdABlAGQAVABlAHgA
dAAAAAAAAAALAACAE4/yQfSDFEGlhO7bWmsL/wEAAAAoAAAASQBzAFEAdQBvAHQAZQBkAFQAZQB4
AHQAQwBoAGEAbgBnAGUAZAAAAAAAAABAAAcw7kZKQwgD2gECAQsAAQAAABAAAABDO8kDyuV7TKJj
rbhJ1udLAwAmAAAAAAALAAYMAAAAAAIBEDABAAAARgAAAAAAAADIpSWxiCOSSoOqZJAKpKsqBwBP
PiDQ/CbdRK5hB1o6Ct0nAAAAAAELAABPPiDQ/CbdRK5hB1o6Ct0nAAIhGpUUAAAAAAIBEzABAAAA
EAAAAHqs0usWcE4Du69BSa9w814CARQwAQAAAAwAAACvAQAAFKN8TFQAAAADAFszAQAAAAMAWjYA
AAAAAwBoNg0AAAALAPo2AQAAAB8A+D8BAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwAiQAEA
AAAGAAAARQBYAAAAAAAfACNAAQAAAPwAAAAvAE8APQBFAFgAQwBIAEEATgBHAEUATABBAEIAUwAv
AE8AVQA9AEUAWABDAEgAQQBOAEcARQAgAEEARABNAEkATgBJAFMAVABSAEEAVABJAFYARQAgAEcA
UgBPAFUAUAAgACgARgBZAEQASQBCAE8ASABGADIAMwBTAFAARABMAFQAKQAvAEMATgA9AFIARQBD
AEkAUABJAEUATgBUAFMALwBDAE4APQBDAEIAMAA0AEYANgA1ADkAMQBBAEQANgA0ADQANgBCADgA
QQBBAEIAQwA5AEIANgA1AEQAQQBFADkAMgAwADcALQBOAFgARgA1ADcANgAyADQAAAAfACRAAQAA
AAYAAABFAFgAAAAAAB8AJUABAAAA/AAAAC8ATwA9AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8A
TwBVAD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0ASQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBS
AE8AVQBQACAAKABGAFkARABJAEIATwBIAEYAMgAzAFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMA
SQBQAEkARQBOAFQAUwAvAEMATgA9AEMAQgAwADQARgA2ADUAOQAxAEEARAA2ADQANAA2AEIAOABB
AEEAQgBDADkAQgA2ADUARABBAEUAOQAyADAANwAtAE4AWABGADUANwA2ADIANAAAAB8AMEABAAAA
FAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwAxQAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAf
ADhAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AOUABAAAAFAAAAEQAYQB2AGkAZAAgAEwA
aQBuAAAAAwBZQAAAAAADAFpAAAAAAAMAN1ABAAAAAwAJWQEAAAAfAApdAQAAACYAAAB5AHUALQBo
AGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwALXQEAAAAmAAAAeQB1AC0AaABhAG8A
LgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAAAAIBFV0BAAAAEgAAAALToW5oK7xvTKks2ZxcMBY1
AQAAAgEWXQEAAAASAAAAAtOhbmgrvG9MqSzZnFwwFjUBAAADAACAUONjC8yc0BG82wCAX8zOBAEA
AAAkAAAASQBuAGQAZQB4AGkAbgBnAEUAcgByAG8AcgBDAG8AZABlAAAAGwAAAB8AAIBQ42MLzJzQ
EbzbAIBfzM4EAQAAACoAAABJAG4AZABlAHgAaQBuAGcARQByAHIAbwByAE0AZQBzAHMAYQBnAGUA
AAAAAAEAAABwAAAASQBuAGQAZQB4AGkAbgBnACAAUABlAG4AZABpAG4AZwAgAHcAaABpAGwAZQAg
AEIAaQBnAEYAdQBuAG4AZQBsAFAATwBJAEkAcwBVAHAAVABvAEQAYQB0AGUAIABpAHMAIABmAGEA
bABzAGUALgAAAAsAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACYAAABJAHMAUABlAHIAbQBhAG4AZQBu
AHQARgBhAGkAbAB1AHIAZQAAAAAAAAAAAB8AAIAfpOszqHouQr57eeGpjlSzAQAAADgAAABDAG8A
bgB2AGUAcgBzAGEAdABpAG8AbgBJAG4AZABlAHgAVAByAGEAYwBrAGkAbgBnAEUAeAAAAAEAAABE
AQAASQBJAD0AWwBDAEkARAA9AGUAYgBkADIAYQBjADcAYQAtADcAMAAxADYALQAwADMANABlAC0A
YgBiAGEAZgAtADQAMQA0ADkAYQBmADcAMABmADMANQBlADsASQBEAFgASABFAEEARAA9AEQAQQAw
ADMAMAA4ADQAMgA3ADEAOwBJAEQAWABDAE8AVQBOAFQAPQAxAF0AOwBUAEYAUgA9AFQAaAByAGUA
YQBkAEYAbwByAGsAaQBuAGcASQBzAEQAaQBzAGEAYgBsAGUAZAA7AFYAZQByAHMAaQBvAG4APQBW
AGUAcgBzAGkAbwBuACAAMQA1AC4AMgAwACAAKABCAHUAaQBsAGQAIAA2ADkAMwAzAC4AMAApACwA
IABTAHQAYQBnAGUAPQBIADQAOwBVAFAAPQAxADAAOwBEAFAAPQAxAAAAQAAAgAggBgAAAAAAwAAA
AAAAAEYAAAAAv4UAADDmdEIIA9oBCwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAgoUAAAAAAAACAQCA
CCAGAAAAAADAAAAAAAAARgEAAAA2AAAASQBuAFQAcgBhAG4AcwBpAHQATQBlAHMAcwBhAGcAZQBD
AG8AcgByAGUAbABhAHQAbwByAAAAAAABAAAAEAAAAN+nXxnGvT5FjiaCrnznEmcDAA00/T8AAB8A
AICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAABhAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4ALQBy
AGUAcwB1AGwAdABzAAAAAAABAAAAsgAAAGQAawBpAG0APQBuAG8AbgBlACAAKABtAGUAcwBzAGEA
ZwBlACAAbgBvAHQAIABzAGkAZwBuAGUAZAApACAAaABlAGEAZABlAHIALgBkAD0AbgBvAG4AZQA7
AGQAbQBhAHIAYwA9AG4AbwBuAGUAIABhAGMAdABpAG8AbgA9AG4AbwBuAGUAIABoAGUAYQBkAGUA
cgAuAGYAcgBvAG0APQBuAHgAcAAuAGMAbwBtADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAA
ACAAAAB4AC0AbQBzAC0AaABhAHMALQBhAHQAdABhAGMAaAAAAAEAAAACAAAAAAAAAB8AAICGAwIA
AAAAAMAAAAAAAABGAQAAAC4AAAB4AC0AbQBzAC0AcAB1AGIAbABpAGMAdAByAGEAZgBmAGkAYwB0
AHkAcABlAAAAAAABAAAADAAAAEUAbQBhAGkAbAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAADYA
AAB4AC0AbQBzAC0AdAByAGEAZgBmAGkAYwB0AHkAcABlAGQAaQBhAGcAbgBvAHMAdABpAGMAAAAA
AAEAAABIAAAAUABBADQAUABSADAANABNAEIAOQA2ADMAOAA6AEUARQBfAHwAVgBJADEAUABSADAA
NABNAEIANwAwADYAOQA6AEUARQBfAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAUAAAAHgALQBt
AHMALQBvAGYAZgBpAGMAZQAzADYANQAtAGYAaQBsAHQAZQByAGkAbgBnAC0AYwBvAHIAcgBlAGwA
YQB0AGkAbwBuAC0AaQBkAAAAAQAAAEoAAAAwAGEAMQA5AGYANQBkADAALQA0ADIAMwA3AC0ANAA3
AGQAMwAtADEAOQBjAGQALQAwADgAZABiAGQAMQAxAGYANgA1AGYAMQAAAAAAHwAAgIYDAgAAAAAA
wAAAAAAAAEYBAAAAOAAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBzAGUAbgBkAGUAcgBh
AGQAYwBoAGUAYwBrAAAAAQAAAAQAAAAxAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOgAAAHgA
LQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABpAHMAcABhAG0ALQByAGUAbABhAHkAAAAA
AAEAAAAEAAAAMAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACoAAAB4AC0AbQBpAGMAcgBvAHMA
bwBmAHQALQBhAG4AdABpAHMAcABhAG0AAAAAAAEAAAAOAAAAQgBDAEwAOgAwADsAAAAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAAEQAAAB4AC0AbQBpAGMAcgBvAHMAbwBmAHQALQBhAG4AdABpAHMA
cABhAG0ALQBtAGUAcwBzAGEAZwBlAC0AaQBuAGYAbwAAAAEAAAACBQAATABxAGkAQQBhAFQATgBv
AG0AeABDAG0ATgBKAHQAbQBVAG8ARgBYAC8AbQA1AHgAWQBJAFcATgBzADEAagBOADEAdQBXAHQA
RgBFAHQAUwB0AEgAcwBIADYAZwBzAEYAcwBmAGcAdAA0AGoAUABmAHkAMQBSAGcAVABXAEMAcABM
AGQAbABvAE8ANAA0AHQAWgA0ADAAYwA4AGEAagAyADgATgBmAG4AOABhAFUATQBGAGsARABTAFcA
dwBnAFcAZABPAFYAdQA2AG4AdQBPAG8ARgBDAFMAbQBGAEwAdwBOAFAALwAxAC8AZABIAGwAcQBG
AE4AdwAwAEMANgAzAEcAYgB4AFYAbQBkAHEAbwBuADcAbgBjAFQAYwB5AE8AYQBuADQALwBPAHMA
UwBoAEIANABoAG0AMABRAFEAZwBlAEUATQB3AGsAQgBRAHQAcgAyAHoARwBBAEUAZABZAG8AYwA3
AHUAUABqAFMAYwB2AEgAeAAwADAAagBPAEoAMgAvAGkASgBNAGwAaQBOAEwASABPACsAZQB3ADgA
awBSADAAUwBIAHIAZgBWAC8AUQBJAHkATwArAFYASQBaAHIAWAA1ADQAdQBRAEUAQQA2AHEAbABD
AHgAdQAwAFYAWABiAHIAYgBJAFYAVgBOAEwAagA1AG8AbgBZAEIAWQB0ACsAegBIAHcATwBBAGgA
LwBxAHYAeAAyAHYAeQArADUAYgA2AE4ANQBYADYAawA1AGMATwBKAFcAUAAwAGYARgBrAGYATwBy
AEEAcgB6AG8AVABkAFcAdQBnAG8ARABWAE0AbAA5ACsAdgBtADcAWQBpACsAUgA4AGoAUgBpADYA
SwA1AFkANQBJAFoARgBmAGYASgBVAG4AaABFAEoARABhAE4ALwA0AFkAdABBAEMARgBXAFgAVAB6
AHEAbwByAEcATwAvAHgAdwBXADIAWABqAFYAbABtAGoAegB3AGUAZAA5AHAALwB4AHUAMgA3AGcA
cwBSAFIASwBLAFMAQwAyAEUAbwBLADEAbQBIAE8AVAAxAFMAegBpAHUASwBtAGoAVABJAFkAMgBr
AHcAYwBGAFMAbgB0AHUAcwB1ADYAYwA1AC8AVQB1AHgAYgBsAFUAcAB2AGkALwBCAFgAVQBkADgA
eAB2ADAAVwBCAFMASgBNAGgANQBBAHoAcQBtAGsANwBoAFYAZAAxAEoANwBaAEIAQwBGAFAARwBB
AEIAMgA5AFEAYQBPAFMAeQBiAEEAbABHAGQAZgBUAHYATwBMAEwASQAwAEcAQwBYAGUAZQB1ADAA
TABRAGMAawBnAGgAMgBOAFoAVQBoAGUAcwA2AEIAbgBIAEwANABOADUAUABYAC8AUABPAEEAUQB2
AGIAVABQAEEAWABwADkAcABWAHoATAB5AEoAVgBPAGsAZgBFAEwAYQAzAE0ATQBwAE4AYgBnAG8A
RgBUAEwARwBqAGQAWABlAHUANgBBAFMAYwB5AEIAcABrAGsARQBBAHgAZQBmAHAAcwBzAEkAaABJ
AHQATQBUAEMAdAB4AGoAcwBRAFYAMwAxAFAAeAA4AE0AQQBvAE4AbQAxAFUAagBwAHQAKwBRAHUA
NABCAGcANgBPAEEAUQBmAFEAaABHAGMAOABnAHIAZwA1AFcAVABUAHgAVgBPAHUAQQBZAGoAWQBs
AEgANABDAHMAcQAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBmAG8AcgBlAGYA
cgBvAG4AdAAtAGEAbgB0AGkAcwBwAGEAbQAtAHIAZQBwAG8AcgB0AAAAAQAAAGIEAABDAEkAUAA6
ADIANQA1AC4AMgA1ADUALgAyADUANQAuADIANQA1ADsAQwBUAFIAWQA6ADsATABBAE4ARwA6AGUA
bgA7AFMAQwBMADoAMQA7AFMAUgBWADoAOwBJAFAAVgA6AE4ATABJADsAUwBGAFYAOgBOAFMAUABN
ADsASAA6AFAAQQA0AFAAUgAwADQATQBCADkANgAzADgALgBlAHUAcgBwAHIAZAAwADQALgBwAHIA
bwBkAC4AbwB1AHQAbABvAG8AawAuAGMAbwBtADsAUABUAFIAOgA7AEMAQQBUADoATgBPAE4ARQA7
AFMARgBTADoAKAAxADMAMgAzADAAMAAzADEAKQAoADMANgA2ADAAMAA0ACkAKAAzADkANgAwADAA
MwApACgAMQAzADYAMAAwADMAKQAoADMANwA2ADAAMAAyACkAKAAzADkAOAA2ADAANAAwADAAMAAw
ADIAKQAoADMANAA2ADAAMAAyACkAKAAyADMAMAA5ADIAMgAwADUAMQA3ADkAOQAwADAAMwApACgA
MQA4ADYAMAAwADkAKQAoADEAOAAwADAANwA5ADkAMAAwADkAKQAoADYANAAxADAAMAA3ADkAOQAw
ADAAMwApACgANAA1ADEAMQA5ADkAMAAyADQAKQAoADUANQAwADEANgAwADAAMwApACgAMwA4ADEA
MAAwADcAMAAwADAAMAAyACkAKAA0ADEAMwAwADAANwAwADAAMAAwADEAKQAoADQAMwAyADYAMAAw
ADgAKQAoADUANgA2ADAAMwAwADAAMAAwADIAKQAoADgANgA3ADYAMAAwADIAKQAoADgAOQAzADYA
MAAwADIAKQAoADUAMgA1ADMANgAwADEANAApACgAOAA2ADMANgAyADAAMAAxACkAKAAzADMANgA1
ADYAMAAwADIAKQAoADIAOQAwADYAMAAwADIAKQAoADEAMgAyADAAMAAwADAAMAAxACkAKAA0ADcA
OAA2ADAAMAAwADAAMQApACgAOAAzADMAOAAwADQAMAAwADAAMAAxACkAKAA5ADYAOAA2ADAAMAAz
ACkAKAA3ADYAOQA2ADAAMAA1ACkAKAAyADYAMAAwADUAKQAoADcAMQAyADAAMAA0ADAAMAAwADAA
MQApACgANgA1ADAANgAwADAANwApACgAMwAxADYAMAAwADIAKQAoADMAOAAwADcAMAA3ADAAMAAw
ADAAOQApACgANgA2ADkANAA2ADAAMAA3ACkAKAA3ADYAMQAxADYAMAAwADYAKQAoADUANAA5ADAA
NgAwADAAMwApACgANgA2ADQANwA2ADAAMAA3ACkAKAA2ADkAMQA2ADAAMAA5ACkAKAA2ADYANAA0
ADYAMAAwADgAKQAoADYANAA3ADUANgAwADAAOAApACgANgA2ADUANQA2ADAAMAA4ACkAOwBEAEkA
UgA6AE8AVQBUADsAUwBGAFAAOgAxADEAMAAxADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAA
AFwAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMA
cwBhAGcAZQBkAGEAdABhAC0AYwBoAHUAbgBrAGMAbwB1AG4AdAAAAAEAAAAEAAAAMQAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAAEoAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQA
aQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABhAC0AMAAAAAAAAQAAAIIMAAA0AFQATgBB
AE8ASQBoAFgAdgBVADAAeABtAFoAVABIADAAMwAwAEQATQAvAFAAMwAyAEcAVABQAEkAaABRAE4A
SABMAG8AQgBGAGkATwBsAGkAbgBpAGQAagB6AGIAdAA0AGkAeABmAEsAbQBFAEwAbAB3AHoAZwA0
AHYAaABnAHkAagA2ADcASgB0ADQATQBQADEASgA2AGUAagBWAGoAeABGAEIATABjAG8AUwBrAHAA
dQBLAHgANgBaAFcAcgA4ADMASwB1ADEAcwA0AGgAeABkAG0AOQB0AEkAdQBrAEIASQB5AC8AMQA0
AC8AQwBoAG0ARABqAEIARwBPAGQANgBOAGgAbgBrAFEAQQBNAHcAcABZAFgAawAvAGcAbgAwAHgA
cABFAEsARAAwAFUARgAyAFEAUQBNAHEAWgBmAHAAeABHAHMARwBxAGcAaABHAEsAbABkAEkAaQBu
AE8AWgByAEcATwAwAEIATQBFADcAUwB3AEEAMAAxAFgAMgBkAGwAdAB2AHMATgA3AHAAQQA3AHYA
cQAyAHQAUwBlAGkAQwBvAFYAbgBYAEEAawBMAHAAMwBZAFUATQBrAEcAQwBkAGQAMABGAFEAMgBR
AEQANABiAFQAWgAzAEoAdwBMAFAAcwBNAHkANgAwAEoASwBVAFoAcwA3AHkANgBzAG0AeQB1AGsA
UgBJADUAUgBXAHMAZwBEAHMAMgBSAHoAQgBIAFYAMgA4AEYATwBaAE8AVQA4AEQAVQBYAGcAbQBI
AC8ATwAzAGgAdABDAGQARgBjAGgAZAAzAEcAVwA1AEEANwBEAFYAVABwAHAAcgBzADkAdgArADAA
YQBaAEQAMwBWAG8AZgBMAGEAYgBZAEIANgBkAE4AYQBBADIANABsADkAKwBUADkAagBkADIANABP
AGkAdQBVAGgAUAA4AGgAbwB0AGQAdwBYAGwARgBrAEIAYwBiAEgARgBkAHYAWQB5AHMAQwA0AGgA
KwBzAHIAcwAvAG4AaABwAGQANgBoAEYARAA3AFkAUQBhAGQAeQBMAGQAaQBtAG4AbgBhAFQAcABI
AE8AUQBnAFUAWgA3AEUAOQB2AHUATABEAGwAMQAzAGEAVABuADQAcwBUAHYAUABIAEgASgBBAFoA
TgBBAGsAYQBoAFcAbwBOADgAUgBQADIAZgBBAHUAdABaAEYAcgBSAHMAQwBEAGUATwB4AHgATgAy
AEQATgBXAEsAYQB5ADAAdABBAFcAVwB5AEUAdwBOAGgAVQBDAHgAbwBnAFIAUQBpADgAcwBjAGoA
eABrAGMATwBLAGgAMABEAEkAZQB4AFUAagA5ADEAWgBGADYAegB2ADUAYQBBAHIAWQBSAG8AdAA2
AFoAQgBKAG4AcgBwAHMAOQAvAEcAVQB6AFoANQAwADAAVQBrAEwAQgA1AEQARwBkAFkAMABHAGUA
WQBIADcAYwBsAEsAaABFAE4AUgAvADAAeABJAGQASQBlAEwAcQBYAGgANgBGAG4AeQBRAHQAcgBU
AFYAVQAyADEANQB2ADQAWAA4AHAAcQA0AE4AUQBiADkAUQBiAEIAbABPAFYAYgBXAEQANQBrAEcA
ZQBHAHEAbwBsAG8AWAB4ADIAMAB4ACsAUgBzAFkATwBwAG0AbgBMAGIAbAB6AGgAMABtAEMASQBX
ADUAUAB0AEoASABEADAAQgB3ADIATwBZAHQAZgBnADYAOABIAC8AeQBSAHAAbABIAFkAdwBHAFAA
VgBmAHIATwA5AEEAcgBYAFkAUQBrADgAbwBHAFQALwByAHkAZQByAG8ARgBUAC8AVgBSAEIATgBL
AHcAbwBiACsAMwBmAEgARgA0AFkAegBLAEgAcAA2ADEAZQBPADkASgBGADQAZAByAEwATQA3AGQA
YgBIAFMAMgBQAHgAKwA5AFEAeAAzAEgAZAAwAEIAUQBoADgAOAB1AG0AeAAxAHkARQBGAEUAWQB1
AEgAcgBKAGEAegB2ADIAQQBGAEUAdQA0AEoANwBaADgAZgA2AHcALwBFAFcAUQBmAHoAQgB6AGMA
NQBzAFkARABuAE4AcgBVADEANwBiACsAbwBoAEgATQBBAGYASQBIADgAOABVAG0ANgBvAEcAdwBP
AG0ASgBEAEUAaABqADUARwAxAEYAdgAzAFoAbwAyAFQARQBHAHYARAA0AFgAYgBsAEIAQgBGAG0A
OQBlACsAZABiAFMAMgBrAHcAYQBDAHYAagAzAGQAKwBKAFkAcgAvAGgAaABoAE8AWgB4ADkAQQBN
ADYAagBXAGMAMgBhAGwATQBPAEgAbQBmAHMAUABEAHQAawBXAEkAcgBhADcAeQBIAEcATgBoAEoA
WQBBAFEAWABZAGkAOABwAHIATwBYAFgAUABWAGgAaQAvAGcARwA3AFEAMwB3AGEASwBNADQARwBV
AFgAbABuAG0ARABVACsAMABEAEIAdgBvAE0AQgB3AGIAbgBtAHIAMQBiADkANABDAHIAaABkAHYA
RwB1AEEAcABIAFAARwBLADgAcwBqAHIAcQBRAFUAcABFAFIAbQB2AFAAcwBWAEgASQA3AHAAawB4
AHMAcgBQAEUAVgA4AG0AYQB2AGIALwAxAHoAOAB5ADYAUgAwAGgATAB2ADEAYwBtAGcAZABaAFEA
RgBOAC8AMQA0AGUAOQBwAEUARgBEAGUAcAB1ADAAWABWAFgAYgB6AG0AeABtAGkAQQA0AEkAaABq
AGoAbgBrAHMANwAzAFUARABLAEYAUQBlAEcAcABEAGMAVgBhAEoAQQBjAE4AdABoADAAOQB0AEsA
SQBXAHQAbQBoADAAUQBxAFQARwBJAHYAagBNAEkATwBWADcAUAB2AEYALwB6ADkASwBEAFcAbwBF
AEYAMwB0AGwARQBCAG8AOAAvAFoAUgBSADQAZABZAGgAbgBnADkAeABlAGEATQB0ADkAKwBtAGkA
UABBAE0AQwAwAFYAQgB2AEcAVQB6ADgAeQBOAFUAYQA5AC8ASgBPAEIAQgAzAEUALwBHAEoAYgAr
AGQANwA5AFcASgBPAEMAQQBoAE4AegA4AE8ASABaAGkAZQBaAHIAYQA2AFoAeABZAHkAMwBoADMA
NAAwADkAQwBoAHgARQAyAEYARABUAHAATQAxAE0ANABaAE4ANABEAGMAMwBHAHcAMQBPAHQAWAA4
AFYAUQA3AC8ASgBJAEIAbwA3AG4AcABBAGUARQBYAG4AWQA1ADIAYwBMAC8AdgBOAGwAbwBNADQA
TwB0AFIAbABrAFAATQBvAEwAawBtAEwAawBvAEoAawBLAEwANwA0ADQAUgBFAEkAagA2AEgARABk
AHEASgBGAGwANQBJAE8AdABMAHcAdwBCAHQAOAB1AFkAMABDAEcARQB2AEUAQQA5AHUAYQBaAHQA
RwBQAFgAcgB1AEsAagBhADkAWABZAHYAVABFAEsASwBZAEsAKwBHAFMANgBKAEkAMQBVADEAUgBr
ADAASgA3AEsARgBSADMAVwBVAG8ATABPAG0AcABVAC8ANQA2AFUAegA0AHAANQBxAG8AaABsAG8A
eQAvAHMAVwBKAHkAbABOAEYARgArADgAZgB4ADkAZgAyADYAMABkAGkATwBpAE0ARQAvADMAcgBB
AHQASAB0AHYANwBxAHoAbABxAHgAZQBmAFcAZwB4AHgALwBiADcAMwBEAEcAZgA0AGkAKwBGAG8A
RABwAHYAcQBLADMARwA0ADkAUAA1AHIAcAA2ADYAQwBVAFoATgBmAGEAMgBvAGgARQBKAHAAeQAz
AEgAZABnAFMARwBVAGoANQAyAHkARgBCAGMAMwBVADYARgBEAEoAcgAvAEsANQAwAHAAUwArAGEA
TgA0AGsAKwBzAEMAegBtAGkAcgBhAFAAYQBIADkAcABaAEkAdgBrAHEANwBPAHEAeAAvADQAMwBG
AHUAUQA0AGQAQgB3AHEALwBiAEgAaQAyAFgASAB0AFYAcQBqAFkARABjAE8AKwBjADIAWQB1ADUA
NQA4AEkATAB1AGgAWQB0AEwAZwBBAGgAcgBHAEUASQAwAGkAdABOACsAWQBGAFoATQA5AFYAZwBM
AHAAdAA3AHQASwA3AHkAWABrAEYASABEAGQATABPAEcAaQBFAEcAbQBXAG0AWAB6AEEAWQBKAEUA
dABqAG4AWgB0AE4AUwBGAHgAUgBLAGQAbwBXADgATAB6AE0ARwBOADAAbABCAE4AWgBlAEEAbQB0
AAAAAAAr2g==

--_000_PA4PR04MB9638C940D962456E3CFC9977D1DBAPA4PR04MB9638eurp_--
