Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C74175F7A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCBQXi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:23:38 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:59180 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCBQXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:23:38 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RuZYtSUifZ0w9rsxmR092xcv10TFTRViUj/QXkQEyd5TFhYfPbSa8SEDfVvJTcM9nsZhcHdWcN
 YvNFBkRGeLxUDk5DDlWhH14scN5/iEj6TbC99675gHPE3cEzQj8JO39BSQ9iiH58ReNf2LIS/H
 aUwbbb8XJwssWkdJa2+CVIpmmpZ70sGKB/Z+j54QwTHX5C91sjlSGZPdaWaQvKBHcTisxNqAwA
 kP2u/8suirz/hdVpD8JZRZ+FhWwuMCocPnK/+lfn5+4B1tohTdGzlhI9KZ0OTJOMJ8mkqVKrxR
 KaQ=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="65862660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:23:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:23:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDBGBw9dkhxrTuXS41NCLkWWNRKRrqwMfRdcpTnTNg9MDUdA3kVhbFky97uvCAWkI9Yfi6tiBbaRtqvoOkEBVRkNNl5hGbwKx2UOPBPpZc1mcJQZKXpMPHIEVRvXdjLYO67H+RWG+npWIL06Qs1v0WeWp1yxRz3EXIsQQkP8vLyqIXfob/wITovMBbI5445pvJxU/We/nQCgpmQWithUdTUmAm5j+vC8NeEwxxH3qdKs0Oo877nAoH7xhA3IcQXSXtbzoF4FW1lj4Jn6dC+0hAKOoB1L+T3xeU0xfh+TRUqBnEh4ctZ7uE2gQ2RRD1DGSX2FVPNPbJUa4rAZOVXIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0T4qkDjuLZw+qtc10X2x4gNCeVnU/NWefbyunAGQ5c=;
 b=ZbaOqFtO147738rpLDQAGdAKUPEjJAc0mB7SWK3NU8rsnCmvoo/8doRbqPbN/z7TKq2/0K/CWX1KRZk4buEex/NVTt/Z0kcVx6+xaUGYJn6VaLasu5KeEQzij3v2/nRSSYfD0G0dHM7lbQo6j9oNdIzUtp1rQTWHzcIUvE7dMatsSDqG/9v2WzYcLQ+W5IH16IpUh4LaGeO7Yi0ST+24t8z6gtK4hz3V49Vi9PgXD+NyKUw5ZbygDWkQytt+NNB6oINpeYYdpoUohmYGvsqRKHjsK2XYjxgY9E20Y2LvSRkUMioEu8JrIY9Mq1urNVWLmEt+xtj1JMOidJGrSYRqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0T4qkDjuLZw+qtc10X2x4gNCeVnU/NWefbyunAGQ5c=;
 b=Pzm+uNgSlR6L1Ajst5lWB8oWVGDx/onTxVBTQ5yu9V8bxzy6yJeYWZkWy588f16uaL1Xnd0O8DcgkNRtba0eYEAIAA/LgUOQp7oN/t84+/TjLlymzOExd4glRgMfyHasCyZ8BaEP/7ltl1R1sHcshN54p5cP3N1rwwdjMRGGqT8=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1426.namprd11.prod.outlook.com (2603:10b6:405:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 16:22:36 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:22:35 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/3] staging: wilc1000: remove unnecessary always true 'if'
 conditions
Thread-Topic: [PATCH 2/3] staging: wilc1000: remove unnecessary always true
 'if' conditions
Thread-Index: AQHV8K7IwDsMZBV4z0mZivbYZpT6/A==
Date:   Mon, 2 Mar 2020 16:22:35 +0000
Message-ID: <20200302162226.4196-3-ajay.kathat@microchip.com>
References: <20200302162226.4196-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302162226.4196-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e91d57e3-42eb-44ce-5d97-08d7bec5eb31
x-ms-traffictypediagnostic: BN6PR11MB1426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB142622FAB38B603FA84AA75DE3E70@BN6PR11MB1426.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(966005)(5660300002)(66556008)(186003)(26005)(66476007)(64756008)(66446008)(6916009)(478600001)(6486002)(6506007)(6512007)(107886003)(86362001)(66946007)(91956017)(76116006)(316002)(8936002)(71200400001)(1076003)(81166006)(81156014)(8676002)(54906003)(2616005)(2906002)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1426;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZN4S2/56F1ApZsMVDY1UWauf5PYLjpJWfgnbGmXvpk1nf3wYyegVQcQq4Lx9C7mD6C+fX5nlQVaUv8I3TwAbHJTLUheeoA9LYX61+P+kQZG6MnbTUiukTBQEpWfIm3xFfDALWxB/UfFUPWav4dJ+tuiJVtFj9wjroG5cxiDVt9r7skAO6uUob1Io9NW3UnsNq1PEE6xj2DpeoMnnSkOjz3SBPaF8/GEzcgkyOBnxUK8MMt1TRiE4ZDimyeIiGlfs9vlLUky3r3FY/YI9nx/TGyci9x+F1DwlWWoauDQbCCJbV6UEtLZUmaZUyUJIo1Yc9UACn9ABBxthwkcLQnr1lwuB7vTkdrWwxNxvw7xcMV14rIggqWJUYJsL8ANCkF6QyVPM7ITd5lIIDoO7nI0Xb+GbXwKtKQmjQbLdZWkK3MgNvozpFugL5hfIPb8Hj/NwpdyhOKGecqJ+naX/f0x7sK7Z/1i7mlxuzG7Jf6NY0F9wjbIz2q5/sBd8xE4aW9XFx5R1ntV0ePEv/GoPgw8ig==
x-ms-exchange-antispam-messagedata: sPtzICTNsXVPMRNmsmFh0EpmV7JRLSQAo18pTZqsBgfB66TNZs2rcE9pVFRf+CxjCLe5b/nm38TA+KFUn+Xms1ss3irEAKtODBz7FWfyMBMgq8jQ6O3ZtaQuPg/+K3JbMPR62UEFXNV8hNby1V5i1A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e91d57e3-42eb-44ce-5d97-08d7bec5eb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:22:35.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iji25J9bAAEUtPTxbIJeXM4TzWR3CUzNOwZdhvxMqSWWi6ZGVguFaLcuIMUmMur5tOXAGJuyvvs9oo/YCUgphI9QAzE03jLzIPHmscp9+rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1426
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove the unnecessary always true 'if' conditions and simiplifed the
logic as suggested in [1].

[1]. https://lore.kernel.org/linux-wireless/20200302092346.GA24308@kadam/

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/cfg80211.c | 26 ++++++++++++--------------
 drivers/staging/wilc1000/wlan.c     |  6 ++----
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000=
/cfg80211.c
index 5d8faa01337d..54e02807cebf 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -888,7 +888,6 @@ static int del_pmksa(struct wiphy *wiphy, struct net_de=
vice *netdev,
 		     struct cfg80211_pmksa *pmksa)
 {
 	u32 i;
-	int ret =3D 0;
 	struct wilc_vif *vif =3D netdev_priv(netdev);
 	struct wilc_priv *priv =3D &vif->priv;
=20
@@ -901,21 +900,20 @@ static int del_pmksa(struct wiphy *wiphy, struct net_=
device *netdev,
 		}
 	}
=20
-	if (i < priv->pmkid_list.numpmkid && priv->pmkid_list.numpmkid > 0) {
-		for (; i < (priv->pmkid_list.numpmkid - 1); i++) {
-			memcpy(priv->pmkid_list.pmkidlist[i].bssid,
-			       priv->pmkid_list.pmkidlist[i + 1].bssid,
-			       ETH_ALEN);
-			memcpy(priv->pmkid_list.pmkidlist[i].pmkid,
-			       priv->pmkid_list.pmkidlist[i + 1].pmkid,
-			       WLAN_PMKID_LEN);
-		}
-		priv->pmkid_list.numpmkid--;
-	} else {
-		ret =3D -EINVAL;
+	if (i =3D=3D priv->pmkid_list.numpmkid)
+		return -EINVAL;
+
+	for (; i < (priv->pmkid_list.numpmkid - 1); i++) {
+		memcpy(priv->pmkid_list.pmkidlist[i].bssid,
+		       priv->pmkid_list.pmkidlist[i + 1].bssid,
+		       ETH_ALEN);
+		memcpy(priv->pmkid_list.pmkidlist[i].pmkid,
+		       priv->pmkid_list.pmkidlist[i + 1].pmkid,
+		       WLAN_PMKID_LEN);
 	}
+	priv->pmkid_list.numpmkid--;
=20
-	return ret;
+	return 0;
 }
=20
 static int flush_pmksa(struct wiphy *wiphy, struct net_device *netdev)
diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index 3aeca882f431..6a82fb2f283e 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -703,10 +703,8 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc=
, u8 *buffer, int size)
 			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
 		} else {
 			if (!is_cfg_packet) {
-				if (pkt_len > 0) {
-					wilc_frmw_to_host(wilc, buff_ptr,
-							  pkt_len, pkt_offset);
-				}
+				wilc_frmw_to_host(wilc, buff_ptr, pkt_len,
+						  pkt_offset);
 			} else {
 				struct wilc_cfg_rsp rsp;
=20
--=20
2.24.0
