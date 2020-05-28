Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7E1E60EA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbgE1Mct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 08:32:49 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:24418
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389279AbgE1Mcr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 08:32:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTRhF46UoipCDrhTI57mc2lOC0onjt5GQ5glpspyXg6rgw8A9z+ozFK/QJMDEuzvb9bfRulTlMnlcM5q+6jWIyHc+w+yu/wR/tm0Irwx42Cf8EsCjavAnZVoQWXB2QUuu3SPVclC3FAWnq6KFbLhS4yuW7EjvCcr6s5mq5OATVuPeUFzmviNGj8+7bkx5YALOmHDSgi04fPqbWBQ2PAX4Ibf7MFdvgu0EOvKefOZDm+2Ohpm8DzNXxNONV8kT+f0LOZB2MJmlq1E6273xnK7/OKZvRjSllNG0MjpYutjgPRS/Jyz0VYjjA+zUAelrCm4mUpv/OjFnfH/WhNhhBBBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA0Ixfgt2t6+2BNKy5rniQQv7W86MoGdcA3p9aDbrVU=;
 b=cFoBh10dAEfUOXHMUD9SvM8Xt3Co//pzVEHdlhUdFm4+mWDtr9jUynGyABeP4yA52IOC5HeyO08CcfsrCsf7d3dUgZKZiAQyfiWOYNYTAahbm2fi8G3YjW1vCY0cyjdI/fQIsn/YApAzAWoNjHQHvx73Oe6m4VXqtKA8LsKKUgmGE+pHSjoEkcAvMgbLBFah1ROcv1AsO5MbgpnapsAJgqxdzfxX01RVJ1QqLuICqbuNP/gFT/ElCvvVHywnOQPWxYQSUmJZfwWk2JUdWu6RbNExTwhAtM2NDlHvSg0uD9ZKudwfj/ydR0L2UEFfZiUQteJpLnVDgf4b/zzBL9cV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA0Ixfgt2t6+2BNKy5rniQQv7W86MoGdcA3p9aDbrVU=;
 b=RkHoTbjlsZeYOnQ+mx1DV0+cX6+hjfTOkuPdWcIP23EiFh9uxLaZ9sYSxX3YxCSqJAk4eACRdV3bTEXcNLPPKWMcshy57X4pWwbwCTNiPuiJ0w6StFzUOZFVy6EAZY/Yf7K38kFXyKCQH6GhX85j8cvOrL1NlOhEGYJh0AY37A4=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 12:32:43 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 12:32:43 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Subject: RE: [EXT] [PATCH 02/11] mmc: sdio: Change macro names for Marvell
 8688 modules
Thread-Topic: [EXT] [PATCH 02/11] mmc: sdio: Change macro names for Marvell
 8688 modules
Thread-Index: AQHWMEeuWeLcIUCYeUyYT+wggOmgN6i9d2kw
Date:   Thu, 28 May 2020 12:32:43 +0000
Message-ID: <VI1PR04MB43668C45F20EECE78179ECB78F8E0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200522144412.19712-1-pali@kernel.org>
 <20200522144412.19712-3-pali@kernel.org>
In-Reply-To: <20200522144412.19712-3-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca7b1354-c335-40ec-cada-08d803033840
x-ms-traffictypediagnostic: VI1PR04MB4366:
x-microsoft-antispam-prvs: <VI1PR04MB436666734DD809481C1A69A08F8E0@VI1PR04MB4366.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESNnmwwBk9xw+EqpcDpDkIU1MClWcX9EIew2dSd5J4mQPHgs41NUZBPY468Ihk/tyBLDz0pSkXFvjO9N0tGa0Fx3O08I+8LaY/BycnLK8+717rN9E9rtoltgMzOncRt6dCAvnEp0VtvGZrvsc+b4HhhNrFbqRGDD14LAA0Xc6m4PDONdR04YOlSPTg4csJfSca6m2l3PNYWFw4z/cexXx8HTmgmEKMbN7UMSvQVcir3BmTta3R3RxhXX0Heemmlo3NgsIuVMBtwzZcTZYlZhkEikvmIvbS/G2YGb4yliP1wJL6/7NRoRsp3mhv2uadWw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(316002)(33656002)(5660300002)(44832011)(558084003)(186003)(7696005)(9686003)(54906003)(76116006)(110136005)(71200400001)(66946007)(66476007)(66446008)(64756008)(2906002)(86362001)(52536014)(7416002)(66556008)(6506007)(26005)(8936002)(8676002)(478600001)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: N+FxMGKvUKKHG8gJjgTFgOaRXptaDXLmPzTmm68kNQDYf75HCZTHZx5b3+9myP8CJj5+cdPWqvZU1HQRQm00nCn+CNeXCpE349KRZGJPO5/u5FGQaS3K7EeP/rCNih8nIai/LkkBlS08Jf5Uh/Ms91Jmvb9UubGcsXBd28QPexKeITZ2OJRbDNpwqUMHOkaS81Sme2hL5yuFhb7wtuJLfGAWfHMDSB3PhXhBQGx4SCJVRnuC2NxQx34n6iOp/mB5/H6jMniH5T+Ty2MDxFwLwpRPpy7v4FexYIbKPR4FxCis37aXBM9dL89Qv6JC9JPMu50ZfnjZThdka2J3EPUF9KiWKtHRCU1X2Co4CCycfMb/YLTQSyOTu8ZwFy2RYJJuykMReSnjR7V5WEf3aMpQ76YissVSGhkqHqPv1VsbULIih7kKe8eHHDXVWAjsGSsbkA8w0V18INjC1lLVuPH1pSByEAHjnxTV3oih+geTGA8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7b1354-c335-40ec-cada-08d803033840
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 12:32:43.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbCG6NOquhkq8Bse3J2apcyRB/AzPvZDgSnFSUovTtFL1cJYZtBHwqzqJOIE0isEz+l23VR2U9C6kNmbWjUaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4366
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUGFsaSwNCg0KPiBBZGQgdW5kZXJzY29yZSBhcyBzZXBhcmF0b3IgaW4gTWFydmVsbCA4Njg4
IG1hY3JvIG5hbWVzIGZvciBiZXR0ZXINCj4gcmVhZGFiaWxpdHkgYW5kIGNvbnNpc3RlbmN5Lg0K
PiANCg0KVGhhbmtzIGZvciB0aGUgY2hhbmdlOw0KDQpBY2tlZC1ieTogR2FuYXBhdGhpIEJoYXQg
PGdhbmFwYXRoaS5iaGF0QG54cC5jb20+DQo=
