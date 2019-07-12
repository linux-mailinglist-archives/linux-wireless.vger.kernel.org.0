Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1E66391
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfGLB7K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:10 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24936 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfGLB7K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:10 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 6FS3gKeSjdcwOO0WIKwLTsMZxYsRYsSgRp1SURDPavykvt1Hjl7D1rFuP1BE+1KsDsss6GqoWJ
 gV4xAAT51MpCYkF1lW/woIpWMxWDYfSjk5PZoCNpyiQ3KAq14rJHhox5uf05CpuKKjLCvLGjDZ
 +o0teO9VsEpNRSapFW0EcbrHcybCUysn+FxCBiqClN4nvc1SYP91x03WH8Gl8HlHpJZ171V2ak
 mndQ8/SZj0MGzhWCONGokhrbZgtLkldHzlJ2s3bUtDvGbfCM1Ws6he5Imcux5ZLmS9oQ2hc6g7
 TBk=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="37967455"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:08 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jul 2019 18:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkyYZMuhpVBIESMgTV7/DergfDw2VAmaxxorsrP4JgN0pIotCOWpLAaD4vXYrbhfXmrUtPYITNdNiORrUEQdESbwmFk+1ooERDwfMSFx0uaHgjiplaIQnBQPgpTQJD2ajKsnleG28m3P5CBr0JuEYjniqhPWUeUW20QQOpvZfwn57OdCmSkIwAKFB1wFE8zybuh+bLIgXlgIbwaexa30DJ+bXa6nl9Ff4+dogcBQEe2nCaXobxlFNqsx4JltqkbtS84qHXdYdvO2znvnGxmhTZs5VNzI1wUojcA0L92zd5w3y5sF0B5nJx4CyzJ+gKEllF6gxFvmBmPSKh+lgQTLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/PyAige6oJjnUz4wzUHeRO/AXHClGCUZE3apGb8D+Q=;
 b=RRZVPt7OjffOfnwHQXJosbzgThHXwtRw6U4REBbG/LXTE2cLLUX0GUn9lCnfq1ocfPtHp6b87PogYqzouITmvi7L6jMTaQIwg0f2k9YV545dPi45xLwba02YcI/X4H6aUAmmPpimwODOofixJrJx2YTQattdq3S5QWowd0i8z33s0v8J7UKsOQT+iIGrLPWyn+3bmTkY4Sbxje8OsONNk2OsGpyTFriYVTIg7db2rAVN0mpA45Ggx5GPSihwV0A2O26NPVjYOFT541SpuHGtSjCfKZtS69sfuSXTpfbVAuULeru/vqL1LznAkYAprhQEXa41q300Ar/VaWjfarYaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/PyAige6oJjnUz4wzUHeRO/AXHClGCUZE3apGb8D+Q=;
 b=s0/BY9n+Ll/jkn1j6KngouOSMTE7//hrqms6tJZwUVOLLuok+bMFkK+3kD3kG4sbIgvBlRksNksXS9RVV7mQaW25hGf16ArzfdMlvy35QvHrjen6I6pzjrEdMt7120YYZb5XEVmPj2HHjcFQWYQMpPepQW0emc3sY0976i2PPTQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:05 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 08/16] wilc1000: add wilc_wfi_cfgoperations.c
Thread-Topic: [PATCH v2 08/16] wilc1000: add wilc_wfi_cfgoperations.c
Thread-Index: AQHVOFViQRm1qYP0Pk22E+1guTtEfw==
Date:   Fri, 12 Jul 2019 01:59:05 +0000
Message-ID: <1562896697-8002-9-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57501ab0-57f3-4763-460a-08d7066c84a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB1425A260B78F4C4324771C60E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(53946003)(5640700003)(107886003)(68736007)(99286004)(30864003)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UMf/fzLIYZqfcdxFqA7IC+FCn00UI10WDZQnjSPYrPSy6qOamPINexSzQTDCV7RAx67RPLejea8O4eLP29vboPBwSK+Wpg0gLNJxUTAOliRrD0HiA+lhkJp+5ThXU8uWtpToveaSLTKDQQuqLbN33XXmZh508Xa6FBHP1KvnxvPgUYfjN6jtHI/Hw80wE1sEM/plt9hTSw3mmUiQl9zV5UZVj08wpZtJjTbMdS7oYqQbJSSZg+OIV4XIkkX/y2ROia3a5LlOrrEZT1M1bBpm3axd+nLbOxo9q9aKxvnRcbGfp5S2alSFGEHo/SZRYCQ+0wDNRxBnfCiwSieGYW+WyabvsBPA3N3JU5sdGLaSSzs3aPIzlvvs0FjgsnwTZF0uWkHTXL7zTvHVknzQ4Jm2DHHw8EsyL8n9yV4VrpMIzic=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57501ab0-57f3-4763-460a-08d7066c84a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:05.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000/wilc_wfi_cfgoperations.c' to
'drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../microchip/wilc1000/wilc_wfi_cfgoperations.c    | 1980 ++++++++++++++++=
++++
 1 file changed, 1980 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgope=
rations.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations=
.c b/drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations.c
new file mode 100644
index 0000000..d72fdd3
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wfi_cfgoperations.c
@@ -0,0 +1,1980 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include "wilc_wfi_cfgoperations.h"
+
+#define FRAME_TYPE_ID			0
+#define ACTION_CAT_ID			24
+#define ACTION_SUBTYPE_ID		25
+#define P2P_PUB_ACTION_SUBTYPE		30
+
+#define ACTION_FRAME			0xd0
+#define GO_INTENT_ATTR_ID		0x04
+#define CHANLIST_ATTR_ID		0x0b
+#define OPERCHAN_ATTR_ID		0x11
+#define PUB_ACTION_ATTR_ID		0x04
+#define P2PELEM_ATTR_ID			0xdd
+
+#define GO_NEG_REQ			0x00
+#define GO_NEG_RSP			0x01
+#define GO_NEG_CONF			0x02
+#define P2P_INV_REQ			0x03
+#define P2P_INV_RSP			0x04
+#define PUBLIC_ACT_VENDORSPEC		0x09
+#define GAS_INITIAL_REQ			0x0a
+#define GAS_INITIAL_RSP			0x0b
+
+#define WILC_INVALID_CHANNEL		0
+
+static const struct ieee80211_txrx_stypes
+	wilc_wfi_cfg80211_mgmt_types[NUM_NL80211_IFTYPES] =3D {
+	[NL80211_IFTYPE_STATION] =3D {
+		.tx =3D 0xffff,
+		.rx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_AP] =3D {
+		.tx =3D 0xffff,
+		.rx =3D BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
+			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+			BIT(IEEE80211_STYPE_ACTION >> 4)
+	},
+	[NL80211_IFTYPE_P2P_CLIENT] =3D {
+		.tx =3D 0xffff,
+		.rx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
+			BIT(IEEE80211_STYPE_DEAUTH >> 4)
+	}
+};
+
+static const struct wiphy_wowlan_support wowlan_support =3D {
+	.flags =3D WIPHY_WOWLAN_ANY
+};
+
+struct wilc_p2p_mgmt_data {
+	int size;
+	u8 *buff;
+};
+
+static const u8 p2p_oui[] =3D {0x50, 0x6f, 0x9A, 0x09};
+static const u8 p2p_vendor_spec[] =3D {0xdd, 0x05, 0x00, 0x08, 0x40, 0x03}=
;
+
+#define WILC_IP_TIMEOUT_MS		15000
+
+static void clear_during_ip(struct timer_list *t)
+{
+	struct wilc_vif *vif =3D from_timer(vif, t, during_ip_timer);
+
+	vif->obtaining_ip =3D false;
+}
+
+static void cfg_scan_result(enum scan_event scan_event,
+			    struct wilc_rcvd_net_info *info, void *user_void)
+{
+	struct wilc_priv *priv =3D user_void;
+
+	if (!priv->cfg_scanning)
+		return;
+
+	if (scan_event =3D=3D SCAN_EVENT_NETWORK_FOUND) {
+		s32 freq;
+		struct ieee80211_channel *channel;
+		struct cfg80211_bss *bss;
+		struct wiphy *wiphy =3D priv->dev->ieee80211_ptr->wiphy;
+
+		if (!wiphy || !info)
+			return;
+
+		freq =3D ieee80211_channel_to_frequency((s32)info->ch,
+						      NL80211_BAND_2GHZ);
+		channel =3D ieee80211_get_channel(wiphy, freq);
+		if (!channel)
+			return;
+
+		bss =3D cfg80211_inform_bss_frame(wiphy, channel, info->mgmt,
+						info->frame_len,
+						(s32)info->rssi * 100,
+						GFP_KERNEL);
+		if (!bss)
+			cfg80211_put_bss(wiphy, bss);
+	} else if (scan_event =3D=3D SCAN_EVENT_DONE) {
+		mutex_lock(&priv->scan_req_lock);
+
+		if (priv->scan_req) {
+			struct cfg80211_scan_info info =3D {
+				.aborted =3D false,
+			};
+
+			cfg80211_scan_done(priv->scan_req, &info);
+			priv->cfg_scanning =3D false;
+			priv->scan_req =3D NULL;
+		}
+		mutex_unlock(&priv->scan_req_lock);
+	} else if (scan_event =3D=3D SCAN_EVENT_ABORTED) {
+		mutex_lock(&priv->scan_req_lock);
+
+		if (priv->scan_req) {
+			struct cfg80211_scan_info info =3D {
+				.aborted =3D false,
+			};
+
+			cfg80211_scan_done(priv->scan_req, &info);
+			priv->cfg_scanning =3D false;
+			priv->scan_req =3D NULL;
+		}
+		mutex_unlock(&priv->scan_req_lock);
+	}
+}
+
+static void cfg_connect_result(enum conn_event conn_disconn_evt, u8 mac_st=
atus,
+			       void *priv_data)
+{
+	struct wilc_priv *priv =3D priv_data;
+	struct net_device *dev =3D priv->dev;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wl =3D vif->wilc;
+	struct host_if_drv *wfi_drv =3D priv->hif_drv;
+	struct wilc_conn_info *conn_info =3D &wfi_drv->conn_info;
+
+	vif->connecting =3D false;
+
+	if (conn_disconn_evt =3D=3D CONN_DISCONN_EVENT_CONN_RESP) {
+		u16 connect_status =3D conn_info->status;
+
+		if (mac_status =3D=3D WILC_MAC_STATUS_DISCONNECTED &&
+		    connect_status =3D=3D WLAN_STATUS_SUCCESS) {
+			connect_status =3D WLAN_STATUS_UNSPECIFIED_FAILURE;
+			wilc_wlan_set_bssid(priv->dev, NULL, WILC_STATION_MODE);
+
+			if (vif->iftype !=3D WILC_CLIENT_MODE)
+				wl->sta_ch =3D WILC_INVALID_CHANNEL;
+
+			netdev_err(dev, "Unspecified failure\n");
+		}
+
+		if (connect_status =3D=3D WLAN_STATUS_SUCCESS)
+			memcpy(priv->associated_bss, conn_info->bssid,
+			       ETH_ALEN);
+
+		cfg80211_connect_result(dev, conn_info->bssid,
+					conn_info->req_ies,
+					conn_info->req_ies_len,
+					conn_info->resp_ies,
+					conn_info->resp_ies_len, connect_status,
+					GFP_KERNEL);
+	} else if (conn_disconn_evt =3D=3D CONN_DISCONN_EVENT_DISCONN_NOTIF) {
+		u16 reason =3D 0;
+
+		vif->obtaining_ip =3D false;
+		priv->p2p.local_random =3D 0x01;
+		priv->p2p.recv_random =3D 0x00;
+		priv->p2p.is_wilc_ie =3D false;
+		eth_zero_addr(priv->associated_bss);
+		wilc_wlan_set_bssid(priv->dev, NULL, WILC_STATION_MODE);
+
+		if (vif->iftype !=3D WILC_CLIENT_MODE) {
+			wl->sta_ch =3D WILC_INVALID_CHANNEL;
+		} else {
+			if (wfi_drv->ifc_up)
+				reason =3D 3;
+			else
+				reason =3D 1;
+		}
+
+		cfg80211_disconnected(dev, reason, NULL, 0, false, GFP_KERNEL);
+	}
+}
+
+static struct wilc_vif *wilc_get_wl_to_vif(struct wilc *wl)
+{
+	int i;
+
+	for (i =3D 0; i < wl->vif_num; i++)
+		if (wl->vif[i])
+			return wl->vif[i];
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int set_channel(struct wiphy *wiphy,
+		       struct cfg80211_chan_def *chandef)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif;
+	u32 channelnum;
+	int result;
+
+	mutex_lock(&wl->vif_mutex);
+	vif =3D wilc_get_wl_to_vif(wl);
+	if (IS_ERR(vif)) {
+		mutex_unlock(&wl->vif_mutex);
+		return PTR_ERR(vif);
+	}
+
+	channelnum =3D ieee80211_frequency_to_channel(chandef->chan->center_freq)=
;
+
+	wl->op_ch =3D channelnum;
+	result =3D wilc_set_mac_chnl_num(vif, channelnum);
+	if (result)
+		netdev_err(vif->ndev, "Error in setting channel\n");
+
+	mutex_unlock(&wl->vif_mutex);
+	return result;
+}
+
+static int scan(struct wiphy *wiphy, struct cfg80211_scan_request *request=
)
+{
+	struct wilc_vif *vif =3D netdev_priv(request->wdev->netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+	u32 i;
+	int ret =3D 0;
+	u8 scan_ch_list[WILC_MAX_NUM_SCANNED_CH];
+	u8 scan_type;
+
+	if (request->n_channels > WILC_MAX_NUM_SCANNED_CH) {
+		netdev_err(vif->ndev, "Requested scanned channels over\n");
+		return -EINVAL;
+	}
+
+	priv->scan_req =3D request;
+	priv->cfg_scanning =3D true;
+	for (i =3D 0; i < request->n_channels; i++) {
+		u16 freq =3D request->channels[i]->center_freq;
+
+		scan_ch_list[i] =3D ieee80211_frequency_to_channel(freq);
+	}
+
+	if (request->n_ssids)
+		scan_type =3D WILC_FW_ACTIVE_SCAN;
+	else
+		scan_type =3D WILC_FW_PASSIVE_SCAN;
+
+	ret =3D wilc_scan(vif, WILC_FW_USER_SCAN, scan_type, scan_ch_list,
+			request->n_channels, cfg_scan_result, (void *)priv,
+			request);
+
+	if (ret) {
+		priv->scan_req =3D NULL;
+		priv->cfg_scanning =3D false;
+	}
+
+	return ret;
+}
+
+static int connect(struct wiphy *wiphy, struct net_device *dev,
+		   struct cfg80211_connect_params *sme)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+	struct host_if_drv *wfi_drv =3D priv->hif_drv;
+	int ret;
+	u32 i;
+	u8 security =3D WILC_FW_SEC_NO;
+	enum authtype auth_type =3D WILC_FW_AUTH_ANY;
+	u32 cipher_group;
+	struct cfg80211_bss *bss;
+	void *join_params;
+	u8 ch;
+
+	vif->connecting =3D true;
+
+	memset(priv->wep_key, 0, sizeof(priv->wep_key));
+	memset(priv->wep_key_len, 0, sizeof(priv->wep_key_len));
+
+	cipher_group =3D sme->crypto.cipher_group;
+	if (cipher_group !=3D 0) {
+		if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP40) {
+			security =3D WILC_FW_SEC_WEP;
+
+			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
+			memcpy(priv->wep_key[sme->key_idx], sme->key,
+			       sme->key_len);
+
+			wilc_set_wep_default_keyid(vif, sme->key_idx);
+			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
+						 sme->key_idx);
+		} else if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP104) {
+			security =3D WILC_FW_SEC_WEP_EXTENDED;
+
+			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
+			memcpy(priv->wep_key[sme->key_idx], sme->key,
+			       sme->key_len);
+
+			wilc_set_wep_default_keyid(vif, sme->key_idx);
+			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
+						 sme->key_idx);
+		} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
+			if (cipher_group =3D=3D WLAN_CIPHER_SUITE_TKIP)
+				security =3D WILC_FW_SEC_WPA2_TKIP;
+			else
+				security =3D WILC_FW_SEC_WPA2_AES;
+		} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) {
+			if (cipher_group =3D=3D WLAN_CIPHER_SUITE_TKIP)
+				security =3D WILC_FW_SEC_WPA_TKIP;
+			else
+				security =3D WILC_FW_SEC_WPA_AES;
+		} else {
+			ret =3D -ENOTSUPP;
+			netdev_err(dev, "%s: Unsupported cipher\n",
+				   __func__);
+			goto out_error;
+		}
+	}
+
+	if ((sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) ||
+	    (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2)) {
+		for (i =3D 0; i < sme->crypto.n_ciphers_pairwise; i++) {
+			u32 ciphers_pairwise =3D sme->crypto.ciphers_pairwise[i];
+
+			if (ciphers_pairwise =3D=3D WLAN_CIPHER_SUITE_TKIP)
+				security |=3D WILC_FW_TKIP;
+			else
+				security |=3D WILC_FW_AES;
+		}
+	}
+
+	switch (sme->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM;
+		break;
+
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		auth_type =3D WILC_FW_AUTH_SHARED_KEY;
+		break;
+
+	default:
+		break;
+	}
+
+	if (sme->crypto.n_akm_suites) {
+		if (sme->crypto.akm_suites[0] =3D=3D WLAN_AKM_SUITE_8021X)
+			auth_type =3D WILC_FW_AUTH_IEEE8021;
+	}
+
+	if (wfi_drv->usr_scan_req.scan_result) {
+		netdev_err(vif->ndev, "%s: Scan in progress\n", __func__);
+		ret =3D -EBUSY;
+		goto out_error;
+	}
+
+	bss =3D cfg80211_get_bss(wiphy, sme->channel, sme->bssid, sme->ssid,
+			       sme->ssid_len, IEEE80211_BSS_TYPE_ANY,
+			       IEEE80211_PRIVACY(sme->privacy));
+	if (!bss) {
+		ret =3D -EINVAL;
+		goto out_error;
+	}
+
+	if (ether_addr_equal_unaligned(vif->bssid, bss->bssid)) {
+		ret =3D -EALREADY;
+		goto out_put_bss;
+	}
+
+	join_params =3D wilc_parse_join_bss_param(bss, &sme->crypto);
+	if (!join_params) {
+		netdev_err(dev, "%s: failed to construct join param\n",
+			   __func__);
+		ret =3D -EINVAL;
+		goto out_put_bss;
+	}
+
+	ch =3D ieee80211_frequency_to_channel(bss->channel->center_freq);
+	vif->wilc->op_ch =3D ch;
+	if (vif->iftype !=3D WILC_CLIENT_MODE)
+		vif->wilc->sta_ch =3D ch;
+
+	wilc_wlan_set_bssid(dev, bss->bssid, WILC_STATION_MODE);
+
+	wfi_drv->conn_info.security =3D security;
+	wfi_drv->conn_info.auth_type =3D auth_type;
+	wfi_drv->conn_info.ch =3D ch;
+	wfi_drv->conn_info.conn_result =3D cfg_connect_result;
+	wfi_drv->conn_info.arg =3D priv;
+	wfi_drv->conn_info.param =3D join_params;
+
+	ret =3D wilc_set_join_req(vif, bss->bssid, sme->ie, sme->ie_len);
+	if (ret) {
+		netdev_err(dev, "wilc_set_join_req(): Error\n");
+		ret =3D -ENOENT;
+		if (vif->iftype !=3D WILC_CLIENT_MODE)
+			vif->wilc->sta_ch =3D WILC_INVALID_CHANNEL;
+		wilc_wlan_set_bssid(dev, NULL, WILC_STATION_MODE);
+		wfi_drv->conn_info.conn_result =3D NULL;
+		kfree(join_params);
+		goto out_put_bss;
+	}
+	kfree(join_params);
+	cfg80211_put_bss(wiphy, bss);
+	return 0;
+
+out_put_bss:
+	cfg80211_put_bss(wiphy, bss);
+
+out_error:
+	vif->connecting =3D false;
+	return ret;
+}
+
+static int disconnect(struct wiphy *wiphy, struct net_device *dev,
+		      u16 reason_code)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+	struct wilc *wilc =3D vif->wilc;
+	int ret;
+
+	vif->connecting =3D false;
+
+	if (!wilc)
+		return -EIO;
+
+	if (wilc->close) {
+		/* already disconnected done */
+		cfg80211_disconnected(dev, 0, NULL, 0, true, GFP_KERNEL);
+		return 0;
+	}
+
+	if (vif->iftype !=3D WILC_CLIENT_MODE)
+		wilc->sta_ch =3D WILC_INVALID_CHANNEL;
+	wilc_wlan_set_bssid(priv->dev, NULL, WILC_STATION_MODE);
+
+	priv->p2p.local_random =3D 0x01;
+	priv->p2p.recv_random =3D 0x00;
+	priv->p2p.is_wilc_ie =3D false;
+	priv->hif_drv->p2p_timeout =3D 0;
+
+	ret =3D wilc_disconnect(vif);
+	if (ret !=3D 0) {
+		netdev_err(priv->dev, "Error in disconnecting\n");
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static inline void wilc_wfi_cfg_copy_wep_info(struct wilc_priv *priv,
+					      u8 key_index,
+					      struct key_params *params)
+{
+	priv->wep_key_len[key_index] =3D params->key_len;
+	memcpy(priv->wep_key[key_index], params->key, params->key_len);
+}
+
+static int wilc_wfi_cfg_allocate_wpa_entry(struct wilc_priv *priv, u8 idx)
+{
+	if (!priv->wilc_gtk[idx]) {
+		priv->wilc_gtk[idx] =3D kzalloc(sizeof(*priv->wilc_gtk[idx]),
+					      GFP_KERNEL);
+		if (!priv->wilc_gtk[idx])
+			return -ENOMEM;
+	}
+
+	if (!priv->wilc_ptk[idx]) {
+		priv->wilc_ptk[idx] =3D kzalloc(sizeof(*priv->wilc_ptk[idx]),
+					      GFP_KERNEL);
+		if (!priv->wilc_ptk[idx])
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
+				      struct key_params *params)
+{
+	kfree(key_info->key);
+
+	key_info->key =3D kmemdup(params->key, params->key_len, GFP_KERNEL);
+	if (!key_info->key)
+		return -ENOMEM;
+
+	kfree(key_info->seq);
+
+	if (params->seq_len > 0) {
+		key_info->seq =3D kmemdup(params->seq, params->seq_len,
+					GFP_KERNEL);
+		if (!key_info->seq)
+			return -ENOMEM;
+	}
+
+	key_info->cipher =3D params->cipher;
+	key_info->key_len =3D params->key_len;
+	key_info->seq_len =3D params->seq_len;
+
+	return 0;
+}
+
+static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_=
index,
+		   bool pairwise, const u8 *mac_addr, struct key_params *params)
+
+{
+	int ret =3D 0, keylen =3D params->key_len;
+	const u8 *rx_mic =3D NULL;
+	const u8 *tx_mic =3D NULL;
+	u8 mode =3D WILC_FW_SEC_NO;
+	u8 op_mode;
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	switch (params->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP) {
+			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
+
+			if (params->cipher =3D=3D WLAN_CIPHER_SUITE_WEP40)
+				mode =3D WILC_FW_SEC_WEP;
+			else
+				mode =3D WILC_FW_SEC_WEP_EXTENDED;
+
+			ret =3D wilc_add_wep_key_bss_ap(vif, params->key,
+						      params->key_len,
+						      key_index, mode,
+						      WILC_FW_AUTH_OPEN_SYSTEM);
+			break;
+		}
+		if (memcmp(params->key, priv->wep_key[key_index],
+			   params->key_len)) {
+			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
+
+			ret =3D wilc_add_wep_key_bss_sta(vif, params->key,
+						       params->key_len,
+						       key_index);
+		}
+
+		break;
+
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP ||
+		    priv->wdev.iftype =3D=3D NL80211_IFTYPE_P2P_GO) {
+			struct wilc_wfi_key *key;
+
+			ret =3D wilc_wfi_cfg_allocate_wpa_entry(priv, key_index);
+			if (ret)
+				return -ENOMEM;
+
+			if (params->key_len > 16 &&
+			    params->cipher =3D=3D WLAN_CIPHER_SUITE_TKIP) {
+				tx_mic =3D params->key + 24;
+				rx_mic =3D params->key + 16;
+				keylen =3D params->key_len - 16;
+			}
+
+			if (!pairwise) {
+				if (params->cipher =3D=3D WLAN_CIPHER_SUITE_TKIP)
+					mode =3D WILC_FW_SEC_WPA_TKIP;
+				else
+					mode =3D WILC_FW_SEC_WPA2_AES;
+
+				priv->wilc_groupkey =3D mode;
+
+				key =3D priv->wilc_gtk[key_index];
+			} else {
+				if (params->cipher =3D=3D WLAN_CIPHER_SUITE_TKIP)
+					mode =3D WILC_FW_SEC_WPA_TKIP;
+				else
+					mode =3D priv->wilc_groupkey | WILC_FW_AES;
+
+				key =3D priv->wilc_ptk[key_index];
+			}
+			ret =3D wilc_wfi_cfg_copy_wpa_info(key, params);
+			if (ret)
+				return -ENOMEM;
+
+			op_mode =3D WILC_AP_MODE;
+		} else {
+			if (params->key_len > 16 &&
+			    params->cipher =3D=3D WLAN_CIPHER_SUITE_TKIP) {
+				rx_mic =3D params->key + 24;
+				tx_mic =3D params->key + 16;
+				keylen =3D params->key_len - 16;
+			}
+
+			op_mode =3D WILC_STATION_MODE;
+		}
+
+		if (!pairwise)
+			ret =3D wilc_add_rx_gtk(vif, params->key, keylen,
+					      key_index, params->seq_len,
+					      params->seq, rx_mic, tx_mic,
+					      op_mode, mode);
+		else
+			ret =3D wilc_add_ptk(vif, params->key, keylen, mac_addr,
+					   rx_mic, tx_mic, op_mode, mode,
+					   key_index);
+
+		break;
+
+	default:
+		netdev_err(netdev, "%s: Unsupported cipher\n", __func__);
+		ret =3D -ENOTSUPP;
+	}
+
+	return ret;
+}
+
+static int del_key(struct wiphy *wiphy, struct net_device *netdev,
+		   u8 key_index,
+		   bool pairwise,
+		   const u8 *mac_addr)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	if (netdev =3D=3D wl->vif[0]->ndev) {
+		if (priv->wilc_gtk[key_index]) {
+			kfree(priv->wilc_gtk[key_index]->key);
+			priv->wilc_gtk[key_index]->key =3D NULL;
+			kfree(priv->wilc_gtk[key_index]->seq);
+			priv->wilc_gtk[key_index]->seq =3D NULL;
+
+			kfree(priv->wilc_gtk[key_index]);
+			priv->wilc_gtk[key_index] =3D NULL;
+		}
+
+		if (priv->wilc_ptk[key_index]) {
+			kfree(priv->wilc_ptk[key_index]->key);
+			priv->wilc_ptk[key_index]->key =3D NULL;
+			kfree(priv->wilc_ptk[key_index]->seq);
+			priv->wilc_ptk[key_index]->seq =3D NULL;
+			kfree(priv->wilc_ptk[key_index]);
+			priv->wilc_ptk[key_index] =3D NULL;
+		}
+	}
+
+	if (key_index <=3D 3 && priv->wep_key_len[key_index]) {
+		memset(priv->wep_key[key_index], 0,
+		       priv->wep_key_len[key_index]);
+		priv->wep_key_len[key_index] =3D 0;
+		wilc_remove_wep_key(vif, key_index);
+	}
+
+	return 0;
+}
+
+static int get_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_=
index,
+		   bool pairwise, const u8 *mac_addr, void *cookie,
+		   void (*callback)(void *cookie, struct key_params *))
+{
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+	struct  key_params key_params;
+
+	if (!pairwise) {
+		key_params.key =3D priv->wilc_gtk[key_index]->key;
+		key_params.cipher =3D priv->wilc_gtk[key_index]->cipher;
+		key_params.key_len =3D priv->wilc_gtk[key_index]->key_len;
+		key_params.seq =3D priv->wilc_gtk[key_index]->seq;
+		key_params.seq_len =3D priv->wilc_gtk[key_index]->seq_len;
+	} else {
+		key_params.key =3D priv->wilc_ptk[key_index]->key;
+		key_params.cipher =3D priv->wilc_ptk[key_index]->cipher;
+		key_params.key_len =3D priv->wilc_ptk[key_index]->key_len;
+		key_params.seq =3D priv->wilc_ptk[key_index]->seq;
+		key_params.seq_len =3D priv->wilc_ptk[key_index]->seq_len;
+	}
+
+	callback(cookie, &key_params);
+
+	return 0;
+}
+
+static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
+			   u8 key_index, bool unicast, bool multicast)
+{
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+
+	wilc_set_wep_default_keyid(vif, key_index);
+
+	return 0;
+}
+
+static int get_station(struct wiphy *wiphy, struct net_device *dev,
+		       const u8 *mac, struct station_info *sinfo)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+	u32 i =3D 0;
+	u32 associatedsta =3D ~0;
+	u32 inactive_time =3D 0;
+
+	if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE) {
+		for (i =3D 0; i < NUM_STA_ASSOCIATED; i++) {
+			if (!(memcmp(mac,
+				     priv->assoc_stainfo.sta_associated_bss[i],
+				     ETH_ALEN))) {
+				associatedsta =3D i;
+				break;
+			}
+		}
+
+		if (associatedsta =3D=3D ~0) {
+			netdev_err(dev, "sta required is not associated\n");
+			return -ENOENT;
+		}
+
+		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
+
+		wilc_get_inactive_time(vif, mac, &inactive_time);
+		sinfo->inactive_time =3D 1000 * inactive_time;
+	} else if (vif->iftype =3D=3D WILC_STATION_MODE) {
+		struct rf_info stats;
+
+		wilc_get_statistics(vif, &stats);
+
+		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_SIGNAL) |
+				 BIT_ULL(NL80211_STA_INFO_RX_PACKETS) |
+				 BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
+				 BIT_ULL(NL80211_STA_INFO_TX_FAILED) |
+				 BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+		sinfo->signal =3D stats.rssi;
+		sinfo->rx_packets =3D stats.rx_cnt;
+		sinfo->tx_packets =3D stats.tx_cnt + stats.tx_fail_cnt;
+		sinfo->tx_failed =3D stats.tx_fail_cnt;
+		sinfo->txrate.legacy =3D stats.link_speed * 10;
+
+		if (stats.link_speed > TCP_ACK_FILTER_LINK_SPEED_THRESH &&
+		    stats.link_speed !=3D DEFAULT_LINK_SPEED)
+			wilc_enable_tcp_ack_filter(vif, true);
+		else if (stats.link_speed !=3D DEFAULT_LINK_SPEED)
+			wilc_enable_tcp_ack_filter(vif, false);
+	}
+	return 0;
+}
+
+static int change_bss(struct wiphy *wiphy, struct net_device *dev,
+		      struct bss_parameters *params)
+{
+	return 0;
+}
+
+struct wilc_vif *wilc_get_interface(struct wilc *wl)
+{
+	int i;
+	struct wilc_vif *vif =3D NULL;
+
+	mutex_lock(&wl->vif_mutex);
+	for (i =3D 0; i < wl->vif_num; i++) {
+		if (wl->vif[i]) {
+			vif =3D wl->vif[i];
+			break;
+		}
+	}
+	mutex_unlock(&wl->vif_mutex);
+	return vif;
+}
+
+static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
+{
+	int ret;
+	struct cfg_param_attr cfg_param_val;
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif;
+	struct wilc_priv *priv;
+
+	vif =3D wilc_get_interface(wl);
+	if (!vif)
+		return -EINVAL;
+
+	priv =3D &vif->priv;
+	cfg_param_val.flag =3D 0;
+
+	if (changed & WIPHY_PARAM_RETRY_SHORT) {
+		netdev_dbg(vif->ndev,
+			   "Setting WIPHY_PARAM_RETRY_SHORT %d\n",
+			   wiphy->retry_short);
+		cfg_param_val.flag  |=3D WILC_CFG_PARAM_RETRY_SHORT;
+		cfg_param_val.short_retry_limit =3D wiphy->retry_short;
+	}
+	if (changed & WIPHY_PARAM_RETRY_LONG) {
+		netdev_dbg(vif->ndev,
+			   "Setting WIPHY_PARAM_RETRY_LONG %d\n",
+			   wiphy->retry_long);
+		cfg_param_val.flag |=3D WILC_CFG_PARAM_RETRY_LONG;
+		cfg_param_val.long_retry_limit =3D wiphy->retry_long;
+	}
+	if (changed & WIPHY_PARAM_FRAG_THRESHOLD) {
+		if (wiphy->frag_threshold > 255 &&
+		    wiphy->frag_threshold < 7937) {
+			netdev_dbg(vif->ndev,
+				   "Setting WIPHY_PARAM_FRAG_THRESHOLD %d\n",
+				   wiphy->frag_threshold);
+			cfg_param_val.flag |=3D WILC_CFG_PARAM_FRAG_THRESHOLD;
+			cfg_param_val.frag_threshold =3D wiphy->frag_threshold;
+		} else {
+			netdev_err(vif->ndev,
+				   "Fragmentation threshold out of range\n");
+			return -EINVAL;
+		}
+	}
+
+	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
+		if (wiphy->rts_threshold > 255) {
+			netdev_dbg(vif->ndev,
+				   "Setting WIPHY_PARAM_RTS_THRESHOLD %d\n",
+				   wiphy->rts_threshold);
+			cfg_param_val.flag |=3D WILC_CFG_PARAM_RTS_THRESHOLD;
+			cfg_param_val.rts_threshold =3D wiphy->rts_threshold;
+		} else {
+			netdev_err(vif->ndev, "RTS threshold out of range\n");
+			return -EINVAL;
+		}
+	}
+
+	ret =3D wilc_hif_set_cfg(vif, &cfg_param_val);
+	if (ret)
+		netdev_err(priv->dev, "Error in setting WIPHY PARAMS\n");
+
+	return ret;
+}
+
+static int set_pmksa(struct wiphy *wiphy, struct net_device *netdev,
+		     struct cfg80211_pmksa *pmksa)
+{
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+	u32 i;
+	int ret =3D 0;
+	u8 flag =3D 0;
+
+	for (i =3D 0; i < priv->pmkid_list.numpmkid; i++)	{
+		if (!memcmp(pmksa->bssid, priv->pmkid_list.pmkidlist[i].bssid,
+			    ETH_ALEN)) {
+			flag =3D PMKID_FOUND;
+			break;
+		}
+	}
+	if (i < WILC_MAX_NUM_PMKIDS) {
+		memcpy(priv->pmkid_list.pmkidlist[i].bssid, pmksa->bssid,
+		       ETH_ALEN);
+		memcpy(priv->pmkid_list.pmkidlist[i].pmkid, pmksa->pmkid,
+		       WLAN_PMKID_LEN);
+		if (!(flag =3D=3D PMKID_FOUND))
+			priv->pmkid_list.numpmkid++;
+	} else {
+		netdev_err(netdev, "Invalid PMKID index\n");
+		ret =3D -EINVAL;
+	}
+
+	if (!ret)
+		ret =3D wilc_set_pmkid_info(vif, &priv->pmkid_list);
+
+	return ret;
+}
+
+static int del_pmksa(struct wiphy *wiphy, struct net_device *netdev,
+		     struct cfg80211_pmksa *pmksa)
+{
+	u32 i;
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	for (i =3D 0; i < priv->pmkid_list.numpmkid; i++)	{
+		if (!memcmp(pmksa->bssid, priv->pmkid_list.pmkidlist[i].bssid,
+			    ETH_ALEN)) {
+			memset(&priv->pmkid_list.pmkidlist[i], 0,
+			       sizeof(struct wilc_pmkid));
+			break;
+		}
+	}
+
+	if (i < priv->pmkid_list.numpmkid && priv->pmkid_list.numpmkid > 0) {
+		for (; i < (priv->pmkid_list.numpmkid - 1); i++) {
+			memcpy(priv->pmkid_list.pmkidlist[i].bssid,
+			       priv->pmkid_list.pmkidlist[i + 1].bssid,
+			       ETH_ALEN);
+			memcpy(priv->pmkid_list.pmkidlist[i].pmkid,
+			       priv->pmkid_list.pmkidlist[i + 1].pmkid,
+			       WLAN_PMKID_LEN);
+		}
+		priv->pmkid_list.numpmkid--;
+	} else {
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static int flush_pmksa(struct wiphy *wiphy, struct net_device *netdev)
+{
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+
+	memset(&vif->priv.pmkid_list, 0, sizeof(struct wilc_pmkid_attr));
+
+	return 0;
+}
+
+static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf, u8 ch_list_attr_idx=
,
+					      u8 op_ch_attr_idx, u8 sta_ch)
+{
+	int i =3D 0;
+	int j =3D 0;
+
+	if (ch_list_attr_idx) {
+		u8 limit =3D ch_list_attr_idx + 3 + buf[ch_list_attr_idx + 1];
+
+		for (i =3D ch_list_attr_idx + 3; i < limit; i++) {
+			if (buf[i] =3D=3D 0x51) {
+				for (j =3D i + 2; j < ((i + 2) + buf[i + 1]); j++)
+					buf[j] =3D sta_ch;
+				break;
+			}
+		}
+	}
+
+	if (op_ch_attr_idx) {
+		buf[op_ch_attr_idx + 6] =3D 0x51;
+		buf[op_ch_attr_idx + 7] =3D sta_ch;
+	}
+}
+
+static void wilc_wfi_cfg_parse_rx_action(u8 *buf, u32 len, u8 sta_ch)
+{
+	u32 index =3D 0;
+	u8 op_channel_attr_index =3D 0;
+	u8 channel_list_attr_index =3D 0;
+
+	while (index < len) {
+		if (buf[index] =3D=3D GO_INTENT_ATTR_ID)
+			buf[index + 3] =3D (buf[index + 3]  & 0x01) | (0x00 << 1);
+
+		if (buf[index] =3D=3D  CHANLIST_ATTR_ID)
+			channel_list_attr_index =3D index;
+		else if (buf[index] =3D=3D  OPERCHAN_ATTR_ID)
+			op_channel_attr_index =3D index;
+		index +=3D buf[index + 1] + 3;
+	}
+	if (sta_ch !=3D WILC_INVALID_CHANNEL)
+		wilc_wfi_cfg_parse_ch_attr(buf, channel_list_attr_index,
+					   op_channel_attr_index, sta_ch);
+}
+
+static void wilc_wfi_cfg_parse_tx_action(u8 *buf, u32 len, bool oper_ch,
+					 u8 iftype, u8 sta_ch)
+{
+	u32 index =3D 0;
+	u8 op_channel_attr_index =3D 0;
+	u8 channel_list_attr_index =3D 0;
+
+	while (index < len) {
+		if (buf[index] =3D=3D GO_INTENT_ATTR_ID) {
+			buf[index + 3] =3D (buf[index + 3]  & 0x01) | (0x0f << 1);
+
+			break;
+		}
+
+		if (buf[index] =3D=3D  CHANLIST_ATTR_ID)
+			channel_list_attr_index =3D index;
+		else if (buf[index] =3D=3D  OPERCHAN_ATTR_ID)
+			op_channel_attr_index =3D index;
+		index +=3D buf[index + 1] + 3;
+	}
+	if (sta_ch !=3D WILC_INVALID_CHANNEL && oper_ch)
+		wilc_wfi_cfg_parse_ch_attr(buf, channel_list_attr_index,
+					   op_channel_attr_index, sta_ch);
+}
+
+static void wilc_wfi_cfg_parse_rx_vendor_spec(struct wilc_priv *priv, u8 *=
buff,
+					      u32 size)
+{
+	int i;
+	u8 subtype;
+	struct wilc_vif *vif =3D netdev_priv(priv->dev);
+
+	subtype =3D buff[P2P_PUB_ACTION_SUBTYPE];
+	if ((subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP) &&
+	    !priv->p2p.is_wilc_ie) {
+		for (i =3D P2P_PUB_ACTION_SUBTYPE; i < size; i++) {
+			if (!memcmp(p2p_vendor_spec, &buff[i], 6)) {
+				priv->p2p.recv_random =3D buff[i + 6];
+				priv->p2p.is_wilc_ie =3D true;
+				break;
+			}
+		}
+	}
+
+	if (priv->p2p.local_random <=3D priv->p2p.recv_random) {
+		netdev_dbg(vif->ndev,
+			   "PEER WILL BE GO LocaRand=3D%02x RecvRand %02x\n",
+			   priv->p2p.local_random, priv->p2p.recv_random);
+		return;
+	}
+
+	if (subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP ||
+	    subtype =3D=3D P2P_INV_REQ || subtype =3D=3D P2P_INV_RSP) {
+		for (i =3D P2P_PUB_ACTION_SUBTYPE + 2; i < size; i++) {
+			if (buff[i] =3D=3D P2PELEM_ATTR_ID &&
+			    !(memcmp(p2p_oui, &buff[i + 2], 4))) {
+				wilc_wfi_cfg_parse_rx_action(&buff[i + 6],
+							     size - (i + 6),
+							     vif->wilc->sta_ch);
+				break;
+			}
+		}
+	}
+}
+
+void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
+{
+	struct wilc *wl =3D vif->wilc;
+	struct wilc_priv *priv =3D &vif->priv;
+	struct host_if_drv *wfi_drv =3D priv->hif_drv;
+	u32 header, pkt_offset;
+	s32 freq;
+	__le16 fc;
+
+	memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
+	le32_to_cpus(&header);
+	pkt_offset =3D GET_PKT_OFFSET(header);
+
+	if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
+		bool ack =3D false;
+
+		if (buff[FRAME_TYPE_ID] =3D=3D IEEE80211_STYPE_PROBE_RESP ||
+		    pkt_offset & IS_MGMT_STATUS_SUCCES)
+			ack =3D true;
+
+		cfg80211_mgmt_tx_status(&priv->wdev, priv->tx_cookie, buff,
+					size, ack, GFP_KERNEL);
+		return;
+	}
+
+	freq =3D ieee80211_channel_to_frequency(wl->op_ch, NL80211_BAND_2GHZ);
+
+	fc =3D ((struct ieee80211_hdr *)buff)->frame_control;
+	if (!ieee80211_is_action(fc)) {
+		cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
+		return;
+	}
+
+	if (priv->cfg_scanning &&
+	    time_after_eq(jiffies, (unsigned long)wfi_drv->p2p_timeout)) {
+		netdev_dbg(vif->ndev, "Receiving action wrong ch\n");
+		return;
+	}
+	if (buff[ACTION_CAT_ID] =3D=3D PUB_ACTION_ATTR_ID) {
+		u8 subtype =3D buff[P2P_PUB_ACTION_SUBTYPE];
+
+		switch (buff[ACTION_SUBTYPE_ID]) {
+		case GAS_INITIAL_REQ:
+		case GAS_INITIAL_RSP:
+			break;
+
+		case PUBLIC_ACT_VENDORSPEC:
+			if (!memcmp(p2p_oui, &buff[ACTION_SUBTYPE_ID + 1], 4))
+				wilc_wfi_cfg_parse_rx_vendor_spec(priv, buff,
+								  size);
+
+			if ((subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP) &&
+			    priv->p2p.is_wilc_ie)
+				size -=3D 7;
+
+			break;
+
+		default:
+			netdev_dbg(vif->ndev,
+				   "%s: Not handled action frame type:%x\n",
+				   __func__, buff[ACTION_SUBTYPE_ID]);
+			break;
+		}
+	}
+
+	cfg80211_rx_mgmt(&priv->wdev, freq, 0, buff, size, 0);
+}
+
+static void wilc_wfi_mgmt_tx_complete(void *priv, int status)
+{
+	struct wilc_p2p_mgmt_data *pv_data =3D priv;
+
+	kfree(pv_data->buff);
+	kfree(pv_data);
+}
+
+static void wilc_wfi_remain_on_channel_expired(void *data, u64 cookie)
+{
+	struct wilc_vif *vif =3D data;
+	struct wilc_priv *priv =3D &vif->priv;
+	struct wilc_wfi_p2p_listen_params *params =3D &priv->remain_on_ch_params;
+
+	if (cookie !=3D params->listen_cookie)
+		return;
+
+	priv->p2p_listen_state =3D false;
+
+	cfg80211_remain_on_channel_expired(&priv->wdev, params->listen_cookie,
+					   params->listen_ch, GFP_KERNEL);
+}
+
+static int remain_on_channel(struct wiphy *wiphy,
+			     struct wireless_dev *wdev,
+			     struct ieee80211_channel *chan,
+			     unsigned int duration, u64 *cookie)
+{
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+	u64 id;
+
+	if (wdev->iftype =3D=3D NL80211_IFTYPE_AP) {
+		netdev_dbg(vif->ndev, "Required while in AP mode\n");
+		return ret;
+	}
+
+	id =3D ++priv->inc_roc_cookie;
+	if (id =3D=3D 0)
+		id =3D ++priv->inc_roc_cookie;
+
+	ret =3D wilc_remain_on_channel(vif, id, duration, chan->hw_value,
+				     wilc_wfi_remain_on_channel_expired,
+				     (void *)vif);
+	if (ret)
+		return ret;
+
+	vif->wilc->op_ch =3D chan->hw_value;
+
+	priv->remain_on_ch_params.listen_ch =3D chan;
+	priv->remain_on_ch_params.listen_cookie =3D id;
+	*cookie =3D id;
+	priv->p2p_listen_state =3D true;
+	priv->remain_on_ch_params.listen_duration =3D duration;
+
+	cfg80211_ready_on_channel(wdev, *cookie, chan, duration, GFP_KERNEL);
+	mod_timer(&vif->hif_drv->remain_on_ch_timer,
+		  jiffies + msecs_to_jiffies(duration));
+
+	return ret;
+}
+
+static int cancel_remain_on_channel(struct wiphy *wiphy,
+				    struct wireless_dev *wdev,
+				    u64 cookie)
+{
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	if (cookie !=3D priv->remain_on_ch_params.listen_cookie)
+		return -ENOENT;
+
+	return wilc_listen_state_expired(vif, cookie);
+}
+
+static void wilc_wfi_cfg_tx_vendor_spec(struct wilc_priv *priv,
+					struct wilc_p2p_mgmt_data *mgmt_tx,
+					struct cfg80211_mgmt_tx_params *params,
+					u8 iftype, u32 buf_len)
+{
+	const u8 *buf =3D params->buf;
+	size_t len =3D params->len;
+	u32 i;
+	u8 subtype =3D buf[P2P_PUB_ACTION_SUBTYPE];
+	struct wilc_vif *vif =3D netdev_priv(priv->dev);
+
+	if (subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP) {
+		if (priv->p2p.local_random =3D=3D 1 &&
+		    priv->p2p.recv_random < priv->p2p.local_random) {
+			get_random_bytes(&priv->p2p.local_random, 1);
+			priv->p2p.local_random++;
+		}
+	}
+
+	if (priv->p2p.local_random <=3D priv->p2p.recv_random ||
+	    !(subtype =3D=3D GO_NEG_REQ || subtype =3D=3D GO_NEG_RSP ||
+	      subtype =3D=3D P2P_INV_REQ || subtype =3D=3D P2P_INV_RSP))
+		return;
+
+	for (i =3D P2P_PUB_ACTION_SUBTYPE + 2; i < len; i++) {
+		if (buf[i] =3D=3D P2PELEM_ATTR_ID &&
+		    !memcmp(p2p_oui, &buf[i + 2], 4)) {
+			bool oper_ch =3D false;
+			u8 *tx_buff =3D &mgmt_tx->buff[i + 6];
+
+			if (subtype =3D=3D P2P_INV_REQ || subtype =3D=3D P2P_INV_RSP)
+				oper_ch =3D true;
+
+			wilc_wfi_cfg_parse_tx_action(tx_buff, len - (i + 6),
+						     oper_ch, iftype,
+						     vif->wilc->sta_ch);
+
+			break;
+		}
+	}
+
+	if (subtype !=3D P2P_INV_REQ && subtype !=3D P2P_INV_RSP) {
+		int vendor_spec_len =3D sizeof(p2p_vendor_spec);
+
+		memcpy(&mgmt_tx->buff[len], p2p_vendor_spec,
+		       vendor_spec_len);
+		mgmt_tx->buff[len + vendor_spec_len] =3D priv->p2p.local_random;
+		mgmt_tx->size =3D buf_len;
+	}
+}
+
+static int mgmt_tx(struct wiphy *wiphy,
+		   struct wireless_dev *wdev,
+		   struct cfg80211_mgmt_tx_params *params,
+		   u64 *cookie)
+{
+	struct ieee80211_channel *chan =3D params->chan;
+	unsigned int wait =3D params->wait;
+	const u8 *buf =3D params->buf;
+	size_t len =3D params->len;
+	const struct ieee80211_mgmt *mgmt;
+	struct wilc_p2p_mgmt_data *mgmt_tx;
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+	struct host_if_drv *wfi_drv =3D priv->hif_drv;
+	u32 buf_len =3D len + sizeof(p2p_vendor_spec) +
+			sizeof(priv->p2p.local_random);
+	int ret =3D 0;
+
+	*cookie =3D prandom_u32();
+	priv->tx_cookie =3D *cookie;
+	mgmt =3D (const struct ieee80211_mgmt *)buf;
+
+	if (!ieee80211_is_mgmt(mgmt->frame_control))
+		goto out;
+
+	mgmt_tx =3D kmalloc(sizeof(*mgmt_tx), GFP_KERNEL);
+	if (!mgmt_tx) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	mgmt_tx->buff =3D kmalloc(buf_len, GFP_KERNEL);
+	if (!mgmt_tx->buff) {
+		ret =3D -ENOMEM;
+		kfree(mgmt_tx);
+		goto out;
+	}
+
+	memcpy(mgmt_tx->buff, buf, len);
+	mgmt_tx->size =3D len;
+
+	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
+		wilc_set_mac_chnl_num(vif, chan->hw_value);
+		vif->wilc->op_ch =3D chan->hw_value;
+		goto out_txq_add_pkt;
+	}
+
+	if (!ieee80211_is_action(mgmt->frame_control))
+		goto out_txq_add_pkt;
+
+	if (buf[ACTION_CAT_ID] =3D=3D PUB_ACTION_ATTR_ID) {
+		if (buf[ACTION_SUBTYPE_ID] !=3D PUBLIC_ACT_VENDORSPEC ||
+		    buf[P2P_PUB_ACTION_SUBTYPE] !=3D GO_NEG_CONF) {
+			wilc_set_mac_chnl_num(vif, chan->hw_value);
+			vif->wilc->op_ch =3D chan->hw_value;
+		}
+		switch (buf[ACTION_SUBTYPE_ID]) {
+		case GAS_INITIAL_REQ:
+		case GAS_INITIAL_RSP:
+			break;
+
+		case PUBLIC_ACT_VENDORSPEC:
+			if (!memcmp(p2p_oui, &buf[ACTION_SUBTYPE_ID + 1], 4))
+				wilc_wfi_cfg_tx_vendor_spec(priv, mgmt_tx,
+							    params, vif->iftype,
+							    buf_len);
+			else
+				netdev_dbg(vif->ndev,
+					   "Not a P2P public action frame\n");
+
+			break;
+
+		default:
+			netdev_dbg(vif->ndev,
+				   "%s: Not handled action frame type:%x\n",
+				   __func__, buf[ACTION_SUBTYPE_ID]);
+			break;
+		}
+	}
+
+	wfi_drv->p2p_timeout =3D (jiffies + msecs_to_jiffies(wait));
+
+out_txq_add_pkt:
+
+	wilc_wlan_txq_add_mgmt_pkt(wdev->netdev, mgmt_tx,
+				   mgmt_tx->buff, mgmt_tx->size,
+				   wilc_wfi_mgmt_tx_complete);
+
+out:
+
+	return ret;
+}
+
+static int mgmt_tx_cancel_wait(struct wiphy *wiphy,
+			       struct wireless_dev *wdev,
+			       u64 cookie)
+{
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+	struct wilc_priv *priv =3D &vif->priv;
+	struct host_if_drv *wfi_drv =3D priv->hif_drv;
+
+	wfi_drv->p2p_timeout =3D jiffies;
+
+	if (!priv->p2p_listen_state) {
+		struct wilc_wfi_p2p_listen_params *params;
+
+		params =3D &priv->remain_on_ch_params;
+
+		cfg80211_remain_on_channel_expired(wdev,
+						   params->listen_cookie,
+						   params->listen_ch,
+						   GFP_KERNEL);
+	}
+
+	return 0;
+}
+
+void wilc_mgmt_frame_register(struct wiphy *wiphy, struct wireless_dev *wd=
ev,
+			      u16 frame_type, bool reg)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+
+	if (!frame_type)
+		return;
+
+	switch (frame_type) {
+	case IEEE80211_STYPE_PROBE_REQ:
+		vif->frame_reg[0].type =3D frame_type;
+		vif->frame_reg[0].reg =3D reg;
+		break;
+
+	case IEEE80211_STYPE_ACTION:
+		vif->frame_reg[1].type =3D frame_type;
+		vif->frame_reg[1].reg =3D reg;
+		break;
+
+	default:
+		break;
+	}
+
+	if (!wl->initialized)
+		return;
+	wilc_frame_register(vif, frame_type, reg);
+}
+
+static int set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *dev=
,
+			       s32 rssi_thold, u32 rssi_hyst)
+{
+	return 0;
+}
+
+static int dump_station(struct wiphy *wiphy, struct net_device *dev,
+			int idx, u8 *mac, struct station_info *sinfo)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	int ret;
+
+	if (idx !=3D 0)
+		return -ENOENT;
+
+	sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_SIGNAL);
+
+	ret =3D wilc_get_rssi(vif, &sinfo->signal);
+	if (ret)
+		return ret;
+
+	memcpy(mac, vif->priv.associated_bss, ETH_ALEN);
+	return 0;
+}
+
+static int set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
+			  bool enabled, int timeout)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	if (!priv->hif_drv)
+		return -EIO;
+
+	if (vif->wilc->enable_ps)
+		wilc_set_power_mgmt(vif, enabled, timeout);
+
+	return 0;
+}
+
+static int change_virtual_intf(struct wiphy *wiphy, struct net_device *dev=
,
+			       enum nl80211_iftype type,
+			       struct vif_params *params)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	priv->p2p.local_random =3D 0x01;
+	priv->p2p.recv_random =3D 0x00;
+	priv->p2p.is_wilc_ie =3D false;
+	vif->obtaining_ip =3D false;
+	del_timer(&vif->during_ip_timer);
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		vif->connecting =3D false;
+		dev->ieee80211_ptr->iftype =3D type;
+		priv->wdev.iftype =3D type;
+		vif->monitor_flag =3D 0;
+		if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE)
+			wilc_wfi_deinit_mon_interface(wl, true);
+		vif->iftype =3D WILC_STATION_MODE;
+		wilc_set_operation_mode(vif, WILC_STATION_MODE);
+
+		memset(priv->assoc_stainfo.sta_associated_bss, 0,
+		       WILC_MAX_NUM_STA * ETH_ALEN);
+
+		wl->enable_ps =3D true;
+		wilc_set_power_mgmt(vif, 1, 0);
+		break;
+
+	case NL80211_IFTYPE_P2P_CLIENT:
+		vif->connecting =3D false;
+		dev->ieee80211_ptr->iftype =3D type;
+		priv->wdev.iftype =3D type;
+		vif->monitor_flag =3D 0;
+		vif->iftype =3D WILC_CLIENT_MODE;
+		wilc_set_operation_mode(vif, WILC_STATION_MODE);
+
+		wl->enable_ps =3D false;
+		wilc_set_power_mgmt(vif, 0, 0);
+		break;
+
+	case NL80211_IFTYPE_AP:
+		wl->enable_ps =3D false;
+		dev->ieee80211_ptr->iftype =3D type;
+		priv->wdev.iftype =3D type;
+		vif->iftype =3D WILC_AP_MODE;
+
+		if (wl->initialized) {
+			wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif),
+						 0, vif->idx);
+			wilc_set_operation_mode(vif, WILC_AP_MODE);
+			wilc_set_power_mgmt(vif, 0, 0);
+		}
+		break;
+
+	case NL80211_IFTYPE_P2P_GO:
+		vif->obtaining_ip =3D true;
+		mod_timer(&vif->during_ip_timer,
+			  jiffies + msecs_to_jiffies(WILC_IP_TIMEOUT_MS));
+		wilc_set_operation_mode(vif, WILC_AP_MODE);
+		dev->ieee80211_ptr->iftype =3D type;
+		priv->wdev.iftype =3D type;
+		vif->iftype =3D WILC_GO_MODE;
+
+		wl->enable_ps =3D false;
+		wilc_set_power_mgmt(vif, 0, 0);
+		break;
+
+	default:
+		netdev_err(dev, "Unknown interface type=3D %d\n", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int start_ap(struct wiphy *wiphy, struct net_device *dev,
+		    struct cfg80211_ap_settings *settings)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	int ret;
+
+	ret =3D set_channel(wiphy, &settings->chandef);
+	if (ret !=3D 0)
+		netdev_err(dev, "Error in setting channel\n");
+
+	wilc_wlan_set_bssid(dev, dev->dev_addr, WILC_AP_MODE);
+	wilc_set_power_mgmt(vif, 0, 0);
+
+	return wilc_add_beacon(vif, settings->beacon_interval,
+				   settings->dtim_period, &settings->beacon);
+}
+
+static int change_beacon(struct wiphy *wiphy, struct net_device *dev,
+			 struct cfg80211_beacon_data *beacon)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+
+	return wilc_add_beacon(vif, 0, 0, beacon);
+}
+
+static int stop_ap(struct wiphy *wiphy, struct net_device *dev)
+{
+	int ret;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+
+	wilc_wlan_set_bssid(dev, NULL, WILC_AP_MODE);
+
+	ret =3D wilc_del_beacon(vif);
+
+	if (ret)
+		netdev_err(dev, "Host delete beacon fail\n");
+
+	return ret;
+}
+
+static int add_station(struct wiphy *wiphy, struct net_device *dev,
+		       const u8 *mac, struct station_parameters *params)
+{
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE) {
+		memcpy(priv->assoc_stainfo.sta_associated_bss[params->aid], mac,
+		       ETH_ALEN);
+
+		ret =3D wilc_add_station(vif, mac, params);
+		if (ret)
+			netdev_err(dev, "Host add station fail\n");
+	}
+
+	return ret;
+}
+
+static int del_station(struct wiphy *wiphy, struct net_device *dev,
+		       struct station_del_parameters *params)
+{
+	const u8 *mac =3D params->mac;
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc_priv *priv =3D &vif->priv;
+	struct sta_info *info;
+
+	if (!(vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE)=
)
+		return ret;
+
+	info =3D &priv->assoc_stainfo;
+
+	if (!mac)
+		ret =3D wilc_del_allstation(vif, info->sta_associated_bss);
+
+	ret =3D wilc_del_station(vif, mac);
+	if (ret)
+		netdev_err(dev, "Host delete station fail\n");
+	return ret;
+}
+
+static int change_station(struct wiphy *wiphy, struct net_device *dev,
+			  const u8 *mac, struct station_parameters *params)
+{
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+
+	if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE) {
+		ret =3D wilc_edit_station(vif, mac, params);
+		if (ret)
+			netdev_err(dev, "Host edit station fail\n");
+	}
+	return ret;
+}
+
+static int wilc_get_vif_from_type(struct wilc *wl, int type)
+{
+	int i;
+
+	mutex_lock(&wl->vif_mutex);
+	for (i =3D 0; i < wl->vif_num; i++) {
+		if (wl->vif[i]->iftype =3D=3D type) {
+			mutex_unlock(&wl->vif_mutex);
+			return i;
+		}
+	}
+	mutex_unlock(&wl->vif_mutex);
+
+	return -EINVAL;
+}
+
+static struct wireless_dev *add_virtual_intf(struct wiphy *wiphy,
+					     const char *name,
+					     unsigned char name_assign_type,
+					     enum nl80211_iftype type,
+					     struct vif_params *params)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif;
+	struct wireless_dev *wdev;
+	int iftype;
+	int ret;
+
+	if (type =3D=3D NL80211_IFTYPE_MONITOR) {
+		struct net_device *ndev;
+		int ap_index =3D wilc_get_vif_from_type(wl, WILC_AP_MODE);
+
+		if (ap_index < 0) {
+			ap_index =3D wilc_get_vif_from_type(wl, WILC_GO_MODE);
+			if (ap_index < 0)
+				goto validate_interface;
+		}
+
+		vif  =3D wl->vif[ap_index];
+		if (vif->monitor_flag)
+			goto validate_interface;
+
+		ndev =3D wilc_wfi_init_mon_interface(wl, name, vif->ndev);
+		if (ndev)
+			vif->monitor_flag =3D 1;
+		else
+			return ERR_PTR(-EINVAL);
+
+		wdev =3D &vif->priv.wdev;
+		return wdev;
+	}
+
+validate_interface:
+	mutex_lock(&wl->vif_mutex);
+	if (wl->vif_num =3D=3D WILC_NUM_CONCURRENT_IFC) {
+		pr_err("Reached maximum number of interface\n");
+		ret =3D -EINVAL;
+		goto out_err;
+	}
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		iftype =3D WILC_STATION_MODE;
+		break;
+	case NL80211_IFTYPE_AP:
+		iftype =3D WILC_AP_MODE;
+		break;
+	default:
+		ret =3D -EOPNOTSUPP;
+		goto out_err;
+	}
+
+	vif =3D wilc_netdev_ifc_init(wl, name, iftype, type, true);
+	if (IS_ERR(vif)) {
+		ret =3D PTR_ERR(vif);
+		goto out_err;
+	}
+
+	mutex_unlock(&wl->vif_mutex);
+
+	return &vif->priv.wdev;
+
+out_err:
+	mutex_unlock(&wl->vif_mutex);
+	return ERR_PTR(ret);
+}
+
+static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev=
)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif;
+	int i;
+
+	if (wdev->iftype =3D=3D NL80211_IFTYPE_AP ||
+	    wdev->iftype =3D=3D NL80211_IFTYPE_P2P_GO)
+		wilc_wfi_deinit_mon_interface(wl, true);
+	vif =3D netdev_priv(wdev->netdev);
+	cfg80211_stop_iface(wiphy, wdev, GFP_KERNEL);
+	unregister_netdevice(vif->ndev);
+	vif->monitor_flag =3D 0;
+
+	mutex_lock(&wl->vif_mutex);
+	wilc_set_wfi_drv_handler(vif, 0, 0, 0);
+	for (i =3D vif->idx; i < wl->vif_num ; i++) {
+		if ((i + 1) >=3D wl->vif_num) {
+			wl->vif[i] =3D NULL;
+		} else {
+			vif =3D wl->vif[i + 1];
+			vif->idx =3D i;
+			wl->vif[i] =3D vif;
+			wilc_set_wfi_drv_handler(vif, wilc_get_vif_idx(vif),
+						 vif->iftype, vif->idx);
+		}
+	}
+	wl->vif_num--;
+	mutex_unlock(&wl->vif_mutex);
+
+	return 0;
+}
+
+static int wilc_suspend(struct wiphy *wiphy, struct cfg80211_wowlan *wow)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+
+	if (!wow && wilc_wlan_get_num_conn_ifcs(wl))
+		wl->suspend_event =3D true;
+	else
+		wl->suspend_event =3D false;
+
+	return 0;
+}
+
+static int wilc_resume(struct wiphy *wiphy)
+{
+	return 0;
+}
+
+static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
+{
+	struct wilc *wl =3D wiphy_priv(wiphy);
+	struct wilc_vif *vif;
+
+	mutex_lock(&wl->vif_mutex);
+	vif =3D wilc_get_wl_to_vif(wl);
+	if (IS_ERR(vif)) {
+		mutex_unlock(&wl->vif_mutex);
+		return;
+	}
+
+	netdev_info(vif->ndev, "cfg set wake up =3D %d\n", enabled);
+	mutex_unlock(&wl->vif_mutex);
+}
+
+static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+			enum nl80211_tx_power_setting type, int mbm)
+{
+	int ret;
+	s32 tx_power =3D MBM_TO_DBM(mbm);
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+
+	if (tx_power < 0)
+		tx_power =3D 0;
+	else if (tx_power > 18)
+		tx_power =3D 18;
+	ret =3D wilc_set_tx_power(vif, tx_power);
+	if (ret)
+		netdev_err(vif->ndev, "Failed to set tx power\n");
+
+	return ret;
+}
+
+static int get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+			int *dbm)
+{
+	int ret;
+	struct wilc_vif *vif =3D netdev_priv(wdev->netdev);
+	struct wilc *wl =3D vif->wilc;
+
+	/* If firmware is not started, return. */
+	if (!wl->initialized)
+		return -EIO;
+
+	ret =3D wilc_get_tx_power(vif, (u8 *)dbm);
+	if (ret)
+		netdev_err(vif->ndev, "Failed to get tx power\n");
+
+	return ret;
+}
+
+static const struct cfg80211_ops wilc_cfg80211_ops =3D {
+	.set_monitor_channel =3D set_channel,
+	.scan =3D scan,
+	.connect =3D connect,
+	.disconnect =3D disconnect,
+	.add_key =3D add_key,
+	.del_key =3D del_key,
+	.get_key =3D get_key,
+	.set_default_key =3D set_default_key,
+	.add_virtual_intf =3D add_virtual_intf,
+	.del_virtual_intf =3D del_virtual_intf,
+	.change_virtual_intf =3D change_virtual_intf,
+
+	.start_ap =3D start_ap,
+	.change_beacon =3D change_beacon,
+	.stop_ap =3D stop_ap,
+	.add_station =3D add_station,
+	.del_station =3D del_station,
+	.change_station =3D change_station,
+	.get_station =3D get_station,
+	.dump_station =3D dump_station,
+	.change_bss =3D change_bss,
+	.set_wiphy_params =3D set_wiphy_params,
+
+	.set_pmksa =3D set_pmksa,
+	.del_pmksa =3D del_pmksa,
+	.flush_pmksa =3D flush_pmksa,
+	.remain_on_channel =3D remain_on_channel,
+	.cancel_remain_on_channel =3D cancel_remain_on_channel,
+	.mgmt_tx_cancel_wait =3D mgmt_tx_cancel_wait,
+	.mgmt_tx =3D mgmt_tx,
+	.mgmt_frame_register =3D wilc_mgmt_frame_register,
+	.set_power_mgmt =3D set_power_mgmt,
+	.set_cqm_rssi_config =3D set_cqm_rssi_config,
+
+	.suspend =3D wilc_suspend,
+	.resume =3D wilc_resume,
+	.set_wakeup =3D wilc_set_wakeup,
+	.set_tx_power =3D set_tx_power,
+	.get_tx_power =3D get_tx_power,
+
+};
+
+static void wlan_init_locks(struct wilc *wl)
+{
+	mutex_init(&wl->hif_cs);
+	mutex_init(&wl->rxq_cs);
+	mutex_init(&wl->cfg_cmd_lock);
+	mutex_init(&wl->vif_mutex);
+
+	spin_lock_init(&wl->txq_spinlock);
+	mutex_init(&wl->txq_add_to_head_cs);
+
+	init_completion(&wl->txq_event);
+	init_completion(&wl->cfg_event);
+	init_completion(&wl->sync_event);
+	init_completion(&wl->txq_thread_started);
+}
+
+int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type=
,
+		       const struct wilc_hif_func *ops)
+{
+	struct wilc *wl;
+	struct wilc_vif *vif;
+	int ret;
+
+	wl =3D wilc_create_wiphy(dev);
+	if (!wl)
+		return -EINVAL;
+
+	ret =3D wilc_wlan_cfg_init(wl);
+	if (ret)
+		goto free_wl;
+
+	*wilc =3D wl;
+	wl->io_type =3D io_type;
+	wl->hif_func =3D ops;
+	wl->enable_ps =3D false;
+	wl->chip_ps_state =3D WILC_CHIP_WAKEDUP;
+	INIT_LIST_HEAD(&wl->txq_head.list);
+	INIT_LIST_HEAD(&wl->rxq_head.list);
+
+	wl->hif_workqueue =3D create_singlethread_workqueue("WILC_wq");
+	if (!wl->hif_workqueue) {
+		ret =3D -ENOMEM;
+		goto free_cfg;
+	}
+	vif =3D wilc_netdev_ifc_init(wl, "wlan%d", WILC_STATION_MODE,
+				   NL80211_IFTYPE_STATION, false);
+	if (IS_ERR(vif)) {
+		ret =3D PTR_ERR(vif);
+		goto free_hq;
+	}
+
+	wlan_init_locks(wl);
+
+	return 0;
+
+free_hq:
+	destroy_workqueue(wl->hif_workqueue);
+
+free_cfg:
+	wilc_wlan_cfg_deinit(wl);
+
+free_wl:
+	wiphy_unregister(wl->wiphy);
+	wiphy_free(wl->wiphy);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
+
+struct wilc *wilc_create_wiphy(struct device *dev)
+{
+	struct wiphy *wiphy;
+	struct wilc *wl;
+	int ret;
+
+	wiphy =3D wiphy_new(&wilc_cfg80211_ops, sizeof(*wl));
+	if (!wiphy)
+		return NULL;
+
+	wl =3D wiphy_priv(wiphy);
+
+	memcpy(wl->bitrates, wilc_bitrates, sizeof(wilc_bitrates));
+	memcpy(wl->channels, wilc_2ghz_channels, sizeof(wilc_2ghz_channels));
+	wl->band.bitrates =3D wl->bitrates;
+	wl->band.n_bitrates =3D ARRAY_SIZE(wl->bitrates);
+	wl->band.channels =3D wl->channels;
+	wl->band.n_channels =3D ARRAY_SIZE(wilc_2ghz_channels);
+
+	wl->band.ht_cap.ht_supported =3D 1;
+	wl->band.ht_cap.cap |=3D (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
+	wl->band.ht_cap.mcs.rx_mask[0] =3D 0xff;
+	wl->band.ht_cap.ampdu_factor =3D IEEE80211_HT_MAX_AMPDU_8K;
+	wl->band.ht_cap.ampdu_density =3D IEEE80211_HT_MPDU_DENSITY_NONE;
+
+	wiphy->bands[NL80211_BAND_2GHZ] =3D &wl->band;
+
+	wiphy->max_scan_ssids =3D WILC_MAX_NUM_PROBED_SSID;
+#ifdef CONFIG_PM
+	wiphy->wowlan =3D &wowlan_support;
+#endif
+	wiphy->max_num_pmkids =3D WILC_MAX_NUM_PMKIDS;
+	wiphy->max_scan_ie_len =3D 1000;
+	wiphy->signal_type =3D CFG80211_SIGNAL_TYPE_MBM;
+	memcpy(wl->cipher_suites, wilc_cipher_suites,
+	       sizeof(wilc_cipher_suites));
+	wiphy->cipher_suites =3D wl->cipher_suites;
+	wiphy->n_cipher_suites =3D ARRAY_SIZE(wilc_cipher_suites);
+	wiphy->mgmt_stypes =3D wilc_wfi_cfg80211_mgmt_types;
+
+	wiphy->max_remain_on_channel_duration =3D 500;
+	wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
+				BIT(NL80211_IFTYPE_AP) |
+				BIT(NL80211_IFTYPE_MONITOR) |
+				BIT(NL80211_IFTYPE_P2P_GO) |
+				BIT(NL80211_IFTYPE_P2P_CLIENT);
+	wiphy->flags |=3D WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+
+	set_wiphy_dev(wiphy, dev);
+	wl->wiphy =3D wiphy;
+	ret =3D wiphy_register(wiphy);
+	if (ret) {
+		wiphy_free(wiphy);
+		return NULL;
+	}
+	return wl;
+}
+
+int wilc_init_host_int(struct net_device *net)
+{
+	int ret;
+	struct wilc_vif *vif =3D netdev_priv(net);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	timer_setup(&vif->during_ip_timer, clear_during_ip, 0);
+
+	priv->p2p_listen_state =3D false;
+
+	mutex_init(&priv->scan_req_lock);
+	ret =3D wilc_init(net, &priv->hif_drv);
+	if (ret)
+		netdev_err(net, "Error while initializing hostinterface\n");
+
+	return ret;
+}
+
+void wilc_deinit_host_int(struct net_device *net)
+{
+	int ret;
+	struct wilc_vif *vif =3D netdev_priv(net);
+	struct wilc_priv *priv =3D &vif->priv;
+
+	priv->p2p_listen_state =3D false;
+
+	mutex_destroy(&priv->scan_req_lock);
+	ret =3D wilc_deinit(vif);
+
+	del_timer_sync(&vif->during_ip_timer);
+
+	if (ret)
+		netdev_err(net, "Error while deinitializing host interface\n");
+}
+
--=20
2.7.4

