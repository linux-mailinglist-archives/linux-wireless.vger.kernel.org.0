Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC6128E92
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVOzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 09:55:38 -0500
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:43758
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfLVOzi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 09:55:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuUaqqmKQdZyUBB6w32kiRX5nuOplY6kGFBKoMMD1NPxIDHaO5xBwrUMCtanBjsLzsRnCmJUjD6vUTGaUwryjua7MfGOzPjuTqxCMx/xIvzWONV6ITHClvKFjhemF8sW2O8evapvVMLiAMod4PXM+Ry36iVeuSr8tUkt2AK+erSRxZuf5iiwqzd2NRpznWMsL/KFdVc9wK545SUvKaIe4WQ5XeUJJpHcLXpLSyMqBg1rREdwe/31E861/tEEbCr0cWAHwkIsGTmdkP7byiKd79Gh42EU9FNRUcS4AWM5arXmK/bYLZXThixKPYm7AapBhkcX746Pyp+MTLNKJcqOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU2HBLV6VhDPV+K8HiNAo6QvoLPxc9edAGN39bSCs3Y=;
 b=PQvKy6ZbPoTr9F1I16YuKbri1OEIS5P2MaagaxxKXQWUGwcfmA++zB+sahjAMUnFpxEyjH2FPgqBDMMxnMqaWslaHBJ0VYvHI0DNfFvlfMcywmJSLYLaaMxTfENpLqUkgbBilB/7HdF+/tsW9OjbrmE93zy31D+VGHATs2zVWo47Fvr83KZCMgOjj3oNv35DLWqW+RAgguOrInCd+voCDGV5VywujaIXhuDukf4YIMnUiBHlbqPgZoGSaZoh0STOkysK7Q/bSxWfhcSNkF+ueuSR/9OURN3/iHX3+96kuotkG9v2ts4mCzYHz3eVgxykhpyAMeMpCXyHQA3f4lNQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU2HBLV6VhDPV+K8HiNAo6QvoLPxc9edAGN39bSCs3Y=;
 b=BkY4p+oZF25j5DOjNGzxPfrorOeuU+CKAbr/3Hx45WyIHx9z1jgXhspROmHgzCa0KCswGhA+08sWTOB90hSSDUy/ped576cYXEsJE9EALNgbuiwgiGk+K44NCi4t/b3TXvTXerS7bUZwJjFDY2UaAK7FWC1G6awFnwpHYcvQXKA=
Received: from AM0PR02MB3620.eurprd02.prod.outlook.com (52.133.63.21) by
 AM0PR02MB5572.eurprd02.prod.outlook.com (10.255.31.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Sun, 22 Dec 2019 14:55:32 +0000
Received: from AM0PR02MB3620.eurprd02.prod.outlook.com
 ([fe80::4565:4fd:e296:3ad]) by AM0PR02MB3620.eurprd02.prod.outlook.com
 ([fe80::4565:4fd:e296:3ad%6]) with mapi id 15.20.2559.017; Sun, 22 Dec 2019
 14:55:32 +0000
From:   Orr Mazor <orr.mazor@tandemg.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Orr Mazor <orr.mazor@tandemg.com>
Subject: [PATCH] subsystem: Fix radar event during another phy CAC
Thread-Topic: [PATCH] subsystem: Fix radar event during another phy CAC
Thread-Index: AQHVuNfbH206ZJg9QUmhdGm55ai8ZA==
Date:   Sun, 22 Dec 2019 14:55:31 +0000
Message-ID: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To AM0PR02MB3620.eurprd02.prod.outlook.com
 (2603:10a6:208:3f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=orr.mazor@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c72082fb-b3d8-4ce4-6e30-08d786eefde6
x-ms-traffictypediagnostic: AM0PR02MB5572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB55721FC3D513E6C9C1A275BAEF2F0@AM0PR02MB5572.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(136003)(376002)(366004)(346002)(199004)(189003)(81166006)(26005)(8936002)(6512007)(186003)(71200400001)(66946007)(2906002)(66556008)(66476007)(6486002)(64756008)(66446008)(1076003)(81156014)(8676002)(36756003)(86362001)(5660300002)(52116002)(54906003)(508600001)(6916009)(107886003)(2616005)(4326008)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5572;H:AM0PR02MB3620.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKtKPT2zrU28CcmJkJSD8/o6OvNOWbJJexote9XBFwaWiSY+kwGBurhJFa9fybDqhYXlBrVGqQfBiqrAigpk1HghKcNMOk+vMfQtjof0RZ1hWMoIv2MwgPUoHswXKB57b+9PQ+kNaGaH9zboaGDLLcyI9o7iu7Z3UN1eqEJJ942MQMIxR/2WT/8IrmhHbCTF3aFieg2UrchY35+9K4OajBSbVGgpLdJBRuPsr1zMDs0tTRQ1rqMCq82DCfJFUixze4W8VM/GAtCa1NxQpZXxAkM+Vx/wukPQekAl4NfGUblv+SDnKS1fRSPs1t9DRnrJEEdsRlser+cyvZgiHPGxI0ZMrnDnXqgmd3hJcXlJk7rwlnYnNKfXcmXdkW5ezB229f6bE0mOMkm/7YjOn6z+V2d5NKafIZJ1HNTGlHZVzm2FotJqsgncE81dEYcxJI6t
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72082fb-b3d8-4ce4-6e30-08d786eefde6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2019 14:55:32.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZIXyErTSNCCrncfxxe9buVgWYEBu4QZM2mix76mfZyiJQ5e3gM2OT8kFb0LIvJ/cTdJdOZ7AAiRSXtMD4mZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5572
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case a radar event of CAC_FINISHED or RADAR_DETECTED
happens during another phy is during CAC we might need
to cancel that CAC.
If we got a radar in a channel that another phy is now
doing CAC on then the CAC should be canceled.
If, for example, 2 phys doing CAC on the same channels,
or on comptable channels, once on of them will finish his CAC
the other might need to cancel his CAC, since it is no
longer relevant.

To fix that the commit adds an callback and implement it in mac80211
to end CAC.
This commit also adds a call to said callback if after a radar
event we see the cac is no longer relevant

Signed-off-by: Orr Mazor <Orr.Mazor@tandemg.com>
---
 include/net/cfg80211.h  |  5 +++++
 net/mac80211/cfg.c      | 23 +++++++++++++++++++++++
 net/wireless/rdev-ops.h | 10 ++++++++++
 net/wireless/reg.c      | 24 +++++++++++++++++++++++-
 net/wireless/trace.h    |  5 +++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ab2c49423dc..68782ba8b6e8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3537,6 +3537,9 @@ struct cfg80211_update_owe_info {
  *
  * @start_radar_detection: Start radar detection in the driver.
  *
+ * @end_cac: End running CAC, probably because a related CAC
+ *	was finished on another phy.
+ *
  * @update_ft_ies: Provide updated Fast BSS Transition information to the
  *	driver. If the SME is in the driver/firmware, this information can be
  *	used in building Authentication and Reassociation Request frames.
@@ -3863,6 +3866,8 @@ struct cfg80211_ops {
 					 struct net_device *dev,
 					 struct cfg80211_chan_def *chandef,
 					 u32 cac_time_ms);
+	void	(*end_cac)(struct wiphy *wiphy,
+				struct net_device *dev);
 	int	(*update_ft_ies)(struct wiphy *wiphy, struct net_device *dev,
 				 struct cfg80211_update_ft_ies_params *ftie);
 	int	(*crit_proto_start)(struct wiphy *wiphy,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 70739e746c13..0daaf7e37a21 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2954,6 +2954,28 @@ static int ieee80211_start_radar_detection(struct wi=
phy *wiphy,
 	return err;
 }
=20
+static void ieee80211_end_cac(struct wiphy *wiphy,
+			      struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local =3D sdata->local;
+
+	mutex_lock(&local->mtx);
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		/* it might be waiting for the local->mtx, but then
+		 * by the time it gets it, sdata->wdev.cac_started
+		 * will no longer be true
+		 */
+		cancel_delayed_work(&sdata->dfs_cac_timer_work);
+
+		if (sdata->wdev.cac_started) {
+			ieee80211_vif_release_channel(sdata);
+			sdata->wdev.cac_started =3D false;
+		}
+	}
+	mutex_unlock(&local->mtx);
+}
+
 static struct cfg80211_beacon_data *
 cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 {
@@ -4023,6 +4045,7 @@ const struct cfg80211_ops mac80211_config_ops =3D {
 #endif
 	.get_channel =3D ieee80211_cfg_get_channel,
 	.start_radar_detection =3D ieee80211_start_radar_detection,
+	.end_cac =3D ieee80211_end_cac,
 	.channel_switch =3D ieee80211_channel_switch,
 	.set_qos_map =3D ieee80211_set_qos_map,
 	.set_ap_chanwidth =3D ieee80211_set_ap_chanwidth,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index e853a4fe6f97..663c0d3127a4 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1167,6 +1167,16 @@ rdev_start_radar_detection(struct cfg80211_registere=
d_device *rdev,
 	return ret;
 }
=20
+static inline void
+rdev_end_cac(struct cfg80211_registered_device *rdev,
+	     struct net_device *dev)
+{
+	trace_rdev_end_cac(&rdev->wiphy, dev);
+	if (rdev->ops->end_cac)
+		rdev->ops->end_cac(&rdev->wiphy, dev);
+	trace_rdev_return_void(&rdev->wiphy);
+}
+
 static inline int
 rdev_set_mcast_rate(struct cfg80211_registered_device *rdev,
 		    struct net_device *dev,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 446c76d44e65..d18cc05061a0 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3885,6 +3885,26 @@ bool regulatory_pre_cac_allowed(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(regulatory_pre_cac_allowed);
=20
+static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *=
rdev)
+{
+	struct wireless_dev *wdev;
+	/* If we finished CAC or received radar, we should end any
+	 * CAC running on the same channels.
+	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
+	 * either all channels are available - those the CAC_FINISHED
+	 * event has effected another wdev state, or there is a channel
+	 * in unavailable state in wdev chandef - those the RADAR_DETECTED
+	 * event has effected another wdev state.
+	 * In both cases we should end the CAC on the wdev.
+	 *
+	 */
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		if (wdev->cac_started &&
+		    !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev->chandef))
+			rdev_end_cac(rdev, wdev->netdev);
+	}
+}
+
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 				    struct cfg80211_chan_def *chandef,
 				    enum nl80211_dfs_state dfs_state,
@@ -3911,8 +3931,10 @@ void regulatory_propagate_dfs_state(struct wiphy *wi=
phy,
 		cfg80211_set_dfs_state(&rdev->wiphy, chandef, dfs_state);
=20
 		if (event =3D=3D NL80211_RADAR_DETECTED ||
-		    event =3D=3D NL80211_RADAR_CAC_FINISHED)
+		    event =3D=3D NL80211_RADAR_CAC_FINISHED) {
 			cfg80211_sched_dfs_chan_update(rdev);
+			cfg80211_check_and_end_cac(rdev);
+		}
=20
 		nl80211_radar_notify(rdev, chandef, event, NULL, GFP_KERNEL);
 	}
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index d98ad2b3143b..8677d7ab7d69 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -646,6 +646,11 @@ DEFINE_EVENT(wiphy_netdev_evt, rdev_flush_pmksa,
 	TP_ARGS(wiphy, netdev)
 );
=20
+DEFINE_EVENT(wiphy_netdev_evt, rdev_end_cac,
+	     TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
+	     TP_ARGS(wiphy, netdev)
+);
+
 DECLARE_EVENT_CLASS(station_add_change,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 *mac,
 		 struct station_parameters *params),
--=20
2.17.1

