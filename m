Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE81B6611
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgDWVSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 17:18:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D71C09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 14:18:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so8364391wma.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3UMfdWcimBn25JH2myhA40azE0PlplXVveJxc9S5LYk=;
        b=uamWr4MnC2gvgpYgfAIoTG2UxaKYkmo+H+l1vvu+mlG+aJJkhnvh5nR+bkVjcBEYLx
         NCZyuMLSdXLuMGrWhTvfRkAE1oxzj/Tex41zV2hlhGRJf77rq+JVrsbp+Nn5wbmBjSON
         fztN2Y/voSToxjv3cnPgB+vpZ5gHTOWSQRA+aou4GYBKE66aDT+jifF5ztFBBFWwv8bb
         O1B7qrQFjtmSCXhMigoRppHUAV3ky63ayC3zweUP9OC1TLMw/8zZGvLEGfBoX/xQ6d4v
         cb5tDs1pMhXG3CNlb11iQzm4V9AZD6xdd4Uh7mx8p/TjlHy8MkIJVyH1lb60dPp34P/x
         /Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3UMfdWcimBn25JH2myhA40azE0PlplXVveJxc9S5LYk=;
        b=LcckocWLk97agMt3V2xQtNMPRF7Wtvo+QHnxW/R7GqrAIhmoj/nP2io7IQV3XqpEHJ
         pMWi6gph9F7DBoGsE42672365+B4cD7KmG8t+v73812JWbzbFel3axPTU9pvtIrFCNzk
         O0GX0mzuCJv4HsRI/YXOTNnGBhQWkqG+SFb+F2gnkG01jKUFm0fEpbHzVPc+G/iB1uv9
         zG37mKFDgOJaZFQxBDFBVtHbn/asB8e7kvmVvJ9aikr+xRR/wsVitArwPrdrX/2xhIVf
         2at/ziO6vK3Mu/Jz1UoflvM+hzwOrRcLDDil9Bt09CcXeslXwBpWc897IiAan46BLelZ
         WO7Q==
X-Gm-Message-State: AGi0Pub0O9JmhH+BQiqvoTJl+c7jtTekkyTUzKbkLDCgjh2g1xdJVi0T
        1/hxBqG09FbXAWcmKX27DsY=
X-Google-Smtp-Source: APiQypL14SL2t3MTWCC5IqHR6QKM17e2Mz6mwndEh3M6aXyfBYq39YCccjsK43uXeZBOPEM+4ZNhbQ==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr6615537wmi.50.1587676680314;
        Thu, 23 Apr 2020 14:18:00 -0700 (PDT)
Received: from [192.168.43.18] (94.197.120.138.threembb.co.uk. [94.197.120.138])
        by smtp.gmail.com with ESMTPSA id j3sm5373507wrw.28.2020.04.23.14.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 14:17:59 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: Remove preamble_type setting from
 vnt_tx_packet.
Message-ID: <04874ae5-0859-7cb5-619a-ac96a207be5d@gmail.com>
Date:   Thu, 23 Apr 2020 22:17:58 +0100
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

preamble_type is set in vnt_bss_info_changed no need to set it
here.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 7e15534e52ff..f56a2b02fe36 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -729,11 +729,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (ieee80211_has_retry(hdr->frame_control))
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LRETRY);
 
-	if (tx_rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
-		priv->preamble_type = PREAMBLE_SHORT;
-	else
-		priv->preamble_type = PREAMBLE_LONG;
-
 	if (tx_rate->flags & IEEE80211_TX_RC_USE_RTS_CTS) {
 		need_rts = true;
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_RTS);
-- 
2.25.1
