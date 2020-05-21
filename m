Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A541DCA75
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgEUJtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgEUJto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:49:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D59C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:49:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so6037252wrt.5
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=L5hgR3ScM9kCl+6+EZ5ctodeKVTcZYOKQzyH7lseAGo=;
        b=IfqQfFH+DZUfo3RHEKmYBDR4aCE116Cz2ouRa1kJsa7QwgM/TVw0n9mLEvr/NCvAzT
         2iOOmlhzolHWfUH91wvid/FIXKuy8aEaK5t7XEqkhAPA+ZZStmXRqXJ1jcAwmDZx++SU
         bwBs0A1MpvAtA/nBjtZfYKXy+Dp2dwwgz2UpI01m7etx+vpfze3xlfZyycfncssQomOY
         +10hq+OP4bIfjUYUQedfhsCKjsgTm8Pmc+YSpXY6VONLTYi1bWvd6UwuoAfIgxj6eW7L
         bCfBgPNBS+rIBDQvMiWhJ/g5RDN9vzZIj+GHbzqhKJAk5LBPtSX2aonGCoE7rvvNaCk7
         0jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=L5hgR3ScM9kCl+6+EZ5ctodeKVTcZYOKQzyH7lseAGo=;
        b=GrX0sgGFAJ9bQnxqljn4BSeO0kdhd1BGtcgH2h87MpPyPjWtCIM2ggVCQ2HZIP7Ih/
         KKKhsEhyXy76x4m7caFFbq3e33xtNLz58L8Yn8/uu2QxPOB7xs+GquDhXAewV9fFugIY
         6x1L0bdMt1NGFqSFFdY7L8cQy+OosvevKA+a1cexIyS5Pph3yfW0ITWEiF45drYXFBlV
         QWGK8Ub61M3gWrPFTQL32dhng9YJInGtL6RxHQ0/WVkWbYQd4y4PyM6ypkJao5NdDrL2
         jn1g7k7thXeJBMmM0NYhYS2O7LlAK46tu47TS5CHFWWhMsJZJ2W0D3etCpowkshi3/ph
         g7fw==
X-Gm-Message-State: AOAM533kl8xyXsdj8GqP9v4Qwmn5kuuGtfuB9XFgGXZJawG2uUIyXHC6
        87ICmLz2gE61yQ1vrOtFczte2jMGwia81Q==
X-Google-Smtp-Source: ABdhPJw0BQBqdBSBX01iSr3Hrw293C4Q1sSJ3xSWwi9lk0bO9qkMwq0ntFa6d3DAoTtStKHkf7A4tw==
X-Received: by 2002:a5d:61d2:: with SMTP id q18mr7503030wrv.46.1590054582943;
        Thu, 21 May 2020 02:49:42 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id p7sm5916815wmg.38.2020.05.21.02.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:49:42 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 08/10] staging: vt6656: Move tx_key inside vnt_fill_txkey.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <1b964a6c-5cf7-e675-cf53-3a632acc0be9@gmail.com>
Date:   Thu, 21 May 2020 10:49:41 +0100
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

tx_key can be got directly from info.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index b9164142e2b5..a0672ca51138 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -382,12 +382,11 @@ static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head);
 }
 
-static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
-			   struct ieee80211_key_conf *tx_key,
-			   struct sk_buff *skb)
+static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 {
 	struct vnt_tx_fifo_head *fifo = &tx_buffer->fifo_head;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *tx_key = info->control.hw_key;
 	struct vnt_mic_hdr *mic_hdr;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u64 pn64;
@@ -629,7 +628,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (info->control.hw_key) {
 		tx_key = info->control.hw_key;
 		if (tx_key->keylen > 0)
-			vnt_fill_txkey(tx_buffer, tx_key, skb);
+			vnt_fill_txkey(tx_buffer, skb);
 	}
 
 	priv->seq_counter = (le16_to_cpu(hdr->seq_ctrl) &
-- 
2.25.1


