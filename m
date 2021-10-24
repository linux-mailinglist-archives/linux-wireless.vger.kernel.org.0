Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E27438BC2
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJXUS0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXUS0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 16:18:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC56C061745
        for <linux-wireless@vger.kernel.org>; Sun, 24 Oct 2021 13:16:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f16so2984951ljo.12
        for <linux-wireless@vger.kernel.org>; Sun, 24 Oct 2021 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59H4YP+8FVs7dxtAMpMerX1hrtP3cWNKONPn0AFnRV8=;
        b=B0rx8dGZemSXdHtoaMr7ERCl7mOAaeO28H80xzhyug+9qKj/2yV6heJtldlr9+goPW
         uIOH11hKD1v4jprHC0nzDlc4J7Z2Lj1/1RtAG1ebeOVk54YPqWp8szI5MVhSPuneMXq8
         Nbay79EHInJVvej334Cu+bJ8elmsKgCVzAwvQE6U670P9iIN7getQGL7DkC/IAGw8bnY
         9xf4o/Slaxyy+Vr7OPyWmdTeFnXRREGHRg4/RYQ+alu5o9FEIKSPW/Um2Y+ImwRTGLPX
         Z5rMxpIz6SQqTVIHlXqygXct3cz71s4Qz7qVTXfi0jpAeR9iX7EmS9hc6PxgTvcov4H0
         iw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59H4YP+8FVs7dxtAMpMerX1hrtP3cWNKONPn0AFnRV8=;
        b=qXIeMQYvfAomVEejnz7L9DvxaI8Jm+ZwurEtCHWvqM9njVzssVsWgBDf/+EkWARskW
         g/tVybFGL5e5nd6DtOtpxPapo7PQOnRUAg9iFrYTQgZdlA4WVxUTv1/OB2U7rpMQp5q5
         r2rzsSgR2WaPzJ7gMhGG9V5QFsi4tidi5bKasZYPlf0S+ZhbDK+GkE+hfqxhs4MEx5ks
         NKjiDfHcY+R88okUVXBDvO81JP/pQLDHlUr6/rdytcWW5euc4dNx5j/Rs0mVRsa2R80V
         MNkMactvuoy4An/JA5JaBZ21u1qIIuL0e/yCqyK6NqR2h0KxbNcNtPLLaMx3R9+JbtvL
         NHyQ==
X-Gm-Message-State: AOAM532rvtcwd9EAtjIzvH4WfKbUiOOww2vhi8w7rh368a/0R38qH3Kd
        Dp/pgZ5umUa5PFXN5XJ3zLZhPzuRf6s=
X-Google-Smtp-Source: ABdhPJwZZsmrEhsfkx0sajInI5Bc5sBIE4KvbGguR5v2qyFERQoZwcCqhXrpqmX44SjiWggKW8YBlQ==
X-Received: by 2002:a2e:9242:: with SMTP id v2mr14305060ljg.103.1635106563118;
        Sun, 24 Oct 2021 13:16:03 -0700 (PDT)
Received: from localhost.localdomain ([62.141.192.106])
        by smtp.gmail.com with ESMTPSA id u25sm1413689lfr.279.2021.10.24.13.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 13:16:02 -0700 (PDT)
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] cfg80211: move bridge/4addr mode check
Date:   Sun, 24 Oct 2021 22:15:46 +0200
Message-Id: <20211024201546.614379-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Without the patch we failed:

janusz@t2:~$ sudo brctl addbr br0
janusz@t2:~$ sudo brctl addif br0 wlp1s0
janusz@t2:~$ sudo iw wlp1s0 set 4addr on
command failed: Device or resource busy (-16)

Last command failed but iface was already in 4addr mode.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 18dba3d7c638..c0c87541326f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1028,14 +1028,14 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 	    !(rdev->wiphy.interface_modes & (1 << ntype)))
 		return -EOPNOTSUPP;
 
-	/* if it's part of a bridge, reject changing type to station/ibss */
-	if (netif_is_bridge_port(dev) &&
-	    (ntype == NL80211_IFTYPE_ADHOC ||
-	     ntype == NL80211_IFTYPE_STATION ||
-	     ntype == NL80211_IFTYPE_P2P_CLIENT))
-		return -EBUSY;
-
 	if (ntype != otype) {
+		/* if it's part of a bridge, reject changing type to station/ibss */
+		if (netif_is_bridge_port(dev) &&
+		    (ntype == NL80211_IFTYPE_ADHOC ||
+		     ntype == NL80211_IFTYPE_STATION ||
+		     ntype == NL80211_IFTYPE_P2P_CLIENT))
+				return -EBUSY;
+
 		dev->ieee80211_ptr->use_4addr = false;
 		dev->ieee80211_ptr->mesh_id_up_len = 0;
 		wdev_lock(dev->ieee80211_ptr);
-- 
2.25.1

