Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95B02C3F37
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgKYLlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 06:41:13 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:36343 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYLlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606304470; x=1637840470;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=vaQevOH2tVm5Tny22OOkAhIJaA3+QzBZOFjqyfsmWxg=;
  b=UAQDVtZMO0SeFdEhMUyt54f/Y0+N58mYbkhOJbxrWwAQUR8MQPs/3721
   6PqIpaeRvuxvCOfFKZvPu3IHsfeUDdh2+KBBixX6bS7IRwcgRh7YXT9Op
   wTvqnMkhSuebS+POrq5tw7MEiGCWzT2QJ4E50GPtGB91YPkIIM0r1OCnt
   wTnYhet29ODLkBQ7RHXMibsF5Vn6BCuy1zUqQnjuIfVBtGcknAqQL8fxW
   QrkjEsM9c+MpvMyxIV8YGYt7g8/vRgO6d4lo7MX5i694qVTpitlyS1ykd
   qQKIA8xejJ9SMhC5OiLkVutd7Q8hILM9uYeLc5IjoqEmqHZyvG7qk8stn
   Q==;
IronPort-SDR: X9b2AYUnBQSe4GUheoq2xqYrv68+q2UEaG+QgnouRM6eHx1DL8vuNCeEMyikqeTift3uTthiry
 OcqXpboYAR56hX5/DDTC3E35vEVs4gGjsHssckpEe9qnWxHEWhzheYcLqY2BE0jqAxd2sKtq/d
 hvMm5vWj19EGOvANFTzoieMTSS9tHFY2hQA9/RgKefVlYSRDVS5qB5+SgqQvzk1eFFMP6YDa0J
 ZgXfftw3LjrDJWLpWcFRvmERiuCkeHnmI/aXHELO7be/5ytkB+mif3cxRSDK6q7EHUJBWKePQz
 h2c=
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="97544269"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 04:41:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 04:41:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 25 Nov 2020 04:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBFqjkO2WiOdnUvThtXcmL0vAFCRKiRqo++mmAeq2e5vXfOeNEYakRMc7Gv+KYfIeUtQObvfPg68chmMMBx8CCIcev/xdZNI+IkafLqdjFgibtxj/I4bylwl+U+yLvwyXy3ALqaHfUYucO7D+qtVdKjKi4xOszecYav6Ddi9slOlCcS4sXq8iL+Yx3KynVBiYEtQ8YqdNE0Hn45eS7jlFBGa0dQZWCJxo3UlX/DLSFodf1bWojVjsrD64WPr+KnPSgfhMlAj+rim/VGmIamG/isvW24Xg/UuBy282CyCT9Ci2cR6boko1/YUzBMU1Y2JCDRTLtySMRdk2FUZt5SaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaQevOH2tVm5Tny22OOkAhIJaA3+QzBZOFjqyfsmWxg=;
 b=LrxN4uibMRdiX7pMl5xJqbPfOjt272SW//cRGDxq4Qt+UTkZ+9mUiYmFVFQFbjin8sJZosH32R75CCzYaWkd9GscFyF19pe7GAtBnSKTsUSgsKZhjTQKanfdxMHIwqYvwx8x8+jhdhXF72TIgbdhZpM6Ccd9XIniYM3p9YsX8C+jkiy7jK+mxW8ZZUJCj1ENCLy1sfFezE8Oz013kVJUPvS8W354o6JISkIRX4BuLRPwgvR2D3S2KmXkLZI1RP6QgiugL0qo4L6IOXwFqLARLTE9DJ+g/84SeJTQyAwcJ3PH1iwYyIdPq+H6od4DcrG6QHjzGfXRUmcZj2uJkzfqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaQevOH2tVm5Tny22OOkAhIJaA3+QzBZOFjqyfsmWxg=;
 b=H4LbzjLfNz7g6Vhj0iRH6hJJZFpYVsWc5gNs3TGEptZ3/Q7gbOY/GgIAlP7tpS5rJ1EVWMXZxA8MYeY+Boh5/RksIzf7WJpGR2pvX37geTMxlAwAj9Si+VVRioEIk9bPP0pb5XUOjM32E90XcAq+th5WdNakkEof0Csqh8RBA9k=
Received: from CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21)
 by CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 11:41:07 +0000
Received: from CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988]) by CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988%6]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:41:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 0/5] wilc1000: added WMM support and minor fixes
Thread-Topic: [PATCH 0/5] wilc1000: added WMM support and minor fixes
Thread-Index: AQHWwx/cPi40F/+G3km+l173i6AfsQ==
Date:   Wed, 25 Nov 2020 11:41:07 +0000
Message-ID: <20201125114059.10006-1-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: cc4af1af-80a9-4a9f-c7c0-08d89136ff89
x-ms-traffictypediagnostic: CY4PR11MB1605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1605EC411F95A6C061029486E3FA0@CY4PR11MB1605.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5eSsNz3py+PzAKzBvk3R2PVIa2XCGImS4EN/hUAlCx8rIhxg4RmGWWsu3JP4APLYSQmNKE6TRmETSbwS2CDKf8wiXjyEXxnkyvjPg67fYnfvDWuLCgd98lUoWh//eplTf0dJ8hWCBXZoivyLIWhlUxDHkl90GdpMewBTcoR5hf0iWu/xtQpMr7OpPnYpa0eGDgtl/bXPErHRr4P5RFZc9Q69ZbVwQcnKKItBcG2q8bMEMfF8a90CwOwjHV/356kNZOiTJ37NhO815zI2n9Pj9s1dp7aMs46nJkzoVSYxoYSXwVkAUZK8cuwDfKh8RtNFoc6iPTyrqL/mAQjyGcRyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(396003)(376002)(66446008)(66556008)(107886003)(2616005)(6486002)(4326008)(4744005)(5660300002)(66476007)(36756003)(54906003)(71200400001)(76116006)(8936002)(64756008)(110136005)(2906002)(6506007)(66946007)(86362001)(186003)(91956017)(478600001)(83380400001)(26005)(316002)(8676002)(1076003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Y5dXjM0Hz6LoLSztkTwPrIz5ci1mvWiwQHQRRvvwc1/AusZ7TqJ92LVEtatCLb80cAob0vJCttgjHobxAp7GbQZ/5QhEbCrgjgeuO19rM3XwBR4Y0z913vsiVFVry4QYCZZ+wtbHRI2/beMID9e+yj/ViDgc7F7PZ4egi2Uvg3cDkM2kcn0hZRUkNk6awZq7btWy7PAFtVbtRkJKLL7ESblMe0N0P2e/R8xP70xSI8J5hLziKiSuTBfR2NKv2KmRQl4y5aiTZvERudJylNbxvZpsvnQsKp06O7OdUCPpixnESpCvy0XJXD+2RWm/UQTZkF0EcL7gNcC5B4q0mUYctDoYXFZyESSGlMRiAJOAxV5IZSyyxt2RA69l9sNeal9US4SOK4mCzyAPHrtthxEGx5MttsDni8fFG9XkZ2K0eFfn0xxms4Fu7ZqsGbM8xcDgdfKrTH0iFDvTQU18PSBZuNrgKYV4zxCuyW7sWsIC/8VQguY3+QbBKk08sYtWNktIsWIG/coRN00DhyuIYoKgX/a3wK2EriYFtxkmoXZdwRVti/aV1raG4xiqsfwTD4LDPD6oPAwfRJTihKt5UoEugVjizfA7sNZqeob70qJFvcrz9XT9LSYNmjJHPgUS4mb3e4pUyT76xNe3O0OnEejpEe28j42slVOotRkZboMPghGprQ6HXl2g3yuJzoXdVrJ2qekCgWn9WxyZ+H153yOxWlHMaL8/uqnvpAjEn27yr2Qy9rKvkciQSTo/n2vVgaevtFp8Qgu2WQlb6E/aGOWcD4kn9EcnDNF/VQdCFsdZvX/WxnCwOCNfjQF6Ni8kG3Uew4S13CytLvRXMj+KifyHggM0Dk1wTKsEMSJy1no8Yxnkym/wYx2ArkF9MIPPtpRuzvVknA+cKj4B0cB0BV1BVQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E1D8C362199E4E84070ACE74A97C8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4af1af-80a9-4a9f-c7c0-08d89136ff89
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:41:07.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4bgQ3TZlZFgY8DtwDveujg7ymR7tRQbvMAoLsEb8/COne0+AXW+I5Y1tnGumYEA6bvVmhKWxlD4uvTUKbZOuKPwO3Y3SUcQy4Yb8WGbO7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1605
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KVGhlIHBhdGNo
IHNlcmllcyBpbmNsdWRlIGNoYW5nZXMgdG8gYWRkIFdNTSBzdXBwb3J0LiBBbHNvIGZldyBwYXRj
aGVzDQp0byBoYW5kbGUgaXNzdWVzIGluIGZhaWx1cmUgcGF0aC4NCg0KQWpheSBTaW5naCAoNSk6
DQogIHdpbGMxMDAwOiBhZGRlZCAnbmRvX3NldF9tYWNfYWRkcmVzcycgY2FsbGJhY2sgc3VwcG9y
dA0KICB3aWxjMTAwMDogZnJlZSByZXNvdXJjZSBpbiB3aWxjX3dsYW5fdHhxX2FkZF9uZXRfcGt0
KCkgZm9yIGZhaWx1cmUNCiAgICBwYXRoDQogIHdpbGMxMDAwOiBmcmVlIHJlc291cmNlIGluIHdp
bGNfd2xhbl90eHFfYWRkX21nbXRfcGt0KCkgZm9yIGZhaWx1cmUNCiAgICBwYXRoDQogIHdpbGMx
MDAwOiBjYWxsIGNvbXBsZXRlKCkgZm9yIGZhaWx1cmUgaW4gd2lsY193bGFuX3R4cV9hZGRfY2Zn
X3BrdCgpDQogIHdpbGMxMDAwOiBhZGRlZCBxdWV1ZSBzdXBwb3J0IGZvciBXTU0NCg0KIC4uLi93
aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvY2ZnODAyMTEuYyAgICB8ICAgNyArLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuYyB8ICAxNyArDQogZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5oIHwgICAxICsNCiAuLi4vbmV0
L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuYyAgfCAgMzggKysNCiAuLi4vbmV0
L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuaCAgfCAgMTEgKy0NCiAuLi4vbmV0
L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMgICAgfCAzMzUgKysrKysrKysrKysr
KystLS0tDQogLi4uL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5oICAgIHwg
IDMwICsrDQogNyBmaWxlcyBjaGFuZ2VkLCAzNzMgaW5zZXJ0aW9ucygrKSwgNjYgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi4yNC4wDQo=
