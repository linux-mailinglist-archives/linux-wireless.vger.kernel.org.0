Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4477A64BE8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 20:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGJSK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jul 2019 14:10:56 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:24254 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727193AbfGJSKz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jul 2019 14:10:55 -0400
X-Greylist: delayed 1987 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 14:10:54 EDT
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AHa78q030265;
        Wed, 10 Jul 2019 11:37:41 -0600
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0a-00183b01.pphosted.com with ESMTP id 2tnhmy8f5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Jul 2019 11:37:41 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyyC/Y7B8rX2GY/rjQWam5gwizh9HeOxEmEbAVLp8jDS3LHDO02hBYPowNRTsEypUW/Qm4Wqn7EGNbHt2IYynXhe/f0aXkNI5UkPMNYFzKVySVAtkQ6KirRNOfdz+FdLn+B8GfV+JuUjbSiuQH6MiAYb7xuO6XVHLepRpgLQhY7v3KqtJo+CpazgobbilqxyUZWTuSYftTI7P6wzJQgdqrFGVwXJfunnfa1nrrNCR+/bOOlUJn5MCHraF+loPwJLRZhsZv7TZNhWsHrmfCiXgSR+Cj8WST2RT/W9Wc9OWu5FIEwYiSDIpv2PORIM7zQYNRWxTsCCeT30a+In2MWjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crcaJrwB69uZ+h0VncsQVmMCkx1ycPBis7K0y8HUYc8=;
 b=gDNy+GKpcH2aFuuP6XxZO1YAG+Nm3mIbEYYsBqTO5L85ntODpXhr3Gr96uzHKx7Xs9dh01VL7OsUhHSx+m0C604Umb6mwfxusx7Wqvq6wZszjpy+asM2YYF1Tnk8beSdq2Ae2Tcbx7KQpIwnY/ubpXrVdiEeylCCXtza/3qJ3TU3tIpD3o7tsQVHvZgrVYcIaoZxXXTaMISNkLRbXqbXb57KvFT0dtVDqz7KY9gFvU6b4zIL6uLun5hJp6dnqa+VwiNJiM45zqw4lizOKJ5aZT6oaabn/kNr9qiF9PI/wUmA4ohL+tQgHSAYT4Bg6Wjn6wuEt7bNcm25BjJYemwyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crcaJrwB69uZ+h0VncsQVmMCkx1ycPBis7K0y8HUYc8=;
 b=bn5/+xmB9SGIUZzs9JGIZSYAKtI++PZSRLfoAb6UfuDW8SJUMcz7dQnTyxveZ+Xj/tDSk8BYG95CraNNgCqYou1wJX1TaU0EkmbwzuGy2/SUPaunGLzsdQMyLmRIFzP16Y2wkRD9qY6TKZXEqxKoncRlQ0B1ICxaqbffmmyvKaE=
Received: from DM6PR05MB5273.namprd05.prod.outlook.com (20.177.223.225) by
 DM6PR05MB4505.namprd05.prod.outlook.com (20.176.78.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 17:37:40 +0000
Received: from DM6PR05MB5273.namprd05.prod.outlook.com
 ([fe80::d571:4322:69c3:86e7]) by DM6PR05MB5273.namprd05.prod.outlook.com
 ([fe80::d571:4322:69c3:86e7%7]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 17:37:40 +0000
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
Subject: [RFC PATCH v3 1/2] cfg80211: refactor cfg80211_bss_update
Thread-Topic: [RFC PATCH v3 1/2] cfg80211: refactor cfg80211_bss_update
Thread-Index: AQHVN0YUhHXBofQCAUidYlGg48NfoA==
Date:   Wed, 10 Jul 2019 17:37:01 +0000
Message-ID: <20190710173651.15770-2-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: a0a4892f-9b5d-4fed-08ba-08d7055d36fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB5200;
x-ms-traffictypediagnostic: SN6PR05MB5200:|DM6PR05MB4505:
x-microsoft-antispam-prvs: <SN6PR05MB5200BF6E53741DE432D46D83A3F00@SN6PR05MB5200.namprd05.prod.outlook.com>
x-moderation-data: 7/10/2019 5:37:38 PM
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(376002)(346002)(39850400004)(396003)(189003)(199004)(66476007)(1076003)(66946007)(52116002)(64756008)(2351001)(66446008)(66556008)(14454004)(53936002)(66066001)(6506007)(6436002)(71190400001)(71200400001)(2501003)(6916009)(5660300002)(386003)(102836004)(68736007)(25786009)(5640700003)(86362001)(6512007)(3846002)(81166006)(316002)(2616005)(36756003)(11346002)(14444005)(256004)(436003)(8936002)(103116003)(26005)(50226002)(478600001)(2906002)(446003)(8676002)(4326008)(76176011)(6486002)(476003)(305945005)(54906003)(6116002)(7736002)(99286004)(81156014)(486006)(107886003)(6666004)(186003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4505;H:DM6PR05MB5273.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: efWtM0zOgaJnzv5YkxMr+pcHJLQcWavkCzGZtab+bo1Kk55Iz0EhSNrDjDydMecl51WZPZvwQhvWJB6bUcYWpi7Jsqss3Ty1AdKKgaj2KyMnPYEvYbgxv1LkfszS5OLjip3xfPGJ3WEFCMdGjXexHUffc3P2uiTnUJUzLxS1KOMIfZbahOJsnHszSF4R9cFXloc4j1lAHDXQxQEFSy/k6E8CYKeA3fY6l0wWshqw0MsCXuVo60XJ3HHAB2e61zx6VELojqBox5ZXPSlEA9ijuk5BkrnT/m2qtM7T0BS4ej/E0eGzsOLCSrL7tjtcvc8AmcjTBBYuZUYLp40TM9n/4yqsqljtd6NgUVrdIh+VWZKjsJay3z79OV1JzepZGOEeHT78xrCMXsvlfq1zLeJBP9VjEbbTYC96zMrmgJgs1+o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a4892f-9b5d-4fed-08ba-08d7055d36fc
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SecureScore_8b3391f4-af01-4ee8-b4ea-9871b2499735@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 17:37:40.1650
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4505
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=974 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907100198
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch implements minor refactoring for cfg80211_bss_update function.
Code path for updating known BSS is extracted into dedicated
cfg80211_update_known_bss function.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 net/wireless/scan.c | 171 +++++++++++++++++++++++++++---------------------=
----
 1 file changed, 89 insertions(+), 82 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d66e6d4b7555..9f21162f05e9 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1091,6 +1091,93 @@ struct cfg80211_non_tx_bss {
 	u8 bssid_index;
 };
=20
+static bool
+cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
+			  struct cfg80211_internal_bss *known,
+			  struct cfg80211_internal_bss *new,
+			  bool signal_valid)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	/* Update IEs */
+	if (rcu_access_pointer(new->pub.proberesp_ies)) {
+		const struct cfg80211_bss_ies *old;
+
+		old =3D rcu_access_pointer(known->pub.proberesp_ies);
+
+		rcu_assign_pointer(known->pub.proberesp_ies,
+				   new->pub.proberesp_ies);
+		/* Override possible earlier Beacon frame IEs */
+		rcu_assign_pointer(known->pub.ies,
+				   new->pub.proberesp_ies);
+		if (old)
+			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
+	} else if (rcu_access_pointer(new->pub.beacon_ies)) {
+		const struct cfg80211_bss_ies *old;
+		struct cfg80211_internal_bss *bss;
+
+		if (known->pub.hidden_beacon_bss &&
+		    !list_empty(&known->hidden_list)) {
+			const struct cfg80211_bss_ies *f;
+
+			/* The known BSS struct is one of the probe
+			 * response members of a group, but we're
+			 * receiving a beacon (beacon_ies in the new
+			 * bss is used). This can only mean that the
+			 * AP changed its beacon from not having an
+			 * SSID to showing it, which is confusing so
+			 * drop this information.
+			 */
+
+			f =3D rcu_access_pointer(new->pub.beacon_ies);
+			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			return false;
+		}
+
+		old =3D rcu_access_pointer(known->pub.beacon_ies);
+
+		rcu_assign_pointer(known->pub.beacon_ies, new->pub.beacon_ies);
+
+		/* Override IEs if they were from a beacon before */
+		if (old =3D=3D rcu_access_pointer(known->pub.ies))
+			rcu_assign_pointer(known->pub.ies, new->pub.beacon_ies);
+
+		/* Assign beacon IEs to all sub entries */
+		list_for_each_entry(bss, &known->hidden_list, hidden_list) {
+			const struct cfg80211_bss_ies *ies;
+
+			ies =3D rcu_access_pointer(bss->pub.beacon_ies);
+			WARN_ON(ies !=3D old);
+
+			rcu_assign_pointer(bss->pub.beacon_ies,
+					   new->pub.beacon_ies);
+		}
+
+		if (old)
+			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
+	}
+
+	known->pub.beacon_interval =3D new->pub.beacon_interval;
+
+	/* don't update the signal if beacon was heard on
+	 * adjacent channel.
+	 */
+	if (signal_valid)
+		known->pub.signal =3D new->pub.signal;
+	known->pub.capability =3D new->pub.capability;
+	known->ts =3D new->ts;
+	known->ts_boottime =3D new->ts_boottime;
+	known->parent_tsf =3D new->parent_tsf;
+	known->pub.chains =3D new->pub.chains;
+	memcpy(known->pub.chain_signal, new->pub.chain_signal,
+	       IEEE80211_MAX_CHAINS);
+	ether_addr_copy(known->parent_bssid, new->parent_bssid);
+	known->pub.max_bssid_indicator =3D new->pub.max_bssid_indicator;
+	known->pub.bssid_index =3D new->pub.bssid_index;
+
+	return true;
+}
+
 /* Returned bss is reference counted and must be cleaned up appropriately.=
 */
 struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
@@ -1114,88 +1201,8 @@ cfg80211_bss_update(struct cfg80211_registered_devic=
e *rdev,
 	found =3D rb_find_bss(rdev, tmp, BSS_CMP_REGULAR);
=20
 	if (found) {
-		/* Update IEs */
-		if (rcu_access_pointer(tmp->pub.proberesp_ies)) {
-			const struct cfg80211_bss_ies *old;
-
-			old =3D rcu_access_pointer(found->pub.proberesp_ies);
-
-			rcu_assign_pointer(found->pub.proberesp_ies,
-					   tmp->pub.proberesp_ies);
-			/* Override possible earlier Beacon frame IEs */
-			rcu_assign_pointer(found->pub.ies,
-					   tmp->pub.proberesp_ies);
-			if (old)
-				kfree_rcu((struct cfg80211_bss_ies *)old,
-					  rcu_head);
-		} else if (rcu_access_pointer(tmp->pub.beacon_ies)) {
-			const struct cfg80211_bss_ies *old;
-			struct cfg80211_internal_bss *bss;
-
-			if (found->pub.hidden_beacon_bss &&
-			    !list_empty(&found->hidden_list)) {
-				const struct cfg80211_bss_ies *f;
-
-				/*
-				 * The found BSS struct is one of the probe
-				 * response members of a group, but we're
-				 * receiving a beacon (beacon_ies in the tmp
-				 * bss is used). This can only mean that the
-				 * AP changed its beacon from not having an
-				 * SSID to showing it, which is confusing so
-				 * drop this information.
-				 */
-
-				f =3D rcu_access_pointer(tmp->pub.beacon_ies);
-				kfree_rcu((struct cfg80211_bss_ies *)f,
-					  rcu_head);
-				goto drop;
-			}
-
-			old =3D rcu_access_pointer(found->pub.beacon_ies);
-
-			rcu_assign_pointer(found->pub.beacon_ies,
-					   tmp->pub.beacon_ies);
-
-			/* Override IEs if they were from a beacon before */
-			if (old =3D=3D rcu_access_pointer(found->pub.ies))
-				rcu_assign_pointer(found->pub.ies,
-						   tmp->pub.beacon_ies);
-
-			/* Assign beacon IEs to all sub entries */
-			list_for_each_entry(bss, &found->hidden_list,
-					    hidden_list) {
-				const struct cfg80211_bss_ies *ies;
-
-				ies =3D rcu_access_pointer(bss->pub.beacon_ies);
-				WARN_ON(ies !=3D old);
-
-				rcu_assign_pointer(bss->pub.beacon_ies,
-						   tmp->pub.beacon_ies);
-			}
-
-			if (old)
-				kfree_rcu((struct cfg80211_bss_ies *)old,
-					  rcu_head);
-		}
-
-		found->pub.beacon_interval =3D tmp->pub.beacon_interval;
-		/*
-		 * don't update the signal if beacon was heard on
-		 * adjacent channel.
-		 */
-		if (signal_valid)
-			found->pub.signal =3D tmp->pub.signal;
-		found->pub.capability =3D tmp->pub.capability;
-		found->ts =3D tmp->ts;
-		found->ts_boottime =3D tmp->ts_boottime;
-		found->parent_tsf =3D tmp->parent_tsf;
-		found->pub.chains =3D tmp->pub.chains;
-		memcpy(found->pub.chain_signal, tmp->pub.chain_signal,
-		       IEEE80211_MAX_CHAINS);
-		ether_addr_copy(found->parent_bssid, tmp->parent_bssid);
-		found->pub.max_bssid_indicator =3D tmp->pub.max_bssid_indicator;
-		found->pub.bssid_index =3D tmp->pub.bssid_index;
+		if (!cfg80211_update_known_bss(rdev, found, tmp, signal_valid))
+			goto drop;
 	} else {
 		struct cfg80211_internal_bss *new;
 		struct cfg80211_internal_bss *hidden;
--=20
2.11.0

