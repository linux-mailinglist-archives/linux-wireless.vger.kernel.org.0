Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1628EFA14
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfKEJvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:51:39 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:28039 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfKEJvj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:51:39 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 7DVj/YiA6VTqEEYOiOlG3YtrQ0B3zaNMpnGtREsDCgHPo+vu33s8Et5wt2eqidCqs8pgMviKLg
 0bcksLzMei4ima/lzxvHBXYGvHuOZsnFI0CIsQL+CsePDGVl6ywcTxbd08BuUZCR5jsZe2CekC
 6tkCaEJpW/pVSMv875WMfQOSa3+zDbP4Nm88N0PzRJYtpWWptn6RCIpjlsDYqgQuvMrkWp6ScB
 cAFkUyN7h9XswDvjxxSzW42VojhoJ7HX8A7n4TwpSBaihIXyBSeaF+VpHxxaN4Rh1IhwgAMQu8
 hsw=
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="55347263"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2019 02:51:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 02:51:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 5 Nov 2019 02:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=korfY6WFAFFsQjWEs+Y9aEf0+0b+DMuMdaniYCDNmg01O8Zexp6RyLMQQ2sIGIouh7L4Vi3WfBiLnHLbYqCS62Er/MwFwiwQfengGapkVRt4FyyS+IvEnX339hqFHhDVLL0j/bemgvkUlDVxVra/lyTwmvuzwDXfP6phG+98Y1YwwCSE6izyXNdfu2dOvk5t9Z5iAk1da3swsCorbDpo/sDvVxGJ2sc2rIvw9q5WAlUhLn34tSNaKyaCdkCTi6+Tp70TaaW5aG9xw5UNj5qYDW93tuyLbtgLXPbi2UEOsupH9hEikoKGfEFJVDPBD2bfmGJZIepFzz/yO3As9aod2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICLvsKY46TwBBTouyaWjAlTXn//H1RlTLAqgSNezE0w=;
 b=A44a2xPohjLr2I9JG7m3DSnCNaA/tkMmwKWHYXmgLXbxQaS2mlvjkGrEx+Ldt70JW7v5myGVobRhjIYDHbxQkmajWFl+yYQStybJzJETu5T5Cv+Hf/pAgeuy64rftWg7Fn+gVIhReoNasunprnQwifxa5VnxVIf2nsTEJd0Y+R6nKuUUgfrJa6DLwOJUxsumI9l6Eoo+rrRRfIT7BpvMNpkTSpIo7Xhs4303EVQb9q4y+kFIIAVYn5NxLD24rJv25vc5BqYIQUR8W+ZmbujrNgqc4CoeaugweU/rjGjm4/yobqjLrl5Q7qFJQ8pY4B4gU1r4gkAfC15LLVIjzcmuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICLvsKY46TwBBTouyaWjAlTXn//H1RlTLAqgSNezE0w=;
 b=GenCmDXZjmb/L4BYgkC0cUO7w7s3mRwgmYcl+5JFwZVXmwrW75GtdQJ+A0KIYUv7lneAJdZKyUIEUL4pGiiLcSl5vk4aVAz0zdGX3OpnrAlPfA6Xt4PUIZoDiOgM5oLajQKATlqYg4UZJ2/gqKNYf+hhx3riofpBmpocek7raz0=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1972.namprd11.prod.outlook.com (10.175.100.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:51:28 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:51:28 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/6] staging: wilc1000: added 'WILC_' prefix in header guard
 macro
Thread-Topic: [PATCH 3/6] staging: wilc1000: added 'WILC_' prefix in header
 guard macro
Thread-Index: AQHVk76YBU8d/Q2rzEitM8uyhib/bw==
Date:   Tue, 5 Nov 2019 09:51:28 +0000
Message-ID: <20191105095058.24223-4-ajay.kathat@microchip.com>
References: <20191105095058.24223-1-ajay.kathat@microchip.com>
In-Reply-To: <20191105095058.24223-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bfd7fc3-49c8-402b-9c59-08d761d5ba51
x-ms-traffictypediagnostic: BN6PR11MB1972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1972A5BC86223D5BD5B7539EE37E0@BN6PR11MB1972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(6436002)(2616005)(36756003)(71190400001)(486006)(186003)(86362001)(76176011)(386003)(14454004)(5640700003)(52116002)(2501003)(6512007)(64756008)(99286004)(6916009)(66446008)(66476007)(66946007)(66556008)(71200400001)(2351001)(26005)(316002)(8936002)(8676002)(50226002)(81166006)(81156014)(102836004)(6506007)(5660300002)(11346002)(1076003)(476003)(107886003)(54906003)(446003)(478600001)(25786009)(2906002)(7736002)(305945005)(4326008)(6116002)(3846002)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1972;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOykZ74etlwa1O4dy46bnfUasJL8w5l6QeQYd+zVgC+HOhv+cuK48fChUx56ZdOzfpk0T5Sps4tFp865stB5G84Uoe4Jh8oGgZgYLud8/StxK/CYkERU/0PcsRaKYUdF6NKgrt2qsfnG/Y5FMYBAqIvVUGz79E0LeB6djCMsxgP/pTNGhZZ47y1kHDXTPevUmGiRt6Vad9q+QLcZoQ/JGJR1i2jmX/kiyr1MeecRE5l3IuIiNS4WTo3LE6mgIjqNz47ZH+wfRoGBiCnpVy98QP8BSdV9LclgKx2XNfojiFrt02r7wk8V/vb124xLjs+TEw0g7gISRrcwMjtz06AOozjac9dKfIaXddSg+34HcRbEjW8yGfmPJlwMtjZI9QTPCgvP/ftjpwNP57L2oY60DnnRkeFNQgcOpUiCHrm9ek9R0pm4Hbu6XZ2uxHfeVCR4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd7fc3-49c8-402b-9c59-08d761d5ba51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:51:28.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OBNZcug/DoqEAv25zi4ovwoPz7xfhVQ3Yxz5WMKki/IhlEeQkP9J2+zRqmWnG6MBL6o1ZCA9irjCyxda0FgY575LK5GeJ1+fyNN9qKXCKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1972
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use 'WILC_' prefix in header guard to follow the proper naming
convention for macro name.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/cfg80211.h | 4 ++--
 drivers/staging/wilc1000/hif.h      | 4 ++--
 drivers/staging/wilc1000/netdev.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/cfg80211.h b/drivers/staging/wilc1000=
/cfg80211.h
index 05c910baf095..5e5d63f70df2 100644
--- a/drivers/staging/wilc1000/cfg80211.h
+++ b/drivers/staging/wilc1000/cfg80211.h
@@ -4,8 +4,8 @@
  * All rights reserved.
  */
=20
-#ifndef NM_WFI_CFGOPERATIONS
-#define NM_WFI_CFGOPERATIONS
+#ifndef WILC_CFG80211_H
+#define WILC_CFG80211_H
 #include "netdev.h"
=20
 struct wiphy *wilc_cfg_alloc(void);
diff --git a/drivers/staging/wilc1000/hif.h b/drivers/staging/wilc1000/hif.=
h
index 2defe58ab194..22ee6fffd599 100644
--- a/drivers/staging/wilc1000/hif.h
+++ b/drivers/staging/wilc1000/hif.h
@@ -4,8 +4,8 @@
  * All rights reserved.
  */
=20
-#ifndef HOST_INT_H
-#define HOST_INT_H
+#ifndef WILC_HIF_H
+#define WILC_HIF_H
 #include <linux/ieee80211.h>
 #include "wlan_if.h"
=20
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/n=
etdev.h
index 8bc62ce4f2f7..42e0eb192b86 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -4,8 +4,8 @@
  * All rights reserved.
  */
=20
-#ifndef WILC_WFI_NETDEVICE
-#define WILC_WFI_NETDEVICE
+#ifndef WILC_NETDEV_H
+#define WILC_NETDEV_H
=20
 #include <linux/tcp.h>
 #include <linux/ieee80211.h>
--=20
2.22.0

