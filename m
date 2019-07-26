Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6639B76F31
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbfGZQkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 12:40:08 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:8886 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbfGZQkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 12:40:08 -0400
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QGZjn2003725;
        Fri, 26 Jul 2019 10:40:01 -0600
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by mx0a-00183b01.pphosted.com with ESMTP id 2u0560r098-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 10:40:01 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJnAINBjlGisDpJ4miJ2YdFF6wmOn9zhUDwdF2iSYi4TPE764Thx4p2Yu8foYQ8zv+CPNEo5TC5ppe8h4GW7nDFJzKO+6id5TYg7meM7y9iYWmFE4ZNdqs/E3bhTgp9++fzqCZPeVqIuGnLRz1OxgjkV2TE9NszDvDV5d96VlxnDNwq/K0IjKsu1U3QF5vAYVzEp3tQ0OMWcZpiH9yjh8dQ30tnpcollD+lMm3UAPmmQdTb2QZLyEeGc0FdPSFTUFg2ly+9htTWFmN1uZegIRyxMXnc36iwIepyecnTdOlJI5XGxWEjSB0W8Ec69rKQUK9rS5ihJk6WhkMZWq1EUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PA46Gcs8yYFZrJR+ZEYBttDcP5fY2dU2EFn/rf/ldk=;
 b=SqK7QiaGb24H7brRgl4+BDwlQwZNsFS8nblfW8Mhs93XZgjv3rMaj9ZwYfulxvhiTNEG8jqD2sfnLucjsOtn7U74stLiIDjJ8ihb5RFQGBTt4AuC1vQMyIi6uqlrRaAYidZK4UVnyP9VEm53jUA9S7FQOQoCsKVtEW/Zi6vA88ycKEajdS7iKPe/z4rGXg8czvy/GWRZIY7hbNplvuEbKs9DAKIF9Q5z8Ia9jEy0ywSwXsETeIyxLafVsw3hdXFz+S0nKDCByU/qCuB50Gk8gUkVma/r5jDDUWyNz0eQFGtQuwoX+ESwDLaAbPqokTPeQzbKB+o0OlvvS0GWX0HA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PA46Gcs8yYFZrJR+ZEYBttDcP5fY2dU2EFn/rf/ldk=;
 b=q8wbdXEuccZrxNVGuWkyIEDrKJ5FvAELqBNydvNz/kLV1SBvOdNLHqSu2tBuaQf8LxIN4KXsVXvK6FwREJWTalpvYGQV8EKOJf2qUYMU2Wyk6u4yfaqxd7NrBFOYkei5qYP0fqXDuzBxBgrrD/FzB02Lamk4OUcXmNueCtJLK+k=
Received: from BYAPR05MB4056.namprd05.prod.outlook.com (52.135.199.33) by
 BYAPR05MB6408.namprd05.prod.outlook.com (20.178.51.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 16:39:58 +0000
Received: from BYAPR05MB4056.namprd05.prod.outlook.com
 ([fe80::95ae:b687:6dd:cbd9]) by BYAPR05MB4056.namprd05.prod.outlook.com
 ([fe80::95ae:b687:6dd:cbd9%7]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 16:39:58 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com (52.135.235.159) by
 BYAPR05MB4327.namprd05.prod.outlook.com (52.135.202.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 16:39:34 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e]) by BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 16:39:34 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH v4 2/2] cfg80211: fix duplicated scan entries after channel
 switch
Thread-Topic: [PATCH v4 2/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVQ9C0GLu1A28lFkKn47oV7U1oNQ==
Date:   Fri, 26 Jul 2019 16:39:34 +0000
Message-ID: <20190726163922.27509-3-sergey.matyukevich.os@quantenna.com>
References: <20190726163922.27509-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20190726163922.27509-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To BYAPR05MB4917.namprd05.prod.outlook.com
 (2603:10b6:a03:42::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39eecef0-de86-4bab-b15c-08d711e7d6f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4327;
x-ms-traffictypediagnostic: BYAPR05MB4327:|BYAPR05MB6408:
x-microsoft-antispam-prvs: <BYAPR05MB4327AEB29555B6F7DC34CBD8A3C00@BYAPR05MB4327.namprd05.prod.outlook.com>
x-moderation-data: 7/26/2019 4:39:56 PM
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39850400004)(396003)(346002)(189003)(199004)(6916009)(66946007)(66446008)(68736007)(66556008)(2906002)(186003)(66476007)(26005)(6506007)(386003)(8936002)(14454004)(107886003)(11346002)(86362001)(5660300002)(436003)(476003)(5640700003)(53936002)(102836004)(446003)(2616005)(36756003)(4326008)(1076003)(305945005)(7736002)(486006)(6116002)(3846002)(66066001)(103116003)(14444005)(6436002)(2501003)(54906003)(50226002)(316002)(99286004)(6486002)(81166006)(8676002)(2351001)(25786009)(71190400001)(52116002)(478600001)(71200400001)(76176011)(6512007)(64756008)(256004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6408;H:BYAPR05MB4056.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zFr7CSU9dWDXhRqcPro7Ab07kNpD+wdAEoBrkPviU2CD7UOGdO9HzSAigC9kv7KVaSw/4LtgRBr7+NpxeHaN2kp/hKrvX+cYDO5rhZ7lew9G2ymaYby/qXYZxbbpX6oTnXXxHGv2F4I5G7nSr15hlqTOS6Dh03DiW1C6QJuknpsqsIqWqxYNxcZy6Q0OoKO/rfYJJyqtlGJ0IDUfz3VYzj5SbXQuarwiWfEWOH007EvVWZ6akq+oNwdwF5fyyjKWG1BDhaZNzQjlWS3kNQMrb+7suTyaaTJwVjwMV+5NxMvk7fpFdGLz7h9aeplx4Q9eX4cFuiDz3+0JRadhJ4lqy/hfstbCB8GNTdtIfuCnMLcuR+9sX7eD9GGGmklCQfwlXV4qNDUIuC1IefnHT3amI43cxG6JtWA7A6f9XCHwLD4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eecef0-de86-4bab-b15c-08d711e7d6f8
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_4acb5e86-e93b-4c01-ae1f-712441a9c274@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 16:39:58.5572
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When associated BSS completes channel switch procedure, its channel
record needs to be updated. The existing mac80211 solution was
extended to cfg80211 in commit 5dc8cdce1d72 ("mac80211/cfg80211:
update bss channel on channel switch").

However that solution still appears to be incomplete as it may lead
to duplicated scan entries for associated BSS after channel switch.
The root cause of the problem is as follows. Each BSS entry is
included into the following data structures:
- bss list rdev->bss_list
- bss search tree rdev->bss_tree
Updating BSS channel record without rebuilding bss_tree may break
tree search since cmp_bss considers all of the following: channel,
bssid, ssid. When BSS channel is updated, but its location in bss_tree
is not updated, then subsequent search operations may fail to locate
this BSS since they will be traversing bss_tree in wrong direction.
As a result, for scan performed after associated BSS channel switch,
cfg80211_bss_update may add the second entry for the same BSS to both
bss_list and bss_tree, rather then update the existing one.

To summarize, if BSS channel needs to be updated, then bss_tree should
be rebuilt in order to put updated BSS entry into a proper location.

This commit suggests the following straightforward solution:
- if new entry has been already created for BSS after channel switch,
  then use its IEs to update known BSS entry and then remove new
  entry completely
- use rb_erase/rb_insert_bss reinstall updated BSS in bss_tree
- for nontransmit BSS entry, the whole transmit BSS hierarchy
  is updated

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 net/wireless/core.h    |  2 ++
 net/wireless/nl80211.c |  2 +-
 net/wireless/scan.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index ee8388fe4a92..77556c58d9ac 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -306,6 +306,8 @@ void ieee80211_set_bitrate_flags(struct wiphy *wiphy);
 void cfg80211_bss_expire(struct cfg80211_registered_device *rdev);
 void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
                       unsigned long age_secs);
+void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
+				     struct ieee80211_channel *channel);
=20
 /* IBSS */
 int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 10b57aa10227..a8d4b2b6b3ec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16116,7 +16116,7 @@ void cfg80211_ch_switch_notify(struct net_device *d=
ev,
=20
 	if (wdev->iftype =3D=3D NL80211_IFTYPE_STATION &&
 	    !WARN_ON(!wdev->current_bss))
-		wdev->current_bss->pub.channel =3D chandef->chan;
+		cfg80211_update_assoc_bss_entry(wdev, chandef->chan);
=20
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_NOTIFY, 0);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 9119f5ce3677..5e38f8092917 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2001,6 +2001,85 @@ void cfg80211_bss_iter(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_bss_iter);
=20
+void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
+				     struct ieee80211_channel *chan)
+{
+	struct wiphy *wiphy =3D wdev->wiphy;
+	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
+	struct cfg80211_internal_bss *cbss =3D wdev->current_bss;
+	struct cfg80211_internal_bss *new =3D NULL;
+	struct cfg80211_internal_bss *bss;
+	struct cfg80211_bss *nontrans_bss;
+	struct cfg80211_bss *tmp;
+
+	spin_lock_bh(&rdev->bss_lock);
+
+	if (WARN_ON(cbss->pub.channel =3D=3D chan))
+		goto done;
+
+	/* use transmitting bss */
+	if (cbss->pub.transmitted_bss)
+		cbss =3D container_of(cbss->pub.transmitted_bss,
+				    struct cfg80211_internal_bss,
+				    pub);
+
+	cbss->pub.channel =3D chan;
+
+	list_for_each_entry(bss, &rdev->bss_list, list) {
+		if (!cfg80211_bss_type_match(bss->pub.capability,
+					     bss->pub.channel->band,
+					     wdev->conn_bss_type))
+			continue;
+
+		if (bss =3D=3D cbss)
+			continue;
+
+		if (!cmp_bss(&bss->pub, &cbss->pub, BSS_CMP_REGULAR)) {
+			new =3D bss;
+			break;
+		}
+	}
+
+	if (new) {
+		/* to save time, update IEs for transmitting bss only */
+		if (cfg80211_update_known_bss(rdev, cbss, new, false)) {
+			new->pub.proberesp_ies =3D NULL;
+			new->pub.beacon_ies =3D NULL;
+		}
+
+		list_for_each_entry_safe(nontrans_bss, tmp,
+					 &new->pub.nontrans_list,
+					 nontrans_list) {
+			bss =3D container_of(nontrans_bss,
+					   struct cfg80211_internal_bss, pub);
+			if (__cfg80211_unlink_bss(rdev, bss))
+				rdev->bss_generation++;
+		}
+
+		WARN_ON(atomic_read(&new->hold));
+		if (!WARN_ON(!__cfg80211_unlink_bss(rdev, new)))
+			rdev->bss_generation++;
+	}
+
+	rb_erase(&cbss->rbn, &rdev->bss_tree);
+	rb_insert_bss(rdev, cbss);
+	rdev->bss_generation++;
+
+	list_for_each_entry_safe(nontrans_bss, tmp,
+				 &cbss->pub.nontrans_list,
+				 nontrans_list) {
+		bss =3D container_of(nontrans_bss,
+				   struct cfg80211_internal_bss, pub);
+		bss->pub.channel =3D chan;
+		rb_erase(&bss->rbn, &rdev->bss_tree);
+		rb_insert_bss(rdev, bss);
+		rdev->bss_generation++;
+	}
+
+done:
+	spin_unlock_bh(&rdev->bss_lock);
+}
+
 #ifdef CONFIG_CFG80211_WEXT
 static struct cfg80211_registered_device *
 cfg80211_get_dev_from_ifindex(struct net *net, int ifindex)
--=20
2.11.0

