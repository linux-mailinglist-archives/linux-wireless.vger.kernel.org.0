Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED26179921
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgCDTmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 14:42:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34739 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDTmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 14:42:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so3985054wrl.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6qRC4ZEtbivWf7pTzAk5IxR4VdJwhvQpCG+0bFg+YM8=;
        b=ktEiW56xdeKdtuxV6JycjdIeSOuDU+DLJkql6lFehEQ6ipsd3gxfTfN13k6vkyk/oU
         fiTD1gkRHSacfSo2cd/Kty+URVgl5nPRgjI8+VN/P0tzw7O/UJvkxcPBhdpBkaWa+/G+
         HiSXqdGoL86b2rRYjTz1MYQudJhVEcEGLHaqLKwssKSOfbF4R1M4780YsmpC8MNKVDe7
         rY+XC8byCFDx7pbmI3BkcRX+oCcKzo+5NLlcRFMgJsHhweVUkcgjR3IEWSybIjH71XYQ
         kgT+BdHAzF/dcq7bfPNO5KfxFQ9E14uqleMZNy7rSJNqzUm8r2phryqjSQxIsFVAqb19
         1OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6qRC4ZEtbivWf7pTzAk5IxR4VdJwhvQpCG+0bFg+YM8=;
        b=Pl9JRlV8k89pT15Bzq2Uoglv4CIiHmtDsVGLeZ2u79A6sxQsks7eUjZhgFOv8d4Y1/
         p65mKQvDteJAY7CbIzc13lAQEhffAuJM8undW93a93bSBi0iwW+ugXSQEMP30NrCaqke
         e9VbMNcT7gx38LXN7JJecMEqJEc4iWShR2iT9XMGcqIaR4mQIL826k3Kv0ttVW2th4Do
         ZksdQv72chI95jAoc5afX9+E0IaYcEd5ZzHF7PkHHseEmmO8deXdxhXXNA90ozcfut8X
         PsuWlhEcH7RQ8T17JVlmo8R2smPffXSyuR6i0JGjHl4sGzERKDHgDSFgrDMsNF7ufOQG
         oAzg==
X-Gm-Message-State: ANhLgQ3jkxvKasD9JWEwQ/CDqogddBwMd8IL4xBJdMXyqgqA0d+iOhjq
        nLHxIbirqrV7LPOp6crWBGOXy5UL
X-Google-Smtp-Source: ADFU+vs59BIina8af35nFwom2zL+4XxJ4Hy5d3D0d+YfcTrWe3Bnxi9Vker7DxPtPdFCIT95KLagbw==
X-Received: by 2002:adf:8b1b:: with SMTP id n27mr5670686wra.324.1583350918287;
        Wed, 04 Mar 2020 11:41:58 -0800 (PST)
Received: from [192.168.43.18] (92.40.168.8.threembb.co.uk. [92.40.168.8])
        by smtp.gmail.com with ESMTPSA id i12sm26546110wrw.64.2020.03.04.11.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:41:57 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6656: Remove vnt_interrupt_buffer in_use flag.
Message-ID: <69585034-4318-4bec-7d9b-f64a167df237@gmail.com>
Date:   Wed, 4 Mar 2020 19:41:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 is the only user of in_use to start it and should
not be true when so.

So internal toggling of this variable is not relevant.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h  |  1 -
 drivers/staging/vt6656/usbpipe.c | 28 +++-------------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 5c9991415432..e94df4685b25 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -253,7 +253,6 @@ struct vnt_usb_send_context {
  */
 struct vnt_interrupt_buffer {
 	u8 *data_buf;
-	bool in_use;
 };
 
 /* flags for options */
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index b9e79755e7fa..fd2c9d9d6eb4 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -221,8 +221,6 @@ static void vnt_int_process_data(struct vnt_private *priv)
 		low_stats->dot11ACKFailureCount += int_data->ack_fail;
 		low_stats->dot11FCSErrorCount += int_data->fcs_err;
 	}
-
-	priv->int_buf.in_use = false;
 }
 
 static void vnt_start_interrupt_urb_complete(struct urb *urb)
@@ -237,25 +235,19 @@ static void vnt_start_interrupt_urb_complete(struct urb *urb)
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
-		priv->int_buf.in_use = false;
 		return;
 	default:
 		break;
 	}
 
-	if (status) {
-		priv->int_buf.in_use = false;
-
+	if (status)
 		dev_dbg(&priv->usb->dev, "%s status = %d\n", __func__, status);
-	} else {
+	else
 		vnt_int_process_data(priv);
-	}
 
 	status = usb_submit_urb(priv->interrupt_urb, GFP_ATOMIC);
 	if (status)
 		dev_dbg(&priv->usb->dev, "Submit int URB failed %d\n", status);
-	else
-		priv->int_buf.in_use = true;
 }
 
 int vnt_start_interrupt_urb(struct vnt_private *priv)
@@ -264,13 +256,6 @@ int vnt_start_interrupt_urb(struct vnt_private *priv)
 
 	dev_dbg(&priv->usb->dev, "---->Interrupt Polling Thread\n");
 
-	if (priv->int_buf.in_use) {
-		ret = -EBUSY;
-		goto err;
-	}
-
-	priv->int_buf.in_use = true;
-
 	usb_fill_int_urb(priv->interrupt_urb,
 			 priv->usb,
 			 usb_rcvintpipe(priv->usb, 1),
@@ -281,16 +266,9 @@ int vnt_start_interrupt_urb(struct vnt_private *priv)
 			 priv->int_interval);
 
 	ret = usb_submit_urb(priv->interrupt_urb, GFP_ATOMIC);
-	if (ret) {
+	if (ret)
 		dev_dbg(&priv->usb->dev, "Submit int URB failed %d\n", ret);
-		goto err_submit;
-	}
-
-	return 0;
 
-err_submit:
-	priv->int_buf.in_use = false;
-err:
 	return ret;
 }
 
-- 
2.25.1
