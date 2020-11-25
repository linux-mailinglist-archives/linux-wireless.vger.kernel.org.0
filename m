Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273472C3F3A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 12:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgKYLlP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 06:41:15 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:51750 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgKYLlN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606304472; x=1637840472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x7tGFYol/qoIc/ewgqIxkMSd8CIql7Hx5Pw2Ho2lBJg=;
  b=sJfaxbzPMVlCqT5IWEqPRXoQviX2k1s2MFzus+GZfUO8KE9abUMl9ODU
   LMOXflSHv86X9b2eEfSF6xL7IBwyUQuhfNCmTGW+8u1cCKSSwn9pInVgG
   5ZlwCE39jG5zIbK4LQ6aQOfPRWXaTPpmRzeRH8wWYzVhcLgh/vcmQy90k
   EM4yNShl3vJCd1r+FcSnNDHDoKi1WxhQoDm+pb0kYuEdkiHBWgsXTKaWh
   W6v4mwCUKhgzVINN6XpfqJF24U0uihXvkg7tJQ7ZHhno6i2YTTlyErs/7
   eQAeWz0PBSIAaxIYMU8IAy8WtHonQPMQTvwkumPpSVynqpoJiCjQiNYM6
   g==;
IronPort-SDR: 9fsBbIPJogry5buIcycwD+tud0GoRSFSJD4oNpZ2o3Lkq2D6aDzDO+6/3Z4JvWhD9FgGqVzmZu
 /zaBGp4Y1cxfehAluepKV+/OECGmHkeaSp4pw/XdTPGPwgWnbx93sK31EQhQsKOT8KrjSpaxd5
 iaNF8uFv1ZdaZ4ArmyYyvf+6nBm+faXL8Ez+5I1t8KfKFURQfmyAemu9sD4IXgjfUqrL4Yrm+T
 4sdqbgwf1xNrICTaRT1SWPze3yktE2blNYvnRqRVlYT81sC3nYnFbEpzAqwA6ZozFsb0zwigxQ
 HAg=
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="100348218"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 04:41:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 04:41:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 25 Nov 2020 04:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+8iyKI0vj/LFpy2UT2pjepMAw3oVsozoZeKFsF170wRKdQ5abGvUMeFrCJMKKNaZZjRYYj5bOdCK7mqIcsL0bIZ1+XS/wcSggJXxihEJNBabtePzKjCQ2UU0ToLwSYM8kC6XZpWAPU474wlWrJFwTbZbEbegjq43FBLue2cNh1+MYSnGa8cOfHksBg0cYHvLnUNnqVbuhPKf39oEnU83Al1pt1QrfDMYcUK/W3vSV8CnaDjiFHybcpRnrn+JVh6Bc51JNJVzzUjjAEuKwcUBxZ9DHMUVD7cIhsluoqfJTea6BiS9eWGg1i04kXEIRok/Q64tbi/fyyQMSuFGkjutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jsve2jUlaok+5TdrLzcUATUAv1x/ivXUPR/D1QW2FxQ=;
 b=YIuS0bQF/wLbw3eqitETLtFzDwfqhrytTrUCC9N+bEGUF7UyatBoALuu2jVRbz7hO8hRXVcQ4Z4e4w9Rv5UFfnji4d5ISRM2Pnrm38YCGyDsUm9xSzsb4uXN10x9wn7/OUn8pP/KiiesclIpwdNiKSD3AAjNd2m8Ib2zcGeuWR34WwInt+bzDLbK9QSlljJnX695mzJGOvXEjnBL+k27CToGZB9YraUK2CNhbKqOiJblWeAf2mmAD/0VNcuDr1+Hn77B4i8aMNEZBldmjbxXKeDWTmOW7QZFGwNm8uOiFiGdFODmFVKa3fy/PFWKru/IwlcgIrMCStL+bEpXmL+MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jsve2jUlaok+5TdrLzcUATUAv1x/ivXUPR/D1QW2FxQ=;
 b=sbg+Z1ErolYqXJIayAl+emJGXDgLkYNGdqZsHt4fGx6sFvMGBLQK/QmqH3UhKR25v2h4w3Il2eRsoPcFNsrz73R4y8XG7A9yGeMTYf2vxNyev+ag92ALa8C78hTrYD2LCtZjS7oWEJUEgqHhXzrwGZY8OO6KHXmb3QLdZ53SEw4=
Received: from CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21)
 by CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 11:41:10 +0000
Received: from CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988]) by CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988%6]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:41:10 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/5] wilc1000: call complete() for failure in
 wilc_wlan_txq_add_cfg_pkt()
Thread-Topic: [PATCH 4/5] wilc1000: call complete() for failure in
 wilc_wlan_txq_add_cfg_pkt()
Thread-Index: AQHWwx/eKSDKaY4O/02tWmIDpLW1+A==
Date:   Wed, 25 Nov 2020 11:41:10 +0000
Message-ID: <20201125114059.10006-5-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 677eb85b-7390-4f0a-3da6-08d89137013b
x-ms-traffictypediagnostic: CY4PR11MB1605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1605334032542C887B7B8E4BE3FA0@CY4PR11MB1605.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abeDY1RIXea5DP2eFbM/5bH1xaad4Q/UJcbs6ov5OxW57fCRrrxenGhxU6oY3RI6bDreR5bTskQRcvtBlUBPSTDIORaT8mapV3m/L8QzJWfTRSzAadrWJ0DI9VQWKaeQGrt/YJM6jlvZbkxG4MqupSF2vh25qhOS2lUHa8yyECnq23vs4uHCvbQRb/vVMpSFG3WcUFz6wV93jWh0+2+C9Y1NNA1rErRyOHY2F+O68X54+mxAaNBcWojAZcjcxCsnUH+pl3SAjqaeO23GM6Ybvuf/5SOiPpqd/q/6N0cDGJLI3d2CXVfK+4syQLv1VKS9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(396003)(376002)(66446008)(66556008)(107886003)(2616005)(6486002)(4326008)(4744005)(5660300002)(66476007)(36756003)(54906003)(71200400001)(76116006)(8936002)(64756008)(110136005)(2906002)(6506007)(66946007)(86362001)(186003)(91956017)(478600001)(83380400001)(26005)(316002)(8676002)(1076003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ogun6f1xLkfkny41WkrNJd4lGVf9sdkilqcMQZoXXdKQkmk9hX+UbdxYbFnsG5r16bgRKdQXDYe+eF4A0T8XN6sUuXT81mfis+vxp62zhxESOpTnLlx6fs0/KcaYGZgpRjwfUSqwN9tnTnvI3hod7HC6ROn5U7/w/c0xssdaaRIP+M2p/SIG1put117AVM0lfYQJOajGNP1HTA4ecxrLlb+BejrXE65XJsSi2Vl69EPlC0O1+J0VN5nyFQJYJXR605k0zjqYnq8uGSPBMCyEexaAQnDMLCGiML6PSpHLnTSwYWFnHlSW3Dyn+IdpDy0MFFGIds4FYLoTPQKZy1l8N5WOzyDAtKyGbUWZezwHONjw3u+lpo85ff0rfu5xjPrPoY9r8lXpKQ+IJTpLdTc/U9U0WW7nYxDqPqqy3mfU4+LJ5aM6czcdOYlS6UcmsT5BmiCbOcs2C8ryUKKvVsHpeYuB4BY2h/sicNArLmjtzaWTOnniHk+n5T0o+/Sq3Ce4qrx/OX1wr3jl8O68fwP1aAT2kwFNHBjU06UJanU/K4UxXmKvZqqeNKcsPUvziKdzYVE+KyafWkj+8/3Dy2UNxDiC5JsimYbcl6ieT1M6IxexMVuxtwO5YfUT8PcczxN+la9bO7ICUNflNotzqBzkrMDAKbBJRSqTfFVZWtlNGRu1e2hPbTsl5pzjgVn8+zHp+fJCWvHXr98B2Gqf1Rx9a1z1tmzZTFEzbDbvraJaaUdarkOEWMqxahJC2zDwuLDGQKoOlBi8+GVqspQS//TRW59y8aowmAR3flaACoAU+isbNOVjs+v2IV2HGmYhuhlbPFbfZfcaiCDwih46ygihDyc1UYJr1ZJeATnSVue8K6g9QcZdzJVqCTPFRHXcPWFViuVmtkytfzL8G8XvLU9COg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677eb85b-7390-4f0a-3da6-08d89137013b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:41:10.2173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aylal6KWm20VxVQJxiUPGhCl8tYDUb3o2vcWHHOBRckOhu9hT1vac/4JQmWkWDL7dyG+/w4AsaAnA+YSOhQzAx4FahC8JZmFOJEcwVY1PRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1605
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added complete() call for failure case in wilc_wlan_txq_add_cfg_pkt().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 42b5db4e2d81..0ff4de28f622 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -258,8 +258,10 @@ static int wilc_wlan_txq_add_cfg_pkt(struct wilc_vif *=
vif, u8 *buffer,
 	}
=20
 	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
-	if (!tqe)
+	if (!tqe) {
+		complete(&wilc->cfg_event);
 		return 0;
+	}
=20
 	tqe->type =3D WILC_CFG_PKT;
 	tqe->buffer =3D buffer;
--=20
2.24.0
