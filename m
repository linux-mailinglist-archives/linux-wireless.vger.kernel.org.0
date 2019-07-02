Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486555CDDE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBKum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 06:50:42 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:28199
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfGBKum (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 06:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Celeno.onmicrosoft.com; s=selector1-Celeno-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CojBUKtK1unQS4RkXjZhy878rfWmZWxR8iW38beJxcc=;
 b=kSRHe0RPUjmtkjDt0x3RdvKsnEZUtIC8FtszQ5Z3KuiqjP0tW6mZbAh7o55TOtDyGFFFAWNwBd42bso9/CoGBHvdAY5TPfnY6YyFDXQZvR0JW8toHQesi/ROGrIeb6/kCNP2AVm2jWmamtJgrS3aMQiCYTtu8NOm9OiCubLtWNI=
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM (10.175.12.18) by
 AM5P192MB0097.EURP192.PROD.OUTLOOK.COM (10.175.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:50:38 +0000
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::1c8f:5675:fd1:115e]) by AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::1c8f:5675:fd1:115e%5]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 10:50:38 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Shay Bar <Shay.Bar@celeno.com>
Subject: [PATCH] HE: STA disassociate AP due to QOS NULL not sent
Thread-Topic: [PATCH] HE: STA disassociate AP due to QOS NULL not sent
Thread-Index: AQHVMMP8XOtVfDdhmEGBpfvj7auHPw==
Date:   Tue, 2 Jul 2019 10:50:38 +0000
Message-ID: <20190702105019.10633-1-shay.bar@celeno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.116.2.211]
x-clientproxiedby: LO2P265CA0479.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::35) To AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:203:80::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shay.Bar@celeno.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24618a5b-116b-42bc-9879-08d6fedb1e5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5P192MB0097;
x-ms-traffictypediagnostic: AM5P192MB0097:
x-microsoft-antispam-prvs: <AM5P192MB0097784D100680A7147B2499E7F80@AM5P192MB0097.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39850400004)(189003)(199004)(26234003)(26244003)(36756003)(5660300002)(64756008)(66556008)(66476007)(66946007)(66446008)(66066001)(73956011)(107886003)(3846002)(6116002)(14444005)(1076003)(256004)(71200400001)(71190400001)(7736002)(6916009)(72206003)(6512007)(305945005)(478600001)(5640700003)(53936002)(6486002)(2501003)(6506007)(102836004)(68736007)(52116002)(99286004)(26005)(14454004)(86362001)(54906003)(186003)(386003)(4326008)(476003)(486006)(6436002)(44832011)(81166006)(81156014)(1730700003)(8676002)(2616005)(316002)(8936002)(2906002)(2351001)(25786009)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5P192MB0097;H:AM5P192MB0226.EURP192.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: celeno.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: agV24fKFnVeixGLJq1nA+HVga2LuXbBZzgWiC+UwgvZSm4HZ1JDMdTmAmo/cE0QUofc1NnlpeF2hVIq+Nz2i83C5ecUVpkqwC02tYl5jjbVGW15yFdlnlt8HnYKBz0a2uV1mSlN9sz6CniiNtIfdy8pHwfCuWvrFmXThBKVmF2Moc+EHONrPv5kJLDyzsnrDWm/af5XtmveVJW4c0H6VAtYt7HjJcYmoyJ2yNw/oC71xMSgJdM0epE3ZIODTfq32xUnBAoFgpr6AAXbxU1ihm+S8mvqU3hsqlo4PWbVuIaoKiDTAEF33BK+RllgrIs/t9/SZrC/4W/FvLpJUO7BW91l2jXiP3u/KQvgNVFe6fWY+5PyRqn+/56e6/xobFP602I5m/eB16oat6EyqSnA2Gh5bTvCCQzJiYWzx6pcc/GI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24618a5b-116b-42bc-9879-08d6fedb1e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:50:38.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Shay.Bar@celeno.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P192MB0097
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case of HE AP-STA link, ieee80211_send_nullfunc() will not send the QOS =
NULL packet to check if AP is still associated.
In this case, probe_send_count will be non zero and ieee80211_sta_work() wi=
ll later disassociate the AP (although it didn't really send a test QOS NUL=
L packet).
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

