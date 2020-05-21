Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD71DCA0A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgEUJbk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgEUJbk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:31:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DAEC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:31:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so4780252wrw.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8Xy4F09kjG4qIrtXe0CxsoffCIloB6B/lxDeVupgx+c=;
        b=WOMHCO5r/+JSEOLRQoG3VeYHZXyajd4nIwrHzdZTMVxYgAVcJtB05oRN/b7D3TolcF
         uxhlTyhchzznNp8zN1t0/ne9LK1wzUoU5Pja8+R89KkeL+ZkrcNJa9pB9nxL2QCHygXk
         aKeW5qI5OhqFMMjcfYSfAXZnhGLfDsLFyvcHjUs9gb2PAbBh6ZcdG3jiujodbAQPlKXu
         MCowsC4d/ZAMmETSsVaQ/Yeil47+p6EZT2su6Up/Xt5gGi0GqaEBTXaXahHkDUe+I4Oq
         bpRN1Z3SWe3uQkQ+GD3ndyhBPGXvMzL0EtZ36BLKvmLkW0NHsttmlEml55oRnI9UD8EQ
         Axqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8Xy4F09kjG4qIrtXe0CxsoffCIloB6B/lxDeVupgx+c=;
        b=VZhfBMNwITunLjRyeLdXG7AWjBcjb7qQiwnA4EtiEl8YuDt/2OOXrTIu2FtBM+SEY5
         q/WdU/uacwX7rVM/MPONn6swkj0SRuw49P0iFOJJv+xZf7SzZxHq37zHAuIu93zmJObJ
         yD7h4pr0ETh4jAtvUQ5/6mPJaH9TdZq1dQXoneeLoSvz1EqoVueNlDPzFncjXcN5bcT0
         b+S62elH7eHBDhtTfa4MEyWgTEYPF+vCoUEwqDFpnIJJOM8bL2mMMvTX2wAXDpofDI1f
         0qcKsqd30iNnizlmc/CfUSfW/0I8kAxF7DBrR9u+yZ5g+VN9Os1VKQs2wsvr7VVoJHUR
         zg0g==
X-Gm-Message-State: AOAM530bzfj4VgfZPeK59xdlVI4+jL1fMpwZhpq9oqErFY9bHphD9AOC
        C+f+EPOtWGaoy7xS+8gs80GTDlfSl0iaYA==
X-Google-Smtp-Source: ABdhPJx+RjkbunaR4c0lPQOZgi/mZNT9ej++tVyCFe65wtpfyzXVGccrQLe7AQBay545mTqhhbQYLw==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr2922817wrr.337.1590053498236;
        Thu, 21 May 2020 02:31:38 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id g69sm929660wmg.15.2020.05.21.02.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:31:37 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 01/10] staging: vt6656: remove ieee80211_hdr from
 vnt_usb_send_context.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <556fab01-aa1e-154e-149e-c04feeb76efa@gmail.com>
Date:   Thu, 21 May 2020 10:31:36 +0100
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

It is only used in one place were it can be pointed to at skb->data.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h | 1 -
 drivers/staging/vt6656/rxtx.c   | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index d1b19dcaf991..0486aabba061 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -238,7 +238,6 @@ struct vnt_rcb {
 struct vnt_usb_send_context {
 	void *priv;
 	struct sk_buff *skb;
-	struct ieee80211_hdr *hdr;
 	void *tx_buffer;
 	unsigned int buf_len;
 	u32 frame_len;
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 8f9904c8045c..a47f42bedfa9 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -73,8 +73,6 @@ static struct vnt_usb_send_context
 		context = priv->tx_context[ii];
 		if (!context->in_use) {
 			context->in_use = true;
-			context->hdr = NULL;
-
 			return context;
 		}
 	}
@@ -392,7 +390,7 @@ static void vnt_fill_txkey(struct vnt_usb_send_context *tx_context,
 			   struct sk_buff *skb, u16 payload_len,
 			   struct vnt_mic_hdr *mic_hdr)
 {
-	struct ieee80211_hdr *hdr = tx_context->hdr;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u64 pn64;
 	u8 *iv = ((u8 *)hdr + ieee80211_get_hdrlen_from_skb(skb));
 
@@ -544,7 +542,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	tx_context->need_ack = false;
 	tx_context->frame_len = skb->len + 4;
 	tx_context->tx_rate =  rate->hw_value;
-	tx_context->hdr = hdr;
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-- 
2.25.1


