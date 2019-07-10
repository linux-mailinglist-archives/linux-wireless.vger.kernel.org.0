Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7264B8C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfGJRjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jul 2019 13:39:21 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:51788 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbfGJRjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jul 2019 13:39:21 -0400
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AHWWJw023717;
        Wed, 10 Jul 2019 11:37:36 -0600
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tnck410h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jul 2019 11:37:36 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeRYOdNbJv9yv85NMGNdIMf/sucd1MRnAK/b+7iDCuQ///wov4LtdfqgVndSIW2/npLx3HjRUuJRKylCYil/lFhJ7IsB1TU699T6PyfEgndhmotmin37N3NTJIXJF0jfLmeZ8FSRSm/BZXGwIyU6J3shcwyjK0B80fIfIk5BeNfk9wSyGw5D5T+rCEYlMqy4YQUA4KWHwRBvUD6ILoDmaKujI8gU41WhvkS3C9XWQ6PTDRB8xWIy0Y1cmAJJO+yztLb9rMxSipfQlzK8aNW8vpgKSc06yN9eFqW1mBRsLukzYVybYSpQzrSRxpOr7UKfq0Np9BmiksOb/QXpqkgY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ubs+/W26U+is2yUlzCPUBN8kl+9QVqYmoNo/WH9Aas=;
 b=BcxthykLflXcCBN0gzDvGKHjvXFsF5cJe0KjP/BTqf7mEy3PftVGnP05aYjy4GnZyZu2vl7ACfsi1JF536T/rQTqqZtS6ibcxaxnDgpyRJEkff6SESvWzXZGUXrvI2A3jgKeIqLW1OghEg6PZM3rUGdpT/gDKMdOLD/h3qrvfapaEqgjnRC7JoJsPQFEmB9AbNAPlSseHFXrzMUKZf5Mo8Ged/ivJjHYYMuo7VeTS5J+RLp+szLV/UezRlEKRmUcoWkV7AiFsmKTqbpqKV0Eots3Vk0oEfVFXYK7Nfiz5mW1lJrcBB6adEPXQc+K0LfjGoh2iTBLbukJEjo0UBjFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ubs+/W26U+is2yUlzCPUBN8kl+9QVqYmoNo/WH9Aas=;
 b=J2SRHsy3mCxXk8G4eK6Cc0tNr+LkUKF6weXadUDb5IsfXfSRaUOXDTAf/u+22cnyXPBNSQK3Ka48SFpNZbgVSYfaWVZJyB0xsGi5e2hE4SkLs+Q8DjZDKvn8sA3hAMqJLAV/65j7Nv92cVIbjOrPbqHn20XUN1r1vnLgi38PMMg=
Received: from BN7PR05MB4163.namprd05.prod.outlook.com (52.132.220.23) by
 BN7PR05MB4355.namprd05.prod.outlook.com (52.133.223.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 17:37:34 +0000
Received: from BN7PR05MB4163.namprd05.prod.outlook.com
 ([fe80::f8f6:ad25:294d:f733]) by BN7PR05MB4163.namprd05.prod.outlook.com
 ([fe80::f8f6:ad25:294d:f733%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 17:37:34 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5200.namprd05.prod.outlook.com (20.177.251.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 17:37:04 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 17:37:04 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v3 2/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Topic: [RFC PATCH v3 2/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVN0YVdcoRktgdq0CETrSEqiQijg==
Date:   Wed, 10 Jul 2019 17:37:03 +0000
Message-ID: <20190710173651.15770-3-sergey.matyukevich.os@quantenna.com>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63f3c147-2e99-44c8-9777-08d7055d3845
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB5200;
x-ms-traffictypediagnostic: SN6PR05MB5200:|BN7PR05MB4355:
x-microsoft-antispam-prvs: <SN6PR05MB5200725D26678D9642FF66F3A3F00@SN6PR05MB5200.namprd05.prod.outlook.com>
x-moderation-data: 7/10/2019 5:37:31 PM
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39840400004)(366004)(346002)(189003)(199004)(478600001)(8676002)(436003)(14454004)(8936002)(81166006)(81156014)(6116002)(6436002)(25786009)(3846002)(76176011)(5640700003)(386003)(6506007)(102836004)(26005)(14444005)(256004)(50226002)(186003)(7736002)(305945005)(5024004)(1076003)(2501003)(486006)(86362001)(99286004)(52116002)(6916009)(11346002)(446003)(4326008)(6486002)(2616005)(476003)(71200400001)(36756003)(66066001)(53936002)(107886003)(6512007)(103116003)(5660300002)(2351001)(54906003)(316002)(68736007)(2906002)(66446008)(66476007)(66556008)(64756008)(71190400001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4355;H:BN7PR05MB4163.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VYu/g7ZdHkD+v261zczoQd55r/huSUmO0NTr9ZiSZ6BEGpj2nGxwq4yoQqmAxVJ68Aq7py6qG6+xDeH+m4uIkak9s6tFXp8NroPDX/VsbhLEaiUPQdSborFBAGXoqLjdNPLsbtcme+g5wzHe1bitVaEWRSZC43DVGJMvY3t/Z9yxJQv2CaZI/XVtPP3CFrqapm8UzcbJbWqfHAFmtboL8Y72H04568T9yvQGFQWOgLZ4i/S6Bo708EQ3E60amzp7gxS39FeDZYntRgHLhrBQf+aCJGA/ZRrbfE/FgSlSJ3FZU80ZTRuk4AHrt1eBUuj4Zg8k3663lLno3/sitJHUANjw9UGTCY7PeCeCAm6trk13aGQSED6jNFP+zZcUl+kn4ulLyB9SA1xUkb8h0JDIdL0RJNBYLaIHpEEpUNL5pnk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f3c147-2e99-44c8-9777-08d7055d3845
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_b1a04bc5-0a1e-4230-9ecb-d0ac830b24f0@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 17:37:34.4774
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4355
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907100198
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When associated BSS completes channel switch procedure, its channel record
needs to be updated. The existing mac80211 solution was extended to
cfg80211 in commit 5dc8cdce1d72 ("mac80211/cfg80211: update bss
channel on channel switch")

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
- update channel and location in rb-tree for non-transmitting bss entries

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---

Cover email is not attached to patchwork, so duplicate it here as well...

Suggested approach to handle non-transmitting BSS entries is simplified in =
the
following sense. If new entries have been already created after channel swi=
tch,
only transmitting bss will be updated using IEs of new entry for the same
transmitting bss. Non-transmitting bss entries will be updated as soon as
new mgmt frames are received. Updating non-transmitting bss entries seems
too expensive: nested nontrans_list traversing is needed since we can not
rely on the same order of old and new non-transmitting entries.

Basic use-case tested using both iwlwifi and qtnfmac. However multi-BSSID
support has not yet been tested.=20

v1 -> v2
- use IEs of new BSS entry to update known BSS entry
  for this purpose extract BSS update code from cfg80211_bss_update
  into a separate function cfg80211_update_known_bss

v2 -> v3
- minor cleanup according to review comments
- split cfg80211_update_known_bss function into a separate patch
- update channel and location in rb-tree for nontransmit bss entries


Regards,
Sergey

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
index fc83dd179c1a..6ebb427883d0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16092,7 +16092,7 @@ void cfg80211_ch_switch_notify(struct net_device *d=
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
index 9f21162f05e9..30932b955ebc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2002,6 +2002,85 @@ void cfg80211_bss_iter(struct wiphy *wiphy,
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
+		/* to save time, update IEs for trasmitted bss only */
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

