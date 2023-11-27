Return-Path: <linux-wireless+bounces-98-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB47F9E8B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 12:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167E4B21006
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F14199D2;
	Mon, 27 Nov 2023 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Vfthra3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408810A
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 03:27:04 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab88:0:640:49ea:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTP id 50207608ED;
	Mon, 27 Nov 2023 14:27:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1RRSaHnOhOs0-zce0bGwO;
	Mon, 27 Nov 2023 14:27:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701084421; bh=qELbiInsN4WxE85PKkK627AADht/WKnH06zeJrsWQxQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Vfthra3sdih2AAThY8sCRKAig0ssB+1rlTeTbbnztkULyhOLytDssjpkrwvCKqCLn
	 99zHph97s88rbljWqZBBk6EQ9x8jORwS5iDMLI4hCGoAjP+Tz0iNuUUQyoUaRszTnf
	 oi6me2Q/upKM1peMb3/c7YisIEdYcnVZmtciuIFo=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mac80211: use __counted_by for the rest of flexible array members
Date: Mon, 27 Nov 2023 14:25:49 +0300
Message-ID: <20231127112601.42636-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following commit 9118796dfa67 ("wifi: mac80211: Add __counted_by for struct
ieee802_11_elems and use struct_size()"), use an incoming '__counted_by()'
attribute for the flexible array members of 'struct probe_resp', 'struct
fils_discovery_data', 'struct unsol_bcast_probe_resp_data', 'struct
ieee80211_mgd_auth_data' and 'struct ieee80211_mgd_assoc_data', as well as
'struct_size()' helper to allocate an instances of them where appropriate.
This also introduces reordering of statements in 'ieee80211_mgd_auth()'
and 'ieee80211_mgd_assoc()' because the counter field should (is better
to?) be adjusted before touching the corresponding '__counted_by()' area.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/cfg.c         |  7 ++++---
 net/mac80211/ieee80211_i.h | 10 +++++-----
 net/mac80211/mlme.c        | 17 +++++++++--------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..5eb95fe0aa78 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -929,7 +929,7 @@ ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 
 	old = sdata_dereference(link->u.ap.probe_resp, sdata);
 
-	new = kzalloc(sizeof(struct probe_resp) + resp_len, GFP_KERNEL);
+	new = kzalloc(struct_size(new, data, resp_len), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
@@ -970,7 +970,8 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 		kfree_rcu(old, rcu_head);
 
 	if (params->tmpl && params->tmpl_len) {
-		new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
+		new = kzalloc(struct_size(new, data, params->tmpl_len),
+			      GFP_KERNEL);
 		if (!new)
 			return -ENOMEM;
 		new->len = params->tmpl_len;
@@ -1001,7 +1002,7 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 		kfree_rcu(old, rcu_head);
 
 	if (params->tmpl && params->tmpl_len) {
-		new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
+		new = kzalloc(struct_size(new, data, params->tmpl_len), GFP_KERNEL);
 		if (!new)
 			return -ENOMEM;
 		new->len = params->tmpl_len;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 84df104f272b..7ac3ce4e1070 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -278,19 +278,19 @@ struct probe_resp {
 	struct rcu_head rcu_head;
 	int len;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 struct fils_discovery_data {
 	struct rcu_head rcu_head;
 	int len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 struct unsol_bcast_probe_resp_data {
 	struct rcu_head rcu_head;
 	int len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 struct ps_data {
@@ -397,7 +397,7 @@ struct ieee80211_mgd_auth_data {
 
 	u16 sae_trans, sae_status;
 	size_t data_len;
-	u8 data[];
+	u8 data[] __counted_by(data_len);
 };
 
 struct ieee80211_mgd_assoc_data {
@@ -446,7 +446,7 @@ struct ieee80211_mgd_assoc_data {
 
 	size_t ie_len;
 	u8 *ie_pos; /* used to fill ie[] with link[].elems */
-	u8 ie[];
+	u8 ie[] __counted_by(ie_len);
 };
 
 struct ieee80211_sta_tx_tspec {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 887b496f2b81..41a4719fb413 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7322,8 +7322,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	}
 	rcu_read_unlock();
 
-	auth_data = kzalloc(sizeof(*auth_data) + req->auth_data_len +
-			    req->ie_len, GFP_KERNEL);
+	auth_data = kzalloc(struct_size(auth_data, data,
+					req->auth_data_len +
+					req->ie_len), GFP_KERNEL);
 	if (!auth_data)
 		return -ENOMEM;
 
@@ -7340,9 +7341,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 			auth_data->sae_trans = le16_to_cpu(pos[0]);
 			auth_data->sae_status = le16_to_cpu(pos[1]);
 		}
+		auth_data->data_len += req->auth_data_len - 4;
 		memcpy(auth_data->data, req->auth_data + 4,
 		       req->auth_data_len - 4);
-		auth_data->data_len += req->auth_data_len - 4;
 	}
 
 	/* Check if continuing authentication or trying to authenticate with the
@@ -7354,9 +7355,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		    ifmgd->auth_data->link_id == req->link_id;
 
 	if (req->ie && req->ie_len) {
+		auth_data->data_len += req->ie_len;
 		memcpy(&auth_data->data[auth_data->data_len],
 		       req->ie, req->ie_len);
-		auth_data->data_len += req->ie_len;
 	}
 
 	if (req->key && req->key_len) {
@@ -7637,16 +7638,16 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss;
 	bool override;
 	int i, err;
-	size_t size = sizeof(*assoc_data) + req->ie_len;
+	size_t extra = req->ie_len;
 
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
-		size += req->links[i].elems_len;
+		extra += req->links[i].elems_len;
 
 	/* FIXME: no support for 4-addr MLO yet */
 	if (sdata->u.mgd.use_4addr && req->link_id >= 0)
 		return -EOPNOTSUPP;
 
-	assoc_data = kzalloc(size, GFP_KERNEL);
+	assoc_data = kzalloc(struct_size(assoc_data, ie, extra), GFP_KERNEL);
 	if (!assoc_data)
 		return -ENOMEM;
 
@@ -7811,8 +7812,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	       sizeof(ifmgd->s1g_capa_mask));
 
 	if (req->ie && req->ie_len) {
-		memcpy(assoc_data->ie, req->ie, req->ie_len);
 		assoc_data->ie_len = req->ie_len;
+		memcpy(assoc_data->ie, req->ie, req->ie_len);
 		assoc_data->ie_pos = assoc_data->ie + assoc_data->ie_len;
 	} else {
 		assoc_data->ie_pos = assoc_data->ie;
-- 
2.43.0


