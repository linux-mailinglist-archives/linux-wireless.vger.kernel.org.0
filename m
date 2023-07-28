Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1F766409
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjG1GTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 02:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjG1GTO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 02:19:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160663C03
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 23:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlXh6zahtmoFJ/r7gu+sYu/TrZzgjpRnx697dlqZ13mfKZ1BOlJZh5gGH6QEa9+vezJBwj8U/xUoderdz2lUmMZ3k/QNxXkaBLoOkYQNudE9o79+O25oKs4IjjioQ/dVybPdeYIfpBhqtIMV3FIDaXv+zDCHc4M5/kj3tqWnDs9zv+NJz4O54heGQBTW5pQkhemp+79as2tk6qzMw7DbY5yFXB/EGSnZ1miSts7fV4mo2RHKHlNeNO/TzUaOpJDJtle8oQjKHKsWBeebPx2Oo7XfG/xmeCZpgVk6faZ3eT0lenjn1mWeSnf+rJGlVYJRXVMxZkpm4YTLcJowE1apwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDFctxYQjnCtgsJr2xBHKGzNrLkxn0thB7DQuKW/fDw=;
 b=eg8dibJ+4SmaQ8InYuU1GqhD9OVkz9E8QG8Rz11wXTRoxwaKG9plkENVxe+n/Azh++yQTo6t1SPgLCjKcxNu4HprtObr/bjVlWV6oeqGLEtS1asDpOhkGW2GN9j7zKbqHWQyQKNImmXu06F7eUOjp5l+DUw4xYX+1nNYvmAAiY8ZG3ema2KwC6CmdO2xbQVSF7sqpkczHW4CD11gAAc9Njf8Y6LNoVdxWUIQkIfIPOzQl2mQYhFBX8YfnjTnI8SNS3OoY+wg1ePtbwoMGRyNX5IDudONC59yfX32AaIVpIURTCmvYTWhU9Xs6MJRyYa+qtvbeVUzPRWv/ptN3O73ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDFctxYQjnCtgsJr2xBHKGzNrLkxn0thB7DQuKW/fDw=;
 b=qzxyj8StOJi9l5VrVQyL3YL04BTRBd/weeYCrgEfcri8GRAFxq9EOSf8KDS0IDamQVb4+W8kj6D8ScG3he+Snc0T5+OKJ2VjIpN/rmyHCNQ3hZTPN7Fdp70t1rKCd5DGeUr+/ukfKHgDp8IdaiJpFIoDg5kMQ1MYOQSjrD7U8TY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:18:09 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 06:18:09 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB9638100B3F21D083F386C6D9D106APA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [PATCH] wifi: mwifiex: added code to support host mlme.
Thread-Index: AdnBG0VbUku3Gob0RoOlmlRWbISqeA==
Date:   Fri, 28 Jul 2023 06:18:09 +0000
Message-ID: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB9PR04MB8480:EE_
x-ms-office365-filtering-correlation-id: 6a299d11-4a48-4431-b663-08db8f3269f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qFmLphKrC47cMyjIygVeSmEfB8ESqZkyakthCzUQGNmxY6yc7b2nkzIt37YUfHfmF3IJs+u3nlnzXeikHYKzbMDjMYbRSGSGTwaGpSIXWdXRfUYUj1p3Xc+f8hqr5UCI4oLYsSkHiV+jkeUhfGkXtZhyerUnJAecPnYf8+OOUA1SeLo2f3yDkJ/wMhW1o6cjMTKZPcSrG8vu13G8f+eJK+oBQjlimBjDXSxrQ5Jnc42jEPJ66FJf+myS5YimimWbkrnhrMAh3ke+/sBbtR952O89Oy58aZ0MIJr2bXu1HP2Xl33T92r1VycYOIH200tT6eh37hpdKTPpNdqRIEBlTvuF+px1VBuaUnJfc5222DiZJOgkrkcYsL41lW5XyHVtim3EL988C3PSmJDXUftlFSEWR9CARk3LKSkyBMkDfAfa8Wa5yQ/qPJMcKPZQ64I7YP7VWkW+Pd+uUgb//awqZL1O9ENVstKzWuvunmGAaH43rlu/FH8MPItLnKtzsgYN/7YL82k16DjZ/kYcAumVMqSvS0xplZtTM4ARhREKskwD9ZBOtDA5oGGugZfioAS4f3sK6a7+4aM2bL6YaaUOuILEkAg3TTue3wKBk31b/PI6GCiuPLP2R2NeXuDeBrb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(316002)(6506007)(8936002)(26005)(41300700001)(66899021)(8676002)(55016003)(33656002)(54906003)(6916009)(122000001)(66446008)(64756008)(76116006)(66556008)(478600001)(4326008)(66476007)(9686003)(66946007)(7696005)(71200400001)(38100700002)(30864003)(2906002)(38070700005)(83380400001)(86362001)(52536014)(186003)(5660300002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?khxSr7aHsdX6cqvYQ3IlVA36UcER+4Vs/VS4N3In2fSt3KfsfschVGjQsqd+?=
 =?us-ascii?Q?Ic715OhdUi+EJoEvcTnzyIPwWB8kOBcAVN+p/T+qLBKkNrpuR7gYcuEX54N8?=
 =?us-ascii?Q?Q9ctS+Xmk/RZjvCPbaulHhKKnwmBipcBXLcS8IIIzUvNB9zQpYAka5kfj3vm?=
 =?us-ascii?Q?M6bl7UHmuv+jJeNmfTrSBJDSNYHHbkkI3lr6RIsCrqA0BnKw7Ma6SJ1Z/tsA?=
 =?us-ascii?Q?viicUTBedQAG4C245IEwOLDAJcrFFxMjXekOTR61z6ENFaxsQd7U010jGh0c?=
 =?us-ascii?Q?WajnxWVvRfn1GUvGaeogOiiVwyq/HcCg+VM56QGwgojU6+BZBZ/KSTbWr63R?=
 =?us-ascii?Q?6QsJvBKX8tzEXA/PWvtqernfMDzEqCVX4h4ngUChefbgZje+yssdgTvWBH0/?=
 =?us-ascii?Q?1bwHb8mLIkajNe2faVWWIGnV7l3hw+/RDcyj6EbnM3dVs/LrwqYeaRtQscV4?=
 =?us-ascii?Q?KHBEyWvjmCajZwmsVSzuMYusQByV4aWmB5TqN1HAEEMb+3ZjxdWkB/nADfP/?=
 =?us-ascii?Q?rmRxfgeM2WkCZOhEZ4DnsTBGFvLOIhnJsWoo6V8kXl4vOfRc/nl21HEc1/jC?=
 =?us-ascii?Q?Km0CHS/OwuXUGLlsNzX/QMtQZtk3qXHqGYMR8GchuxuZ9V7ya5E05PkczR2l?=
 =?us-ascii?Q?tX7u/htoUdmd8M264+T5nktY1bGyM0END7IhCMKDnc7MBGShGEKsudd4KZWY?=
 =?us-ascii?Q?BcZWAuzljDIdEAaEl4egx79WJIGC62ykZ8iL8OIVa6jayeFsPUwoCKJFX4AU?=
 =?us-ascii?Q?nvuFyn584ddOoS1ksWrPHBUwQskHikmNEOYkUrzsmFlJ6RMJWV3naKCdxGHQ?=
 =?us-ascii?Q?6F8JluK3gkg7Z4WLYt2FbLz9tK/boe1FaPsquI3APrfXf7xaQPsReN4Jb+5Y?=
 =?us-ascii?Q?aC4G00tW8FNEFQkDqsjPEQH8hk8PBa+DlePW6NJwIG8Necvqem4SAB7MFPeb?=
 =?us-ascii?Q?Yj/XmXiKb+3YgtoYPi2/9yjyh+JUmbeziGZOzP4+INKXVJUXvaW5URFefXUh?=
 =?us-ascii?Q?akb12DpiBsbPDRZy2OhrwDDwL7pbanO8jpElnLpn88N0xBZXDZ/olXwtOgQC?=
 =?us-ascii?Q?knsCZjcrdT1IGtCGacB1H0P0QXwqGSIS6E7VR/l7+lR0p120c7LsJd6zKd14?=
 =?us-ascii?Q?lZbGxTnoJtcltkD8VmHKgiM8bhPWm2wzujSEwo+JVN8I/ukTZjRY/QAvW/UO?=
 =?us-ascii?Q?holev87oDxM74e4Sutj79BGxZ1lQHnRq7ERWRo5t6T4YChwapwuCiEGO29bB?=
 =?us-ascii?Q?HVc+cVCPSR3prtRBMOAmkvC12ey0/r5c122xNFIpwD4Fd/widHqU0XjrvQD4?=
 =?us-ascii?Q?/2ar2wB2lcpF9WuYNGEJT+IA5AWsdPFS+eKlSbOiy8GzvTCkWw/9+roxfnRi?=
 =?us-ascii?Q?Y7hkJSwCng6ve4H4IdOo6rTpbEvJCsC2Nd3ZTkm5rOBO0hzUY6rhq2IsUktO?=
 =?us-ascii?Q?yQNn1UM+nNy3wap2ToIZNBKAHqT83nspCGKtfSo0nNuin7Vk19tGYTMEEPfN?=
 =?us-ascii?Q?TO/BsSYkBHVkaMe5UqGb2MzvngSD00FsJsb2Sowez+1UK6geaD4m9eGFsC/2?=
 =?us-ascii?Q?clzgbz0UoVvhVrU1RFaKa3ipx3WXuImjxXBtA3xb?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a299d11-4a48-4431-b663-08db8f3269f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 06:18:09.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H9pzCR06A1HlaC73QFKKRQK7AWEGgYA6nleyDjdsMAKoScVB0eFeoeMyOQxvIVgqy/4zzeRbpRrro3tukrwUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_000_PA4PR04MB9638100B3F21D083F386C6D9D106APA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

1. For station mode first.
2. This feature is a must for WPA3.
3. The code is tested with IW416. There is no guarantee for other chips.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 327 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
 drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  65 +++-
 drivers/net/wireless/marvell/mwifiex/main.c   |   4 +
 drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  17 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   1 +
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    |  25 ++
 drivers/net/wireless/marvell/mwifiex/util.c   |  74 ++++
 14 files changed, 558 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index 813d1cbebe19..619c1746ce67 100644
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
+	if (host_mlme) {
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
@@ -4424,7 +4748,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter =
*adapter)
=20
 	wiphy->features |=3D NL80211_FEATURE_INACTIVITY_TIMER |
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
-			   NL80211_FEATURE_NEED_OBSS_SCAN;
+			   NL80211_FEATURE_NEED_OBSS_SCAN |
+			   NL80211_FEATURE_SAE;
=20
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->features |=3D NL80211_FEATURE_HT_IBSS;
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
index f2168fac95ed..e2827e25ec38 100644
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
+	u8 pwe[1];
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
index a6e254a1185c..56bb1a1146d9 100644
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
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe));
+			sae_pwe_tlv->pwe[0] =3D bss_desc->bcn_rsnx_ie->data[0];
+			pos +=3D sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe);
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
+	if (host_mlme) {
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
+	if (host_mlme) {
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
+	if (host_mlme) {
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
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wire=
less/marvell/mwifiex/main.c
index 1cd9d20cca16..39bf4fd13899 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -28,6 +28,10 @@ module_param(driver_mode, ushort, 0);
 MODULE_PARM_DESC(driver_mode,
 		 "station=3D0x1(default), ap-sta=3D0x3, station-p2p=3D0x5, ap-sta-p2p=3D=
0x7");
=20
+bool host_mlme;
+module_param(host_mlme, bool, 0);
+MODULE_PARM_DESC(host_mlme, "Host MLME support enable:1, disable:0");
+
 bool mfg_mode;
 module_param(mfg_mode, bool, 0);
 MODULE_PARM_DESC(mfg_mode, "manufacturing mode enable:1, disable:0");
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wire=
less/marvell/mwifiex/main.h
index b95886e1413e..b88761b170a1 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -49,6 +49,7 @@
 #include "sdio.h"
=20
 extern const char driver_version[];
+extern bool host_mlme;
 extern bool mfg_mode;
 extern bool aggr_ctrl;
=20
@@ -384,6 +385,7 @@ struct ieee_types_aid {
=20
 struct mwifiex_bssdescriptor {
 	u8 mac_address[ETH_ALEN];
+	struct cfg80211_bss *bss;
 	struct cfg80211_ssid ssid;
 	u32 privacy;
 	s32 rssi;
@@ -426,6 +428,8 @@ struct mwifiex_bssdescriptor {
 	u16 wpa_offset;
 	struct ieee_types_generic *bcn_rsn_ie;
 	u16 rsn_offset;
+	struct ieee_types_generic *bcn_rsnx_ie;
+	u16 rsnx_offset;
 	struct ieee_types_generic *bcn_wapi_ie;
 	u16 wapi_offset;
 	u8 *beacon_buf;
@@ -536,6 +540,8 @@ struct mwifiex_private {
 	u8 bss_priority;
 	u8 bss_num;
 	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
 	u8 frame_type;
 	u8 curr_addr[ETH_ALEN];
 	u8 media_connected;
@@ -658,6 +664,7 @@ struct mwifiex_private {
 	u16 gen_idx;
 	u8 ap_11n_enabled;
 	u8 ap_11ac_enabled;
+	bool host_mlme_reg;
 	u32 mgmt_frame_mask;
 	struct mwifiex_roc_cfg roc_cfg;
 	bool scan_aborting;
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
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net=
/wireless/marvell/mwifiex/sta_event.c
index df9cdd10a494..51009f20e942 100644
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
@@ -999,10 +1002,16 @@ int mwifiex_process_sta_event(struct mwifiex_private=
 *priv)
 	case EVENT_REMAIN_ON_CHAN_EXPIRED:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: Remain on channel expired\n");
-		cfg80211_remain_on_channel_expired(&priv->wdev,
-						   priv->roc_cfg.cookie,
-						   &priv->roc_cfg.chan,
-						   GFP_ATOMIC);
+
+		if (host_mlme && (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
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
index a2ad2b53f016..2bea5bc627f1 100644
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
index e78a201cd150..f0ac8f144198 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -743,6 +743,28 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command =
*cmd, u16 cmd_action,
 	return 0;
 }
=20
+/* This function prepares AP start up command with or without host MLME
+ */
+static int mwifiex_cmd_uap_bss_start(struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+
+	cmd->command =3D cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	cmd->size =3D S_DS_GEN;
+
+	if (host_mlme) {
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
@@ -777,6 +799,9 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *pri=
v, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		if (mwifiex_cmd_uap_bss_start(cmd))
+			return -1;
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wire=
less/marvell/mwifiex/util.c
index 94c2d219835d..79b4f666a9b4 100644
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
@@ -405,6 +445,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *pri=
v,
 					      pkt_len, rx_pd))
 			return -1;
 	}
+
 	/* Remove address4 */
 	memmove(skb->data + sizeof(struct ieee80211_hdr_3addr),
 		skb->data + sizeof(struct ieee80211_hdr),
@@ -413,6 +454,39 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *pr=
iv,
 	pkt_len -=3D ETH_ALEN + sizeof(pkt_len);
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


--_000_PA4PR04MB9638100B3F21D083F386C6D9D106APA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IocFAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEMyQ0Y5NzZD
RkQxNDI0NDU5RkEyMzEzMEIwRTg5NDcwACEHAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHBwAcAAYA
EgAJAAUANwEBIIADAA4AAADnBwcAHAAGABIACQAFADcBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABADgAAABbUEFUQ0hdIHdpZmk6IG13aWZpZXg6IGFkZGVkIGNvZGUgdG8g
c3VwcG9ydCBob3N0IG1sbWUuAGgTAQuAAQAhAAAAQzJDRjk3NkNGRDE0MjQ0NTlGQTIzMTMwQjBF
ODk0NzAAIQcBA5AGAARiAABaAAAAAgF/AAEAAABRAAAAPFBBNFBSMDRNQjk2MzgxMDBCM0YyMUQw
ODNGMzg2QzZEOUQxMDZBQFBBNFBSMDRNQjk2MzguZXVycHJkMDQucHJvZC5vdXRsb29rLmNvbT4A
AAAACwAfDgAAAAACAQkQAQAAACM0AAAfNAAAdZ8AAExaRnXSB3GRYQAKZmJpZAQAAGNjwHBnMTI1
MgD+A0PwdGV4dAH3AqQD4wIABGNoCsBzZXQwIO8HbQKDAFARTTIKgAa0AoCWfQqACMg7CWIxOQ7A
vwnDFnIKMhZxAoAVYioJsHMJ8ASQYXQFsg5QA2Bzom8BgCBFeBHBbhgwXQZSdgSQF7YCEHIAwHR9
CFBuGjEQIAXABaAbZGSaIANSIBAiF7JcdgiQ5HdrC4BkNR1TBPAHQA0XcDAKcRfyYmttawZzAZAA
ICBCTV9C4EVHSU59CvwB8QvwwDIgMS4gRgWxH2G0dGkCICAEYhxwaRHwUHQuXGwLgGUKgDLZIbBU
aAQAHHBlGIAIcOsZ4CQBYSKAdR9gHHAFsfBXUEEzIzYlwCPRGeB/BaAisSQBECAfYBxRA/B0gGgg
SVc0MTYmY8EkhG5vIGd1CsAAcHcQICLBBbFvJ9AbsiPwcEZzIzYjRVNpZxhQZAItGTBmLWJ5OiAs
RGEdYBxgTAuAIDxIeXUtEdBvLiNRQJBueHAuBaBtPiNFpi0u8CNFIC4voC8YULx0LwPwCXAecAQQ
LwDAeRohbGwwoAPwIuAQMC+AY2ZnODAyMSGgBGMgMlB8IDMyN+wgKzLuLxdkBRAaMTCQ6y/vMPtt
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
Ya9iuP+Op0ThnM1yz4lqab9qykT1f3ahJkBFcG4z/zBuv4Q9IE5DFzChwDOgSSiahXP2blcBmoVu
JID0HwWrcDwJ9VctLQZWMi4yNcwuMfDl8OV9fUlQBEAAHwBCAAEAAAAUAAAARABhAHYAaQBkACAA
TABpAG4AAAAfAGUAAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAA
AAAAHwBkAAEAAAAKAAAAUwBNAFQAUAAAAAAAAgFBAAEAAABcAAAAAAAAAIErH6S+oxAZnW4A3QEP
VAIAAACARABhAHYAaQBkACAATABpAG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBA
AG4AeABwAC4AYwBvAG0AAAAfAAJdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAA
LgBjAG8AbQAAAAAAHwDlXwEAAAAuAAAAcwBpAHAAOgB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4
AHAALgBjAG8AbQAAAAAAHwAaDAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAfAB8MAQAAACYA
AAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAAHwAeDAEAAAAKAAAAUwBN
AFQAUAAAAAAAAgEZDAEAAABcAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAACARABhAHYAaQBkACAA
TABpAG4AAABTAE0AVABQAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAf
AAFdAQAAACYAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAAAACwBAOgEA
AAAfABoAAQAAABIAAABJAFAATQAuAE4AbwB0AGUAAAAAAAMA8T8EBAAACwBAOgEAAAADAP0/5AQA
AAIBCzABAAAAEAAAAMLPl2z9FCRFn6IxMLDolHADABcAAQAAAEAAOQCApmFHG8HZAUAACDBEW21H
G8HZAQsAKQAAAAAAHwDZPwEAAAAAAgAAMQAuACAARgBvAHIAIABzAHQAYQB0AGkAbwBuACAAbQBv
AGQAZQAgAGYAaQByAHMAdAAuAA0ACgAyAC4AIABUAGgAaQBzACAAZgBlAGEAdAB1AHIAZQAgAGkA
cwAgAGEAIABtAHUAcwB0ACAAZgBvAHIAIABXAFAAQQAzAC4ADQAKADMALgAgAFQAaABlACAAYwBv
AGQAZQAgAGkAcwAgAHQAZQBzAHQAZQBkACAAdwBpAHQAaAAgAEkAVwA0ADEANgAuACAAVABoAGUA
cgBlACAAaQBzACAAbgBvACAAZwB1AGEAcgBhAG4AdABlAGUAIABmAG8AcgAgAG8AdABoAGUAcgAg
AGMAaABpAHAAcwAuAA0ACgANAAoAUwBpAGcAbgBlAGQALQBvAGYAZgAtAGIAeQA6ACAARABhAHYA
aQBkACAATABpAG4AIAA8AHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAD4ADQAK
AC0ALQAtAA0ACgAgAC4ALgAuAC8AbgBlAHQALwB3AGkAcgBlAGwAZQBzAHMALwBtAGEAcgB2AGUA
bABsAC8AbQB3AGkAZgBpAGUAeAAvAGMAZgBnADgAMAAyADEAMQAuAGMAIAAgACAAfAAgADMAMgA3
ACAAKwArACsAKwArACsAKwArACsAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAAUhQAAAAAAAB8A
AICGAwIAAAAAAMAAAAAAAABGAQAAAB4AAABhAGMAYwBlAHAAdABsAGEAbgBnAHUAYQBnAGUAAAAA
AAEAAAAaAAAAegBoAC0AVABXACwAIABlAG4ALQBVAFMAAAAAAAMAAIAIIAYAAAAAAMAAAAAAAABG
AQAAADIAAABFAHgAYwBoAGEAbgBnAGUAQQBwAHAAbABpAGMAYQB0AGkAbwBuAEYAbABhAGcAcwAA
AAAAIAAAAEgAAIAIIAYAAAAAAMAAAAAAAABGAQAAACIAAABOAGUAdAB3AG8AcgBrAE0AZQBzAHMA
YQBnAGUASQBkAAAAAAARnSlqSEoxRLZjCNuPMmnwHwAAgBOP8kH0gxRBpYTu21prC/8BAAAAFgAA
AEMAbABpAGUAbgB0AEkAbgBmAG8AAAAAAAEAAAAqAAAAQwBsAGkAZQBuAHQAPQBNAFMARQB4AGMA
aABhAG4AZwBlAFIAUABDAAAAAAAfAPo/AQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8ANwAB
AAAAcAAAAFsAUABBAFQAQwBIAF0AIAB3AGkAZgBpADoAIABtAHcAaQBmAGkAZQB4ADoAIABhAGQA
ZABlAGQAIABjAG8AZABlACAAdABvACAAcwB1AHAAcABvAHIAdAAgAGgAbwBzAHQAIABtAGwAbQBl
AC4AAAAfAD0AAQAAAAIAAAAAAAAAAwA2AAAAAAACAXEAAQAAABYAAAAB2cEbRVtSS7cahvRGg6Wa
VFZshKp4AAAfAHAAAQAAAHAAAABbAFAAQQBUAEMASABdACAAdwBpAGYAaQA6ACAAbQB3AGkAZgBp
AGUAeAA6ACAAYQBkAGQAZQBkACAAYwBvAGQAZQAgAHQAbwAgAHMAdQBwAHAAbwByAHQAIABoAG8A
cwB0ACAAbQBsAG0AZQAuAAAAHwA1EAEAAACiAAAAPABQAEEANABQAFIAMAA0AE0AQgA5ADYAMwA4
ADEAMAAwAEIAMwBGADIAMQBEADAAOAAzAEYAMwA4ADYAQwA2AEQAOQBEADEAMAA2AEEAQABQAEEA
NABQAFIAMAA0AE0AQgA5ADYAMwA4AC4AZQB1AHIAcAByAGQAMAA0AC4AcAByAG8AZAAuAG8AdQB0
AGwAbwBvAGsALgBjAG8AbQA+AAAAAAADAN4/n04AAAMAExIAAAAAAgEAgBOP8kH0gxRBpYTu21pr
C/8BAAAALgAAAEgAZQBhAGQAZQByAEIAbwBkAHkARgByAGEAZwBtAGUAbgB0AEwAaQBzAHQAAAAA
AAEAAAAiAAAAAQAKAAAABAAAAAAAAAAUAAAAAAAAAAAAAAD/////AAAAAAAACwAAgBOP8kH0gxRB
pYTu21prC/8BAAAAHAAAAEgAYQBzAFEAdQBvAHQAZQBkAFQAZQB4AHQAAAAAAAAACwAAgBOP8kH0
gxRBpYTu21prC/8BAAAAKAAAAEkAcwBRAHUAbwB0AGUAZABUAGUAeAB0AEMAaABhAG4AZwBlAGQA
AAAAAAAAQAAHMA9AwUYbwdkBAgELAAEAAAAQAAAAws+XbP0UJEWfojEwsOiUcAMAJgAAAAAACwAG
DAAAAAACARAwAQAAAEYAAAAAAAAAyKUlsYgjkkqDqmSQCqSrKgcATz4g0Pwm3USuYQdaOgrdJwAA
AAABCwAATz4g0Pwm3USuYQdaOgrdJwACIRqU4gAAAAACARMwAQAAABAAAABSS7cahvRGg6WaVFZs
hKp4AgEUMAEAAAAMAAAASAgAANZlKmsxAAAAAwBbMwEAAAADAFo2AAAAAAMAaDYNAAAACwD6NgEA
AAAfAPg/AQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AIkABAAAABgAAAEUAWAAAAAAAHwAj
QAEAAAD8AAAALwBPAD0ARQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUAPQBFAFgAQwBIAEEA
TgBHAEUAIABBAEQATQBJAE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBVAFAAIAAoAEYAWQBE
AEkAQgBPAEgARgAyADMAUwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAASQBFAE4AVABTAC8A
QwBOAD0AQwBCADAANABGADYANQA5ADEAQQBEADYANAA0ADYAQgA4AEEAQQBCAEMAOQBCADYANQBE
AEEARQA5ADIAMAA3AC0ATgBYAEYANQA3ADYAMgA0AAAAHwAkQAEAAAAGAAAARQBYAAAAAAAfACVA
AQAAAPwAAAAvAE8APQBFAFgAQwBIAEEATgBHAEUATABBAEIAUwAvAE8AVQA9AEUAWABDAEgAQQBO
AEcARQAgAEEARABNAEkATgBJAFMAVABSAEEAVABJAFYARQAgAEcAUgBPAFUAUAAgACgARgBZAEQA
SQBCAE8ASABGADIAMwBTAFAARABMAFQAKQAvAEMATgA9AFIARQBDAEkAUABJAEUATgBUAFMALwBD
AE4APQBDAEIAMAA0AEYANgA1ADkAMQBBAEQANgA0ADQANgBCADgAQQBBAEIAQwA5AEIANgA1AEQA
QQBFADkAMgAwADcALQBOAFgARgA1ADcANgAyADQAAAAfADBAAQAAABQAAABEAGEAdgBpAGQAIABM
AGkAbgAAAB8AMUABAAAAFAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA4QAEAAAAUAAAARABhAHYA
aQBkACAATABpAG4AAAAfADlAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAAMAWUAAAAAAAwBa
QAAAAAADADdQAQAAAAMACVkBAAAAHwAKXQEAAAAmAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4A
eABwAC4AYwBvAG0AAAAAAB8AC10BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAu
AGMAbwBtAAAAAAACARVdAQAAABIAAAAC06FuaCu8b0ypLNmcXDAWNQEAAAIBFl0BAAAAEgAAAALT
oW5oK7xvTKks2ZxcMBY1AQAAAwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAJAAAAEkAbgBkAGUAeABp
AG4AZwBFAHIAcgBvAHIAQwBvAGQAZQAAABsAAAAfAACAUONjC8yc0BG82wCAX8zOBAEAAAAqAAAA
SQBuAGQAZQB4AGkAbgBnAEUAcgByAG8AcgBNAGUAcwBzAGEAZwBlAAAAAAABAAAAcAAAAEkAbgBk
AGUAeABpAG4AZwAgAFAAZQBuAGQAaQBuAGcAIAB3AGgAaQBsAGUAIABCAGkAZwBGAHUAbgBuAGUA
bABQAE8ASQBJAHMAVQBwAFQAbwBEAGEAdABlACAAaQBzACAAZgBhAGwAcwBlAC4AAAALAACAUONj
C8yc0BG82wCAX8zOBAEAAAAmAAAASQBzAFAAZQByAG0AYQBuAGUAbgB0AEYAYQBpAGwAdQByAGUA
AAAAAAAAAAAfAACAH6TrM6h6LkK+e3nhqY5UswEAAAA4AAAAQwBvAG4AdgBlAHIAcwBhAHQAaQBv
AG4ASQBuAGQAZQB4AFQAcgBhAGMAawBpAG4AZwBFAHgAAAABAAAALgEAAEkASQA9AFsAQwBJAEQA
PQAxAGEAYgA3ADQAYgA1ADIALQBmADQAOAA2AC0AOAAzADQANgAtAGEANQA5AGEALQA1ADQANQA2
ADYAYwA4ADQAYQBhADcAOAA7AEkARABYAEgARQBBAEQAPQBEADkAQwAxADEAQgA0ADUANQBCADsA
SQBEAFgAQwBPAFUATgBUAD0AMQBdADsAVABGAFIAPQBOAG8AdABGAG8AcgBrAGkAbgBnADsAVgBl
AHIAcwBpAG8AbgA9AFYAZQByAHMAaQBvAG4AIAAxADUALgAyADAAIAAoAEIAdQBpAGwAZAAgADYA
NgAzADEALgAwACkALAAgAFMAdABhAGcAZQA9AEgANAA7AFUAUAA9ADEAMAA7AEQAUAA9ADEAQwAx
AAAAAABAAACACCAGAAAAAADAAAAAAAAARgAAAAC/hQAA0NVcRRvB2QELAACACCAGAAAAAADAAAAA
AAAARgAAAACChQAAAAAAAAIBAIAIIAYAAAAAAMAAAAAAAABGAQAAADYAAABJAG4AVAByAGEAbgBz
AGkAdABNAGUAcwBzAGEAZwBlAEMAbwByAHIAZQBsAGEAdABvAHIAAAAAAAEAAAAQAAAAj9Tn5VpU
L0SdWW6pI8DT+AMADTT9PwAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAALgAAAGEAdQB0AGgAZQBu
AHQAaQBjAGEAdABpAG8AbgAtAHIAZQBzAHUAbAB0AHMAAAAAAAEAAACyAAAAZABrAGkAbQA9AG4A
bwBuAGUAIAAoAG0AZQBzAHMAYQBnAGUAIABuAG8AdAAgAHMAaQBnAG4AZQBkACkAIABoAGUAYQBk
AGUAcgAuAGQAPQBuAG8AbgBlADsAZABtAGEAcgBjAD0AbgBvAG4AZQAgAGEAYwB0AGkAbwBuAD0A
bgBvAG4AZQAgAGgAZQBhAGQAZQByAC4AZgByAG8AbQA9AG4AeABwAC4AYwBvAG0AOwAAAAAAHwAA
gIYDAgAAAAAAwAAAAAAAAEYBAAAAIAAAAHgALQBtAHMALQBoAGEAcwAtAGEAdAB0AGEAYwBoAAAA
AQAAAAIAAAAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAALgAAAHgALQBtAHMALQBwAHUAYgBs
AGkAYwB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAAAAAAAEAAAAMAAAARQBtAGEAaQBsAAAAHwAAgIYD
AgAAAAAAwAAAAAAAAEYBAAAANgAAAHgALQBtAHMALQB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAZABp
AGEAZwBuAG8AcwB0AGkAYwAAAAAAAQAAAEgAAABQAEEANABQAFIAMAA0AE0AQgA5ADYAMwA4ADoA
RQBFAF8AfABEAEIAOQBQAFIAMAA0AE0AQgA4ADQAOAAwADoARQBFAF8AAAAfAACAhgMCAAAAAADA
AAAAAAAARgEAAABQAAAAeAAtAG0AcwAtAG8AZgBmAGkAYwBlADMANgA1AC0AZgBpAGwAdABlAHIA
aQBuAGcALQBjAG8AcgByAGUAbABhAHQAaQBvAG4ALQBpAGQAAAABAAAASgAAADYAYQAyADkAOQBk
ADEAMQAtADQAYQA0ADgALQA0ADQAMwAxAC0AYgA2ADYAMwAtADAAOABkAGIAOABmADMAMgA2ADkA
ZgAwAAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBu
AGcAZQAtAHMAZQBuAGQAZQByAGEAZABjAGgAZQBjAGsAAAABAAAABAAAADEAAAAfAACAhgMCAAAA
AADAAAAAAAAARgEAAAA6AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBw
AGEAbQAtAHIAZQBsAGEAeQAAAAAAAQAAAAQAAAAwAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAA
KgAAAHgALQBtAGkAYwByAG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEAbQAAAAAAAQAAAA4AAABC
AEMATAA6ADAAOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAARAAAAHgALQBtAGkAYwByAG8A
cwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUALQBpAG4AZgBvAAAAAQAA
AAIFAAA5AHEARgBtAEwAcABoAEsAcgBDADQANwBjAE0AeQBqAEkAeQBnAFYAZQBTAG0ARQBmAEIA
OABFAFMAcQBaAGsAeQBhAGsAdABoAEMAegBVAFEARwBOAG0AeABZADYAeQBjADcAYgAyAG4AawB6
AEkAdAAzADcAWQBVAGYASABmAG0ARgAzAEkASgBzACsAdQAzAG4AbABuAHoAWABlAGkAawBIAFkA
SwB6AGIATQBEAGoATQBZAGIAUgBTAEcAUwBHAFQAdwBhAEcAcABTAEkAWABXAGQAWABSAGYAVQBZ
AFUAagAxAHAAMwBYAGMAKwBmADgAaABxAHIANQBVAEMASQA0AG8ATABZAHMAUwBrAEgAaQBWACsA
agBrAGUAVQBoAGYARwBrAFgAdABaAGgAeQBlAHIAVQBuAEoAQQBlAGMAUABuAFkAZgA4ACsATwBP
AFUAQQAxAFMAZQBMAG8AMgBmADMAeQBEAGsASgAvAHcATQBoAFcAMQBvADYAYwBqAE0AVABLAFoA
UABjAFMAcgBHADgAdgB1ADEAMwBHADgAZgArAGUASgBLACsAbwBCAFEAagBsAGkAbQBCAGoARABY
AFMAeAByAFEANQBKAG4AYwA0ADIAagBFAFAASgA2ADYARgBKAGYAKwBtAHkAUwA1AFkAaQBtAGkA
bQBXAGIAawByAG4AaAByAE0AQQBoADMAawBlACsALwBzAEIAYgB0AFIAOQA1ADIATwA4ADkATwB5
ADUAOABhAFoAMABNAEkASgByADIAYgBYAHUAMQBIAFAAMgBYAGwAMwAzAFQAOQAyAHIAMQBWAHkA
YwBZAE8ASQBIADIAMAAwAHQAVAA2AGUAaAAzADcAaABwAGQASwBUAFAAcABOAGQAcQBSAEkARQBC
AGwAVAB2AHUARgArAHAAeAAxAFYAQgB1AGEAVQBuAEoAZgBjADUAMgAyADIARABpAFoASgBPAGcA
awByAGsAYwBZAHMATAA0ADEAbABXADUAWAB5AEgAVgB0AGkAbQAzAEUATAA5ADgAOABDADMAUABT
AG0ASgBEAFgAVQBmAHQAbABGAFMARQBXAFIAOQBDAEEAUgBrADMATABLAFMAawB5AEIATQBrAEQA
ZgBBAGYAYQA4AFcAYQA1AHkAUQAvAHEAUABKAE0AYwBLAFAAWgBRADYANABJADcAWQBQADcAVgBX
AGsAVwArAFAAZAArAHUAVQBnAGIALwAvAGEAdwBxAFoATAAxAE8AOQBFAE4AVgBzAHQASwB6AFcA
dQB2AHUAbgBtAEcAQQBhAEgANAAzAHIAbAB1AC8ARgBIADgATQBQAEkAdABMAG4ASwB0AHoAcwBn
AFkATgAvADcAWQBMADgAMgBrADEANgBEAGoAWgAvAGsAWQBjAEEAdQBtAFYATQBxAFMAdgBTADAA
eABwAGwAWgB0AFQATQA0AEEAUgBoAFIARQBLAHMAawB3AEQAOQBaAEIATwB0AEQAQQA1AG8ARwBH
AHUAZwBaAGYAaQBvAEEAUwA0AGYAMwBzAEsANgBhADcAKwA0AGEATQAyAGIATAA2AFkAYQBhAFUA
TwB1AEkATABFAGsAQQBnADMAVABUAHUAZQAzAHcASwBCAGsAMwAxAGIALwBQAEkANgBHAEMAaQB1
AFAATABQADIAUgAyAE4AZQBYAHUARABlAEIAcgBiAAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEA
AAA4AAAAeAAtAGYAbwByAGUAZgByAG8AbgB0AC0AYQBuAHQAaQBzAHAAYQBtAC0AcgBlAHAAbwBy
AHQAAAABAAAAaAQAAEMASQBQADoAMgA1ADUALgAyADUANQAuADIANQA1AC4AMgA1ADUAOwBDAFQA
UgBZADoAOwBMAEEATgBHADoAZQBuADsAUwBDAEwAOgAxADsAUwBSAFYAOgA7AEkAUABWADoATgBM
AEkAOwBTAEYAVgA6AE4AUwBQAE0AOwBIADoAUABBADQAUABSADAANABNAEIAOQA2ADMAOAAuAGUA
dQByAHAAcgBkADAANAAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0AOwBQAFQAUgA6
ADsAQwBBAFQAOgBOAE8ATgBFADsAUwBGAFMAOgAoADEAMwAyADMAMAAwADIAOAApACgANAA2ADMA
NgAwADAAOQApACgAMwA3ADYAMAAwADIAKQAoADMANAA2ADAAMAAyACkAKAAzADkANgAwADAAMwAp
ACgAMwA5ADgANgAwADQAMAAwADAAMAAyACkAKAAzADYANgAwADAANAApACgAMQAzADYAMAAwADMA
KQAoADQANQAxADEAOQA5ADAAMgAxACkAKAAzADEANgAwADAAMgApACgANgA1ADAANgAwADAANwAp
ACgAOAA5ADMANgAwADAAMgApACgAMgA2ADAAMAA1ACkAKAA0ADEAMwAwADAANwAwADAAMAAwADEA
KQAoADYANgA4ADkAOQAwADIAMQApACgAOAA2ADcANgAwADAAMgApACgANQA1ADAAMQA2ADAAMAAz
ACkAKAAzADMANgA1ADYAMAAwADIAKQAoADUANAA5ADAANgAwADAAMwApACgANgA5ADEANgAwADAA
OQApACgAMQAyADIAMAAwADAAMAAwADEAKQAoADYANgA0ADQANgAwADAAOAApACgANgA0ADcANQA2
ADAAMAA4ACkAKAA3ADYAMQAxADYAMAAwADYAKQAoADYANgA1ADUANgAwADAAOAApACgANAA3ADgA
NgAwADAAMAAwADEAKQAoADQAMwAyADYAMAAwADgAKQAoADYANgA0ADcANgAwADAANwApACgAOQA2
ADgANgAwADAAMwApACgANgA2ADkANAA2ADAAMAA3ACkAKAA3ADYAOQA2ADAAMAA1ACkAKAA3ADEA
MgAwADAANAAwADAAMAAwADEAKQAoADMAOAAxADAAMAA3ADAAMAAwADAAMgApACgAMwAwADgANgA0
ADAAMAAzACkAKAAyADkAMAA2ADAAMAAyACkAKAAzADgAMAA3ADAANwAwADAAMAAwADUAKQAoADgA
MwAzADgAMAA0ADAAMAAwADAAMQApACgAOAA2ADMANgAyADAAMAAxACkAKAA1ADIANQAzADYAMAAx
ADQAKQAoADEAOAA2ADAAMAAzACkAKAA1ADYANgAwADMAMAAwADAAMAAyACkAKAA1ADUAOQAwADAA
MQApACgANQA3ADkAMAAwADQAKQA7AEQASQBSADoATwBVAFQAOwBTAEYAUAA6ADEAMQAwADEAOwAA
AB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAFwAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0A
YQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABhAC0AYwBoAHUAbgBrAGMAbwB1
AG4AdAAAAAEAAAAEAAAAMQAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEoAAAB4AC0AbQBzAC0A
ZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABh
AC0AMAAAAAAAAQAAAIIMAABrAGgAeABTAHIANwBhAEgAcwBkAFgANgBjAHEAdgBZAFEAMwBJAGwA
VgBBADMANgBVAGMARQBSACsANABWAHMALwBWAFMANABOADMASQBuADIAZgBTAHQAMwBLAGYAcwBm
AHMAYwBoAFYARwBqAFEAcwBxAGQAKwBJAGMANwAxADUATwBoAGQAVQBpACsARQBKAG8ARQB2AGMA
VABuAHoAeQBJAFAAdwBXAEIAOABrAE8AQgBjAEEAVgBOACsAcAAvAFQAKwBxAEwAQgBLAGsATgBy
AHAAdQBSADcAZwBZAGMAdQBFAFgANQA0AE4AOABRADkAYwB0AFMAKwBYAG0AawAvAFIAWgBqAHYA
QwBQAGIAYQB1AGwASABoAEsASwBuAHcAbQBCAGkAcABjAEIAWABMAGMAUwA4AEkASQBJAHoAVQB2
AE4AQgA5AHoAUQBwAFkAQQBrAGEANQBrAGYAagAzAHYAbQBNADYAYgBsADcAVQBIAG0AdQB2ACsA
agBKAGUATgBtAGYAVAByAFMAQgBKAEQAUwBOAFkASABIAGIAawBrAEkAMwBsAHIANgBSAEkAcwBD
AHIAcQBBADAAQgBuAEsAdwA3AE0AYQA2AFMASgAxAFoALwB0AHMAQQB2AGkAaQBjAFUAVABCAGUA
ZABRAEEARwA0AEMAMgA0ADUASQBFAHcATwBMAEQAQQBKAGMAcgBGAEYAeABNAGoAWABlAGsATwBU
AFIANgAxAHoANgBFAE4ARgBhAHgAcwBRAGQANwBVADAAMQAwAGoARwBoADAAYwBXAGEAagBuAHgA
VwBWAHYAUgBmAG4AMQBHAFUAdgBHAGEAZQBvAGcATwBpAGkAVgB3AHkAcQAvAEgAYwBDAGcAKwBW
AE0ANQA2AFEARwB3AGcAbwBqAFUANgArAEIAWgBCAFoALwBLAFMAVABiAFcAcgA2ADMAUgA2AFEA
cwBKAHYAQgBLAFgAOAB0AHoARQBYAEEALwBQAFcAdgB0AHEAZQByAG4AZgBNAEQAegBFAHEAQwBW
AFgANABoADQAbgBnAFUAQwBoAGUAZgBiAGcAWgBqAGUAKwB5AHMAcwBkAGcAVAB2AFcAQgBIADAA
LwAxAGIAdwBIAGIAOABtAEwASQBrAGEAagBOAGUAMgBmAGEAVgBXAFcASQBHAG4AVgA3AGwAMwBo
AHcAKwAvAFIARABjAHkAagA2AEUAYgBuAE0AMwBkAFYAcwAvAEwAcgB3AHEAWQBlAGEAUgB0AFEA
cwBjAFYANABLAEgAQgBFAHkAVwB2AGoAbQBDAGEAagBaAHcAbQBzAFYAUwB6AHUATQBZAHUAcwBR
AEIAeQBWADQAYQBXAG0AQgA1AFQAcQBOADEASABBAEUARQBNAGIAKwAzAFoAagB4AGQAVwBrAEIA
LwBuAEEARABmAFAALwByAG0AUgB4AGYAZwBlAE0AMgBXAGsAQwBaAE8AaABFAFoANABEAG4AcwBU
AEIARwBGAHYATABPAEkAaABuAEoAcwBXAG8AbwA2AFYAOABrAFgAbAA0AHYATwBmAFIAYwAvAG4A
bAAyADEASABFAGMAMQAvAGoAQwBLAG0AMABDAEgAUwAvAE8AdwB1AFgAVQBHAEwAbABzAE4AegBY
AC8AUQBNAHQAUQBaAHQAawAzAHEAWABIAHEARwBZAE0AUgA4AEcAYwBoAHUAeAB1AFoAOQBWADcA
eQBhADUARQAwADUAUABrAGMAegBSADIAbAB0AFgANwB1AC8AaAB0AG8AVQBkAG0AZAA4AE0AMgA2
ADQAKwBUADUAbgBrAHQAWQAxAGIARwB5AE0AMABFAE4ARAA3AEkAaABDAE0ASwBEAG4AYwA3AE0A
QgBHAFMAaABHAEUASwBzAHUAZABkADQASwBaAFcAWQBCAGMAWgBXAEEAdQB6AGwAagBEAEkAZABF
AEEAYQBFAGwANABlAGcAeAA3ADkAVwBKAEkARwBDADYAMgB5AGsAWgA4AGkATAA4AE8ASQBWAGEA
NgBqAGEAeQBlAEYAcwBQAFUAdwBvAEMASwBKAEYAWAA0AEEAVQBuAHYAdQBGAHkAbgA1ADgANABk
AGQATwBvAFMAMQBrAHMAVwByAFAASABCAFUAdwBRAHMAawBIAGkAawBtAE4ARQBPAFkAawBVAHIA
egBzAG0ARgBsAEoANgBSAE0ASgBXAFYAMwBuAGEASwBDAGQAeABHAEgAUQA2AEYAOABKAGwAdQBL
ADMAZwBrAGcANwBaADQAVwBMAFkAdAAyAEYAYgBMAHoAOQB0AEsALwBiAG8AZQAxAEYAYQBQAHMA
cQB1AEkAMwBBAFAAcgBmAFgAZgA3AHgAYQBRAFAAcwBSAGUATgA0AEoAYgArADUAWQBhAEMANABH
ADAAMAB0AFcAOABGAE4ARQBGAFEAawBEAHEAcwBqAFAARQBRAEgAOABoAGsAOABQAEIAYQArAEQA
bABlAFAAVwA2AE4ASgB3AEkARwA4AE4AZQBjAHYAcQBlAG0ANABTAEEAQgA3AE0ARgBQAGUAYgBZ
AGoALwBYAG0AWABpAEsAYgArADMAWQBnAHQAbwBZAFAAaQAyAC8AOQB5AGoAeQBoACsASgBVAG0A
YgBlAHoAaQBHAFoATwB6AFAANAArAEkATgBLAFgAVgBKAFUAWAB2AGEAVwA1AFUAUgBGAGUAZgBY
AFUAaABhAGsAYgAxADIARABwAGkAQgBzAGIAUABEAFIAWgB5ADIATwBoAHIAdwBEAEQAdwBMADcA
cABiAGEAbgBPADgAagBwAEUAbABuAEwAcABuADgAOABOADAAeABCAFoAWABEAFoALwBvAGwAWAB3
AHQATwBnAFEAQwBrAG4AcwBDAFoAagBjAHIAZABUADEASQBHAHQAQwBHAGEAYwBCADEASAAwAFAA
MABRAFgAdwBxAEcAUwBJAFMANgBFADcAVgBSAC8AbAA3ACsAbABSADAAcAAxADIAMABjADcATABz
AEoAZAA2AHoASwBkADEANABsAFoAYgBHAHgAVABuAG8ASgB0AGMAbAB0AGsARAA4AFYAbQBIAEsA
ZwBpAE0AOABiAGgAUABXAG0AMgB3AHoAdQBqAFMARQB3AG8AKwBKAFYATgA4AEkALwB1AGsAVABa
AGoAUgBZAC8AUQBBAHYAVwAvAFUATwBoAG8AbABlAHYAOAA3AG8ARAB4AE0ANwA0AGUANABTAHUA
dABqADcAOQBCAEcAeABaADEAbABRAEgAbgBSAHEANwBFAFIAVwBSAG8ANQB0ADYAVAA0AFkAQwBo
AHcAYQBwAHcAdQBDAGkARQBHAE8AMgA5AGIAQgBIAFYAYwArAGMAVgBDAFAAUwBSADMAcAByAHQA
UgBCAE0ATwBBAG0AawB2AEMAMQAyAGUAeQAwAC8AcgA1AGMAMQAyADIAeABOAEYASQBwAHcARAA0
AEYAZAAvAHcAaQBkAEgAcQBVADAAWABqAHIAdgBRAEQANAAvADIAYQByADIAdwBCADIAbABjAHAA
RgA5AFcAdQBZAE4ARwBFAEoAVAArAEkAQQA1AEEAVwBzAGQAUABGAFMAKwBlAEsAbABTAGIATwBp
AHkAOABHAHoAdgBUAEMAawBXAHcALwA5ACsAcgBvAHgAZgBuAFIAaQBZADcAaABrAEoAUwB3AEMA
bgBnADYAdgBlADQASAA0AEkAZABPAG8ANgByAFQAcABiAEUAdgBKAEMAcwBDADIATgBkADMAWgBU
AGsAbQA1AHIATwBCAE8AMABoAHoAVQBZADYAcgBoAHEAMgBJAHMAVQBrAHQATwB5AFEATgBuADEA
VQBNACsAbgBOAHkAMwB3AGEAcAAyAFQAbwBJAFoATgBCAEsAQQBIAHEAVAA4ADMAbgBzAHAAQwBH
AEsAdABmAFMAbwAwAG4ATgB1AGkAbgA3AFYAawAxADkAdABHAFkAVABNAEUARQBQAGYATgBUAE8A
LwBCAHMAUwBZAGsAQgBIAFYAawBhAE0AZQA1AFUAcQBHAGIAMgBNAHoAdgBuAGcAUwBEADAAMABG
AHMASgBzAGIAMgBTAG8AdwBlAHoAKwAxAFUASwA2AGcAZQBhAEQANABtADkAZQBHAEYAcwBDAC8A
MgBjAGwAegBnAGIAegAwAFUAbwBWAHYAaABWAHIAVQAxAFIARgBhAEsAYQAzAGkAcAB4ADMAVwBY
AHUASQBtAGoAeABYAEIAdABBADMAeABiAAAAAABLlw==

--_000_PA4PR04MB9638100B3F21D083F386C6D9D106APA4PR04MB9638eurp_--
