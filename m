Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298773ADA20
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhFSNbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhFSNba (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 09:31:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5EFC061574
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jun 2021 06:29:18 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f70so18209633qke.13
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jun 2021 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gfNauruCjgHZhdqzW7ZsI8vUBpPsRmwg+YoAVeGAQOI=;
        b=jvbyW7VeMBBVbAVE7mp+HoKkE/njd5SJS9T5YmmTBXpseB22xVhUh9pVv6oIP+433J
         W2tqMSw2r4Tpv6ar8QjDAYIj3lOmRuFqCS5zWSGrSp54DxjUSIfO5X4sxeeHrH0lz6Dj
         bSohhsNzPQ3XgKeK7/V0EgVUgGgqZkoS7mp8UwHKb3rc7tzelgWj97c8Mw7zUYdX+/FX
         9a3HdvoEq/irwDKgScd5fOXbwqq7O0SyQGUUIV5IdI64j5mq73Ajewy2pK7Bl6q3eqKY
         1u9yBd4xAEsR5ubhV/5Q8EiTL3TD+041zPYpl4Yr/7qvvphdQPe64X6uqPMA/W0ASswr
         WBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gfNauruCjgHZhdqzW7ZsI8vUBpPsRmwg+YoAVeGAQOI=;
        b=kvOq3gGYGkkb+M4YTOxBsakjxjGbeFqoHXqQ0rbE6Wq59XVoSK1oFnV0K1DOnJslVV
         jzInbpXha98CfNNbka7lrpSha2as30xpTSCQ1D1JtLWqtYevjkC7lCbBbRIcny3lN2PI
         Yye+f0KQdHNcMQNQu++Ouh21OyVYfwGmtXJhty6dxocpTsHajg4mwvOk3UXvh2sziVjU
         YxtvN28JgWXQi8ZA1avY6E6mAA5BzSGM43HC1ZS9LPoRaG4rlBaAEkS+F80OjBIh823o
         pnnht5UmcKVWX8S9ANQe+UOEFklBqNXoOcTQTSKig/FQn42G8JXrv73rJx5d5bIIzUJ6
         5JUQ==
X-Gm-Message-State: AOAM533ISMUXcXK195LYykl0lSi6XvUVAVDKkub1h3DDK8pPR8B2LC3v
        Ki3om014iaUCFehww8cd0fk=
X-Google-Smtp-Source: ABdhPJzFlrTUsnJG8KGQBz2PLRVa6ilZCAYosJW/axIbkPd86wwZ0uxlfn61ot+dtVDdhq4jLwuCvQ==
X-Received: by 2002:a05:620a:ce4:: with SMTP id c4mr11057004qkj.254.1624109357455;
        Sat, 19 Jun 2021 06:29:17 -0700 (PDT)
Received: from Zekuns-MBP-16.fios-router.home (cpe-74-73-56-100.nyc.res.rr.com. [74.73.56.100])
        by smtp.gmail.com with ESMTPSA id y15sm7141955qto.90.2021.06.19.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 06:29:16 -0700 (PDT)
Date:   Sat, 19 Jun 2021 09:29:14 -0400
From:   Zekun Shen <bruceshenzk@gmail.com>
To:     bruceshenzk@gmail.com
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] ath9k: fix OOB read ar9300_eeprom_restore_internal
Message-ID: <YM3xKsQJ0Hw2hjrc@Zekuns-MBP-16.fios-router.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bad header can have large length field which can cause OOB.
cptr is the last bytes for read, and the eeprom is parsed
from high to low address. The OOB, triggered by the condition
length > cptr could cause memory error with a read on
negative index.

There are some sanity check around length, but it is not
compared with cptr (the remaining bytes). Here, the
corrupted/bad EEPROM can cause panic.

I was able to reproduce the crash, but I cannot find the
log and the reproducer now. After I applied the patch, the
bug is no longer reproducible.

Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index b4885a700296..b0a4ca3559fd 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3351,7 +3351,8 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 			"Found block at %x: code=%d ref=%d length=%d major=%d minor=%d\n",
 			cptr, code, reference, length, major, minor);
 		if ((!AR_SREV_9485(ah) && length >= 1024) ||
-		    (AR_SREV_9485(ah) && length > EEPROM_DATA_LEN_9485)) {
+		    (AR_SREV_9485(ah) && length > EEPROM_DATA_LEN_9485) ||
+		    (length > cptr)) {
 			ath_dbg(common, EEPROM, "Skipping bad header\n");
 			cptr -= COMP_HDR_LEN;
 			continue;
-- 
2.23.0.rc1

