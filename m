Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6035E78A6
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 19:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfJ1Skk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 14:40:40 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35380 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfJ1Skk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 14:40:40 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: UNetet4Nl8un5cuokevncacgzb0ayuz5ORhHc6CCLbdBYZ4X5lveDkOPkE0XBhMOj+GFyPO6ja
 D4/XwTGyamegioDBB8Axw3cNhKw+p90MXjtacfDSXpEJGCaFaK3W8FEO+QKAyV3kZCozdTalgx
 SmkDf25Ehbt2XZpPHul8wVuisLXr9C1F8wp/H/ppjY42g9jWWJUhi4vhiAr/YwFTrRN48X7j8U
 vjzykhr3SmQWaYvzOeo+MJqMCWt+AcCchwbUfEfQZdFaGKtGR+2YeY/c1JnYUbUFAZORjPf+zj
 XMM=
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="51859965"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2019 11:40:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 11:40:32 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 11:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/bwcWOkqWRRprR9RyBPVywMJvaj7vxVd261ZZLac3WfB+oJ3qyDGRGE4keY7MOXC4OjdPUNTrYbUF0kFg9qz/Bshb5GCeuhbP9K4Zb4uqCH85uAHlK3fRRq+BWFRfHwt9uJcCLgyFKR/dqhcR1LSizYJztkdznmeseCFXeYHXvYIBrSo3wBIkmfOpvqJch4gbBjrupix5A6VZAxejH6QvsJT9XlRCG+b9Qed2SMzWe/iFtEBIteJ4h3bHCC7qHw5IsxJ66AEBYl5wUjvrD6STn2eyopPYXa3XcfPtUxRpGlEvDbLItjwu/k/uyHZ5VUo6Q/9kNBcDN3osBxNIbpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6l4Zw8RjY7L/anuOH+l8qrEb/OlmN6mUpPaU8WxIjE=;
 b=HkYh/aRTsgJRP49fMrbvFSWfSHKS+NwazHTtQH9iwxP6pm02NPt6sCMv9e9XLIYlL2VhgfO/6Qlkd1ELJddXVirl7INrP8Z60iP6wNT2A+Y/ideQDcaJWuMKlVDO97B6sHIHxZdfPyu/+dBlERMG6TNlMtyrRHopOJ93nZGUDxnJl9J+x40BTU2dY3b7n3OCApl8EcKaAyWMbNICMOrSbe1J5d+stZTrDJ9sfqW3KiSug953i0i7+RqkrxaT1oaLEkZhYgY1ElTOVTaRo+fpSSL1OxBdzdNTXXCpko15Pituibk5mMIfCIQUdvZUM9uIt+PHkf+CJIWh6pwAM2VIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6l4Zw8RjY7L/anuOH+l8qrEb/OlmN6mUpPaU8WxIjE=;
 b=rweWm0/m0rj332LMLbA5+iC3BUqqtzyYAAgfWZBrp2cFx9gbssmqHwdaNRmvNnk0maI6GsQmHMF0+Pg3uhNJlSCNaqttw5xp3gWNvfPPFeBl9sH+XOK1bcWiZ5qcvwFhjmg/p64e7+d1+nFj8OqrRZsFWp+74iDQcA89MnoTcUY=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1357.namprd11.prod.outlook.com (10.169.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 18:40:26 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20%12]) with mapi id 15.20.2387.025; Mon, 28 Oct
 2019 18:40:26 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: check if device is initialzied before
 changing vif
Thread-Topic: [PATCH] staging: wilc1000: check if device is initialzied before
 changing vif
Thread-Index: AQHVjb8q94hkn7Bx+keiQt3ysOkP/A==
Date:   Mon, 28 Oct 2019 18:40:26 +0000
Message-ID: <20191028184019.31194-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To MWHPR11MB1373.namprd11.prod.outlook.com (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e787b35-4a38-47f1-aa4b-08d75bd64c91
x-ms-traffictypediagnostic: MWHPR11MB1357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1357BD77A7EF9A21150358608D660@MWHPR11MB1357.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(102836004)(2906002)(71190400001)(14454004)(305945005)(71200400001)(5640700003)(316002)(4326008)(256004)(6436002)(6116002)(6512007)(3846002)(107886003)(476003)(8676002)(2616005)(6916009)(25786009)(486006)(386003)(81166006)(81156014)(36756003)(66066001)(8936002)(99286004)(478600001)(86362001)(6506007)(26005)(54906003)(52116002)(50226002)(6486002)(186003)(66556008)(5660300002)(66476007)(1076003)(66946007)(2501003)(66446008)(64756008)(2351001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1357;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FT/NaqCBZxJp4AHPlyYS8IYRfqFkGziImopXVKv7LReq7oKiLqnw7CtpmXS3fhGOp1yYJcw/sd1JQarrmkLfV+fWdha7CuGvpVzqcpdHBC3FLjSB7wXsCZVl47FtVaBnxPV9+JqQo1p/4XBdEg2TyQnBImNpiAmf8fnt5arwV1JtXpghbpivj9rbd4XnVv0LlgE6zf4HbAh6ordGPbvkfpBzUluQ+JczEl72YtPMm6kYiKu9uX0Y2CldMh0yWCM7OnjpLRAGK5zw6ERPBbM+6mBSK+JBq0VpsJp6mSF//pb4wu3nQ6QLjKWHDmt3u7IvQIMlCdZAJFEBbplMW3xDvh+XWxyFcAUDLUlPuW7CSCUEtZG5O3pWG6djtjQq1CZwRr7iz+JFrKpw8e5mX1F64HYVw57vGxEoEXQnMDq8Q9TQaChd+41NkyiGu4f7Aq9j
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e787b35-4a38-47f1-aa4b-08d75bd64c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 18:40:26.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IB0cnMMfkgYXZ8X+T6JhJstfqAU3ofJ9zYNE/r2ve7eVZJTMbqt0i57OttPanpUFY5aPMEXt4pDwlb+WAJc++g1bMlW2z3DEddAA84un/zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1357
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

When killing hostapd, the interface is closed which deinitializes the
device, then change virtual interface is called.
This change checks if the device is initialized before sending the
interface change command to the device

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 .../staging/wilc1000/wilc_wfi_cfgoperations.c  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index 9781f712ae3e..66328ac85adc 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1413,8 +1413,10 @@ static int change_virtual_intf(struct wiphy *wiphy, =
struct net_device *dev,
 		if (vif->iftype =3D=3D WILC_AP_MODE || vif->iftype =3D=3D WILC_GO_MODE)
 			wilc_wfi_deinit_mon_interface(wl, true);
 		vif->iftype =3D WILC_STATION_MODE;
-		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
-					WILC_STATION_MODE, vif->idx);
+
+		if (wl->initialized)
+			wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+						WILC_STATION_MODE, vif->idx);
=20
 		memset(priv->assoc_stainfo.sta_associated_bss, 0,
 		       WILC_MAX_NUM_STA * ETH_ALEN);
@@ -1426,8 +1428,10 @@ static int change_virtual_intf(struct wiphy *wiphy, =
struct net_device *dev,
 		priv->wdev.iftype =3D type;
 		vif->monitor_flag =3D 0;
 		vif->iftype =3D WILC_CLIENT_MODE;
-		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
-					WILC_STATION_MODE, vif->idx);
+
+		if (wl->initialized)
+			wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+						WILC_STATION_MODE, vif->idx);
 		break;
=20
 	case NL80211_IFTYPE_AP:
@@ -1444,8 +1448,10 @@ static int change_virtual_intf(struct wiphy *wiphy, =
struct net_device *dev,
 		dev->ieee80211_ptr->iftype =3D type;
 		priv->wdev.iftype =3D type;
 		vif->iftype =3D WILC_GO_MODE;
-		wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
-					WILC_AP_MODE, vif->idx);
+
+		if (wl->initialized)
+			wilc_set_operation_mode(vif, wilc_get_vif_idx(vif),
+						WILC_AP_MODE, vif->idx);
 		break;
=20
 	default:
--=20
2.17.1

