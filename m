Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504BB6FEBF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfGVLdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 07:33:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35478 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGVLdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 07:33:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so37293154ljh.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oSm58XeL4FQu1bXAGeTHMv1Ur+zZszwec54kzqlsXg=;
        b=jG6xRVIBcul9uZ9Rbz1vKDw/a25lNSrU/3iTTJg3hKmnsWHYsOjO4JbjRXSLnaS8Sz
         2Y5CLkiFgt1hUAZglFCMQrvtqs9zr1xFYsR8BWV+vymezLszpIjJgarIN5sxaW4qe8gN
         08encqy8goJ+rVKLzYPHI0C1UdVnWyeip06JEJrdRqhlISXA3VM5whHsAorqdq6/1Xnq
         Mn0en1yQlMmF8AowNs/z37IVVe8hIUaaCNKzYfLZozbcAgxtPdfUh4V6hmYUpnioG5xj
         YLGlWXqIoPDLtP/VWmDSwwykDjRN7yLJ7oTeHZD0Pj7ly56yvhG8RqAY9RZb/enzPu3v
         YzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oSm58XeL4FQu1bXAGeTHMv1Ur+zZszwec54kzqlsXg=;
        b=aVA8smNaAouhBO+b1G4PT2xtXPrY/NLcrx6hTGwsG5AprwVSlW6DNe3SXxZ1G0kh4w
         lLv4KkGXXNPe2pg1Z1Vz8PR9ETK69Uu1qtts+/AbmVp0Hg1GGPt1u05sR37tixXoj+IN
         P2VWTO/o8L3SZoUU0HlRQZjxt8T51JJiwIM+a2+uz1EsROfcvhnuj+yJQ7UGqzcBXLQl
         jqOy9EHo/Wn/MWuBKglFOt1g+31ocmravt/mNSWcoa1I4FGwRuwU41iL+muLoQGYIgpY
         rAYNu4JqlEu3kWXLDoH4mbtsATR90OxnYWDY2qMRZ37XpogKKM6HsrkNwmvn8cqBQap3
         OKHQ==
X-Gm-Message-State: APjAAAWzifAeQEOROC52DSnE8HqaaZZfIYhpaPmIDzLX8RPg5fOobZ53
        O9ecV3BmftBITSIBz23XjcE=
X-Google-Smtp-Source: APXvYqzLPBJX/FTLUGT7e49NpCClJhXA0nJR3ecPEXN8MV+j7r/7Vb2U2MPcYp6TlTfa+hV5sOTW2Q==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr37199987ljj.160.1563795198394;
        Mon, 22 Jul 2019 04:33:18 -0700 (PDT)
Received: from localhost.localdomain (109-252-54-73.nat.spd-mgts.ru. [109.252.54.73])
        by smtp.gmail.com with ESMTPSA id u18sm5940336lfe.65.2019.07.22.04.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 04:33:17 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v4 1/3] nl80211: Update uapi for CMD_FRAME_WAIT_CANCEL
Date:   Mon, 22 Jul 2019 06:33:10 -0500
Message-Id: <20190722113312.14031-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 1c38c7f22068 ("nl80211: send event when CMD_FRAME duration
expires") added the possibility of NL80211_CMD_FRAME_WAIT_CANCEL
being sent whenever the off-channel wait time associated with a
CMD_FRAME completes.  Document this in the uapi/linux/nl80211.h file.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 include/uapi/linux/nl80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

 Changes in v4:
  -  None

 Changes in v3:
  -  None

 Changes in v2:
  - update commit formatting
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8fc3a43cac75..0d9aad98c983 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -657,7 +657,9 @@
  *	is used during CSA period.
  * @NL80211_CMD_FRAME_WAIT_CANCEL: When an off-channel TX was requested, this
  *	command may be used with the corresponding cookie to cancel the wait
- *	time if it is known that it is no longer necessary.
+ *	time if it is known that it is no longer necessary.  This command is
+ *	also sent as an event whenever the driver has completed the off-channel
+ *	wait time.
  * @NL80211_CMD_ACTION: Alias for @NL80211_CMD_FRAME for backward compatibility.
  * @NL80211_CMD_FRAME_TX_STATUS: Report TX status of a management frame
  *	transmitted with %NL80211_CMD_FRAME. %NL80211_ATTR_COOKIE identifies
-- 
2.21.0

