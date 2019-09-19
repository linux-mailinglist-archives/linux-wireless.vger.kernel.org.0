Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2BB793B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfISMWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 08:22:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390189AbfISMWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 08:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568895770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TjYALoQnRgIrNe7Jpy6h0CAGnfDVH/rvpH+SgQd3Yw=;
        b=TpFrmwPqm6+1DOFlLqCABatFPDPTt5iwWfhqB1ZT99gd4LQGqcrUvm8Rr+NI1h6Gu0Zg8k
        jMrAVDp2PvVIltRGeEOF0sKEtPDVJlrq7BIbm91TQnnur2cvs7k2tqh9kOkrW+SytvSK4H
        DHQD6NQ+s9uworfiR7v/LN+/eUoj2gE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-gcFSpKOIP0Gx7-oRn-NNDA-1; Thu, 19 Sep 2019 08:22:49 -0400
Received: by mail-ed1-f70.google.com with SMTP id c16so991731eds.10
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 05:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KjFprYlVcjHNButAUZ7w0c0tzBKf1DOqVFXKr1K22dc=;
        b=tgqjRYH4uplYsxJYGYoy9POmu2wZdN6j/SFWtNmDQyP//cp5giDwgfjHTepi0uMWqD
         v1gGThU6YqUeNmr2iNLGeL6hlM2Yup9L0GgRT9g3P2x2cfUn4KZPZUohUbo/6oWS2uQ0
         IfjJmhBKgMh6H0/kQzKbh5mBiO6OZxwBp8BcpnVqjmVDlh8uZ1VwbeXzJC2uY9R1/fNf
         kZLQtredt9Gs40mnR0DAatkZulG65YmSvqGiJXj7IJrMonwiGHBPATM9pRcs99R5n8gm
         MwspoD9bsPdOY4teS5pCNP/q7SW9BQH4NGsOfuxlz4BCw3bKwcZleTkcPGDC3Th55LBQ
         jzsw==
X-Gm-Message-State: APjAAAXA7CI37Z/LoHQCZ/+ImwpoAhtAq8aSsTPM/zb5OilRx8cbP7M1
        8Nml+dbQTb7hQnxewfsPwcC3VT2oUqr/gDNqmfh2LpxKtc55fQ/vaDvoJvWwRmViI2VMUpkHsqu
        CZVJgM6B91pC4omId6rALeMj5Sf4=
X-Received: by 2002:a17:906:4a51:: with SMTP id a17mr13838839ejv.279.1568895768183;
        Thu, 19 Sep 2019 05:22:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1JrZikJXVhvU4P8naQE9WjBTVHMbuP067O/imjHriv11OeWSxV/xIvPwxrqVVaAtNp5t6Ow==
X-Received: by 2002:a17:906:4a51:: with SMTP id a17mr13838819ejv.279.1568895767985;
        Thu, 19 Sep 2019 05:22:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id c22sm1619170edc.9.2019.09.19.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:22:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8EC2E18063E; Thu, 19 Sep 2019 14:22:46 +0200 (CEST)
Subject: [PATCH RFC/RFT 2/4] mac80211: Add API function to set the last TX
 bitrate for a station
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Sep 2019 14:22:46 +0200
Message-ID: <156889576646.191202.14461472477971784776.stgit@alrua-x1>
In-Reply-To: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-MC-Unique: gcFSpKOIP0Gx7-oRn-NNDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

To implement airtime queue limits, we need an estimate of the transmission
rate a station is currently transmitting at. The ath10k driver already
keeps this internally, so add an API function to pass this up to mac80211.

We also keep a pre-calculated 64-bit reciprocal that will be used in the
actual calculations, to avoid a division operation in the fast path.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/mac80211.h     |   10 ++++++++++
 net/mac80211/ieee80211_i.h |    4 ++++
 net/mac80211/sta_info.c    |    9 +++++++++
 net/mac80211/sta_info.h    |    2 ++
 4 files changed, 25 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b12d378621b0..1b7f4a370122 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4529,6 +4529,16 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vi=
f,
 void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
 =09=09=09=09=09   u32 thr);
=20
+/**
+ * ieee80211_sta_set_last_tx_bitrate - set last tx rate for station
+ *
+ * This sets the last TX bitrate for a given station.
+ *
+ * @sta: Pointer to the station
+ * @bitrate: Bitrate in kbps
+ */
+void ieee80211_sta_set_last_tx_bitrate(struct ieee80211_sta *sta, u32 bitr=
ate);
+
 /**
  * ieee80211_tx_rate_update - transmit rate update callback
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 05406e9c05b3..9de5390411ba 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -59,6 +59,10 @@ struct ieee80211_local;
 /* power level hasn't been configured (or set to automatic) */
 #define IEEE80211_UNSET_POWER_LEVEL=09INT_MIN
=20
+/* constants for calculating reciprocals to avoid division in fast path */
+#define IEEE80211_RECIPROCAL_DIVISOR 0x100000000ULL
+#define IEEE80211_RECIPROCAL_SHIFT 32
+
 /*
  * Some APs experience problems when working with U-APSD. Decreasing the
  * probability of that happening by using legacy mode for all ACs but VO i=
sn't
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index df553070206c..aae878ffe94c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2481,3 +2481,12 @@ void ieee80211_sta_set_expected_throughput(struct ie=
ee80211_sta *pubsta,
=20
 =09sta_update_codel_params(sta, thr);
 }
+
+void ieee80211_sta_set_last_tx_bitrate(struct ieee80211_sta *pubsta,
+=09=09=09=09       u32 rate)
+{
+=09struct sta_info *sta =3D container_of(pubsta, struct sta_info, sta);
+
+=09sta->last_tx_bitrate =3D rate;
+=09sta->last_tx_bitrate_reciprocal =3D ((u64)IEEE80211_RECIPROCAL_DIVISOR =
/ rate);
+}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 369c2dddce52..dd1a0b87f234 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -617,6 +617,8 @@ struct sta_info {
 =09const struct ieee80211_cipher_scheme *cipher_scheme;
=20
 =09struct codel_params cparams;
+=09u32 last_tx_bitrate;
+=09u64 last_tx_bitrate_reciprocal;
=20
 =09u8 reserved_tid;
=20

