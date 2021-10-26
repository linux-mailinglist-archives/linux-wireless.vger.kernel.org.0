Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAEA43B394
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhJZOHI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 10:07:08 -0400
Received: from mail-db8eur05on2102.outbound.protection.outlook.com ([40.107.20.102]:13153
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233975AbhJZOHH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 10:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYvTuFC+lm+OGRSHV1xANCRoHYVU9yPTkoJvHcFJpfVIGIQ6+2kIo6XOBqqfEhTgbeG6xh1IF4KO9ej0yyTWDQz6QjU+XFVUY0DqXV92Y7y3cRdFxJEuvxqacz8IYT809yDFQotu8Ao1upJlfALb7zgvHXHh/nPsIKKLuqI7CC97sKnPeSE5D5MVWFsux+llj8O+YDRvJkYfqSgCJSMI+mDEq97zr9TM2qhy17bzEfSP7X1+alhZbqIeHNif3vc1nEsQCmmAPcKQXByT2DViw+8Jef6rAlAooH1u5I578H8R/AkH0wwU3BFzbrnDhdhLLZnPb+8hAduwdXdq205Brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcGCSLOkRVHR1kfwMuXSZovEAdyU2wB6rodzh3snjdg=;
 b=EDEmIHcDy/2qlYsgvvlgmbk2sP6SeD51j+wp2J/ls3qeaKrEqNQxKEho0YHUQhaPr/A0UOmTy4oa6kVctyYrd1g+o6jwYzmTs0fxJS8iQtr0L3I1rknbD+8xH8iVOJIOr4weoOFC3S7lRYZClma08bic6rhflmTEI0d0OieZyfBW+H9M90e2N82koysog6RxgUULDsPnSvH/rrBkV3VB7uFaP9dCqpYfh3em8uTqCeYhZ54x5mYjunKnzUwZ3DkKIJHfvxIB+qG/yfiWeNReSRPfZveH+5mB3Rng2ny9hCBflIuQWUD3dEP9e57DwKyENpX74oBJh//xa/MVyVB1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcGCSLOkRVHR1kfwMuXSZovEAdyU2wB6rodzh3snjdg=;
 b=wbn8N5z6XIp7rGMJbafgYI0DUmWTT5xWDpdqQ0dWiSAcmZRl7XKNep1fGkVguHKNjL4daOYL1jJdJw2cB/tn2hH0PNrLTRuK/cXhdxg27ith4AnjmfzoeswbOS8C7WVcHhgHhyDDkv+sUwh/VFdo2yoj4zJGW0fCYL3xGIwHj1k=
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21d::7) by DB8PR01MB6390.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:150::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 14:04:41 +0000
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe]) by DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 14:04:41 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     "Johannes Berg (johannes@sipsolutions.net)" 
        <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [RFC] mac80211: fix rx blockack session race condition
Thread-Topic: [RFC] mac80211: fix rx blockack session race condition
Thread-Index: AdfKa2Vnf+51pzw3S2ywVKfXICdlgQ==
Date:   Tue, 26 Oct 2021 14:04:41 +0000
Message-ID: <DB9PR01MB735472EB045E560573F9C369E4849@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=acksys.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bfb4262-131e-46e3-352a-08d998898e22
x-ms-traffictypediagnostic: DB8PR01MB6390:
x-microsoft-antispam-prvs: <DB8PR01MB639087834BC8A6588FCEB136E4849@DB8PR01MB6390.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNOVQyd5TV5Sr1Gw18JX6CQ6e496t0Q1TFxvWt9IqLh+fO8loaaZZYLIllWfSEX+GVpU5IRyFNvH0/JcJT+1+OpVjftoRb0QMwrWm3TU4cGYffaykrL7+z2pxB95ffk/+GG/cHqtKQhDqdMEf1Kmx2lw7NcFJajz72nnyunEoy9wj3hnxjJSM5CNfh4YCVlA/DO2Q7YYWeUggUemGE43Kqbdjl/mUlP0GID6mdh0ulzYpU3ouEAuc1XldJ06hgQ346e9vpQ4JcPEcn42xPox9dcg26D6Micm2UsgnGFAUNCjp+KKQGamwCCDEPL/w8ucYyVAeYGuwDa+1/QTMKGCsC2zgiW5+kpsNxOWkTWHzVgInPQCX9QMIC3teJlseiHfYVyb695CX/XL5Lsx3lP12nIB1tOzXYna3OZwCH4PbZ0o8jEvuyNgbtrtalZNNoUzmmTvnxP09bsDgY2maWHVramWC4Ys3Fz7gi8U/uwcrqJnTtWXXKYt9aNgsc1Yu3n6KPKxcT9By9HihrK6CYSDtc4B4940tw0nJNABBOTNBJ8sk+ZBoNBzQre8caoxE0hUwl0fqnLXXhsiuxygInT9MI7T7jeKZApfRX+bX4UeEL//MxlIE1Q0R3NEgT5M80rheCdZqmTLsZEETIoT1gW63X59oCILar8SUNcIZY55ts4svjdMBBK9w/PLRw6Gd1x2PetellEq0S7ifONpCZBlvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR01MB7354.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(366004)(346002)(376002)(136003)(33656002)(6506007)(186003)(5660300002)(122000001)(55016002)(6916009)(316002)(38100700002)(52536014)(71200400001)(2906002)(26005)(66946007)(7696005)(9686003)(38070700005)(86362001)(64756008)(66476007)(66446008)(66556008)(76116006)(508600001)(4326008)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: bs2CZ+9SY/aE0RzK39DU83fLAE2i0NDnsScOS6cerVbKURbXrCT/JP3c6QmygiBF3v4uRDwgUyJV+am+g4cWTuss+lE3VHfqxBKf/zmoZFTAQpcN5oSkWeyUHSxIh/6lRu0yOviI/DwDWxIPGu8M6RQ3LXpRTvg4l0YS5XPg5W2IH9WQexnsiM0N9NbzAv5qOfaOkamfaWYcyra7lNwQm2t5qw2rDIkYndoIMIsqm7IC/xogGnEqIEdWlX2NDWBEan6m40j1YbxSjvtJHDAUlcfTmIwncFbfFn/pTA6A/xTRrWb6pgaaVcwyHPgX3oC9xPo/FINdqgn/IIwDrLHMWyUdHIwmqssa9KHrOzk2mQqn8lWSdA6ozKrFyhFvC+xQX+EwEyg69xK1hC4XPkvw/NtmcRprx23rHJpQ1IaJQPk5oXd6ewYLWVyK/rnFJI36
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR01MB7354.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfb4262-131e-46e3-352a-08d998898e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 14:04:41.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNBPQp7ahwpiUArHagRo0WteAP+YnfJXAts7QgyCh1BKZ/+7oENi6r08eHKXfbaJcwSFkJTVCYuKdUXIrGTe1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6390
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When used with ath10k, the following may happen:
a) radio card firmware receives ADDBA-REQ from peer
b) radio sends back ADDBA-RESP to peer and signals the ath10k driver
c) ath10k calls back ieee80211_manage_rx_ba_offl() in mac80211
   to signal rx ba offloading
d) mac80211::agg-rx.c::ieee80211_manage_rx_ba_offl()
  d1) sets a flag: sta->ampdu_mlme.tid_rx_manage_offl
  d2) queues a call to ht.c::ieee80211_ba_session_work()
e) ...scheduler runs...
f) ht.c::ieee80211_ba_session_work() checks the flag, clears it
   and sets up the rx ba session.

During (e), a fast peer may already have sent a BAREQ which is
propagated to rx.c::ieee80211_rx_h_ctrl(). Since the session is not
yet established, mac80211 sends back a DELBA to the peer, which can
hang the BA session.

The phenomenon can be observed between two QCA988X fw 10.2.4 radios,
using a loop of associate/arping from client to AP/disconnect. After
a few thousand loops, arping does not get a response and a sniffer
detects a DELBA action frame from the client, following an ADDBA.

Fix:
1) check the offload flag in addition to the check for a valid
   aggregation session
2) surround the checks with the existing dedicated mutex, to avoid
   interference from ieee80211_ba_session_work() during the check.

Note 1: there is another dubious DELBA generation in
ieee80211_rx_reorder_ampdu(), where the same kind of fix should fit,
but I did not fix it since I knew no easy way to test.

Note 2: this fix applies to wireless backports from 5.4-rc8.
---
Index: b/net/mac80211/rx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2992,6 +2992,7 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_
 		return RX_CONTINUE;
=20
 	if (ieee80211_is_back_req(bar->frame_control)) {
+int ii =3D 99;
 		struct {
 			__le16 control, start_seq_num;
 		} __packed bar_data;
@@ -3008,11 +3009,19 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_
=20
 		tid =3D le16_to_cpu(bar_data.control) >> 12;
=20
+		mutex_lock(&rx->sta->ampdu_mlme.mtx);
 		if (!test_bit(tid, rx->sta->ampdu_mlme.agg_session_valid) &&
-		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
+		    /* back_req is allowed if the fw just received addba */
+		    !(ii=3Dtest_bit(tid, rx->sta->ampdu_mlme.tid_rx_manage_offl)) &&
+		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg)) {
+			mutex_unlock(&rx->sta->ampdu_mlme.mtx);
 			ieee80211_send_delba(rx->sdata, rx->sta->sta.addr, tid,
 					     WLAN_BACK_RECIPIENT,
 					     WLAN_REASON_QSTA_REQUIRE_SETUP);
+		} else {
+			mutex_unlock(&rx->sta->ampdu_mlme.mtx);
+if (ii !=3D 99) printk(KERN_ERR "JPT delba avoided, rx ba offload=3D%d", i=
i);
+		}
=20
 		tid_agg_rx =3D rcu_dereference(rx->sta->ampdu_mlme.tid_rx[tid]);
 		if (!tid_agg_rx)
--
quilt 0.63
