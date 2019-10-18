Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE43DC793
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408506AbfJROk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:40:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59819 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389378AbfJROk2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571409626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eg6GWygKeYzqmkq+LDj844ZOc9L0SpguuNdAt7HOGwI=;
        b=G6jOAMwYm+aL6DQegZPO0zxfRrTTcAXqafgytbDUS96JVHu9siaUm2IbM7Hal5a5TRx+Z6
        OIAraMPGZoHGf9q8JdlEC6Uq7aYpjVkkR6j3MEwesjpp2Oit9xG0FazdE9iDEh1R3uUA2M
        i08inJE5iP/ZFVrW2xxlYKC5AbDej78=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-pPthp24zMfG9FMVpm_gpRA-1; Fri, 18 Oct 2019 10:40:25 -0400
Received: by mail-lj1-f197.google.com with SMTP id g88so1125233lje.10
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 07:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gQX28cV4kR5e8hFv0Sv15bTp7rYQDznh9B4z2Gx6gas=;
        b=LbvXW/LdFWSMvdAhuYWAe6vtE3e6YYWG1HWBaqlduo6i7kp6zndM2zGICp8229NEOg
         cVtrG1nVEBqs/Gzzw8fzQdBaus2RbPJCYThkPYzJl9iliMbfJPTjQwhSbnoOFG8LL2wP
         4ypvhIiFfkvja/KURFEbv6IsO7SmY4fg91+c6pZAOyXgm38gnrsLVtfqTpflSC1VoyKG
         GD2Po5ugSiUI19c5KTfFO1kRX+neFkNOHlP13x/3oT0jIbIrdCGFsrGs+vKh/GgcP8W3
         zmwZgjJYeCtwDvB0Wak9Dsp4n03MmDlYK6pHi9UOMmaMnhz880DCfGb5SwD8ryRjkGMA
         Wqfw==
X-Gm-Message-State: APjAAAV3r40i+xd49qGFHuFfuTj+nE3v4THM6OAVcFXSYiqUySsljVSS
        k6f71FQ2uNiBDene2NzkY9EudNWJTixHaPulYEXN9CjczfXRwvX9b+Kzb6SjcQ8WAbP8eksjzyz
        OnnWPVmeNB3zi0vbS15gR6xqpgMg=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr6357138ljm.7.1571409623703;
        Fri, 18 Oct 2019 07:40:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1YvkIc2YHpk1/SSCOw+Ds7+tH99z4j9/nltzLAYUnxbi1nOpFOFqviaE5EgAWL5eFjRejZw==
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr6357117ljm.7.1571409623508;
        Fri, 18 Oct 2019 07:40:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id k13sm2644724ljc.96.2019.10.18.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:40:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 20DE21804C9; Fri, 18 Oct 2019 16:40:22 +0200 (CEST)
Subject: [PATCH v3 1/4] mac80211: Shrink the size of ack_frame_id to make room
 for tx_time_est
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 18 Oct 2019 16:40:22 +0200
Message-ID: <157140962205.2866668.16480110695725359529.stgit@toke.dk>
In-Reply-To: <157140962094.2866668.3383184317264069493.stgit@toke.dk>
References: <157140962094.2866668.3383184317264069493.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: pPthp24zMfG9FMVpm_gpRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

To implement airtime queue limiting, we need to keep a running account of
the estimated airtime of all skbs queued into the device. Do to this
correctly, we need to store the airtime estimate into the skb so we can
decrease the outstanding balance when the skb is freed. This means that the
time estimate must be stored somewhere that will survive for the lifetime
of the skb.

To get this, decrease the size of the ack_frame_id field to 6 bits, and
lower the size of the ID space accordingly. This leaves 10 bits for use for
tx_time_est, which is enough to store a maximum of 4096 us, if we shift the
values so they become units of 4us.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/mac80211.h |    4 +++-
 net/mac80211/cfg.c     |    2 +-
 net/mac80211/tx.c      |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d69081c38788..4288ace72c2b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -967,6 +967,7 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_ra=
te *rate)
  * @band: the band to transmit on (use for checking for races)
  * @hw_queue: HW queue to put the frame on, skb_get_queue_mapping() gives =
the AC
  * @ack_frame_id: internal frame ID for TX status, used internally
+ * @tx_time_est: TX time estimate in units of 4us, used internally
  * @control: union part for control data
  * @control.rates: TX rates array to try
  * @control.rts_cts_rate_idx: rate for RTS or CTS
@@ -1007,7 +1008,8 @@ struct ieee80211_tx_info {
=20
 =09u8 hw_queue;
=20
-=09u16 ack_frame_id;
+=09u16 ack_frame_id:6;
+=09u16 tx_time_est:10;
=20
 =09union {
 =09=09struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 70739e746c13..4fb7f1f12109 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3428,7 +3428,7 @@ int ieee80211_attach_ack_skb(struct ieee80211_local *=
local, struct sk_buff *skb,
=20
 =09spin_lock_irqsave(&local->ack_status_lock, spin_flags);
 =09id =3D idr_alloc(&local->ack_status_frames, ack_skb,
-=09=09       1, 0x10000, GFP_ATOMIC);
+=09=09       1, 0x40, GFP_ATOMIC);
 =09spin_unlock_irqrestore(&local->ack_status_lock, spin_flags);
=20
 =09if (id < 0) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 938c10f7955b..a16c2f863702 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2719,7 +2719,7 @@ static struct sk_buff *ieee80211_build_hdr(struct iee=
e80211_sub_if_data *sdata,
=20
 =09=09=09spin_lock_irqsave(&local->ack_status_lock, flags);
 =09=09=09id =3D idr_alloc(&local->ack_status_frames, ack_skb,
-=09=09=09=09       1, 0x10000, GFP_ATOMIC);
+=09=09=09=09       1, 0x40, GFP_ATOMIC);
 =09=09=09spin_unlock_irqrestore(&local->ack_status_lock, flags);
=20
 =09=09=09if (id >=3D 0) {

