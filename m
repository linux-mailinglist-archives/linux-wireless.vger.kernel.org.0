Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515921AE79
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 07:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJFWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 01:22:19 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1798 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgGJFUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 01:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594358405; x=1625894405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ec1PxbQI2xCr+MxUSecivPaE6jbygJqpEDQ4sKDj0eU=;
  b=Y+UOQuPNPzXIPJvUHqkUw9wbWIDRBex4DoCsNJPMDssaau4zlP1p6PLT
   xswJSys9u6Lpv2TJQ5+oXn5QbCDusW97Djf4/LhM7zWjtUSZOmiJiEKdD
   ZVUNDcHL4jili4PkjRsHkRrcmLnko8P2CHVJHQwaeLujRUFR/pnjG74Lp
   vP6XiXdgthldm8z/9Y5Z+CMvbfTjfpiDSsvw7/D9w0qDxJ/7iNTw9Sygq
   6ExSGUzw5A1pmtcWzJiE3UQmw78eb/MJczm3iRKTa7N2VYRMHHxIBvjA+
   y7YBKnM09u2tMQLv0dE84o4ZLNR4bklR4IE/lE22rImjmH19KAulSaxpM
   Q==;
IronPort-SDR: 1DyXo3IXrVldu9AvK8Iv6eABqkhhL2iG3ApAxks7a02nAlBiHicUdHWON8sbWFJbLeuyel1IYJ
 MzYnCnHQAExmNWfcoUgxI09s+c8DzSR0folSzeqvOnIVF4DGU9Ikts2P2vahtbwayAbNXsexae
 UmawfYe2qZkg/UpJbgIMJ/vvwVWI1jzSSojnW1DQZjmj7E6X12e/XUjqMKGE2C666s1SbiL10u
 SBXwxaa8xU+nrS6QyJMqVtPs6Ww113fyNvVCYmaKLGUhJTL7V4JIRx9W8EvAHfulJMcJK5XImo
 5mM=
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="18638118"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 22:18:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 22:18:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 22:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4zwqdSLgagbqKRuSQ5A1qWNw1MQN7KdMQtVcAawus8puO7s6Qlbe16DpTHr/6KJZWq2U77fQsci+IFVlIJUruPCOIYMmczeVip6IfVTaprtOmWsCiryalp7pypThIOuGZojQf5roXlGvXOtGg4aP0Ut8ObkcyXuZL3Q6AzVKVxUKWbwLnYAEGJ6ympPsijhA9EMEpSVB8B54VrgC7rnu/U2uF5z3tZRxkqKjccSApc2yyk8wRkXnt9loY/qOl9Wnu3538XHz16NdnY33ZgznYv46QdCOTk/O1+Mv7Zfjycj8gLma7FyL83A7IyAlIYt7u0hi2yWGfXdVQ+qAgH2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy/fXLUMRYf14qxT+HjrNFiumBYc221wFEkVX5H6NBM=;
 b=GfuYRw41bPYIflHfXE6XWJVTSEQMm9kJV/0fFS6X77l+Vl7k1O7Aa4Q+SsOPT2aGL5+7CLdbMIEbrH6VYN5Z87bJCoa9gNUJQ+wKyZf1nYcKDZqg340Wh5ECvGD46Su4scKAw7qKocNxmfoO/x/vKUHVuwdvj4jQEgcE4gfX1cLGkG0UWcSw34gT+jIMaYtDrgcET8coNf8vgsAbluKlg3LerI6+kGacu5WFD0jfwdX6UIgregiN7fogtPpD1HXqEgK7p/g7My+L4ySn89msHQsDKnSJKwCNeLk81O1lSPUveIfzPsq0ntvJf88CzkiLu3mwA3pE+nenIlg+I3hrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy/fXLUMRYf14qxT+HjrNFiumBYc221wFEkVX5H6NBM=;
 b=rmdZ6TfIw5UeKBtYCZVb9RvqrgTjLWAqlzBf35PrhuieOd5pUSuIpxmw5po+uSZWozwxXBIwbnXH6nBMMp6LHncVuxVDoQ3AOhB6cHwtAmvf5Oq2MTst80QdmoYAltHN6LedjCnT/qprdav0zp49EcX9B6Qq1lvXSDuvFs1WQtU=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB4128.namprd11.prod.outlook.com (2603:10b6:208:139::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:18:29 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:18:29 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH wireless-drivers-next 1/5] MAINTAINERS: net: wilc1000: Update
 entry
Thread-Topic: [PATCH wireless-drivers-next 1/5] MAINTAINERS: net: wilc1000:
 Update entry
Thread-Index: AQHWVnmMPuAU4KVFeU+r3jzuwtgylg==
Date:   Fri, 10 Jul 2020 05:18:29 +0000
Message-ID: <20200710051826.3267-2-ajay.kathat@microchip.com>
References: <20200710051826.3267-1-ajay.kathat@microchip.com>
In-Reply-To: <20200710051826.3267-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.205.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af3b1a1-be9d-4bca-cc76-08d82490ae8d
x-ms-traffictypediagnostic: MN2PR11MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4128516212ED43D796DB5744E3650@MN2PR11MB4128.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3mhzVVbgEixIX2zPh0DKKB4SmI6TBaMarDJ33rQquqkGOHaKqn8nIdGEGuOwiUoYTf3W9op31wLqVbP9HA93sUwATW8Mntj3FDNPBRiSjfawNnqBlX3vxx04xroKrlKueGSEDSBegEAypdGIongWwmIaEAbmDN0cZEIb+SFsfcplkBsfcml4SrjslFuaA871pd8Q/kbWJSCrqnzFaA/S9R5QFtQEgcWuVA6qa2TulW9dFYXAQdA6cPUS7JWhURcga1Gb4vBWe9O2y5DlitdH8eMDtp3gDUAgcSrA1MvdUaB7nPoMh+MOOaXfnr9C0NA7HIZ1KAaKqNygPsEzd4zbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(2616005)(4744005)(36756003)(186003)(6512007)(26005)(66446008)(66476007)(83380400001)(66556008)(8936002)(71200400001)(64756008)(8676002)(6486002)(2906002)(4326008)(478600001)(107886003)(86362001)(316002)(5660300002)(66946007)(54906003)(1076003)(76116006)(91956017)(6506007)(6916009)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jxsE2GHeemAH1OGkGc6oRTx0ELAu5Cfu3SrJ2Y0dt/OmwVl+wGz+qR/c+KEfhlvJjN5amTYuzEZnqRbpd7wIQXEiBs0UrxOBFe8x+hFgg+BQW/AHpicjPQtgq5SX1lKUNhmFJSJFbfUUsm9SohAGOsUpPAfd9vJoJ/OdCbUcCGXKxgLAUcD/6WZi3H3R8iiPU8X/WKdUuZgfA/4WhUxOzvKobpqZ4yMeNncevLj6BwpkritZ3uNm6eLwD22sVz4H3/xpW4puem+dOA1TjTmTGr9F1T6RIFrlvh0uNqbNz6A6NaYyOlZAGpNtbs+QTL/AfAgatWrx1u6rBfIlby0Y5/1cT2UIVWPiwvLx0LDpQLHVGnhPNZfh5C1YPqZvcMMl02WDFMcVIckTOtxPvh80UIY7d13vt4xZSBsJI6EJoLbZWmOZnaDuHpLmqiot+B2GgpCNQ0epC22kU7gx5ge+91P2yvU4YmpKdpnM1unP0x0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af3b1a1-be9d-4bca-cc76-08d82490ae8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:18:29.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6pfUoKfvREEsiESBbjqd3pcraeqzkQ6WUuFywldkdF0Q3a4iPCxB5Wa6L0pTc1Vkvj0p6TImsxRE7cMWMfKD7wRczzQmc4H8Sn2OIlZHyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4128
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

As Adham's email address is bouncing, remove him from wilc1000 entry and
add Claudiu as a new co-maintainer. Claudiu follows wilc1000 driver
development for a long time and contributed to it already.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7dae51e32254..099e672ec6e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11363,8 +11363,8 @@ S:	Supported
 F:	drivers/usb/gadget/udc/atmel_usba_udc.*
=20
 MICROCHIP WILC1000 WIFI DRIVER
-M:	Adham Abozaeid <adham.abozaeid@microchip.com>
 M:	Ajay Singh <ajay.kathat@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/wilc1000/
--=20
2.24.0
