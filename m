Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F81C62B8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 23:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEEVN7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 17:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEVN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 17:13:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C32C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 14:13:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so64007wmg.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SxoGNbx/SjEjX8E4Hfylau22uU5ODb774u0e2Ds9cX0=;
        b=cjRXihmYVgY/DEY8cx0GirJlX5d3QDZS3HLWZypl+C3mRXPKi6AmMRU3Tv6Sr/kVT1
         NZRFD9jfn9uAzz3EhgpSBmBiXDHw55duZKGWHD7JGJ0jI5zLXVOJh8YpEvee1RCZSDiG
         SAbMrIK2xGfBPCy5ofR1bv1E4Y4ZdvShBmeCtUHjg/uDqMEcMC0x7VVqbp6yQJNyD5ua
         RnyMKn5gjA4ZXIIYooDX4ceVnJS8+SP4L1h6BsyBwM93KLmIk2iDMdd/m37OpolmU9GP
         blYT8Zjy8lGrenpsCgEyXgO06hPQHSzJdujvSJz0Un3qKcR8VcK+NsCuyIz8VTajp1DD
         FDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SxoGNbx/SjEjX8E4Hfylau22uU5ODb774u0e2Ds9cX0=;
        b=MD3A3vAeUFyrhIiW4zHjgeyebZT7jTZfOxg0gWO5bVeDm66cPWZ/bZBdGaMT9HMZUi
         cGq1KF7zPpES4IvwgcjPAgfakqp48hYSNOIajBaI5HooLY1GT5bJ82sWYunbiRoRSFHA
         FcPgrHu+ym82ocLVy0ISayuyD1ATeU3Y02IbASduLqGryA3Vf6OcaiRqkc1yueZ6Sxis
         wpU12uCM/tc4twftOAE28NY3HzBZSM/4iwvzqUp9nWniFiDKI7zFHL9pY+jCh0MMmLWI
         p8NyHl03ohMvI2NaqM2j9hpPLBG98Bc4o1MoDHrwImVQPD3mRObe3xdBc/g/ykW+xON6
         5aWA==
X-Gm-Message-State: AGi0PuYWzItFlFwj+7/HpzLVGPTEJVZUMZly9o/XhIlwPT9II3J+C1q3
        AhN+J8GQI7EyszsTeGHbwB0IRPu4
X-Google-Smtp-Source: APiQypJgxGTND2E1DiYbST1RbWViLXfQvDD+e1P9B+SUKy7ccWb4fMfiookyvbBlS6BCs3HgStu/Iw==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr521963wmf.119.1588713237066;
        Tue, 05 May 2020 14:13:57 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.117.threembb.co.uk. [188.29.165.117])
        by smtp.gmail.com with ESMTPSA id a8sm5280774wrg.85.2020.05.05.14.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:13:56 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/6] staging: vt6656: vnt_get_rtscts_duration_le use
 ieee80211_rts_duration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <377a4cc3-cfe3-91aa-cf71-1063f311426a@gmail.com>
Date:   Tue, 5 May 2020 22:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

use the mac80211 ieee80211_rts_duration for RTS frames.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 6724b213a723..48fe16c27d3f 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -285,28 +285,18 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
 					 u8 dur_type, u8 pkt_type, u16 rate)
 {
 	struct vnt_private *priv = context->priv;
-	u32 cts_time = 0, dur_time = 0;
+	u32 dur_time = 0;
 	u32 frame_length = context->frame_len;
 	u8 need_ack = context->need_ack;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(context->skb);
 
 	switch (dur_type) {
+	/* fall through */
 	case RTSDUR_BB:
 	case RTSDUR_BA:
-		cts_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
-					      14, priv->top_cck_basic_rate);
-		dur_time = cts_time + 2 * priv->sifs +
-			vnt_get_rsvtime(priv, pkt_type,
-					frame_length, rate, need_ack);
-		break;
-
 	case RTSDUR_AA:
-		cts_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
-					      14, priv->top_ofdm_basic_rate);
-		dur_time = cts_time + 2 * priv->sifs +
-			vnt_get_rsvtime(priv, pkt_type,
-					frame_length, rate, need_ack);
-		break;
-
+		return ieee80211_rts_duration(priv->hw, priv->vif,
+					      context->frame_len, info);
 	case CTSDUR_BA:
 		dur_time = priv->sifs + vnt_get_rsvtime(priv,
 				pkt_type, frame_length, rate, need_ack);
-- 
2.25.1
