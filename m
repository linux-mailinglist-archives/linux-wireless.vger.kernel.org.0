Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2BAF75E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 09:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfIKH7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 03:59:16 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com ([40.107.14.117]:22320
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfIKH7Q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 03:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDAjcmlJeevakrkbFDn0+zkgrJ+dLrd/iDJLI14tJ3MeGCyEnZuNnATudjRKGplni/ftUo6UQbEVnobLAybtHM+ZZ1Q3Vu9s3vmxtILR5+RnSTRc3H0MBiyLXxH7mQY2Gav4XRJjKrs+mf49PNVrQd96PMW11u3zwQjYzp7/0ixWGti9sjuHBzVd7nFrBFww3vvGA45IPHH3NVOfUGlNPzeNxucmzJ7sFI6KQ9Ijggg1jXTT6Yh7ZksRFQ65RvKn5tVIHd6LWAtlz2ngYQXRbkRa+FnnFZwVA7z2z4TBXHFHAyclQh1lbAIu9NXFupPoCcTM8beTazXON3yY/gTomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrIJBwqNKy9Fp5axjnd7lBX1THUoyZ8h1WCQnh8CErc=;
 b=WYO8Re8OkqJrUSFuKOcBU2dSIJmalnwnX+FO0b+5e50GzAFQMRB0TZzCxSiwFeBykQv+HXARyc70MOtcFIc+pV2cjjx8+jiB/THVqTL5LNUSrQ2ObbIZTSIpmqIAYNf+AqzxNJY4A857ttXu38ANwkfBWXzWgCTa+/XxwBqw1uxvKqNmW36/4/59onNOb9rsPlmcxvCwc73Pucl98C4zbo98Jk7F+VuEZx1poXv7kEkByP6Kpk6MDgqmv+CMSVfM0Z4V2meO7/rVrazRnaHRMKSuCqEyH+qZlfsx52cBruhkb26d7S5xwaTXK5ulfBGz+I0dFRiSR7/PO2yRLfH1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrIJBwqNKy9Fp5axjnd7lBX1THUoyZ8h1WCQnh8CErc=;
 b=esioyGUJVD//OdyFo+VLj69V03pnisMT/EagFSj6GZyHCnyFbP9LgW+kxoqBTPDOo3UBwQjZ/Ft/m+r1tErRkV6AA1nAVAf2+IDOmFzJCOMbP46e+dw5IwBwNi40D3Azbj8pNJGqHH+yv30wZ36lrBazwWCyBVxYjVA1aUO8o7w=
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com (20.176.239.11) by
 DB7PR02MB4460.eurprd02.prod.outlook.com (20.178.41.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Wed, 11 Sep 2019 07:58:31 +0000
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::c1b8:cfb9:aeea:5803]) by DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::c1b8:cfb9:aeea:5803%4]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 07:58:31 +0000
From:   Aaron Komisar <aaron.komisar@tandemg.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Aaron Komisar <aaron.komisar@tandemg.com>
Subject: [PATCH] Can't scan on ETSI domains when operating ch is DFS
Thread-Topic: [PATCH] Can't scan on ETSI domains when operating ch is DFS
Thread-Index: AQHVaHaz1r4/pdjrUUyysFv5c6SpqA==
Date:   Wed, 11 Sep 2019 07:58:30 +0000
Message-ID: <1568188529-14653-1-git-send-email-aaron.komisar@tandemg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::48) To DB7PR02MB4314.eurprd02.prod.outlook.com
 (2603:10a6:10:44::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron.komisar@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e67318e-8188-4302-c38d-08d7368dd61f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR02MB4460;
x-ms-traffictypediagnostic: DB7PR02MB4460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB4460168A4607F2C6AF1F2E5FF8B10@DB7PR02MB4460.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39840400004)(199004)(189003)(8936002)(186003)(102836004)(50226002)(5660300002)(2616005)(25786009)(5640700003)(26005)(107886003)(44832011)(476003)(486006)(52116002)(305945005)(7736002)(36756003)(99286004)(6512007)(64756008)(66446008)(66556008)(66476007)(14444005)(66946007)(256004)(2501003)(6116002)(316002)(3846002)(86362001)(6486002)(71190400001)(71200400001)(14454004)(66066001)(6436002)(6916009)(508600001)(4326008)(53936002)(6506007)(386003)(81166006)(81156014)(8676002)(2906002)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4460;H:DB7PR02MB4314.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NJLdpgv2X/PPC4FiFbKaogaOntt9FDlr8JJagFqq4je17NQ1VkZCBZ9Glpj9whzjlPzVLO8scB/ja3nAqMpTveFS7HWuw34NKUjC6U+Ta/wRvyX6SWeaMUTOgaa+E0+yoLA53Au768t7Pu7/eOP6tIaKADpu7+pazBlOM0WplijUM8OcvI27ENl+8R3iaR/v5pXu04EpU+JjB5tfwUpCXyRqAuFzhQqXX9UCRxoE8UnKLkFgo5pd6zFqKvPb5gu5iQHq8VV9I6U/LItY9UQQOstf6A5pSi/gFUg5DrFp/cnomsoVBpHu/zxoQf1jiFx1XO9ZuSMYzKp0qieymqpIbLpCiG8lTlhAnStBwJ3c20oE7U/2Ny2RHqWFxu4A73eWUobyiZWNsPjSbvi345vs2MTAVtruRr+FeYyK3vX1Ncg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e67318e-8188-4302-c38d-08d7368dd61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 07:58:31.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiHaXtp75GMt4MIOFXnbWhv1kF+hynyEUkiQI4B7wWwfaDNZfgCC+OjXuJTCEIbOoXe5vYg/sE/CqvPDkkWjxEawFp65XIUiS2cyBQUVhy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4460
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In non-ETSI reg domains scan is blocked when operating channel is a DFS ch.
For ETSI domains, however, once DFS channel is marked as available afer
the CAC, this channel will remain available even after leaving this channel=
.
Therefore a new CAC will not be required when scan is done.

In cfg80211 scan is not blocked for ETSI reg domains.
This patch enables scan in mac80211 as well when operating channel is a rad=
ar
channel for ETSI reg domains.

Signed-off-by: Aaron Komisar <aaron.komisar@tandemg.com>
---
 include/net/cfg80211.h | 8 ++++++++
 net/mac80211/scan.c    | 6 ++++--
 net/wireless/reg.c     | 1 +
 net/wireless/reg.h     | 8 --------
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5253e7f667bd..5349898ed3e6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5546,6 +5546,14 @@ const struct ieee80211_reg_rule *freq_reg_info(struc=
t wiphy *wiphy,
 const char *reg_initiator_name(enum nl80211_reg_initiator initiator);
=20
 /**
+ * regulatory_pre_cac_allowed - if pre-CAC allowed in the current dfs doma=
in
+ * @wiphy: wiphy for which pre-CAC capability is checked.
+
+ * Pre-CAC is allowed only in ETSI domain.
+ */
+bool regulatory_pre_cac_allowed(struct wiphy *wiphy);
+
+/**
  * DOC: Internal regulatory db functions
  *
  */
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index adf94ba1ed77..812ff820844b 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -523,7 +523,8 @@ static int ieee80211_start_sw_scan(struct ieee80211_loc=
al *local,
 static bool ieee80211_can_scan(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata)
 {
-	if (ieee80211_is_radar_required(local))
+	if (ieee80211_is_radar_required(local) &&
+	    !regulatory_pre_cac_allowed(local->hw.wiphy))
 		return false;
=20
 	if (!list_empty(&local->roc_list))
@@ -630,7 +631,8 @@ static int __ieee80211_start_scan(struct ieee80211_sub_=
if_data *sdata,
=20
 	lockdep_assert_held(&local->mtx);
=20
-	if (local->scan_req || ieee80211_is_radar_required(local))
+	if (local->scan_req || (ieee80211_is_radar_required(local) &&
+	    !regulatory_pre_cac_allowed(local->hw.wiphy)))
 		return -EBUSY;
=20
 	if (!ieee80211_can_scan(local, sdata)) {
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5311d0ae2454..50d3242c4985 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3883,6 +3883,7 @@ bool regulatory_pre_cac_allowed(struct wiphy *wiphy)
=20
 	return pre_cac_allowed;
 }
+EXPORT_SYMBOL(regulatory_pre_cac_allowed);
=20
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 				    struct cfg80211_chan_def *chandef,
diff --git a/net/wireless/reg.h b/net/wireless/reg.h
index 504133d76de4..dc8f689bd469 100644
--- a/net/wireless/reg.h
+++ b/net/wireless/reg.h
@@ -156,14 +156,6 @@ bool regulatory_indoor_allowed(void);
 #define REG_PRE_CAC_EXPIRY_GRACE_MS 2000
=20
 /**
- * regulatory_pre_cac_allowed - if pre-CAC allowed in the current dfs doma=
in
- * @wiphy: wiphy for which pre-CAC capability is checked.
-
- * Pre-CAC is allowed only in ETSI domain.
- */
-bool regulatory_pre_cac_allowed(struct wiphy *wiphy);
-
-/**
  * regulatory_propagate_dfs_state - Propagate DFS channel state to other w=
iphys
  * @wiphy - wiphy on which radar is detected and the event will be propaga=
ted
  *	to other available wiphys having the same DFS domain
--=20
2.11.0

