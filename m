Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716FC43B3CF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhJZOVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 10:21:48 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com ([40.107.14.105]:21989
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232907AbhJZOVr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 10:21:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejoPkTtfyDMWNJibDen3gDY8oIxTs4PphD1uT6Nc/YMVP5lQbdDTRo/5WYX1+y1Y69shDgQlNYGuSIM8oCsDr4X/TD2SvS2vgxxa0mnpT9x/GKRqTv4dWchROkPADHkGqN5N0vkNTY5r1+/38ysMohc8m/8PquVIaaRtLjnL+pExedhhKScj9S9pDZhuLkpZw+mnlP/+wci2W+VWN8VDyi1Ut7fAn135RuuICIeocEzhI0fG7wtxDagP01YpHgcdZ+/Dymk6bUZHtSLKyiaZ/y9HoofVDw6FS0dhlXU0a8n5TN1WsAnwPl9Z6kwXFQozxznf60QZ/a3UBcurGVYXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG+mOM4iRKHLlGl059u91fk+BnxgyITb1aZw68fqb9k=;
 b=b1AH1hC9UqKeExqknPhQoYZ7w6JfXB81cb68Leim/T21Gia+fTYvsCPoiZCXKilioJhxKqjI9bGZZTbz1wObmvyMrxxjenqSr4WTFCyeePXqdjs05ZZhqTgugamq9FF1oCc14cVqDjrBJSsLvEFXWX7zFfUxkMQmPdYHoVIBcbmr9lLyFI2Hru6ezXxp+NrRbw2LpVQzQL/EHUOK2LaGQv+q61VjGVFSkazVk+wSLKoCQsTko5I9fCoEg2Ix2NBULUEbVD04zo+VQl6a5pPCiCvoJW4pMoLRZNfAJd3HvJazx+iY/d1dK6QfgS6jA8QFh8t5Z8mi4wySoSewh2wUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG+mOM4iRKHLlGl059u91fk+BnxgyITb1aZw68fqb9k=;
 b=vOYV0xHFJtDuXD+HRAemnqnTTuW/UIkrBrw73uSnt1CjsE1Si5h3/Ml5LaCkytkBZNPnH9qUTe/Yy3KjyD8BnEgRhuf3eF+PgLRvS4M/TO7I9D1xCsp7qJCCQ0dAHy78+9pHAC0eKEEVF5od0+8G6A0uV6tGGoJLvzJtsSTrlIE=
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21d::7) by DB7PR01MB3993.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 14:19:20 +0000
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe]) by DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 14:19:20 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     "Johannes Berg (johannes@sipsolutions.net)" 
        <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [RFC v2] mac80211: fix rx blockack session race condition
Thread-Topic: [RFC v2] mac80211: fix rx blockack session race condition
Thread-Index: AdfKc+9SA/Z+MZzkSXqeBIjUqq1f9w==
Date:   Tue, 26 Oct 2021 14:19:20 +0000
Message-ID: <DB9PR01MB73541EC2ECFCEF6521B86AFFE4849@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=acksys.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ce50b8-db89-41f3-4616-08d9988b9a48
x-ms-traffictypediagnostic: DB7PR01MB3993:
x-microsoft-antispam-prvs: <DB7PR01MB3993EED610D1C27F8939278FE4849@DB7PR01MB3993.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVa/aP9UShvBxmRZY3orpuF4WmSFeOlHsLY2EKaYmwpi18M9r07pa1k4K8pKcmTCG07kQr/rfDd0VG/CJBu/Kllb9GP9ZJsUGbpZ5uI9hcD+hsU1iaKVyDYPHmhpEFFN7jXe5fYYfrURrrYKvE/Z+/jB65+ZmG/51k7+FKeiZ52HZIEjUQvpScUU0oB20cq2MMucdlZG2NW9+YU7i1DvMOSa0A7eJSzGauwVZzdJvmS5jlAqTjaCPQVmLECZx3NawaGJaKOM9IXsDn3LYhd/8pMEkMqYvryqJrVz+Vp0+w5xTmQdZTupNBa/aEb97FutcuNGMrWyoj88e3pkTKigMSCq9e7eQWLctlPSkz8cFekdDpiP7vkNR/Jpp62g+FEiZ9ojYa9ENYm/8aBlppeY+1KL5XeNvx3USNeuKl9ST6MORgdFRsUSA1qVC4VOVdvPM8sQRxd37/3J1omuvluLKQ6VGkt6pejQX4lIDr/l1vd7kTAojOTb7GJcv+6iQuaaRibu6NIOxqTHfNwz14EA/KpguOGdK4VRutNpjQ/htRtYExuP7Y2tNqatLJ2z+FGbij3jyGimG380riGp9zto2Vw/q7lK/mL2jgJUGVMs0BOwCc2MoSYGEs2GeNwJvRYPO9c68OygqbvoZqgdfplZH5wFC0+SPenz26HudYfspC/1Qm4i9XIS2ZbdAoSt3+lt/Rs6ktfQ3QIXb87tl7GGYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR01MB7354.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(136003)(346002)(376002)(396003)(26005)(186003)(6916009)(86362001)(52536014)(38070700005)(8676002)(33656002)(55016002)(4326008)(122000001)(508600001)(7696005)(83380400001)(9686003)(2906002)(6506007)(66946007)(316002)(5660300002)(64756008)(66476007)(66556008)(66446008)(76116006)(8936002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L4wky4C2xrmHwtsNvJAWTVGhrMAn27cXeIeV1+ZnbC7gE81ngqzu/MhzTPOl?=
 =?us-ascii?Q?nK9gUHUZe6drKtLnW4Ri3EZNoa1IJRPkgyHtu31ujgJLhCyShHcHvKhpiIA4?=
 =?us-ascii?Q?+zxJuSf+E+aiGOwZY8zTyLyWDkF/nuIhlp3+VljVRH/q6vzRvgU1dg73fd04?=
 =?us-ascii?Q?U2734PxvfL21+jhkpNe8b/uIDDLAiPfnxcymjYEpUPC8figIrWNuNloAeqjq?=
 =?us-ascii?Q?kwJJj0Ayq3at0k17Un+1apYRC2R00M4fDZXoH7/Sw0YMWANgiPiiwKhmV1j8?=
 =?us-ascii?Q?y/2bAourXoSor0UR1zFyiGRX5mkyYDwVaFqYKDxxNwp9cRQ8aUwfrk6ntqWT?=
 =?us-ascii?Q?AL8FILImiI7qOoZ3BdVJW2FVELe02dJ+EuR56Gpg+t8FS6xYXByRIQ3X59qT?=
 =?us-ascii?Q?4Tnh5up4nJtrzzrDj2/uWvnzrUak35CUaSWIA3fkUFCGS5iAmPwKwdq/nXBP?=
 =?us-ascii?Q?0pgWw6Hhxn28k9BWpEga6OR/xHoc1AUeRctBuilanQimXPofVxuRH00UuAIC?=
 =?us-ascii?Q?NKWdGW7ZaxeNBCI/ZrSKeVwjaTGTasyDDSV2r/x4FIYIMaQtvTZfcXtBnH6G?=
 =?us-ascii?Q?zMQsjQ37AlEttIZwmHHB8YYKggCNtaA2TzPuWuPWhzxPlTjs1atprUrxXiA7?=
 =?us-ascii?Q?+phl6OQUMEw7JFSd0UilpNl1/7bASA0jhvdJOKq4yBrzfx3OfFFxMv0gqpbM?=
 =?us-ascii?Q?vB6BiGJP8PMcEyu8seFAyWE56OznPVatIZQxW9+Xv4Ny7Rn4ZLrulXJvdtON?=
 =?us-ascii?Q?eFhZAnK9tMqyyCg5esUCjiqggMjdQ00q+82MHl4gS5BdBJBOK5tmIyKfZadw?=
 =?us-ascii?Q?eT2fVb+N4O5yfTey6ZOqpraebkjcAmlnekCy0jfwh3crndO/bYcQlhSuAxHM?=
 =?us-ascii?Q?LNCfW0pFncxyMJp75i/O18j4VuyQYC4PpGBqdL+pz0JH5P/KVIHA/nL2BBnq?=
 =?us-ascii?Q?iAwqi2iiJuXsN7jRpvHVoK6azhFHXprikiok2vkKltz/HRk6MUDxWdwhGTqM?=
 =?us-ascii?Q?e0lQaKyJRWOtsr+Fhnd1435QMxvCQGk5Ox/x8mcOzTSdMb4TFO/q3S9QJPfY?=
 =?us-ascii?Q?sRN0FmyNP7vMnfdGSNPNTlWTM0j9sbqz1bD9ZCgBiaW1FlCrQXKBydikEK30?=
 =?us-ascii?Q?cvpvHxDwcoKT8S6o/e3k8Y7M2l2LshM/eRB9hCo2MtWizDkEId5QgeaH6gGR?=
 =?us-ascii?Q?f6EFOmAHHZhYrqvChFdbY9uH5sc5rB9PkczuVfqphqhnlPppPO9QYA2vljE3?=
 =?us-ascii?Q?VYBu2HvKKk3bp43xsOIbytNbp7BXVpDqa2QrXNY8HC/Fj+jDwqYZIG8gz3GO?=
 =?us-ascii?Q?UAyZrohrI2CqdJYPbW3pspwBZ4X6GE8f6iXJXdp7laINdvFMx3k8mq7qsQU6?=
 =?us-ascii?Q?izvWzP/9hYwEOQpMg3MWr1nOO3eE7cFgRBY0dPvfCHr6TwOuEn+F7pGP0wax?=
 =?us-ascii?Q?wg6eUF7wUX3cyBV9/JUYaD/8ehnW4aCdcI+bfpD1/5BXHXJ0fAzkSP2frZXt?=
 =?us-ascii?Q?LZHK2MNhTlXDJk9sijfn1ZVWpA4NmxPuTauaH6Y4V/+TMvXInvOHM5vyh7uh?=
 =?us-ascii?Q?Sn9s3v3xYmIKmHM76lA6KxUCocB+fUQAtHTwT4+O6tZYdZrSCxf9lpzZQIO9?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR01MB7354.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ce50b8-db89-41f3-4616-08d9988b9a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 14:19:20.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ot1FcXUixVGI+9QAuYTCdnSXHX013JE06iYg85IzWszZV2wSmZ7nUqgLCrnS55npyazNT5Ik822uFFYNHEAPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB3993
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
V2: remove debugging code leftovers, sorry for that

Index: b/net/mac80211/rx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
Index: bp/net/mac80211/rx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- bp.orig/net/mac80211/rx.c
+++ bp/net/mac80211/rx.c
@@ -3008,11 +3008,18 @@ ieee80211_rx_h_ctrl(struct ieee80211_rx_
=20
 		tid =3D le16_to_cpu(bar_data.control) >> 12;
=20
+		mutex_lock(&rx->sta->ampdu_mlme.mtx);
 		if (!test_bit(tid, rx->sta->ampdu_mlme.agg_session_valid) &&
-		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
+		    /* back_req is allowed if the fw just received addba */
+		    !test_bit(tid, rx->sta->ampdu_mlme.tid_rx_manage_offl) &&
+		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg)) {
+			mutex_unlock(&rx->sta->ampdu_mlme.mtx);
 			ieee80211_send_delba(rx->sdata, rx->sta->sta.addr, tid,
 					     WLAN_BACK_RECIPIENT,
 					     WLAN_REASON_QSTA_REQUIRE_SETUP);
+		} else {
+			mutex_unlock(&rx->sta->ampdu_mlme.mtx);
+		}
=20
 		tid_agg_rx =3D rcu_dereference(rx->sta->ampdu_mlme.tid_rx[tid]);
 		if (!tid_agg_rx)
--
quilt 0.63
