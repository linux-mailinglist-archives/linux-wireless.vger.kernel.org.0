Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A524C8A5E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfJBN7M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 09:59:12 -0400
Received: from mail-eopbgr50115.outbound.protection.outlook.com ([40.107.5.115]:7395
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfJBN7M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 09:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEk3kQg7p0Pp0QDzgwndLD8ofsl3N9Z4z/W3f1hspp1aUQrCQ2LsWbt0c5ktAudIzKivb+hKg8I3MMxQEBDoJ+lFh8+6/FBCi5aanjqGw4FNtIL0bW4y2atje+wjOKrOQYiZ05ChjEqXCsba2Kz2yA3D6QCx+nc6XqauJIZmsSZnU/UdWRBspKXbSb17jaYoOJmQhD1w3SPgs/twV85bxiIGO6UTANAwfYbgID9u9eOG0kFS/t54fu4C+JGGRcZFpmftP0ToEAzqM1ZHTXmbLtuTy7FiT1yewZPbt3pIxq+gUCklFhejbrDIe5Ce9OoGyvTRLSLeX7WrBSXpdeBECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NILg//pZf6ZX4A688tPlGpG+yNk5fNJloFdXO6YGgH4=;
 b=EuUZF+l/UA+i2TjXHJ6QioN5iNDlpn2sbOshqu1dHF49uyubUJ2qSY2agpxKHxryX0sHb2mcqfHY9PnYDoK+tOE4UZ/uiNtx38a+NryyONZ22A3NZq1ekgzNOJDKi4NHBKVYWj+8Yrrt4Xoskf/+j4qYVpfm8c6/NmcoE1hoWRLMmlahrlkXL76RgAP9A5DqeddKoN8hPkNx2RrQ7HyGguf1VTXg16BI8oUldCSG8iETuZrXR7VpKq+gk9o6eL+OCLUeORP552KEJcqBryo6z1pVbjJga7O8tPJVzAQNlgO8rv6tuF6Fh/G0CypdA5PquF3yPzvNDNgJWPk4/0UFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NILg//pZf6ZX4A688tPlGpG+yNk5fNJloFdXO6YGgH4=;
 b=E7lSXbKFE0rTczZlvLS2lw1vYFc9RBTV5wgVYGPZLlMQeN5OiDAeGxCFFCoPP9++4DTtW0nd+l2s8NRICdv2mPkt7OzZxADb79nXQvIYtVbtWMEIM7MEL4TtwDFnWCW+jRR6yE8Lke0UdCNNaTOVJHw2gdt6ETPvdN1iEXndZe0=
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com (20.176.239.11) by
 DB7PR02MB4250.eurprd02.prod.outlook.com (20.176.238.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 13:59:07 +0000
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::f978:a0d8:4042:92b]) by DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::f978:a0d8:4042:92b%5]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:59:07 +0000
From:   Aaron Komisar <aaron.komisar@tandemg.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Aaron Komisar <aaron.komisar@tandemg.com>
Subject: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI domains
Thread-Topic: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI
 domains
Thread-Index: AQHVeSmOSAENpyhoVE6RI/+qs7ypzA==
Date:   Wed, 2 Oct 2019 13:59:07 +0000
Message-ID: <1570024728-17284-1-git-send-email-aaron.komisar@tandemg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0902CA0009.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::19) To DB7PR02MB4314.eurprd02.prod.outlook.com
 (2603:10a6:10:44::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron.komisar@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03426bd6-a871-4db8-1cbb-08d74740b104
x-ms-traffictypediagnostic: DB7PR02MB4250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB4250E67922580F785423BD94F89C0@DB7PR02MB4250.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39840400004)(136003)(199004)(189003)(86362001)(15650500001)(102836004)(6512007)(2616005)(99286004)(5640700003)(476003)(186003)(2351001)(5660300002)(8676002)(6506007)(386003)(14454004)(26005)(107886003)(66066001)(36756003)(66946007)(71200400001)(6916009)(81166006)(81156014)(66446008)(64756008)(66476007)(8936002)(52116002)(4326008)(66556008)(50226002)(2906002)(71190400001)(25786009)(7736002)(44832011)(486006)(6436002)(508600001)(6486002)(305945005)(2501003)(6116002)(14444005)(256004)(316002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4250;H:DB7PR02MB4314.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bv7gsI7KXQt7N9Sw4XGzchyVamVefbVpYc6+MBCZiJbkGNNZBbc3I+qEeB0klZsNjDWOcY+BD6sl2yZf8qessU4cDq8OdpzqtzA4iA0GrpdU084tM0KfKSGF/a142dsoj4YAZpx7ucbediCAsNWfwFoNhbGqXA2392O9E22mQwpeooycd+CfaOf3a2FS7KVvWfWsWqPjJnXLzp4kvKFvewHShZi2onvMNSqlH7syh6cQCGg6u9wPilqGENn3qkUY4Otl9PrCOP/1E9+LfTs55riD5Br+3HEcqsaEf8d94HsfAd2mecxiaiP14MhhW+9yk+Ta11vMHekpi7OLldznvUf3zysy6xpCvw9oj1lT6BVJQQK161flWedBHrrULgL0863fkUpG+Pmh+0+JDJI9/pFXCCI6a8ToZupnA1rqmL8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03426bd6-a871-4db8-1cbb-08d74740b104
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:59:07.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcZOCxxTlcOq0XinL5U03/0kFlela36v6OcouuAJoEKTXdqcZworHw2J+8c6uQ/5Cw4Ef2PqkH6UjXDHsXjTr5wR43uNhJzqTPTFbuIrNuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4250
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
Changes in v3:
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

