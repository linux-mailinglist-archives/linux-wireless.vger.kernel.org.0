Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452463FB8F8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhH3P1q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhH3P1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 11:27:45 -0400
Received: from mail-ej1-x663.google.com (mail-ej1-x663.google.com [IPv6:2a00:1450:4864:20::663])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7BFC06175F
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:51 -0700 (PDT)
Received: by mail-ej1-x663.google.com with SMTP id a25so31959305ejv.6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2uVTuwcLjTSUuIq5c/WEDkXs600lH+++wZWmF9MwAhc=;
        b=syrrSH2jukk1mdT3xpuaAus6Qv5ZXaGbUjSuQOxvEddXwEIw1ehTTYrUEeX/xqlsqc
         bKYNjOh0jYBP1I/KHHYtLYnZ4Y2v1wz5BilVZdvO6m1JdkrQYDAexKBA5jSvp00YhfcI
         1wtuW+e58l+DOJD3DL+sOI/7JwXd35ZdQatzd2AkR6xhLvfSwvLKIXSTj6e4DBBhVBKA
         xXLCg1GlhrWchgm9dOMZ2cLiSgEa6337yV+CUJidCM6DkbTProKZbvs8PeKkGIVEfenl
         5Z7O9tOiPT6liDrTrHshbBaiawCPvhLdcIkFRhqUPo4sf75QOmaRbZLuykB8bepL2yGO
         isYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2uVTuwcLjTSUuIq5c/WEDkXs600lH+++wZWmF9MwAhc=;
        b=tojUz0+irPSpLQUoVGI6+Ze1uOYW0r5Ml2bpVhy1dO5nQUArhrvFN6Qot2uWAn6vsE
         BtJ0nA0KWcSoSmQbjAYDoe15sn/BTr+gJqX8SPn3psm1g77D7K8hyY1IgqsmvRKXtOcV
         ALi+KTEEADO6s8VnITArDYlMH5uPFIOdFaS85ykP7RXBK3fQeeoIzzBfd7vT5Z6Vqkli
         aZ+ESkdG6OINwyPODJaVQr3MOPQVB4JPNgnBe2r+VfmBHcfHSax0Y9B1xG9xxAQihvEt
         N88+FL43yZz2YUVMH6YW2mMRF34dclbobh/+jcicUjzmpr3Ort1ZbKu4QaQaXyMsHS4L
         VlPw==
X-Gm-Message-State: AOAM533g69KRutRsgomRDk+vpzdcuxpTiDO/2Gp0lVncRkTa0BNbW7oE
        hX7Wd/jZK7pZzY/mPQ0bv2VtwcdoX6ZufmD9cNpqZAIQATe1xrEFYPyeQ7/hdTvmqOpxKbwffd1
        llq85w4tvAYWJ50PEigREGHJOsfrmbKHvCZ7TbqobUaLXyOx596+Pv0LeEr7PFw6Ks7eq5W+T1L
        ZsISb9/1eMnmPA5IMnTqJStHpCZ24KiA==
X-Google-Smtp-Source: ABdhPJwnCjsrIHlEyn9wXMdBf+pkN0cXywPKmngP3zOO/Tehs6K3gDncrt/SCiV8uPJXhQUhOuxkPoG+glAt
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr24782327ejd.268.1630337209597;
        Mon, 30 Aug 2021 08:26:49 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id hd18sm127584ejc.43.2021.08.30.08.26.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Aug 2021 08:26:49 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.38] (port=37560 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mKjBR-0005mz-1M; Mon, 30 Aug 2021 17:26:49 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH v2 2/3] rsi: fix key enabled check causing unwanted encryption for vap_id > 0
Date:   Mon, 30 Aug 2021 17:26:45 +0200
Message-Id: <1630337206-12410-3-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
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
CC: stable@vger.kernel.org
---
 drivers/net/wireless/rsi/rsi_91x_core.c | 2 ++
 drivers/net/wireless/rsi/rsi_91x_hal.c  | 2 +-
 drivers/net/wireless/rsi/rsi_main.h     | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_core.c b/drivers/net/wireless/rsi/rsi_91x_core.c
index a48e616..6bfaab4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_core.c
+++ b/drivers/net/wireless/rsi/rsi_91x_core.c
@@ -399,6 +399,8 @@ void rsi_core_xmit(struct rsi_common *common, struct sk_buff *skb)
 
 	info = IEEE80211_SKB_CB(skb);
 	tx_params = (struct skb_info *)info->driver_data;
+	/* info->driver_data and info->control part of union so make copy */
+	tx_params->have_key = !!info->control.hw_key;
 	wh = (struct ieee80211_hdr *)&skb->data[0];
 	tx_params->sta_id = 0;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index f4a26f1..2aa9f0b 100644
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
index a3e4fd5..810485a 100644
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

