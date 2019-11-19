Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FD10182B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 07:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfKSGGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 01:06:24 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54341 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfKSGGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 01:06:23 -0500
Received: by mail-pg1-f202.google.com with SMTP id t28so14933858pgl.21
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 22:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=SUJ++x/TlhzzyCi0jS7LtcmTW7wMb85gdnxub2e66+4=;
        b=jzcfBOXOxGybpn7TTyB80D1IkGi0bBq0gVKYBPTYxT3//xKRGogjWxHWfnUxLuQ6YF
         NUAibcBr6n7a2nLtzBvI1I/He3pN/eVNDKWeJqYZbYsd1e0gXsJXnTZ0pqpCzOi8f+3o
         fFHs+UGbTbQ3XIFzivdY7soT8yuSQwMlDXDRNYyktpg4/qepd+pTOYIpPIz4/S2UEkDh
         7xOgJBp13PkQ34TvIckWDeiQdHqoNlPAUBEhFycLMS2E01YXo096G8e6p3or2T3fLjfG
         4gmAFDtJPjGPuiFOViOrxXCIWg84AeT4iBVFhGsqhaFHxdRAYzggxqLkRclxkfxv4Rnq
         IEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=SUJ++x/TlhzzyCi0jS7LtcmTW7wMb85gdnxub2e66+4=;
        b=VdCLKYUgoukaLMEzApy7mDNUHyPknx1Lb7ZnJAK73AYoCU01rksYh3bwvliY1XNu8h
         wt+j/Xeo8FtKmTgdX2P57B/AD6Tb3M1mfUeexgRfBDnIYzTmME8d2UvlahaTpvApDeW1
         HIFgNGvnCrRWwYjb1JM91P+ZbhZd8SJ53XZTmbjN+4ajLrF6scspfsbzMrm3yJqcDWEQ
         3I4+inXgaTcykB2cwKV+VcIok5yp6KDftvVvjdhcV3aQAiCrxBBBCLGrjViuQ9vUTeqQ
         3zJva+XTOxoCvlcDDoOrf0oAifty38zQcqyj87xXdQzYHxIGUkWh9I8cCGI1coUDGztW
         FWlw==
X-Gm-Message-State: APjAAAUcfgy++sF4qvWYNEreAdurouFwF+fC1HjEXImvjP+1pjuviFB5
        kuA45Vu28r8izcB5dd96kWaZM19V
X-Google-Smtp-Source: APXvYqzNV134LcY9JhSizYZkLWNChU1nezzOzXKtuUuyFIXvORQzS+wTNUd+ckq/gOiolRVK8ppuCq/Q
X-Received: by 2002:a63:495b:: with SMTP id y27mr3614518pgk.438.1574143580296;
 Mon, 18 Nov 2019 22:06:20 -0800 (PST)
Date:   Mon, 18 Nov 2019 22:06:07 -0800
In-Reply-To: <20191119060610.76681-1-kyan@google.com>
Message-Id: <20191119060610.76681-2-kyan@google.com>
Mime-Version: 1.0
References: <20191119060610.76681-1-kyan@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v11 1/4] mac80211: Add new sta_info getter by sta/vif addrs
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

In ieee80211_tx_status() we don't have an sdata struct when looking up the
destination sta. Instead, we just do a lookup by the vif addr that is the
source of the packet being completed. Factor this out into a new sta_info
getter helper, since we need to use it for accounting AQL as well.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/mac80211/sta_info.c | 20 ++++++++++++++++++++
 net/mac80211/sta_info.h |  3 +++
 net/mac80211/status.c   | 10 ++--------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd11fef2139f..465d83b13582 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -210,6 +210,26 @@ struct sta_info *sta_info_get_bss(struct ieee80211_sub=
_if_data *sdata,
 	return NULL;
 }
=20
+struct sta_info *sta_info_get_by_addrs(struct ieee80211_local *local,
+				       const u8 *sta_addr, const u8 *vif_addr)
+{
+	struct rhlist_head *tmp;
+	struct sta_info *sta;
+
+	rcu_read_lock();
+	for_each_sta_info(local, sta_addr, sta, tmp) {
+		if (ether_addr_equal(vif_addr, sta->sdata->vif.addr)) {
+			rcu_read_unlock();
+			/* this is safe as the caller must already hold
+			 * another rcu read section or the mutex
+			 */
+			return sta;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
 struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 				     int idx)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 369c2dddce52..80e76569144e 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -725,6 +725,9 @@ struct sta_info *sta_info_get(struct ieee80211_sub_if_d=
ata *sdata,
 struct sta_info *sta_info_get_bss(struct ieee80211_sub_if_data *sdata,
 				  const u8 *addr);
=20
+struct sta_info *sta_info_get_by_addrs(struct ieee80211_local *local,
+				       const u8 *sta_addr, const u8 *vif_addr);
+
 #define for_each_sta_info(local, _addr, _sta, _tmp)			\
 	rhl_for_each_entry_rcu(_sta, _tmp,				\
 			       sta_info_hash_lookup(local, _addr), hash_node)
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..0e51def35b8a 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1073,19 +1073,13 @@ void ieee80211_tx_status(struct ieee80211_hw *hw, s=
truct sk_buff *skb)
 		.skb =3D skb,
 		.info =3D IEEE80211_SKB_CB(skb),
 	};
-	struct rhlist_head *tmp;
 	struct sta_info *sta;
=20
 	rcu_read_lock();
=20
-	for_each_sta_info(local, hdr->addr1, sta, tmp) {
-		/* skip wrong virtual interface */
-		if (!ether_addr_equal(hdr->addr2, sta->sdata->vif.addr))
-			continue;
-
+	sta =3D sta_info_get_by_addrs(local, hdr->addr1, hdr->addr2);
+	if (sta)
 		status.sta =3D &sta->sta;
-		break;
-	}
=20
 	__ieee80211_tx_status(hw, &status);
 	rcu_read_unlock();
--=20
2.24.0.432.g9d3f5f5b63-goog

