Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E518BFDECB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 14:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKONUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 08:20:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40160 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727249AbfKONUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 08:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXoS2W5BbZsp09HQfFBXWaQ8N7PlWsSs7THfUeKuQyo=;
        b=Ebu11Plv52hz8V6WxKgAqewg4txYQnV5jRf5+WsafWByzir93pl78L1QrrQk+7+rGEzG0Z
        qEyAI9xNY/3QOiPRBosjZ9ccsgvmgQlXdIuSLXKl3/KlchPD+6xizjJ/6hYBNi2GS9pNF+
        h51GeHIYkzuZtP7vkfgnm0+i/bkcQwY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-9k8KbyDLPt-2DafAyPWLFA-1; Fri, 15 Nov 2019 08:20:42 -0500
Received: by mail-lj1-f198.google.com with SMTP id k14so1536857ljh.14
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 05:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=x+t/BOQM8F7dbfpj4lBhXe72lJwS1NOF599JEwP8bYk=;
        b=Qebe7qk3Ibtjy6V8NG57I0j0doPU7Ae03U0KMHd/EYWPPJfQYPbFK00voRD0WGT/rx
         MMlQqFwv1H8oymuNYeitpOE2xDc6FX+YXnA01Xl3emfRyEAw7HccpryvSJv964ndYhZT
         iiskbqBPF0/w7YFezAMQKdcDSpYDIaSud7kbmgLPUAGgv4kBhRSGqssIknzWEigiMmaW
         AHs0I4tNYTAa827LSvyi7jfm8rKNE6AcoPzCtZ8OIeFMLhkNGMWNccChTi5dl9ZLvLTn
         NMDUoqIqyiKPtX/4NStiAt/Gh5Ns87eQy+BCB6PRnS680Z6HXF6IE14MWun00VYMwC+Q
         duNg==
X-Gm-Message-State: APjAAAXD3jh1DCokn5pCBm6aNoryXHxgEoLJJUNsf8f1dkdZiVPDtr4a
        n4y+qzYyNynDcPCenActgDYdFSN4j3IEE01YfZhPmZVVXMk4uTXyMdn6+9rsBydfIhSmJn3259q
        R4VtQ4LsWXKnlb48DDDhYFA9ODWc=
X-Received: by 2002:ac2:430d:: with SMTP id l13mr9984250lfh.114.1573824040784;
        Fri, 15 Nov 2019 05:20:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjtwhBuf6diGEEm4m0JGBfBPFikNScE7ZnAZecoaHzG4zmmeoECoLruj7w1iqNj4pJC9ozgA==
X-Received: by 2002:ac2:430d:: with SMTP id l13mr9984230lfh.114.1573824040606;
        Fri, 15 Nov 2019 05:20:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id t17sm3977910ljc.88.2019.11.15.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:20:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F14BB1818C6; Fri, 15 Nov 2019 14:20:37 +0100 (CET)
Subject: [PATCH v9 1/4] mac80211: Add new sta_info getter by sta/vif addrs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 15 Nov 2019 14:20:37 +0100
Message-ID: <157382403786.580235.15008951293054113025.stgit@toke.dk>
In-Reply-To: <157382403672.580235.12525941420808058808.stgit@toke.dk>
References: <157382403672.580235.12525941420808058808.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: 9k8KbyDLPt-2DafAyPWLFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
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
 net/mac80211/sta_info.c |   20 ++++++++++++++++++++
 net/mac80211/sta_info.h |    3 +++
 net/mac80211/status.c   |   10 ++--------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd11fef2139f..465d83b13582 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -210,6 +210,26 @@ struct sta_info *sta_info_get_bss(struct ieee80211_sub=
_if_data *sdata,
 =09return NULL;
 }
=20
+struct sta_info *sta_info_get_by_addrs(struct ieee80211_local *local,
+=09=09=09=09       const u8 *sta_addr, const u8 *vif_addr)
+{
+=09struct rhlist_head *tmp;
+=09struct sta_info *sta;
+
+=09rcu_read_lock();
+=09for_each_sta_info(local, sta_addr, sta, tmp) {
+=09=09if (ether_addr_equal(vif_addr, sta->sdata->vif.addr)) {
+=09=09=09rcu_read_unlock();
+=09=09=09/* this is safe as the caller must already hold
+=09=09=09 * another rcu read section or the mutex
+=09=09=09 */
+=09=09=09return sta;
+=09=09}
+=09}
+=09rcu_read_unlock();
+=09return NULL;
+}
+
 struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 =09=09=09=09     int idx)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 369c2dddce52..80e76569144e 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -725,6 +725,9 @@ struct sta_info *sta_info_get(struct ieee80211_sub_if_d=
ata *sdata,
 struct sta_info *sta_info_get_bss(struct ieee80211_sub_if_data *sdata,
 =09=09=09=09  const u8 *addr);
=20
+struct sta_info *sta_info_get_by_addrs(struct ieee80211_local *local,
+=09=09=09=09       const u8 *sta_addr, const u8 *vif_addr);
+
 #define for_each_sta_info(local, _addr, _sta, _tmp)=09=09=09\
 =09rhl_for_each_entry_rcu(_sta, _tmp,=09=09=09=09\
 =09=09=09       sta_info_hash_lookup(local, _addr), hash_node)
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..0e51def35b8a 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1073,19 +1073,13 @@ void ieee80211_tx_status(struct ieee80211_hw *hw, s=
truct sk_buff *skb)
 =09=09.skb =3D skb,
 =09=09.info =3D IEEE80211_SKB_CB(skb),
 =09};
-=09struct rhlist_head *tmp;
 =09struct sta_info *sta;
=20
 =09rcu_read_lock();
=20
-=09for_each_sta_info(local, hdr->addr1, sta, tmp) {
-=09=09/* skip wrong virtual interface */
-=09=09if (!ether_addr_equal(hdr->addr2, sta->sdata->vif.addr))
-=09=09=09continue;
-
+=09sta =3D sta_info_get_by_addrs(local, hdr->addr1, hdr->addr2);
+=09if (sta)
 =09=09status.sta =3D &sta->sta;
-=09=09break;
-=09}
=20
 =09__ieee80211_tx_status(hw, &status);
 =09rcu_read_unlock();

