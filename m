Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB113234C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 11:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgAGKMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 05:12:19 -0500
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:22689
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgAGKMT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 05:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ+0w8q+WT7n7JSCTdRAsKzlJj5Fps9bWwb8sgEv4OvttavLgWb5aDWGNGt9Gu3R4lVYVhls9A7ihEHir9NtLuutVZyx10OTcYtpek8JDbIXPOABsuLNp+ESFSrvNzSPO+kVTV5DZvQKTzlMp903icXBFPRqy9MbjzUggrQUs5N7kInzQj3h6S8vu9HtxFC7kZytlx2JGd2f5SnGgQqGvGEj6mimFXu7d8jrrcZIDF2e43yiD/tpM6npaopF1BuQJaKznDSTfSkqDGoSdidAFypxuYF+nrzV9vMLgbC0RjtxxYIlKC1g2Cqjg73ol1dPR6uoNsNQsE4cH+SOfjBAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Cmmn9N7F+74KQZi83aZQOREtBarhMPxDjJJbpMyeE=;
 b=nzDBSJ5PtMls8Pwb46T2t5smx93NcM1KXk3Nlqmgkg2FRDq6Dy1cQpTWq1xUhukfhJ9GYtY8rXxD+Jt5RNhxcqIJB3+/793+cMgeHxn22sDCe3YpqR4WvJxiMZ0XQ7lAhqNb1OOn5ef4l47Nob6q8VVuMn6qCaMUuNVpI92TBt3mBX39YhBjESCG4pCujunh/cQJDoZgKvsLjbjy/y2kIxV5XuGoZvYAO66gdLWKkW3kaI2kStQi8ERigjOvn/47xChKdNiyExPjxF4vCVvRDFC3UBDuZgh4GINSV8elx+w50Do01PTThUw8JA7a7jfPtVz+SKO/JsjQ/r/XPZlD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Cmmn9N7F+74KQZi83aZQOREtBarhMPxDjJJbpMyeE=;
 b=NBpnJ/AIsZig0ooe5ZSL1bTXQMeCTFxdSljR7zGVM02yHRoARfiAmbvaPW8mg2fFwWRBXZQ3JLUM5UfmZalONghgdB2wPm07YgcrqF/s5TX4mR7WcWNKJParJLzeh1Zm7/Dvs+O4wcdXD3F5TKIOZV4I5vOiVNY1Y/1PUO5aIv4=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB4524.eurprd04.prod.outlook.com (52.135.141.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 7 Jan 2020 10:12:09 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff%7]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 10:12:09 +0000
Received: from localhost.localdomain (92.121.64.9) by SG2PR06CA0116.apcprd06.prod.outlook.com (2603:1096:1:1d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 10:12:06 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Sachin Shelke <sachin.shelke@nxp.com>
Subject: [PATCH] MAINTAINERS: update for mwifiex driver maintainers
Thread-Topic: [PATCH] MAINTAINERS: update for mwifiex driver maintainers
Thread-Index: AQHVxULra7xFx8PUQkCYPtEHbpzs0w==
Date:   Tue, 7 Jan 2020 10:12:09 +0000
Message-ID: <1578391915-3960-1-git-send-email-ganapathi.bhat@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0116.apcprd06.prod.outlook.com
 (2603:1096:1:1d::18) To DB7PR04MB5242.eurprd04.prod.outlook.com
 (2603:10a6:10:18::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.121.64.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aec1c2a-341d-46e0-4d10-08d7935a0e29
x-ms-traffictypediagnostic: DB7PR04MB4524:|DB7PR04MB4524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB45246E9FF31DDDC546D536928F3F0@DB7PR04MB4524.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(4744005)(478600001)(2616005)(66446008)(66556008)(66476007)(956004)(6506007)(66946007)(4326008)(8676002)(69590400006)(64756008)(16526019)(26005)(186003)(71200400001)(54906003)(316002)(6916009)(52116002)(86362001)(5660300002)(2906002)(8936002)(44832011)(6512007)(36756003)(81166006)(81156014)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4524;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noewF4KzMh1iSWSvHL7y3RX2S9wCHCb+d5xuSJBi44C52L51EGPcqCFkw20LSVrYyKiNKNh9micM60ewIwOGOMDGI59HbI7I7Udg6xVAS6IP6dOkGa3CkTnxym7a4B+KDaP1wH92kzKStTwSfKWmjQzpn5xbRtZwA3nitleI0mYz8iR+SZM8PZNbtlVzsVhHh5FvBCYtPGmd4IcpiEC53R7AeCNO2F0BMomm0e3bPxl1lbmnbwQ+eMFws2DEf6QRhN29xVz1UTb/e3/exa4pX9ahkY3q8TO2z450N4HrsScn2+53QEULgRoMoYyrKQlaF3ZQw1oRI0y9ygZpb35sch/I8AMl3JVh3Q+fzN6BT8C04fimY7x/sjG58jApZV8HpDZFlfwLB5byq5BmEjvL+zX/K+zp1KRNARUVunCiTeeksy0IopvvIxPrWpwpKPW5bFguVqc0y2/MbG5lJBo9QcNzX+5lDNhSaeteG/LROLieTAPYkkcFJOO6rM6pDfVj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aec1c2a-341d-46e0-4d10-08d7935a0e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 10:12:09.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkHf/3eDFr2FeEMyoz5QXx0qTmzPTIEFq7HEFIE1ga5FvFFjg8HfgZrsfPQJ+uBgcx/zE/NTOzVzKaTyPc2vCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4524
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Parmar, Sharvari Harisangam & Sachin Shelke have started
to take a more active role in mwifiex driver maintainership.
This change is to add them to the list of MAINTAINERS.

Signed-off-by: Rakesh Parmar <rakesh.parmar@nxp.com>
Signed-off-by: Sharvari Harisangam <sharvari.harisangam@nxp.com>
Signed-off-by: Sachin Shelke <sachin.shelke@nxp.com>
Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d095198..d371843 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9955,8 +9955,10 @@ F:	drivers/net/ethernet/marvell/mvneta.*
=20
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Amitkumar Karwar <amitkarwar@gmail.com>
-M:	Nishant Sarmukadam <nishants@marvell.com>
+M:	Rakesh Parmar <rakesh.parmar@nxp.com>
 M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
+M:	Sharvari Harisangam <sharvari.harisangam@nxp.com>
+M:	Sachin Shelke <sachin.shelke@nxp.com>
 M:	Xinming Hu <huxinming820@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
--=20
1.9.1

