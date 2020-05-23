Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0F1DFB9C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgEWXMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 May 2020 19:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbgEWXMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 May 2020 19:12:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66BCC061A0E
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 16:12:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u1so12071823wmn.3
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JmYrO0plrEP12CDs2l0y0uFQRQ9e6H6nwDIO9eVDLRQ=;
        b=B8RI7XDAkvSAtcSE/6JvRb0SJRj9aFJU06wIoHIQPi0ojIArr00WI5QASxzA+PmUPj
         FhcpjnitOH5chrQ31t2qYPgr2hQy0dyC8tWZIgglqSXAeXCLnq2duPEmvKYo+W7LgfLo
         Vhkj0GN7/R7vqvn8tAO5ScBP2m78EeJ0A7SQGUhus/Zij3DCCSeOBCXUrnsK693Yxyr+
         xNNvEbxoOwvwKHo3w4XyARBfeskQbgcoE8AVwHsCLDOT3a1Klkbf3AKY72g1vDhtFhIP
         b1ge/f66+JZd0BD//q00OC8nfD1MS0xX1urhKFUabng7ZykduiO2uwlNDeRhMSIPtTEe
         F6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JmYrO0plrEP12CDs2l0y0uFQRQ9e6H6nwDIO9eVDLRQ=;
        b=cohlzRWpIGKZCduMqDUuRdecDMWW5NoY7/n1scrqxSJXMNcZAnDJNT2ZmK5lztE76/
         ymxoqWCJH83/tRnt3QkE1C9X5BnEl4W09PRr1I0SMqwYJQwIONfaamWZOKEGppAC8UvE
         BmJBfzzWJ9XT2Go0W/wopzaG68dpeuGkaGLOwjMKzV14rllsZDhdh1Vjv6vQJOYFSOky
         +tiUmY0dH04gdMakLnE4qFR2GFl1kuyVri5kBV0THqcAqanchidG4TO1hliU2liQHCIr
         9L/VZVo0FCx0OjQbmBTPkyL8OqWH/PQkV9IMuf+zyPF5Lavclgbsp4GQ5881mhg0Y4kL
         VJ+w==
X-Gm-Message-State: AOAM531yMWFhQBTiFDNjWgJZ431Ofm3vMEQWwwd0R5SKsPSzsqcvFeKx
        pDG9SI5cobjl6LX+sOdWo9o=
X-Google-Smtp-Source: ABdhPJxjZXpEmBTyaPUtdzFGRipSkstDLhKjYz48SqJEQ9vwIEeWid4o0OtLK0peCMiA/R3s4cRfEg==
X-Received: by 2002:a1c:49:: with SMTP id 70mr17852711wma.184.1590275563369;
        Sat, 23 May 2020 16:12:43 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.236.81])
        by smtp.gmail.com with ESMTPSA id s8sm12951131wrt.69.2020.05.23.16.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 16:12:42 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH] staging: vt6656: Fix vnt_tx_usb_header static checker warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, dan.carpenter@oracle.com
Message-ID: <9818e564-81f6-a683-caa0-69423fded401@gmail.com>
Date:   Sun, 24 May 2020 00:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

drivers/staging/vt6656/rxtx.c:729 vnt_beacon_xmit()
warn: struct type mismatch 'vnt_beacon_buffer vs vnt_tx_usb_header'

Since the only part of vnt_beacon_buffer is used remove and
replace it with vnt_tx_usb_header.

Fixes: 9deca1e3e2b6 ("staging: vt6656: vnt_beacon_xmit use extra_tx_headroom.")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 12 ++++++------
 drivers/staging/vt6656/rxtx.h |  5 -----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 9ee57f7c0c88..a1b16ef9b27f 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -634,7 +634,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 {
-	struct vnt_beacon_buffer *beacon_buffer;
+	struct vnt_tx_usb_header *usb;
 	struct vnt_tx_short_buf_head *short_head;
 	struct ieee80211_tx_info *info;
 	struct vnt_usb_send_context *context;
@@ -701,13 +701,13 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 	if (priv->seq_counter > 0x0fff)
 		priv->seq_counter = 0;
 
-	beacon_buffer = skb_push(skb, sizeof(struct vnt_tx_usb_header));
-	beacon_buffer->usb.tx_byte_count = cpu_to_le16(count);
-	beacon_buffer->usb.pkt_no = context->pkt_no;
-	beacon_buffer->usb.type = 0x01;
+	usb = skb_push(skb, sizeof(*usb));
+	usb->tx_byte_count = cpu_to_le16(count);
+	usb->pkt_no = context->pkt_no;
+	usb->type = 0x01;
 
 	context->type = CONTEXT_BEACON_PACKET;
-	context->tx_buffer = beacon_buffer;
+	context->tx_buffer = usb;
 	context->buf_len = skb->len;
 
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index fd64d0838e34..f3c7b99cda73 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -179,11 +179,6 @@ struct vnt_tx_short_buf_head {
 	__le16 time_stamp_off;
 } __packed;
 
-struct vnt_beacon_buffer {
-	struct vnt_tx_usb_header usb;
-	struct vnt_tx_short_buf_head short_head;
-} __packed;
-
 int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb);
 int vnt_beacon_make(struct vnt_private *priv, struct ieee80211_vif *vif);
 int vnt_beacon_enable(struct vnt_private *priv, struct ieee80211_vif *vif,
-- 
2.27.0.rc0
