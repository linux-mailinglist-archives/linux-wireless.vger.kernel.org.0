Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C065D2F3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 13:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjADMlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 07:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbjADMlv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 07:41:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155AE07
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 04:41:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n12so23092588pjp.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jan 2023 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYqAuotZakvJbzXu+JOiNvmSNcfzCg1hdPWkKPrWBFI=;
        b=Ki2ktntELCQCy5wPrCXk9VJXnRfBaarhWGUU1fHT3SXVGGOHGKjlq0eTAaul5yAi7U
         sOdUKm6bAoIB+nzN8qEO0Nt2Xy8MRRSB35uSiVVfsw56hAkcuv9DRxNTOySlCvpAmlLg
         l+KDC/CEqwrYkwpf2lxRLtq1D051mJZboFAe1gnW15tVtb35TsTq1WYJuerNHepEcpVJ
         D4r5C8Y8hZjq4a5+/s2RI85EIhXOPNdageAw7kOWUiLFXWRfcGVheRrkXGJSJryTK/eS
         ZgRWxKi5zDtukgsqBljrKuNexGlnC2ngrb+qhTy5c0AO6bg1IImhNZJU2V3KCOm7KHe9
         V81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYqAuotZakvJbzXu+JOiNvmSNcfzCg1hdPWkKPrWBFI=;
        b=fUKFy/3oGi6VWNy1tJU4DAq1FcQaLKuSJo+Mqdvj51trMTR66gW/8RNJQvatoyq/2x
         frtzP9tcRr6TXNu7rq37K8z8+tcmwlWsFZrRcyBn8D6jSsMuRCnHusXKzDbie0uJHjUu
         hA1PhUEQtpDi+2WZ55gmgEWX2BI82AVjfjn6lunhOoDgiVYkCdzd2UJxJ+AHtj5jVJqh
         6nKFyIZVaBLf62tlpoz8ntZI/qb3/nPfYU0c/7ahdmidWez440cir1x/YK2+nv7CbZi4
         iKW9JSaieXfsV4PuLu8q1Iu0lNF0aTAQ2aiVRrjj5ZytBdyga4EHhS8qWpfeWjJneYSB
         Lkig==
X-Gm-Message-State: AFqh2kpcwXBSgAhq7rYoAsawYbhGiNh10UxV4FyZn1oex9URrErctcZ7
        vTRbw513ObreGC4L8FSTEUYfI3Bfd2kXDJM89aPctQ==
X-Google-Smtp-Source: AMrXdXtUYW3grFI5DS65MO1EJU5CLzV8RXIAN2NiO371Xw9drsGl1qvewH+6IVgVigfzZ3aRoOZmWw==
X-Received: by 2002:a05:6a20:d819:b0:b2:3b40:32b1 with SMTP id iv25-20020a056a20d81900b000b23b4032b1mr55335626pzb.57.1672836109414;
        Wed, 04 Jan 2023 04:41:49 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id q28-20020aa7983c000000b0057255b7c8easm18570752pfl.33.2023.01.04.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:41:49 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, toke@toke.dk
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH v2] ath9k: Fix potential stack-out-of-bounds write in ath9k_wmi_rsp_callback()
Date:   Wed,  4 Jan 2023 21:41:30 +0900
Message-Id: <20230104124130.10996-1-linuxlovemin@yonsei.ac.kr>
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
could no longer be valid when a timeout occurs. Set wmi->last_seq_id to
0 when a timeout occurred.

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
v1->v2:
  Reset wmi->last_seq_id to 0 instead of introducing a new 'timedout'
  field when a timeout occurred.

 drivers/net/wireless/ath/ath9k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index f315c54bd3ac..19345b8f7bfd 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -341,6 +341,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	if (!time_left) {
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
+		wmi->last_seq_id = 0;
 		mutex_unlock(&wmi->op_mutex);
 		return -ETIMEDOUT;
 	}
-- 
2.25.1

