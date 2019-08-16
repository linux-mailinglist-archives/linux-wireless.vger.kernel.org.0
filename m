Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC6690831
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfHPT1M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 15:27:12 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40592 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfHPT1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 15:27:12 -0400
Received: by mail-ot1-f46.google.com with SMTP id c34so10604276otb.7
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2019 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJkdZ2Mqjb4Vj1N2P/9YdW2gUhcT57fOyzLmxjy2JZU=;
        b=iBrLHFBgzp8Yw7efsIjYcD5F1BqaE4zcS3YB0qD5u0tf2VZEHHFEWltxxHB6BPx6FP
         hRXXvxSR19ZW4UiMZk7giuob3iD2g/EizMwmAqeE4iWY2FLqX82oTIdWp2zHQDWPvUtM
         JfPfp7SPSKn2n11Ro95NWprvekyI3oWDLtlszl7RjtFUQuHUBQgJ7PyTxxiuLjrz5qUE
         8wk9p4TsIbLNWE+8qpINK20qqQYAljVq3X2BK5CbHMtSUzRyPv991ZZk/mum4D1AU2Os
         EN2LhnHcRJ00ueglzyQHVMPlLDLbXbWg+71JuX2B2FjxyMAui7X4wXQsOmTUbr6z253x
         bkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJkdZ2Mqjb4Vj1N2P/9YdW2gUhcT57fOyzLmxjy2JZU=;
        b=Cgqr/7TF6SXPyXUu7loCctVOBiQHcFq4zxx81QfYW/VpSlwCYDYL84x0jaiMBH64ur
         9Di3KgX6GDV6QZZ8ERrEgaHTfxfV4N0lLV05bBQF5uvv60KeOFvOpLbWi41/F2LjqpgA
         VxEDcrwSMr8WGr8VLzsx1zA2l4DsB43JxuC2Duwnbd4bQtYQCrOUOzxUVr4aBVWpjX+s
         T9+TnrD9T9Lhi/3wDRJfVcSnXONQzJyhLNNs47KBi0MQ5uAhVJR21f9xpqJ5tL9TYtwT
         sWjj4bNTtJVN3O18NZA0e0gTIy8VIXhBi8PxCgCYicHCPhc+lVvDPZCuonl0Pu7SvGUi
         y+jQ==
X-Gm-Message-State: APjAAAVR6gimPUG7KN7jwdWjykVM+eIeh/kLHyPzZ4JwHw8yx5JkYV6y
        h+UmW7R4zQ0uJNyTZk/6iCrU9Gmj
X-Google-Smtp-Source: APXvYqzWWiUt15MTvK7WWu7MWHHIXPcHWHMKjadL1uSkBTEWpT07JBM2ZFGZQpeIMryGO6y1aB8h3Q==
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr8253426otr.64.1565983630939;
        Fri, 16 Aug 2019 12:27:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b10sm2452246oti.61.2019.08.16.12.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 12:27:10 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [RFCv2 1/4] nl80211: Fix broken non-split wiphy dumps
Date:   Fri, 16 Aug 2019 14:27:00 -0500
Message-Id: <20190816192703.12445-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If a (legacy) client requested a wiphy dump but did not provide the
NL80211_ATTR_SPLIT_WIPHY_DUMP attribute, the dump was supposed to be
composed of purely non-split NEW_WIPHY messages, with 1 wiphy per
message.  At least this was the intent after commit:
3713b4e364ef ("nl80211: allow splitting wiphy information in dumps")

However, in reality the non-split dumps were broken very shortly after.
Perhaps around commit:
fe1abafd942f ("nl80211: re-add channel width and extended capa advertising")

The reason for the bug is a missing setting of split_start to 0 in the
case of a non-split dump.

Here is a sample non-split dump performed on kernel 4.19, some parts
were cut for brevity:
< Request: Get Wiphy (0x01) len 0 [ack,0x300]
> Result: New Wiphy (0x03) len 3496 [multi]
    Wiphy: 0 (0x00000000)
    Wiphy Name: phy0
    Generation: 1 (0x00000001)
<snip>
> Result: New Wiphy (0x03) len 68 [multi]
    Wiphy: 0 (0x00000000)
    Wiphy Name: phy0
    Generation: 1 (0x00000001)
    Extended Capabilities: len 8
        Capability: bit  2: Extended channel switching
        Capability: bit 62: Opmode Notification
    Extended Capabilities Mask: len 8
        04 00 00 00 00 00 00 40                          .......@
    VHT Capability Mask: len 12
        f0 1f 80 33 ff ff 00 00 ff ff 00 00              ...3........
> Result: New Wiphy (0x03) len 28 [multi]
    Wiphy: 0 (0x00000000)
    Wiphy Name: phy0
    Generation: 1 (0x00000001)
> Result: New Wiphy (0x03) len 28 [multi]
    Wiphy: 0 (0x00000000)
    Wiphy Name: phy0
    Generation: 1 (0x00000001)
> Result: New Wiphy (0x03) len 52 [multi]
    Wiphy: 0 (0x00000000)
    Wiphy Name: phy0
    Generation: 1 (0x00000001)
    Max CSA Counters: len 1
        02                                               .
    Scheduled Scan Maximum Requests: len 4
        01 00 00 00                                      ....
    Extended Features: len 4
        02 02 00 04                                      ....
> Result: New Wiphy (0x03) len 36 [multi]
    Wiphy: 0 (0x00000000)
    Wiphy Name: phy0
    Generation: 1 (0x00000001)
    Reserved: len 4
        00 00 00 00                                      ....
> Complete: Get Wiphy (0x01) len 4 [multi]
    Status: 0

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1a107f29016b..b9b0199b5ec6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2173,6 +2173,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		 * but break unconditionally so unsplit data stops here.
 		 */
 		state->split_start++;
+
+		if (!state->split)
+			state->split_start = 0;
 		break;
 	case 9:
 		if (rdev->wiphy.extended_capabilities &&
-- 
2.21.0

