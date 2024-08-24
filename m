Return-Path: <linux-wireless+bounces-11876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FB95DC76
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F12827FB
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25138154458;
	Sat, 24 Aug 2024 07:33:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1E2D7B8;
	Sat, 24 Aug 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484800; cv=none; b=uMK0xuJV/+oXDF3pd3wtI0cc7Tpi1PEMDblOVzinC6lHFNdMRvxdiZEJQEeltDH6ib8MicxoWmWq0pzk8mMp3hrFJmqEGXDnOAukMuQrKx9NA2CoNy4BVIX2c7bXZOYzva66j6vGV5SXQVku/qHU4BPmRJMRloXgRyRKDoZKW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484800; c=relaxed/simple;
	bh=vhj7JegrniHUVNoTBlLWxbuanhFLd38NBAGgKpKlWR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxLhbyAaMiI3L9Wwnq4FWgRWrsRIVjPia50s/BX9xdJmaOtAo3LsDo21XnqQubNA4bndC3CWH5bYr9yDNdkOGqMhtr4krVoewluh8JPZTKPUY03eIXePPxnAZpiKyPfo2N0bFn6na2Vjd4irBODlpMiXaJWvZ5a4Y0MmVcxd26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WrTDz2mT4z1S8mL;
	Sat, 24 Aug 2024 15:33:07 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EFF2D1402D0;
	Sat, 24 Aug 2024 15:33:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 15:33:13 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-afs@lists.infradead.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next 1/8] net/mac80211: use max to simplify the code
Date: Sat, 24 Aug 2024 15:40:26 +0800
Message-ID: <20240824074033.2134514-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824074033.2134514-1-lihongbo22@huawei.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The following Coccinelle/coccicheck warning reported by
minmax.cocci:
    WARNING opportunity for max()
Let's use max() to simplify the code and fix the warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/mac80211/driver-ops.h | 2 +-
 net/mac80211/mlme.c       | 2 +-
 net/mac80211/scan.c       | 6 ++----
 net/mac80211/tdls.c       | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d382d9729e85..6b75c7eeff25 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -971,7 +971,7 @@ drv_mgd_protect_tdls_discover(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
-	link_id = link_id > 0 ? link_id : 0;
+	link_id = max(link_id, 0);
 
 	trace_drv_mgd_protect_tdls_discover(local, sdata);
 	if (local->ops->mgd_protect_tdls_discover)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4779a18ab75d..60a7631f0457 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5375,7 +5375,7 @@ ieee80211_determine_our_sta_mode_auth(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_conn_settings *conn)
 {
 	ieee80211_determine_our_sta_mode(sdata, sband, NULL, wmm_used,
-					 req->link_id > 0 ? req->link_id : 0,
+					 max(req->link_id, 0),
 					 conn);
 }
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f6..e77c9f07b046 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1013,10 +1013,8 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	 */
 	if ((chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR)) ||
 	    !scan_req->n_ssids) {
-		*next_delay = msecs_to_jiffies(scan_req->duration) >
-			      IEEE80211_PASSIVE_CHANNEL_TIME ?
-			      msecs_to_jiffies(scan_req->duration) :
-			      IEEE80211_PASSIVE_CHANNEL_TIME;
+		*next_delay = max(msecs_to_jiffies(scan_req->duration),
+				  IEEE80211_PASSIVE_CHANNEL_TIME);
 		local->next_scan_state = SCAN_DECISION;
 		if (scan_req->n_ssids)
 			set_bit(SCAN_BEACON_WAIT, &local->scanning);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f07b40916485..719739def96c 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -919,7 +919,7 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 	int ret;
 	struct ieee80211_link_data *link;
 
-	link_id = link_id >= 0 ? link_id : 0;
+	link_id = max(link_id, 0);
 	rcu_read_lock();
 	link = rcu_dereference(sdata->link[link_id]);
 	if (WARN_ON(!link))
-- 
2.34.1


