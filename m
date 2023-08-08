Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED9773BED
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjHHP6b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjHHP5C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:02 -0400
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776B5B95
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 08:43:54 -0700 (PDT)
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by forward203a.mail.yandex.net (Yandex) with ESMTP id 3605748754
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 18:27:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3c99:0:640:7c39:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 98BEA46CF3;
        Tue,  8 Aug 2023 18:26:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jQaGdD4DR0U0-3aoxAOA1;
        Tue, 08 Aug 2023 18:26:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1691508406;
        bh=HzciPL0UHcDSko7HoMRoD6OUrboLAVfN1ZdHJ8vTpHI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=foz7XxK+1I4FGZZAtpJTxJV4hc5y6m0JmmHiHopwDnrswJ81M/zBfreoYn2OtB511
         nSubwrMDlvTCbO9d9R81Kf2Z5DYG9nlTbqaCw32Wk1Tk+8axzMbSOmE50dcqXwuiRw
         vV6GuvJPiIawDy3zxSoV41gHim7JSKn5atRofTeI=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: ath10k: do not ignore value returned by ath10k_wmi_peer_set_param()
Date:   Tue,  8 Aug 2023 18:25:35 +0300
Message-ID: <20230808152542.91117-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not ignore value returned by 'ath10k_wmi_peer_set_param()' but
rather propagate it as the return value of the 'ath10k_set_key()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9cdd00575029 ("ath10k: fix TDLS peer TX data failure issue on encryped AP")
Fixes: 382e51c139ef ("ath10k: set WMI_PEER_AUTHORIZE after a firmware crash")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/mac.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 03e7bc5b6c0b..22e5ee151c49 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6663,12 +6663,14 @@ static int ath10k_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	spin_unlock_bh(&ar->data_lock);
 
 	if (sta && sta->tdls)
-		ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
-					  ar->wmi.peer_param->authorize, 1);
-	else if (sta && cmd == SET_KEY && (key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
-		ath10k_wmi_peer_set_param(ar, arvif->vdev_id, peer_addr,
-					  ar->wmi.peer_param->authorize, 1);
-
+		ret = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
+						ar->wmi.peer_param->authorize,
+						1);
+	else if (sta && cmd == SET_KEY &&
+		 (key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		ret = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, peer_addr,
+						ar->wmi.peer_param->authorize,
+						1);
 exit:
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
-- 
2.41.0

