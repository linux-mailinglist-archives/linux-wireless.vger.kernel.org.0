Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A17751CC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 06:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjHIEHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 00:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHIEHo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 00:07:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1E1986
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 21:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh28s4kympZ76JEh5XCPSDK/lAyJ/uBJE7Ipjlq/OeqbY6hqfJPvHdFa4UdOv8v+kIfgzoL40z0W7bp063K+lnoqmvorbvTOV4mlyJzpjXdD9jrVhZc2y4wE+Hj8ym8JhOGs0QsECOXwHIrkKv1SUZEBWU/z66Nkw7JrYydqSh48SXlUBf1TZQQub2vZWwopZ4++dwl5ZTpVFillmfwk6yuA1dCxtgmOii2CtbiCJPKW4KJoEcKfHMcxFgzaoVhy8tCOvvGAruqp/jRxJK0z0oEhosSnwnAOEAynhD67KcoGDRzT6p6CTeEv3WfCLXioVYZJhzUwVsySLznlZCB//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwh4PxrEy4oPo4FjLOSw/NOfp52ahAQ2fIAZ0sHw11A=;
 b=Hq9jri7ByW1P02hkREeZMQPibBB9FENmH03FqvfRUqcPnmchbqTdqToYYcaDZDOsWTMxmbZTklZU4z+SPer67c9/0WvyAPlec/Bd/bvZxQhjUK5rDcGtUAaHU5k0vILqezI02fnLfBtesDtuAws895YCWADtvYAizHKveoGQEvC36t717Zz3TdVA2FdrYbXZPG8pJecjN/hVdVRV1HF11B7eTUSow1by9r2ggonnSoWeRHut79mg7n2WJd8wYU3KZwD/u3/mJ+OPB3iKlVB0UXSkhgfEzdUQU4WYSefSQvm6ZXEn4mWZxomgIQ2LsLdpltUYpXqnAnPqjr3z8LvNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwh4PxrEy4oPo4FjLOSw/NOfp52ahAQ2fIAZ0sHw11A=;
 b=aJHtG93llNDkse9YjB4E8IZhhjhNGLl9uCVh3CvbppZZT65Ek8eAY+zTAQcY5Bk2e3u4nLjL60wDvYo9A+jOin5UiaDxOZGJXXo7FglFmH6k1/iYvXv8YJjjPZLWP6b47wwvf9nmbR4XD//8s4LS5XJyeHYw2kYrLg+Va+cY3V8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8482.eurprd04.prod.outlook.com (2603:10a6:20b:34a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 04:07:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 04:07:36 +0000
Content-Type: multipart/mixed;
        boundary="_000_PA4PR04MB9638FE710460BC44BA290470D112APA4PR04MB9638eurp_"
From:   David Lin <yu-hao.lin@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        David Lin <yu-hao.lin@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: [PATCH v2] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [PATCH v2] wifi: mwifiex: added code to support host mlme.
Thread-Index: AdnKdwWMgAI8idR0S3aBP+we4161gw==
Date:   Wed, 9 Aug 2023 04:07:36 +0000
Message-ID: <PA4PR04MB9638FE710460BC44BA290470D112A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <PA4PR04MB9638FE710460BC44BA290470D112A@PA4PR04MB9638.eurprd04.prod.outlook.com>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB8482:EE_
x-ms-office365-filtering-correlation-id: 6d67f683-fb80-41bc-c1f5-08db988e2a7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RalgHRwTJldbpQv0eLBSqxVouc1xtYt6b5IV+95NY6LP1c3hvQPPZRfd10kF3glzDY9JcMS40Or4Qo51Mz/WIqjSZxUcnc4cIPZu4htywtdYyf5bRG1igopCFefQv81XMCRpYKltO/SPVrPBlyhFlSvTHEvkcY4cjSwZyMVaQ0De7aQ+/JQweI2R123qoX44mJUBAVhaYoIO7VtkgHaOl1Bcg3j/ABmy6ZxG6/CcGnVclv+nIji/rSrF7afkZWBF+6JSptpkY2Mx1TbXMWXEKrdzoEwPdHkjgg73SYH3Y6MJxWRQOCnVH4te1OTfzmsjbsBRRBJxr1W71lK8wBz0Bdw1fxTz93p5IDLag+TnTCwtF/+boyJtShpzi048a9tRld4MPrLsmbhkGgk+ZX5j85MeZJdpQoJGc1EM+0AucN1sCduhwDCfOuokAsdMrSvjoI5UDBMGlyTS8u62EwMKS5yv+XCgEvSWXvv5P9Jx2L0UnYVc6+pAk+k1Mpia/+IJSCJWxpzZfGFdW+qUMvTlllv8FD5dBjOZP7TE2bEbMo7wezWwlaZMC3+ZvEhvHAMOMyoQibokw5bnCwe2YiuGrAKRkiHmrpdmfj194R0xU06JZU4qg6qDqAV+qxGKkQMu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(186006)(1800799006)(451199021)(52536014)(38070700005)(26005)(30864003)(2906002)(83380400001)(5660300002)(8676002)(41300700001)(66899021)(8936002)(55016003)(122000001)(6916009)(6506007)(316002)(54906003)(33656002)(86362001)(478600001)(76116006)(7696005)(66476007)(66446008)(66556008)(38100700002)(71200400001)(66946007)(64756008)(9686003)(4326008)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqCyxJ+Cy5r91B9dYTW4lpnYrQPeDxdkiQ/27u1s7hwhHJTeaL+4Nu6ugL4j?=
 =?us-ascii?Q?1+XV+UQG4sLQsVdbiHH2FBfZHXvsMrr3qegbEvgTMTsPLit5/yxA85oOuE0m?=
 =?us-ascii?Q?HlhD4oeqQlxMAC1ta6Wo3AUBoY2eoSMLbpfFwI69AXzb7tOBhMqnuHps2x9G?=
 =?us-ascii?Q?S//kFTYRIHsI4ptMGwSB9MWMZ4IKAdzGT1LFKh6nQxhyo0820Ow49BWXHOmP?=
 =?us-ascii?Q?os3WN6Kvh6HndISHqZc/a06CxnioK28bxRc9ckkevqLfIDQ700yVCyiknqg9?=
 =?us-ascii?Q?sA8WbywyMWDXlnd1dmS7i1/xa/07bVBbH5xORv4Ry2e2eYYHUThJqj+E9aZe?=
 =?us-ascii?Q?3FcXVETGpIkT/E5uHp2jN/TiVdi+LHhoxzFT73yVqBtEbGSd3rgDplHwYBbI?=
 =?us-ascii?Q?jR0iK0Pm8GqPaUhgYaFZCItbzOwgrd+VIr6lLmtIvLrZSPOKLuHRP1LeVqlb?=
 =?us-ascii?Q?WuEAd/kAcZEmcrR2xnks+M0+WmuK40cphbwHWRHApjIfRhxoMfDl1f1e8Os5?=
 =?us-ascii?Q?NHmzCB78p3j0BkynK869OInhz2eL4FQx5MQNXywN5xjHCP8QacK6TmSLHqde?=
 =?us-ascii?Q?UPl9u/u46yQ6SWow2JqQoYqMCkpTZo7rHHTxEWfiDpTof9qWXCnhrKGcMc5k?=
 =?us-ascii?Q?MaFWdVaTEXe4+mnUfHjAk6L31D/sxkzJSh+nXmdPiBAmNPRgVMNogHQ6IiQX?=
 =?us-ascii?Q?Gk5dX3r+vzAYwHAkSESYlzJxcFiIs+qD/DJx+n89DfGLSzvVrzCsoIAIdr62?=
 =?us-ascii?Q?qqunXBqi/hj87xu92K4Cx14q3H8HhlaJVp0S7gt5Z3hdnP6F2yrEG4qzfikx?=
 =?us-ascii?Q?+aORSd7fUQoYBtH1Dl2KiJ06cK0jUqm2qrLAZC4qwZqt64AJnTbAgosGDIIp?=
 =?us-ascii?Q?inT0T4EE9gwv/iI9hezTUuF2vsBUEEWYOzStqdyO8P6RUy27C7J9+DK3PP/p?=
 =?us-ascii?Q?3uLa/1rA9XCSd6MkUnv77erGs4YIDvvBRNDDi9fsCG93c257bQHjueVlYKiB?=
 =?us-ascii?Q?YLw9Biawyac2zXVyXH9tUzRhXmkidFZZA87hgaDZG/ZqP9gbvQ4aj7VLNOds?=
 =?us-ascii?Q?Oge+toRXZon8EPlTYc+4UJCwf5Bd0rePFZvnA8PlpFMYhrCw4aP5eDoxkryv?=
 =?us-ascii?Q?z8quC40ktph43JPrWn5nrJenDUUGcYPkUwA9MiBdb++hOMGM6iVhovSkYv/S?=
 =?us-ascii?Q?43TqtAJOHFYMfxt/vY1qSEzQl1lfddhQ9CZkgB07vZtHo6vnFZ8rr5Lr0bDE?=
 =?us-ascii?Q?qa7UT9wF1BW13dj6qs7ympdl+kZYJcL4So7lPs4Z94cpdbJiSyxu12ax0Igm?=
 =?us-ascii?Q?8mBjcDgatc9muB7Pz9a/0glzy/pzlORqTbrf9C01e0wJoaIXN7g1ZeaCpxTG?=
 =?us-ascii?Q?AmfWuHsk9TswP0cbLj8ytGHPthQnNFF70omEk0kgjGk7Xez/TWbpYw0D4Ojh?=
 =?us-ascii?Q?EznqWKm0pHJMZ9f/TVmz9Ar++QGcQeKVTZlIHiHae3gxBSOxeng4ql6/98z/?=
 =?us-ascii?Q?ZTkJXkbJ/Us9AAZQKIoHful3GOIL6cQaCDXERQjM6uKmAaW98zatO25oBEkO?=
 =?us-ascii?Q?M50vpd3ByIsPHh6LD8mtgMYcG2zlB8CmHRhKWcZq?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d67f683-fb80-41bc-c1f5-08db988e2a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 04:07:36.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg7cfSeqMx4d/hMsc7vvw+on6jzhiF4HBaEkEnfIRIYkxDEuLbogZKEPK12N/tJqKtDOP4kOYp/PpGI9EfH3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_000_PA4PR04MB9638FE710460BC44BA290470D112APA4PR04MB9638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

1. For station mode first.
2. This feature is a must for WPA3.
3. The code is enabled and tested with IW416.
   There is no guarantee for other chips.

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


--_000_PA4PR04MB9638FE710460BC44BA290470D112APA4PR04MB9638eurp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+IvNsAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAAEY1NDVFQjgx
NDQxMzc4NENCQzNEOUFGMEU4REVBNTMzAFQHAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHCAAJAAQA
BwAkAAMAMQEBIIADAA4AAADnBwgACQAEAAcAJAADADEBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABADsAAABbUEFUQ0ggdjJdIHdpZmk6IG13aWZpZXg6IGFkZGVkIGNvZGUg
dG8gc3VwcG9ydCBob3N0IG1sbWUuADAUAQuAAQAhAAAARjU0NUVCODE0NDEzNzg0Q0JDM0Q5QUYw
RThERUE1MzMAVAcBA5AGAAxmAABaAAAAAgF/AAEAAABRAAAAPFBBNFBSMDRNQjk2MzhGRTcxMDQ2
MEJDNDRCQTI5MDQ3MEQxMTJBQFBBNFBSMDRNQjk2MzguZXVycHJkMDQucHJvZC5vdXRsb29rLmNv
bT4AAAAACwAfDgAAAAACAQkQAQAAAAE4AAD9NwAApLAAAExaRnXwLeM0YQAKZmJpZAQAAGNjwHBn
MTI1MgD+A0PwdGV4dAH3AqQD4wIABGNoCsBzZXQwIO8HbQKDAFARTTIKgAa0AoCWfQqACMg7CWIx
OQ7AvwnDFnIKMhZxAoAVYioJsHMJ8ASQYXQFsg5QA2Bzom8BgCBFeBHBbhgwXQZSdgSQF7YCEHIA
wHR9CFBuGjEQIAXABaAbZGSaIANSIBAiF7JcdgiQ5HdrC4BkNR1TBPAHQA0XcDAKcRfyYmttawZz
AZAAICBCTV9C4EVHSU59CvwB8QvwwDIgMS4gRgWxH2G0dGkCICAEYhxwaRHwUHQuXGwLgGUKgDLZ
IbBUaAQAHHBlGIAIcOsZ4CQBYSKAdR9gHHAFsfBXUEEzIzYlwCPRGeD/BaAisSQBCfABoB5wHGAA
cB8cYBAgH2AcUQPwdGggoElXNDE2IzYgKZCDJoEkhG5vIGd1CsDvAHAQICLBBbFvKJAbsiPwjHBz
IzYjRVNpZxhQBGQtGTBmLWJ5OlggRGEdYBxgTAuAIJA8eXUtEdBvLiNRIEBueHAuBaBtPq0jRS0w
QCkmLjDwLxhQvHQvA/AJcB5wBBAvAMB5GiFsbDHwA/Ai4BAwL4BjZmc4MDIxIaACYymRfCAzMjcg
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
RQD5ICAlcOBNXFxuIuefavvF6L1AgjOOD9+fx/8KoSGQGf84xfqADR/hX1uf8T+8P8W//8bP9n/X
/3Jv+290D3Uf4y8f71z1z5Mfi4+MmHNrYv9h0gLwbsGvvZyvFfuTr5S5/27VoIFZYG9QmBMcUJif
FkSdavhDQRAVcLSQSSitdexzboDhrXVuTmAHDy+LT5ocCEcisSk1Mi4gkC5mMSk1KTV9fSmAFzAA
AAAfAEIAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AZQABAAAAJgAAAHkAdQAtAGgAYQBv
AC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAGQAAQAAAAoAAABTAE0AVABQAAAAAAACAUEA
AQAAAFwAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAIBEAGEAdgBpAGQAIABMAGkAbgAAAFMATQBU
AFAAAAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAB8AAl0BAAAAJgAAAHkA
dQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfAOVfAQAAAC4AAABzAGkAcAA6
AHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAAfABoMAQAAABQAAABEAGEA
dgBpAGQAIABMAGkAbgAAAB8AHwwBAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAu
AGMAbwBtAAAAAAAfAB4MAQAAAAoAAABTAE0AVABQAAAAAAACARkMAQAAAFwAAAAAAAAAgSsfpL6j
EBmdbgDdAQ9UAgAAAIBEAGEAdgBpAGQAIABMAGkAbgAAAFMATQBUAFAAAAB5AHUALQBoAGEAbwAu
AGwAaQBuAEAAbgB4AHAALgBjAG8AbQAAAB8AAV0BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4A
QABuAHgAcAAuAGMAbwBtAAAAAAALAEA6AQAAAB8AGgABAAAAEgAAAEkAUABNAC4ATgBvAHQAZQAA
AAAAAwDxPwQEAAALAEA6AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAA9UXrgUQTeEy8PZrw6N6lMwMA
FwABAAAAQAA5AAC0gQd3ytkBQAAIMO3w+wd3ytkBCwApAAAAAAAfANk/AQAAAAACAAAxAC4AIABG
AG8AcgAgAHMAdABhAHQAaQBvAG4AIABtAG8AZABlACAAZgBpAHIAcwB0AC4ADQAKADIALgAgAFQA
aABpAHMAIABmAGUAYQB0AHUAcgBlACAAaQBzACAAYQAgAG0AdQBzAHQAIABmAG8AcgAgAFcAUABB
ADMALgANAAoAMwAuACAAVABoAGUAIABjAG8AZABlACAAaQBzACAAZQBuAGEAYgBsAGUAZAAgAGEA
bgBkACAAdABlAHMAdABlAGQAIAB3AGkAdABoACAASQBXADQAMQA2AC4ADQAKACAAIAAgAFQAaABl
AHIAZQAgAGkAcwAgAG4AbwAgAGcAdQBhAHIAYQBuAHQAZQBlACAAZgBvAHIAIABvAHQAaABlAHIA
IABjAGgAaQBwAHMALgANAAoADQAKAFMAaQBnAG4AZQBkAC0AbwBmAGYALQBiAHkAOgAgAEQAYQB2
AGkAZAAgAEwAaQBuACAAPAB5AHUALQBoAGEAbwAuAGwAaQBuAEAAbgB4AHAALgBjAG8AbQA+AA0A
CgAtAC0ALQANAAoAIAAuAC4ALgAvAG4AZQB0AC8AdwBpAHIAZQBsAGUAcwBzAC8AbQBhAHIAdgBl
AGwAbAAvAG0AdwBpAGYAaQBlAHgALwBjAGYAZwA4ADAAMgAxADEALgBjACAAIAAAAAsAAIAIIAYA
AAAAAMAAAAAAAABGAAAAABSFAAAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAHgAAAGEAYwBj
AGUAcAB0AGwAYQBuAGcAdQBhAGcAZQAAAAAAAQAAABoAAAB6AGgALQBUAFcALAAgAGUAbgAtAFUA
UwAAAAAAAwAAgAggBgAAAAAAwAAAAAAAAEYBAAAAMgAAAEUAeABjAGgAYQBuAGcAZQBBAHAAcABs
AGkAYwBhAHQAaQBvAG4ARgBsAGEAZwBzAAAAAAAgAAAASAAAgAggBgAAAAAAwAAAAAAAAEYBAAAA
IgAAAE4AZQB0AHcAbwByAGsATQBlAHMAcwBhAGcAZQBJAGQAAAAAAIP2Z22A+7xBwfUI25iOKn4f
AACAE4/yQfSDFEGlhO7bWmsL/wEAAAAWAAAAQwBsAGkAZQBuAHQASQBuAGYAbwAAAAAAAQAAACoA
AABDAGwAaQBlAG4AdAA9AE0AUwBFAHgAYwBoAGEAbgBnAGUAUgBQAEMAAAAAAB8A+j8BAAAAFAAA
AEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA3AAEAAAB2AAAAWwBQAEEAVABDAEgAIAB2ADIAXQAgAHcA
aQBmAGkAOgAgAG0AdwBpAGYAaQBlAHgAOgAgAGEAZABkAGUAZAAgAGMAbwBkAGUAIAB0AG8AIABz
AHUAcABwAG8AcgB0ACAAaABvAHMAdAAgAG0AbABtAGUALgAAAAAAHwA9AAEAAAACAAAAAAAAAAMA
NgAAAAAAAgFxAAEAAAAWAAAAAdnKdwWMgAI8idR0S3aBP+we4161gwAAHwBwAAEAAAB2AAAAWwBQ
AEEAVABDAEgAIAB2ADIAXQAgAHcAaQBmAGkAOgAgAG0AdwBpAGYAaQBlAHgAOgAgAGEAZABkAGUA
ZAAgAGMAbwBkAGUAIAB0AG8AIABzAHUAcABwAG8AcgB0ACAAaABvAHMAdAAgAG0AbABtAGUALgAA
AAAAHwA1EAEAAACiAAAAPABQAEEANABQAFIAMAA0AE0AQgA5ADYAMwA4AEYARQA3ADEAMAA0ADYA
MABCAEMANAA0AEIAQQAyADkAMAA0ADcAMABEADEAMQAyAEEAQABQAEEANABQAFIAMAA0AE0AQgA5
ADYAMwA4AC4AZQB1AHIAcAByAGQAMAA0AC4AcAByAG8AZAAuAG8AdQB0AGwAbwBvAGsALgBjAG8A
bQA+AAAAAAADAN4/n04AAAMAExIAAAAAAgEAgBOP8kH0gxRBpYTu21prC/8BAAAALgAAAEgAZQBh
AGQAZQByAEIAbwBkAHkARgByAGEAZwBtAGUAbgB0AEwAaQBzAHQAAAAAAAEAAAAiAAAAAQAKAAAA
BAAAAAAAAAAUAAAAAAAAAAAAAAD/////AAAAAAAACwAAgBOP8kH0gxRBpYTu21prC/8BAAAAHAAA
AEgAYQBzAFEAdQBvAHQAZQBkAFQAZQB4AHQAAAAAAAAACwAAgBOP8kH0gxRBpYTu21prC/8BAAAA
KAAAAEkAcwBRAHUAbwB0AGUAZABUAGUAeAB0AEMAaABhAG4AZwBlAGQAAAAAAAAAQAAHMCEt8wZ3
ytkBAgELAAEAAAAQAAAA9UXrgUQTeEy8PZrw6N6lMwMAJgAAAAAACwAGDAAAAAACARAwAQAAAEYA
AAAAAAAAyKUlsYgjkkqDqmSQCqSrKgcATz4g0Pwm3USuYQdaOgrdJwAAAAABCwAATz4g0Pwm3USu
YQdaOgrdJwACIRqU6AAAAAACARMwAQAAABAAAACAAjyJ1HRLdoE/7B7jXrWDAgEUMAEAAAAMAAAA
awkAAO39sAgxAAAAAwBbMwEAAAADAFo2AAAAAAMAaDYNAAAACwD6NgEAAAAfAPg/AQAAABQAAABE
AGEAdgBpAGQAIABMAGkAbgAAAB8AIkABAAAABgAAAEUAWAAAAAAAHwAjQAEAAAD8AAAALwBPAD0A
RQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUAPQBFAFgAQwBIAEEATgBHAEUAIABBAEQATQBJ
AE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBVAFAAIAAoAEYAWQBEAEkAQgBPAEgARgAyADMA
UwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAASQBFAE4AVABTAC8AQwBOAD0AQwBCADAANABG
ADYANQA5ADEAQQBEADYANAA0ADYAQgA4AEEAQQBCAEMAOQBCADYANQBEAEEARQA5ADIAMAA3AC0A
TgBYAEYANQA3ADYAMgA0AAAAHwAkQAEAAAAGAAAARQBYAAAAAAAfACVAAQAAAPwAAAAvAE8APQBF
AFgAQwBIAEEATgBHAEUATABBAEIAUwAvAE8AVQA9AEUAWABDAEgAQQBOAEcARQAgAEEARABNAEkA
TgBJAFMAVABSAEEAVABJAFYARQAgAEcAUgBPAFUAUAAgACgARgBZAEQASQBCAE8ASABGADIAMwBT
AFAARABMAFQAKQAvAEMATgA9AFIARQBDAEkAUABJAEUATgBUAFMALwBDAE4APQBDAEIAMAA0AEYA
NgA1ADkAMQBBAEQANgA0ADQANgBCADgAQQBBAEIAQwA5AEIANgA1AEQAQQBFADkAMgAwADcALQBO
AFgARgA1ADcANgAyADQAAAAfADBAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAB8AMUABAAAA
FAAAAEQAYQB2AGkAZAAgAEwAaQBuAAAAHwA4QAEAAAAUAAAARABhAHYAaQBkACAATABpAG4AAAAf
ADlAAQAAABQAAABEAGEAdgBpAGQAIABMAGkAbgAAAAMAWUAAAAAAAwBaQAAAAAADADdQAQAAAAMA
CVkBAAAAHwAKXQEAAAAmAAAAeQB1AC0AaABhAG8ALgBsAGkAbgBAAG4AeABwAC4AYwBvAG0AAAAA
AB8AC10BAAAAJgAAAHkAdQAtAGgAYQBvAC4AbABpAG4AQABuAHgAcAAuAGMAbwBtAAAAAAACARVd
AQAAABIAAAAC06FuaCu8b0ypLNmcXDAWNQEAAAIBFl0BAAAAEgAAAALToW5oK7xvTKks2ZxcMBY1
AQAAAwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAJAAAAEkAbgBkAGUAeABpAG4AZwBFAHIAcgBvAHIA
QwBvAGQAZQAAABsAAAAfAACAUONjC8yc0BG82wCAX8zOBAEAAAAqAAAASQBuAGQAZQB4AGkAbgBn
AEUAcgByAG8AcgBNAGUAcwBzAGEAZwBlAAAAAAABAAAAcAAAAEkAbgBkAGUAeABpAG4AZwAgAFAA
ZQBuAGQAaQBuAGcAIAB3AGgAaQBsAGUAIABCAGkAZwBGAHUAbgBuAGUAbABQAE8ASQBJAHMAVQBw
AFQAbwBEAGEAdABlACAAaQBzACAAZgBhAGwAcwBlAC4AAAALAACAUONjC8yc0BG82wCAX8zOBAEA
AAAmAAAASQBzAFAAZQByAG0AYQBuAGUAbgB0AEYAYQBpAGwAdQByAGUAAAAAAAAAAAAfAACAH6Tr
M6h6LkK+e3nhqY5UswEAAAA4AAAAQwBvAG4AdgBlAHIAcwBhAHQAaQBvAG4ASQBuAGQAZQB4AFQA
cgBhAGMAawBpAG4AZwBFAHgAAAABAAAALgEAAEkASQA9AFsAQwBJAEQAPQA4ADkAMwBjADAAMgA4
ADAALQA3ADQAZAA0AC0ANwA2ADQAYgAtADgAMQAzAGYALQBlAGMAMQBlAGUAMwA1AGUAYgA1ADgA
MwA7AEkARABYAEgARQBBAEQAPQBEADkAQwBBADcANwAwADUAOABDADsASQBEAFgAQwBPAFUATgBU
AD0AMQBdADsAVABGAFIAPQBOAG8AdABGAG8AcgBrAGkAbgBnADsAVgBlAHIAcwBpAG8AbgA9AFYA
ZQByAHMAaQBvAG4AIAAxADUALgAyADAAIAAoAEIAdQBpAGwAZAAgADYANgA1ADIALgAwACkALAAg
AFMAdABhAGcAZQA9AEgANAA7AFUAUAA9ADEAMAA7AEQAUAA9ADEAQwAxAAAAAABAAACACCAGAAAA
AADAAAAAAAAARgAAAAC/hQAAMKyNBXfK2QELAACACCAGAAAAAADAAAAAAAAARgAAAACChQAAAAAA
AAIBAIAIIAYAAAAAAMAAAAAAAABGAQAAADYAAABJAG4AVAByAGEAbgBzAGkAdABNAGUAcwBzAGEA
ZwBlAEMAbwByAHIAZQBsAGEAdABvAHIAAAAAAAEAAAAQAAAAbSxPg8jgokKqwAVO+vBVzAMADTT9
PwAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAALgAAAGEAdQB0AGgAZQBuAHQAaQBjAGEAdABpAG8A
bgAtAHIAZQBzAHUAbAB0AHMAAAAAAAEAAACyAAAAZABrAGkAbQA9AG4AbwBuAGUAIAAoAG0AZQBz
AHMAYQBnAGUAIABuAG8AdAAgAHMAaQBnAG4AZQBkACkAIABoAGUAYQBkAGUAcgAuAGQAPQBuAG8A
bgBlADsAZABtAGEAcgBjAD0AbgBvAG4AZQAgAGEAYwB0AGkAbwBuAD0AbgBvAG4AZQAgAGgAZQBh
AGQAZQByAC4AZgByAG8AbQA9AG4AeABwAC4AYwBvAG0AOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAA
AEYBAAAAIAAAAHgALQBtAHMALQBoAGEAcwAtAGEAdAB0AGEAYwBoAAAAAQAAAAIAAAAAAAAAHwAA
gIYDAgAAAAAAwAAAAAAAAEYBAAAALgAAAHgALQBtAHMALQBwAHUAYgBsAGkAYwB0AHIAYQBmAGYA
aQBjAHQAeQBwAGUAAAAAAAEAAAAMAAAARQBtAGEAaQBsAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYB
AAAANgAAAHgALQBtAHMALQB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAZABpAGEAZwBuAG8AcwB0AGkA
YwAAAAAAAQAAAEgAAABQAEEANABQAFIAMAA0AE0AQgA5ADYAMwA4ADoARQBFAF8AfABBAFMAOABQ
AFIAMAA0AE0AQgA4ADQAOAAyADoARQBFAF8AAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABQAAAA
eAAtAG0AcwAtAG8AZgBmAGkAYwBlADMANgA1AC0AZgBpAGwAdABlAHIAaQBuAGcALQBjAG8AcgBy
AGUAbABhAHQAaQBvAG4ALQBpAGQAAAABAAAASgAAADYAZAA2ADcAZgA2ADgAMwAtAGYAYgA4ADAA
LQA0ADEAYgBjAC0AYwAxAGYANQAtADAAOABkAGIAOQA4ADgAZQAyAGEANwBlAAAAAAAfAACAhgMC
AAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAHMAZQBuAGQA
ZQByAGEAZABjAGgAZQBjAGsAAAABAAAABAAAADEAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA6
AAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkAcwBwAGEAbQAtAHIAZQBsAGEA
eQAAAAAAAQAAAAQAAAAwAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAKgAAAHgALQBtAGkAYwBy
AG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEAbQAAAAAAAQAAAA4AAABCAEMATAA6ADAAOwAAAAAA
HwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAARAAAAHgALQBtAGkAYwByAG8AcwBvAGYAdAAtAGEAbgB0
AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUALQBpAG4AZgBvAAAAAQAAAAIFAABSAGEAbABnAEgA
UgB3AFQASgBsAGQAYgBwAFEAdgAwAGUATABCAFMAcQB4AFYAbwB1AGMAMQB4AHQAWQB0ADYAYgA1
AEkAVgArADkANQBOAFkANgBMAFAAMQBjADMAaAB2AFEAUABQAFoAUgBmAGQAMQAwAGsARgAzAGcA
bAB6AEQAWQA5AEoAYwBNAFMANAAwAE8AcgA0AFEAbwA1ADEATQB6AC8AVwBJAHEAagBTAFoAeABV
AGMAbgBjADQAYwBJAFAAWgB1ADQAaAB0AHkAdwB0AGQAWQB5AGYANQBiAFIARwAxAGkAZwBvAHAA
QwBGAGUAZgBRAHYAOAAxAFgATQBDAFIAcABZAEsAbAB0AE8ALwBTAFAAVgByAFAAQgBsAHkAaABG
AGwAUwB2AFQASABFAHYAawBjAFkANABjAGoAUwB3AFoAeQBNAFYAYQBRADAARABlADcAYQBRACsA
LwBKAFEAdwBlAEkAMgBSADEAMgAzAHEAbwBYADQANABtAEoAVQBCAEEAVgBoAGEAWQBvAEkATwA3
AFYAdABrAGcASABhAE8AbAAxAEIAYwBnADMAagAvAEEAQgBtAHkANgBaAHgARwA2AC8AQwBjAEcA
bgBWAGMAbAB2ACsAbgBJAGoAaQAvAHIAUwByAEYANwBhAGYAawBaAFcAQgBGACsANgBKAFMAcAB0
AHAAawBZADIATQB4ADEAVABiAFgATQBXAFgARQBLAHIAZAB6AG8ARQB3AFAAZABIAGsAagBnAGcA
NwAzAFMAWQBIADMAWQA2AE0ASgB4AFcAUgBRAE8AQwBuAFYASAA0AHQAZQAxAE8AVABmAHoAbQBz
AGoAYgBzAEIAUgBSAEIASgB4AHIAMQBXADcAMQBsAEsAOAB3AEIAegAwAEIAZAB3ADEAZgB4AFQA
egA5ADMAcAA1AEkARABMAGEAZwArAFQAbgBUAEMAdwB0AEYALwArAGIAbwB5AEoAdABTAGgAcAB6
AGkAMAA0ADgAYQA5AHQAUgBsAGQANABNAFAAcgBMAHMAbQBiAGgAawBHAGcAawArAFoAWAA1AGoA
OAA1AE0AZQBaAEoAZABwAFEAbwBKAEcAYwAxAEUATQArADAAQQB1AGMATgAxAHMAQwBkAHUAaAB3
AEQAQwBmAE8AdQBvAGsAQQBzAGQATQByAFMAdgBqAG8ASQA1AFUARABCAE0ARwBsAHkAVABTADgA
dQA2ADIARQB3AE0ASwBTADUAeQB2ACsAWABDAGcARQB2AFMAVwBYAHYAdgA1AFAAOQBKAHgAMgBM
ADAAVQBuAFkAVgBjADYAKwBwAEEAawArAGsAMQBNAHAAaQBhAC8AKwBJAEoAUwBDAEoAVwB4AHAA
egBaAGYARwBGAGQAVwArAHEAVQBNAHYAVABsAGwAbAB2ADgARgBEADUAZABCAGoATwBaAFAANwBU
AEUAMgBiAEUAYgBNAG8ANwB3AGUAegBXAHcAbABhAFoATQBDADMAKwBaAHYARQBoAHYASABBAE0A
TwBNAHkAbwBRAGkAYgBvAGsAdwA1AGIAbgBDAHcAZQAyAFkAaQB1AEcAcgBBAEsAUgBrAGkASABt
AHIAcABkAG0AZgBqADEAOQA0AFIAMAB4AFUAMAA2AEoAWgBVADQAcQBnADYAcQBEAHEAQQBWACsA
cQB4AEcASwBrAFEATQB1AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAGYAbwBy
AGUAZgByAG8AbgB0AC0AYQBuAHQAaQBzAHAAYQBtAC0AcgBlAHAAbwByAHQAAAABAAAAgAQAAEMA
SQBQADoAMgA1ADUALgAyADUANQAuADIANQA1AC4AMgA1ADUAOwBDAFQAUgBZADoAOwBMAEEATgBH
ADoAZQBuADsAUwBDAEwAOgAxADsAUwBSAFYAOgA7AEkAUABWADoATgBMAEkAOwBTAEYAVgA6AE4A
UwBQAE0AOwBIADoAUABBADQAUABSADAANABNAEIAOQA2ADMAOAAuAGUAdQByAHAAcgBkADAANAAu
AHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0AOwBQAFQAUgA6ADsAQwBBAFQAOgBOAE8A
TgBFADsAUwBGAFMAOgAoADEAMwAyADMAMAAwADIAOAApACgANAA2ADMANgAwADAAOQApACgAMwA3
ADYAMAAwADIAKQAoADEAMwA2ADAAMAAzACkAKAAzADQANgAwADAAMgApACgAMwA5ADgANgAwADQA
MAAwADAAMAAyACkAKAAzADYANgAwADAANAApACgAMwA5ADYAMAAwADMAKQAoADEAOAA2ADAAMAA2
ACkAKAAxADgAMAAwADcAOQA5ADAAMAA2ACkAKAA0ADUAMQAxADkAOQAwADIAMQApACgANQAyADUA
MwA2ADAAMQA0ACkAKAAzADgAMAA3ADAANwAwADAAMAAwADUAKQAoADIANgAwADAANQApACgAMwAw
ADgANgA0ADAAMAAzACkAKAAyADkAMAA2ADAAMAAyACkAKAA4ADMAMwA4ADAANAAwADAAMAAwADEA
KQAoADUANgA2ADAAMwAwADAAMAAwADIAKQAoADgANgA3ADYAMAAwADIAKQAoADQAMQAzADAAMAA3
ADAAMAAwADAAMQApACgANgA2ADgAOQA5ADAAMgAxACkAKAA4ADkAMwA2ADAAMAAyACkAKAA1ADUA
MAAxADYAMAAwADMAKQAoADEAMgAyADAAMAAwADAAMAAxACkAKAA2ADkAMQA2ADAAMAA5ACkAKAA2
ADUAMAA2ADAAMAA3ACkAKAAzADEANgAwADAAMgApACgANQA0ADkAMAA2ADAAMAAzACkAKAAzADMA
NgA1ADYAMAAwADIAKQAoADgANgAzADYAMgAwADAAMQApACgANAA3ADgANgAwADAAMAAwADEAKQAo
ADcANgAxADEANgAwADAANgApACgANwA2ADkANgAwADAANQApACgANgA2ADQANwA2ADAAMAA3ACkA
KAA2ADYANAA0ADYAMAAwADgAKQAoADYANgA1ADUANgAwADAAOAApACgAMwA4ADEAMAAwADcAMAAw
ADAAMAAyACkAKAA3ADEAMgAwADAANAAwADAAMAAwADEAKQAoADYANgA5ADQANgAwADAANwApACgA
NgA0ADcANQA2ADAAMAA4ACkAKAA5ADYAOAA2ADAAMAAzACkAKAA0ADMAMgA2ADAAMAA4ACkAKAA1
ADUAOQAwADAAMQApACgANQA3ADkAMAAwADQAKQA7AEQASQBSADoATwBVAFQAOwBTAEYAUAA6ADEA
MQAwADEAOwAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAFwAAAB4AC0AbQBzAC0AZQB4AGMAaABh
AG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABhAC0AYwBoAHUA
bgBrAGMAbwB1AG4AdAAAAAEAAAAEAAAAMQAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEoAAAB4
AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcA
ZQBkAGEAdABhAC0AMAAAAAAAAQAAAIIMAABtAHEAQwB5AHgASgArAEMAeQA1AHIAOQAxAEIAOQBk
AFkAVABXADQAbABwAG4AWQByAFEAUABlAEQAeABkAGsAaQBRAC8AMgA3AHUAMQBzADcAaAB3AGgA
SABKAFQAZQBhAEwAKwA0AE4AdQA2AHUAZwBMADQAagAxACsAWABWACsAVQBRAEcANABzAEwAUQBz
AFYAZABiAGkASABIADIARgBCAGYAWgBIAFgAdgBzAE0AcgByADMAcQBlAGcAYgBFAHYAZwBUAE0A
VABzAFAATABpAHQANQAvAHkAeABBADgANQBvAE8AdQBFADAAbQBIAGwAaABEADQAbwBlAHEAUQBs
AHgATQBBAEMAMQB0AGEANgBXAG8AMwBBAFUAQgBvAFkAMgBlAG8AUwBNAEwAYgBwAGYARgB3AEkA
NgA5AEEAWAB6AGIANwB0AE8AQgBoAE0AcQBuAHUASABwAHMAMgB4ADkARwBTAC8ALwBrAEYAVABZ
AFIASQBIAHMASQA0AHAAdABNAEcAdwBTAEIAOQBNAFcATQBaADQASQBLAEEAZAB6AEcAVAAxAEwA
RgBLAGgANgBuAFEAeABoAHkAbwAwADgAMgAwAE8AdwA0ADkAQgBXAFgASABPAG0AUABvAHMAMwBX
AE4ANgBLAHYAaAA2AEgAbgBkAEkAUwBIAHEAWgBjAC8AYQAwADYAQwB4AG4AaQBvAEsAMgA4AGIA
eABSAGMAOQBjAGsAawBlAHYAcQBMAGYASQBEAFEANwAwADAAeQBWAEMAeQBpAGsAbgBxAGcAOQBz
AEEAOABXAGIAeQB3AHkATQBXAEQAWABsAG4AZAAxAGQAbQBTADcAaQAxAC8AeABhAC8AMAA3AGIA
VgBCAGIASAA1AHgATwBSAHYANABSAHkAMgBlADIAZQBZAFkASABVAFQAaABKAHEAagArAEUAOQBh
AFoAZQAzAEYAYwBYAFYARQBUAEcAcABJAGsAVAAvAEUANQB1AEgAcAAyAGoATgAvAFQAaQBWAGQA
aQArAEwASABoAG8AeAB6AEYAVAA3ADMAeQBWAHEAQgB0AEUAYgBHAFMAZAAzAHIAZwBEAHAAbABI
AHcAWQBCAGIASQBqAFIAMABpAEsAMABQAG0AOABHAHEAUABhAFUAaABnAFkAYQBGAFoAQwBJAHQA
YgB6AE8AdwBnAHIAZAArAFYASQByADYAbABMAG0AdABJAHYATAByAFoAUwBQAE8ASwBMAHUASABS
AFAAMQBMAGUAVgBxAGwAYgBXAHUARQBBAGQALwBrAEEAYwBaAEUAbQBjAHIAUgAyAHgAbgBrAHMA
KwBNADAAKwBXAG0AdQBLADQAMABjAHAAaABiAHcASABXAFIASABBAHAAagBJAGYAUgBoAHgAbwBN
AGYARABsADEAZgAxAGUAOABPAHMANQBOAEgAbQB6AEMAQgA3ADgAcAAzAGoAMABCAGsAeQBuAEsA
OAA2ADkATwBJAG4AaAB6ADIAZQBMADQARgBRAHgANQBNAFEATgBYAHkAdwBOADUAeABqAEgAQwBQ
ADgAUQBhAGMASwA2AFQAbQBTAEwASABxAGQAZQBVAFAAbAA5AHUALwB1ADQANgB5AFEANgBTAFcA
bwB3ADIASgBxAFEAbwBZAHEATQBDAGsAcABUAFoAbwA3AHIASABIAFQAeABFAFcAZgBpAEQAcABU
AG8AZgA5AHEAVwBYAEMAbgBoAHIASwBHAGMATQBjADUAawBNAGEARgBXAGQAVgBhAFQARQBYAGUA
NAArAG0AbgBVAGYASABqAEEAawA2AEwAMwAxAEQALwBzAHgAawB6AEoAUwBoACsAbgBYAG0AZABQ
AGkAQgBBAG0ATgBQAFIAZwBWAE0ATgBvAGcASABRADYASQBpAFEAWABHAGsANQBkAFgAMwByACsA
dgB6AEEAWQB3AEgAQQBrAFMARQBTAFkAbAB6AEoAeABjAEYAaQBJAHMAKwBxAEQALwBEAEoAeAAr
AG4AOAA5AEQAZgBHAEwAUwB6AHYAVgByAHoAQwBzAG8ASQBBAEkAZAByADYAMgBxAHEAdQBuAFgA
QgBxAGkALwBoAGoAOAA3AHgAdQA5ADIASwA0AEMAeAAxADQAcQAzAEgAOABIAGgAbABhAEoAVgBw
ADAAUwA3AGcAdAA1AFoAMwBoAGQAbgBQADYARgAyAHkAcgBFAEcANABxAHoAZgBpAGsAeAArAGEA
TwBSAFMAZAA3AGYAVQBRAG8AWQBCAHQASAAxAEQAbAAyAEsAaQBKADAANgBjAEsAMABqAFUAcQBt
ADIAcQByAEwAQQBaAEMANABxAHcAWgBxAHQANgA0AEEASgBuAFQAYgBBAGcAbwBzAEcARABJAEkA
cABpAG4AVAAwAFQANABFAEUAOQBnAHcAdgAvAGkASQA5AGgAZQB6AFQAVQB1AEYAMgB2AHMAQgBV
AEUARQBXAFkATwB6AFMAdABxAGQAeQBPADgAUAA2AFIAVQB5ADIANwBDADcASgA5ACsARABLADMA
UABQAC8AcAAzAHUATABhAC8AMQByAEEAOQBYAEMAUwBkADYATQBrAFUAbgB2ADcANwBlAHIARwBz
ADQAWQBJAEQAdgB2AEIAUgBOAEQARABpADkAZgBzAEMARwA5ADMAYwAyADUANwBiAFEASABqAHUA
ZQBWAGwAWQBLAGkAQgBZAEwAdwA5AEIAaQBhAHcAeQBhAGMAMgB6AFgAVgB5AFgASAA5AHQAVQB6
AFIAaABYAG0AawBpAGQARgBaAFoAQQA4ADcAaABnAGEARABaAEcALwBaAHEAUAA5AGcAYgB2AFEA
NABhAGoANwBWAEwATgBPAGQAcwBPAGcAZQArAHQAbwBSAFgAWgBvAG4AOABFAFAAbABUAFkAYwAr
ADQAVQBKAEMAdwBmADUAQgBkADAAcgBlAFAARgBaAHYAbgBBADgAUABsAHAARgBNAFkAaAByAEMA
dwA0AGEAUAA1AGUARABvAHgAawByAHkAdgB6ADgAcQB1AEMANAAwAGsAdABwAGgANAAzAEoAUABy
AFcAbgA1AG4AcgBKAGUAbgBEAFUAVQBHAGMAWQBQAGsAVQB3AEEAOQBNAGkAQgBkAGIAKwArAGgA
TwBNAEcATQA2AGkAVgBoAG8AdgBTAGsAWQB2AC8AUwA0ADMAVABxAHQAQQBKAE8ASABGAFkATQBm
AHgAdAAvAHYAWQAxAHEAUwBFAHoAUQBsADEAbABmAGQAZABoAFEAOQBDAFoAawBnAEIAMAA3AHYA
WgB0AEgAbwA2AHYAbgBGAFoAOAByAHIANQBMAHIAMABiAEQARQBxAGEANwBVAFQAOQB3AEYAMQBC
AFcAMQAzAGQAagA2AHEAcwA3AHkAbQBwAGQAbAArAGsAWgBZAEoAYwBMADQAUwBvADcAbABQAHMA
NABaADkANABjAHAAZABiAEoAaQBTAHkAeAB1ADEAMgBhAHgAMABJAGcAbQA4AG0AQgBqAGMARABn
AGEAdABjADkAbQB1AEIANwBQAHoAOQBhAC8AMABnAGwAegB5AC8AcAB6AGwATwBSAHEAVABiAHIA
ZgA5AEMAMAAxAGUAMAB3AEoAbwBhAEkAWABOADcAZwAxAFoAZQBhAEMAcAB4AFQARwBBAG0AZgBX
AHUASABzAGsAOQBUAHMAdwBQADAAYwBiAEwAagA4AHkAdABHAEgAUAB0AGgAUQBuAE4ARgBGADcA
MABvAG0ARQBrADAAawBnAGoARwBrADcAWABlAHoALwBUAFcAYgBwAFkAdwAwAEQANABPAGoAaABF
AHoAbgBxAFcASwBtADAAcABIAEoATQBaADkAZgAvAFQAVgBtAHoAOQBBAHIAKwArAFEARwBjAFEA
ZQBLAFYAVABaAGwASQBIAGkASABhAGUAMwBnAHgAQgBTAE8AeABlAG4AZwA0AHEAbAA2AC8AOQA4
AHoALwBaAFQAawBKAFgAawBiAEoALwBVAHMAOQBBAEEAWgBRAEsASQBvAEgAZgB1AGwAMwBHAE8A
SQBMADYAYwBRAGEAQwBEAFgARQBSAFEAagBNADYAdQBLAG0AQQBhAFcAOQA4AHoAYQB0AE8AMgA1
AG8AQgBFAGsATwBNADUAMAB2AHAAZAAzAEIAeQBJAHMAUABIAGgANgBMAEQAOABtAHQAZwBNAFkA
YwBHADIAegBsAEIAOABDAG0ASABSAGgASwBXAGMAWgBxAAAAAADvyw==

--_000_PA4PR04MB9638FE710460BC44BA290470D112APA4PR04MB9638eurp_--
