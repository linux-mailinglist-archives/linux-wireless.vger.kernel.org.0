Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0213C6D8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAOPCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 10:02:20 -0500
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:38166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbgAOPCU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 10:02:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwjPas1canX0ebO5yfS7ucxSMrImuQIGVEMsdOzvxvuOguYKPdrCkBbxyDFEwC9c3n85tA8RgAlGi7+O0Qw5dEojjyNqOAVyj0FnZZScACTML7GefTkwGZb9lOIEgRXeVqGiCIhbeYPFz/PobIALQc//XoJxGjeGxCJZ6hvlxoon1fs2nWRNk9DLCxRzwBtu0pCJxHUVhgq+q8C8nUSWxamO26Mit+x7BfhEYHBPGIeX30JZjzeunEG5ci7/9LzaMNeK/wa0LTEMoP/SuFzH0R9wWpFz0aka2M2J/FU8w0EKDSN+Utp2dzapxv4nol5r9JwPyyJN+4dsdBMMHWHKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TulLm90Ai/5uZLceRUx1X0jqKsnqHugYpvipfRw93aU=;
 b=h/7H7OYpBupxauSR6Y6pvua2141Hmm7KjrS1ikDD0kaTwN6dLP6NSMkxGPZxk7CJwH2XGjSCSSkLD35M2hl0DLIXI8SpSCaFanMXlGtAsbEPqBcg3vKoGb5E6bsgx3rCXAB4nbY31dS0+Zlyie/PdZbxP+M7LdEzxy7arZQWYZgdO+Ij6izS+su0VrzV8csVUbD18mBi0jTBzUjKKLTpk7dZHg5stVARlDdQ9Lgs8qr2Cq6LlSsl1dbGDXQvMRa2UseDHZQYtAVMnu80c4RR8wtRe9tAWgOllF3qP5mnHPWloiSskgvnwZl8DCEU8iKpRJkXS1OFwSsAL5yHrGYSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TulLm90Ai/5uZLceRUx1X0jqKsnqHugYpvipfRw93aU=;
 b=rzkKmiSVDcbXM4CFKh014K+5s0ogRU8yXcuID3L8kccoJhbB9X2JM9xsYUB3EgSYNEYV4m6K5PjwgR2qyzIn/qqIZ+Qamh4uPo5o4L9wwpAesw0o5HJIFUCEE02xBi7nNi38JCG103Nax2wr56fyvjaQCup3OEpj8H0JDfCR0p0=
Received: from AM0PR02MB3620.eurprd02.prod.outlook.com (52.133.63.21) by
 AM0PR02MB5732.eurprd02.prod.outlook.com (10.255.31.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 15:02:16 +0000
Received: from AM0PR02MB3620.eurprd02.prod.outlook.com
 ([fe80::cc09:22f:6786:819c]) by AM0PR02MB3620.eurprd02.prod.outlook.com
 ([fe80::cc09:22f:6786:819c%5]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 15:02:16 +0000
Received: from orr-ub.tandemg.local (84.95.243.50) by AM0PR06CA0086.eurprd06.prod.outlook.com (2603:10a6:208:fa::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 15:02:15 +0000
From:   Orr Mazor <orr.mazor@tandemg.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Orr Mazor <orr.mazor@tandemg.com>
Subject: [PATCH] cfg80211: Fix regulatory data is reset in case all phys have
 disconnected
Thread-Topic: [PATCH] cfg80211: Fix regulatory data is reset in case all phys
 have disconnected
Thread-Index: AQHVy7TG5nX+3c3iBUKSj4Vf+8rn0Q==
Date:   Wed, 15 Jan 2020 15:02:16 +0000
Message-ID: <20200115150123.7612-1-Orr.Mazor@tandemg.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0086.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::27) To AM0PR02MB3620.eurprd02.prod.outlook.com
 (2603:10a6:208:3f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=orr.mazor@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcd95982-f3dc-47c4-82c5-08d799cbe8f2
x-ms-traffictypediagnostic: AM0PR02MB5732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB573294FE1965C46B31A6D2F5EF370@AM0PR02MB5732.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39840400004)(199004)(189003)(16526019)(6916009)(186003)(4326008)(54906003)(26005)(71200400001)(316002)(6506007)(52116002)(2906002)(107886003)(81166006)(508600001)(15650500001)(8676002)(1076003)(5660300002)(81156014)(956004)(36756003)(8936002)(66946007)(86362001)(66476007)(66556008)(64756008)(2616005)(66446008)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5732;H:AM0PR02MB3620.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2BuIieTSZ3ry1h88p+lOGZ9eEmcD0+ZDEEI8mZ7n56I8Xa7M8W7gxHAZcSKaUxem6EYIkio7z457a+f142ddBN3zeawtLPOjxa7BKoYgF6WAzJ4kjy9Cyx+JUv00ofBetepoMW1KYceNPBSD6qkW/v2+kxntDLyAxi8f9Q/peIrOTMKnvybcVRmxjjdoAvNkyMcoB4DBTM8okePilExz1/9qKqqhg6N2ZCD1Qe6Nb6FNrAqHcPFu8rMUJM54f5VVQqba4m2/UsyHh7VlVbmCDE/3/LQx6zGXlUG+Ir27Ouam1UNSxe7C73P5Zj5oDtmthU7T3sBn5EZw3LL+0MFDIJex2eqEz83dDbaHFYH7v0+5MXSNqAa0i0JhAAepAab/4sTFnaKu+E4PuEmyLcngk+Fqb6QCCJAxed3hTla0i5//uy2pemQ8FhpE+mgDbu6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd95982-f3dc-47c4-82c5-08d799cbe8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 15:02:16.3441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Esxw2gLhjaiwCJqzpXMz7wbasav8gR+QaWHe73fmxDiULhdxfiRa6qIeXPnA+4Cy1MBJvOj0mcp1AgbU6v7rYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5732
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case no one is occupying a wiphy, all past regulatory data will be lost
as a result of reset to world reg domain.

This includes any channel that is currently in NOP time as well as
in AVAILABLE state.

This means that after detecting a radar on a channel the user might be
able to simply reset hostapd and get back to that channel,
this is a major issue.

To solve this I have added a check before doing any resets.

If the user (for example: hostapd) asks for a regdomain and we are
already in that regdomain, than we shouldn't reset that regdomain in case
of wiphy disconnection (for example: hostapd reset or killed).

That way the regulatory data will be saved as long as we are
in the same regdomain.

Since in that case we will anyway get back to the same regdomain
the only difference is we will now save the regulatory data,
won't lose it, and as a result won't get back to a channel that a radar
was detected on until NOP will be finished, as should be.

Signed-off-by: Orr Mazor <Orr.Mazor@tandemg.com>
---
 net/wireless/reg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index d18cc05061a0..5049c487950b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3180,6 +3180,16 @@ static void restore_regulatory_settings(bool reset_u=
ser, bool cached)
 	}
 	spin_unlock(&reg_indoor_lock);
=20
+	/* If the user asks for a regdomain and we are
+	 * already in that regdomain, than we shouldn't reset
+	 * the regdomain in the case of wiphy disconnection.
+	 */
+	if (cached && !reset_user &&
+	    (!IS_ERR_OR_NULL(cfg80211_user_regdom)) &&
+	    (!regdom_changes(cfg80211_user_regdom->alpha2))) {
+		return;
+	}
+
 	reset_regdomains(true, &world_regdom);
 	restore_alpha2(alpha2, reset_user);
=20
--=20
2.17.1

