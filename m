Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08C19FE1C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgDFTdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 15:33:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36677 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 15:33:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so948159wrm.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9iA2Xd8MbX8MeDRK88rJx+tp22J+csXn1fYwh/6669Q=;
        b=ZKbN0mIcat8AnMyiIpDXBdZfwuSYvXH9wmzYqosDdkyPbuKZ/6q5/ZCsYH0nKkl1OC
         vUy+C13qFfaU8fkDvZhV99e0mLrKhazn2oDSOZpe1jwR/SSPtVp8p8OzFer7JcNtQv3n
         AdR27SakYSyi4Yb71lxR7WfwHUvTPc73w0S+vZM3xa1a7L2aDAs5BR/vfMpPp1XoH1U3
         a9RK9Pkt93iFupvLfsjYGyS1CpeVwjVN4EbBjM8/caKuRVfysFIofZGwuWwHXRec17af
         EH1os5Dv3AmGyz78YcTTiVdSKqjQfd12IVhb1pIRsI+nER8A2W4Q/0ILPGE//OL5V4PR
         I2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9iA2Xd8MbX8MeDRK88rJx+tp22J+csXn1fYwh/6669Q=;
        b=EMRRU8fGl5LH+yR+LQfRoZA6g8dTvxmGc67o/SHuqpe7TwiZhifnapMeHjLlFXM/zk
         2ucPaTCyBwyHEEfF6OB8xKLTaYIhJkbPJEpGdib8zy/06rhA4vEZiHSGp53cYAq829gr
         SrDJWPGCD90ORsDrL/K4KU1RmTc+W30/CTw9PbE29QnnqgPo9PDy7QoNTUzrQDnmx/2c
         MebrxPcAmtmuOomlRKVkZZQZfX1zfoWU5Xf9meY9KKlejjiq7sivWbYdyetV/01JQjvv
         02Ql4QAco9ESnDaKDzz5PYgT8/SidFRkcNBg6TKk0bvoK3+T6jOTlC5WFQB0T/AtWL+W
         7dpw==
X-Gm-Message-State: AGi0PuZ9elzxgF+BMgXEf78FaRD17v3WLSz4Tybp9scb5xWkUOctxHck
        eV5YHHeF6QS/svVFI+mpVsEeEz4X
X-Google-Smtp-Source: APiQypL4fvmGlhMGPgPei4Tsk9B1DFmsaSIxmo16sVa47FV5d1fNgoXR/lKeS4OiLgjM0S+0BPqe/w==
X-Received: by 2002:a5d:4988:: with SMTP id r8mr826012wrq.248.1586201597794;
        Mon, 06 Apr 2020 12:33:17 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id r5sm675404wmr.15.2020.04.06.12.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 12:33:17 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2 v2] staging: vt6656: rxtx remove rate change and
 current_rate.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <3ba896aa-5ab2-affb-9ce5-7df8a9b3190a@gmail.com>
Date:   Mon, 6 Apr 2020 20:33:16 +0100
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
v2
Patch 1 had wrong array.

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
