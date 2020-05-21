Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4330A1DCA11
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgEUJdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgEUJdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:33:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BAC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:33:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so5965230wrc.8
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TRsInQSBwN+shLNJB6dj9nN2OgX9fcoBCx1Y8zTY1JE=;
        b=kqgstXurDIFYnkHExtT62KqsA7sxo8V5X8yBsY+QlbYBBsrH8oEFGFkOD8nhkCm8x+
         Slbed7rXS/DzANGdhdtfJhcvC0uwbdy/sI/+GuU7WLj4wO09I62QCfGzybutw8HSFry2
         Fw0rBUluxG/MlZ6zDbOjKO3X7z/1qq/0lKAgACmeIrNKKvl4xn3Yvc2d2TIl7/IYzNxe
         YdUZar/wsb/hz99bvqs1HRLn4Vv044mT8MvVQpxlFAO/AbwVXJKXcxR8Lg72E8lTLUvx
         L10KKDBnXj8S2Xwt10oknp7naZLXCqV2HcaAqnghSUyIGMFmqlqzAZ7MCZ88eO8NX3eU
         Hx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TRsInQSBwN+shLNJB6dj9nN2OgX9fcoBCx1Y8zTY1JE=;
        b=t8oktODWeLbNIQLE6rU9SHWGhcYD71OhngcnkzWhKVYs6UwyZZUEGPW37nf540hwjA
         zWKOfqBVdIRl55V0mvhbnzyPtVE6zKakFaoTP25Z9JGDkUWzJZUTOP4LjXcqqTMunie5
         UqvXXdKZTYTAvb8m3sBYVw4C1qrgDPbovRaw0+WguMP3UY5sYl2IMkf4bz/FjKdr1Mwb
         3vi/aQ7QRxB0yEtZ5MicNohEknmY7gv3F8ElPQiKkpWcnnVakyE0/Ce8sdd8gMYKZHXf
         wJcnHd8uOI4B+t9EFIyQij7DUSnpGzrnPryTLMImC8fffUL+ZAxvnoupMNZd4hOL2LaC
         HxUA==
X-Gm-Message-State: AOAM530KgiKypaaBfUxtD6TVDLjlgsNmlPUIumgOgr6lxhQtcG7iNzZJ
        ygmE13BDBpdJkQc38VlKKRUZo6ilkKzw8A==
X-Google-Smtp-Source: ABdhPJzAaHKK0g2fpCO5WomK+FhJORBjK6lJ0C8ilrGJjwYls4pqfsTh5rLTN3WJifhnZgS6CJ+Tzg==
X-Received: by 2002:adf:9d91:: with SMTP id p17mr7454308wre.119.1590053592966;
        Thu, 21 May 2020 02:33:12 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id 89sm5966904wrj.37.2020.05.21.02.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:33:12 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 02/10] staging: vt6656: rxtx remove unused need_ack
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <f19dfbde-23a6-ba79-d988-576d2e3bcf62@gmail.com>
Date:   Thu, 21 May 2020 10:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

need_ack is no longer used by driver remove it.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h | 1 -
 drivers/staging/vt6656/rxtx.c   | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 0486aabba061..d89f564a13c4 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -246,7 +246,6 @@ struct vnt_usb_send_context {
 	u8 type;
 	u8 pkt_no;
 	u8 pkt_type;
-	u8 need_ack;
 	bool in_use;
 };
 
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index a47f42bedfa9..24acc2de0fb9 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -539,7 +539,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	tx_context->skb = skb;
 	tx_context->pkt_type = pkt_type;
-	tx_context->need_ack = false;
 	tx_context->frame_len = skb->len + 4;
 	tx_context->tx_rate =  rate->hw_value;
 
@@ -587,10 +586,8 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 			cpu_to_le16(DEFAULT_MSDU_LIFETIME_RES_64us);
 	}
 
-	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
+	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_NEEDACK);
-		tx_context->need_ack = true;
-	}
 
 	if (ieee80211_has_retry(hdr->frame_control))
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LRETRY);
-- 
2.25.1


