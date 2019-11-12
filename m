Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA8F903A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 14:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKLNIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 08:08:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28412 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbfKLNIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 08:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573564129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0c9Bj8gH8ohmbBRkzUjd0z4DKWnVc+gaVVS5MgRwcd8=;
        b=Vg2CTWFfXEuLZpntVPPbXFUQ4UB0g09S/2YIGS8/mvMDS5i1CgXLBYVUtIhtycQ2laXFgZ
        ZsD5PZUa3H7rQnwfVzvDSX7yr0FKPgvv64dzh8zuowSM+/SChSef/ZhOiM5UNZH8dnWiMC
        JkPCXv3DTDvVualDv5V+Mg2XgPME2lk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-XlSbO_KWNXaId5FAVm6Hmg-1; Tue, 12 Nov 2019 08:08:47 -0500
Received: by mail-lj1-f197.google.com with SMTP id d16so3212773ljo.11
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 05:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPUix7ImQc8T3yv5ojNugs6VfQoOoAC5mK8M6f55aLo=;
        b=MlR50x2CGfJeeymrvcFfQtZXmH0ftgvID/Fmlvj2JmTkxPJQLOD0bJGYwpUWhUxyY3
         k3tkiK7CWSmqFL780JIC4JMYjePbtN3PKltBEfhoP1ppgMn2+TOqJ5D0W+4xmpUd/dZR
         sE0sPxZtmN8i29B4o1RWX6cHx5K5MPzpEQgYsTOlrCoJXM5evkQzX13Rl2iiOgSEyaq9
         vmbsHNC3enykiqlg3SoWC3kc95oBpytvIk/Kl8GRHHV+Fs7BOwuvnTTz0B+RDm8hc90V
         G/qFcA2FUrbbSKE18ITcLTbrOcONjvHMhkrBrCaQ5NXRUuGvbFIbsNRtL/ocRuJPgEgy
         SLTw==
X-Gm-Message-State: APjAAAWV2kDK87I4wLRqkdGid27PD6NUVGz8KLd9gmuijVb6PbJOosPT
        qUYqenRcIG5e+5JpMgS7lPoMYiVAac2wyW9X3aOdDfVZ/CKewDyoE/ocgmrVSo0hM/FQ2KXngcc
        euSJs2Hw5y5/3HU8osgkwIcMSZXg=
X-Received: by 2002:a05:651c:1025:: with SMTP id w5mr9415318ljm.68.1573564125911;
        Tue, 12 Nov 2019 05:08:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBuVRzzNVXg3Py8K6+wzb72ntAse9lF/3d7Wt3srStHwOwopNOVJACilEYta6lA3nu4wsEag==
X-Received: by 2002:a05:651c:1025:: with SMTP id w5mr9415301ljm.68.1573564125655;
        Tue, 12 Nov 2019 05:08:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id c12sm9854452ljk.77.2019.11.12.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:08:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1AF701803C7; Tue, 12 Nov 2019 14:08:44 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org, Kan Yan <kyan@google.com>
Subject: [PATCH] mac80211: Add new sta_info getter by sta/vif addrs
Date:   Tue, 12 Nov 2019 14:08:35 +0100
Message-Id: <20191112130835.382062-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: XlSbO_KWNXaId5FAVm6Hmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
--=20
2.24.0

