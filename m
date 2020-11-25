Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C212C3F36
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgKYLlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 06:41:12 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:51746 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYLlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606304470; x=1637840470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qPxkbBU/85AZngGcyzLQrAu7gYT8WS5mnobx/iPf3us=;
  b=hMTGttyur6/eVuex4Y66JhUE0hCEN+FPLe0Bx8WuVf0bB1C/0wRHUA94
   j1YuLKXQ+TIN9f3c+Naxs/U1zBVKydgHGHd1DfF0vOBQUJslTdpgf21NA
   govYzI8O1KsPhM7Yv2JdrC+grDFgr5F0Te1wqVtI+BSgwG9ScLrVG6aWq
   eSYHGtpQhBK8aHo8ff/pFJ6/KUhkWjgQekpG6kuVBkTXI2aoWtSLxrH6P
   aNtn0512Mr3mNc/XIGr26DClQEKsU6PwRBP97B+i5wFFiJT2YziDuis0n
   vYwYxDbQjs1glG2CctTfDFzY8QsukUcbwEEEm4BFgV/1B+glPy4ZBHk0Z
   g==;
IronPort-SDR: guo5uVhuClmmHG2EtZvvytyexcD8QVzE3xeejQc3TwcQULI34W7nHyFA5//HC3H2esFG1Q3+lZ
 VPgIYk5bCrTiDxtbbrliI4Gg6DFA8rz6OFAsQek2u5fmJn2rg9a5KHuOa1NimWhDkiMGMF7Hjh
 PSJakw2mKj6icZN/KNungvho7Grz/8DmyiPslG79KQFaq0P0VMTX7NteAP0oFWtlHQwSqp038L
 am22AXPjtkqueft2S4cwZtjWSwNo2vL2J2A12Vx4yA+1clBxVnkuhnbH+tngU+qZ/q7HyG3GBS
 f48=
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="100348213"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 04:41:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 04:41:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 25 Nov 2020 04:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK1pMQFMIw2DAIBfNLyNswbxDr4PSbfB2Icxe8sgu8oH8Jey/G3Mol0zhmdcMBV7FK2ik8bbFMDL0wcFz6D15beh+0sSMYOLPYbbQLJS/jMaI5R80rsExQGQ27DH5SJDRjtCt+/II68EgClKT5VUUV5oUDxOkuZn3/Sr1vVQYvS8cpo2xGI2/wWh1Qyi+d9sCNYvjKcu8FT0H1lmHLxxWgr9SAwAVj6vPDiH2XBW0Gq2smw2T0h9HvrNBxr5SpmqEHWB0c3W/eg8MsqeGCODr553Gc5Ce2ic+2jqY8Xi9yTwwXjdoqawZKkKNoqVTYE3um5/oOxeX020IUFd9UltEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyPY2/kVfl6grF9AJ+FWy2876/dkxnkSb8F5XyGJkPE=;
 b=oSbRoDvfxoppmJhDM+cNVyedcPQVO5IMJvcrfVDr6kged5Oafdit4TkBINQZPav0vABGt4ThDo6YQbrywy+MQUhdGubLUzjqAHOGZcEbh8iy2u2M5pXmFX19zWgejkrlIzKwFUUDtx0+JvQqammZVO4dJl59sMjPfh0mxhqq+jSdOczOu9lhE9ikdSetxNSn0fzTtPoz/SYMPCIHygYljFsEEX62eu7cZtcbRPbEtUa9ZTnpd8HepIfmvKYTguTqpzyFAGd18NaW4I9W7A95YCqdLay0ZY/z9FaC3jxgtJkdo08l9kVVHQ9ygEmpkue0IVwFTs5l4luTpLKGIFDGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyPY2/kVfl6grF9AJ+FWy2876/dkxnkSb8F5XyGJkPE=;
 b=Be+WLXndbJ16xKygOpPuRIWI8ENDC3s/whmeLJUZJwP6udMK+btTMhGSI01lwL9/jhiLKPc7B0L6dT9VN/6wsGODauGSpsTE6oQIdpabkzn3t6vhyjpmQjCdkPdbTqEEWklBGhG3NpE79t8OmT7SuIzJuo33TS7CG2ArhgbVuOo=
Received: from CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21)
 by CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 11:41:08 +0000
Received: from CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988]) by CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988%6]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:41:08 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/5] wilc1000: added 'ndo_set_mac_address' callback support
Thread-Topic: [PATCH 1/5] wilc1000: added 'ndo_set_mac_address' callback
 support
Thread-Index: AQHWwx/dBWbbhXDpIE29CGrbpOduxQ==
Date:   Wed, 25 Nov 2020 11:41:08 +0000
Message-ID: <20201125114059.10006-2-ajay.kathat@microchip.com>
References: <20201125114059.10006-1-ajay.kathat@microchip.com>
In-Reply-To: <20201125114059.10006-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [171.61.34.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 807d1767-daff-4a5b-7533-08d89136fffe
x-ms-traffictypediagnostic: CY4PR11MB1605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB16052884C2468AD9616C0789E3FA0@CY4PR11MB1605.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wqlywXB9+O7MXpCOucljmT2NDrmUwzhXNJDxMiEHE2xT8r/cE+AGuSbWri9VLOxyZKC1TecfxMDipfTq2TLiF0/GFe470DxOqsBGytJ7Ikfu2mjGpyAHGrmFSVKsm499pXePplVQUTznKxHS3pRO9ZunK3GllThjS+D507wu1YeMPyER6ima0rDs3CXcAiECT+slf9uNpO7OFkC52O5mHS6GVJhq+GvdCpFl9O5RDRuRCSyAwokxvYEXEHCSvbh0lZ/9/dO4/tjBtqrRUzfiNevw+61hjlZZ0Ayw60PLzrMseE6IuYjyr3Krrx1oDBI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(396003)(376002)(66446008)(66556008)(107886003)(2616005)(6486002)(4326008)(5660300002)(66476007)(36756003)(54906003)(71200400001)(76116006)(8936002)(64756008)(110136005)(2906002)(6506007)(66946007)(86362001)(186003)(91956017)(478600001)(83380400001)(26005)(316002)(8676002)(1076003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ORwWEzSkRygUvNFbDuDffBwLaX1xsdjzeTnUKAZ+ki0i9bwldyDQNZX+x7WcFKcnArxmT8CmbIFFcjrKu9+Ab5/3AxueyCAs69VIUtT81r7HcgArIhDb7ro3UKBzoJPGYm+d5vbC0fE7x9PmMf5VQQg8UHlWSY3gPeTUeyqk4MWRv7Ll3IkX4s1WuIn/BZ4Q+7TkMt/LQq+zET+Mt0g5vaej7hh6MhIeKA+MpyDHZydxnHYjzqzUg7xMDsNUf9R/Sp242ChOvMdrCZR722DrRyBpLGFIw+oB0NTkoVick6hV91r5vxAA8NCTrdj4W2mKrFy6BTS5pbAna+yHsI+nJFztE3cMv+SnWFe+Oal0+yFsLHi9dFkZFLoZzEroLg1HFD/EAPjf6FrLZAd2Dg/gMNhI5ZKqJs2GMJDXI5TS/iNjaoXr/IGO6zuW2Ak0ZplIpebtW/AUY6U3Wn+r6fo5sD9409TQUwR4uD2PqwaUBgoviR+RZr4LjG7rJBjvkqjpSwa+wW3mV/aTvPklJ88v8Bu0D1y5Ws3MhU1cdrcjs+gKNT2MNZ+3Tahn/8xAt4UCbo1jfy+PbqYpWvtsJ5xcPod09oiTrrQgcnSq0dAppgypEMallfh6RRGcqfKwBwtmrrl3Zkl61NU83nhOdDxjpuoh3r0Ot+7eajHsD2G64PRNuMU+2eEz1tvSgIHGPb0Y4EtCDVPxbnH1MpdoQ4999NNNYxxgX/ChJPwJOeQtuTaubm6H4XjuwSHGbpkQ5BSO5Bmw6Pcv2ACTZlbegB4KrsuchRWhvMDF0ZGMYt0VBgjX8t7wRCgzWrzgjU5T/LqiBCFlc5VwPVt/dDRiIhKUqJVPvrPY+hu2qPHAi2AwPzZwl+OxROUily036Q7HdvXYVjtbAugqkIAMLOvcoPuKqA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807d1767-daff-4a5b-7533-08d89136fffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:41:08.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbVG9J/H79bieyLXA5hZnYWqAmiJmI6/JKEe++YaMFBW7YuNvFO00rhOPxLQVfKan2GCKAvWsUO/Wolt1KOOatzg+i341mI3jcGE5YiIVIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1605
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added support for 'ndo_set_mac_address call' callback to allow change of
interface MAC address.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 17 +++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  1 +
 .../net/wireless/microchip/wilc1000/netdev.c  | 38 +++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index d025a3093015..a133736a7821 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1276,6 +1276,23 @@ int wilc_get_mac_address(struct wilc_vif *vif, u8 *m=
ac_addr)
 	return result;
 }
=20
+int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr)
+{
+	struct wid wid;
+	int result;
+
+	wid.id =3D WID_MAC_ADDR;
+	wid.type =3D WID_STR;
+	wid.size =3D ETH_ALEN;
+	wid.val =3D mac_addr;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to get mac address\n");
+
+	return result;
+}
+
 int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
 		      size_t ies_len)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index db9179171f05..58811911213b 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -168,6 +168,7 @@ int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_=
gtk, u8 gtk_key_len,
 		    u8 cipher_mode);
 int wilc_set_pmkid_info(struct wilc_vif *vif, struct wilc_pmkid_attr *pmki=
d);
 int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr);
+int wilc_set_mac_address(struct wilc_vif *vif, u8 *mac_addr);
 int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
 		      size_t ies_len);
 int wilc_disconnect(struct wilc_vif *vif);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 20615c7ec168..2a1fbbdd6a4b 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -628,6 +628,43 @@ static struct net_device_stats *mac_stats(struct net_d=
evice *dev)
 	return &vif->netstats;
 }
=20
+static int wilc_set_mac_addr(struct net_device *dev, void *p)
+{
+	int result;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	struct sockaddr *addr =3D (struct sockaddr *)p;
+	unsigned char mac_addr[ETH_ALEN];
+	struct wilc_vif *tmp_vif;
+	int srcu_idx;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EINVAL;
+
+	srcu_idx =3D srcu_read_lock(&wilc->srcu);
+	list_for_each_entry_rcu(tmp_vif, &wilc->vif_list, list) {
+		wilc_get_mac_address(tmp_vif, mac_addr);
+		if (ether_addr_equal(addr->sa_data, mac_addr)) {
+			if (vif !=3D tmp_vif) {
+				srcu_read_unlock(&wilc->srcu, srcu_idx);
+				return -EINVAL;
+			}
+			srcu_read_unlock(&wilc->srcu, srcu_idx);
+			return 0;
+		}
+	}
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
+
+	result =3D wilc_set_mac_address(vif, (u8 *)addr->sa_data);
+	if (result)
+		return result;
+
+	ether_addr_copy(vif->bssid, addr->sa_data);
+	ether_addr_copy(vif->ndev->dev_addr, addr->sa_data);
+
+	return result;
+}
+
 static void wilc_set_multicast_list(struct net_device *dev)
 {
 	struct netdev_hw_addr *ha;
@@ -813,6 +850,7 @@ static const struct net_device_ops wilc_netdev_ops =3D =
{
 	.ndo_init =3D mac_init_fn,
 	.ndo_open =3D wilc_mac_open,
 	.ndo_stop =3D wilc_mac_close,
+	.ndo_set_mac_address =3D wilc_set_mac_addr,
 	.ndo_start_xmit =3D wilc_mac_xmit,
 	.ndo_get_stats =3D mac_stats,
 	.ndo_set_rx_mode  =3D wilc_set_multicast_list,
--=20
2.24.0
