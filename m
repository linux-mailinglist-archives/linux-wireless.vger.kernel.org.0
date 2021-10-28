Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D343DECC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJ1K2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 06:28:06 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:50618
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhJ1K2F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 06:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9nIuw3LYNrNVdqvEvN/7s4giNeoHG/P67nf7+Dsl7nm2MbgUaAqXiMWL3E/AzHhgnvQxr2GEKbRMdPyfPWuqDLkH/eI5h5OdeHfQ7zaKZw40jumA7vvRZALbTlkcScboZvtE3BPbKwA8jBIaWEi3xLVucS4o9z02K1qRIrdxosbkcBboEGj75U5U4mU+DvWwwhinsOorXz/zFLl3rbNFS50d2FbPcR7p4fGBUjQ5WW+kQxE8AkjwEMoHuZhHcudd2Olnme3J5C3JS24pCErHq0uRNMsNQx5bRF7/9Mc8lDFZpE4CF0urzP4cbvjL8dsJdeLsYGCCNF6ywQLlk5Kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJRDza0DmJBpMbKtC5cCZefPfe38qbo67c7i6UA2DgY=;
 b=XL5ti6Vq3p0QfjgBjb0KBBbLOcl8b/9vWw6iMPylSwqipfkcVoryVBlLwGLFlrRhutW/dFZ416PJRRjh8L1nMNSwLtRV9UgMCFnHwQaaroYSP+s1z4vhxdjyuvFYR+MuvTw2RPkPvE0AakVQJPsNdcdhd2a5e339a+yplfaa/vrzCevrxuBnTMqCleaUi7AlBcSdFoqpJKYdzCJ3pbg8B8fF6pV+4ZvtNw8CzDObYUg3KEEDt/DF5FKyCUeyOO7dToYQ0dshPOa8Xlr83wUarPG/muKO6NEhSTrCtB7wPiBtJtGLm2eoK8qDfaQLNOyMicZje9PdC8cHj20Kga37AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJRDza0DmJBpMbKtC5cCZefPfe38qbo67c7i6UA2DgY=;
 b=PriW8V+xykbLPtQY+9RKjpJndjwYnzr/CtLW3wCPus0LSYUqJlfGYPmdPzZSWpwIsUZYQlOVe62aSKoMM22WLqUHOsZhj72Cz5oKSQAPdxV5j9+ymeU2c5GkYcNLqoMNL9Qp8FSW4yuup7Crw1165lAXFMXYLSaOGKCqrQG7cyM=
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21d::7) by DB6PR0101MB2376.eurprd01.prod.exchangelabs.com
 (2603:10a6:4:3b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 10:25:36 +0000
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe]) by DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::f007:df3d:1b84:f0fe%6]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 10:25:36 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     "Johannes Berg (johannes@sipsolutions.net)" 
        <johannes@sipsolutions.net>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
Subject: [RFC v4] mac80211: fix rx blockack session race condition
Thread-Topic: [RFC v4] mac80211: fix rx blockack session race condition
Thread-Index: AdfL5NB40bniWIPCQwqcYHgT9opvcA==
Date:   Thu, 28 Oct 2021 10:25:36 +0000
Message-ID: <DB9PR01MB73541FED9E91AC3005D27DAEE4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=acksys.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ebc9538-085d-4f00-ef21-08d999fd47ee
x-ms-traffictypediagnostic: DB6PR0101MB2376:
x-microsoft-antispam-prvs: <DB6PR0101MB2376348C9782882AB5762063E4869@DB6PR0101MB2376.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOJa5zbIQVLrPjG4t+YgzVmC+4Z8HfH1HnxqkmghQGzh47gFPwxHacNPFExYwx26ZTVcquo5axt+HLLZCJ+gZDah1m03uoyUL0cmE1j26N/dt/f/C4XE4JGrzxciV7QhHDM9ruY7en9vOl3ONSxvmE52t687he3FAmWLKE7lHPjpCoCV0qAQs0LzdxVGGJeNlqOI8OpfIiHrB9jtxx7CgtZM/IcavpOyFv+j2O09yco32VO23hBYFQ4bn3D+YTkbIS41PqkbPeo46AHq1JOPyfhxI7WFIjb/QSwfci4fIBdFG3DiTsJsk8v8ypor+oBQNL1HHpj8i7JacpZKwgneLYzJ2/qttIjchx7vyF4Sh7lOKYm1d6cW5pyWdNlzToOsX6sdv3R5xHXlKELmyxUtqQR/Fv4G03lF6zFpQwyN/QsPB6tmAqNr2dLbL993inU4rOu1aWlqYbuh6dl74+nmHirFEnsfDdJkU03+MaBU8avZsukWWgRKbrIYcpx3AIvsWcKCPN0TViltaXQTuv4rZBJC/WJk3/qiA8Xv4Dvm2218+leBTzL45nTRDtgLQ/jVZOquNLwwierHeKTa0QCTXN4dbLDLBfsgHoVOJeSwQN53jnjJppz67PZ71soq5PiVl0CY57HuixMHceLjjra8BFDlh7bmdp9xOc2bo2fE/UprIgQaTD0ruM3MquzTvB9A3VnZdqJNAdlJfhGUsDf+V1GpNU683qdjbU51UYfJsWk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR01MB7354.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(366004)(376002)(396003)(136003)(83380400001)(8676002)(86362001)(508600001)(122000001)(66556008)(38100700002)(66476007)(33656002)(38070700005)(110136005)(76116006)(2906002)(186003)(66446008)(6506007)(8936002)(26005)(316002)(64756008)(52536014)(5660300002)(66946007)(9686003)(7696005)(55016002)(71200400001)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MyBlX7Ir15bRpEXdgZoKK4IfPayoWHbBXbuyw8KHUhQume8QgrbYUa8xSDVm?=
 =?us-ascii?Q?guEq4LwYjwaYKaAcOOJ5OFouHkMzAhjPzz672A4U/GxJjU9supWWqh8HVL5g?=
 =?us-ascii?Q?o1wh/YJ/R0ZIY9AuHcduxl7oHzpnw0BLMu43RyLxWKfHX5uBA7C7GreEYI8l?=
 =?us-ascii?Q?nR94UnRS3UJsQgzbiPWTdCoIJUSN0gErDrESmehXnWGbU51yNq0b7w8fkzAH?=
 =?us-ascii?Q?UjBP15JVJTdm+/IsSZDYyBIPWBt+I6cfUOF/JwM46WlBBfnovr2eHS9fLiFj?=
 =?us-ascii?Q?aUJIj/FgcVjfl7pGR6L2Ol/r9bF8ZJbJJQwyjDVyj1tU+6T8XSbIA2//ujHF?=
 =?us-ascii?Q?lg47ipiXg7HXuXZm/3kS1wepCo/CdguL9UXeRmZ8cmGWMbDGFG6wv9WIEiCl?=
 =?us-ascii?Q?71BozT/2LV0E4zG+MXpMSXKnxrcZA/8V8QYB0NVuJCqsp0pr0eztNftC6Lqd?=
 =?us-ascii?Q?Q11VBu305qfGS62USgGaUO80k5sId6ti/xM/CyY0sq39RH+ProCWAxuOJpBs?=
 =?us-ascii?Q?/bdyzTuNgCEOVjdfpMPgI/PORsFY7adGnYukDcDZ/OByJ7mP0GYklejEoYs2?=
 =?us-ascii?Q?LczXymMhCNCx+c5rQB0lTIVDvc2DwAaoPD3ZLOdTShHygQXnWc+g22VQGUmM?=
 =?us-ascii?Q?/RmvaLPylqqZ+tuWt9eJPOf9KgXBnZYQMQ/x0TWsUC97yxH355KyjtT6SX9m?=
 =?us-ascii?Q?nSfN1V5P7DHtOZ/k1rXJ+1H5xtp86Fvy8jQIR1Qxm9jqB2MkvDMQmN4d+OfG?=
 =?us-ascii?Q?9+TossYv639gwskjES2c5h2VVCsbPdPuAmcOMn6qKgWoOggqRtHWkEaiKEFH?=
 =?us-ascii?Q?K+NqlAmKsgUtKB1lbQaiLwjQaPUUsXAl5hO/PsIpaaJ1apFDGGwZXAaWvUcu?=
 =?us-ascii?Q?rdjFS7CmY+jeNtUJzlbZzEQiQSmKhp+LaEu49mx3ezKn7CoIVO+ODx3SSd2R?=
 =?us-ascii?Q?ppFaHRB5gW4qb3NKlQ2ZB8csFFS0S8bRc8FHp9wcVHSxZf7bzvYM1OOdJHiX?=
 =?us-ascii?Q?/wRxA768LPlsrxhmOURwL04oehaTzPyOacR88qFHjFw+Bnsu02FCKmj3w0hD?=
 =?us-ascii?Q?tuGRIiYuEOofIverNyzju0sJ3tH/zeJZ69Yf88QS1DERCpn2+ezj4ZvkxrG4?=
 =?us-ascii?Q?XuVKlO/Nd1+/AitBN9If5azcrsEdriivcpiacmOYfbEEnWhhPcZg57ngguh+?=
 =?us-ascii?Q?UAZbu0Mmqgawrru8sDpMn1uy+H1VhKOMXYgQvosKk96Ue6Pj7SnnO1/Ul5ho?=
 =?us-ascii?Q?A7E1lr7HWwYFDgMSq4VaE2NijdTRH8+LitWVQIuM7EP2IssnO6OFmg8crX6B?=
 =?us-ascii?Q?N60twXFwJSYVSGjpo7VRBx6bJOCm/BXLyGf41OfjLwog2P/pUA4vMAbcAxU+?=
 =?us-ascii?Q?JIZXFuF1mVStN1x2RH6/45tBFXTl7kjz++2n7W/5sPOGM8V5kyz337Sq1zv2?=
 =?us-ascii?Q?H6JzumU1FPPd3fgqSdmJyNjLLOCl3iJ5oa7rQR47RXMr3yxnjmS5PDbv8pTm?=
 =?us-ascii?Q?PLnGUEDYrN9W37SjC6zTgghsQhwOQMrIHBFqJ5zh84mrQT6KFKdv1yrLGxI/?=
 =?us-ascii?Q?fBW+8ntSdE5urWn5W1/3JzIiDkK6NgojadqwSBAldcuEzanWkKZvtICReCdD?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR01MB7354.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebc9538-085d-4f00-ef21-08d999fd47ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 10:25:36.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3mLRWkkXxDIVTbQ2tp2dyvOpzpikAjbJ82qh2QGsDASOLiPipUk9CFFu4uvD5yhG3IB2LvWN4+ZXvQ6scEk5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0101MB2376
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

Note 2: this fix was tested against a wireless backport from 5.4-rc8.

Signed-off-by: Jean-Pierre Tosoni <jp.tosoni@acksys.fr>
---
V2: remove debugging code leftovers, sorry for that
V3: use spin_lock_bh instead of a mutex
V4: spinlock must protect ___ieee80211_start_rx_ba_session instead of
    ___ieee80211_stop_rx_ba_session
Index: bp/net/mac80211/rx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- bp.orig/net/mac80211/rx.c
+++ bp/net/mac80211/rx.c
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
Index: bp/net/mac80211/ht.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- bp.orig/net/mac80211/ht.c
+++ bp/net/mac80211/ht.c
@@ -360,12 +360,14 @@ void ieee80211_ba_session_work(struct wo
 				sta, tid, WLAN_BACK_RECIPIENT,
 				WLAN_REASON_UNSPECIFIED, true);
=20
+		spin_lock_bh(&sta->ampdu_mlme.rx_offl_lock);
 		if (!blocked &&
 		    test_and_clear_bit(tid,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
 			___ieee80211_start_rx_ba_session(sta, 0, 0, 0, 1, tid,
 							 IEEE80211_MAX_AMPDU_BUF_HT,
 							 false, true, NULL);
+		spin_unlock_bh(&sta->ampdu_mlme.rx_offl_lock);
=20
 		if (test_and_clear_bit(tid + IEEE80211_NUM_TIDS,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
Index: bp/net/mac80211/sta_info.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- bp.orig/net/mac80211/sta_info.c
+++ bp/net/mac80211/sta_info.c
@@ -354,6 +354,7 @@ struct sta_info *sta_info_alloc(struct i
=20
 	spin_lock_init(&sta->lock);
 	spin_lock_init(&sta->ps_lock);
+	spin_lock_init(&sta->ampdu_mlme.rx_offl_lock);
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
 	INIT_WORK(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
 	mutex_init(&sta->ampdu_mlme.mtx);
Index: bp/net/mac80211/sta_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- bp.orig/net/mac80211/sta_info.h
+++ bp/net/mac80211/sta_info.h
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

