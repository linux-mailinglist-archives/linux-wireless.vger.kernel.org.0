Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4E776E28
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHJCjb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 22:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHJCja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 22:39:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C41BFA
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 19:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj21vkPLiGSx2Egsg19L0/Y47Bzt/0vzElDYo0wj1XB85ExmzPDtax0P08ziMJ+vYvs1XbRCmwIM9IhwKPyjpuqTvsbAsYOWd6ynO85P5wzZEG28c5ySkHOJCSzI2DLCIpAy6WGkq3jkbswgme629Cf84y4OdXJSz3JpACSRIlMgaSd6Hu2ykOu3DH7I8fe2+n3mkQpkxlnVpvx+/DqPysO1oP9SaC4S+gJX/PkAPWkI9LXZ8k2SGlB5IsEAjQdRhrR3Db5Yh9cHfKcM7j7gWGHdXxHhyfoAx7p/QVnEKG7gkhYXWfwpw7BDcx1WoFdlFB84TqALSqvVNGKs2WQDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySEhDNHWA/S5wGZAB0B28D51kmZUq87LqzJCTte6TGg=;
 b=T3RGzKWTxdVUcPEMVVU8CfIq9W6FlbE6XtYbpZhfJQcH+HBy7NfHM0Q1BoLmweEN3hCPfGHDWu05NRhYCcj7yd2gmlWCFdT6pFKUHa6j7/2gBfmeNKVA4un1GrLZ3i3PFGinNVoivyZ4n4F0j317NMPH3YgReoJYqC67noL4a6k5MoyuUCok1NJS0ET+oeIuPbk++mJEm9nqYVlM0mMm2pspl/78B88ySzNl0rNceff9yitorU5MJ3ijkibWfaSzEV5CVsdAsC3FdCVfTDEFTbIYJOVeVtyX35wWP8O9pTKR+lSpsv8clsgsXgE5XMOe2IdfpWNjISaL6zABxyY7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySEhDNHWA/S5wGZAB0B28D51kmZUq87LqzJCTte6TGg=;
 b=DE63Birdz9pmL+eZdYz5WPGN0z9Br+iIFnbK9RhutQJE7kVAMwlOzcIwqgyJ3NwfcSvmwYeYTnc0Tcd3T/CgK49OR5Yt8mR/noJ0U2/U1v8zOB2ZA0L0XClqkn1iG+gaf4UK9k5ZR4CVH3zq4go5FBIqOo7zctQuGrq1SFuDDIQ=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:39:22 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::5db6:ba53:768:f057]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::5db6:ba53:768:f057%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:39:22 +0000
Content-Type: multipart/mixed;
        boundary="_000_DU0PR04MB963607ADBFC49C7AB713092DD113ADU0PR04MB9636eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH v3] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [PATCH v3] wifi: mwifiex: added code to support host mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhg==
Date:   Thu, 10 Aug 2023 02:39:21 +0000
Message-ID: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|GV1PR04MB9150:EE_
x-ms-office365-filtering-correlation-id: f88b49ea-fb64-493d-78b5-08db994b00ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l553Ss7htz8qkAD2ZPsfynsqVofPa3cnTEQUEHMMegaknmDmueKA6YdtYkgCSxnv665aaFeypKdPPOU0xxVYDi+VU5IlY5xcPVfcPDm4EeGdvnkeWLNVoktJLZ5fXXeEa6sYh9cZAGazPnrrSlxPg4LYSzA+DhTL3q60zijDSeK7xgA8hD8nbYJ4+H+lm7UPtQlparyQ/fgQslbqERUthnRrqmljqbHZv+GPNIEQ3V9MsRyXniHki2PJ/DO/sEX6IgayHsUANE/a828QHA+bY02QGJbTpEezsIlQ2wS1wrZ0WSvaCS15KP5b4usAwYxSOuGQ6JfjC8RQ6Nh4BOSC3JjCdc71xE/V+tTe2+7laPWZyH7PjmwEIsipfd0OS8hN1Pwj66AuJD9i4FJLthC5im7ySKESmahg//5ZVlESccar6Yc0EuDY7lk8TBpye4vM7fX0faONsAlddqeWYOvWeqOH/M7gSFLMFqOgiYO5RDGxQ7aVpMxqsfl8Qyr+kjRttlRTBfZzoIS16AySh272Q/Uw93DFM4vRGiK00nmDjgmF90uOe/rIX45I+6SKHnBr+1yGmkZqrNV7GTiZoZcOT2HvDmCs9ypcxPM2iIs6rg8zERUe/6xcX+9/KmW2UTSh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(1800799006)(186006)(66899021)(55016003)(66476007)(66946007)(6916009)(54906003)(66556008)(76116006)(6506007)(64756008)(66446008)(71200400001)(478600001)(33656002)(83380400001)(41300700001)(316002)(4326008)(9686003)(7696005)(2906002)(30864003)(8936002)(8676002)(86362001)(38100700002)(52536014)(5660300002)(122000001)(38070700005)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f2SnBdTWusgcqqdGln7VPh9Fp5oBADLs8Xny1skM5T6hRoT6zWjVRbX876+r?=
 =?us-ascii?Q?FRqXpUOsxxO7rag/4JRImidSn9wCDGJfNLzgRQY6mMo4gf9mSOmVlg/gcGWS?=
 =?us-ascii?Q?eN7e2AxaRyCdFxrvvO7T2+doPcUqfG52qhNXMDKgDX5d/9c40wJjfYUJC1jo?=
 =?us-ascii?Q?FaRFIghNu4oPIL4E0jh9ZXwrLhXV8pQsWy1iO1F601vAuby/97Pq3+krTU1H?=
 =?us-ascii?Q?VX7Hec/o3Jq8/F0r+AT8j4898jDvESFdiWYqF6LZK1ZuSI4jq9nZ0nFBL3rV?=
 =?us-ascii?Q?5yE6UD8yd3VjumfZml1Ex05JQ8Zi6iB15c0G8ZAktF7TPGtq/kh3TgD4jmiq?=
 =?us-ascii?Q?pCUnniG1CwsjYPtbgTNocRXyvys9AhqcpSjjIafioV94Qp17oHpd1aP1Gtro?=
 =?us-ascii?Q?TYkOlsfT6B1K4Yg/gWYqSEr/ZCOL8JSLKoMtKFQ4aN7GnGdzSmhUNp/e3VFA?=
 =?us-ascii?Q?gfTRoB28GNZJ6uY2aW28hTpqjB9EnEIzBX7N4BUJXMCNZA4bbDMI3HVBTB2H?=
 =?us-ascii?Q?Oefdh6SAfRWNQGt3g5FOK9b07s+N+3oKpKiCTyrWM8lwALu22v1u2BRM8cFg?=
 =?us-ascii?Q?teFvA3CEudqpGmMp0oBYD2hUl2KuomHYJAkcyy2ocqDBnIvUU56GeazUdgYk?=
 =?us-ascii?Q?s7R1mn8YwnbqbITyh7TUZQ76+SaDc7GUzHIZAIiP3EDPRAIOuhwRHlkKmzCv?=
 =?us-ascii?Q?Wck8P6ieT1F8eS1LcFoO1l9XF0QdjCpFjwYhH2AxwddCXKU5CNOVm3WX9lt8?=
 =?us-ascii?Q?SbnnoN9ou7frXtTRFSGh6Dd+5c79md8Hm9FVv/PCbK+9YYyWieZnjgXVaP+3?=
 =?us-ascii?Q?5r7uvi3hQ9aj18rMDJQpzmLphg+9TwF2+7sdUCudys9QqIkHOTiu+ueTgZc/?=
 =?us-ascii?Q?/uFhZGunxUfS+NLvYVBLUJ7vTtkHnAkCaICFnLhqc186H+MobvXfm9kiwdFX?=
 =?us-ascii?Q?ChnYYjogvBvYAC6/Y/sj2Y27V39du0ZaT/TFWx3ry+9IUHK0ydfoMrQEtflG?=
 =?us-ascii?Q?st20ILf9BJkaEV9gawe3xx7l9f1eyDqQboDgwiInawdoDaz2a/2XEDdmWfmz?=
 =?us-ascii?Q?wYimTdw1atH2JyEj+mhvS0kSBTL2cCRrIMXyLRzewxyx1QAF5NbsZcSY7IWI?=
 =?us-ascii?Q?Y0BKNSXhgbVFN98794HxPFrwJ8HvZNTyDq2qQh3B5uNa2O+izrjFXubtTXBG?=
 =?us-ascii?Q?CgE/KVgNwY82BMgYX4TgcKqfO56mwuNdoMT5oYovAXWqOWKs+IeN8g3ewkQ9?=
 =?us-ascii?Q?SSwoSgcVFQkTdMBDRz/FodEKHUi8RU6pJxQA2wkGL/8PEh+Y16roiXEgmWt7?=
 =?us-ascii?Q?pCoI3qsx+2J7SwZYvRju055KsqM3FjPU45OM7NMVwW2rC8PuqddtgKUwXWhq?=
 =?us-ascii?Q?taDrPIzXn3eyO2r8VWpex2aqnOrT5Ak5KWcsrcbcm5fH7KvOQ/l/HjG3huEE?=
 =?us-ascii?Q?N6squpWEUaZdSlq2nIr0hyZjEfONQg0dNXQBB5wGxu5gmHINy/nc0G1G0LwA?=
 =?us-ascii?Q?cjAFOJcUp2JhCY2XSCKa9Tpz3iVeKXvTB7gRN2bZ3db+zJCB165U9LIesA?=
 =?us-ascii?Q?=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88b49ea-fb64-493d-78b5-08db994b00ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 02:39:22.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbu3lIM00H34U7f918dk8nHmB28Qr1kK11FAwbsqUe8pxqCAnwLvngJRo3mE95qDFdSzheio1BG4PqItIQZQgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_000_DU0PR04MB963607ADBFC49C7AB713092DD113ADU0PR04MB9636eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

1. For station mode first.
2. This feature is a must for WPA3.
3. Firmware version 2 is needed for this feature.
4. The code is only enabled and tested with IW416.
5. This feature is disabled for other chips.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 327 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
 drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  65 +++-
 drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
 drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
 15 files changed, 572 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index ba4e29713a8c..605952ee0aa9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -57,6 +57,31 @@ ieee80211_iface_combination mwifiex_iface_comb_ap_sta_dr=
cs =3D {
 	.beacon_int_infra_match =3D true,
 };
=20
+struct mwifiex_ieee80211_mgmt {
+	__le16 frame_control;
+	__le16 duration;
+	u8 da[ETH_ALEN];
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	union {
+		struct {
+			__le16 auth_alg;
+			__le16 auth_transaction;
+			__le16 status_code;
+			/* possibly followed by Challenge text */
+			u8 variable[];
+		} __packed auth;
+		struct {
+			__le16 capab_info;
+			__le16 listen_interval;
+			/* followed by SSID and Supported rates */
+			u8 variable[];
+		} __packed assoc_req;
+	} u;
+} __pack;
+
 /*
  * This function maps the nl802.11 channel type into driver channel type.
  *
@@ -268,6 +293,8 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct=
 wiphy *wiphy,
=20
 	if (mask !=3D priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask =3D mask;
+		if (priv->host_mlme_reg)
+			priv->mgmt_frame_mask |=3D HOST_MLME_MGMT_MASK;
 		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 				 HostCmd_ACT_GEN_SET, 0,
 				 &priv->mgmt_frame_mask, false);
@@ -848,6 +875,7 @@ static int mwifiex_deinit_priv_params(struct mwifiex_pr=
ivate *priv)
 	struct mwifiex_adapter *adapter =3D priv->adapter;
 	unsigned long flags;
=20
+	priv->host_mlme_reg =3D false;
 	priv->mgmt_frame_mask =3D 0;
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 			     HostCmd_ACT_GEN_SET, 0,
@@ -4201,6 +4229,292 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy=
, struct net_device *dev,
 	return ret;
 }
=20
+static int
+mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_auth_request *req)
+{
+	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter =3D priv->adapter;
+	struct sk_buff *skb;
+	u16 pkt_len, auth_alg;
+	int ret;
+	struct mwifiex_ieee80211_mgmt *mgmt;
+	struct mwifiex_txinfo *tx_info;
+	u32 tx_control =3D 0, pkt_type =3D PKT_TYPE_MGMT;
+	u8 addr[ETH_ALEN] =3D {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+	u8 trans =3D 1, status_code =3D 0;
+	u8 *varptr;
+
+	if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP) {
+		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
+		return -EFAULT;
+	}
+
+	if (priv->wdev.iftype !=3D NL80211_IFTYPE_STATION) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "Interface type is not correct (type %d)\n",
+			    priv->wdev.iftype);
+		return -EINVAL;
+	}
+
+	if (priv->auth_alg !=3D WLAN_AUTH_SAE &&
+	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
+		return -EBUSY;
+	}
+
+	if (!priv->host_mlme_reg) {
+		priv->host_mlme_reg =3D true;
+		priv->mgmt_frame_mask |=3D HOST_MLME_MGMT_MASK;
+		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				 HostCmd_ACT_GEN_SET, 0,
+				 &priv->mgmt_frame_mask, false);
+	}
+
+	switch (req->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		auth_alg =3D WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		auth_alg =3D WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_FT:
+		auth_alg =3D WLAN_AUTH_FT;
+		break;
+	case NL80211_AUTHTYPE_NETWORK_EAP:
+		auth_alg =3D WLAN_AUTH_LEAP;
+		break;
+	case NL80211_AUTHTYPE_SAE:
+		auth_alg =3D WLAN_AUTH_SAE;
+		break;
+	default:
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "unsupported auth type=3D%d\n", req->auth_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (!priv->auth_flag) {
+		ret =3D mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_SET,
+						 req->bss->channel,
+						 AUTH_TX_DEFAULT_WAIT_TIME);
+
+		if (!ret) {
+			priv->roc_cfg.cookie =3D get_random_u32() | 1;
+			priv->roc_cfg.chan =3D *req->bss->channel;
+		}
+	}
+
+	priv->sec_info.authentication_mode =3D auth_alg;
+
+	mwifiex_cancel_scan(adapter);
+
+	pkt_len =3D (u16)req->ie_len + req->auth_data_len +
+		     MWIFIEX_MGMT_HEADER_LEN + MWIFIEX_AUTH_BODY_LEN;
+	if (req->auth_data_len >=3D 4)
+		pkt_len -=3D 4;
+
+	skb =3D dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
+			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
+			    pkt_len + sizeof(pkt_len));
+	if (!skb) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "allocate skb failed for management frame\n");
+		return -ENOMEM;
+	}
+
+	tx_info =3D MWIFIEX_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num =3D priv->bss_num;
+	tx_info->bss_type =3D priv->bss_type;
+	tx_info->pkt_len =3D pkt_len;
+
+	skb_reserve(skb, MWIFIEX_MIN_DATA_HEADER_LEN +
+		    MWIFIEX_MGMT_FRAME_HEADER_SIZE + sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(pkt_len)), &pkt_len, sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(tx_control)),
+	       &tx_control, sizeof(tx_control));
+	memcpy(skb_push(skb, sizeof(pkt_type)), &pkt_type, sizeof(pkt_type));
+
+	mgmt =3D (struct mwifiex_ieee80211_mgmt *)skb_put(skb, pkt_len);
+	memset(mgmt, 0, pkt_len);
+	mgmt->frame_control =3D
+		cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_AUTH);
+	memcpy(mgmt->da, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->sa, priv->curr_addr, ETH_ALEN);
+	memcpy(mgmt->bssid, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->addr4, addr, ETH_ALEN);
+
+	if (req->auth_data_len >=3D 4) {
+		if (req->auth_type =3D=3D NL80211_AUTHTYPE_SAE) {
+			__le16 *pos =3D (__le16 *)req->auth_data;
+
+			trans =3D le16_to_cpu(pos[0]);
+			status_code =3D le16_to_cpu(pos[1]);
+		}
+		memcpy((u8 *)(&mgmt->u.auth.variable), req->auth_data + 4,
+		       req->auth_data_len - 4);
+		varptr =3D (u8 *)&mgmt->u.auth.variable +
+			 (req->auth_data_len - 4);
+	}
+
+	mgmt->u.auth.auth_alg =3D cpu_to_le16(auth_alg);
+	mgmt->u.auth.auth_transaction =3D trans;
+	mgmt->u.auth.status_code =3D status_code;
+
+	if (req->ie && req->ie_len) {
+		if (!varptr)
+			varptr =3D (u8 *)&mgmt->u.auth.variable;
+		memcpy((u8 *)varptr, req->ie, req->ie_len);
+	}
+
+	priv->auth_flag =3D HOST_MLME_AUTH_PENDING;
+	priv->auth_alg =3D auth_alg;
+
+	skb->priority =3D WMM_HIGHEST_PRIORITY;
+	__net_timestamp(skb);
+
+	mwifiex_dbg(priv->adapter, MSG,
+		    "auth: send authentication to %pM\n", req->bss->bssid);
+
+	mwifiex_queue_tx_pkt(priv, skb);
+
+	return 0;
+}
+
+static int
+mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev,
+			   struct cfg80211_assoc_request *req)
+{
+	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter =3D priv->adapter;
+	int ret;
+	struct cfg80211_ssid req_ssid;
+	const u8 *ssid_ie;
+	struct cfg80211_rx_assoc_resp assoc_resp =3D {
+		.uapsd_queues =3D -1,
+	};
+
+	if (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_STA) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: reject infra assoc request in non-STA role\n",
+			    dev->name);
+		return -EINVAL;
+	}
+
+	if (test_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags) ||
+	    test_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: Ignore association.\t"
+			    "Card removed or FW in bad state\n",
+			    dev->name);
+		return -EFAULT;
+	}
+
+	if (priv->auth_alg =3D=3D WLAN_AUTH_SAE)
+		priv->auth_flag =3D HOST_MLME_AUTH_DONE;
+
+	if (priv->auth_flag && !(priv->auth_flag & HOST_MLME_AUTH_DONE))
+		return -EBUSY;
+
+	if (!mwifiex_stop_bg_scan(priv))
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
+
+	memset(&req_ssid, 0, sizeof(struct cfg80211_ssid));
+	rcu_read_lock();
+	ssid_ie =3D ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
+
+	if (!ssid_ie)
+		goto ssid_err;
+
+	req_ssid.ssid_len =3D ssid_ie[1];
+	if (req_ssid.ssid_len > IEEE80211_MAX_SSID_LEN) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
+		goto ssid_err;
+	}
+
+	memcpy(req_ssid.ssid, ssid_ie + 2, req_ssid.ssid_len);
+	if (!req_ssid.ssid_len || req_ssid.ssid[0] < 0x20) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
+		goto ssid_err;
+	}
+	rcu_read_unlock();
+
+	/* As this is new association, clear locally stored
+	 * keys and security related flags
+	 */
+	priv->sec_info.wpa_enabled =3D false;
+	priv->sec_info.wpa2_enabled =3D false;
+	priv->wep_key_curr_index =3D 0;
+	priv->sec_info.encryption_mode =3D 0;
+	priv->sec_info.is_authtype_auto =3D 0;
+	ret =3D mwifiex_set_encode(priv, NULL, NULL, 0, 0, NULL, 1);
+
+	if (req->crypto.n_ciphers_pairwise)
+		priv->sec_info.encryption_mode =3D
+			req->crypto.ciphers_pairwise[0];
+
+	if (req->crypto.cipher_group)
+		priv->sec_info.encryption_mode =3D req->crypto.cipher_group;
+
+	if (req->ie)
+		ret =3D mwifiex_set_gen_ie(priv, req->ie, req->ie_len);
+
+	memcpy(priv->cfg_bssid, req->bss->bssid, ETH_ALEN);
+
+	mwifiex_dbg(priv->adapter, MSG,
+		    "assoc: send association to %pM\n", req->bss->bssid);
+
+	cfg80211_ref_bss(priv->adapter->wiphy, req->bss);
+
+	ret =3D mwifiex_bss_start(priv, req->bss, &req_ssid);
+
+	if (!ret) {
+		assoc_resp.links[0].bss =3D priv->attempted_bss_desc->bss;
+		assoc_resp.buf =3D priv->assoc_rsp_buf;
+		assoc_resp.len =3D priv->assoc_rsp_size;
+		cfg80211_rx_assoc_resp(priv->netdev,
+				       &assoc_resp);
+	} else {
+		priv->auth_flag =3D 0;
+		priv->auth_alg =3D 0xFFFF;
+		eth_zero_addr(priv->cfg_bssid);
+	}
+
+	cfg80211_put_bss(priv->adapter->wiphy, req->bss);
+
+	return 0;
+
+ssid_err:
+
+	rcu_read_unlock();
+	return -EFAULT;
+}
+
+static int
+mwifiex_cfg80211_deauthenticate(struct wiphy *wiphy,
+				struct net_device *dev,
+				struct cfg80211_deauth_request *req)
+{
+	return mwifiex_cfg80211_disconnect(wiphy, dev, req->reason_code);
+}
+
+static int
+mwifiex_cfg80211_disassociate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_disassoc_request *req)
+{
+	return mwifiex_cfg80211_disconnect(wiphy, dev, req->reason_code);
+}
+
+static int
+mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
+			      struct net_device *dev, const u8 *peer,
+			      u64 *cookie)
+{
+	return -1;
+}
+
 /* station cfg80211 operations */
 static struct cfg80211_ops mwifiex_cfg80211_ops =3D {
 	.add_virtual_intf =3D mwifiex_add_virtual_intf,
@@ -4346,6 +4660,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter=
 *adapter)
 			    "%s: creating new wiphy\n", __func__);
 		return -ENOMEM;
 	}
+	if (adapter->host_mlme) {
+		mwifiex_cfg80211_ops.auth =3D mwifiex_cfg80211_authenticate;
+		mwifiex_cfg80211_ops.assoc =3D mwifiex_cfg80211_associate;
+		mwifiex_cfg80211_ops.deauth =3D mwifiex_cfg80211_deauthenticate;
+		mwifiex_cfg80211_ops.disassoc =3D mwifiex_cfg80211_disassociate;
+		mwifiex_cfg80211_ops.disconnect =3D NULL;
+		mwifiex_cfg80211_ops.connect =3D NULL;
+		mwifiex_cfg80211_ops.probe_client =3D
+			mwifiex_cfg80211_probe_client;
+	}
 	wiphy->max_scan_ssids =3D MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len =3D MWIFIEX_MAX_VSIE_LEN;
 	wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes;
@@ -4427,6 +4751,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter =
*adapter)
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
=20
+	if (adapter->host_mlme)
+		wiphy->features |=3D NL80211_FEATURE_SAE;
+
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->features |=3D NL80211_FEATURE_HT_IBSS;
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wi=
reless/marvell/mwifiex/cmdevt.c
index 3756aa247e77..1db437cc96b8 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -654,7 +654,7 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 =
cmd_no,
 	if (ret) {
 		mwifiex_dbg(adapter, ERROR,
 			    "PREP_CMD: cmd %#x preparation failed\n",
-			cmd_no);
+			    cmd_no);
 		mwifiex_insert_cmd_to_free_q(adapter, cmd_node);
 		return -1;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wire=
less/marvell/mwifiex/decl.h
index 88648c062713..385b5119f2ee 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -24,6 +24,18 @@
 #define MWIFIEX_RX_HEADROOM	    64
 #define MAX_TXPD_SZ		    32
 #define INTF_HDR_ALIGN		     4
+/* frmctl + durationid + addr1 + addr2 + addr3 + seqctl + addr4 */
+#define MWIFIEX_MGMT_HEADER_LEN   (2 + 2 + 6 + 6 + 6 + 2 + 6)
+/* 6   =3D auth_alg + auth_transaction + auth_status */
+#define MWIFIEX_AUTH_BODY_LEN     6
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
=20
 #define MWIFIEX_MIN_DATA_HEADER_LEN (MWIFIEX_DMA_ALIGN_SZ + INTF_HDR_ALIGN=
 + \
 				     MAX_TXPD_SZ)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wirele=
ss/marvell/mwifiex/fw.h
index f2168fac95ed..5e6bda38f22c 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -209,6 +209,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_RANDOM_MAC         (PROPRIETARY_TLV_BASE_ID + 236)
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
+#define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
+
=20
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
=20
@@ -802,6 +805,11 @@ struct mwifiex_ie_types_ssid_param_set {
 	u8 ssid[];
 } __packed;
=20
+struct mwifiex_ie_types_host_mlme {
+	struct mwifiex_ie_types_header header;
+	u8 host_mlme;
+} __packed;
+
 struct mwifiex_ie_types_num_probes {
 	struct mwifiex_ie_types_header header;
 	__le16 num_probes;
@@ -905,6 +913,13 @@ struct mwifiex_ie_types_tdls_idle_timeout {
 	__le16 value;
 } __packed;
=20
+#define MWIFIEX_AUTHTYPE_SAE 6
+
+struct mwifiex_ie_types_sae_pwe_mode {
+	struct mwifiex_ie_types_header header;
+	u8 pwe[];
+} __packed;
+
 struct mwifiex_ie_types_rsn_param_set {
 	struct mwifiex_ie_types_header header;
 	u8 rsn_ie[];
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wire=
less/marvell/mwifiex/init.c
index 7dddb4b5dea1..ca23be8d3ac3 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -81,6 +81,9 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->bcn_avg_factor =3D DEFAULT_BCN_AVG_FACTOR;
 	priv->data_avg_factor =3D DEFAULT_DATA_AVG_FACTOR;
=20
+	priv->auth_flag =3D 0;
+	priv->auth_alg =3D 0xFFFF;
+
 	priv->sec_info.wep_enabled =3D 0;
 	priv->sec_info.authentication_mode =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
 	priv->sec_info.encryption_mode =3D 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wire=
less/marvell/mwifiex/join.c
index a6e254a1185c..59c2ed805128 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -382,7 +382,9 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private=
 *priv,
 	struct mwifiex_ie_types_ss_param_set *ss_tlv;
 	struct mwifiex_ie_types_rates_param_set *rates_tlv;
 	struct mwifiex_ie_types_auth_type *auth_tlv;
+	struct mwifiex_ie_types_sae_pwe_mode *sae_pwe_tlv;
 	struct mwifiex_ie_types_chan_list_param_set *chan_tlv;
+	struct mwifiex_ie_types_host_mlme *host_mlme_tlv;
 	u8 rates[MWIFIEX_SUPPORTED_RATES];
 	u32 rates_size;
 	u16 tmp_cap;
@@ -448,7 +450,7 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private=
 *priv,
 	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_CMD: rates size =3D %d\n",
 		    rates_size);
=20
-	/* Add the Authentication type to be used for Auth frames */
+	/* Add the Authentication type */
 	auth_tlv =3D (struct mwifiex_ie_types_auth_type *) pos;
 	auth_tlv->header.type =3D cpu_to_le16(TLV_TYPE_AUTH_TYPE);
 	auth_tlv->header.len =3D cpu_to_le16(sizeof(auth_tlv->auth_type));
@@ -460,6 +462,24 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_privat=
e *priv,
=20
 	pos +=3D sizeof(auth_tlv->header) + le16_to_cpu(auth_tlv->header.len);
=20
+	if (priv->sec_info.authentication_mode =3D=3D WLAN_AUTH_SAE) {
+		auth_tlv->auth_type =3D cpu_to_le16(MWIFIEX_AUTHTYPE_SAE);
+		if (bss_desc->bcn_rsnx_ie &&
+		    bss_desc->bcn_rsnx_ie->ieee_hdr.len &&
+		    (bss_desc->bcn_rsnx_ie->data[0] &
+		    (0x01 << WLAN_RSNX_CAPA_SAE_H2E))) {
+			sae_pwe_tlv =3D
+				(struct mwifiex_ie_types_sae_pwe_mode *)pos;
+			sae_pwe_tlv->header.type =3D
+				cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
+			sae_pwe_tlv->header.len =3D
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
+			sae_pwe_tlv->pwe[0] =3D bss_desc->bcn_rsnx_ie->data[0];
+			pos +=3D sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe[0]);
+		}
+	}
+
 	if (IS_SUPPORT_MULTI_BANDS(priv->adapter) &&
 	    !(ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
 	    (!bss_desc->disable_11n) &&
@@ -491,6 +511,17 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_privat=
e *priv,
 			sizeof(struct mwifiex_chan_scan_param_set);
 	}
=20
+	if (priv->adapter->host_mlme) {
+		host_mlme_tlv =3D (struct mwifiex_ie_types_host_mlme *)pos;
+		host_mlme_tlv->header.type =3D cpu_to_le16(TLV_TYPE_HOST_MLME);
+		host_mlme_tlv->header.len =3D sizeof(host_mlme_tlv->host_mlme);
+		host_mlme_tlv->host_mlme =3D 1;
+		pos +=3D sizeof(host_mlme_tlv->header) +
+			host_mlme_tlv->header.len;
+		host_mlme_tlv->header.len =3D
+			cpu_to_le16(host_mlme_tlv->header.len);
+	}
+
 	if (!priv->wps.session_enable) {
 		if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
 			rsn_ie_len =3D mwifiex_append_rsn_ie_wpa_wpa2(priv, &pos);
@@ -634,6 +665,7 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private=
 *priv,
 	u16 cap_info, status_code, aid;
 	const u8 *ie_ptr;
 	struct ieee80211_ht_operation *assoc_resp_ht_oper;
+	struct ieee80211_mgmt *hdr;
=20
 	if (!priv->attempted_bss_desc) {
 		mwifiex_dbg(priv->adapter, ERROR,
@@ -641,7 +673,19 @@ int mwifiex_ret_802_11_associate(struct mwifiex_privat=
e *priv,
 		goto done;
 	}
=20
-	assoc_rsp =3D (struct ieee_types_assoc_rsp *) &resp->params;
+	if (adapter->host_mlme) {
+		hdr =3D (struct ieee80211_mgmt *)&resp->params;
+		if (!memcmp(hdr->bssid,
+			    priv->attempted_bss_desc->mac_address,
+			    ETH_ALEN))
+			assoc_rsp =3D (struct ieee_types_assoc_rsp *)
+				&hdr->u.assoc_resp;
+		else
+			assoc_rsp =3D
+				(struct ieee_types_assoc_rsp *)&resp->params;
+	} else {
+		assoc_rsp =3D (struct ieee_types_assoc_rsp *)&resp->params;
+	}
=20
 	cap_info =3D le16_to_cpu(assoc_rsp->cap_info_bitmap);
 	status_code =3D le16_to_cpu(assoc_rsp->status_code);
@@ -778,7 +822,8 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private=
 *priv,
=20
 	priv->adapter->dbg.num_cmd_assoc_success++;
=20
-	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_RESP: associated\n");
+	mwifiex_dbg(priv->adapter, MSG, "assoc: associated with %pM\n",
+		    priv->attempted_bss_desc->mac_address);
=20
 	/* Add the ra_list here for infra mode as there will be only 1 ra
 	   always */
@@ -1491,6 +1536,20 @@ int mwifiex_deauthenticate(struct mwifiex_private *p=
riv, u8 *mac)
 	if (!priv->media_connected)
 		return 0;
=20
+	if (priv->adapter->host_mlme) {
+		priv->auth_flag =3D 0;
+		priv->auth_alg =3D 0xFFFF;
+		priv->host_mlme_reg =3D false;
+		priv->mgmt_frame_mask =3D 0;
+		if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				     HostCmd_ACT_GEN_SET, 0,
+				     &priv->mgmt_frame_mask, false)) {
+			mwifiex_dbg(priv->adapter, ERROR,
+				    "could not unregister mgmt frame rx\n");
+			return -1;
+		}
+	}
+
 	switch (priv->bss_mode) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wire=
less/marvell/mwifiex/main.h
index b95886e1413e..6d0b9fcfe07c 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -384,6 +384,7 @@ struct ieee_types_aid {
=20
 struct mwifiex_bssdescriptor {
 	u8 mac_address[ETH_ALEN];
+	struct cfg80211_bss *bss;
 	struct cfg80211_ssid ssid;
 	u32 privacy;
 	s32 rssi;
@@ -426,6 +427,8 @@ struct mwifiex_bssdescriptor {
 	u16 wpa_offset;
 	struct ieee_types_generic *bcn_rsn_ie;
 	u16 rsn_offset;
+	struct ieee_types_generic *bcn_rsnx_ie;
+	u16 rsnx_offset;
 	struct ieee_types_generic *bcn_wapi_ie;
 	u16 wapi_offset;
 	u8 *beacon_buf;
@@ -536,6 +539,8 @@ struct mwifiex_private {
 	u8 bss_priority;
 	u8 bss_num;
 	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
 	u8 frame_type;
 	u8 curr_addr[ETH_ALEN];
 	u8 media_connected;
@@ -658,6 +663,7 @@ struct mwifiex_private {
 	u16 gen_idx;
 	u8 ap_11n_enabled;
 	u8 ap_11ac_enabled;
+	bool host_mlme_reg;
 	u32 mgmt_frame_mask;
 	struct mwifiex_roc_cfg roc_cfg;
 	bool scan_aborting;
@@ -1012,6 +1018,7 @@ struct mwifiex_adapter {
 	bool is_up;
=20
 	bool ext_scan;
+	bool host_mlme;
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
@@ -1077,6 +1084,9 @@ int mwifiex_recv_packet(struct mwifiex_private *priv,=
 struct sk_buff *skb);
 int mwifiex_uap_recv_packet(struct mwifiex_private *priv,
 			    struct sk_buff *skb);
=20
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa);
+
 int mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				struct sk_buff *skb);
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wire=
less/marvell/mwifiex/scan.c
index 644b1e134b01..27eb9a073666 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1388,6 +1388,12 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_a=
dapter *adapter,
 			bss_entry->rsn_offset =3D (u16) (current_ptr -
 							bss_entry->beacon_buf);
 			break;
+		case WLAN_EID_RSNX:
+			bss_entry->bcn_rsnx_ie =3D
+				(struct ieee_types_generic *)current_ptr;
+			bss_entry->rsnx_offset =3D
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
 		case WLAN_EID_BSS_AC_ACCESS_DELAY:
 			bss_entry->bcn_wapi_ie =3D
 				(struct ieee_types_generic *) current_ptr;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wire=
less/marvell/mwifiex/sdio.c
index a24bd40dd41a..6ba0339ccc65 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8786 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D false,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 =3D {
@@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8787 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 =3D {
@@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8797 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 =3D {
@@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8897 =3D {
 	.can_dump_fw =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 =3D {
@@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8977 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 =3D {
@@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8978 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D true,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 =3D {
@@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8997 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 =3D {
@@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8887 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D true,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 =3D {
@@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8987 =3D {
 	.fw_dump_enh =3D true,
 	.can_auto_tdls =3D true,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 =3D {
@@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd=
8801 =3D {
 	.can_dump_fw =3D false,
 	.can_auto_tdls =3D false,
 	.can_ext_scan =3D true,
+	.host_mlme =3D false,
 };
=20
 static struct memory_type_mapping generic_mem_type_map[] =3D {
@@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct=
 sdio_device_id *id)
 		card->fw_dump_enh =3D data->fw_dump_enh;
 		card->can_auto_tdls =3D data->can_auto_tdls;
 		card->can_ext_scan =3D data->can_ext_scan;
+		card->host_mlme =3D data->host_mlme;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
=20
@@ -2493,6 +2504,8 @@ static int mwifiex_register_dev(struct mwifiex_adapte=
r *adapter)
 		adapter->num_mem_types =3D ARRAY_SIZE(mem_type_mapping_tbl);
 	}
=20
+	adapter->host_mlme =3D card->host_mlme;
+
 	return 0;
 }
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wire=
less/marvell/mwifiex/sdio.h
index ae94c172310f..d2da8c45a9be 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -258,6 +258,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
=20
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -281,6 +282,7 @@ struct mwifiex_sdio_device {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool host_mlme;
 };
=20
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net=
/wireless/marvell/mwifiex/sta_event.c
index df9cdd10a494..69426ddd9c3a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -135,6 +135,9 @@ void mwifiex_reset_connect_state(struct mwifiex_private=
 *priv, u16 reason_code,
=20
 	priv->media_connected =3D false;
=20
+	priv->auth_flag =3D 0;
+	priv->auth_alg =3D 0xFFFF;
+
 	priv->scan_block =3D false;
 	priv->port_open =3D false;
=20
@@ -999,10 +1002,17 @@ int mwifiex_process_sta_event(struct mwifiex_private=
 *priv)
 	case EVENT_REMAIN_ON_CHAN_EXPIRED:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: Remain on channel expired\n");
-		cfg80211_remain_on_channel_expired(&priv->wdev,
-						   priv->roc_cfg.cookie,
-						   &priv->roc_cfg.chan,
-						   GFP_ATOMIC);
+
+		if (adapter->host_mlme &&
+		    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+			priv->auth_flag =3D 0;
+			priv->auth_alg =3D 0xFFFF;
+		} else {
+			cfg80211_remain_on_channel_expired(&priv->wdev,
+							   priv->roc_cfg.cookie,
+							   &priv->roc_cfg.chan,
+							   GFP_ATOMIC);
+		}
=20
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net=
/wireless/marvell/mwifiex/sta_ioctl.c
index a2ad2b53f016..046541713318 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct mwifiex_private *p=
riv,
 	const struct cfg80211_bss_ies *ies;
=20
 	rcu_read_lock();
+	bss_desc->bss =3D bss;
 	ies =3D rcu_dereference(bss->ies);
 	beacon_ie =3D kmemdup(ies->data, ies->len, GFP_ATOMIC);
 	beacon_ie_len =3D ies->len;
@@ -339,7 +340,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv, str=
uct cfg80211_bss *bss,
 			ret =3D mwifiex_associate(priv, bss_desc);
 		}
=20
-		if (bss)
+		if (bss && !priv->adapter->host_mlme)
 			cfg80211_put_bss(priv->adapter->wiphy, bss);
 	} else {
 		/* Adhoc mode */
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wi=
reless/marvell/mwifiex/sta_tx.c
index 13c0e67ededf..6aed6a334d15 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -36,7 +36,7 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *pr=
iv,
 	struct txpd *local_tx_pd;
 	struct mwifiex_txinfo *tx_info =3D MWIFIEX_SKB_TXCB(skb);
 	unsigned int pad;
-	u16 pkt_type, pkt_offset;
+	u16 pkt_type, pkt_length, pkt_offset;
 	int hroom =3D adapter->intf_hdr_len;
=20
 	if (!skb->len) {
@@ -58,9 +58,11 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *p=
riv,
 	memset(local_tx_pd, 0, sizeof(struct txpd));
 	local_tx_pd->bss_num =3D priv->bss_num;
 	local_tx_pd->bss_type =3D priv->bss_type;
-	local_tx_pd->tx_pkt_length =3D cpu_to_le16((u16)(skb->len -
-						       (sizeof(struct txpd) +
-							pad)));
+
+	pkt_length =3D (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type =3D=3D PKT_TYPE_MGMT)
+		pkt_length -=3D MWIFIEX_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length =3D cpu_to_le16(pkt_length);
=20
 	local_tx_pd->priority =3D (u8) skb->priority;
 	local_tx_pd->pkt_delay_2ms =3D
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/w=
ireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..eb0b8016d43d 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -743,6 +743,29 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command =
*cmd, u16 cmd_action,
 	return 0;
 }
=20
+/* This function prepares AP start up command with or without host MLME
+ */
+static int mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
+				     struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+
+	cmd->command =3D cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	cmd->size =3D S_DS_GEN;
+
+	if (priv->adapter->host_mlme) {
+		tlv =3D (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + cmd->size);
+		tlv->header.type =3D cpu_to_le16(TLV_TYPE_HOST_MLME);
+		tlv->header.len =3D cpu_to_le16(sizeof(tlv->host_mlme));
+		tlv->host_mlme =3D 1;
+		cmd->size +=3D sizeof(struct mwifiex_ie_types_host_mlme);
+	}
+
+	cmd->size =3D cpu_to_le16(cmd->size);
+
+	return 0;
+}
+
 /* This function prepares AP specific deauth command with mac supplied in
  * function parameter.
  */
@@ -777,6 +800,9 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *pri=
v, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		if (mwifiex_cmd_uap_bss_start(priv, cmd))
+			return -1;
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wire=
less/marvell/mwifiex/util.c
index 745b1d925b21..bd9bf2888485 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -370,6 +370,46 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv=
, u8 *payload, u16 len,
=20
 	return 0;
 }
+
+/* This function sends deauth packet to the kernel. */
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa)
+{
+	u8 broadcast_addr[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	u8 frame_buf[100];
+	struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)frame_buf;
+
+	memset(frame_buf, 0, sizeof(frame_buf));
+	mgmt->frame_control =3D (__force __le16)IEEE80211_STYPE_DEAUTH;
+	mgmt->duration =3D 0;
+	mgmt->seq_ctrl =3D 0;
+	mgmt->u.deauth.reason_code =3D (__force __le16)reason_code;
+
+	if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_STA) {
+		memcpy(mgmt->da, broadcast_addr, ETH_ALEN);
+		memcpy(mgmt->sa,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
+		priv->auth_flag =3D 0;
+		priv->auth_alg =3D 0xFFFF;
+	} else {
+		memcpy(mgmt->da, priv->curr_addr, ETH_ALEN);
+		memcpy(mgmt->sa, sa, ETH_ALEN);
+		memcpy(mgmt->bssid, priv->curr_addr, ETH_ALEN);
+	}
+
+	if (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP) {
+		mutex_lock(&priv->wdev.mtx);
+		cfg80211_rx_mlme_mgmt(priv->netdev, frame_buf, 26);
+		mutex_unlock(&priv->wdev.mtx);
+	} else {
+		cfg80211_rx_mgmt(&priv->wdev,
+				 priv->bss_chandef.chan->center_freq,
+				 0, frame_buf, 26, 0);
+	}
+}
+
 /*
  * This function processes the received management packet and send it
  * to the kernel.
@@ -417,6 +457,39 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *pr=
iv,
 	pkt_len -=3D ETH_ALEN;
 	rx_pd->rx_pkt_length =3D cpu_to_le16(pkt_len);
=20
+	if (priv->host_mlme_reg &&
+	    (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP) &&
+	    (ieee80211_is_auth(ieee_hdr->frame_control) ||
+	     ieee80211_is_deauth(ieee_hdr->frame_control) ||
+	     ieee80211_is_disassoc(ieee_hdr->frame_control))) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control)) {
+			if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
+				if (priv->auth_alg !=3D WLAN_AUTH_SAE) {
+					priv->auth_flag &=3D
+						~HOST_MLME_AUTH_PENDING;
+					priv->auth_flag |=3D
+						HOST_MLME_AUTH_DONE;
+				}
+			} else {
+				return 0;
+			}
+
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive authentication from %pM\n",
+				    ieee_hdr->addr3);
+		} else {
+			if (!priv->wdev.connected)
+				return 0;
+
+			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
+				priv->auth_flag =3D 0;
+				priv->auth_alg =3D 0xFFFF;
+			}
+		}
+
+		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
--=20
2.25.1


--_000_DU0PR04MB963607ADBFC49C7AB713092DD113ADU0PR04MB9636eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IhFbAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEE3MzgwMjEx
OUY1N0M0NDY5QjBCOTc3NkNFMTQ1MEJFABYHAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCAAKAAIA
JwAVAAQAQgEBIIADAA4AAADnBwgACgACACcAFgAEAEMBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABADsAAABbUEFUQ0ggdjNdIHdpZmk6IG13aWZpZXg6IGFkZGVkIGNvZGUg
dG8gc3VwcG9ydCBob3N0IG1sbWUuADEUAQuAAQAhAAAAQTczODAyMTE5RjU3QzQ0NjlCMEI5Nzc2
Q0UxNDUwQkUAFgcBA5AGAMxlAABaAAAAAgF/AAEAAABRAAAAPERVMFBSMDRNQjk2MzYwN0FEQkZD
NDlDN0FCNzEzMDkyREQxMTNBQERVMFBSMDRNQjk2MzYuZXVycHJkMDQucHJvZC5vdXRsb29rLmNv
bT4AAAAACwAfDgAAAAACAQkQAQAAAB84AAAbOAAA5LAAAExaRnUj3SViYQAKZmJpZAQAAGNjwHBn
MTI1MgD+A0PwdGV4dAH3AqQD4wIABGNoCsBzZXQwIO8HbQKDAFARTTIKgAa0AoCWfQqACMg7CWIx
OQ7AvwnDFnIKMhZxAoAVYioJsHMJ8ASQYXQFsg5QA2Bzom8BgCBFeBHBbhgwXQZSdgSQF7YCEHIA
wHR9CFBuGjEQIAXABaAbZGSaIANSIBAiF7JcdgiQ5HdrC4BkNR1TBPAHQA0XcDAKcRfyYmttawZz
AZAAICBCTV9C4EVHSU59CvwB8QvwwDIgMS4gRgWxH2G0dGkCICAEYhxwaRHwUHQuXGwLgGUKgDLZ
IbBUaAQAHHBlGIAIcOsZ4CQBYSKAdR9gHHAFsfBXUEEzIzYlwCHAIvD8bXcKwBngGjEAkCJhIYDf
JAEYUAmAHFIFsXQj+SM2fjQjwhngBaAisSQBAiBs/HkgCfABoB5wHGAAcBxgHxAgH2AcUQPwKJAg
SVeoNDE2IzY1I88gDeE7KzQlUm8okBuyI/BwcyMjNiNFU2lnGFBkLQEZMGYtYnk6IEQWYR1gHGBM
C4AgPHkkdS0R0G8uI1FAbkh4cC4FoG0+I0UtUzRAI0UgLjTwLxhQdN4vA/AJcB5wBBAvAMAaITxs
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
YCrAUVBNU0frnT9u+yL8wjqlRibQ/NEfnJH8cFikSQD9ICAlcOBNXFxuIuufbvvJ6L1EgjOSD+Of
y/8OoSGUGf88xf6AER/lX1+f9T/AP8m//8rP+n/b/3Zv/294D3kf5y8f81z5z5cfj4+QmHNrYv9l
0gbwcsGzvaCvGfuXr5i5/3LVpIFdYHNQnBMgUJyfGkSdbvhDRRAZcLiQSSixdexzboThsXVuUmAL
DzOLT54cDEcmsS01Mi4kkC5mMS01LTV9fS2AGzAAHwBCAAEAAAAUAAAARABhAHYAaQBkACAATABp
AG4AAAAfAGUAAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAA
HwBkAAEAAAAKAAAAUwBNAFQAUAAAAAAAAgFBAAEAAABcAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIA
AACARABhAHYAaQBkACAATABpAG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4A
eABwAC4AYwBvAG0AAAAfAAJdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBj
AG8AbQAAAAAAHwDlXwEAAAAuAAAAcwBpAHAAOgB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAA
LgBjAG8AbQAAAAAAHwAaDAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfAB8MAQAAACYAAAB5
AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwAeDAEAAAAKAAAAUwBNAFQA
UAAAAAAAAgEZDAEAAABcAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAACARABhAHYAaQBkACAATABp
AG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAfAAFd
AQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAACwBAOgEAAAAf
ABoAAQAAABIAAABJAFAATQAuAE4AbwB0AGUAAAAAAAMA8T8EBAAACwBAOgEAAAADAP0/5AQAAAIB
CzABAAAAEAAAAKc4AhGfV8RGmwuXds4UUL4DABcAAQAAAEAAOQCAktrdM8vZAUAACDCFMHPeM8vZ
AQsAKQAAAAAAHwDZPwEAAAAAAgAAMQAuACAARgBvAHIAIABzAHQAYQB0AGkAbwBuACAAbQBvAGQA
ZQAgAGYAaQByAHMAdAAuAA0ACgAyAC4AIABUAGgAaQBzACAAZgBlAGEAdAB1AHIAZQAgAGkAcwAg
AGEAIABtAHUAcwB0ACAAZgBvAHIAIABXAFAAQQAzAC4ADQAKADMALgAgAEYAaQByAG0AdwBhAHIA
ZQAgAHYAZQByAHMAaQBvAG4AIAAyACAAaQBzACAAbgBlAGUAZABlAGQAIABmAG8AcgAgAHQAaABp
AHMAIABmAGUAYQB0AHUAcgBlAC4ADQAKADQALgAgAFQAaABlACAAYwBvAGQAZQAgAGkAcwAgAG8A
bgBsAHkAIABlAG4AYQBiAGwAZQBkACAAYQBuAGQAIAB0AGUAcwB0AGUAZAAgAHcAaQB0AGgAIABJ
AFcANAAxADYALgANAAoANQAuACAAVABoAGkAcwAgAGYAZQBhAHQAdQByAGUAIABpAHMAIABkAGkA
cwBhAGIAbABlAGQAIABmAG8AcgAgAG8AdABoAGUAcgAgAGMAaABpAHAAcwAuAA0ACgANAAoAUwBp
AGcAbgBlAGQALQBvAGYAZgAtAGIAeQA6ACAARABhAHYAaQBkACAATABpAG4AIAA8AHkAdQAtAGgA
YQBvAC4AbABpAG4AQABuAHgAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAAUhQAAAAAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAAB4AAABhAGMAYwBlAHAAdABsAGEAbgBnAHUAYQBnAGUAAAAAAAEA
AAAaAAAAegBoAC0AVABXACwAIABlAG4ALQBVAFMAAAAAAAMAAIAIIAYAAAAAAMAAAAAAAABGAQAA
ADIAAABFAHgAYwBoAGEAbgBnAGUAQQBwAHAAbABpAGMAYQB0AGkAbwBuAEYAbABhAGcAcwAAAAAA
IAAAAEgAAIAIIAYAAAAAAMAAAAAAAABGAQAAACIAAABOAGUAdAB3AG8AcgBrAE0AZQBzAHMAYQBn
AGUASQBkAAAAAADqSYv4ZPs9SXi1CNuZSwDsHwAAgBOP8kH0gxRBpYTu21prC/8BAAAAFgAAAEMA
bABpAGUAbgB0AEkAbgBmAG8AAAAAAAEAAAAqAAAAQwBsAGkAZQBuAHQAPQBNAFMARQB4AGMAaABh
AG4AZwBlAFIAUABDAAAAAAAfAPo/AQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8ANwABAAAA
dgAAAFsAUABBAFQAQwBIACAAdgAzAF0AIAB3AGkAZgBpADoAIABtAHcAaQBmAGkAZQB4ADoAIABh
AGQAZABlAGQAIABjAG8AZABlACAAdABvACAAcwB1AHAAcABvAHIAdAAgAGgAbwBzAHQAIABtAGwA
bQBlAC4AAAAAAB8APQABAAAAAgAAAAAAAAADADYAAAAAAAIBcQABAAAAFgAAAAHZyzPcid7B8fra
1EoRubA2z7bHwYYAAB8AcAABAAAAdgAAAFsAUABBAFQAQwBIACAAdgAzAF0AIAB3AGkAZgBpADoA
IABtAHcAaQBmAGkAZQB4ADoAIABhAGQAZABlAGQAIABjAG8AZABlACAAdABvACAAcwB1AHAAcABv
AHIAdAAgAGgAbwBzAHQAIABtAGwAbQBlAC4AAAAAAB8ANRABAAAAogAAADwARABVADAAUABSADAA
NABNAEIAOQA2ADMANgAwADcAQQBEAEIARgBDADQAOQBDADcAQQBCADcAMQAzADAAOQAyAEQARAAx
ADEAMwBBAEAARABVADAAUABSADAANABNAEIAOQA2ADMANgAuAGUAdQByAHAAcgBkADAANAAuAHAA
cgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0APgAAAAAAAwDeP59OAAADABMSAAAAAAIBAIAT
j/JB9IMUQaWE7ttaawv/AQAAAC4AAABIAGUAYQBkAGUAcgBCAG8AZAB5AEYAcgBhAGcAbQBlAG4A
dABMAGkAcwB0AAAAAAABAAAAIgAAAAEACgAAAAQAAAAAAAAAFAAAAAAAAAAAAAAA/////wAAAAAA
AAsAAIATj/JB9IMUQaWE7ttaawv/AQAAABwAAABIAGEAcwBRAHUAbwB0AGUAZABUAGUAeAB0AAAA
AAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAACgAAABJAHMAUQB1AG8AdABlAGQAVABlAHgAdABD
AGgAYQBuAGcAZQBkAAAAAAAAAEAABzDDYovdM8vZAQIBCwABAAAAEAAAAKc4AhGfV8RGmwuXds4U
UL4DACYAAAAAAAsABgwAAAAAAgEQMAEAAABGAAAAAAAAAMilJbGII5JKg6pkkAqkqyoHAE8+IND8
Jt1ErmEHWjoK3ScAAAAAAQsAAE8+IND8Jt1ErmEHWjoK3ScAAiEalOoAAAAAAgETMAEAAAAQAAAA
3sHx+trUShG5sDbPtsfBhgIBFDABAAAADAAAAHYJAAC3JEi9MQAAAAMAWzMBAAAAAwBaNgAAAAAD
AGg2DQAAAAsA+jYBAAAAHwD4PwEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfACJAAQAAAAYA
AABFAFgAAAAAAB8AI0ABAAAA/AAAAC8ATwA9AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBV
AD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0ASQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8A
VQBQACAAKABGAFkARABJAEIATwBIAEYAMgAzAFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQ
AEkARQBOAFQAUwAvAEMATgA9AEMAQgAwADQARgA2ADUAOQAxAEEARAA2ADQANAA2AEIAOABBAEEA
QgBDADkAQgA2ADUARABBAEUAOQAyADAANwAtAE4AWABGADUANwA2ADIANAAAAB8AJEABAAAABgAA
AEUAWAAAAAAAHwAlQAEAAAD8AAAALwBPAD0ARQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUA
PQBFAFgAQwBIAEEATgBHAEUAIABBAEQATQBJAE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBV
AFAAIAAoAEYAWQBEAEkAQgBPAEgARgAyADMAUwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAA
SQBFAE4AVABTAC8AQwBOAD0AQwBCADAANABGADYANQA5ADEAQQBEADYANAA0ADYAQgA4AEEAQQBC
AEMAOQBCADYANQBEAEEARQA5ADIAMAA3AC0ATgBYAEYANQA3ADYAMgA0AAAAHwAwQAEAAAAUAAAA
RABhAHYAaQBkACAATABpAG4AAAAfADFAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AOEAB
AAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA5QAEAAAAUAAAARABhAHYAaQBkACAATABpAG4A
AAADAFlAAAAAAAMAWkAAAAAAAwA3UAEAAAADAAlZAQAAAB8ACl0BAAAAJgAAAHkAdQAtAGgAYQBv
AC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAAtdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwA
aQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAAgEVXQEAAAASAAAAAtOhbmgrvG9MqSzZnFwwFjUBAAAC
ARZdAQAAABIAAAAC06FuaCu8b0ypLNmcXDAWNQEAAAMAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACQA
AABJAG4AZABlAHgAaQBuAGcARQByAHIAbwByAEMAbwBkAGUAAAAbAAAAHwAAgFDjYwvMnNARvNsA
gF/MzgQBAAAAKgAAAEkAbgBkAGUAeABpAG4AZwBFAHIAcgBvAHIATQBlAHMAcwBhAGcAZQAAAAAA
AQAAAHAAAABJAG4AZABlAHgAaQBuAGcAIABQAGUAbgBkAGkAbgBnACAAdwBoAGkAbABlACAAQgBp
AGcARgB1AG4AbgBlAGwAUABPAEkASQBzAFUAcABUAG8ARABhAHQAZQAgAGkAcwAgAGYAYQBsAHMA
ZQAuAAAACwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAJgAAAEkAcwBQAGUAcgBtAGEAbgBlAG4AdABG
AGEAaQBsAHUAcgBlAAAAAAAAAAAAHwAAgB+k6zOoei5Cvnt54amOVLMBAAAAOAAAAEMAbwBuAHYA
ZQByAHMAYQB0AGkAbwBuAEkAbgBkAGUAeABUAHIAYQBjAGsAaQBuAGcARQB4AAAAAQAAAC4BAABJ
AEkAPQBbAEMASQBEAD0AZgBhAGYAMQBjADEAZABlAC0AZAA0AGQAYQAtADEAMQA0AGEALQBiADkA
YgAwAC0AMwA2AGMAZgBiADYAYwA3AGMAMQA4ADYAOwBJAEQAWABIAEUAQQBEAD0ARAA5AEMAQgAz
ADMARABDADgAOQA7AEkARABYAEMATwBVAE4AVAA9ADEAXQA7AFQARgBSAD0ATgBvAHQARgBvAHIA
awBpAG4AZwA7AFYAZQByAHMAaQBvAG4APQBWAGUAcgBzAGkAbwBuACAAMQA1AC4AMgAwACAAKABC
AHUAaQBsAGQAIAA2ADYANQAyAC4AMAApACwAIABTAHQAYQBnAGUAPQBIADQAOwBVAFAAPQAxADAA
OwBEAFAAPQAxAEMAMQAAAAAAQAAAgAggBgAAAAAAwAAAAAAAAEYAAAAAv4UAAPC5itwzy9kBCwAA
gAggBgAAAAAAwAAAAAAAAEYAAAAAgoUAAAAAAAACAQCACCAGAAAAAADAAAAAAAAARgEAAAA2AAAA
SQBuAFQAcgBhAG4AcwBpAHQATQBlAHMAcwBhAGcAZQBDAG8AcgByAGUAbABhAHQAbwByAAAAAAAB
AAAAEAAAANVFKvfPrBRNrTcfXDb0GvoDAA00/T8AAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4A
AABhAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4ALQByAGUAcwB1AGwAdABzAAAAAAABAAAAsgAA
AGQAawBpAG0APQBuAG8AbgBlACAAKABtAGUAcwBzAGEAZwBlACAAbgBvAHQAIABzAGkAZwBuAGUA
ZAApACAAaABlAGEAZABlAHIALgBkAD0AbgBvAG4AZQA7AGQAbQBhAHIAYwA9AG4AbwBuAGUAIABh
AGMAdABpAG8AbgA9AG4AbwBuAGUAIABoAGUAYQBkAGUAcgAuAGYAcgBvAG0APQBuAHgAcAAuAGMA
bwBtADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACAAAAB4AC0AbQBzAC0AaABhAHMALQBh
AHQAdABhAGMAaAAAAAEAAAACAAAAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAAB4AC0A
bQBzAC0AcAB1AGIAbABpAGMAdAByAGEAZgBmAGkAYwB0AHkAcABlAAAAAAABAAAADAAAAEUAbQBh
AGkAbAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAADYAAAB4AC0AbQBzAC0AdAByAGEAZgBmAGkA
YwB0AHkAcABlAGQAaQBhAGcAbgBvAHMAdABpAGMAAAAAAAEAAABIAAAARABVADAAUABSADAANABN
AEIAOQA2ADMANgA6AEUARQBfAHwARwBWADEAUABSADAANABNAEIAOQAxADUAMAA6AEUARQBfAAAA
HwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAUAAAAHgALQBtAHMALQBvAGYAZgBpAGMAZQAzADYANQAt
AGYAaQBsAHQAZQByAGkAbgBnAC0AYwBvAHIAcgBlAGwAYQB0AGkAbwBuAC0AaQBkAAAAAQAAAEoA
AABmADgAOABiADQAOQBlAGEALQBmAGIANgA0AC0ANAA5ADMAZAAtADcAOABiADUALQAwADgAZABi
ADkAOQA0AGIAMAAwAGUAYwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBtAHMA
LQBlAHgAYwBoAGEAbgBnAGUALQBzAGUAbgBkAGUAcgBhAGQAYwBoAGUAYwBrAAAAAQAAAAQAAAAx
AAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOgAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUA
LQBhAG4AdABpAHMAcABhAG0ALQByAGUAbABhAHkAAAAAAAEAAAAEAAAAMAAAAB8AAICGAwIAAAAA
AMAAAAAAAABGAQAAACoAAAB4AC0AbQBpAGMAcgBvAHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0A
AAAAAAEAAAAOAAAAQgBDAEwAOgAwADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEQAAAB4
AC0AbQBpAGMAcgBvAHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0ALQBtAGUAcwBzAGEAZwBlAC0A
aQBuAGYAbwAAAAEAAAACBQAAbAA1ADUAMwBTAHMANwBoAHQAegA4AHEAawBBAEQAMgBaAFAAcwBm
AHkAbgBzAHEAVgBvAGYAUABhADMAYwBuAFQARQBRAFUARQBIAE0ATQBlAGcAYQBrAG4AbQBEAG0A
dQBlAEsAQQA2AFkAZAB0AFkAawBnAEMAUwB4AG4AdgA2ADYANQBhAGEARgBlAHkAcABLAGQAUABQ
AE8AVQAwAHgAeABWAFkARABpACsAVgBVADUASQBsAFkANQB4AGMAUABWAGYAYwBQAEQAbQA0AEUA
ZQBHAGQAdgBuAGsAZQBXAEwATgBWAG8AawB0AEoATABaADUAZgBYAFgAZQBFAGEANgBzAFkAaAA5
AGMAWgBBAEcAYQB6AFAAbgByAHIAUwBsAHgAUABnADQATABZAFMAegBBACsARABoAFQATAAzAHEA
NgAwAHoAaQBqAEQAUwBlAEsANwB4AGcAQQA4AGgARAA4AG4AYgBZAEoANAArAEgAKwBsAG0ANwBV
AFAAdABRAGwAcABhAHIAeQBRAC8AZgBnAFEAcwBsAGIAcQBFAFIAVQB0AGgAbgBSAHIAcQBtAGwA
agBxAGIASABaAHYAKwBHAFAATgBJAEUAUQAzAFYAOQBNAHMAUgB5AFgAbgBpAEgAawBpADIAUABK
AC8ARABPAC8AcwBFAFgANgBJAGcAYQB5AEgAcwBVAEEATgBFAC8AYQA4ADIAOABRAEgAQQArAGIA
WQAwADIAUQBHAEoAYgBUAHAARQBlAHoAcwBJAGwAUQAyAHcAUwAxAHcAcgBaADAAVwBTAHYAYQBD
AFMAMQA1AEsAUAA1AGIANAB1AHMAQQB3AFkAeABTAE8AdQBHAFEANgBKAGYAagBDADgAUgBRADYA
TgBoADQAQgBPAFMAQwAzAEoAagBDAGQAYwA3ADEAeABFAC8AVgArAHQAVABlADIAKwA3AGwAYQBQ
AFcAWgB5AEgANwBQAGoAbQB3AEUASQBzAGkAcABmAGQAMABPAFMAOABoAE4AMQBQAHcAagA2ADYA
QQB1AEoARAA5AGkANABGAEoATAB0AGgAQwA1AGkAbQA3AHkAUwBLAEUAUwBtAGEAaABnAC8ALwA1
AFoAVgBsAEUAUwBjAGMAYQByADYAWQBjADAARQB1AEQAWQA3AGwAawA4AFQAQgBwAHkAZQA0AHYA
TQA3AGYAWAAwAGYAYQBPAE4AcwBBAGwAZABkAHEAZQBXAFkATwB2AFcAZQBxAE8ASAAvAE0ANwBn
AFMARgBMAE0ARgBxAE8AZwBpAFkATwA1AFIARABHAHgAUQA3AGEAVgBwAE0AeABxAHMAZgBsADgA
UQB5AHIAKwBrAGoAUgB0AHQAbABSAFQAQgBmAFoAegBvAEkAUwAxADYAQQB5AFMAaAAyADcAMgBR
AC8AVQB3ADkAMwBEAEYATQA0AHYAUgBHAGkASwAwADAAbgBtAEQAagBnAG0ARgA5ADAAdQBPAGUA
LwByAEkAWAA0ADUASQArADYAUwBLAEgAbgBCAHIAKwAxAHkARwBtAGsAWgBxAHIATgBWADcARwBU
AGkAWgBvAFoAYwBPAFQAMgBIAHYARABtAEMAcwA5AHkAcABjAHgAUABNADIAaQBJAHMANgByAGcA
OAB6AEUAUgBVAGUALwA2AHgAYwBYACsAOQAvAEsAbQBXADIAVQBUAFMAaAAAAAAAHwAAgIYDAgAA
AAAAwAAAAAAAAEYBAAAAOAAAAHgALQBmAG8AcgBlAGYAcgBvAG4AdAAtAGEAbgB0AGkAcwBwAGEA
bQAtAHIAZQBwAG8AcgB0AAAAAQAAAHIEAABDAEkAUAA6ADIANQA1AC4AMgA1ADUALgAyADUANQAu
ADIANQA1ADsAQwBUAFIAWQA6ADsATABBAE4ARwA6AGUAbgA7AFMAQwBMADoAMQA7AFMAUgBWADoA
OwBJAFAAVgA6AE4ATABJADsAUwBGAFYAOgBOAFMAUABNADsASAA6AEQAVQAwAFAAUgAwADQATQBC
ADkANgAzADYALgBlAHUAcgBwAHIAZAAwADQALgBwAHIAbwBkAC4AbwB1AHQAbABvAG8AawAuAGMA
bwBtADsAUABUAFIAOgA7AEMAQQBUADoATgBPAE4ARQA7AFMARgBTADoAKAAxADMAMgAzADAAMAAy
ADgAKQAoADQANgAzADYAMAAwADkAKQAoADMANgA2ADAAMAA0ACkAKAAxADMANgAwADAAMwApACgA
MwA3ADYAMAAwADIAKQAoADMAOQA2ADAAMAAzACkAKAAzADkAOAA2ADAANAAwADAAMAAwADIAKQAo
ADMANAA2ADAAMAAyACkAKAA0ADUAMQAxADkAOQAwADIAMQApACgAMQA4ADAAMAA3ADkAOQAwADAA
NgApACgAMQA4ADYAMAAwADYAKQAoADYANgA4ADkAOQAwADIAMQApACgANQA1ADAAMQA2ADAAMAAz
ACkAKAA2ADYANAA3ADYAMAAwADcAKQAoADYANgA5ADQANgAwADAANwApACgANgA5ADEANgAwADAA
OQApACgANQA0ADkAMAA2ADAAMAAzACkAKAA2ADYANQA1ADYAMAAwADgAKQAoADcANgAxADEANgAw
ADAANgApACgANgA1ADAANgAwADAANwApACgANgA0ADcANQA2ADAAMAA4ACkAKAA2ADYANAA0ADYA
MAAwADgAKQAoADcAMQAyADAAMAA0ADAAMAAwADAAMQApACgANAA3ADgANgAwADAAMAAwADEAKQAo
ADMAMwA2ADUANgAwADAAMgApACgAOAAzADMAOAAwADQAMAAwADAAMAAxACkAKAA0ADEAMwAwADAA
NwAwADAAMAAwADEAKQAoADMAMQA2ADAAMAAyACkAKAA0ADMAMgA2ADAAMAA4ACkAKAA5ADYAOAA2
ADAAMAAzACkAKAA3ADYAOQA2ADAAMAA1ACkAKAAyADkAMAA2ADAAMAAyACkAKAAzADAAOAA2ADQA
MAAwADMAKQAoADgAOQAzADYAMAAwADIAKQAoADgANgA3ADYAMAAwADIAKQAoADgANgAzADYAMgAw
ADAAMQApACgAMwA4ADEAMAAwADcAMAAwADAAMAAyACkAKAA1ADIANQAzADYAMAAxADQAKQAoADUA
NgA2ADAAMwAwADAAMAAwADIAKQAoADEAMgAyADAAMAAwADAAMAAxACkAKAAzADgAMAA3ADAANwAw
ADAAMAAwADUAKQAoADUANQA5ADAAMAAxACkAKAA1ADcAOQAwADAANAApADsARABJAFIAOgBPAFUA
VAA7AFMARgBQADoAMQAxADAAMQA7AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABcAAAAeAAt
AG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUA
ZABhAHQAYQAtAGMAaAB1AG4AawBjAG8AdQBuAHQAAAABAAAABAAAADEAAAAfAACAhgMCAAAAAADA
AAAAAAAARgEAAABKAAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEA
bQAtAG0AZQBzAHMAYQBnAGUAZABhAHQAYQAtADAAAAAAAAEAAAAyDAAAZgAyAFMAbgBCAGQAVABX
AHUAcwBnAGMAcQBxAGQARwBsAG4ANwBWAFAAaAA5AEYAcAA1AG8AQgBBAEQATABzADgAWABuAHkA
MQBzAGsATQA1AFQANgBoAFIAbwBUADYAegBXAGoAVgBSAGIAWAA4ADcANgArAHIARgBSAHEAWABw
AFUATwBzAHgAeABPADcAcgBhAGcALwA0AEoAUgBJAG0AaQBkAFMAbgA5AHcAQwBEAEcASgBmAE4A
TAB6AGcAUgBRAFkANgBtAE0AbwA0AGcAZgA5AG0AUwBPAG0AVgBsAGcALwBnAGMARwBXAFMAZQBO
ADcAZQAyAEEAeABhAFIAeQBDAGQARgB4AHIAdgB2AE8ANwBUADIAKwBkAG8AUABjAFUAcQBmAEcA
NQAyAHEAaABOAFgATQBEAEsAZwBEAFgANQBkAC8AOQBjADQAMAB3AEoAagBmAFkAVQBKAEMAMQBq
AG8ARgBhAFIARgBJAGcAaABOAHUANABvAFAASQBMADQARQAwAGoAaAA5AFoAWAB3AHIATABoAFgA
VgA4AHAAUQBzAFcAeQAxAGkATwAxAEYANgAwADEAdgBBAHUAYgB5AC8AOQA3AFAAcQAzACsAawBy
AFQAVQAxAEgAVgBYADcASABlAGMALwBvADMASgBxADgALwBGADAAcgArAEEAVAA4AGoANAA4ADkA
OABqAEQAdgBFAFMARgBkAGkAVwBZAHEARgA2AEwAWgBLADEAWgB1AFMASQA0AGoAcQA5AG4AWgAw
AG4ARgBCAEwAMwByAFYANQB5AEUANgBVAEQAOAB5AGQAMwBWAGoAdQBtAGYAWgBtAGwAMQBFAHgA
MAA1AEoAUQA4AFoAaQA2AGkAQgAxADUAYwAwAEcAOABaAEEAawB0AEYANwBUAFAARwB0AHEALwBr
AGgAMwBUAGcARAA0AGoAbQBpAHEAcABDAFUAbgBuAGkARwAxAEMAdwBzAGoAWQBQAHQAYgBnAFQA
TgBvAGMAUgBYAHkAdgB5AHMAOQBBAGgAcQBjAHAAUwBqAGoASQBhAGYAaQBvAFYAOQA0AFEAcAAx
ADcAbwBIAHAAZAAxAGEAUAAxAEcAdAByAG8AVABZAGsATwBsAHMAZgBUADYAQgAxAEsANABZAGcA
LwBnAFcAWQBxAFMARQByAC8AWgBDAE8ATAA4AEoAUwBMAEsAbwBNAHQASwBGAFEANABhAE4ANwBH
AG4ARwBkAHoAUwBtAGgAVQBOAHAALwBlADMAVgBGAEEAZwBmAFQAUgBvAEIAMgA4AEcATgBaAEoA
NgB1AFkAMgBhAFcAMgA4AGgAVABwAHEAagBCADkARQBuAEUASQB6AEIAWAA3AE4ANABCAFUASgBY
AE0AQwBOAFoAQQA0AGIAYgBEAE0ASQAzAEgAVgBCAFQAQgAyAEgATwBlAGYAZABoADYAUwBBAGYA
UgBXAE4AUQBHAHQAMwBnADUARgBPAEsAOQBiADAANwBzACsATgArADMAbwBLAHAASwBpAEMAVAB5
AHIAVwBNADgAbAB3AEEATAB1ADIAMgB2ADEAdQAyAEIAUgBNADgAYwBGAGcAdABlAEYAdgBBADMA
QwBFAHUAZABxAHAARwBtAE0AcAAwAG8AQgBZAEQAMgBoAFUAbAAyAEsAdQBvAG0ASABZAEoAQQBr
AGMAeQB5ADIAbwBjAHEARABCAG4ASQB2AFUAVQA1ADYARwBlAGEAegBVAGQAZwBZAGsAcwA3AFIA
MQBtAG4AOABZAHcAbgBiAHEAYgBJAFQAeQBoADcAVABVAFoAUQA3ADYAKwBTAGEARABjADcARwBV
AHoASABJAFoAQQBJAGkAUAAzAEUARABQAFIAQQBJAE8AdQBoAHcAUgBIAGwAawBLAG0AegBDAHYA
VwBjAGsAOABQADYAaQBlAFQAMQBGADgAZQBTADEATABjAEYAbwBPADEAbAA5AFgARgAwAFEAZABq
AEMAcABGAGoAdwBZAGgASAAyAEEAeAB3AGQAZABDAFgASwBVADUAQwBOAE8AVgBtADMAVwBYADkA
bAB0ADgAUwBiAG4AbgBvAE4AOQBvAHUANwBmAHIAWAB0AFQAUgBGAFMARwBoADYARABkACsANQBj
ADcAOQBtAGQAOABIAG0AOQBGAFYAdgAvAFAAQwBiAEsAKwA5AFkAWQB5AFcAaQBlAFoAbgBqAGcA
WABWAGEAUAArADMANQByADcAdQB2AGkAMwBoAFEAOQBhAGoAMQA4AHIATQBEAEoAUQBwAHoAbQBM
AHAAaABnACsAOQBUAHcARgAyACsANwBzAGQAVQBDAHUAZAB5AHMAOQBRAHEASQBrAEgATwBUAGkA
dQArAHUAZQBUAGcAWgBjAC8ALwB1AEYAaABaAEcAdQBuAHgAVQBmAFMAKwBOAEwAdgBZAFYAQgBM
AFUASgA3AHYAVAB0AGsASABuAEEAawBDAGEASQBDAEYAbgBMAGgAcQBjADEAOAA2AEgAKwBNAG8A
YgB2AFgAZgBtADkAawBpAHcAZABGAFgAQwBoAG4AWQBZAGoAbwBnAHYAQgB2AFkAQQBDADYALwBZ
AC8AcwBqADIAWQAyADcAVgAzADkAZAB1ADAAWgBhAFQALwBUAEYAVwB4ADMAcgB5ACsAOQBJAFUA
SABLADAAeQBkAGYAbwBNAHIAUQBFAHQAZgBsAEcAcwB0ADIAMABJAEwAZgA5AEIASgBrAGEARQBW
ADkAZwBhAHcAZQAzAHgAeAA3AGwAOQBmADEAZQB5AEQAcQBRAGIAbwBEAGcAdwBpAEkAbgBhAHcA
ZABvAEQAYQB6ADIAYQAvADIAWABFAEQAZABtAFcAZgBtAHoAdwBZAGkAbQBUAGQAdwAxAGEAdABI
ADIASgB5AEUAagArAG0AaAB2AFMAMABrAFMAQgBUAEwAMgBjAEMAUgByAEkATQBYAHkATABSAHoA
ZQB3AHgAeQB4ADEAUQBBAEYANQBOAGIAcwBaAGMAUwBZADcASQBXAEkAWQAwAEIASwBOAFMAWABo
AGcAYgBWAEYATgA5ADgANwA5ADQASAB4AFAARgByAHcASgA4AEgAdgBaAE4AVAB5AEQAcQAyAHEA
UQBoADMAQgA1AHUATgBhADIATwArAGkAegByAGoARgBYAHUAYgB0AFQAWABCAEcAQwBnAEUALwBL
AFYAZwBOAHcAWQA4ADIAQgBNAGcAWQBYADQAVABnAGMASwBxAGYATwA1ADYAbQB3AHUATgBkAG8A
TQBUADUAbwBZAG8AdgBBAFgAVwBxAE8AVwBLAHMAKwBJAGUATgA4AGcAMwBlAHcAawBRADkAUwBT
AHcAbwBTAGcAYwBWAEYAUQBrAFQAZABNAEIARABSAHoALwBGAG8AZABFAEsASABVAGkAOABSAFUA
NgBwAEoAeABRAEEAMgB3AGsARwBMAC8AOABQAEUAaAArAFkAMQA2AHIAbwBpAFgARQBnAG0AVwB0
ADcAcABDAG8ASQAzAHEAcwB4ACsAMgBKADcAUwB3AFoAWQB2AFIAagB1ADAANQA1AEsAcwBxAE0A
MwBGAGoAUABVADQANQBPAE0ANwBOAE0AVgB3AFcAMgByAEMAOABQAHUAcQBkAGQAdABnAEsAVQB3
AFgAVwBoAHEAdABhAEQAcgBQAEkAegBYAG4AMwBlAHkATwAyAHIAOABWAFcAcABlAHgAMgBhAHEA
bgBPAHIAVAA1AEEAawA1AEsAVwBjAHMAcgBjAGIAYwBtADUAZgBIADcASwB2AE8AUQAvAGwALwBI
AGoARwAzAGgAdQBFAEUATgA2AHMAcQB1AHAAVwBFAFUAYQBaAGQAUwBsAHEAMgBuAEkAcgAwAGgA
eQBaAGoARQBmAE8ATgBRAGcAMABkAE4AWABRAEIAQgA1AHcARwB4AHUANQBnAG0ASABJAE4AeQAv
AG4AYwAwAEcAMQBHADAATAB3AEEAYwBqAEEARgBPAEoAYwBVAHAAMgBKAGgAQwBZADIAWABTAEMA
SwBhADkAVABwAHoAMwBpAFYAZQBLAFgAdgBUAEIANwBnAFIATgAyAGIAWgAzAGQAYgArAHoASgBD
AEIAMQA2ADUAVQA5AEwASQBlAHMAQQA9AD0AAAAAAIfI

--_000_DU0PR04MB963607ADBFC49C7AB713092DD113ADU0PR04MB9636eurp_--
