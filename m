Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D22EFA17
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbfKEJvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:51:43 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:53158 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfKEJvm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:51:42 -0500
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
IronPort-SDR: ODXZjw+ruggXhmdLYLGVK1HkVMu075kiExA2STMObCRcEoYepRKbXqET1YObXR/rtWMedTpDB8
 86FJ1Yzs0VxdlgfsfwDMOleSTjemk2IqPwcM/OmfxUn8F/c/7RSrFA2MbFezypLlZqi2diLmo2
 ITGyCPGIecItSXt8uZgei63IHiSTlR/Bf2ZseopGd8LnXjHYrlHZ3u4X8zFWgjmNmy+vhuxrkD
 Z/XA9/Bm1YoHMihTc64pHzeCDnSxyMTeBshS2HDPQOhWZza30zoMCfK+SNwYA+e7GvhC8OPoz9
 DKg=
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="52914439"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2019 02:51:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 02:51:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 02:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGcVNRxJV6FA+qHTUqrLeMogK98ZJyGRTvYjYYqYmFz0vNxx+O3pQcSAZKWyYSf0TSK3rjtEuhUQAnuyor6ExYj5CZvsSEgtxHzJp7iJDSPNZKVCBwT6NVTi84WhArCP6si8KP4v/yT811/oxOe/jM1Phy8HT9ltYzKssJlSBWj9ZvJPk+0KlMbL9pgXhUE0gIFUE1KoyBYj+/r71MGfhihLta5dTuowCVJ3HXSkPUFfuBXvhM4LIXVh7sqsscttLtl5UB6RXOfB46WS+7rm7j9EsfxXSvonvFSgfdAtVhlIobHKYh/clh44vwNTcyNy0xfI5i/yzyACEFgOOAEKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgkVpcCauAjW7gHRxD91e+dsTaBgJi9EaCzn2BouYwE=;
 b=OU7ZVaARgSotutpPX9ikhlvI7D6FTESfsILFyPBFT90QuuVun0OqpSvSO2eKIGyPew8c7M1/AmaS1q5C0jZOWfT12wul8vOYpSUK/jdokfvhdCUYuHAJcRyQKvww9mjfXh4/MHIhedMdWIHYrNUPODgjkNz3xBPKrIzwoFmr7fqEyjwFQ2AfQFVsCbWMNw7yG1d8CsoTDqOLBkgGsd9Yfs5DV0CpncL+PyS0fKTlmKEWKh98NKUZvukXeqa5LsACmglOxERLqyuqUSsiDFHLfzir4PHOFz8NtvagmYGmP77D9WmN+lFkFNyYwtepzvW5A07irWvZkeTLYSUxtWbxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgkVpcCauAjW7gHRxD91e+dsTaBgJi9EaCzn2BouYwE=;
 b=uAfoXZt/09+wd/gGBW1f+f0fI9Bzfv1DMTp94S8q5CJ6j99m89wcBR18n8eYck/UC7vx99ucGVUKiHnz71CBNBYR4TOLRCv5rhCNBAflewsrHiuP9bC5wCX4elK2suwcC9BnhwmA3jIclauAqxFTN1RhszlmUC81naO4YSdJAnM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1972.namprd11.prod.outlook.com (10.175.100.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:51:31 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:51:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/6] staging: wilc1000: avoid use of C++ style comments
Thread-Topic: [PATCH 4/6] staging: wilc1000: avoid use of C++ style comments
Thread-Index: AQHVk76ZTWlKQCuDbU+TzJqUPm4zvg==
Date:   Tue, 5 Nov 2019 09:51:30 +0000
Message-ID: <20191105095058.24223-5-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 853f413d-cc33-44e4-c36f-08d761d5bbea
x-ms-traffictypediagnostic: BN6PR11MB1972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1972CC2F358B5375CCD082C5E37E0@BN6PR11MB1972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(6436002)(2616005)(36756003)(71190400001)(486006)(186003)(86362001)(76176011)(386003)(14454004)(5640700003)(52116002)(2501003)(6512007)(64756008)(99286004)(6916009)(66446008)(66476007)(66946007)(66556008)(71200400001)(2351001)(26005)(316002)(8936002)(8676002)(50226002)(81166006)(81156014)(102836004)(6506007)(4744005)(5660300002)(11346002)(1076003)(476003)(107886003)(54906003)(446003)(478600001)(25786009)(2906002)(7736002)(305945005)(4326008)(6116002)(3846002)(256004)(14444005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1972;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lF9G2j2JbGGyylRVhaPwh81xL/GubiMNViH/XriZpYJoIVQjxOW0Z30+IiXllMG7L/H2Ezc6ZU1+73vOSH3SIy5bg4JivXdk9S5AL3shpxrIqOn73QApV3iW4tWgJvckQCf7TPCmzC3HAzMolqGly/3M/tr9NXvX74iyw4tp23H+JsRJ8ru5k0deNHanAi0UfORux7VF4SaELnAnFhVw8ae3v9HFPdJNI/UB7w/2UZyZiCKz0rqi8xiHP3c29jD1yLHr3v8MWhGK7aYH9xDQxMIiVfioV5zw9fVo8r0v9kRTyybg92HJfdUiMQS4SUONjR8m80LNdrnRaBszjXRrVrF+TXPtugt0luw8SAb09UhijUHrcuSd/3GiqQ8z96GF2XIXiYOpC018R0cDKgYgL5xI2YzY2yqgV2LEuPWt4/r53o03Y3EQqmqME2prgUQy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 853f413d-cc33-44e4-c36f-08d761d5bbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:51:30.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6CaOReskCoV4Oo6TzJqNl86LeKdotfy5UY3uwgI5M8p0T8uyN38MD4nL8GQxUluH/na25r9t3lB1CzvfBeCm4Qgpf0vZyJ+/YwciGnz8S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1972
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Replace C++ style comment with C style.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/hif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif.=
c
index 25f035c02b10..5f6706bcedf6 100644
--- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -552,7 +552,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bs=
s,
=20
 		param->mode_802_11i =3D 2;
 		param->rsn_found =3D true;
-		//extract RSN capabilities
+		/* extract RSN capabilities */
 		offset +=3D (rsn_ie[offset] * 4) + 2;
 		offset +=3D (rsn_ie[offset] * 4) + 2;
 		memcpy(param->rsn_cap, &rsn_ie[offset], 2);
--=20
2.22.0

