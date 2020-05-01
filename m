Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772241C110B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgEAKn3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728513AbgEAKn2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:43:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B220C08E859
        for <linux-wireless@vger.kernel.org>; Fri,  1 May 2020 03:43:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so753436wrt.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2020 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oLW9QP+uFGtsQ3xitP0v7EQjyBZf41Mp396PMAaih5A=;
        b=lt8r7KZmIrSb+h7Kq01GabPqoAJcdIIaoL1HtjyFmdjosIaCSl4BII75tL1IYdSG3z
         7EN+A6EfOul+LdCgtmY4htqbh6PLpJ5FXblp6djtII7DGpkVUncLLZP3/7NqznYwneLs
         TQu1T6GB7hR1DfVm69BzA2+xRYg+sCtAQeEOXoD2rK5xzWhSdWBGvziOHCH5v5oQvA8N
         AyGDrJGwZuBKetuzKLr+9i3/KeDsrhIIeR/TwTM+UReP4tlkOQxqH2+fL7D+aspSwrRi
         PHzsYcZdRka/EtyyQlxS4B2JH+OHyUnd3zbLhvveOwwqug1hMWZuZMJGT/C8wcdqQ8t+
         c9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oLW9QP+uFGtsQ3xitP0v7EQjyBZf41Mp396PMAaih5A=;
        b=DdZZSWSE2Q6QY/uSVCuG/UTLOtgbSalMs+e8NFA6CQcUkcKV6wTiUWH34Ap9XhIbFk
         kIqMoQ3VIXtEE/CQ1OT/G49ERdgIlcvk9DN5DYSoHMv+ABTHnYKVPVfpeoKRzr2DBrDy
         20GfOQKtwA9PFfv/8YYlHS7QxQbvmgpEIemSXuonu3kiu06iBUXHV/i5ME1XqGmFpJBv
         Uz5fMymwF+GLSBvfg8f7aeZfb6ZfWTpInPFayv3o+LWjbdzOZ7qMnYqDuQ3M+JCIGEqz
         6Klgk+0dPHsXhEFyeqW9BOocJW0+baxTQKQfhkIcozNXNB/1NYwUYw8rIpong5wEfbeV
         eg8g==
X-Gm-Message-State: AGi0Puby9wr+bxgnyEKLSorZN/kcKvQ59XcTpBO95i04ULs6IeEzkb0A
        uTHNYlnrFHA619gGOIlQgjQ=
X-Google-Smtp-Source: APiQypIwB3DpAzLiDZDKqvBs2eET4ezmu9OlTO4vA1B6CgCw90t+Q73igEikzDaW7CC6/o/IVfoslg==
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr3526222wrs.230.1588329807308;
        Fri, 01 May 2020 03:43:27 -0700 (PDT)
Received: from [192.168.43.18] (94.197.121.192.threembb.co.uk. [94.197.121.192])
        by smtp.gmail.com with ESMTPSA id a24sm3336487wmb.24.2020.05.01.03.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 03:43:26 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <malcolmpriestley@gmail.com>
Subject: [PATCH] staging: vt6656: Return on isr0 when zero.
Message-ID: <8dccc74d-d0bb-e8e7-df81-dfd81e3fd7d8@gmail.com>
Date:   Fri, 1 May 2020 11:43:25 +0100
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

When isr0 is zero there is nothing more todo so return and
pull following code in.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/usbpipe.c | 47 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 91b62c3dff7b..e8efdeadb1a7 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -196,32 +196,31 @@ static void vnt_int_process_data(struct vnt_private *priv)
 	if (int_data->tsr3 & TSR_VALID)
 		vnt_int_report_rate(priv, int_data->pkt3, int_data->tsr3);
 
-	if (int_data->isr0 != 0) {
-		if (int_data->isr0 & ISR_BNTX &&
-		    priv->op_mode == NL80211_IFTYPE_AP)
-			vnt_schedule_command(priv, WLAN_CMD_BECON_SEND);
-
-		if (int_data->isr0 & ISR_TBTT &&
-		    priv->hw->conf.flags & IEEE80211_CONF_PS) {
-			if (!priv->wake_up_count)
-				priv->wake_up_count =
-					priv->hw->conf.listen_interval;
-
-			if (priv->wake_up_count)
-				--priv->wake_up_count;
-
-			/* Turn on wake up to listen next beacon */
-			if (priv->wake_up_count == 1)
-				vnt_schedule_command(priv,
-						     WLAN_CMD_TBTT_WAKEUP);
-		}
-		priv->current_tsf = le64_to_cpu(int_data->tsf);
+	if (!int_data->isr0)
+		return;
+
+	if (int_data->isr0 & ISR_BNTX && priv->op_mode == NL80211_IFTYPE_AP)
+		vnt_schedule_command(priv, WLAN_CMD_BECON_SEND);
+
+	if (int_data->isr0 & ISR_TBTT &&
+	    priv->hw->conf.flags & IEEE80211_CONF_PS) {
+		if (!priv->wake_up_count)
+			priv->wake_up_count = priv->hw->conf.listen_interval;
 
-		low_stats->dot11RTSSuccessCount += int_data->rts_success;
-		low_stats->dot11RTSFailureCount += int_data->rts_fail;
-		low_stats->dot11ACKFailureCount += int_data->ack_fail;
-		low_stats->dot11FCSErrorCount += int_data->fcs_err;
+		if (priv->wake_up_count)
+			--priv->wake_up_count;
+
+		/* Turn on wake up to listen next beacon */
+		if (priv->wake_up_count == 1)
+			vnt_schedule_command(priv, WLAN_CMD_TBTT_WAKEUP);
 	}
+
+	priv->current_tsf = le64_to_cpu(int_data->tsf);
+
+	low_stats->dot11RTSSuccessCount += int_data->rts_success;
+	low_stats->dot11RTSFailureCount += int_data->rts_fail;
+	low_stats->dot11ACKFailureCount += int_data->ack_fail;
+	low_stats->dot11FCSErrorCount += int_data->fcs_err;
 }
 
 static void vnt_start_interrupt_urb_complete(struct urb *urb)
-- 
2.25.1
