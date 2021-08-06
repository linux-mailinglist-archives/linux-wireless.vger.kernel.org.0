Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA21B3E287E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245054AbhHFKYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244988AbhHFKXt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 06:23:49 -0400
Received: from mail-ej1-x664.google.com (mail-ej1-x664.google.com [IPv6:2a00:1450:4864:20::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6569C06179E
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 03:23:27 -0700 (PDT)
Received: by mail-ej1-x664.google.com with SMTP id c25so449036ejb.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Aug 2021 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BhuvLUtJjtdk95aNyv0UA+LJF/I1txEHciDn57ftEOs=;
        b=ARcrIcbM+sHbCsJLR/76nbk+upNQipH51iWxiRXHLHSWMVLbUoRIxTBW+7RlxgEK/l
         ErC0PTNZrTv2pwQIbvvySoSB44OG+hA/wFgGBzYB6H0sD3Xt0NFyaL3PMCZ9vn2n4e2E
         eaCIsFnXijU3DSvKIEHKNX1EsvE8N7+JUOQ25XmbNQid+UZKHd3mFQhaM+9VyI77xCt6
         LY6UQLKjyWlaXw3cE4k/bI+Qc7iPctBGwM7SFrxaBa5bkUUNLfplxNt3ENz6RAkuBXAI
         9FpkYZPMMSwbWjiZ5XR8cJezsyk/B8tJYJ5Nn9pq8SEJJtFgfU16CTcjFsumulT6BShl
         v6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BhuvLUtJjtdk95aNyv0UA+LJF/I1txEHciDn57ftEOs=;
        b=MZFnRY5pAjFPX7Nqh0oMB4Kb3IRwjCWlbN+NqqSuFikhqWu/dfcGq2Q+6tVXq09MDF
         ztzpcZ2NoBxvHRTxboG8w1rehixmb3KYpAcfCRyPUBvN/hkLPTq5AVp0mFZ2UlNN+NPq
         m2M0ucFwfBau3vKnhQTlH87fmY/GSXJlpWuGcnBje8FPEuREwuqrISTuDj+fwvUxg9mn
         cVgoaqUM43kvlotdL9XrxmNsaSbLAXcqxxjiWMERQ3mtgpUvwMz4XTbWPvFtvMjFL5Rx
         Czmvtziq1pY8Vw9sr1O2p/p4ys0ysOo3dnmQ3crwL6t791rvYuTyfw+wEfXyQD/JgezS
         G4Ww==
X-Gm-Message-State: AOAM530IgWuaJTaaeuVcSfPF2rgKBxiAtmTcnql8KUSwRH32p/p4pudr
        v8drJ1WUArzZActVBYQ9lJ3O0LPM08YzwW7y720OYmVvOyqOkQ4zlRi+ZOQPb7Q/ZShUd2ecxCN
        zAHFMIDWxKxSAhZD8ksFO28v/GCsLPblMwLHxlKaDON8HaPJo36fLHl+l0pka+ZhOBN/oikGCq4
        39/m7DrsaUX1NYbbRU7U0bcqmtjhWh5g==
X-Google-Smtp-Source: ABdhPJycEqDvPvPyAe4Sc7/bj6UmMWxEF20Q2S1pf2kHIbVEiUFp9a0Z75jDfBbkoGESQOTNkq0bvUk/0nnA
X-Received: by 2002:a17:906:7e04:: with SMTP id e4mr9068646ejr.225.1628245406131;
        Fri, 06 Aug 2021 03:23:26 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id f9sm323302edq.26.2021.08.06.03.23.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 03:23:26 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.14] (port=47598 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mBx0f-0006b1-NC; Fri, 06 Aug 2021 12:23:25 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH 2/3] rsi: fix key enabled check causing unwanted encryption for vap_id > 0
Date:   Fri,  6 Aug 2021 12:23:22 +0200
Message-Id: <1628245403-2517-3-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1628245403-2517-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1628245403-2517-1-git-send-email-martin.fuzzey@flowbird.group>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My previous patch checked if encryption should be enabled by directly
checking info->control.hw_key (like the downstream driver).
However that missed that the control and driver_info members of
struct ieee80211_tx_info are union fields.

Due to this when rsi_core_xmit() updates fields in "tx_params"
(driver_info) it can overwrite the control.hw_key, causing the result
of the later test to be incorrect.

With the current structure layout the first byte of control.hw_key is
overlayed with the vap_id so, since we only test if control.hw_key is
NULL / non NULL, a non zero vap_id will incorrectly enable encryption.

In basic STA and AP modes the vap_id is always zero so it works but in
P2P client mode a second VIF is created causing vap_id to be non zero
and hence encryption to be enabled before keys have been set.

Fix this by extracting the key presence flag to a new field in the driver
private tx_params structure and populating it first.

Fixes: 314538041b56 ("rsi: fix AP mode with WPA failure due to encrypted EAPOL")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 drivers/net/wireless/rsi/rsi_91x_core.c | 2 ++
 drivers/net/wireless/rsi/rsi_91x_hal.c  | 2 +-
 drivers/net/wireless/rsi/rsi_main.h     | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_core.c b/drivers/net/wireless/rsi/rsi_91x_core.c
index 3644d7d..c6c2903 100644
--- a/drivers/net/wireless/rsi/rsi_91x_core.c
+++ b/drivers/net/wireless/rsi/rsi_91x_core.c
@@ -400,6 +400,8 @@ void rsi_core_xmit(struct rsi_common *common, struct sk_buff *skb)
 
 	info = IEEE80211_SKB_CB(skb);
 	tx_params = (struct skb_info *)info->driver_data;
+	/* info->driver_data and info->control part of union so make copy */
+	tx_params->have_key = !!info->control.hw_key;
 	wh = (struct ieee80211_hdr *)&skb->data[0];
 	tx_params->sta_id = 0;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 76bf13a..8be8afa 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -203,7 +203,7 @@ int rsi_prepare_data_desc(struct rsi_common *common, struct sk_buff *skb)
 		wh->frame_control |= cpu_to_le16(RSI_SET_PS_ENABLE);
 
 	if ((!(info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)) &&
-	    info->control.hw_key) {
+	    tx_params->have_key) {
 		if (rsi_is_cipher_wep(common))
 			ieee80211_size += 4;
 		else
diff --git a/drivers/net/wireless/rsi/rsi_main.h b/drivers/net/wireless/rsi/rsi_main.h
index b983cc5..db1ab1d 100644
--- a/drivers/net/wireless/rsi/rsi_main.h
+++ b/drivers/net/wireless/rsi/rsi_main.h
@@ -139,6 +139,7 @@ struct skb_info {
 	u8 internal_hdr_size;
 	struct ieee80211_vif *vif;
 	u8 vap_id;
+	bool have_key;
 };
 
 enum edca_queue {
-- 
1.9.1

