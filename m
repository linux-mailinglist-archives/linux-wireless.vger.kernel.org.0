Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C801B672F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 17:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfIRPdd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 11:33:33 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:25373
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729873AbfIRPdc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 11:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuyoqN5QWgiOPgo2TrqqJB6JsIj1+TXUJJ6MlYN2vOJEHfYb/QXlsLyWG09eC/o+hhaRPol0Nu9cA07v0R3jTmzmh9SfclWQCWyHXcMIE+Feu/TykKbzZEKnmJCEYqPf6pI+cBt2guWlip7AvKzqYO3jhNtrYqmh2BF6POXegWigzfVp/c3ZWTXNLGhqd5B8tTZl0QTlJi6zkgIdAQzv7nO3IpoNoSRICnpj3AbNyWPp93KGubgNoOCR2sQki7GotXj4Eo5d7OpaMNmTcvUlZTIxjxSYGHidhh/P/Ku5wISUhExdMpK3K1/0M12UG8mbN0IXuRis3hfaBg7xbv+NHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo+7VyaPpvQewMiEgvGE790JZsK6CLWA/hAQGr4D79M=;
 b=fwmk3FQBtBJnxs9SImt8JGdsQhS/bhGaTsNDAVwJit9Emuq/aDiwb7+oGqvvCClXpP/Y/ntTNsOr/1D+LXJxsEX0s0t8sORe7blA++m/uAOqwD2YHkvxtjIFZ4ogiTYX2bd7G0ibenpcN31FQ0KYu4Q1nqGIdLaajTFg9VJ5mzKqBLj2OHgdLalGL5L9gFRT7FYenwqvIuQnEJ7YK1AVu0sica0Pt8n5oTkgq4cSqhKOpJYQ9GEn0zc5IsfjVJFC5v6sfXeXO7cC/pqKKSbTeAfPd+irJiQ2uqs/PB8+brATnFPbOH3HBOoHTEfVCgNXGflb3IwXdIxcyB5E5iutXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo+7VyaPpvQewMiEgvGE790JZsK6CLWA/hAQGr4D79M=;
 b=XDbJ6lRQtgcNIIG0/b7xPSie37Gu+E63ZNuGDhgp8r50XrBx/Jr0ZsExbR8QZJ+WGJpzCpcs1wvdLrPlxp4/t0u68G1jVPM2pVlMEJtCaj2xJpcgKD1/rbz+vOpPgC6drnlp4M9kUTvcbpci04Mz924/uJ0NNlrJrKJVwlV5pQ0=
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com (20.176.239.11) by
 DB7PR02MB5306.eurprd02.prod.outlook.com (20.178.44.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Wed, 18 Sep 2019 15:33:26 +0000
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::883a:76f9:6600:4ca8]) by DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::883a:76f9:6600:4ca8%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 15:33:26 +0000
From:   Aaron Komisar <aaron.komisar@tandemg.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Aaron Komisar <aaron.komisar@tandemg.com>
Subject: [PATCH v2] Can't scan on ETSI domains when operating ch is DFS
Thread-Topic: [PATCH v2] Can't scan on ETSI domains when operating ch is DFS
Thread-Index: AQHVbjZpIGFsSiGrGk65Wy5zqOPP4Q==
Date:   Wed, 18 Sep 2019 15:33:26 +0000
Message-ID: <1568820782-4679-1-git-send-email-aaron.komisar@tandemg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0205.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::25) To DB7PR02MB4314.eurprd02.prod.outlook.com
 (2603:10a6:10:44::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron.komisar@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe21d14e-9936-49d9-3cb8-08d73c4d8c47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:DB7PR02MB5306;
x-ms-traffictypediagnostic: DB7PR02MB5306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB53067B30784A103D34839567F88E0@DB7PR02MB5306.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(39830400003)(366004)(346002)(199004)(189003)(476003)(305945005)(14454004)(66446008)(66946007)(8676002)(6916009)(14444005)(64756008)(66556008)(66476007)(50226002)(81166006)(5640700003)(508600001)(6436002)(6486002)(3846002)(256004)(81156014)(52116002)(186003)(71190400001)(71200400001)(2906002)(8936002)(102836004)(6116002)(2501003)(2616005)(99286004)(44832011)(25786009)(107886003)(6506007)(2351001)(316002)(7736002)(86362001)(486006)(26005)(386003)(36756003)(4326008)(5660300002)(66066001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB5306;H:DB7PR02MB4314.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6AZ2rvJ2fS7vN5BY1ec2H/BzmTnKeLzoQEl9jGx7ANhF9N49DBwv/cIpS3EqXNYSX6P59x4n+O7zGr1JFh5/1ujgkD3agy3HZ0plKj3itlYNI5X7i/eELAaqBhkwB2kpGNZlbrY7eMnA8Vkq2Znb28B2b5rd5FOuSa40AYpm5abYt1TnynDSXVDsEIHKpFe3ESIImERHE++XeizMhIyowJ1TbRHflKQjHCbC58Tv4iDyZMuPKZbzfr1oEkwCl6IudVpaVpry3IlB3vJDaZT9mKnXkEY3+WOjSEmf3meX9VdA8omWIcm7bpiFcJtYAPtw+mQLGbfl3yStOVvVuOSbScezhm0HtkmApAtIFGU9mopA25HwCdkfhK3x/xfhm4f6xHg5+FHNjhWqLo9BHc+xVeS/lHpcbnsBJVZnOuV79II=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe21d14e-9936-49d9-3cb8-08d73c4d8c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 15:33:26.2410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9QMlT3X/emck11gMuRuOk/b1oWdMs0y/WFKNqk7adLjM7nWoo/eql0zL6s0LcOodKSBM0JdbFaZ0023M1vfWq1W3YH2eFRpg+4oWEf9rIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5306
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
channel for ETSI reg domains (unless CAC is in progress).

Signed-off-by: Aaron Komisar <aaron.komisar@tandemg.com>
---

Changes in v2:
 - Added verification that CAC is not in progress
 - Updated commit message

 include/net/cfg80211.h |  8 ++++++++
 net/mac80211/scan.c    | 30 ++++++++++++++++++++++++++++--
 net/wireless/reg.c     |  1 +
 net/wireless/reg.h     |  8 --------
 4 files changed, 37 insertions(+), 10 deletions(-)

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
index adf94ba1ed77..4d31d9688dc2 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -520,10 +520,33 @@ static int ieee80211_start_sw_scan(struct ieee80211_l=
ocal *local,
 	return 0;
 }
=20
+static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local =3D sdata->local;
+	struct ieee80211_sub_if_data *sdata_iter;
+
+	if (!ieee80211_is_radar_required(local))
+		return true;
+
+	if (!regulatory_pre_cac_allowed(local->hw.wiphy))
+		return false;
+
+	mutex_lock(&local->iflist_mtx);
+	list_for_each_entry(sdata_iter, &local->interfaces, list) {
+		if (sdata_iter->wdev.cac_started) {
+			mutex_unlock(&local->iflist_mtx);
+			return false;
+		}
+	}
+	mutex_unlock(&local->iflist_mtx);
+
+	return true;
+}
+
 static bool ieee80211_can_scan(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata)
 {
-	if (ieee80211_is_radar_required(local))
+	if (!__ieee80211_can_leave_ch(sdata))
 		return false;
=20
 	if (!list_empty(&local->roc_list))
@@ -630,7 +653,10 @@ static int __ieee80211_start_scan(struct ieee80211_sub=
_if_data *sdata,
=20
 	lockdep_assert_held(&local->mtx);
=20
-	if (local->scan_req || ieee80211_is_radar_required(local))
+	if (local->scan_req)
+		return -EBUSY;
+
+	if (!__ieee80211_can_leave_ch(sdata))
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

