Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B8DD890
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfJSLhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:37:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbfJSLhU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571485039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eg6GWygKeYzqmkq+LDj844ZOc9L0SpguuNdAt7HOGwI=;
        b=NlfOAKI3FLe96FZVC1YmQhPOl5zJ0aMUVlEZnWCkY7aoME9/BNNbbEGXWD/+SPE9GNnZcP
        hA+pKBXAHcWYyTLAUi43SSk5pBfvKn8QfVM//aTbF/qvrKQ2T6jNCGzfT1CmNlr2xNo0WZ
        WoPc6tAsNr4G7CoMko4Wbf1TyY6+fqI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-qX6acbbyNWugMVQJS57T7w-1; Sat, 19 Oct 2019 07:37:18 -0400
Received: by mail-lf1-f72.google.com with SMTP id u14so1763721lfi.10
        for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2019 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gQX28cV4kR5e8hFv0Sv15bTp7rYQDznh9B4z2Gx6gas=;
        b=QWq/LBR60vtjAMAsVZ0iaM4ujEkNuCuGsY3K/nISwswge/2BjgRNI/fJk3hZ1fqsuq
         URgMfz7EgfbJEf119EGo5YmJN4Dtp3PsJWpUFLOjd8fH4BV+49vlf2dli59Mqd2AbMvr
         B9rsZtDOL/fQym0Z5oaEWXKQ/kGUueXbhm0dNc1zoKlfs+J8B5oumzY7EOYMSKgl+sjx
         /QRfXFw739iuVyeIn4dNwYJCblxk5NJ8s1GXL/GQM36EN+YHCy/EoE3jNH/+cbe6SQc/
         jJgcueUTdyqshcWQtE7iU6cA3WYvrc7IkvOfu2w+93GFr3SUAT3TdW12NZryrJN1Okcj
         2xvg==
X-Gm-Message-State: APjAAAUq0RWdqx3lN4OJgmbtF82z2xzA2QRsYb9l/0A1RzyRzWhLa6IB
        PbpUADnfsM9TR4s3uXsayRG2xhCFHlc8TJFaaYS0ZVYaBXgw8tnZsEwle/DH4aCiJ6s2VrrqFCv
        b4py5Wvp7qiyQybyNhnvowlQYiRg=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr9161984ljj.4.1571485036738;
        Sat, 19 Oct 2019 04:37:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJEjxmojsJP7IanyFe53Iv8Ncd2ZXFdJBhgc/XXnG9JRPPb5VwPEj6BG1t7AJcX3UPrE3L2g==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr9161976ljj.4.1571485036534;
        Sat, 19 Oct 2019 04:37:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id i17sm5961865lfj.35.2019.10.19.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:37:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5ED841804C9; Sat, 19 Oct 2019 13:37:15 +0200 (CEST)
Subject: [PATCH v4 1/4] mac80211: Shrink the size of ack_frame_id to make room
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
Date:   Sat, 19 Oct 2019 13:37:15 +0200
Message-ID: <157148503526.2989444.13871793436722188173.stgit@toke.dk>
In-Reply-To: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: qX6acbbyNWugMVQJS57T7w-1
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

