Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD632FCE1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCFTtk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 14:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCFTtQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 14:49:16 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410BC06174A
        for <linux-wireless@vger.kernel.org>; Sat,  6 Mar 2021 11:49:16 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j8so5345020otc.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Mar 2021 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3xWV5zAqKnrplLTO+ME8uiC/bDkyJw2IionsQTOWESU=;
        b=IhwYVa3ZyPSQ5ATyanUpL7cEHaIlUWYceq6glOHNc1VzUmBGPr0yWr5g1NAdnn2g+8
         3c18wNeeJWbrcGKP3XaBBDiclc+tJhp/kRaLcn8uGCSJ/gySvMjyef35k5RbDp3CQygf
         y6+vhEfTxMTrFBnac6PTJdpiKJ5Mx5d/ww5VWZs2wgrAiCC6Q7KzZGyyr2NGg3Tt7jx+
         I77BCnWUzYLc51Qa02/rcCCsrY4GbnU0swx/yNbTjNwr3J5YqovL8RfXsw6W1kbEWM/4
         H7YCPjoPDOjuOcdauI/JGoUo8mnHOxY7zeMQvr1Mb1xyASG03QFW4s0KfQnEu1H4y4l7
         zZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3xWV5zAqKnrplLTO+ME8uiC/bDkyJw2IionsQTOWESU=;
        b=op0ynAheyPitrzyfCo3d64d6p7OU8drdGdfHhvEUm3wyKRLNC+u2Y9m/EQK6tA+zmO
         4wPvUmXN+brtZcTdhy5u3Ny5FGC5vb4Ojg3PzjWtXER1QNzfduIoSMYHJ4zQ6qVmPVF5
         L+Xkr3kiPr/0xm54mBzyIDB2lNEHtDYKS7Os9TyvPk4OhAv4n4x0ZoPewNTHY0+mCaCK
         n1ISh0caRfcVKGq3QYBUUvltNH3qO2lVUslnGxo8TxoCDZNl+Yp/bAdSthU3Rm51t1bW
         THvDX+XceFczqyksmG2bUlzaLT4gww/F7m/9V6XuiT3ajs3Rm2a0e0puqoc/rLvzw2WI
         pCvg==
X-Gm-Message-State: AOAM5326GTi9BPJOoz4KIi69M+R0GoYe8LYtD/WZcXcokTg3/yZinb1A
        waW98Rr4ZNZALF+Ft6T9wRW6vw==
X-Google-Smtp-Source: ABdhPJzNb4doqDJycZlkxwYjyWr7mBB/Di1OfL51GUaZI4vO7db4kJ4Uq96qKaS5mhUIYT7vY/om6A==
X-Received: by 2002:a9d:6381:: with SMTP id w1mr13282381otk.236.1615060155724;
        Sat, 06 Mar 2021 11:49:15 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n6sm1353898oop.48.2021.03.06.11.49.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 06 Mar 2021 11:49:15 -0800 (PST)
Date:   Sat, 6 Mar 2021 11:49:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Luca Coelho <luciano.coelho@intel.com>
cc:     Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iwlwifi: fix DVM boot regression in 5.12-rc
In-Reply-To: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2103061147270.1285@eggly.anvils>
References: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No time_point op has been provided for DVM: check for NULL before
calling, to fix the oops (blank screen booting non-modular kernel).

Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 5.12-rc2/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h	2021-02-28 16:58:55.058425551 -0800
+++ linux/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h	2021-03-05 20:59:14.156217412 -0800
@@ -205,7 +205,8 @@ static inline void iwl_op_mode_time_poin
 					  enum iwl_fw_ini_time_point tp_id,
 					  union iwl_dbg_tlv_tp_data *tp_data)
 {
-	op_mode->ops->time_point(op_mode, tp_id, tp_data);
+	if (op_mode->ops->time_point)
+		op_mode->ops->time_point(op_mode, tp_id, tp_data);
 }
 
 #endif /* __iwl_op_mode_h__ */
