Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA64D7D45
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfJORTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 13:19:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730579AbfJORTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 13:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571159943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qf8HGaC9XYB4yCBmVPA2/e9VNoQoe0I/AoOfC2m9mE=;
        b=IhyczgNUMdFCijTG2/3feMwdNG6tVuWkf3WNE8/F/bZLRJ/yUokHTGv8BaNX9led1481al
        FQm/duG+OeuYAUWpgeUegLJsmfMhVpbWJa/6501zIGOcTsXG7E/nOsmr2aUQEQB877b4JW
        /nqM5W2DjFhVEHsaumTrp5Ev5p6lmmY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-LHnuATfuMC2lXYZXGnCTtg-1; Tue, 15 Oct 2019 13:19:01 -0400
Received: by mail-lj1-f200.google.com with SMTP id v24so4037058ljh.23
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 10:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Xz0DFDu36TCFLND3BKlsyYv/TX/+u1NMntE7P/QH1z8=;
        b=tQ3/TXNwgq/BbAmGNi843CPAabe0Z7Ia0NDSXPd1waJzXmvFurIo3N32CllvfzPCAG
         +mdbQQw10DtfaRPxaSiYZTUaMZFJxyhW2A8cBxH+a9fNDlsNJyu/xOvv9dwN4+qq3tCN
         rIC21wouIxLhjKbhYbPtwg1hcvL0NTSkU9MLeZT1OAUO+2RGkK6sHJqq1neuFjCRyZoE
         JX4i1HQXrT67OZYJT2NF8a+E9B0tg1W/bbEd+bkFjVoqoQW2lahgZ/HbWFocpXmZ6uou
         /3mn7tDNOmsX0T/e4ZMTMNwVTXM7XNH3kj8diS2U1zEYHQ9ARAg7TypJddgk2AHKJg/v
         Ynwg==
X-Gm-Message-State: APjAAAXEolMIWO8v4JIEQRMqvaMi1VTuobY4eI0VxRs3vD2l+rpLSoY0
        Cq5wB67Hdg6crFOSeCXr5jZg1dd4z3g8RAYgdd4a/M7h6ibPE1AuCJWHe9ccYq96J0mUEDMXznE
        XFQo85KoFbHKmYYvGUdtXWvvhTOY=
X-Received: by 2002:a19:dc14:: with SMTP id t20mr3205381lfg.21.1571159940384;
        Tue, 15 Oct 2019 10:19:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzjLO6aCJGIyJgLbMmJuwRaVWDfTwy3zvUgeePNCzfGgSDv/H65WMQjzv2MbphmgGo+wiStTQ==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr3205368lfg.21.1571159940122;
        Tue, 15 Oct 2019 10:19:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z72sm5664042ljb.98.2019.10.15.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:18:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B680A1803A9; Tue, 15 Oct 2019 19:18:58 +0200 (CEST)
Subject: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make room for
 tx_time_est
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Tue, 15 Oct 2019 19:18:58 +0200
Message-ID: <157115993866.2500430.13989567853855880476.stgit@toke.dk>
In-Reply-To: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: LHnuATfuMC2lXYZXGnCTtg-1
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
 include/net/mac80211.h |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d69081c38788..49f8ea0af5f8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -975,20 +975,23 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_=
rate *rate)
  * @control.short_preamble: use short preamble (CCK only)
  * @control.skip_table: skip externally configured rate table
  * @control.jiffies: timestamp for expiry on powersave clients
+ * @control.enqueue_time: enqueue time (for iTXQs)
+ * @control.tx_time_est: estimated airtime usage (shared with @status)
+ * @control.reserved: unused field to ensure alignment of data structure
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
@@ -1026,11 +1029,17 @@ struct ieee80211_tx_info {
 =09=09=09=09/* only needed before rate control */
 =09=09=09=09unsigned long jiffies;
 =09=09=09};
+=09=09=09union {
+=09=09=09=09codel_time_t enqueue_time;
+=09=09=09=09struct {
+=09=09=09=09=09u16 tx_time_est; /* shared with status */
+=09=09=09=09=09u16 reserved; /* padding for alignment */
+=09=09=09=09};
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
@@ -1038,12 +1047,13 @@ struct ieee80211_tx_info {
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
@@ -1126,6 +1136,8 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_in=
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

