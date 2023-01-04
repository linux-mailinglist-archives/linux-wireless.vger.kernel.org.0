Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7165CC5B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 05:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjADEWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 23:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjADEWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 23:22:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC6826E8
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 20:22:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso37816558pjp.4
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 20:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f30Wn9AFQRuhTIo8K7Emf29ohiZmBtNaV3a5neDcHwM=;
        b=lEYH4KuibHufn07IRyauvoCTnYkWnKshzWyRtpZjaGo8KUAmSZRunUvayNjwTqwBUL
         EV6xHFdYuNhXwp9uK7f2vn90TcDoq7lvf/zY0BTmjwOIulGn098oIK6UHIh3slP21Dnn
         gyTStei9W7aWt/2VBSk2S4ICd4JrQ9mFmgLQU4Ufj6kv9b7WQ38mp7tq0wGD1ZLz+Zvn
         rOW6NIDlCdBvcgBAuSdLt4wfxaoFUDiYJCKhmE3U1UPS7Q3tJgfsfOLKbm5RvdQiIQmD
         70I3eCJjM2dR5J0aR8Y2UfUJ6tvRB++KcyJDcY09/1vGH6kWCdwTg7FL3Jpi0/LsNzQ7
         mTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f30Wn9AFQRuhTIo8K7Emf29ohiZmBtNaV3a5neDcHwM=;
        b=O/geF/cLfTYt7qI/9pXXUkNYX/nx/NEZgz4+th5UaYaOzaQ+MolMaywZp55C0/XUHA
         IMVf7a/5kaZ5ohef5MbcRFfNdF7A+zurXi293BPLkQtom8ROe9cD0SJGQ5aYoKvMyy6u
         kraZughAIZXtCyOVau8KNWMEdNpCVNe/ECpFvL4gZBiRQw/oa50fISk2iDN4qCjhIQrZ
         cknRCTFA0z2wDcxHXdXlRKv1tX+6wycpcw9qBu5tLX5KJXhea+K5Q/62WlvaIRIupkn8
         xLYEH4dMlL48bQe8C9/VALfx4HMjJQx+s//4BvBq7ZAcYr1wvmwBmjQGjtb3wCsRuudz
         Ca7Q==
X-Gm-Message-State: AFqh2kqqYiapLcVCTfgrIsowPY9Mq2pjgZ9cOaMdi7QJrKG4y8HpOfxR
        3ol2j7VeghctphiCqjTdPGPwxjTfq+meINZ5FHQ=
X-Google-Smtp-Source: AMrXdXs+RWf+7khFFl64GPrOvJpFclniFa5YAYx9L38eYzk/9mRck5tuw9VkprCqF6PUkZa6N5ybmg==
X-Received: by 2002:a05:6a20:d695:b0:a2:c1f4:3c70 with SMTP id it21-20020a056a20d69500b000a2c1f43c70mr55865970pzb.8.1672806151201;
        Tue, 03 Jan 2023 20:22:31 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id p26-20020a631e5a000000b004768ce9e4fasm19601493pgm.59.2023.01.03.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 20:22:30 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, toke@toke.dk
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] ath9k: Fix potential stack-out-of-bounds write in ath9k_wmi_rsp_callback()
Date:   Wed,  4 Jan 2023 13:21:47 +0900
Message-Id: <20230104042147.1419030-1-linuxlovemin@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a stack-out-of-bounds write that occurs in a WMI response callback
function that is called after a timeout occurs in ath9k_wmi_cmd().
The callback writes to wmi->cmd_rsp_buf, a stack-allocated buffer that
could no longer be valid when a timeout occurs. Checking seq_no is
insufficient as the bug can occur between the timeout and the next WMI
command. Add wmi->timedout to check whether a timeout occurred.

Found by a modified version of syzkaller.

BUG: KASAN: stack-out-of-bounds in ath9k_wmi_ctrl_rx
Write of size 4
Call Trace:
 memcpy
 ath9k_wmi_ctrl_rx
 ath9k_htc_rx_msg
 ath9k_hif_usb_reg_in_cb
 __usb_hcd_giveback_urb
 usb_hcd_giveback_urb
 dummy_timer
 call_timer_fn
 run_timer_softirq
 __do_softirq
 irq_exit_rcu
 sysvec_apic_timer_interrupt

Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 5 ++++-
 drivers/net/wireless/ath/ath9k/wmi.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index f315c54bd3ac..f46cbecc12e3 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -234,7 +234,8 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 
 	/* Check if there has been a timeout. */
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
-	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id) {
+	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id ||
+	    wmi->timedout) {
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
@@ -290,6 +291,7 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
 	wmi->last_seq_id = wmi->tx_seq_id;
+	wmi->timedout = false;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 	return htc_send_epid(wmi->htc, skb, wmi->ctrl_epid);
@@ -341,6 +343,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	if (!time_left) {
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
+		wmi->timedout = true;
 		mutex_unlock(&wmi->op_mutex);
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/wmi.h b/drivers/net/wireless/ath/ath9k/wmi.h
index 5c3b710b8f31..2cdfea4da906 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.h
+++ b/drivers/net/wireless/ath/ath9k/wmi.h
@@ -158,6 +158,7 @@ struct wmi {
 	u8 *cmd_rsp_buf;
 	u32 cmd_rsp_len;
 	bool stopped;
+	bool timedout;
 
 	struct list_head pending_tx_events;
 	spinlock_t event_lock;
-- 
2.25.1

