Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4348B759AA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfGYVbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:31:39 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:20977 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfGYVbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:38 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: AcVNhtcDfQFU2Cs29sd1aTQKsmyKWCP+k6Ob3NgckGsvXIFpRtnCY0Eomnd+wr/UbDq1oApIzq
 IMcw/iwGd8x6PHcQTKI9YlJqWTKb2p9Cx/3EKWpCfH1zt+WxAYHjilBnG7H2KFNlqCuEAdCLG7
 ZcAbJ+rlYRnbr+h4P9LbsikcdOa2khE4NoLpOs+ELt4nyfv9XhXwUfB9UN+nE/0R/F3p58PRId
 TDXEFHFIdytRFT/LoU9uUkdqDQPAijoXM+VVfZ0gdwLSQ3L2Feyt1HsP8VvekCweQ58Nimn+ve
 188=
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="42815736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 14:31:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 14:31:36 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 14:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S15pPVKXsx68dl7NXpIzIhDX6l2pHp8w4J65zXftg6w1thpOFb9SpZOp4N5KYHF6nKLp0Y/fc1XAwyXPO4Pf4EOUhYtl7RGjCuuxiJlLqmZZcNzGftyiynE63xuXslkoQh+qoU8ySDlar/icCwGoDrEgagMArl4wrXIsjfLJUGgu+2+Ws+zDvHzQMu9yVcWwdtCjOEP3OdX2sSku5NzqIBpHYEMsCLHYFFO0/wHMtwULzUL+tfPKMB2jq4x73zPVMHt9sAzEQhwlT5WwY1SzdwawsbTFvMxZ9T8nd1iefjQOmEtbi4Y4jU0Kihh3SxPC0ZT5UKr8PpUJl8377jlruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL33oM3PwYbtC0leddwZMempv2b1RF+7y6MhQ6V8Pss=;
 b=anx0q/dpEY0nRVPvbo37sMqPeDDPN1ga03cZEl1s/QY01NUaSmbuc4JffT5NGj5exX8NtSmaFZOiXtMAdnu4MIBJreqxtpbZY4IYEgVhxeNLPfW4QmPvhw4zUga19j/efUDjmhTtekqB9gfM1hMVEQlU968rbzwqu6/gDiEvsvvGH0Va3NthGgBopn/YpNuWIjRsoYV2Lv4vq57iSBRaOKIDjzaUt0+UH5HiZJ8Wt2RChgZcUFBnNi9aZaN933gy50/nVNR+M6TUr9vMOJwTXFpr//BjTrlNyXbyJQT3m8Y6C4zo43ArAMu4F+aCYi2MHp6glpnU/XpomkKZgmHgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL33oM3PwYbtC0leddwZMempv2b1RF+7y6MhQ6V8Pss=;
 b=qy6nrBD0UfuRabpNRtt6uh8LDcE0cAs5/zuflU6quON3lyieUdhjlx1ZEl29gZVQLlH5mNZUoYrkKiG6/UgQNQhJb78sKQiX0wTRinBwgbtOL6wU0MJi4LewROo0hhlQR5M0Nr0YH0GPeSJvo0N/dns44DOTr90XfZLdQ9vLj7w=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 21:31:35 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 21:31:35 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH 3/6] staging: wilc1000: remove unused members
Thread-Topic: [PATCH 3/6] staging: wilc1000: remove unused members
Thread-Index: AQHVQzBVmkV0XiIfSkqdQ0TzXZfFVQ==
Date:   Thu, 25 Jul 2019 21:31:34 +0000
Message-ID: <20190725213125.2810-4-adham.abozaeid@microchip.com>
References: <20190725213125.2810-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190725213125.2810-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: MWHPR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:300:ee::26) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 236b70ff-5205-4871-fa08-08d7114777ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984EF43439A34EA13468CBC8DC10@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:193;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(11346002)(2616005)(476003)(102836004)(386003)(446003)(486006)(6916009)(2351001)(6506007)(66946007)(186003)(99286004)(2501003)(76176011)(26005)(316002)(52116002)(5660300002)(66446008)(256004)(305945005)(6486002)(25786009)(64756008)(66556008)(66476007)(53936002)(1076003)(107886003)(71200400001)(86362001)(71190400001)(4326008)(14444005)(68736007)(478600001)(8936002)(6116002)(6512007)(14454004)(50226002)(8676002)(5640700003)(81166006)(81156014)(3846002)(2906002)(6436002)(66066001)(54906003)(7736002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J2krTnVpfDLQErzak6ihhZrsj/Y2ty/42MRPdhduOq1qmxwwL+ain4IYtQECDTazJwyCjTmE6SJxRuRP30w8FAnr6Tk4OEoCg6hAtn9mHvxRAqN26hLQeqlrxtsjq890R52zxrot9zXRyzalD31KEahiT23cx1cyV8GK1UMTbNltYCjJMK59wdyGs0ks59LS8n9g6tLc9D5fFUVrHB4sgI5j/rPWlSqTp46OPL6nl88Ui8BCPcS1iDULZdo5uZhbjtDkVpZiAbxlcNQh3Y8rFGzjkC99I+QPNxd2yp+A1l9uSrFm/hwgUZlhZk25oTeiQ6ZGMrAdUJ/23s37zw4bfKbxrxjciyK/IBP2hYWVyJbL4j95Z6VKHKFSDGIoIpv90z23mATBZzH+MAlOuVvyo7aN54S+XIg6cWSf85G5vHQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 236b70ff-5205-4871-fa08-08d7114777ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:31:34.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

remove obtaining_ip from struct wilc_vif

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_hif.c               | 9 ++-------
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 ---
 drivers/staging/wilc1000/wilc_wfi_netdevice.h     | 1 -
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index 9bd2d14ad610..611f842d2836 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -248,7 +248,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 =
scan_type,
 		goto error;
 	}
=20
-	if (vif->obtaining_ip || vif->connecting) {
+	if (vif->connecting) {
 		netdev_err(vif->ndev, "Don't do obss scan\n");
 		result =3D -EBUSY;
 		goto error;
@@ -682,8 +682,6 @@ static inline void host_int_parse_assoc_resp_info(struc=
t wilc_vif *vif,
 		wilc_set_power_mgmt(vif, 0, 0);
=20
 		hif_drv->hif_state =3D HOST_IF_CONNECTED;
-
-		vif->obtaining_ip =3D true;
 	} else {
 		hif_drv->hif_state =3D HOST_IF_IDLE;
 	}
@@ -707,7 +705,6 @@ static inline void host_int_handle_disconnect(struct wi=
lc_vif *vif)
 	}
=20
 	if (hif_drv->conn_info.conn_result) {
-		vif->obtaining_ip =3D false;
 		wilc_set_power_mgmt(vif, 0, 0);
=20
 		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF,
@@ -770,7 +767,6 @@ int wilc_disconnect(struct wilc_vif *vif)
 	wid.val =3D (s8 *)&dummy_reason_code;
 	wid.size =3D sizeof(char);
=20
-	vif->obtaining_ip =3D false;
 	wilc_set_power_mgmt(vif, 0, 0);
=20
 	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
@@ -922,7 +918,7 @@ static int handle_remain_on_chan(struct wilc_vif *vif,
 	if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP)
 		return -EBUSY;
=20
-	if (vif->obtaining_ip || vif->connecting)
+	if (vif->connecting)
 		return -EBUSY;
=20
 	remain_on_chan_flag =3D true;
@@ -1608,7 +1604,6 @@ int wilc_init(struct net_device *dev, struct host_if_=
drv **hif_drv_handler)
 	*hif_drv_handler =3D hif_drv;
=20
 	vif->hif_drv =3D hif_drv;
-	vif->obtaining_ip =3D false;
=20
 	if (wilc->clients_count =3D=3D 0)
 		mutex_init(&wilc->deinit_lock);
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index 5559f27c8e24..6ac0fe58ceed 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -167,7 +167,6 @@ static void cfg_connect_result(enum conn_event conn_dis=
conn_evt, u8 mac_status,
 	} else if (conn_disconn_evt =3D=3D CONN_DISCONN_EVENT_DISCONN_NOTIF) {
 		u16 reason =3D 0;
=20
-		vif->obtaining_ip =3D false;
 		priv->p2p.local_random =3D 0x01;
 		priv->p2p.recv_random =3D 0x00;
 		priv->p2p.is_wilc_ie =3D false;
@@ -1412,7 +1411,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 	priv->p2p.local_random =3D 0x01;
 	priv->p2p.recv_random =3D 0x00;
 	priv->p2p.is_wilc_ie =3D false;
-	vif->obtaining_ip =3D false;
=20
 	switch (type) {
 	case NL80211_IFTYPE_STATION:
@@ -1459,7 +1457,6 @@ static int change_virtual_intf(struct wiphy *wiphy, s=
truct net_device *dev,
 		break;
=20
 	case NL80211_IFTYPE_P2P_GO:
-		vif->obtaining_ip =3D true;
 		wilc_set_operation_mode(vif, WILC_AP_MODE);
 		dev->ieee80211_ptr->iftype =3D type;
 		priv->wdev.iftype =3D type;
diff --git a/drivers/staging/wilc1000/wilc_wfi_netdevice.h b/drivers/stagin=
g/wilc1000/wilc_wfi_netdevice.h
index 1e74a08e7cf1..704e4d572695 100644
--- a/drivers/staging/wilc1000/wilc_wfi_netdevice.h
+++ b/drivers/staging/wilc1000/wilc_wfi_netdevice.h
@@ -203,7 +203,6 @@ struct wilc_vif {
 	struct net_device *ndev;
 	u8 mode;
 	struct timer_list during_ip_timer;
-	bool obtaining_ip;
 	struct timer_list periodic_rssi;
 	struct rf_info periodic_stat;
 	struct tcp_ack_filter ack_filter;
--=20
2.17.1

