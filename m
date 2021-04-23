Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB73699AF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbhDWSae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3594 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbhDWSab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202595; x=1650738595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qm71vc3tlF1M51gRNDOspdEz4hzegMwwe98vYnk2J1Y=;
  b=qFSE4dD1r+3hUjOtAB5pU2SPQu2V0NEobjtq3j6WaOVOYApMat4CnIfc
   GJ2uJ3OrdhW8P/Y7W38cq7WmRt7xVPhdNlgMvPguf+0/YHenrgg+oOvCe
   g3uZ6wztdF6TjHq3kgl6Bu5x9YfabtXtSKNUhSbE6NX747v5XzzMltmDq
   eg0aeSDTcRMjN/wMIf5Opv+o28ugKhXI1GqXBqBWp2r68fCng5lH6qxAk
   Dh5yTrVVnwZbgG1yLHekB4cUhA3WPTaWaHoXf57A31UWA2N//lJ7wrfFm
   LjHS/82nyXjX1BWq+Y5N1yZGjYBlEgZPUXT+KoNlsTxtXuqZ8eVx89uHA
   w==;
IronPort-SDR: K+R8SPkzku9/vd638Rn0do9E5r+bbTRB2kBj8t+OSqGTxrKEeLKdDFnjC+D2hQdu4VT4NKkS3T
 4Ba7xrBJPPr1iKFU2/JS4g/PUpmhKeBDZt2PCKr1juj0t8oLzQLrX3MNiKOA6sg6EIAP9HehFg
 34L1W4xApYzILJFvje/UXBUb8OyQQmRo2TXOrtuPQn1m47IR61fxfaJ5QGOtRSRLXNKcnl4Sys
 lZnzbzOm0hiCtyptvu2xGH4+QcDtJiDJd1LyKhJ27C2Z65paZIwSqDMA3q01cdjQS1OxCRv69I
 9F0=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwzIKQZbTCtxqpuNHv20AX383MyqTyhbEq1zTz0t/fHWdgfkts24hhuPR3xSdy/ma51i5XGaTRigbQjxFweomXqIOSzJ1jZSWW/nNwUwAPKHl5FKWmgGnCT61OIohWfhJy+jadhFDlHW2Lq7bdt2wDST/7OBnTpO5uNGGtKc6hI4DbreqRXMoV5rK0/Lvj1EvhyOv3ud4tzwT82d6HwskAguwTRksQ77VY7hjqzFlH0hw4YyeJK060ygTENdJplxhT/bTaCfhRntM4HtQlytOYtqloNwrfA4Ybuen9bE0O+5nA2it5HYGQvtZ1Prv7syYrIClLEi3rWOS6AosWgDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtbF4jTB6xItvpq3WBA5J69Z4fhvvXpSER5zsClzpCw=;
 b=WeF2TGj5FapykIuPO14TOP2hwhHVQu042r6k1ev26qB2ohauF+DQdFpQ/H6wUcpLlNpfaMpJfCgYaxstlhasJzsr6BgOEkjUIvpR6chLxOFFoJFA9z92hnrB+bm6uAqTdkq7ABOmCa4DkG/TxssReNtlxM8Jsx4opTmRXRpNX0mW+2uXXUKg8DSfm8Im3pJbehKxPEwUEE1Cp8MIRqb67/fu9V96rV2+sGDz9uvxpvvz+1IqVLITj+xW6EZlzcdutdY6zRcRd04751R+ecFsMqm0iOzCbhqqDazJgGz87lIeLBQcEq3S/03vgNRbshDpT5s1kZEibBe4Vwx+lXECiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtbF4jTB6xItvpq3WBA5J69Z4fhvvXpSER5zsClzpCw=;
 b=l5u54P2SXe6+c7qr2MNyAq2rwgCX113xu0eAU9mL6jF7VUXDOnCyhG2U8szFLllN7MzqiicPpmyB5WMgr8nAUe/JGBOC8A5sfQUMkyifFFW4xehPP0b7e+xSzjMF7c/3o4AMR+Snmqqft4fG8rNZXxLvEsyg5isQM8xnlCVw6mw=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:49 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:49 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 11/12] wilc1000: use write command after read in
 wilc_spi_sync_ext()
Thread-Topic: [PATCH 11/12] wilc1000: use write command after read in
 wilc_spi_sync_ext()
Thread-Index: AQHXOG6lNmP3/zddBk+/8QqBnnrwEA==
Date:   Fri, 23 Apr 2021 18:29:49 +0000
Message-ID: <20210423182925.5865-12-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1356ac0-0180-4754-22ec-08d90685c7a4
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3318367030AE8EDC46576B39E3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MT4ESFy78F+mUVGtdSHSfVTXAAwjaj4bF0nAZjFWTCPBnYTsJ7NYsBQc9g1Ndl8v8UpCF9KvxKvINEOoTE0jG1Qf2AOZOb14QQSezeVN2kIJwX6KGVYYY2W1VGpRUOm1t4wMiGFWdzBDNx99+tvhhU100L6aEXh8i7H7+3pNtQYfh3Csdw5+csoqcWA0T7rLQxmAeOoyKcQN4XK6loAEHr2PUwD8uqwhWzENPiEH8mrO3/EVt8P0qbVjjwGyuQG4pw7brGisa0rAj5Fxj+EDKRQGavDgg6BC0tbrIrJsp/g4CV+P4KFIuManWA7bBEtaiw0QqoEKuL1eLc5vF5cTSbOWcQCch/rNfmlW0E6Ps9u8ps0MKX//3izjoDhW+drbXR1EZVEW5C//aaUm/8zUO9pB7DWYavUrPWbSiJYPzw4iYC3ECc+uY8i8iUSdOzh8Btdf2bduZ7duSHO5pDls5wbMjNNHn2nSpb3Mkm2lcCeiP8wKJpoutFaOruHM/Jc65sRPjr9izSVcpwk/grJiKfjbPXRq9BZOQSnkUYRn4TXUghluB+37N+9GsJ0ZHkmUnPsfv2KdC/FUfgFq0BZBlhQxjL16nrpqQPs1ZLcvHLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(4744005)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?y83WhNSZRf1Bskm9yiRFeTmMykmftw+nOzm0Gl3XzZxKK0H18H03O3LgEj?=
 =?iso-8859-1?Q?G6qaO9pewQmkjHpA1EaiBIKD2n+pZrmk/wAYc39+2fOIXigxxG2PzFWQ3j?=
 =?iso-8859-1?Q?Z3RS1aaSjYaFSYp/AcjkazZtSu5QUlq8AsuHidjY6c5d954ID2OytPKNMk?=
 =?iso-8859-1?Q?NCbvQH3khGsOp8jqaW72/YKTAY7FfCx7HMSwu8Gwe1TW+l5AuBPj/Uyc99?=
 =?iso-8859-1?Q?aaeoIlgC/wSJwxUSAKbL+Zz8ARWYziLP8x/LMdvtpaEdr1g4IWV2QvgCHH?=
 =?iso-8859-1?Q?R/jVecaOSEtblUfcWys4g5vnWXSD9PquBIWtU84hLvkFtJXD227FTvyUQY?=
 =?iso-8859-1?Q?orouTemhcJ/g1aLbg7tnLDrqCigK37TUR3fxMpSCoOuo5Pe5pdPqkXzshq?=
 =?iso-8859-1?Q?ZCuihFC4a+4osHrovzHPDiClJ0j9K6GyL2gJxDtWVCPOjJXrpwR+AqQE6q?=
 =?iso-8859-1?Q?FdRqWh5CCFElDuEsFkbQ+oDKfaIlL+0BYHe4QDe8vNnU308MwUyUvc0WJH?=
 =?iso-8859-1?Q?ZBiS25yxqkThpW6gVUV5xhF24nShiz/hcF8pomjjzYIMcNvtpRiH93cwKz?=
 =?iso-8859-1?Q?cyGV14Y33lWZphVCDWmbYc7/xseAERP42hbQR7U5V099HfRwIksj21doqL?=
 =?iso-8859-1?Q?qb0PeJPS0RJznXeiRkIHCQxkL26GDGkgUKhQBf8N7wLHzUYw+Cwc2qG3Y3?=
 =?iso-8859-1?Q?K9MxwzcS29XEO3uUwlS4CZjyTdlu11efeu7O1D/060dcS0LR5RQfPO0kFa?=
 =?iso-8859-1?Q?0XNr/Z2SEWUuMN0EaRNDIcDtJsc3BLLsz1Lv+wNE4o9Gopiy3K/+kURQdG?=
 =?iso-8859-1?Q?vba2Y4oJRCIypodY8PfHh0qQrvHEYdcmjuy2iyeNmNpXuba0InlYKGB3xE?=
 =?iso-8859-1?Q?HjX1A/pW9Z1hc6wtUVgYwNopa2jfYn5l60k3eikEbmkFyDM6ZzoQQ6batD?=
 =?iso-8859-1?Q?hXZF5v7cIS7uvIBKeMGvyj6yeHn6Wg/vaY1Jp4b8G7dZn1Kh3ybI13UXiN?=
 =?iso-8859-1?Q?kiCLFhpuVjRqeQIp63n0vamhrdJfYG8eeL7mjQ9/EtOJAVJOqpyz8jO9E2?=
 =?iso-8859-1?Q?6KkUngE7yqr8asuD5U5aFZwa8dteXQBPbo3eUbYygb4nrBYMvG9EpY/YOM?=
 =?iso-8859-1?Q?t3+Y6z/k6BexUwOyqv0Sa72WdibAi8gClKCxvNHFEOtQjgpmS8SeFCWMmx?=
 =?iso-8859-1?Q?6vIutJPBaEQU0csYyBm0bktGIfHbISVn4MgiiRd2sewQwHmMvnl1iiuKnh?=
 =?iso-8859-1?Q?WNl5qZMSK0UTqlY8AbLWG8LW4VD04RqXlmCIj+cGUG52I7zd70bLjeNPsf?=
 =?iso-8859-1?Q?mv9kmbPi9r9hGhxHpU/kJ+ckECYgHr4YTKgRGlFpJW9JIiLjQNYqDUse0k?=
 =?iso-8859-1?Q?ATirbv9wZORbxMXZ3OdrBxAEl4k5xM0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1356ac0-0180-4754-22ec-08d90685c7a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:49.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wh9p9E2/TW2CGqkkdR79lUaJGjS4rvP7/41ofGn2g0Qnr1W91f850xx81cWOUBx/yr2ml2U4N8soDpxJ/tJpqnCFb82A78yIuVQIhNVmHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use write command instead of read command to have correct sequence of
reg read followed by write operation.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 8e88986db9a4..1ab0b6dd0288 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -1170,7 +1170,7 @@ static int wilc_spi_sync_ext(struct wilc *wilc, int n=
int)
 		for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
 			reg |=3D BIT(i);
=20
-		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+		ret =3D wilc_spi_write_reg(wilc, WILC_INTR2_ENABLE, reg);
 		if (ret) {
 			dev_err(&spi->dev, "Failed write reg (%08x)...\n",
 				WILC_INTR2_ENABLE);
--=20
2.24.0
