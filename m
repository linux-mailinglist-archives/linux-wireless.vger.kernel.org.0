Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F385CF4B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGBMUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 08:20:37 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:48527
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfGBMUh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 08:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Celeno.onmicrosoft.com; s=selector1-Celeno-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLSXvYZahQjMY7LrcfbGFWL6hqb2cl1DjuRhGvx7i7o=;
 b=X7AKBf0PeiPa9e7AoDZaX316VmecjkYiE6DomnoXaokxIRyloyAzEK0PG5WbNmM+Z6rccwmyuCNR1hnK2V8a1QgurBwSp177aOx2bEjTZSrGJcQgPP8q9tSemHC+M4BKJTeKkTQ9mfbBvwCXH4Ci9UxBLnISXl92ceFb65RO0Zw=
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM (10.175.12.18) by
 AM5P192MB0019.EURP192.PROD.OUTLOOK.COM (10.175.12.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 12:20:33 +0000
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::1c8f:5675:fd1:115e]) by AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::1c8f:5675:fd1:115e%5]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 12:20:33 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Shay Bar <Shay.Bar@celeno.com>
Subject: [PATCH] mac80211: HE STA disassoc due to QOS NULL not sent
Thread-Topic: [PATCH] mac80211: HE STA disassoc due to QOS NULL not sent
Thread-Index: AQHVMNCLxLg8c2okeUGX0Ct02IaO/g==
Date:   Tue, 2 Jul 2019 12:20:33 +0000
Message-ID: <20190702122010.11174-1-shay.bar@celeno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.116.2.211]
x-clientproxiedby: LNXP123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::18) To AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:203:80::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shay.Bar@celeno.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c645f46-c90d-4f2c-1a03-08d6fee7ae0d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5P192MB0019;
x-ms-traffictypediagnostic: AM5P192MB0019:
x-microsoft-antispam-prvs: <AM5P192MB0019FE92EC346A3E6891612CE7F80@AM5P192MB0019.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39850400004)(396003)(26234003)(189003)(199004)(26244003)(53936002)(26005)(486006)(14454004)(2616005)(66946007)(1730700003)(186003)(476003)(73956011)(14444005)(256004)(386003)(6506007)(68736007)(52116002)(81166006)(8676002)(66446008)(72206003)(66066001)(81156014)(66556008)(2906002)(478600001)(25786009)(5640700003)(64756008)(6512007)(6436002)(4326008)(6486002)(66476007)(71200400001)(99286004)(86362001)(44832011)(7736002)(71190400001)(2501003)(6116002)(2351001)(3846002)(5660300002)(305945005)(36756003)(107886003)(316002)(8936002)(6916009)(102836004)(54906003)(50226002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5P192MB0019;H:AM5P192MB0226.EURP192.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: celeno.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aRKA7kkS/X5rp2Q8E5GJUA82BhrJOtGKkbDUjn/d26iDJXnYdffTKyhWd9ZbHqQ1ZqpKHSS6XGBaKzIkEQVFJ+JnRWoAOR3y/MgGiAvNuqwKbVIHrLaNMoAcX5gSxwU7dmg0yQ7dLsJa+ssPl3nG89XuDmpGndZ0IlHKgUBimVvyfeH95W+/lNoz7vkX98FDwHQ+sM0eIttvL+NWjNU2lNdM8vRtloufxrWV73M9wzoBNSognS8aNsuGx/kICKahHQXtQ4c0u0RGTxgDC6vICPxiVjdQ1gLBxKm6PRScAO11n+S63/YmrRdg6ts1nE99bofV4fzF5k1CPRDLPBPvz7L3xo6IBNx2LwsEkpKWvl//8RhORQPMNEja6xtesNH6EP2CGqWp8WHjvNZreJ1inXjJ0EQcFt/cUHJAyAc5Cvs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c645f46-c90d-4f2c-1a03-08d6fee7ae0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 12:20:33.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Shay.Bar@celeno.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P192MB0019
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case of HE AP-STA link, ieee80211_send_nullfunc() will not send the QOS =
NULL packet to check if AP is still associated.
In this case, probe_send_count will be non zero and ieee80211_sta_work() wi=
ll later disassociate the AP.
(although it didn't really send a test QOS NULL packet).
Fix is to decrement probe_send_count and not call ieee80211_send_nullfunc()=
 in case of HE link.

Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 379d2ab6d327..bc5ed2dbe69b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2511,7 +2511,10 @@ static void ieee80211_mgd_probe_ap_send(struct ieee8=
0211_sub_if_data *sdata)

 if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
 ifmgd->nullfunc_failed =3D false;
-ieee80211_send_nullfunc(sdata->local, sdata, false);
+if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+ifmgd->probe_send_count--;
+else
+ieee80211_send_nullfunc(sdata->local, sdata, false);
 } else {
 int ssid_len;

--
2.22.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

