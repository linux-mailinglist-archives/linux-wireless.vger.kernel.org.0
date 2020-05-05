Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDE1C62C4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgEEVPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729335AbgEEVPP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 17:15:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C950C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 14:15:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so177022wmc.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=EGVbbPzyVO01/FIopW3nxXbQ2QWRQV9JRxf2+f7pU/4=;
        b=P6UvQqflx2ZYERn4eaqY506W5Rur02ytOd9iAp3fhiX4TboDGEdGzxcvDCr5I7Osjl
         7pRzLT9GwIUgNFlOJ0S8AGI4AIH3IJWEg7EokoPNsFRK+18JotIzsCQIT/d6n+AoTeyM
         yShcJtOHQDHsDgt41qOf4nk00EU73qs3AzoGPuSWwjjOHPnvQCUBWD0rxB51p3b8Q50t
         gZai9+2CmLPODDxy1n+7N5ySATlkxaIFjssCrx24PyzowQI7qJ6dO1AvpXhtvB1pCAHi
         z04XJr1EGGag2UWWApHgdR725ORJ4ZQZniyt8n6eaAZSdo5M7dtIjNnrsNXDJ3fS9Ny2
         ZmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=EGVbbPzyVO01/FIopW3nxXbQ2QWRQV9JRxf2+f7pU/4=;
        b=VfPqm0gsc6XVuZI73K8IzVbIMcCuzb59HG033rlm2nOpvHPYWNCMv+FXlRwz/xv3ha
         tH/I1SW9ByKOXYax4BjPHlVTl0PYcdC/Ksl+DORRIJaFt5Kw1xhZbjjwx4TpHnQwGHv8
         vfvrBraUJv7wUkWwZAslOdf880CkIfrapL1M0g7DxM9HS5yQa9Pa8bWy+TuIJi/K0Fkh
         wCTOROL35FpPJ+PN9h6bbL1SALiFkOCPlBKnbsWhXfUSbMbjEmeEi6InIe+8LOHYB8fw
         ynTzUn377jca4j9zfkyr4wnllnnRmvd1Ui/UzVLczsb/0FWrDyUpW0Duvz8dE8p0TZTZ
         dfUQ==
X-Gm-Message-State: AGi0PubcGiZGvtgKDmoc90m22BZSov5Ew6b7GJ4+BY9sAvUtUofRtsq6
        fBo9diR27kNlHDkNnh5PnO4=
X-Google-Smtp-Source: APiQypKV8F3AYlmVJISg2XtrkQm49hI0dMxlxUu0DXgIwqB2WAr6o/1OsZu4cXhcCO65eCr/qDSWLA==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr546692wmi.147.1588713314066;
        Tue, 05 May 2020 14:15:14 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.117.threembb.co.uk. [188.29.165.117])
        by smtp.gmail.com with ESMTPSA id 145sm64647wma.1.2020.05.05.14.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:15:13 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 3/6] staging: vt6656: vnt_get_rtscts_duration_le use
 ieee80211_ctstoself_duration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <f12b3d71-eb61-340b-e473-83509d9bc38a@gmail.com>
Date:   Tue, 5 May 2020 22:15:12 +0100
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

use the mac80211 ieee80211_ctstoself_duration for CTS to self frames.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 48fe16c27d3f..27069ac60b15 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -195,27 +195,6 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 							[rate % MAX_RATE]);
 }
 
-static u32 vnt_get_rsvtime(struct vnt_private *priv, u8 pkt_type,
-			   u32 frame_length, u16 rate, int need_ack)
-{
-	u32 data_time, ack_time;
-
-	data_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
-				       frame_length, rate);
-
-	if (pkt_type == PK_TYPE_11B)
-		ack_time = vnt_get_frame_time(priv->preamble_type, pkt_type, 14,
-					      (u16)priv->top_cck_basic_rate);
-	else
-		ack_time = vnt_get_frame_time(priv->preamble_type, pkt_type, 14,
-					      (u16)priv->top_ofdm_basic_rate);
-
-	if (need_ack)
-		return data_time + priv->sifs + ack_time;
-
-	return data_time;
-}
-
 static __le16 vnt_rxtx_rsvtime_le16(struct vnt_usb_send_context *context)
 {
 	struct vnt_private *priv = context->priv;
@@ -285,9 +264,6 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
 					 u8 dur_type, u8 pkt_type, u16 rate)
 {
 	struct vnt_private *priv = context->priv;
-	u32 dur_time = 0;
-	u32 frame_length = context->frame_len;
-	u8 need_ack = context->need_ack;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(context->skb);
 
 	switch (dur_type) {
@@ -298,15 +274,13 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
 		return ieee80211_rts_duration(priv->hw, priv->vif,
 					      context->frame_len, info);
 	case CTSDUR_BA:
-		dur_time = priv->sifs + vnt_get_rsvtime(priv,
-				pkt_type, frame_length, rate, need_ack);
-		break;
-
+		return ieee80211_ctstoself_duration(priv->hw, priv->vif,
+						    context->frame_len, info);
 	default:
 		break;
 	}
 
-	return cpu_to_le16((u16)dur_time);
+	return cpu_to_le16(0);
 }
 
 static u16 vnt_mac_hdr_pos(struct vnt_usb_send_context *tx_context,
-- 
2.25.1
