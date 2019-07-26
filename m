Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D176676F37
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfGZQlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 12:41:47 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:45840 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727343AbfGZQlq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 12:41:46 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QGe2Cb007061;
        Fri, 26 Jul 2019 10:40:02 -0600
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tywkqrwj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 10:40:02 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1oFd1QBnAC4h9te+8fsbGycqEjzJz4LfsDsDzHpAbcDwNLuhwuzclJ/2ia5tpCE9U2e+OORkrLAsqWLGWVnLCgZJv9F58929jwL08p0Lze2hP3ALMC+RQZPGT8VtIqHramfQDy9WWsrYXSgTsz5kuU7AW/SPo7imWSMUwscEmkEDxhBGdWlGVIsUzBySMQWcjVNL537Aqp/IsrVkjTjIcHqZnKpg1fVB0pZiMpWytq7Buzv1x994nJqcebZ9rXMVeQlSKKoMeQHaKUtA6UGtdvCUjlYzOCKptv8fgwADUitZ8dyRkG9qM0iP+sZyy8uCB6+hbjRIlEoFNC/XCxUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCqhU2B+pNM5h8DdqOZ2JeOJdTopWQ2Hsj/cFiao3mA=;
 b=BOws8r4j3q+3dEElBZ+FfLZq86D06K0lMzAx3WxtzEsijx4BbWtQtBvpwua+II278KxhBs/WVwTg6vPUoZknBTy0lzZwFGyv0NzqQr6ciku/O+jzNQpGlXprxxqXnEOExJD02fqUpi5MoQZT2C7OhoNm5mNpA1oF16ZItvrYKl7Hp9CMQ0t+WXW/Y/66XugxsdVlX2tu5gNSAO/2hLxDVhZD+P56U5dzkKtPe6d52mXUgnxnl5WiqbuRqIIS5Zt0tX6zWdhMnxwp8dVZ2ZkBsVteYD7pL1zVMLaDwU+GDtM9tJOchm2kHzV4Z9xZcoAjcW4fl/3Q1WR+SkIWF0kmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCqhU2B+pNM5h8DdqOZ2JeOJdTopWQ2Hsj/cFiao3mA=;
 b=N7s/nM98VlQMesO0zuXbqihQZ8bvY2Slc0TzV/UoxYTW55i+H2xF9qhmveuBYPsy6lTneLMsZ89HRjhreGZNdn9eq94y9kCt9l2XRlgbEM5Ds1J51RlK/A5RlII7ErYQhEoX+EM7k3Q5pTeP+Z0g/291RAgmAv3cDFIr9YgvSW0=
Received: from SN6PR05MB4703.namprd05.prod.outlook.com (52.135.114.213) by
 SN6PR05MB4959.namprd05.prod.outlook.com (20.177.249.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.9; Fri, 26 Jul 2019 16:40:00 +0000
Received: from SN6PR05MB4703.namprd05.prod.outlook.com
 ([fe80::78b3:7cea:d0b6:d11]) by SN6PR05MB4703.namprd05.prod.outlook.com
 ([fe80::78b3:7cea:d0b6:d11%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 16:40:00 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com (52.135.235.159) by
 BYAPR05MB4327.namprd05.prod.outlook.com (52.135.202.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 16:39:32 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e]) by BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 16:39:32 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH v4 1/2] cfg80211: refactor cfg80211_bss_update
Thread-Topic: [PATCH v4 1/2] cfg80211: refactor cfg80211_bss_update
Thread-Index: AQHVQ9CzMkyU2IXzSEuwiE76ToNQiw==
Date:   Fri, 26 Jul 2019 16:39:32 +0000
Message-ID: <20190726163922.27509-2-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 57199ce3-c55c-4f9d-847c-08d711e7d5c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4327;
x-ms-traffictypediagnostic: BYAPR05MB4327:|SN6PR05MB4959:
x-microsoft-antispam-prvs: <BYAPR05MB4327BC649A26F0DA1B2BFAFDA3C00@BYAPR05MB4327.namprd05.prod.outlook.com>
x-moderation-data: 7/26/2019 4:39:58 PM
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39850400004)(189003)(199004)(6506007)(6436002)(2501003)(5640700003)(53936002)(386003)(107886003)(6512007)(102836004)(2906002)(99286004)(7736002)(86362001)(2616005)(71190400001)(4326008)(6916009)(186003)(6116002)(66066001)(25786009)(478600001)(14454004)(3846002)(103116003)(316002)(76176011)(54906003)(5660300002)(26005)(8936002)(1076003)(36756003)(50226002)(8676002)(66446008)(81166006)(66476007)(81156014)(68736007)(66556008)(64756008)(2351001)(476003)(71200400001)(446003)(436003)(66946007)(11346002)(52116002)(14444005)(486006)(305945005)(6486002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4959;H:SN6PR05MB4703.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hhl9YemNdSCFb22+TqSmpBzVwN1b3yIcYNNmwFQamQFKmhBoMZmDZ7Ed7kBu0vulbTTR/OqUvROJUEX234PLLCs5IUMvK+g1T50vhJbnUJIB9ryIMHoEUKILThLkqpCLlqeCXJSXf01NMeA0lJYkmEFfCSu6/1+A7o7JjQz4sEqYSke7Y9VjOn1MtztlO/suyQeY45N/f6TbwXXAXo+gV8UahN+TA8n8V+k5qHW5BIfyFy+egVGEsJaOzfMbdO3XYb/DgNo7bpqJcLekTQWRHMph5HOTS7Gxy4VkDr6NGOhTo8LYDbBtHRl/gVco5D5pbm/OMOEqp8eSiwRosS9H4CBybGu/ONQfghyPqBY3NM6XhaLuLf9ofpDFwaXxphTwKqnU460Q8Qc5++2IpChdpAzAqCknjrwTb/QTY+GZ9+w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57199ce3-c55c-4f9d-847c-08d711e7d5c9
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_d3241082-88d9-4157-85a8-5a9c8795aa9d@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 16:40:00.1739
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4959
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260203
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
index a98dabab557a..9119f5ce3677 100644
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

