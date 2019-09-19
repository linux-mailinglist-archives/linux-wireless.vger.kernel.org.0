Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D74B793C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfISMWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 08:22:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390237AbfISMWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 08:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568895772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwctswRgBDzjQDKiFZhMpOyHVX95Z8fvqsdkOkPRGjY=;
        b=GnebpjRJiwbpVJsA5Bq2u0e21OH6HMfbS98bfuTy0DEkgCoDqTOBDAkmgob4ac8oTGHWgU
        FNcbekxZfa7YJ+VcZNjYTyglsTZL6mVwXlYA0LLLSjiyhwxtVCSfzd1i3dxIHuzrjHfSd/
        jufWuyqlSSZACtAT3P9ADlr8Lr5zOn4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-AI3e1DeJPOWBJTiijeC5AQ-1; Thu, 19 Sep 2019 08:22:50 -0400
Received: by mail-ed1-f71.google.com with SMTP id 38so1859468edr.4
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 05:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Oen7CzFZmELv1d4/EePaKSFIocxA1ziuIjtlPtY3KYI=;
        b=iMSMClzadhdaHa2mxJU/x7FV9n8zQzSQeBdLhHBjkVVIWAf5uQ7sIFVwvp4rgrOWsa
         yD9VdS4qWdmzxSTCzWSUX+BhD4gQERwfrKxgYRmhUeN3s3Fh2YsydeyAXE7fWSxgxvur
         uN3tB6IBAR9nNY8iFootJaTd/hmY1ajIWN8k6sEvkriMrmRDm/X1zZoO9/aqz7/Yrkp5
         qFmTbugZgWPLAuGIL1cX2pcGcLSH9HrB2xgfcMBUiNKwoyYdVSc4TFrE7h2ahdfgNWc9
         nZgJ3YF7jIfe//w3A5mddgW8u6hI2/XKx68aXai8QeG0UKSu7NjjlRWN/2s1cAdzm0zr
         F1vg==
X-Gm-Message-State: APjAAAX2R5zRNw2i8jNOSqY8Cjs/eaAGvarcJ1Ve0vuXnQ2g72vIPM1z
        ymYnloKtxac1VyjdZFP9wV3bfqwOIL8mqXoJeBKJ01Gc2fC6Eg2s2DGy0QSLWrsOHeyAqOppP5T
        EsvNx6W6BeTAFHiRrUdiBLJq7aIM=
X-Received: by 2002:aa7:c657:: with SMTP id z23mr13862895edr.234.1568895769632;
        Thu, 19 Sep 2019 05:22:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4Wrq6mkotnQ/ffGvhibRAOH/IoFNreUVCNsD+HOZ36Lv4908di3XQf+c6ZEgDxc1uJSdeYQ==
X-Received: by 2002:aa7:c657:: with SMTP id z23mr13862793edr.234.1568895768591;
        Thu, 19 Sep 2019 05:22:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id y5sm994249ejj.35.2019.09.19.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:22:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A8A9E18063F; Thu, 19 Sep 2019 14:22:47 +0200 (CEST)
Subject: [PATCH RFC/RFT 3/4] ath10k: Pass last TX bitrate up to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Sep 2019 14:22:47 +0200
Message-ID: <156889576758.191202.2981673914345691512.stgit@alrua-x1>
In-Reply-To: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-MC-Unique: AI3e1DeJPOWBJTiijeC5AQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Use the newly added API to pass the last_tx_bitrate up to mac80211. The
multiplication is because ath10k keeps it internally as units of 100kbps,
whereas for mac80211 we just use kbps as the variable unit.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireles=
s/ath/ath10k/htt_rx.c
index 83a7fb68fd24..0617341eb70c 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3454,6 +3454,7 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 =09arsta->txrate.nss =3D txrate.nss;
 =09arsta->txrate.bw =3D ath10k_bw_to_mac80211_bw(txrate.bw);
 =09arsta->last_tx_bitrate =3D cfg80211_calculate_bitrate(&arsta->txrate);
+=09ieee80211_sta_set_last_tx_bitrate(sta, arsta->last_tx_bitrate * 100);
 =09if (sgi)
 =09=09arsta->txrate.flags |=3D RATE_INFO_FLAGS_SHORT_GI;
=20

