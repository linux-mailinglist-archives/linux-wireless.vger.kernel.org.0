Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D443DD82
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJ1JRH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 05:17:07 -0400
Received: from mail-db8eur05on2122.outbound.protection.outlook.com ([40.107.20.122]:4480
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhJ1JRG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 05:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsDiNmsR4tCbyiWLeIA29j8UtmFwoFETMHrOWsYpezcaLXXSQed/0g6vjpGyKUW0Z+VhrKQ79Y72+rLSXaqLNh6jhYv/QWMQjKe9ayUnGDOwvJcUi4BVvB1jKvZg7XDEbkNoV2BCzTG0oVJjQG4sHPxj+EJFuwjdQye7Uq+JEwyxMLbcqfeU2N9+09GHae67rdX7n01K1Fg6KLwl+sYFhofEpSu6Oq15dO/G8Cm+yntDPtJaZXYC3zlbMhbDGzfIk8SzL/3bvHR3dQnARed5YmiX2ulhobWr66KYK6CbePcL/sbCHTw5sI7LE0Cree/AxLRV4RSc3TKh7qsSfz2YHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxK7EoukByycGS/xcQTL9XzvsJ27JzX0qaF5JxTedXE=;
 b=S7rWB03OY9HBeqG/whyKtr7HgeGvm2Vh+6oSExo6xiq+q/ng1aSsLg11zf+Pq8cxN3qam+s4NLOuwVl7jeZsBtfi57aGbofoBPxVCiOfem6icvQLm14JhIJl+DlktXYiwHmCNX+roOuBDEYW2X8voMjgnFVb0wJhj4I+nJhhSfhvCWZh6mUlF99qaKz8SFdeU4uCf3zErxuVcE3Ei+lmO57wsRrx2gNitaA3LMSvhr2z4FS1t4kXHczvoMRFyA2MGS12/iWvuBt85jak5PYh+yqRu7lNt2OZXF8Y6Zc7hACUKOB9aVi2B5TMrtdw71sjH3Lxy/iI4c6bJHGSQ2MAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxK7EoukByycGS/xcQTL9XzvsJ27JzX0qaF5JxTedXE=;
 b=i2JiDG/mQaZx7KdEpiFb4ggOZEUDKWiXysXo1cahqWLQwwgSg48UTOpFBYHl0wr6se2+7KH9gmy/JPatmSBGDEGtM9gAY8mZC5BUotBY++qKFvEkBLUoEA6xLQ6WpQA0x/FumBv1AVj2u1BJdCDFtSsgxSrzb06PyUjp8KrmBoU=
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21d::7) by DB7PR01MB4715.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:61::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 09:14:37 +0000
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe]) by DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe%6]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 09:14:37 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     "Johannes Berg (johannes@sipsolutions.net)" 
        <johannes@sipsolutions.net>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
Subject: [RFC v3] mac80211: fix rx blockack session race condition
Thread-Topic: [RFC v3] mac80211: fix rx blockack session race condition
Thread-Index: AdfL0tUGplDdZUWUTvSEilo32QEGpQ==
Date:   Thu, 28 Oct 2021 09:14:37 +0000
Message-ID: <DB9PR01MB7354781F66D4D59611D256A6E4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=acksys.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930b8368-0c7e-4be7-36d7-08d999f35d7b
x-ms-traffictypediagnostic: DB7PR01MB4715:
x-microsoft-antispam-prvs: <DB7PR01MB471518EE8D1B2B40971418B6E4869@DB7PR01MB4715.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htIdbR+mEexp0g0TTkBUpkJxSY2fkk9lmVvnEYkk6IxpPdo7PFxVhyZVxt2FX9XA0qADXSG15MUjgVPDpaAooKN6EhalZtEz/ZujnDF1y2dTTmN/VkmQ84uoTFtAqquEqksbh3F3rHUVx+C9BT+DpzkteUl46ahB6Qy10dauPv9eatRaJOuKGHUYO9/+F8+hmPzNjXtEqev/oK+dVN0dptBRGAvQQTqas1+fFm2avXhQ/FnWImX7HfccGhOYHCHIU3VhFTINuFceeJ/Yg63G4+osn4NbdRVpigdVeu9p0IjRAB7ihaxSX0akx83KqEh+oEhkFXVTGo5lU1yeEIyOv+J0rSMLVr3MO+pOViJDiV3xvCt6r4bck0gvfZgNQaJ2IreDV2EN0xDclraKFiPGhqirPuvUwqxzTxpJfUboKkyMyvxyX5/ShP7bN/z2ebVcC78L5RXfk40I3OfGGQIYRw1a2PH5hvcLPxqDJkBe8deb/oB6CiQmGS1sPGyzx1K/rs+pi/c9fi6W/tLdg+OI9WqNyUjHu9UKjj7a/v29+4cvKxbuszeo9cm4bQpZ1VdN8SK9gnUaxczGXZgncfhU+EDRuHtcDmfRektpAON+6OjT2kmOIMMxcTN39EHOzNdV7DV9HBuSzDOncicZzW+CbrMt9MVQdz79JdA6ciBuSRioPoJBAwn3Xyc9yJjjyDnhjb9OBZDlMx6lI6aHSWSw5VOMydpXGC2fPc67brdsloU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR01MB7354.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39830400003)(366004)(136003)(396003)(508600001)(66476007)(5660300002)(186003)(316002)(83380400001)(26005)(66556008)(66946007)(7696005)(64756008)(66446008)(76116006)(8676002)(52536014)(86362001)(6506007)(8936002)(55016002)(38100700002)(33656002)(2906002)(110136005)(9686003)(122000001)(71200400001)(38070700005)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rAeePg4JVd4/03Q8AxWS1+C7C0MTB6h51oV5vvIHL6L6ec+v/SBov0S7Zu69?=
 =?us-ascii?Q?EEz5Whd/00LqXQLENXNaSfk7gX0qOo76nq5TiFnPIsTFpd2OEzWtU5yO5b/L?=
 =?us-ascii?Q?4eKURxH+say6q9ZqoHOFxEIAO6igHsNMYxo6dkB7oXl4kfNxFbpYPhGy+CmI?=
 =?us-ascii?Q?oHafDOJRK/jpIs+vscuWkSDakXDHQS6ufxHvmxi9lwN0YZF+AlsOBqnvNr/F?=
 =?us-ascii?Q?rpL5Sf0W2XXohYP2GzOWcqaAfa37ALarIAlucNYvCavTubxP6p/ONh1boobR?=
 =?us-ascii?Q?lHY3EIXB4+ukKk5jdEQNjPvrj5mjwEEWkNAWZSLzRsNXmM3oGMDDgzSwfuAP?=
 =?us-ascii?Q?ZLcwnLUYMfUtkvX1vN47cOAZ8TJllJ+/PCQjEgbjlLpZsB2aEnWneYtZe9Gi?=
 =?us-ascii?Q?dXTbbkP4DQPHSEtI4kwasHYHSpCkoQtiYonGymK4v3r5Q5kahq7BigrcR7Zb?=
 =?us-ascii?Q?TLkGR9oKennvKRyrwHBoE4zhwsWUrbFevuvyWJLoeI7vzCfvTWsDWu8KqA0t?=
 =?us-ascii?Q?rUOgeYS9Wl8LsPFcm1w2QGbN058XvezsT2WowJrB5gZWmyLp8GFx4EOVpCwQ?=
 =?us-ascii?Q?2TJDBJzPe4r3WuiocgfBxS1MzQiFMjDxN7koeJK8OHQhan686+C2jC42PBFp?=
 =?us-ascii?Q?XZw0D9lE7SGhQZS1FCjbqxSXR+MzZ3Rko2GdgnXgGFtxMSyLKbVGF8oKTTvv?=
 =?us-ascii?Q?7esFd360DScaV1eo7k7iZaEb3+iLWsed1tjYXZ1IgeKjuEqKsMJDqMEQaorw?=
 =?us-ascii?Q?i9HJxl23Th7/kdCDp/Lvaou0j2JneXv4F0yk3DOG//Wt2kc13UBNAT78v6Vr?=
 =?us-ascii?Q?/N7wpjtmaKC1WgvHaFbDyB9fHX7QxcJpEFGZjnISAuD4DFiwJVn2a7g00G/j?=
 =?us-ascii?Q?wJrwx/QEhhK6X5otu+vX18IiSQv+ELUAYrSxh9ZXALOI+eWFWhqSBl3n0EC4?=
 =?us-ascii?Q?69XxQ1oQkab7DSg+La5bGME39WLRcwLQPrVjWILa8liNA2kcFrx770i/lg5s?=
 =?us-ascii?Q?Vz4eRPdM6GyMer6klPorF6M6+t42TGJEKwxsGL6pBTuh87bPacSK8g2YstFG?=
 =?us-ascii?Q?BZ99r2Xu+cXF4yq+dzRUsMg+mEW7grS23npFRYtlRjgP9csOGhIgvnmiPxGn?=
 =?us-ascii?Q?wVLTOS7WASvHE7CUhlZ7qcsKySC+YzLPlroFnQJjrDF/JuvSqAuhS6KiUpvB?=
 =?us-ascii?Q?+lMIg/1EJUXn80H/4s2Lm8Wk4N/EZnpNzJm38i8Jnv+gsQS7pX6hxxF4frz+?=
 =?us-ascii?Q?9Uw2Z1cBkW0es7VLZoZ2AGM7M3mUTrzrOi+7sgJft7Cs5bWpzthRTclNOJ3u?=
 =?us-ascii?Q?ZhaLiQaI8TAT/EUI1+sQRLQlEqHHy8J4NHECGxRhqcHB7Z8lvv66JIsbd9yP?=
 =?us-ascii?Q?fnXpDtMxX8NEcs4yMeGpUrytl85NKYL/eKW5ZoXgjs0QUHoX0WzBzkJ4eF0s?=
 =?us-ascii?Q?BVOHkSae1K4ZsMXdkkpEawEJ/G5+VSlqbG5gkVcx7CaDvWlXxHcapd7Rr+gO?=
 =?us-ascii?Q?cVpwqO2gflHGdtNoMY9lqMPNihi0+Mc4PvEMl4U4Pm9NxUrg7Sba9jGQvJqu?=
 =?us-ascii?Q?7t7xVGT5BIqpJLLjg7pPHVxbVS4Wpju+SVtvsykzTpcGpHPbz3VQFl2jXpXq?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR01MB7354.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930b8368-0c7e-4be7-36d7-08d999f35d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 09:14:37.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kDdHrZwC4WXauLK4/SWZvEY6yz4OwPgI6nljdpGpQ1YnqVrrU+N4z+3oyQid4rW+nICkhwfSuj0MSpskLop4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4715
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
