Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB26B1083D2
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2019 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKXOlE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Nov 2019 09:41:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKXOlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Nov 2019 09:41:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so14319886wra.10
        for <linux-wireless@vger.kernel.org>; Sun, 24 Nov 2019 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSJHYVaBcbYPoVwKHF4hNBkmPEet2RHgQOZZ8GwFQvo=;
        b=NUbd3KJgeJ41TDyvco8u3yQ+xPfinuRY/xQtOFlrrAiwOGsIqgc218Hm+kLqI+oaOl
         0XxXr7uOgoIoml6Pc8AIK12aa+hd7sPmLkK3H9KBoLS1FtSeyBTgFsNUAwGf+SXPm5Jl
         e38lZ520iTTHrGHeby26A0B2ClWrC7MCePYN2vUjDqtlk0JYoFtri4V8tyfvC/0AJs8q
         pd+r3AAjfRSZc9pyJDY/DOiOQ3BXBdvlzTMjIEs8buhZYzvl4YomW9QM6gKP/+YEab+P
         NbX4AAF2DgsfEuXQDWk3wu/l+up2SIaVXHNDc2uEZrbEeB8pAmxijwOWl3/2Fb5fbiQq
         F6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSJHYVaBcbYPoVwKHF4hNBkmPEet2RHgQOZZ8GwFQvo=;
        b=TVBTwXyMKInCLR9ci9YkbO9UpqJAXIU0eqNLHn+2qDkxPkRjwjzyAACby997YjTGLh
         eBlm1CHurWiEijo0EiGSHtOAqX5ZrLDmPnuhOPbDTeCCOfG2TngyWq+Yl3eOXxW6JsIZ
         hoa8Qihu0gR675km60RxZ+xO6zIL1LVlqULlhWbi3S7TeHmo8m6mMBpUmk2W5HtKu+Mq
         lmoWenm2XcoPpCruyjGgVEiF6SnVYuuN4F3sSTwMDEuYyp4LZMurrYyooSDCxJQlJlyU
         qxOOJ4UgutM3t9bnLFLjT/oHkmJeJybX52XsHLioe9uChLa6uzRG6gk6eHqrzLBN8ZPv
         xXvw==
X-Gm-Message-State: APjAAAW86Q9gfeRgnxQsC/SgTS2ZVRWBLjMbp/fayQCozdQqPSpj14fu
        662a5/D2UFS9W7Lrk4Yj6o11hae3
X-Google-Smtp-Source: APXvYqzA1KgU01PwXuZasKXqkBqf7+hLgd1rsiP4ewSUlRMFH916aVepjvpny+1FZ+AIFNsO75GEvw==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr9387190wra.36.1574606461741;
        Sun, 24 Nov 2019 06:41:01 -0800 (PST)
Received: from debian64.daheim (p200300D5FF4C0BFCD63D7EFFFEBDE96E.dip0.t-ipconnect.de. [2003:d5:ff4c:bfc:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id n13sm5148187wmi.25.2019.11.24.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 06:41:00 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.93-RC4)
        (envelope-from <chunkeey@gmail.com>)
        id 1iYt4N-0048HV-Lq; Sun, 24 Nov 2019 15:40:59 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Mathias Kresin <dev@kresin.me>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ath9k: use iowrite32 over __raw_writel
Date:   Sun, 24 Nov 2019 15:40:59 +0100
Message-Id: <20191124144059.985102-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch changes the ath9k_pci_owl_loader to use the
same iowrite32 memory accessor that ath9k_pci is using
to communicate with the PCI(e) chip.

This will fix endian issues that came up during testing
with loaned AVM Fritz!Box 7360 (Lantiq MIPS SoCs + AR9287).

Fixes: 5a4f2040fd07 ("ath9k: add loader for AR92XX (and older) pci(e)")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index 956fa7828d0c..56d1a7764b9f 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -83,7 +83,7 @@ static int ath9k_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
 			val = swahb32(val);
 		}
 
-		__raw_writel(val, mem + reg);
+		iowrite32(val, mem + reg);
 		usleep_range(100, 120);
 	}
 
-- 
2.24.0

