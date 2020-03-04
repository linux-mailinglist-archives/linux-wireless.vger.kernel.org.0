Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12272179935
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 20:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgCDTqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 14:46:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgCDTqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 14:46:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id t11so3973386wrw.5
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 11:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yQqOnaNgqo9/pU61x9cE5W84q/MMvrOFd9j49w+kVT8=;
        b=oQkubaaCUXECeIMHdsEZ5kDdHWZI1vfkAkbD/bGVQTtzD0hECYz3g1mfG7NgAVOwA+
         RM7FzQUhX0MrzpDR6AyAnF99AyvbX0QA9m4gTgrc3+kzwdvb7waG7C5AmWdo5dABvW9E
         swObt4kml8Buz8sldjwIIb9unhu17/SFqTxoMjGwhXsByqinrrnfQE/IR4GHWADmSR/9
         YyqBoCYiVplGBt4mMRK2z1WfynEk1ynh+DTNgL0ynzP2p0rp21ZGzfMCLezpfaKfKRAG
         ECmOxv7ZcigrF4h+JN6eJGKpVRhNhgVcLMB95zkNeXEbmYDB/Hfl5HFQGLUa2r9btTUI
         d7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yQqOnaNgqo9/pU61x9cE5W84q/MMvrOFd9j49w+kVT8=;
        b=ZyZROnu0CAgkUm4USnWu4AEhmP7E9BnEO1Y/GSYh+xofof6he3lOs2VAV4txSqOV3X
         8uxrcBUrOEJ8ySTGfk+ED09kjeBCjpUNx+ls9kwCi8UO8KcSnt59FHslP1+CeT0J8E+P
         /Qb780F8HXPzdvxyE7G2PQj6yzNA88PXRkXloeKVTf3EiEeLRehWe6Ds5YYQE81aCNw5
         rCdF1Ltojyx0P0ZJdpHWVe8mg34h48Vkfo/IDMhA23uy2YeTCEF2EXo1WB15PYfdmsob
         5Fc8v8a1Zt5n+fsKkpP4s/hVhnL2K8t3EEanXTwklQfW3tBYlY6Zf6bTYF9Rfxejipbi
         Lo+Q==
X-Gm-Message-State: ANhLgQ1H/MznOav0hHqJxj5roRdXfNkYrc3dx4vQATxo8FhQJQLf2gF3
        kx0GWvFSR+2o5IzNas+XCOrh0cBS
X-Google-Smtp-Source: ADFU+vunlK+a37LieRWJlBzMTqmN8oDYgcLLYkHvqowrVp7siNYRP3fKIYbkjJy2iuf6t3M5Zba3sQ==
X-Received: by 2002:a5d:4e8b:: with SMTP id e11mr2502804wru.136.1583351164403;
        Wed, 04 Mar 2020 11:46:04 -0800 (PST)
Received: from [192.168.43.18] (92.40.168.8.threembb.co.uk. [92.40.168.8])
        by smtp.gmail.com with ESMTPSA id a7sm5327252wmj.12.2020.03.04.11.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:46:04 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: struct vnt_rcb remove unused in_use.
Message-ID: <130a4078-2502-a381-46c4-b473815e153b@gmail.com>
Date:   Wed, 4 Mar 2020 19:46:02 +0000
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

The variable merely toggles true to false and is unused.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h   |  1 -
 drivers/staging/vt6656/main_usb.c |  3 ---
 drivers/staging/vt6656/usbpipe.c  | 16 +++-------------
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index e94df4685b25..98793e15e80f 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -227,7 +227,6 @@ struct vnt_rcb {
 	void *priv;
 	struct urb *urb;
 	struct sk_buff *skb;
-	int in_use;
 };
 
 /* used to track bulk out irps */
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 41edadc74389..56f81785a118 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -478,9 +478,6 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
 			ret = -ENOMEM;
 			goto free_rx_tx;
 		}
-
-		rcb->in_use = false;
-
 		/* submit rx urb */
 		ret = vnt_submit_rx_urb(priv, rcb);
 		if (ret)
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index fd2c9d9d6eb4..eae211e5860f 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -393,10 +393,8 @@ static void vnt_submit_rx_urb_complete(struct urb *urb)
 	if (urb->actual_length) {
 		if (vnt_rx_data(priv, rcb, urb->actual_length)) {
 			rcb->skb = dev_alloc_skb(priv->rx_buf_sz);
-			if (!rcb->skb) {
-				rcb->in_use = false;
+			if (!rcb->skb)
 				return;
-			}
 		} else {
 			skb_push(rcb->skb, skb_headroom(rcb->skb));
 			skb_trim(rcb->skb, 0);
@@ -406,11 +404,8 @@ static void vnt_submit_rx_urb_complete(struct urb *urb)
 					       skb_tailroom(rcb->skb));
 	}
 
-	if (usb_submit_urb(urb, GFP_ATOMIC)) {
+	if (usb_submit_urb(urb, GFP_ATOMIC))
 		dev_dbg(&priv->usb->dev, "Failed to re submit rx skb\n");
-
-		rcb->in_use = false;
-	}
 }
 
 int vnt_submit_rx_urb(struct vnt_private *priv, struct vnt_rcb *rcb)
@@ -433,13 +428,8 @@ int vnt_submit_rx_urb(struct vnt_private *priv, struct vnt_rcb *rcb)
 			  rcb);
 
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
-	if (ret) {
+	if (ret)
 		dev_dbg(&priv->usb->dev, "Submit Rx URB failed %d\n", ret);
-		goto end;
-	}
-
-	rcb->in_use = true;
-
 end:
 	return ret;
 }
-- 
2.25.1
