Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12835ABCF5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394933AbfIFPtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 11:49:12 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44595 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbfIFPtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 11:49:11 -0400
Received: by mail-ot1-f51.google.com with SMTP id 21so6115721otj.11
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2019 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZuCK/LFe/OO1BZ3AqGk4ZltIe3DN6IjRd0ZQCCV4HE=;
        b=VVgPsTw7tdR8ZTTxfHyTqhFef1mVV/I+n6vowXOUKKJN8lJUsgbGMSgbldvWhGYWk1
         DIrDL8CVethiTZYXaopRzhzScy23FFeGyRVdDfyRzvXZBFjLSkd47+GSkFwCvFl8/xc/
         c/pTWJ86IeFs60nydcHzF4cteKJ6R54O93GSMEsxJxo4wiLJ3SlWRoDPtO1r9Rb3hM73
         7uQkkBUaw2WrFnlTNbr7Vi3jw+PugZOQVZvQkXQMTLCzsgdkePPhYAQkt1FT07tLs8s7
         S8JclLtsRGAVsTkWfDk5gcbBz4VvtNeJ9CHgT/KulDyQvWy0Iy1ta5rMKqCYEDQyh7RD
         PLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZuCK/LFe/OO1BZ3AqGk4ZltIe3DN6IjRd0ZQCCV4HE=;
        b=rM/J9mjyESz9GI6jpWYXYS9MbuYOE0FcHSs2rz/eXnVrTceleLtiXu2Cq12/H8eDde
         4UBDsDxm9EaNXjaDfnPrLV4DU0zENImYlC5VpyJzTZi534sZzc6g49EIj1QmhXhHUMf5
         P1wqMMQN00p1jhDuzSdN1pytZZjiftEoXK/yq4X1IbawTbp6NIkFX7VMONIYxhQpFiQG
         mPdw4DWIhtqy/M70utxe/IQNfw8Qj81NxS6HsN4or+gqH4upa2hlhTbVGheXzwN1MThe
         04TLan6f/oblEHPlJjz0xKyhglQIe8PUy+4poVbo2sBXhNGlSOZRDrJdUSvfUNCohZvO
         E7YQ==
X-Gm-Message-State: APjAAAV1myT+A0qzSu/6+pQOo/prk7uVErzTbmMo2+mex7reukKvuwIr
        79qCX7PBnP9rywL+G+ngHLlpeRKk
X-Google-Smtp-Source: APXvYqxsa2Cbo7TRB16QpFHHGuCmGAG7r2Cqx9iLETnpXdzMHVuy/pfuqrwsXW9jpyIxPMLrizOv2g==
X-Received: by 2002:a9d:6356:: with SMTP id y22mr7608951otk.20.1567784950355;
        Fri, 06 Sep 2019 08:49:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j7sm2105587otn.65.2019.09.06.08.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:49:05 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [RFCv3 1/3] nl80211: Fix broken non-split wiphy dumps
Date:   Fri,  6 Sep 2019 10:43:01 -0500
Message-Id: <20190906154303.9303-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.19.2
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
index 3e30e18d1d89..ff6200fcd492 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2191,6 +2191,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
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
2.19.2

