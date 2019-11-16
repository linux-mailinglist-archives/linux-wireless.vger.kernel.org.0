Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD9FEC22
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKPL5Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:57:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPL5Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573905443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXoS2W5BbZsp09HQfFBXWaQ8N7PlWsSs7THfUeKuQyo=;
        b=Rk/Ofw01ilidAHxDEbF3CVU5u1j47aBhV9BPoWiB/TuUDJpToPSeH+r8JL4r5OS/orRu4r
        3+y1nDwm0C1rbTB7O9TMeIzKHOrkJmc112sXUkMdpXbJLkhmWhsm8A8MDCQCvyjYcfjq40
        uNBvcn/j599rKWosYV2HdsmOZ5l3PZk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-RKWHDo-eN4WZzo496X8XSg-1; Sat, 16 Nov 2019 06:57:22 -0500
Received: by mail-lf1-f69.google.com with SMTP id k30so3979149lfj.5
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2019 03:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=x+t/BOQM8F7dbfpj4lBhXe72lJwS1NOF599JEwP8bYk=;
        b=RIrbk8qt/rUfbPI0Kt9mPe0FftkWljsrwfGoBWi4UxxaQ+tMnhhsxiPXdgjyWEd9iZ
         rlZrYJCc+HF5tJtm+T92BXPg4N5QlOAVHfRgLYy6vnwnXJRYuJnpH+3puaxbXvCsl8bS
         yagrbfZggOVkv73kcU5JUxru2PmKs+9l3RZAHesL0ECr6CeyQAicvRUlo4MXIwxTb/sk
         OR5Qs41HNE7pBtsuMMWhHrNEA6qdAOu+iPZIIJYDWg+S8UImCD7x9rH+/6Unzoyfaxtz
         yL9+RF+goj24CyD9V3ris+SfuA3KH/ve1BWDb9TUhtd+Q6QoHi9JRQJaGJYMliLH3UN1
         39hQ==
X-Gm-Message-State: APjAAAXs9P1oBoFSxNMqvi+bXg/xhSTfY79lN0/dZo8FNSv5r8uhTTX5
        +p/Qs8JrHbFh/TAylrSUlsigPO2pgrTYEuQoCppVDo/DBorSyBsgD1GQ3iGVhs63rWRQ4GhRhqk
        LoaEmUUB2lWauaia/jlcx6Z8Iuzg=
X-Received: by 2002:a2e:9156:: with SMTP id q22mr10462785ljg.166.1573905440929;
        Sat, 16 Nov 2019 03:57:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0L+POcRH+ZCGceuYnd9tkUS+fm0ri2a2QHKWHz6GQdx5Ehz43kLACA3daj8P4f0JD6MpnUA==
X-Received: by 2002:a2e:9156:: with SMTP id q22mr10462771ljg.166.1573905440761;
        Sat, 16 Nov 2019 03:57:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id s28sm6071884lfp.92.2019.11.16.03.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 03:57:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1483C181911; Sat, 16 Nov 2019 12:57:18 +0100 (CET)
Subject: [PATCH v10 1/4] mac80211: Add new sta_info getter by sta/vif addrs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Sat, 16 Nov 2019 12:57:18 +0100
Message-ID: <157390543799.662247.14225450732789555896.stgit@toke.dk>
In-Reply-To: <157390543688.662247.3735146484299260207.stgit@toke.dk>
References: <157390543688.662247.3735146484299260207.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: RKWHDo-eN4WZzo496X8XSg-1
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

