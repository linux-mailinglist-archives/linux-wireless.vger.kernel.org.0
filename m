Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32595E3FD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCMaz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 08:30:55 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:44014 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbfGCMaz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 08:30:55 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63COWAD029407;
        Wed, 3 Jul 2019 06:29:08 -0600
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tgujt83dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 06:29:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY1MIX/UvT3WfDnWWfD2UX+Gk8i+CK6NplhykMZLtmw=;
 b=pwnKIaosjlVIoWoGLmC0Zla/mw8WjHkWFt/QlWsCB3Jo/+vZ6yoFNVOwcctOx/WKOEK/Dpgii7m6XV//CpFMcv8AIPEaJRK9DnDixNlzh9QcuHxRBQoPMUdxDrdfL+gjLMP31rDMhMAbZsmqIJHpaZr9ODgYhoDicMPysA2LjaE=
Received: from MWHPR05MB2896.namprd05.prod.outlook.com (10.168.248.148) by
 MWHPR05MB3005.namprd05.prod.outlook.com (10.168.248.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Wed, 3 Jul 2019 12:29:06 +0000
Received: from MWHPR05MB2896.namprd05.prod.outlook.com
 ([fe80::a8a5:6e5a:1f61:e2e7]) by MWHPR05MB2896.namprd05.prod.outlook.com
 ([fe80::a8a5:6e5a:1f61:e2e7%10]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 12:29:06 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4270.namprd05.prod.outlook.com (52.135.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.9; Wed, 3 Jul 2019 12:28:38 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 12:28:38 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2] cfg80211: fix duplicated scan entries after channel
 switch
Thread-Topic: [RFC PATCH v2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVMZrX98riRwU3GU2cw48EcRYVmw==
Date:   Wed, 3 Jul 2019 12:28:38 +0000
Message-ID: <20190703122829.2454-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95b7909a-41d2-457e-0daf-08d6ffb1f947
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB4270;
x-ms-traffictypediagnostic: SN6PR05MB4270:|MWHPR05MB3005:
x-microsoft-antispam-prvs: <SN6PR05MB42704FF0D07576451D535A1CA3FB0@SN6PR05MB4270.namprd05.prod.outlook.com>
x-moderation-data: 7/3/2019 12:29:03 PM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39850400004)(376002)(396003)(189003)(199004)(8676002)(81166006)(386003)(52116002)(6506007)(86362001)(102836004)(186003)(8936002)(14454004)(2501003)(305945005)(436003)(2351001)(1076003)(476003)(6916009)(2616005)(14444005)(256004)(486006)(2906002)(26005)(7736002)(81156014)(25786009)(66946007)(5660300002)(103116003)(71190400001)(6486002)(71200400001)(3846002)(4326008)(6436002)(316002)(68736007)(6512007)(50226002)(66066001)(54906003)(99286004)(6116002)(107886003)(53936002)(66446008)(66556008)(36756003)(64756008)(30864003)(73956011)(66476007)(478600001)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3005;H:MWHPR05MB2896.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5olyY4dMFyk2qjCDwcaZp+A7TKnV00FadWNdHbqTsewcUZS0+s1WGaKbPZ8fhH/iBwgRo0pnZdiPQt+q+CUwAkmhnGhj9blkQDdHqt3WpOeiFH3MpoaBfPCbuHCyetMP65abCJ7cr1lEQCI6m4aiyv2/oRVrCCe/J7cSiNMHXbneSu8hAbiLAAIixYuLkaQGnrweJAB5VkUH6nRQxWMyfRfUL6nkustkiMU8r/w1aL7yDBFYdJV/QC8NqhwCVfZqlbcVhZKM26n6it/7pVdHK2d6z6mZ1F+elMY/9tjumvcp6qBb12Lpkf+6AUnLBO8wIDhNIaPgRznDb+f8r91HYiTj0EMwM6B59A6rtzFEH7z4buZMhJ6YEoPFZFM/UDQkKki+fTOwgTdoJENxkgY3hJgG1IlgzWwRoGnPAX+2hBg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b7909a-41d2-457e-0daf-08d6ffb1f947
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_8a0a54e2-d484-4cdc-abea-5ecd3275d945@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 12:29:06.5690
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3005
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When associated BSS completes channel switch procedure, its channel
record needs to be updated. The existing mac80211 solution was
extended to cfg80211 in commit 5dc8cdce1d72 ("mac80211/cfg80211:
update bss channel on channel switch")

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
this BSS. As a result, for scan performed after associated BSS channel
switch, cfg80211_bss_update may add the second entry for the same BSS
to both bss_list and bss_tree, rather then update the existing one.

To summarize, if BSS channel needs to be updated, then bss_tree should
be rebuilt in order to put updated BSS entry into a proper location.

This commit suggests the following straightforward solution:
- if new entry has been already created for BSS after channel switch,
  then use its IEs to update known BSS entry and then remove new
  entry completely
- use rb_erase/rb_insert_bss reinstall updated BSS in bss_tree

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

---

v1 -> v2
- use IEs of new BSS entry to update known BSS entry
  for this purpose extract BSS update code from cfg80211_bss_update
  into a separate function cfg80211_update_known_bss

Tested on both iwlwifi and qtnfmac.

From my perspective, primary reason for RFC tag is nontrans_list bss handli=
ng.
I am not sure whether nontrans_bss should be removed for new entry or not.
The approach varies between cfg80211 API functions. For instance,
cfg80211_unlink_bss removes them, while cfg80211_bss_expire does not.
I would appreciate any comments in this regard.

Regards,
Sergey

---
 net/wireless/core.h    |   2 +
 net/wireless/nl80211.c |   5 +-
 net/wireless/scan.c    | 221 +++++++++++++++++++++++++++++++--------------=
----
 3 files changed, 144 insertions(+), 84 deletions(-)

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
index fc83dd179c1a..9bc4999a8c59 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16091,8 +16091,9 @@ void cfg80211_ch_switch_notify(struct net_device *d=
ev,
 	wdev->preset_chandef =3D *chandef;
=20
 	if (wdev->iftype =3D=3D NL80211_IFTYPE_STATION &&
-	    !WARN_ON(!wdev->current_bss))
-		wdev->current_bss->pub.channel =3D chandef->chan;
+	    !WARN_ON(!wdev->current_bss)) {
+		cfg80211_update_assoc_bss_entry(wdev, chandef->chan);
+	}
=20
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_NOTIFY, 0);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d66e6d4b7555..53c07f69365d 100644
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
@@ -1995,6 +2002,56 @@ void cfg80211_bss_iter(struct wiphy *wiphy,
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
+
+	spin_lock_bh(&rdev->bss_lock);
+
+	if (WARN_ON(cbss->pub.channel =3D=3D chan))
+		goto done;
+
+	cbss->pub.channel =3D chan;
+	cbss->ts =3D jiffies;
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
+		if (cfg80211_update_known_bss(rdev, cbss, new, false)) {
+			new->pub.proberesp_ies =3D NULL;
+			new->pub.beacon_ies =3D NULL;
+		}
+
+		WARN_ON(atomic_read(&new->hold));
+		WARN_ON(!__cfg80211_unlink_bss(rdev, new));
+	}
+
+	rb_erase(&cbss->rbn, &rdev->bss_tree);
+	rb_insert_bss(rdev, cbss);
+	rdev->bss_generation++;
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

