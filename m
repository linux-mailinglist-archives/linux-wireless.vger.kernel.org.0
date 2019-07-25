Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698357596D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGYVUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:20:22 -0400
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:10267
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfGYVUV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhtHV8QLb5cEFwN5fySvn0EK3cJ/4tfCAE2OVHfVCaL1oH7Yvo00Q4Cs5CqgXjN33xo5PRCo9xey23jfR9wLZEXvdKbRw3RCjClELS994k8SgNTCdVX+N9f43uEa2nZa0AMfEYUQHsY+BaoV4OWvyZkEp+bfLxaHaSMz9XMqXlsQ+gH3ZZIpHn4tCMuCogPYnTgMAJpw+uyREChCjccXihXZQFnvtoubQ633lt58bcA7W3GvhZRUA52Gebj6rh9ONqqh2TfpciPK38XQij99xoPpzSW9lO4FYiMZHS9g1bwMuMTYhurTXS5fMYcad4DzrpldsEWxnbHZzBTjuTCjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdug70duqfhXLPTM3Vke1SDcmUtTxEpEzoQMjgFlzJk=;
 b=GhrYwmP1V3ibHVMi1JAA2wPvlFQwseNvH7BBZ3A02IbKzj0d3ZmVhQR9c5BpKFYArbqd1dAVCoahFQpPKmfH+N4U0VDUKxmnaV2bO+BFD6a5+TMJJv8DaCMaN/z5RdImCPKyXZZ2TKs7T16x6KkFKvHF9r5TeBcOiDxi6fwmFbsR8hRgY6/oxWlSiyoHLWUR7kdC/dFTSpzYyy2ne2oA8l+ey2iyMHw1WEwo7Y+vU5ZyGrfHkxDFs8sqAkzws8FXKspCjCyAOkAQxSuce5SgeWjPo+q4NYpLwggPTz3Exz5ifBjnEKah+38huGf0Fk3vA2mbVn5UR8jZN+L6Wc7ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=xevo.com;dmarc=pass action=none header.from=xevo.com;dkim=pass
 header.d=xevo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-uievolution-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdug70duqfhXLPTM3Vke1SDcmUtTxEpEzoQMjgFlzJk=;
 b=W4+8QZmukXsWpx0WkhOqiwE8mqywPKcZ1iW6mkV7bkEzRM0v2uRUcOHh6TFDNp34kiDNrPxso5YUk2pKedB+laYFVC9ZAnnV8+NFNIokNl587JVDF+nmw8gfyul6c0D/+HB8ZA9QAHE69ys65GJv1qI09L82e21VLModrDBZDr0=
Received: from DM5PR18MB2293.namprd18.prod.outlook.com (52.132.208.10) by
 DM5PR18MB1323.namprd18.prod.outlook.com (10.175.221.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 21:20:18 +0000
Received: from DM5PR18MB2293.namprd18.prod.outlook.com
 ([fe80::9402:86d2:af64:7938]) by DM5PR18MB2293.namprd18.prod.outlook.com
 ([fe80::9402:86d2:af64:7938%7]) with mapi id 15.20.2094.011; Thu, 25 Jul 2019
 21:20:17 +0000
From:   Brandon Darbro <bdarbro@xevo.com>
To:     "tiwai@suse.de" <tiwai@suse.de>, Luca Coelho <luca@coelho.fi>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "dor.shaish@intel.com" <dor.shaish@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression with the latest iwlwifi-9260-*-46.ucode
Thread-Topic: Regression with the latest iwlwifi-9260-*-46.ucode
Thread-Index: AQHVQOSbihGS2kcqiUKQc4exrvn+2qbb27MA
Date:   Thu, 25 Jul 2019 21:20:17 +0000
Message-ID: <19a71f97-511a-2459-13c0-097766208dae@xevo.com>
References: <adc640f5dc37e63283f48a9ce3c082cc8219638e.camel@xevo.com>
In-Reply-To: <adc640f5dc37e63283f48a9ce3c082cc8219638e.camel@xevo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [4.14.243.50]
x-clientproxiedby: BY5PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::47) To DM5PR18MB2293.namprd18.prod.outlook.com
 (2603:10b6:4:ba::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bdarbro@xevo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 023cdc66-ca22-42d8-fa79-08d71145e3f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR18MB1323;
x-ms-traffictypediagnostic: DM5PR18MB1323:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR18MB13233923AACCE2BD4E87A497DBC10@DM5PR18MB1323.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(136003)(366004)(346002)(376002)(189003)(199004)(11346002)(2906002)(6246003)(2501003)(66476007)(6486002)(76176011)(64126003)(66556008)(31696002)(36756003)(229853002)(102836004)(64756008)(53546011)(58126008)(6506007)(68736007)(54906003)(7736002)(26005)(386003)(4326008)(110136005)(86362001)(65806001)(305945005)(186003)(6116002)(81166006)(8676002)(81156014)(53936002)(66066001)(65956001)(6512007)(3846002)(71200400001)(52116002)(71190400001)(316002)(4744005)(256004)(476003)(99286004)(31686004)(5660300002)(486006)(446003)(2616005)(6436002)(25786009)(6306002)(478600001)(8936002)(14454004)(66946007)(65826007)(66446008)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1323;H:DM5PR18MB2293.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kl4GONElG+2Rh4HX6fuEfw7qLYs89r0E2rv6+y86bsGrsklBE9dTB6GHYOdD86NgBdAKRfSx0pZRj51WwuLdPpjpbuEIgHDAYD6r3/whG6tvXlhfeIZ3Yfn6H0nPPZrHjkAwb1HGIF6n85lH78zY9gyR9BVGwaTRPFyOxVIOYNM+0FLelos9Ahh7T0mm07qj68yI+D8UZIAC2PGc1AcdsPTBcVR/ov6/YhTX/13o3jxEp8d3hN9NZ1fnymZ3p8jeOZRK3SCxPY7Hw728E43fT9qFRVvjUf+OfuznQVFIiTiBLDLWMONkHZ17NKfw67KgdzvgIm9Newb7FDDBcTyKRynZNAJANPoBrv5ExiBUsAee58T6Mw/9bRYE3Wx5ck0j9/rIjPHaKtCcS6nr6vReulI1OnvS5rAb7GQr3odtooQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332ED87019DEF34E946F393395B411F2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023cdc66-ca22-42d8-fa79-08d71145e3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:20:17.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdarbro@xevo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1323
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNy8yMi8xOSA0OjI0IFBNLCBCcmFuZG9uIERhcmJybyB3cm90ZToNCj4gVWJ1bnR1IGJ1ZyB0
cmFja2luZyB0aGUgc2FtZSBpc3N1ZS4NCj4NCj4gaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQv
dWJ1bnR1Lytzb3VyY2UvbGludXgtZmlybXdhcmUvK2J1Zy8xODM2OTg2DQo+DQpIZWxsbyBMdWNh
LA0KDQpBbnkgdXBkYXRlZCBpbmZvcm1hdGlvbiBvbiB0aGlzIGl3bHdpZmktOTI2MCBmaXJtd2Fy
ZSA0NiBpc3N1ZT/CoCBJcyANCnRoZXJlIGJ1ZyB0cmFja2VyIG9yIHJlcG8gSSBzaG91bGQgYmUg
bG9va2luZyB0byBmb3IgZm9sbG93aW5nIHRoZSANCnByb2dyZXNzIG9uIGl0Pw0KDQotLQ0KVGhh
bmsgeW91LA0KQnJhbmRvbg0K
