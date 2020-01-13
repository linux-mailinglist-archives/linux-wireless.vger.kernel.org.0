Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE0138F6D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 11:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAMKmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 05:42:49 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:15246
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727289AbgAMKmt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 05:42:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh9GBhr1vQy7zrLj5xg/A5+elagp6VmRws/lW+90AGkP+qwnTnAuwaP+Dopcvr87+FzvUOqDEUXyDnnUk2LoAokINuG0CTBjW8eyk/kw0ZjmHgwWO1HSSCaSG8QCJHdrI4Oxj6gvr0nC2iPsnihlhXB1KPXuOVdiFGTtT+gFMVTtCvsnjLdX59qfIfJlCy9Mu44kMiYEXnI3CeBOZ46sSLKZt1xgXSfSsEAjFp4tMdUroRvAgdIJ27keQjOYxPq9STKPOA4kUGEUPp8UGK2oE7h5ovO3o10AY4ynvnWyT6j8Y/4nV3+ES/Ie96AtokHn38/oQ3Oxw38EUak0j/WdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdkXT8iF18tmsRImQMs1aeqdEbdCGNFyLPU7tCpEFrA=;
 b=cewkJMc+6Lv0TrpYB7Okan+l6tF8wtEvY7E/5h66Dsk+fY7S8FPJ78EnI7Qbge5xk95yV2qb9biQ1ppYttGdIgaFYbV6I9OXzthzyuxf9sleKg1B7IKomTjiFtwDm0WXEg0QQf42250VrnWTxO/eyOJm0J1KTJq/+GM59lcu8YGhr3RSvnPfUuPaqv5May6S9j9HNJvTsAXCDJiBVzmy4NYk+0giW6iwmyeLuN+tYB67UHJSjag+0KC2AtdTpx/n+mIwHwPN9qpcS1mVuI9du9znQpUk4cUU1JzSDwMfsSL6xBJw9Ll3N7/ete5ntam7r436ByRQ4W3P7hYtg0HHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdkXT8iF18tmsRImQMs1aeqdEbdCGNFyLPU7tCpEFrA=;
 b=PO9vwIbVXPf77eulJT+0y1lsSem0ryPZGUjhfehIATjxvk4P3uMNST0WeejOBKrsHhwfngCzg53sPzBqLwWFPrFpeXrX71dmsz1LA3N82qTIt4ubZ3FDnpfez+F1/GA+GHrUnsLj0HxGau6DfIvQHGxjtz0bPRfqnQKvKvZ8Fm0=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB4089.eurprd04.prod.outlook.com (52.134.109.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 10:42:46 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 10:42:46 +0000
Received: from localhost.localdomain (92.121.64.9) by AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 10:42:44 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>
Subject: [PATCH v2] MAINTAINERS: update for mwifiex driver maintainers
Thread-Topic: [PATCH v2] MAINTAINERS: update for mwifiex driver maintainers
Thread-Index: AQHVyf4x/oAGc/bJlUyG23D4TuFddQ==
Date:   Mon, 13 Jan 2020 10:42:46 +0000
Message-ID: <1578912148-28796-1-git-send-email-ganapathi.bhat@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::17) To DB7PR04MB5242.eurprd04.prod.outlook.com
 (2603:10a6:10:18::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.121.64.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 011af19f-ad74-4b70-82a9-08d7981553c3
x-ms-traffictypediagnostic: DB7PR04MB4089:|DB7PR04MB4089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4089BD7213AE56182A28988C8F350@DB7PR04MB4089.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(86362001)(316002)(956004)(26005)(2906002)(2616005)(52116002)(54906003)(66946007)(5660300002)(4326008)(44832011)(66476007)(6486002)(478600001)(71200400001)(69590400006)(66446008)(64756008)(6512007)(4744005)(66556008)(81156014)(81166006)(6916009)(8936002)(186003)(16526019)(8676002)(36756003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4089;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gU4c0841GbcXeSiottoPE4+OEg3dsYze2u02HneDmBszgI0J07a1E3fqv2N20ws7dJ5aWSChtWRa/Lcam/nPKqgJZ9srM+Cp+VVTKJCPF+bnFDFBjbxormU3OrKBZtoQKCLwC6jAWfzavLQMHISXAH8PlBsuPJ5kfl11Lf4FqN7LZQKSIUuesf6JRmUu3+uODTs1BqQkyZ17oweaKZkvzcNJuHgvd2cYrgQAjGOOAddoV8mRBC3SP9qb9RaqCq5ttWckSNWs9OUCN84CAviSLIGQr60xoLIq1T8q9mgRyk3LfZUIb+JA/JVJUNz3bKYhQTsu+aVQWfg1JdXhp1T5BtM9Es/baYrOPa2GKXAG3qd2kqn9AQ8ai/Fuz3GKaqXPbeg2L25rA5+hmYx2Y++dAQYnZkFj8Sbhxk3A+csNsKnU7GqcDWf+BzQ9Deo15GuBPVNk2tLhDdJyue1dojdcrDNLVgN7HcxmmiunCptE+h88tBV/8N2dcr2ZLdGKRLH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011af19f-ad74-4b70-82a9-08d7981553c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 10:42:46.7059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TkcraeQ1TZDd1xaKoSwiT/lZDjdRD3mk7BKlkkxCii2bddDHxPnig83ooeWNTR96+20kdwhhE73dGbinhDkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove Nishant Sarmukadam from Maintainer list, as he is no
longer working in NXP.

Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d095198..cc1af14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9955,7 +9955,6 @@ F:	drivers/net/ethernet/marvell/mvneta.*
=20
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Amitkumar Karwar <amitkarwar@gmail.com>
-M:	Nishant Sarmukadam <nishants@marvell.com>
 M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
 M:	Xinming Hu <huxinming820@gmail.com>
 L:	linux-wireless@vger.kernel.org
--=20
1.9.1

