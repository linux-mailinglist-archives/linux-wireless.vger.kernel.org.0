Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA4158C36
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 10:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBKJ5I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 04:57:08 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:55200 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgBKJ5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 04:57:08 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ZHWv/U98qwThbkB5de7MBwBx0MY/uld9p7idERc/f6loWo+pCz3QL/oAJErV1XA6FXb5wNTRve
 bgeC1/ZYX/iK7kw/DamZl1Po5zAye+aNtxMtdaNAUHJn7y9enCwMekorgNB4+8+UPaHFpp2uPj
 Szrlx+Ue4X8sPPOQETnSNQYN660DNZXbB2r1ezGxJEqgLqsmy8kuHR+9oem0sFjDZ5ne8Cc0Wt
 7TXnh9pjOgQRnfkG0Q66It5gCDwD4iIEO2PqCgNiiM0VdC1Pq+sCbJUP0VK+9z9EIyPeeRZ7Bz
 7J0=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="1964595"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 02:57:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 02:57:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Feb 2020 02:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2zgchnid3knrWocqXKkAW75m/IQgneU7YNxxYnwT0LcomdmwQgXYsNY74BQNNJaV8NsKEc6LAbETW283xmSpbcgANieKTJ1Xdl5NQFgeyNij8QbAlVRnh3rN3s4F0kY/YGgphhmjRxRl3OieiUt02eN0sHrL++q6vYWXzkkQaSwrqfYbs66TDn5t7joNPjPCPmDbjnBh2Aw/I4EsptuqXrYfSKCojPqItyl8Tac+I0Gbe6Mh9I18f8T3Tmg/cOJ5IRDSUGhKlxOoW5JYxRqCYJaVcp4uVoHt9HymZjIYzhozGxyZL8cl8S4PCjsDnvRWBkDmV13xTERS8WcEKEwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7PmeSnPdlauPWetS7DvnA9uLb9KnyRn8iajT4mZn9I=;
 b=IfI4KlrUUVbE0ZQ3cjgkHj50xqE+Z1a9CsokumDT5KtrIAzwek+3Vvul2f7tdgwoVVEkoMyTXw//Gw/+z+Ab/WD6NqR5i1ouvOJAsB0PPOfFaJsI+Su0ll0wCz1Y/FtQJuNwdAhGQAK3uaWRwxZWVWW2+I5Q0W6A+eR+rLO0FsO3k69hlNR29jo3GqyWdHZbkzmtDhLy9uUAJeThgCseQyHaiUOz1dv5Z9r3t4SRfPx37FyA3n6NG1iPxrUl5nHxJOl82YfhvFKaf5L3FWMESkvWa3U0mynP2ObKJNG71lOoz4OBUrCSyRuORBqlVb2rdcHAixF9QcHE3HTCx2dnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7PmeSnPdlauPWetS7DvnA9uLb9KnyRn8iajT4mZn9I=;
 b=T4fdKXFlYkdn8OCTxUFQCkfxye/iRc8GP8rERU24oA52jxmJH+ODqEADUunX3KVb0hMIS0SvxXidZZeTS7rAzldFzRGn9YcBCjW4lqbbyUfKLMePPjBgZgP8a5/zv1ANsRUyi1qd0usDRmIL6dcc/927Lc925Gb1gnPNQRD6xPs=
Received: from DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) by
 DM6PR11MB4345.namprd11.prod.outlook.com (52.132.251.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Tue, 11 Feb 2020 09:57:05 +0000
Received: from DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392]) by DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 09:57:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 1/3] staging: wilc1000: remove use of vendor specific IE
 for p2p handling
Thread-Topic: [PATCH v2 1/3] staging: wilc1000: remove use of vendor specific
 IE for p2p handling
Thread-Index: AQHV4MGdH4tCboNUMUWXTbBDKdXu/Q==
Date:   Tue, 11 Feb 2020 09:57:05 +0000
Message-ID: <20200211152802.6096-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9b68c5-4023-48b2-44dd-08d7aed8bfea
x-ms-traffictypediagnostic: DM6PR11MB4345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4345046FB17088876EAB563AE3180@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(71200400001)(316002)(107886003)(6916009)(2616005)(36756003)(6486002)(4326008)(1076003)(6512007)(54906003)(6506007)(5660300002)(66446008)(8936002)(186003)(26005)(86362001)(8676002)(81166006)(81156014)(64756008)(2906002)(66556008)(76116006)(91956017)(66476007)(478600001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4345;H:DM6PR11MB3996.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMMi/7kjQI5zvnxfierib4jE92lBBgbjd3w6WUdnBBIyV5/hP0TMSphWgkagCcUxwGxbYK/eo046vTUzvEw2UK/bKIAOSmVvvd5oeGBXrDSB+1JSoekUMLb47JyW7SSWfIJtF9BFrrFpeC9ravODNWjLRHothGZtYJIW5aXyx+JiCFMSbUSBiHIxBPCupiqVK/VbRJBoqpuNrsYqCGqvcl370zTdBwo1Rd4Ekyrep2osI5dqguqkNo2qu9sVYUSqrIEM5RVKeFkVuicpUpelF1vL5vNtOQLcsBoh9qmZ81zu3SMtoOuLk7WDrHhII2d7TBgnKcQVUkExw26uwRzoiXqblfzjjFmZdTcMwdnlEAq0jQupqhl80EteR5p/4XiPy4oizSOH3b1So5tEcLiM+8LCHWZjE7t4ncU0QPtXYaLCpLJ6HfCFwKZWmfkQKYgt
x-ms-exchange-antispam-messagedata: JzPhywv+JbAvOaxSYci/ujGPwa4QsXMMxUMGoq5n8aPXyLHPTk8GWRUHBoFHn/kumDfdIw1YFro38/jMWmZH+DvTZjhbVc0b1SQKhPOoCzRhYlymF3DTVI6f2VlfCxdiXLxUMf9a64xfF60oRhEPtQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9b68c5-4023-48b2-44dd-08d7aed8bfea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 09:57:05.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UGVLpULBYH+qwUVcv9BM0sK5FJXsC25lco8zjUDTcoGV4i4X0af2p94jnELty2reWszld77yQfPcJKiJzrOze6Lkn/wGhc+wxY72K95rk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove the use of vendor specific IE parameter to decide
p2p_GO/p2p_Client roles between two 'wilc' device. Previously p2p group
formation between two 'wilc' device make use of vendor IE for roles
decision. The role is decided based on the 'go_intent' value.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 v2: No change

 drivers/staging/wilc1000/cfg80211.c | 72 ++---------------------------
 drivers/staging/wilc1000/netdev.c   |  2 -
 drivers/staging/wilc1000/netdev.h   |  7 ---
 3 files changed, 4 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000=
/cfg80211.c
index 4863e516ff13..7afbc475b3ea 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -68,7 +68,6 @@ struct wilc_p2p_mgmt_data {
 };
=20
 static const u8 p2p_oui[] =3D {0x50, 0x6f, 0x9A, 0x09};
-static const u8 p2p_vendor_spec[] =3D {0xdd, 0x05, 0x00, 0x08, 0x40, 0x03}=
;
=20
 static void cfg_scan_result(enum scan_event scan_event,
 			    struct wilc_rcvd_net_info *info, void *user_void)
@@ -172,9 +171,6 @@ static void cfg_connect_result(enum conn_event conn_dis=
conn_evt, u8 mac_status,
 	} else if (conn_disconn_evt =3D=3D CONN_DISCONN_EVENT_DISCONN_NOTIF) {
 		u16 reason =3D 0;
=20
-		priv->p2p.local_random =3D 0x01;
-		priv->p2p.recv_random =3D 0x00;
-		priv->p2p.is_wilc_ie =3D false;
 		eth_zero_addr(priv->associated_bss);
 		wilc_wlan_set_bssid(priv->dev, NULL, WILC_STATION_MODE);
=20
@@ -446,9 +442,6 @@ static int disconnect(struct wiphy *wiphy, struct net_d=
evice *dev,
 		wilc->sta_ch =3D WILC_INVALID_CHANNEL;
 	wilc_wlan_set_bssid(priv->dev, NULL, WILC_STATION_MODE);
=20
-	priv->p2p.local_random =3D 0x01;
-	priv->p2p.recv_random =3D 0x00;
-	priv->p2p.is_wilc_ie =3D false;
 	priv->hif_drv->p2p_timeout =3D 0;
=20
 	ret =3D wilc_disconnect(vif);
@@ -934,9 +927,6 @@ static void wilc_wfi_cfg_parse_rx_action(u8 *buf, u32 l=
en, u8 sta_ch)
 	u8 channel_list_attr_index =3D 0;
=20
 	while (index < len) {
-		if (buf[index] =3D=3D GO_INTENT_ATTR_ID)
-			buf[index + 3] =3D (buf[index + 3]  & 0x01) | (0x00 << 1);
-
 		if (buf[index] =3D=3D  CHANLIST_ATTR_ID)
 			channel_list_attr_index =3D index;
 		else if (buf[index] =3D=3D  OPERCHAN_ATTR_ID)
@@ -956,12 +946,6 @@ static void wilc_wfi_cfg_parse_tx_action(u8 *buf, u32 =
len, bool oper_ch,
 	u8 channel_list_attr_index =3D 0;
=20
 	while (index < len) {
-		if (buf[index] =3D=3D GO_INTENT_ATTR_ID) {
-			buf[index + 3] =3D (buf[index + 3]  & 0x01) | (0x0f << 1);
-
-			break;
-		}
-
 		if (buf[index] =3D=3D  CHANLIST_ATTR_ID)
 			channel_list_attr_index =3D index;
 		else if (buf[index] =3D=3D  OPERCHAN_ATTR_ID)
@@ -981,24 +965,6 @@ static void wilc_wfi_cfg_parse_rx_vendor_spec(struct w=
ilc_priv *priv, u8 *buff,
 	struct wilc_vif *vif =3D netdev_priv(priv->dev);
=20
 	subtype =3D buff[P2P_PUB_ACTION_SUBTYPE];
-	if ((subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP) &&
-	    !priv->p2p.is_wilc_ie) {
-		for (i =3D P2P_PUB_ACTION_SUBTYPE; i < size; i++) {
-			if (!memcmp(p2p_vendor_spec, &buff[i], 6)) {
-				priv->p2p.recv_random =3D buff[i + 6];
-				priv->p2p.is_wilc_ie =3D true;
-				break;
-			}
-		}
-	}
-
-	if (priv->p2p.local_random <=3D priv->p2p.recv_random) {
-		netdev_dbg(vif->ndev,
-			   "PEER WILL BE GO LocaRand=3D%02x RecvRand %02x\n",
-			   priv->p2p.local_random, priv->p2p.recv_random);
-		return;
-	}
-
 	if (subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP ||
 	    subtype =3D=3D P2P_INV_REQ || subtype =3D=3D P2P_INV_RSP) {
 		for (i =3D P2P_PUB_ACTION_SUBTYPE + 2; i < size; i++) {
@@ -1051,8 +1017,6 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, =
u32 size)
 		return;
 	}
 	if (buff[ACTION_CAT_ID] =3D=3D PUB_ACTION_ATTR_ID) {
-		u8 subtype =3D buff[P2P_PUB_ACTION_SUBTYPE];
-
 		switch (buff[ACTION_SUBTYPE_ID]) {
 		case GAS_INITIAL_REQ:
 		case GAS_INITIAL_RSP:
@@ -1063,10 +1027,6 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff,=
 u32 size)
 				wilc_wfi_cfg_parse_rx_vendor_spec(priv, buff,
 								  size);
=20
-			if ((subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP) &&
-			    priv->p2p.is_wilc_ie)
-				size -=3D 7;
-
 			break;
=20
 		default:
@@ -1167,17 +1127,8 @@ static void wilc_wfi_cfg_tx_vendor_spec(struct wilc_=
priv *priv,
 	u8 subtype =3D buf[P2P_PUB_ACTION_SUBTYPE];
 	struct wilc_vif *vif =3D netdev_priv(priv->dev);
=20
-	if (subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP) {
-		if (priv->p2p.local_random =3D=3D 1 &&
-		    priv->p2p.recv_random < priv->p2p.local_random) {
-			get_random_bytes(&priv->p2p.local_random, 1);
-			priv->p2p.local_random++;
-		}
-	}
-
-	if (priv->p2p.local_random <=3D priv->p2p.recv_random ||
-	    !(subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP ||
-	      subtype =3D=3D P2P_INV_REQ || subtype =3D=3D P2P_INV_RSP))
+	if (subtype !=3D GO_NEG_REQ && subtype !=3D GO_NEG_RSP &&
+	    subtype !=3D P2P_INV_REQ && subtype !=3D P2P_INV_RSP)
 		return;
=20
 	for (i =3D P2P_PUB_ACTION_SUBTYPE + 2; i < len; i++) {
@@ -1196,15 +1147,6 @@ static void wilc_wfi_cfg_tx_vendor_spec(struct wilc_=
priv *priv,
 			break;
 		}
 	}
-
-	if (subtype !=3D P2P_INV_REQ && subtype !=3D P2P_INV_RSP) {
-		int vendor_spec_len =3D sizeof(p2p_vendor_spec);
-
-		memcpy(&mgmt_tx->buff[len], p2p_vendor_spec,
-		       vendor_spec_len);
-		mgmt_tx->buff[len + vendor_spec_len] =3D priv->p2p.local_random;
-		mgmt_tx->size =3D buf_len;
-	}
 }
=20
 static int mgmt_tx(struct wiphy *wiphy,
@@ -1221,8 +1163,6 @@ static int mgmt_tx(struct wiphy *wiphy,
 	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
 	struct wilc_priv *priv =3D &vif->priv;
 	struct host_if_drv *wfi_drv =3D priv->hif_drv;
-	u32 buf_len =3D len + sizeof(p2p_vendor_spec) +
-			sizeof(priv->p2p.local_random);
 	int ret =3D 0;
=20
 	*cookie =3D prandom_u32();
@@ -1238,7 +1178,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 		goto out;
 	}
=20
-	mgmt_tx->buff =3D kmalloc(buf_len, GFP_KERNEL);
+	mgmt_tx->buff =3D kmalloc(len, GFP_KERNEL);
 	if (!mgmt_tx->buff) {
 		ret =3D -ENOMEM;
 		kfree(mgmt_tx);
@@ -1272,7 +1212,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 			if (!memcmp(p2p_oui, &buf[ACTION_SUBTYPE_ID + 1], 4))
 				wilc_wfi_cfg_tx_vendor_spec(priv, mgmt_tx,
 							    params, vif->iftype,
-							    buf_len);
+							    len);
 			else
 				netdev_dbg(vif->ndev,
 					   "Not a P2P public action frame\n");
@@ -1400,10 +1340,6 @@ static int change_virtual_intf(struct wiphy *wiphy, =
struct net_device *dev,
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc_priv *priv =3D &vif->priv;
=20
-	priv->p2p.local_random =3D 0x01;
-	priv->p2p.recv_random =3D 0x00;
-	priv->p2p.is_wilc_ie =3D false;
-
 	switch (type) {
 	case NL80211_IFTYPE_STATION:
 		vif->connecting =3D false;
diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/n=
etdev.c
index fce5bf2d82fa..045f5cdfdca0 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -577,7 +577,6 @@ static int wilc_mac_open(struct net_device *ndev)
 {
 	struct wilc_vif *vif =3D netdev_priv(ndev);
 	struct wilc *wl =3D vif->wilc;
-	struct wilc_priv *priv =3D wdev_priv(vif->ndev->ieee80211_ptr);
 	unsigned char mac_add[ETH_ALEN] =3D {0};
 	int ret =3D 0;
=20
@@ -621,7 +620,6 @@ static int wilc_mac_open(struct net_device *ndev)
 				 vif->frame_reg[1].reg);
 	netif_wake_queue(ndev);
 	wl->open_ifcs++;
-	priv->p2p.local_random =3D 0x01;
 	vif->mac_opened =3D 1;
 	return 0;
 }
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/n=
etdev.h
index d5f7a6037fbc..c475e78e3a69 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -66,12 +66,6 @@ struct wilc_wfi_p2p_listen_params {
 	u64 listen_cookie;
 };
=20
-struct wilc_p2p_var {
-	u8 local_random;
-	u8 recv_random;
-	bool is_wilc_ie;
-};
-
 static const u32 wilc_cipher_suites[] =3D {
 	WLAN_CIPHER_SUITE_WEP40,
 	WLAN_CIPHER_SUITE_WEP104,
@@ -155,7 +149,6 @@ struct wilc_priv {
 	struct mutex scan_req_lock;
 	bool p2p_listen_state;
 	int scanned_cnt;
-	struct wilc_p2p_var p2p;
=20
 	u64 inc_roc_cookie;
 };
--=20
2.24.0
