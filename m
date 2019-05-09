Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FBC187EE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfEIJs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:48:29 -0400
Received: from mail-eopbgr770125.outbound.protection.outlook.com ([40.107.77.125]:3652
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfEIJs3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PeFRWE3RCdhJWFdrlEV+sOruhM+b+VUNDs/uJ2w1Kk=;
 b=6ovsIePlF42rP2If24Hjn90xSdx/lxiHaiX8ufdBAkGiigs1Qnar+TO4G4dDfCB9fhOfqISZaJJGpGH9IF6nwGim2aQl213txwmhixK0CYoEsh29w7fc2qdLmFK9kGW/lD+8vqO+TYJcrpg+JLKqx4jOIUbbN694T2763Hd6+gg=
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
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH V2 0/2] nl80211: brcmfmac: add port authorized event support
Thread-Topic: [PATCH V2 0/2] nl80211: brcmfmac: add port authorized event
 support
Thread-Index: AQHVBkxYZ3wzEK2tkE24ON3ZCg107g==
Date:   Thu, 9 May 2019 09:48:25 +0000
Message-ID: <1557395289-41133-1-git-send-email-chi-hsien.lin@cypress.com>
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
x-ms-office365-filtering-correlation-id: e69c4094-c222-48cf-b93a-08d6d4637acd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR06MB4777;
x-ms-traffictypediagnostic: DM6PR06MB4777:
x-microsoft-antispam-prvs: <DM6PR06MB47773549077F9EB36FEB21D0BB330@DM6PR06MB4777.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(54534003)(25786009)(52116002)(66476007)(64756008)(66446008)(53936002)(6436002)(66066001)(14444005)(5640700003)(50226002)(66556008)(6512007)(3846002)(256004)(8936002)(66946007)(6486002)(99286004)(2906002)(107886003)(4326008)(2616005)(486006)(476003)(478600001)(305945005)(6916009)(7736002)(386003)(6506007)(71200400001)(71190400001)(54906003)(2501003)(2351001)(186003)(86362001)(4744005)(14454004)(102836004)(8676002)(26005)(68736007)(6116002)(73956011)(36756003)(5660300002)(316002)(81156014)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4777;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 78fYIM8aO2P3hQ8QKXvlKhPbDlS3qeKL2r2wlqn2N0J8BQUZLFV2gD5DJcVmSeKv2pFvzgObxbXZQoXpRDEWmhFRVZ6ECJwTNtNySFOS4ICIa/pMJpan10bWvajpvDyYoHjsMQIs1tLVAUoLPgCkcaY17KtPmkQ4dGqsa079qFGjfIKjGIpFqD1dMqUfA0ChCcGnJsPVS+sp/IKPyk5j8nCIVayDv1+0CR3mD0GWXWyRSLZFtFcNX9pyuMu1RwISenVkqdcLBF0A89tvotFsXyF39l5+bv7Du+PAp5IlP58Gfd0+Op4miLqGckD5A+JHYlSgMukLClJY5mauHEpIQZiWVpKT6pGD0RMMYX4lfaFu1MNN74fPYPCUSOojaL0q35Z8FQjbQLDKK2+QTHQnULKw1Sf3wI0fooK+6UvbDMY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69c4094-c222-48cf-b93a-08d6d4637acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:48:25.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4777
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlc2UgdHdvIHBhdGNoZXMgYWRkcyBwb3J0IGF1dGhvcml6ZWQgZXZlbnQgaW4gYnJjbWZtYWMg
YW5kIG5sODAyMTEuDQoNCkNoYW5nZWxvZzoNClYyOg0KIC0gQmVzaWRlcyBOTDgwMjExX0FUVFJf
V0lQSFksIGFsc28gc2V0IE5MODAyMTFfQVRUUl9XSVBIWSB3aGVuIHNlbmRpbmcgcG9ydCBhdXRo
b3JpemVkDQogICBldmVudC4NCiAtIERyb3AgcG9ydCBhdXRob3JpemVkIGV2ZW50IGZvciA0LXdh
eSBvZmZsb2FkLg0KDQpDaHVuZy1Ic2llbiBIc3UgKDIpOg0KICBubDgwMjExOiBhZGQgTkw4MDIx
MV9BVFRSX0lGSU5ERVggdG8gcG9ydCBhdXRob3JpemVkIGV2ZW50DQogIGJyY21mbWFjOiBzZW5k
IHBvcnQgYXV0aG9yaXplZCBldmVudCBmb3IgRlQtODAyLjFYDQoNCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYyB8IDggKysrKysrKysN
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAy
MTEuaCB8IDEgKw0KIG5ldC93aXJlbGVzcy9ubDgwMjExLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgNCArKystDQogMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQoNCi0tIA0KMi4xLjANCg0K
