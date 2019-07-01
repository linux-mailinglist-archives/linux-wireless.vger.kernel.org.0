Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2735BFE5
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 17:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfGAPdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 11:33:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44488 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfGAPdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 11:33:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so13875498otl.11
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2019 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u5Zeng5hhsrOZK5JXXLz7stBL+xe6u894p81RQmrSY=;
        b=h11ylGlhD7lGjRjFNDr+SWG/uGAZryR/XR32cipxkPiDOkbbls4qmMm0UCLVnAxsl/
         3+FLwXgSruGKjR7GnGR9D1jKbvc1Z/1XNdARJ2zdzYzO7EEDOj7ifNBwWQ4trdgUp4jh
         NO6VZdfkfMCQYM8lvKl/nERSJtqaO2FMgjaqi2uNGw/1W555p7wtvwchw2yhvqyH6an2
         3b9P4PcMjuKg+pifdsMjTOKgeM9POIdG2KeObc2KdFHMvA895KiDaBy++mPC5VVq8Atc
         /uqsgChh/1j5tdBuo+SIZSbEXzT59BCjNS55jIwD2YJMA3kf18wpL/Q73OFiI+GCciGu
         /GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u5Zeng5hhsrOZK5JXXLz7stBL+xe6u894p81RQmrSY=;
        b=m6m6s0ykOfj7UaKyTkpizL9W7kAVQzKGd7NDyEqBNQ5Q7wUiujM4sTmU4ztZM7fzqQ
         JdVuMAKU+RUdKtkP6OJgQ2H5EVvQcQdwKTFa3kw4DwZh3fU/2egQUppRZnpw/yAGj7jz
         BEqeHrllKYgWyWp3xXfYmglOug9jPQfma3LwFiyPpM5P0wKV8DUvClAiLmFn+sw5duiz
         pV2FmyWiEZ0qY53vULVAspHNovzv3J5UAmZqC3ZlNcpQeOGN10v9xpevImIFQypSs61q
         JnfsW3CtGQ4OtEduFhD6FQ24BPCmFUWlF6qkk4k1u/L+VwPJVOXddshon0gPDaZNJ4gh
         0uRw==
X-Gm-Message-State: APjAAAVoHcTWHZVgVa/ezF344FgbHQGPBbMnW7vpK46ub7eXjOME6xDc
        4KuG4w0QbX87s2QMGpIi+aU=
X-Google-Smtp-Source: APXvYqycrI5cWufWhVf0jNT73xyP+ao+UMORl9B3n8504wfvd1ycWWzEpstCcY4peWI9yZzKbWuvEQ==
X-Received: by 2002:a9d:17e6:: with SMTP id j93mr20712230otj.275.1561995204775;
        Mon, 01 Jul 2019 08:33:24 -0700 (PDT)
Received: from new-host-2.home (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id y4sm4136786otj.56.2019.07.01.08.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:33:24 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 1/3] nl80211: Update uapi for CMD_FRAME_WAIT_CANCEL
Date:   Mon,  1 Jul 2019 10:33:15 -0500
Message-Id: <20190701153317.27170-1-denkenz@gmail.com>
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

