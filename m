Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7F43DE6F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 12:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJ1KKj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 06:10:39 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com ([40.107.7.95]:56551
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhJ1KKi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 06:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsL6i+XKAj4NXkeHzFUCT+smHqMk7Wc7IEHfyS/mB4TChoGiIcch/mvux9Iv9V8N7qFYAIpUEX1zziXmcHOnLOExrKO/L2cxcRmxKmDDDxuHGiOIC75lU96+gEnpHUWyr2gVNc0yefWI3RFsLt1yiZ2ukAjxjk/ethB3UZFkIRJ6lcL2ZXTq7I3mKdUXW4WBEmEgb3pyz5qmUtWh+dZH2XOBVqrpn4olO+nzHWI3TvoqxF3C7KEkWYvqlL6E+OpHUIUSkHNrjmNxVXiJQszfTJOV/D9SdpBjztzQWriJQCZmt9z8XEAZzhfh4dsBItbpY7ZMdjwXKjWu/crYDgts7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bkP55mtJRVMyfvZ64QBQMZUmNQfKoi5HM0/tM0kEHc=;
 b=C68LDnqJPYLwZWQtgZ1sSE/qtLQEq7weiC71Y9MXaFu9ydAFNGInWvIb6BSNDVnls2LcSZ417tB8SjxrIeYN+8/znoYYqJ11rjTqUzUQPgP3vFVPOmBI2fbyjxqxUpI/AKVRX78bbtLRC/9LIFT+QGiCOJzCYDO4BMhA2sX9xBopYkjCrZoWs2xuXY0JX0/o0MJbTN4IJNXFsxDh2AsnGsM8z7in8ulPkNxDetEVhM7hsjSwvqgi3KbpJ3vHgNQV2MAdpQxCIlxC2VexAq6XmfK6P6odLFNPFgvb6ARCCugywUfBzBSeGUqUGZ4YqMFuzv+3qi0bYVQB8ZMt8wBzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bkP55mtJRVMyfvZ64QBQMZUmNQfKoi5HM0/tM0kEHc=;
 b=Asjtp/ftWUS7Sao4YYJ1S0aO7gG+I8JvSTd/tcAevXwdbdQQRXJyWgPAecIn5pG9A1Lqg0UmtxHDstScM7f2M2xu9fRUHqCKgWNLLiuPos1+szW0+fQBR7Y2JQ2z9YVoyXUkU3H9hiQAzkejGE/1PUG/zzruivnpbcNqqY/O6Hc=
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21d::7) by DB8PR01MB6438.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:156::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 10:08:09 +0000
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe]) by DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe%6]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 10:08:09 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     "Johannes Berg (johannes@sipsolutions.net)" 
        <johannes@sipsolutions.net>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC v3] mac80211: fix rx blockack session race condition
Thread-Topic: [RFC v3] mac80211: fix rx blockack session race condition
Thread-Index: AdfL0tUGplDdZUWUTvSEilo32QEGpQAELkXg
Date:   Thu, 28 Oct 2021 10:08:09 +0000
Message-ID: <DB9PR01MB73545D195C51A3DDACE38E7CE4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
References: <DB9PR01MB7354781F66D4D59611D256A6E4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DB9PR01MB7354781F66D4D59611D256A6E4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=acksys.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240eb837-ea5d-462b-939f-08d999fad7dd
x-ms-traffictypediagnostic: DB8PR01MB6438:
x-microsoft-antispam-prvs: <DB8PR01MB6438015357B37F9BD1610D11E4869@DB8PR01MB6438.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+nuiChH5p8bFvlHp8gh7vKoCtbAO+HZEdbFGu/ck1Wg1BnctzvtntWU9NrJ+85dJvkrTsPXZB5aqB4ufoHMaxLX8M7qT4NHrllfvdcBMnSbIaDOCD36VNRpD1YK0zos9lwud4RaxE+uuZAoIoZJmbPyd3Bvl3PN41+lxaQ6NsVnjUfIycNmOYKSwHoVjKfRlI2FLY+oxxAnKPsdEpO7DK8KAQh47x87nGTd0pefSMhUjyLCC3h38ZCozWpkG6jn4pCsr/cYHkR1IdX/3X+21X4g5p5f/aB2630e2FrUnXfgsFv16fH6CCp6RjtKkM7SFZzwapKprdAhdlFZ1qEz+LBLTAjL84wgcIhycWWNAAHJK2REd+ntwaHc6DKHSUjUlXDe66RlSeV62oi068hMcVkZo+JTKar8KSTnQHNQDdMUq1SvtxDfeRf1xkoryDU3XHNULOfDdcUhqr/90/tXBC8vCgBX793S+F4I199M4nFOsiIN9BVU6zKifnGT6P4uPdHz3TjoPxcYwUmBreICpswsCaJA3RBuy5O7csEu2dKbhkQCIYLBc0UMWcCTlGGBm2J88mHA8DgnScV881r9tOCHPfTDmj5YGGch3ovDJRw+Jqyjo85WLBSxRWhbP8glelKk7qtHOvna4IeTUTnXeSnoQORdgy2JpZP9zu225AApwNqQ9kXZiA9OVHrA1+C3y89Kf2XLmgC3M5aKECgEiRd7qmN2otEESSc+CRskVZ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR01MB7354.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(136003)(346002)(376002)(66556008)(55016002)(66476007)(66946007)(76116006)(38100700002)(9686003)(316002)(7696005)(33656002)(8936002)(2906002)(52536014)(8676002)(122000001)(83380400001)(26005)(66446008)(6506007)(71200400001)(110136005)(2940100002)(186003)(38070700005)(5660300002)(508600001)(86362001)(64756008)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B2SLA6+m2crCdyqF331g5p+2AM6y+8MUZR2x7+IKJnKCIAfPrubFqzp7/z?=
 =?iso-8859-1?Q?iIFZYoHrveih244xzvvUz+AazUDFeTQoQRv9A+qF4954M8zabC32hQ/T6O?=
 =?iso-8859-1?Q?UE1S0xgvgG42VVCq16bmHJdB6g1+mP/SZyQ6dSJ7cT2vGWvTp/bR5OpwZX?=
 =?iso-8859-1?Q?IveXjHakb6h1Uc3G7KWDJLiNaxjm9VOVMgoSOUlZBgDJeDPCgOA0OCY8Bk?=
 =?iso-8859-1?Q?uZu8MkEmlwc35awiaANz+9uKA1CpKo25+7qdUdJy8VGGM17NMNVB3R3Ere?=
 =?iso-8859-1?Q?Q0seR2WbybfcpRO/GxJpMmXfZKVemHjxi+9itM1zk3kkYvm4AyJEcqHCBI?=
 =?iso-8859-1?Q?QG4dMIzDyvvtZ2UQXEQKjZiqtjCkV3Scql7JL9/jLtIn+bYPOGHJzmrrF6?=
 =?iso-8859-1?Q?IFc70Hjg0JZlDwin5W91jTvcJraqA4M4yUn3TRkLJvgcBKiTNPfUCfULsA?=
 =?iso-8859-1?Q?YfrkjJ05WsHWMNFiVYVie93pnOG90Ugq4ytiln9DHwqeJApEt2fISQoZEM?=
 =?iso-8859-1?Q?vMXIkZ8oP/y/XwkXQGAX0PNfrgUWQOtxiF03OcF/LFA/CizkpX82WPcT7s?=
 =?iso-8859-1?Q?g9ikxg9UI7HWspq3sMtBtVWfPESwz8G4pfrwAFS1r3clBKiq3KdKiDLfZo?=
 =?iso-8859-1?Q?rlwDu5xbozBx5zZKHEXA47M8f5u84wp27LnwGfai1gpRYh5YhwRNnWEWU3?=
 =?iso-8859-1?Q?ZWSBAg1HEOgsaYGWDDI9Bcy6vJk1Gboj2k+EoRnzFrfLyAkIt/SEKrEfTa?=
 =?iso-8859-1?Q?cumtFcUkJ09PdZRTKuvNYN8B84JKnltJbCuWuPQm2Ddddn0C47qufNjWR0?=
 =?iso-8859-1?Q?+mWQAgAFFn1sYVyfdURjvkH2IeY9rz0aU1SkUERn1jnVyK5Fx4dXmlmnkn?=
 =?iso-8859-1?Q?I9W4BAwNuWQYDIwJ6KmDTP6vG61X1VCpDB5DOPev3A1xxYUsI12wMNOcKh?=
 =?iso-8859-1?Q?VJjS37XXJesudgJExey+vRs1tsJhmttvZMJe0n+bUFEMJ/ErME5j8VGJfR?=
 =?iso-8859-1?Q?R51dhse749I1k791wb/e1FGW/YkcotuYm+bzGcxo56EjA8zrfTusxk45Bs?=
 =?iso-8859-1?Q?DCu/QPxdbq5X/btKmj3weoKemwlLvE+YQDi5DfpqzSPqB+5/gGWG6INebj?=
 =?iso-8859-1?Q?7Hj1KOnlUohdo8OblILKutldHsk8PtE8loiFhhRY5PW+1JGRnVl2aKKvE4?=
 =?iso-8859-1?Q?RKVZfJqXq+vX7UA3D/YXj+dhKu7Bxt08On4dPyQ8X4pfSUWGBDBl5/UrHZ?=
 =?iso-8859-1?Q?aJ8AHf4y97sE1UpXgwk1hOFGfimXMiYvuNQbV4PcrAdPDO5MEywK6x45x2?=
 =?iso-8859-1?Q?8PRz3fL7mSFLAH5CngPsMCcg4OOWC+yYyqTREzHfvbrG+z5SzecV7N6Mfc?=
 =?iso-8859-1?Q?KMUDTciR0+ivEOx0QjMFdPD1l9PcyPknGwX00AWrPPJrmrueEYjCDs65As?=
 =?iso-8859-1?Q?vV/KiLUcurZdtJbSSK535cce4DwfForHySy3sJ9//E2nLrXF5H80v8scuX?=
 =?iso-8859-1?Q?v0teC2iwkZcK6yHop0xz55F3TFrOjgsYxvY70fsZWsQWX9UOyBadyyNp/u?=
 =?iso-8859-1?Q?h8d/Y6kAzWG5PCpmTKUu+MOyJrI2LK7g2AM2Uhmq6QGQum82w+Rcpi21BF?=
 =?iso-8859-1?Q?X5arXorW3iZsFwYEfchrCLZS53utaqwLsgp69PHb+7cq1kJkLWDSZukw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR01MB7354.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240eb837-ea5d-462b-939f-08d999fad7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 10:08:09.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bD5p31GT0BxfwSrPr6pLj6CiuOtnZ6AYewzyd+v2C6SnMLKBA03GLRb5J4o2J3K8cZe3arKAY/YOQM6yyXENEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6438
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please disregard this v3. The spinlock is misplaced in ht.c.
Sorry.

-----Message d'origine-----
De=A0: Jean-Pierre TOSONI <jp.tosoni@acksys.fr>=20
Envoy=E9=A0: jeudi 28 octobre 2021 11:15
=C0=A0: Johannes Berg (johannes@sipsolutions.net) <johannes@sipsolutions.ne=
t>; 'linux-wireless@vger.kernel.org' <linux-wireless@vger.kernel.org>
Objet=A0: [RFC v3] mac80211: fix rx blockack session race condition

When the mac80211 layer is used with ath10k, the following may happen:

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
2) protect the paired checks of (offload flag, valid aggregation session)
   with a spinlock against interference from ieee80211_ba_session_work().

Note 1: there is another dubious DELBA generation in
ieee80211_rx_reorder_ampdu(), where the same kind of fix should fit,
but I did not fix it since I knew no easy way to test.

Note 2: this fix applies to wireless backports from 5.4-rc8.
---
V2: remove debugging code leftovers, sorry for that
V3: use spin_lock_bh instead of a mutex

Index: b/net/mac80211/rx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3085,11 +3085,18 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_
=20
 		tid =3D le16_to_cpu(bar_data.control) >> 12;
=20
+		spin_lock_bh(&rx->sta->ampdu_mlme.rx_offl_lock);
 		if (!test_bit(tid, rx->sta->ampdu_mlme.agg_session_valid) &&
-		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
+		    /* back_req is allowed if the fw just received addba */
+		    !test_bit(tid, rx->sta->ampdu_mlme.tid_rx_manage_offl) &&
+		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg)) {
+			spin_unlock_bh(&rx->sta->ampdu_mlme.rx_offl_lock);
 			ieee80211_send_delba(rx->sdata, rx->sta->sta.addr, tid,
 					     WLAN_BACK_RECIPIENT,
 					     WLAN_REASON_QSTA_REQUIRE_SETUP);
+		} else {
+			spin_unlock_bh(&rx->sta->ampdu_mlme.rx_offl_lock);
+		}
=20
 		tid_agg_rx =3D rcu_dereference(rx->sta->ampdu_mlme.tid_rx[tid]);
 		if (!tid_agg_rx)
Index: b/net/mac80211/ht.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -367,11 +367,13 @@ void ieee80211_ba_session_work(struct wo
 							 IEEE80211_MAX_AMPDU_BUF_HT,
 							 false, true, NULL);
=20
+		spin_lock_bh(&sta->ampdu_mlme.rx_offl_lock);
 		if (test_and_clear_bit(tid + IEEE80211_NUM_TIDS,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
 			___ieee80211_stop_rx_ba_session(
 				sta, tid, WLAN_BACK_RECIPIENT,
 				0, false);
+		spin_unlock_bh(&sta->ampdu_mlme.rx_offl_lock);
=20
 		spin_lock_bh(&sta->lock);
=20
Index: b/net/mac80211/sta_info.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -354,6 +354,7 @@ struct sta_info *sta_info_alloc(struct i
=20
 	spin_lock_init(&sta->lock);
 	spin_lock_init(&sta->ps_lock);
+	spin_lock_init(&sta->ampdu_mlme.rx_offl_lock);
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
 	INIT_WORK(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
 	mutex_init(&sta->ampdu_mlme.mtx);
Index: b/net/mac80211/sta_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -266,6 +266,7 @@ struct tid_ampdu_rx {
  * @mtx: mutex to protect all TX data (except non-NULL assignments
  *	to tid_tx[idx], which are protected by the sta spinlock)
  *	tid_start_tx is also protected by sta->lock.
+ * @rx_offl_lock: protects transfer from tid_rx_manage_offl to agg_session=
_valid
  * @tid_rx: aggregation info for Rx per TID -- RCU protected
  * @tid_rx_token: dialog tokens for valid aggregation sessions
  * @tid_rx_timer_expired: bitmap indicating on which TIDs the
@@ -287,6 +288,7 @@ struct tid_ampdu_rx {
 struct sta_ampdu_mlme {
 	struct mutex mtx;
 	/* rx */
+	spinlock_t rx_offl_lock;
 	struct tid_ampdu_rx __rcu *tid_rx[IEEE80211_NUM_TIDS];
 	u8 tid_rx_token[IEEE80211_NUM_TIDS];
 	unsigned long tid_rx_timer_expired[BITS_TO_LONGS(IEEE80211_NUM_TIDS)];
--
quilt 0.63
