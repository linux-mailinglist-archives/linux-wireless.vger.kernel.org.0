Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAA1DCA5C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgEUJoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgEUJoA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:44:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1751BC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:44:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g14so1864927wme.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NTVAkejfWjyTo7BhK8Y0RFgpAEQ+hg4BcBIQrLv9Jg0=;
        b=or3At3+vnVNGd1BP8JClD0lCgdiTn8J9T6bzZu3g7Uak8IqNsRAn+HDLNRZ6cbMT3N
         qaJhVQJnKR8l8ErAp13b8HITNA66m+wYRe38MXwlDPdt8RAULvKh8Ltw1jAuI18BvEzs
         wcJKmh31giOv1DVodw/H8Mi99cgdV+h3YqoAcmInN9V+EbNhjrq/vumNcCCPWSAKlJFh
         nOIXoIfC0XK8n9WrxAApKoluRyZw7klHk3IV9xw2NUoOMVrVa7Of02O6LIZ5OWTqS4Ff
         d49SujfDVD4Zmvm4bunGfYquVQBQXyTye4PPLRLitVGeofZWdem9a0I42MW0OHPyZ9S1
         w4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NTVAkejfWjyTo7BhK8Y0RFgpAEQ+hg4BcBIQrLv9Jg0=;
        b=ml0cyMhs+iYa7tHLUQauKDxp6Vx43QD4gWVlOEYHo+HRnn2ZTiFlDs8tmPjU2Z6wRj
         NZv6tMbcEvQIBnAC8CrRoKRPfSb4sg/1b0gWjb83DRgAn2hYcODDSep2vvnvVqG5TbeW
         n5i/8+e7uGxKidzjtO7IupM5nqinBTepPOWEfA8IZv+csOP6G/+MHKvbm7AxHYuxibgx
         2YM6R1z6QrNnegSD2yZGZ40lT4MTl5anzF/rC+FFVo4M7GCDjIQYer+LWNT7r2/Nfbxt
         z7Fqb/dbTsQAVUPSe77QGnFY4km2GYDjp6RBvSg4/IquQlYP01iC+K2n967WE2luqiL8
         RYrA==
X-Gm-Message-State: AOAM5300IaJD+C2hXnSWbzRka7SbbFks1hdzl+JvQmuR5IgNx6qx7czX
        B+zudL2IzJL8aZEe4ZJqcbNJy+8tvPRbbg==
X-Google-Smtp-Source: ABdhPJypf8AGniJpVL9QoUsOpQ7x1p30DAxkPKMXrG0jtkJfXkQHrbdEdYNaD/YZSkkihf//UBeQ6g==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr8741185wmc.189.1590054238661;
        Thu, 21 May 2020 02:43:58 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id a10sm6041034wmf.46.2020.05.21.02.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:43:58 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 06/10] staging: vt6656: Move key_buffer inside vnt_fill_txkey.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <3631f327-1386-90a2-ba9a-bb62617f3c66@gmail.com>
Date:   Thu, 21 May 2020 10:43:57 +0100
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

Use vnt_tx_fifo_head to point directly at tx_key removing key_buffer.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 310d0eccebd1..2d7a8fc70d92 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -383,9 +383,10 @@ static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 }
 
 static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
-			   u8 *key_buffer, struct ieee80211_key_conf *tx_key,
+			   struct ieee80211_key_conf *tx_key,
 			   struct sk_buff *skb, u16 payload_len)
 {
+	struct vnt_tx_fifo_head *fifo = &tx_buffer->fifo_head;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct vnt_mic_hdr *mic_hdr;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
@@ -399,18 +400,18 @@ static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
 	switch (tx_key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
-		memcpy(key_buffer, iv, 3);
-		memcpy(key_buffer + 3, tx_key->key, tx_key->keylen);
+		memcpy(fifo->tx_key, iv, 3);
+		memcpy(fifo->tx_key + 3, tx_key->key, tx_key->keylen);
 
 		if (tx_key->keylen == WLAN_KEY_LEN_WEP40) {
-			memcpy(key_buffer + 8, iv, 3);
-			memcpy(key_buffer + 11,
+			memcpy(fifo->tx_key + 8, iv, 3);
+			memcpy(fifo->tx_key + 11,
 			       tx_key->key, WLAN_KEY_LEN_WEP40);
 		}
 
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
-		ieee80211_get_tkip_p2k(tx_key, skb, key_buffer);
+		ieee80211_get_tkip_p2k(tx_key, skb, fifo->tx_key);
 
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
@@ -452,7 +453,7 @@ static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
 
-		memcpy(key_buffer, tx_key->key, WLAN_KEY_LEN_CCMP);
+		memcpy(fifo->tx_key, tx_key->key, WLAN_KEY_LEN_CCMP);
 
 		break;
 	default:
@@ -628,8 +629,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (info->control.hw_key) {
 		tx_key = info->control.hw_key;
 		if (tx_key->keylen > 0)
-			vnt_fill_txkey(tx_buffer, tx_buffer_head->tx_key,
-				       tx_key, skb, tx_body_size);
+			vnt_fill_txkey(tx_buffer, tx_key, skb, tx_body_size);
 	}
 
 	priv->seq_counter = (le16_to_cpu(hdr->seq_ctrl) &
-- 
2.25.1


