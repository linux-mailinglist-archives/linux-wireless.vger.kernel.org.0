Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90300187ED
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfEIJs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:48:28 -0400
Received: from mail-eopbgr770125.outbound.protection.outlook.com ([40.107.77.125]:3652
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfEIJs2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dQS4zDtb7Y5zIbBTrYK1JqJA2jHIISLKX5ecSlLFM4=;
 b=queLMNxHuFBnTFmBxmjwM85qaa0jNWQ2NBy7eSOtqQtznogACNgR0F6n/XLXLzsCC1PlpBelFXuOftfzPuzLPW6xECsLRRPITASiWskmDsIu67jgz6nnJj/1h05MmQ4i+mDvNs6QSx7D55piyfSJAfzaaQIbEDOforaD0Lg9Fgw=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB4777.namprd06.prod.outlook.com (20.176.112.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:48:25 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:48:25 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH V2 1/2] nl80211: add NL80211_ATTR_IFINDEX to port authorized
 event
Thread-Topic: [PATCH V2 1/2] nl80211: add NL80211_ATTR_IFINDEX to port
 authorized event
Thread-Index: AQHVBkxYLZwM7Ia6bkWy3WP34dMcpg==
Date:   Thu, 9 May 2019 09:48:25 +0000
Message-ID: <1557395289-41133-2-git-send-email-chi-hsien.lin@cypress.com>
References: <1557395289-41133-1-git-send-email-chi-hsien.lin@cypress.com>
In-Reply-To: <1557395289-41133-1-git-send-email-chi-hsien.lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [12.110.209.245]
x-clientproxiedby: SN2PR01CA0012.prod.exchangelabs.com (2603:10b6:804:2::22)
 To DM6PR06MB5804.namprd06.prod.outlook.com (2603:10b6:5:1a6::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 945c2311-20c7-413c-e8f2-08d6d4637b43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR06MB4777;
x-ms-traffictypediagnostic: DM6PR06MB4777:
x-microsoft-antispam-prvs: <DM6PR06MB4777E70A75300F970AECF354BB330@DM6PR06MB4777.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(25786009)(52116002)(66476007)(64756008)(66446008)(53936002)(6436002)(66066001)(14444005)(5640700003)(50226002)(66556008)(6512007)(3846002)(256004)(8936002)(66946007)(6486002)(99286004)(446003)(2906002)(107886003)(4326008)(2616005)(486006)(11346002)(476003)(478600001)(305945005)(76176011)(6916009)(7736002)(386003)(6506007)(71200400001)(71190400001)(54906003)(2501003)(2351001)(186003)(86362001)(4744005)(14454004)(102836004)(8676002)(26005)(68736007)(6116002)(73956011)(36756003)(5660300002)(316002)(81156014)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4777;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9YCHOirCGeOOCLCGwAmHBROL2fnhHiEMbUdw7Vxv7fGPVhtOcE8/L1kzSrroOC2iXaGUuhmYzVhS7WK+6wTkyaYhPGZDFTKcJi92RaYvalIcegF+rMu9GPRPCkm0pSI2pH1RrU4W4CN9R4jqjja3DF/stXg0oLmaG2Wjr9JxKSz3jUEJOgBBZT3DJk2LPSuw1WT3s/C9N/lqhUsxjU3CHY2SH/2Xi4ZCaAsC3XzaZEoMNko/3I7RLSfCfbVuvEHQaHheOU9bCg7DoUs1RGjbdAIk1tV1v66QUrdnnRUc0sukW7DlVpRnJ2biSzoYiJUL06lWfWY5eqzh0I7xWNQem3FKHMmV4aMVsryvzs6aD/NKPCYsyPyYqAxs6jIvPVR66zIgdDySZUZAKMDlfxszHB0Kql9gzwDOz6SwUf6O6Qw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c2311-20c7-413c-e8f2-08d6d4637b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:48:25.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4777
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQ2h1bmctSHNpZW4gSHN1IDxzdGFubGV5LmhzdUBjeXByZXNzLmNvbT4NCg0KQWRkIE5M
ODAyMTFfQVRUUl9JRklOREVYIGF0dHJpYnV0ZSB0byBwb3J0IGF1dGhvcml6ZWQgZXZlbnQgdG8g
aW5kaWNhdGUNCnRoZSBvcGVyYXRpbmcgaW50ZXJmYWNlIG9mIHRoZSBkZXZpY2UuIEFsc28gcHV0
IE5MODAyMTFfQVRUUl9XSVBIWQ0KYXR0cmlidXRlIGluIGl0IHRvIGJlIGNvbnNpc3RlbnQgd2l0
aCB0aGUgb3RoZXIgTUxNRSBub3RpZmljYXRpb25zLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZy1I
c2llbiBIc3UgPHN0YW5sZXkuaHN1QGN5cHJlc3MuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hpLUhz
aWVuIExpbiA8Y2hpLWhzaWVuLmxpbkBjeXByZXNzLmNvbT4NCi0tLQ0KIG5ldC93aXJlbGVzcy9u
bDgwMjExLmMgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9uZXQvd2lyZWxlc3Mvbmw4MDIxMS5jIGIvbmV0L3dp
cmVsZXNzL25sODAyMTEuYw0KaW5kZXggZmZmZTRiMzcxZTIzLi41Mzk4NzMxMjA2MjcgMTAwNjQ0
DQotLS0gYS9uZXQvd2lyZWxlc3Mvbmw4MDIxMS5jDQorKysgYi9uZXQvd2lyZWxlc3Mvbmw4MDIx
MS5jDQpAQCAtMTUwMzQsNyArMTUwMzQsOSBAQCB2b2lkIG5sODAyMTFfc2VuZF9wb3J0X2F1dGhv
cml6ZWQoc3RydWN0IGNmZzgwMjExX3JlZ2lzdGVyZWRfZGV2aWNlICpyZGV2LA0KIAkJcmV0dXJu
Ow0KIAl9DQogDQotCWlmIChubGFfcHV0KG1zZywgTkw4MDIxMV9BVFRSX01BQywgRVRIX0FMRU4s
IGJzc2lkKSkNCisJaWYgKG5sYV9wdXRfdTMyKG1zZywgTkw4MDIxMV9BVFRSX1dJUEhZLCByZGV2
LT53aXBoeV9pZHgpIHx8DQorCSAgICBubGFfcHV0X3UzMihtc2csIE5MODAyMTFfQVRUUl9JRklO
REVYLCBuZXRkZXYtPmlmaW5kZXgpIHx8DQorCSAgICBubGFfcHV0KG1zZywgTkw4MDIxMV9BVFRS
X01BQywgRVRIX0FMRU4sIGJzc2lkKSkNCiAJCWdvdG8gbmxhX3B1dF9mYWlsdXJlOw0KIA0KIAln
ZW5sbXNnX2VuZChtc2csIGhkcik7DQotLSANCjIuMS4wDQoNCg==
