Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26542127906
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 11:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLTKOg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 05:14:36 -0500
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:51076
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbfLTKOg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 05:14:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfClErobgtgF/pfZnVx3fdhVvLKR6ZhYxF8GOd4Dmr7W5NkgDYp/tDt0YJQCjQ4enwM619C8nheIAo4hYyeC481l0ytZSWHYEFTaHQAOvf6LL+3J9u72kG8zp0nQeBOGtqAI7wY6QTpRYBPNmbkQ7JoO6cvxJ2Icl01BziPOa7uOtPuADKTPiumWOmju8YWYfxYuUF3FrjZiUUMLzXIL0JXzLvnsYCIF6Y63NYRRjwkl1F45/qtuyLNprvuCUeLFA5sN2wQTrr20JfgboU1Pn0mu32+ck58QVz2ZVSDFNpoGk8bwSQ7wx80AkGalngopdOEdTJq9oO4EfFlvUwx4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBqReNbJ8E4/7Ss/O2EDv14mJnYDL1Xo6RXAp9ialVY=;
 b=eyU+aQiqsZSqW+smOKf9/iq8Kf81AEU6D+jPG4EY2Agz2R18qdywx3mruUEPRy6W6uqSjW+p8TJOqjoM44CEUGGwXn/KDOPwDGNU+2hlCRleM26Gt4eAAgSyDMhRbOpO7cPi48iTuX4NOexoOUAHKvUC224GM888n/L0iSSH0xcySQXA6U5DWSsXmOHy2w+mXr6VfxHimw06Kf1ITkmtfHsp5WsrPZzoCZuBJU9/5m2PgfzT6+DJVxUJ7wQq/HPeLdiWfalhz8aqQvWioH8iJnYYxAzZrVbg3rxttlqBFUBlXfgoz+ZcXbW3cXivtMyEeU1W2tfsSp+iSt9CL9EHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBqReNbJ8E4/7Ss/O2EDv14mJnYDL1Xo6RXAp9ialVY=;
 b=Vx7BTa3TF4p0/AT4IBmQrw9g1Il2+Uv1rOaDImzL+rGubYmyWQIW0SUGqItjtbt8NnBNVYbFjtYShp/FWRf3Krf2H8s8rHjh4AMYfQkwoQ+JPZMm/gdj3Sth+s1Kf8ppqoZGLlKepyn29BHtf74MpMy/lCPuLzs9Wi8HZLvKlAM=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB5065.eurprd04.prod.outlook.com (20.176.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 10:14:32 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff%7]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 10:14:32 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Brian Norris <briannorris@chromium.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>
Subject: [PATCH] wireless: fix enabling channel 12 for custom regulatory
 domain
Thread-Topic: [PATCH] wireless: fix enabling channel 12 for custom regulatory
 domain
Thread-Index: AQHVtx5F2vBO0po3d0S4qRl+Mr9tgg==
Date:   Fri, 20 Dec 2019 10:14:32 +0000
Message-ID: <1576836859-8945-1-git-send-email-ganapathi.bhat@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To DB7PR04MB5242.eurprd04.prod.outlook.com (2603:10a6:10:18::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.121.64.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43a16382-9eb0-4f5d-dc01-08d785356835
x-ms-traffictypediagnostic: DB7PR04MB5065:|DB7PR04MB5065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5065154399C3B4188993C1658F2D0@DB7PR04MB5065.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(189003)(199004)(6512007)(4326008)(478600001)(6486002)(8936002)(8676002)(26005)(44832011)(2616005)(81166006)(81156014)(71200400001)(66946007)(52116002)(6506007)(36756003)(66476007)(66556008)(186003)(5660300002)(64756008)(54906003)(66446008)(6916009)(86362001)(2906002)(15650500001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5065;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /sQO4sHYGfCeZ/hAERJI7J0Jw7+t7ExLoVcD+F6Ih+M0uGO952xREaspihZaR9fnhFuzePnnhZ1PFqM6aMd42xpj9CO6MyZ2g/4m7qei4ShIGbUEKyIgdj4Y/1pkKX9xjYiFcrT8gOOePzV0BrAZsCeKeD/jZAwMIAYE5ubO4EIy/YoyFiOx0Px/iFNmboP53j3sfGaCp6vQ6yFrDkf7islpSxbF+wibGXSHNMJZYlkRAlxAmwVGHQMu7gOE7lGANaUckOJMmJYdDWPnzbiT4riJlQbHgQH71QBZca3hkywMSYOq4JBgEr2HIkhs/qpZL/YTImvKwM+FPLg6OrisQHf90SHWZNAwhX20BSxi2YsX0Opg8Ke6NJUatYLNcNi4MIYsmEFsuRc2SmDsK4WpJlnSxoIS7yGCIsem7k9bwxgIImafKi0NGw8xcKqKvPem
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a16382-9eb0-4f5d-dc01-08d785356835
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 10:14:32.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gt9BVbRWLH0VY7OShwpfg2m3CGoXnL5wzgKVxNdGvNaChNvbNr5tItzKl07mvwDXbNHZfZSnOgcTbLGhXSoOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5065
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

'e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by
default when checking usable channels"")' fixed a broken
regulatory(which leave channel 12 open for AP). We need similar
fix, in case of custom regulatory domain as well.

Signed-off-by: Cathy Luo <xiaohua.luo@nxp.com>
Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
---
 net/wireless/reg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 446c76d..91fa3df 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2261,14 +2261,15 @@ static void update_all_wiphy_regulatory(enum nl8021=
1_reg_initiator initiator)
=20
 static void handle_channel_custom(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan,
-				  const struct ieee80211_regdomain *regd)
+				  const struct ieee80211_regdomain *regd,
+				  u32 min_bw)
 {
 	u32 bw_flags =3D 0;
 	const struct ieee80211_reg_rule *reg_rule =3D NULL;
 	const struct ieee80211_power_rule *power_rule =3D NULL;
 	u32 bw;
=20
-	for (bw =3D MHZ_TO_KHZ(20); bw >=3D MHZ_TO_KHZ(5); bw =3D bw / 2) {
+	for (bw =3D MHZ_TO_KHZ(20); bw >=3D min_bw; bw =3D bw / 2) {
 		reg_rule =3D freq_reg_info_regd(MHZ_TO_KHZ(chan->center_freq),
 					      regd, bw);
 		if (!IS_ERR(reg_rule))
@@ -2325,7 +2326,7 @@ static void handle_band_custom(struct wiphy *wiphy,
 		return;
=20
 	for (i =3D 0; i < sband->n_channels; i++)
-		handle_channel_custom(wiphy, &sband->channels[i], regd);
+		handle_channel_custom(wiphy, &sband->channels[i], regd, MHZ_TO_KHZ(20));
 }
=20
 /* Used by drivers prior to wiphy registration */
--=20
1.9.1

