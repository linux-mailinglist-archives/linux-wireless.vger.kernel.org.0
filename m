Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C653B793A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 14:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbfISMWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 08:22:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390189AbfISMWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 08:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568895769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8iED3oiyhLzJJZ30CyP3ZO6eui10EgrPm/9G6wov3s=;
        b=IA0hlO1ZMmyc6Dv/cxAsQAtE4tH8mrusOlc7WMHDyKm+Em0zRN0KmsW7zwwhvVWkhGaL4c
        rtbdtMhSYYoVggR3xHWcdAIlBY4MkH5N8Po5VRbV4aNdTp3++wjDQF0GNo5Dp6V6KYMhCJ
        ABZuhuTwaMZJNurQSTP27jnSJ/dksZc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-SJva4J_mO7mVhw80i6swsQ-1; Thu, 19 Sep 2019 08:22:47 -0400
Received: by mail-ed1-f71.google.com with SMTP id n12so1818917edr.22
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 05:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EXEr1sMDPH/aWfRInXJqvE5yL3ewAcgVs45LnZ9+8dU=;
        b=CHS/YmGkjiUZs09Q73CxyZjRqbnGKkEUOhWFZbNNP0Q3NTI6sE0X6DXpyQJg2UT/Un
         92/L7GpAmqKPxuAmmAzPBVpmY1PyRBWzCjQEfLswF5jZ+POn/ObcarRL920l8kDnkLRE
         UpYhVVhClOU9hoDriK9X+STSgqvQ5wiCJMuR8o5Xm6XO7uswO/EkugyQHO15MpIe19J+
         Dy55C+R9/1lDocpRZqb0b54CCQ1qbHLpN20kcAAOP84fOYKyU2bmus5Iayfbe6Yz0A67
         mArRJeBACA3/dUNzgq4eIspab8VlpLGIJTfGQ55D34/1+yUrIaIGSZpkdJ2V4ZVcjBz2
         k0tQ==
X-Gm-Message-State: APjAAAVDicP7NTUA2tsUlhvajDNGm/cYulz6oZJbu+bZsNPK+IHkin5x
        UYCFHcZR6ghgphn58n1IoHVblFI9sCPFglcwvM7LqedTjKiVE7ipYADi0/j0+xgkem0mIyaiU89
        KCY9AfViLdCZCDxuMsHhibWBN1k4=
X-Received: by 2002:a17:906:1304:: with SMTP id w4mr13641522ejb.6.1568895766662;
        Thu, 19 Sep 2019 05:22:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJa6db6yYOyoT/D8diru8N8y2vYw5ZdUdScxxTHkNz9Av5ARCqssZ6G+qM8bwIdBfM3wU51g==
X-Received: by 2002:a17:906:1304:: with SMTP id w4mr13641508ejb.6.1568895766453;
        Thu, 19 Sep 2019 05:22:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id l11sm1018778eje.67.2019.09.19.05.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:22:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7082518063F; Thu, 19 Sep 2019 14:22:45 +0200 (CEST)
Subject: [PATCH RFC/RFT 1/4] mac80211: Rearrange ieee80211_tx_info to make
 room for tx_time_est
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Sep 2019 14:22:45 +0200
Message-ID: <156889576534.191202.17686228416284995279.stgit@alrua-x1>
In-Reply-To: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-MC-Unique: SJva4J_mO7mVhw80i6swsQ-1
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

Fortunately, we had a couple of bytes left in the 'status' field in the
ieee80211_tx_info; and since we only plan to calculate the airtime estimate
after the skb is dequeued from the FQ structure, on the control side we can
share the space with the codel enqueue time. And by rearranging the order
of elements it is possible to have the position of the new tx_time_est line
up between the control and status structs, so the value will survive from
when mac80211 hands the packet to the driver, and until the driver either
frees it, or hands it back through TX status.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/mac80211.h |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 523c6a09e1c8..b12d378621b0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -975,20 +975,22 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_=
rate *rate)
  * @control.short_preamble: use short preamble (CCK only)
  * @control.skip_table: skip externally configured rate table
  * @control.jiffies: timestamp for expiry on powersave clients
+ * @control.enqueue_time: enqueue time (for iTXQs)
+ * @control.tx_time_est: estimated airtime usage (shared with @status)
+ * @control.flags: control flags, see &enum mac80211_tx_control_flags
  * @control.vif: virtual interface (may be NULL)
  * @control.hw_key: key to encrypt with (may be NULL)
- * @control.flags: control flags, see &enum mac80211_tx_control_flags
- * @control.enqueue_time: enqueue time (for iTXQs)
  * @driver_rates: alias to @control.rates to reserve space
  * @pad: padding
  * @rate_driver_data: driver use area if driver needs @control.rates
  * @status: union part for status data
  * @status.rates: attempted rates
  * @status.ack_signal: ACK signal
+ * @status.tx_time_est: estimated airtime of skb (shared with @control)
+ * @status.tx_time: actual airtime consumed for transmission
  * @status.ampdu_ack_len: AMPDU ack length
  * @status.ampdu_len: AMPDU length
  * @status.antenna: (legacy, kept only for iwlegacy)
- * @status.tx_time: airtime consumed for transmission
  * @status.is_valid_ack_signal: ACK signal is valid
  * @status.status_driver_data: driver use area
  * @ack: union part for pure ACK data
@@ -1026,11 +1028,14 @@ struct ieee80211_tx_info {
 =09=09=09=09/* only needed before rate control */
 =09=09=09=09unsigned long jiffies;
 =09=09=09};
+=09=09=09union {
+=09=09=09=09codel_time_t enqueue_time;
+=09=09=09=09u16 tx_time_est; /* shared with status */
+=09=09=09};
+=09=09=09u32 flags;
 =09=09=09/* NB: vif can be NULL for injected frames */
 =09=09=09struct ieee80211_vif *vif;
 =09=09=09struct ieee80211_key_conf *hw_key;
-=09=09=09u32 flags;
-=09=09=09codel_time_t enqueue_time;
 =09=09} control;
 =09=09struct {
 =09=09=09u64 cookie;
@@ -1038,12 +1043,13 @@ struct ieee80211_tx_info {
 =09=09struct {
 =09=09=09struct ieee80211_tx_rate rates[IEEE80211_TX_MAX_RATES];
 =09=09=09s32 ack_signal;
+=09=09=09u16 tx_time_est; /* shared with control */
+=09=09=09u16 tx_time;
 =09=09=09u8 ampdu_ack_len;
 =09=09=09u8 ampdu_len;
 =09=09=09u8 antenna;
-=09=09=09u16 tx_time;
 =09=09=09bool is_valid_ack_signal;
-=09=09=09void *status_driver_data[19 / sizeof(void *)];
+=09=09=09void *status_driver_data[16 / sizeof(void *)];
 =09=09} status;
 =09=09struct {
 =09=09=09struct ieee80211_tx_rate driver_rates[
@@ -1126,6 +1132,8 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_in=
fo *info)
 =09=09     offsetof(struct ieee80211_tx_info, control.rates));
 =09BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) !=3D
 =09=09     offsetof(struct ieee80211_tx_info, driver_rates));
+=09BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, control.tx_time_est) !=
=3D
+=09=09     offsetof(struct ieee80211_tx_info, status.tx_time_est));
 =09BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) !=3D 8);
 =09/* clear the rate counts */
 =09for (i =3D 0; i < IEEE80211_TX_MAX_RATES; i++)

