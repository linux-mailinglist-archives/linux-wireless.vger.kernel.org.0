Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0914212F6C3
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 11:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgACKfu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 05:35:50 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgACKft (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 05:35:49 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.168]) with ESMTPSA (Nemesis)
 id 1M277h-1ikqGh3VVZ-002XHv; Fri, 03 Jan 2020 11:35:46 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH v2 2/2] mac80211: Allow deleting stations in ibss mode to reset their state.
Date:   Fri,  3 Jan 2020 11:34:57 +0100
Message-Id: <20200103103457.22778-3-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
References: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hqoj2+HquQp6sR66zV8sfHprA+JFQ6c11uohl/K7RM9OazH1QsS
 ongj8hE6LrKNI7JjMGcVW89PWwSyKBqqVfe4jp+YLzjTcFoFLL9N95Mxl8Qi6OsECO9adzk
 zWUZfSVbb+mpLDSv9bgvEaffoTC70niVj94k4VHWJTuV8SSMp9mJyBkvSNu9Ah9/ky9jt/I
 Ro9SUmlnwLuqSK+vbY1oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jXTC2dIqgQ4=:S3q+UgbBcw4GqpNVmUGugL
 vvZRc9lWU1vZpVNScBMQXlIOFzQldBuBazA/VPSod5aMfKJY6RWTbncj/OFSOQdyfA1HFsvoD
 VosMexXzcp2ZfYikmyglrxGPqxTQnc9MLzvAjG8ZxPe4Qrgk+R2D2Zya8zi7OojnLKkQ5nyYf
 qW8mnxOp5Ix0vn/y2yEpRi2AnlHXRu3wn+GACqa+xtJQacI8t3Pd4Udcdudz+gS9UPjjWQM9V
 5uXn8QrOu00OmBrwH4pgQuGjOJsCwy8ECSnN/4z+cDKCjd/EGiyV9u1p4d9PgJKzJOxWqmBrG
 uOu0bjUYagmP/sKSWut9BwIpy0UCwA5C1t1dvrulThseSI24zklqWzPNiWuFt89KEsUawlKFE
 CpUAxq9HfW5ZDNVehd2oMZah4QPjGmyqo+dro1W3nA/l37+3ijm2ez/73vT+Zt5R/P7G4LDTz
 MV12UYcAul4Xuxm5derNib3sm69VxSnz0Ghpo54KfXc6IIJAO5A15w4nDWMwjcy6qmXnCi248
 fMWx2mnZAM6gs40bJZmgdXfNWp2jGCy0lzcj35FXcHNn+trkEoLieiLo2klMtZhCWhzBKIL3Q
 xtvO15XUNlslEob4VTVG5t70WBlCqFI7xKlVMeHYa6QGCiOSWLWiyygBStPMrDuobmhFtxBc9
 5A5atEjeYloggNBmJD6KdBBeHTV1vzTUOJC99YW/DPemuRFuP3pet1F0Idh7cX3HNjfrObuXk
 vWkuAL9O0v4d80xTGoxVwrliKhZmHkIT9rPYAgxKt4ySwC+1JYtyszzYleFpvJyu5tr5Irnpm
 BRkNp2i1gXxU7alVs/ooK1gPQ5fM6qCNoJRl7XWdMdI8i1rzzr3HXGDYpGteTRiYgZH4BTk7b
 XQAlU+PBQkMbXVFN+E99R6hvezk3Xo/2euX6Iod+S1FZzBSD8X1kkF9yX3+ljT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set the NL80211_EXT_FEATURE_DEL_IBSS_STA if the interface support IBSS
mode, so that stations can be resetted from user space.

mac80211 already deletes stations by itself, so mac80211 drivers must
already support this.

This has been successfuly tested with ath9k.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 net/mac80211/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2b5ba3ac09..02f36590c01d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1065,6 +1065,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				      NL80211_EXT_FEATURE_EXT_KEY_ID);
 	}
 
+	if (local->hw.wiphy->interface_modes & BIT(NL80211_IFTYPE_ADHOC))
+		wiphy_ext_feature_set(local->hw.wiphy,
+				      NL80211_EXT_FEATURE_DEL_IBSS_STA);
+
 	/*
 	 * Calculate scan IE length -- we need this to alloc
 	 * memory and to subtract from the driver limit. It
-- 
2.25.0.rc0

