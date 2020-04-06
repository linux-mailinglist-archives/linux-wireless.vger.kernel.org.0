Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03919FD85
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDFSvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 14:51:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44865 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDFSvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 14:51:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id c15so710031wro.11
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PlDcioV+gnhbvYxESnioPwQjMSjmR4pFywSvYz8CRaw=;
        b=N/c+pwD3SnOUCUhW8l+P23DvLVIEyqcb4oDgfOrdq3a1XdhskcACjdPjmmvpUveP6p
         JxZHXrmetCDjwYPZKPq4yCVR3MTDYSIuMYsQrgWi0tyywJaktb8B59PsHH33ZW0ddDXl
         Z4KyXUH7u5X3LCpvwGS4uweBuvB3iqu44ee1Q3DB3ccEASEKy4W1TPggVMb685HH1myt
         PNdsukBCMI5Z6D9ivXFZFYUOYLYcO4yR6USTNM2+AJo8I15UCV4y4/WEOGzPRyhcxoNO
         NesEmRyP8kdVgF1fqTxvTo0ZTqv9Vx/Y+L2e2GtMSxolN3JBA80pn2oMJCeNj9VoS5dd
         a1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PlDcioV+gnhbvYxESnioPwQjMSjmR4pFywSvYz8CRaw=;
        b=Rq6q3bYCZu+iqUO8g1R7vv1B0ykHcxk6wqiiCDnw26e1o3gcrJGfCvppKplcvt5yCX
         TPzyq8zr5E+LY4mduTRnuBr/f70SpRLmQvH1TXEAvS5GzDlhhunPdsVHqH1YTA7YtlCI
         akc/1UJUELFu0QAVzcmkbJtU9HUl5Di08VGDCLkvJ0QIu7lEmk26+/+xkmnPDBZ4P02L
         7kuUY1E7KSi3C0LG7en8jRqi20au9VpfuOJsfR60vNWIhVAumR4mUc/gb9GuKb8s//Xf
         qXfeo0jsubhW6Rz4GCR3sElL4KR5GNEIpaQw2ew8XPY6yJZ8GN3fPcntwec1GCJs//l5
         4adg==
X-Gm-Message-State: AGi0PuZSUo8FBl/5XIwccbZBTUKKdfiq8Nf/pxdMeAQUtWSJmYEKRxnk
        k4FQjpFZl2JM+RP3aUTJAzLwx2+K
X-Google-Smtp-Source: APiQypI6qiFTQOiJqI0CQIVwLU/I4RHHR2z+fPWe+M8VfvovoFRryMNi07t77TgDNOsx5HxYbJeNmA==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr596808wrs.333.1586199112710;
        Mon, 06 Apr 2020 11:51:52 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id t81sm619414wmb.15.2020.04.06.11.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 11:51:52 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: rxtx remove rate change and
 current_rate.
Message-ID: <fddf4e67-a9a0-521a-3b3b-5c1d0778bc9d@gmail.com>
Date:   Mon, 6 Apr 2020 19:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no longer any need to change power in vnt_tx_packet.

Remove current_rate in vnt_tx_packet and struct vnt_private as
it is no longer used elsewhere.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h |  1 -
 drivers/staging/vt6656/rxtx.c   | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index e6ee9411f080..41226cd599c6 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -344,7 +344,6 @@ struct vnt_private {
 	u8 ofdm_pwr_tbl[14];
 	u8 ofdm_a_pwr_tbl[42];
 
-	u16 current_rate;
 	u16 tx_rate_fb0;
 	u16 tx_rate_fb1;
 
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 9439d190f431..8363d54cd821 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -547,7 +547,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	struct vnt_tx_fifo_head *tx_buffer_head;
 	struct vnt_usb_send_context *tx_context;
 	unsigned long flags;
-	u16 tx_bytes, tx_header_size, tx_body_size, current_rate, duration_id;
+	u16 tx_bytes, tx_header_size, tx_body_size, duration_id;
 	u8 pkt_type;
 	bool need_rts = false;
 	bool need_mic = false;
@@ -556,14 +556,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	rate = ieee80211_get_tx_rate(priv->hw, info);
 
-	current_rate = rate->hw_value;
-	if (priv->current_rate != current_rate &&
-	    !(priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)) {
-		priv->current_rate = current_rate;
-		vnt_schedule_command(priv, WLAN_CMD_SETPOWER);
-	}
-
-	if (current_rate > RATE_11M) {
+	if (rate->hw_value > RATE_11M) {
 		if (info->band == NL80211_BAND_5GHZ) {
 			pkt_type = PK_TYPE_11A;
 		} else {
@@ -593,7 +586,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	tx_context->pkt_type = pkt_type;
 	tx_context->need_ack = false;
 	tx_context->frame_len = skb->len + 4;
-	tx_context->tx_rate = current_rate;
+	tx_context->tx_rate =  rate->hw_value;
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -666,7 +659,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 		tx_context->frame_len += tx_key->icv_len;
 	}
 
-	tx_buffer_head->current_rate = cpu_to_le16(current_rate);
+	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
 	duration_id = vnt_generate_tx_parameter(tx_context, tx_buffer, &mic_hdr,
 						need_mic, need_rts);
-- 
2.25.1
