Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40CC12631D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLSNPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:15:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37214 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSNPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:15:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so4839336edb.4
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 05:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+Ei4HzxmBsPDZTHsP8DZ9d6KPTrEHJVVPZdhv56adw=;
        b=awGrenJDW7xKsLpiPGeIRrNo2A6uiQq9t9EbV7eHgKbZd1UBgDN85SFMihKdxt44j+
         McN6qtLM1968DRzpP0a3v1ukyOodwO29cpQTXazvDOHdqsYuLciQ55UDCyfH+YdBIzMq
         e49/fSYwOLqpnkDyCM7423wQOymJVFx9tuO+4fdWihvKsrcHQOtw/Z//n47v3AOFLdi8
         brJY7pAPzOpBHP2CpfB/576DEtHzcWed93QDWBBfdlUSxAchDeMGW4TcBgkotPbzDVsG
         ndCmD8SioCy8XIc/BYIZKmVa4g5oVP+OhjkzBlqEJOiSJPmIpaQoNw4E9LQYgfptBYm3
         Y6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+Ei4HzxmBsPDZTHsP8DZ9d6KPTrEHJVVPZdhv56adw=;
        b=MJFfYkJGSnZUsoUfscd9akfSqFj0PzMH6cH2fodQ3KxWVj+WZkr/JI7pmZvE6X07ma
         uw7hD4ooH+CPXeSRkoERS2sSwLHj1vXQQ/gDS6y0cZHJpR9RL8PZvwVaUr/mCNsPKSnf
         FqRbfa6+3gQfglIpdhmI2QtbUeTYvtb/hDIX/rCgFE2npwqawGenswOIytAUCggSZ4IU
         DIymFrTwOPFYveX7NCSP4NSUnJCl21zABUOlsflD236nbw03Zzonv9hku7DFz/qlFZDg
         yGgiiL8MetAk+NshUvXwmQaYxQJFq7D76MgbOsqIzJrfyYQoAbHcSsPEyEB5SMfoH4C+
         iNvA==
X-Gm-Message-State: APjAAAUuB1RGiDVlav6WDpXV7V4ePvUdCqTN5qv5ey8ELrvMONiKUSev
        pLgYFfTubqvNGYcYbn3Hza3mEg==
X-Google-Smtp-Source: APXvYqymawJmDlguUa+XbUmftPeGxh/G8AqwTN3gz+ZSDE2nbWk2kcAbb2U2kwmtlKldOU5GpAIRBg==
X-Received: by 2002:a17:906:19ca:: with SMTP id h10mr9395261ejd.282.1576761321093;
        Thu, 19 Dec 2019 05:15:21 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id cw15sm410286edb.44.2019.12.19.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:15:20 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, akolli@codeaurora.org,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] ath10k: pci: Two PCI related fixups
Date:   Thu, 19 Dec 2019 13:15:37 +0000
Message-Id: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This set addresses two issues one a contrived but real corner-case crash
scenario and the other a simple typo.

Debugging on a QCS405 which has an ath10k attached to PCIe its been found
that a loop similar to the below [1] will cause.

1. A significant slow-down in the time it takes an individual ioread32()
   to complete.
2. A secure watchdog bite.

This is as a result of the restart routine and the dump register routine
running in parallel and a period of time during restart where dumping
registers is unstable.

The second patch is a simple fix to an apparent copy/paste error describing
the behavior of a similar dump function.

[1] Reset method
while $1
do
echo hw-restart > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
echo hard >  /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
done;

Bryan O'Donoghue (2):
  ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG when safe
  ath10k: pci: Fix comment on ath10k_pci_dump_memory_sram

 drivers/net/wireless/ath/ath10k/pci.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
2.24.0

