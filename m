Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0603784D1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfG2GBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 02:01:20 -0400
Received: from mail-eopbgr150114.outbound.protection.outlook.com ([40.107.15.114]:30790
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfG2GBU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 02:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1k4+DgUYyr0ARSptkswLcuHo/PFIEGBLji6UCKhyvJeQ3KvH3+Us8HnrykKZXQX4q4LPQUlykOYpkDNOs83uw5WIhh+PWQLYK+3HSto9FopWxLB3sTuD91ne9HyStJyDOtBjigtuP0WAxeqQABNdattdT6lEkB/YVtXxwwdit4CohrfiGAPFbKbtdHVVksjKQPucRnonOvdZH4yud4mKsdSyeOhLnsZuVIl7JUeIV+WNSCGfRsX6JbEjDh5bhGS21ceAs+m4DAYCskZTQ+4zRKqnR8VYxruidoMv777kwBFNIKt13xjDWS2xLhhzaRffGDAycPk7H1wYfvzwDqEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io+/Yb8Bvf3XcDXder2ismRznfPlJ/Yu+tqXsUtxM+A=;
 b=QJUiHMgE7wfFhzSFX9Gyr78Cc1Ukb4pAndAogRr/PrqbIgNfC3NXvfortrRu2ek0zIFpeeOD+DCI7HAd8LJpj3ndA1tGLrQlSp3mWyeyvCyQSvCmbiSKI0z09sbI7NyMLcwmiRruM8nHIC+xDNzirAO3gOlTgnbMu4PE/acRhLTzvSTGvk92CxOi1kRxgD0xw+4pDMyfdklEIGpG1nxf6doAGoTANojOZz6m67GDNC618ZLqJ7SkjbE0kXPOwrioSXJ7bN+ZNjKTjBGKZelxXOB1ni4kbiUt3p2TCwd1/ZCgGGpEANye5uMdSi0xPfOx29Nm/A3iMpsFzmCD2eMeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=tandemg.com;dmarc=pass action=none
 header.from=tandemg.com;dkim=pass header.d=tandemg.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io+/Yb8Bvf3XcDXder2ismRznfPlJ/Yu+tqXsUtxM+A=;
 b=LyowhAr5fpgvfegYDvacP+SK9wlRaTzPf+xRmaHBE+zTOf339BVkiAZWhp3PhVEHYcw9w6jf2SLvP6TAPEw115QwkR2E3oewrwf6dkQ5VL5N0QR8xZ1R4SSX/Kx6In7DjbvntW8BHrlG+u0rnIZXgD363FSL4xUJ+S5X6ybaeBw=
Received: from AM0PR02MB5714.eurprd02.prod.outlook.com (10.255.30.156) by
 AM0PR02MB5908.eurprd02.prod.outlook.com (52.132.214.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Mon, 29 Jul 2019 06:01:16 +0000
Received: from AM0PR02MB5714.eurprd02.prod.outlook.com
 ([fe80::cd4f:61b:732c:fd39]) by AM0PR02MB5714.eurprd02.prod.outlook.com
 ([fe80::cd4f:61b:732c:fd39%7]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 06:01:16 +0000
From:   Michael Vassernis <michael.vassernis@tandemg.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Michael Vassernis <michael.vassernis@tandemg.com>
Subject: [PATCH] cfg80211: fix dfs channels remain DFS_AVAILABLE after
 ch_switch
Thread-Topic: [PATCH] cfg80211: fix dfs channels remain DFS_AVAILABLE after
 ch_switch
Thread-Index: AQHVRdMItpRNlNPHIk6DntyiTE54lA==
Date:   Mon, 29 Jul 2019 06:01:16 +0000
Message-ID: <20190729060024.5660-1-michael.vassernis@tandemg.com>
Accept-Language: en-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::15) To AM0PR02MB5714.eurprd02.prod.outlook.com
 (2603:10a6:208:161::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michael.vassernis@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [37.142.120.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d11c8d22-7db2-4812-1fe0-08d713ea2b3a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR02MB5908;
x-ms-traffictypediagnostic: AM0PR02MB5908:
x-microsoft-antispam-prvs: <AM0PR02MB5908BB90EC791494B4B199E9F8DD0@AM0PR02MB5908.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(346002)(396003)(136003)(189003)(199004)(99286004)(66946007)(50226002)(36756003)(14444005)(6916009)(2616005)(52116002)(256004)(508600001)(14454004)(476003)(305945005)(186003)(26005)(4744005)(386003)(64756008)(5660300002)(6506007)(7736002)(66446008)(66066001)(66476007)(486006)(4326008)(81156014)(71200400001)(25786009)(8676002)(8936002)(6116002)(54906003)(86362001)(6436002)(1076003)(66556008)(81166006)(68736007)(3846002)(53936002)(44832011)(2906002)(107886003)(102836004)(6486002)(316002)(6512007)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5908;H:AM0PR02MB5714.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fqM9yNz+fGSUTKNIjnBLoph7MWIj7E5qlofrkhfRF1Vo3sFQJN/9LySK7tqZwjZZWi8V0Qvl6vPuG9p7ijlZgOBZyXG3/FtPeyq0pDsZuJIA/FcMWPXacczRjwlN/vXjXcOM8PM/f6rfDRIcBTGSRJunlVbvKhawouR8VVrPfbv6gScnp3xHF11aQt4GzMbNGk1EOv7X/lZWiQ85p0+UwP8MrhWIk5aKYGvmrrcoq87HVNlOKvJDvStTL5y4q9Sp/uWRz4AuI1oJVdag1qb9D1CM3Ohb7+0B7Gh7ReO+bBCrzFtbQ5rU6PkwsFm78yGsgw0ygosOahiXy7zioJWZjx/P+Xv72CRjD4dlmRfIcxlu65cAPi70jlZZ5U1GznU8p/PDMNzn2cmglXigOYLGUNVViKysCQmuj499JEmFsrY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11c8d22-7db2-4812-1fe0-08d713ea2b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 06:01:16.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: michael.vassernis@tandemg.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5908
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Depending on the regulatory domain, leaving a DFS channel requires
a new CAC to be performed when returning back to that channel.
If needed, update dfs states after a driver channel switch.

Signed-off-by: Michael Vassernis <michael.vassernis@tandemg.com>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fc83dd179c1a..b8c51750ff32 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16094,6 +16094,8 @@ void cfg80211_ch_switch_notify(struct net_device *d=
ev,
 	    !WARN_ON(!wdev->current_bss))
 		wdev->current_bss->pub.channel =3D chandef->chan;
=20
+	cfg80211_sched_dfs_chan_update(rdev);
+
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_NOTIFY, 0);
 }
--=20
2.17.1

