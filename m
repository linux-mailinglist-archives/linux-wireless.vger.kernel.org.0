Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFD11AE60
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 15:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfLKOwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 09:52:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729443AbfLKOwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 09:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576075961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVrOd/AtKqQ+3lFnZdZPMqGZp03aa4R8EHaG4AvYl98=;
        b=LWbJLKNl45QNmCYvk9U4VCnQi8aSag8gt1n6Yt1GXjlQQdb7flOttbSsS6/jaSrxHie3eH
        2/KffTDk+92rdzbzO5DxJ1lYTDwzEH6sG3aLJWjO7rVVh1Epb95AHoXIEL80sBBm2WYQVs
        Ujd1kgZ0M2PC682v0NFCYo3HVDE1TJI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-lOex7PSkMkGn0wJ018lm8Q-1; Wed, 11 Dec 2019 09:52:40 -0500
Received: by mail-lj1-f200.google.com with SMTP id y15so4463735lji.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 06:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIYEceArm89vofCcGEEI9GrhNXUHVHygOyvktxjEWNY=;
        b=VfMmmBv/GRAfrFUINI3suEAFo6MQxxyEdXUVKHKlk9VGBYb+QtNbPPPNe/QrxxW2G4
         rBxej8hWAr/vM7nWR2B8y+WYTQEvar19DBYMzKrnrMeCNyuDcj1UtadZ7uZ9thtGD9bf
         4+wqBXZlHXuQxpKPdz2tAxi+slMbZSs5H3sbU9iBvUHuSKBy9r8rvsgWtI0mNjq4MtG5
         wvUBcX/mzKSrSnpwO3ufCem/T3Ieyeg8uCDnX+GktoqwN+ky6dwcvWCjdfiaOVuvCQhD
         zQiV4aZwKWkGH7g/NhQWJck7zXsM75rd+rSbomDpyRDQWskCAkVswPmrifeP3Qb9Ar96
         Fqkg==
X-Gm-Message-State: APjAAAUNQUIAYB5duzYLobf0BEz4qsulkKLaMieHqrF7GVFPBJ5V7SY9
        ZSGZTzVOHhanI8rtcBj+pgt14rLINYyh56xe5yfuh/LS/U1/LY+tVPUXCgrSliFwNWylHjrVK6l
        NCrwsJTt8AYZ/i+QwPdNnRrUyp74=
X-Received: by 2002:a19:cb54:: with SMTP id b81mr2437667lfg.188.1576075958313;
        Wed, 11 Dec 2019 06:52:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGKqvuy2l7mj+RCSF8XYczhurX2wqsTb4Gc0yCsqsDpPAv6ARGJUyjUxBB8qGIP34AKTL1LA==
X-Received: by 2002:a19:cb54:: with SMTP id b81mr2437659lfg.188.1576075958149;
        Wed, 11 Dec 2019 06:52:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e21sm1487004lfc.63.2019.12.11.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:52:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DCD9A181A44; Wed, 11 Dec 2019 15:52:35 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 2/2] ath10k: Enable Airtime Queue Limits feature
Date:   Wed, 11 Dec 2019 15:52:30 +0100
Message-Id: <20191211145230.200132-3-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211145230.200132-1-toke@redhat.com>
References: <20191211145230.200132-1-toke@redhat.com>
MIME-Version: 1.0
X-MC-Unique: lOex7PSkMkGn0wJ018lm8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since AQL is now a feature flag drivers have to set for the feature to be
enabled, set this for ath10k.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 83cc8778ca1e..978f0037ed52 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8958,6 +8958,7 @@ int ath10k_mac_register(struct ath10k *ar)
 =09wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 =09wiphy_ext_feature_set(ar->hw->wiphy,
 =09=09=09      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+=09wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
=20
 =09if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
 =09    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map)=
)
--=20
2.24.0

