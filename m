Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB401DCA91
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgEUJ5v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgEUJ5v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:57:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90DC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:57:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so6094639wru.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fgA73O2odwNS1tE9Pa7tUkjFkww58qXLyvI3wxAGKjU=;
        b=agHXvB9IT1FaOvbx9VBAx1tGWOiHgA8EhJXKShdYxPUkSCTPsVQqA2rrQXzdtVILEd
         /LmY8fSF87tlAG977QQW770ocB5zu6WgVOTRbo/6e/5qPN6GMwqG7xj554qI0gWb7AWE
         J01Z8TgtSAR+a111SS9SN39QWkY5vUVp7xwzVQwhdjG7IkDkLoj6FVke4tzolDDlr+bu
         YQ27sdEpl2f7xgQ/RE75enP7jii02jV0Bnad7FjQCVMMyfDeieG7Ff8DpgDmOSOHaAYv
         L03lWd9MZrNfZ+4CBR5zPFBcd4JCUagdPpkeqcsyl+S4shqmQvqztlg70ZifhD3KG2jm
         3e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fgA73O2odwNS1tE9Pa7tUkjFkww58qXLyvI3wxAGKjU=;
        b=PS6HsqOq1kOsgaN9YfxIRsZoqhONsTPjUNPD+Q6SGa39CuYx/UaCG3AHL7EI9gVI8b
         Pskpr4gP7HdBOXhnZLx9Kmk6UQ5rVcP3dUMViubaAym7D0/U6JYar+tyeGcQaUuBpj1d
         t6u6E7UFxf38QpJDO23XwWGs8Nlyd/vi3xBAMyY1R8dMr7d1JZhLdvWqwDynnu2LZQa7
         /Wl9HamRz/M3N1ZZLfwSxzub8w5RKyajJtfb/L3nyyVOMNH6GA6psHpR9w9QDYIfMNrX
         JJrnKnRPC41by5NylHFKaKuPCGIlQXFbumTwnUiBDxeZrokwra1oLMTpBq98S4Q8e8k9
         Iqog==
X-Gm-Message-State: AOAM531vW9ixMhpJkfLsWWL3XQ8yV+K+QQ7NptVA6p9BssZaOvT/YJim
        u+NWbiTgITKqFe5oktu9PN/ZNgN4ZzDtVA==
X-Google-Smtp-Source: ABdhPJyfRUcGXaKzvRC6WobHIyznva1VDzu0wm3fu0c2BI7bVUcUR9g3IzrGd0Bs0XkF+Zydj5CI8A==
X-Received: by 2002:adf:8302:: with SMTP id 2mr8201081wrd.114.1590055069527;
        Thu, 21 May 2020 02:57:49 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id a12sm5724063wro.68.2020.05.21.02.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:57:49 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 10/10] staging: vt6656: move key frag controls to
 vnt_fill_txkey
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <bb91b159-387a-005b-f614-c541de128c40@gmail.com>
Date:   Thu, 21 May 2020 10:57:47 +0100
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

vnt_fill_txkey now has access to tx_buffer move cipher frag controls

The icv_len is the only thing needed from hw_key in vnt_tx_packet.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index bbe449af8acf..9ee57f7c0c88 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -323,10 +323,12 @@ static bool vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 			       tx_key->key, WLAN_KEY_LEN_WEP40);
 		}
 
+		fifo->frag_ctl |= cpu_to_le16(FRAGCTL_LEGACY);
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		ieee80211_get_tkip_p2k(tx_key, skb, fifo->tx_key);
 
+		fifo->frag_ctl |= cpu_to_le16(FRAGCTL_TKIP);
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (info->control.use_cts_prot) {
@@ -369,6 +371,7 @@ static bool vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 
 		memcpy(fifo->tx_key, tx_key->key, WLAN_KEY_LEN_CCMP);
 
+		fifo->frag_ctl |= cpu_to_le16(FRAGCTL_AES);
 		return true;
 	default:
 		break;
@@ -504,7 +507,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *tx_rate = &info->control.rates[0];
 	struct ieee80211_rate *rate;
-	struct ieee80211_key_conf *tx_key;
 	struct ieee80211_hdr *hdr;
 	struct vnt_tx_buffer *tx_buffer;
 	struct vnt_tx_fifo_head *tx_buffer_head;
@@ -606,23 +608,8 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	tx_buffer_head->frag_ctl =
 			cpu_to_le16(ieee80211_get_hdrlen_from_skb(skb) << 10);
 
-	if (info->control.hw_key) {
-		tx_key = info->control.hw_key;
-		switch (info->control.hw_key->cipher) {
-		case WLAN_CIPHER_SUITE_WEP40:
-		case WLAN_CIPHER_SUITE_WEP104:
-			tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_LEGACY);
-			break;
-		case WLAN_CIPHER_SUITE_TKIP:
-			tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_TKIP);
-			break;
-		case WLAN_CIPHER_SUITE_CCMP:
-			tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_AES);
-		default:
-			break;
-		}
-		tx_context->frame_len += tx_key->icv_len;
-	}
+	if (info->control.hw_key)
+		tx_context->frame_len += info->control.hw_key->icv_len;
 
 	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
-- 
2.25.1

