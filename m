Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D21578C4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgBJNKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 08:10:13 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:42637
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbgBJMjM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSEzAYCQQpWZcVPYH+P9hFaZ+nKgb2xR6MBqyH6rfpaZ7yCFsGOS6NIdTnGDPofR3xHILBgw8uKTz0KtocKRFdz+9f4nUr5OndvBxKejU404MJ8BQVev863FpPbNnYn7YrGn3eQILnMFh8WxG/UZbu1yvuGMMzgKDcMKfhgzfCiQKeysYYGzmEpsloU3lOsxaN50YFnh5kOvDBTPoELExUzd3jsRIag1/Thevfnu6+Od9emVnL+PBIivFvRzzyPczuNuQpBrhSKIokZs7Naz/IC1zTjhWALBHVl1VGaGmDCDFFzB5H7LdoExRPy7AeYEc+6B62dJiDwy8KCM7gZ7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r+KBbqXj8EbF4Gt9nZ0Kz6kkOJ69+rn1NQdzibdSqY=;
 b=GO1UfD8tHs97BxXGuH5PWg0EcVokw1qH1G+Awr+BaBPszH4hsVWKUScFeQqiyC9GRfUa/pfhNPw6+4dsoXzVi26mL13aw1Koa8ALHQXOCovgUlKQkJJY1wytlr2DYkrkDOT25ibHz27tO9c+5neQElhPxtAUiL/pO8veskxSNAaAFq+RXJeH8SUWn9uNr1sdy+139YjJDR896aqRyaJCvUckSoFdh/Xra2vzKqbXeXgSy15AX4plOMeG3A7prUw+TAsRFAeezh4T6hQ/4ntZS/U7sZFm3VhxfXzcUa+YTmqoyRPb3opifD4MBqoN11+/ELyqW/BDy0zt+VV8MyJojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r+KBbqXj8EbF4Gt9nZ0Kz6kkOJ69+rn1NQdzibdSqY=;
 b=FGIMJBiNrokWtwacWRLOOmp3sc/dWvwL+ghK1SpfuWBT+rLhz9vgVZKuMMhN/KAK9QFGtdy4Pd9NzQtMagiItmotdkkf9ekXcOz2t3j5OqmXc6HgqOJyywr/6Xt3z4N1fBXtcIOKLQAi7OPyYgM2Eg+1bH0Xq4Fp4UU1TFphjuc=
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM (10.175.12.18) by
 AM5P192MB0035.EURP192.PROD.OUTLOOK.COM (10.175.12.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Mon, 10 Feb 2020 12:38:27 +0000
Received: from AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::65d1:c804:671c:71b4]) by AM5P192MB0226.EURP192.PROD.OUTLOOK.COM
 ([fe80::65d1:c804:671c:71b4%6]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 12:38:27 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Aviad Brikman <Aviad.Brikman@celeno.com>
Subject: RE: [PATCH] [PATCH] mac80211: fix wrong 160/80+80 Mhz setting
Thread-Topic: [PATCH] [PATCH] mac80211: fix wrong 160/80+80 Mhz setting
Thread-Index: AQHV312UFGaCKUbhZ0OJ16xqu5TlJKgUXxIg
Date:   Mon, 10 Feb 2020 12:38:27 +0000
Message-ID: <AM5P192MB022610857941CE25FF6FC8B1E7190@AM5P192MB0226.EURP192.PROD.OUTLOOK.COM>
References: <20200209152818.4630-1-shay.bar@celeno.com>
In-Reply-To: <20200209152818.4630-1-shay.bar@celeno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shay.Bar@celeno.com; 
x-originating-ip: [87.71.82.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc1518a-2da7-438d-3d7c-08d7ae2620aa
x-ms-traffictypediagnostic: AM5P192MB0035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5P192MB00354FC31B8DF9FE0606CB1AE7190@AM5P192MB0035.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39840400004)(396003)(366004)(376002)(199004)(189003)(76116006)(64756008)(66476007)(33656002)(66946007)(52536014)(2906002)(26005)(5660300002)(66446008)(66556008)(186003)(107886003)(71200400001)(86362001)(6506007)(53546011)(9686003)(55016002)(4326008)(478600001)(54906003)(316002)(6916009)(81166006)(8936002)(8676002)(81156014)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5P192MB0035;H:AM5P192MB0226.EURP192.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: celeno.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6I8WbvNZSja3sK9+s8sALF/abqdSDuw1yXVDD6FIsmh7Zv4YCsc0dJ7KLtJ0IJtjpHy8nsN8/g+hqANxuNPjG2YwBmu5bcH6KpYVEqtjAvX354V5JQGU12YxMNGLbsQpomHHeBFW4lv4uliDUD3JmmgbDSlTASdJyhSYlb9VUraH05ZjzGGX6tv0GqmMxEKOpwfgDJYIm5JzVE1SRTAUmwpIUftu2K1Ap3o1C1sAwily7fiFTLyUYQZL1f7uDlmPpAUhdAVSU/b3cOepTxybOfRHTuAvDD2vMrO/zI/ufrcD9JNjkEL6GVAYjU9cMK2fGcgAo3AorrDGekhMXEo7FsyUROUSY1DBdaS9bI0MHphPF1DzeWF+4aAWt4oW/+x3EyRHd0+Gh2GKuJyVj9iHLQLwuH1ACvvnmtSslGzbw4L9GdZwqp7ms6Of2FtIR9nR
x-ms-exchange-antispam-messagedata: jx89SVx5bjraaUqAR8CW9pT+NNgqCBSEqlaT+NK7NfeL8X61gwal/RMqnL5TeNamrJQeY2I7EGEbTZPpkLfhqTiivirNKwoE3iveusd4GR1lcNjI5zpZfLnMMFGbipv3SPs4N5yw6ehpiJ+G14vv9Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc1518a-2da7-438d-3d7c-08d7ae2620aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 12:38:27.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THSpOjN08/VGeelAH9F9/fTgJQmL5iYg5Fh1oaVA9qx/Y1ix/SPs7qRGj2DgymdIzSIvE3OiCHhlFirGCD9zZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P192MB0035
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "support_80_80" and "support_160" setting is based on:
"Table 9-272-Setting of the Supported Channel Width Set subfield and Extend=
ed NSS BW
Support subfield at a STA transmitting the VHT Capabilities Information fie=
ld"
From "Draft P802.11REVmd_D3.0.pdf"

-----Original Message-----
From: Shay Bar <shay.bar@celeno.com>
Sent: Sunday, 9 February 2020 17:28
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org; Shay Bar <Shay.Bar@celeno.com>; Aviad B=
rikman <Aviad.Brikman@celeno.com>
Subject: [PATCH] [PATCH] mac80211: fix wrong 160/80+80 Mhz setting

External Email


Before this patch, STA's would set new width of 160/80+80 Mhz based on AP c=
apability only.
This is wrong because STA may not support > 80Mhz BW.
Fix is to verify STA has 160/80+80 Mhz capability before increasing its wid=
th to > 80Mhz.

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 net/mac80211/util.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32a7a53833c0..950fa4741d98 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2987,10 +2987,22 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw=
 *hw,
        int cf0, cf1;
        int ccfs0, ccfs1, ccfs2;
        int ccf0, ccf1;
+       u32 vht_cap;
+       bool support_80_80 =3D false;
+       bool support_160 =3D false;

        if (!oper || !htop)
                return false;

+       vht_cap =3D hw->wiphy->bands[chandef->chan->band]->vht_cap.cap;
+       support_160 =3D (vht_cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK =
|
+                                 IEEE80211_VHT_CAP_EXT_NSS_BW_MASK));
+       support_80_80 =3D ((vht_cap &
+                        IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)=
 ||
+                       (vht_cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ=
 &&
+                        vht_cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) ||
+                       ((vht_cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
+                                   IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT > 1)=
);
        ccfs0 =3D oper->center_freq_seg0_idx;
        ccfs1 =3D oper->center_freq_seg1_idx;
        ccfs2 =3D (le16_to_cpu(htop->operation_mode) &
@@ -3018,10 +3030,10 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw=
 *hw,
                        unsigned int diff;

                        diff =3D abs(ccf1 - ccf0);
-                       if (diff =3D=3D 8) {
+                       if ((diff =3D=3D 8) && support_160) {
                                new.width =3D NL80211_CHAN_WIDTH_160;
                                new.center_freq1 =3D cf1;
-                       } else if (diff > 8) {
+                       } else if ((diff > 8) && support_80_80) {
                                new.width =3D NL80211_CHAN_WIDTH_80P80;
                                new.center_freq2 =3D cf1;
                        }
--
2.17.1

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

