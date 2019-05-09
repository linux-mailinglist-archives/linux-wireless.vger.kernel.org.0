Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31F18986
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEIMPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 08:15:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34889 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEIMPT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 08:15:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so1353516qtk.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2019 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IKMDkwdrLcqX/qesr5m3IU/imK5EeBRe8xlw3bBhjGk=;
        b=h721oY8UqCUOn6c8xbqobJgJFx8EXnnkOiGxFsk0mpSdpKmYXgJP67riWL1V3t1n2U
         uLFiEULrv4VU9Ttn0mPYeMbwKIxxExpVurE1e6UYhC+vdmg7wBGbhgRhLFIQtvEd45D0
         EP9lCDzmd2NXLngNM3N77rVk9caVAfBSMWZUTd1xmXmTMjsNM8iyuyw+U/1nhTPv+0EK
         ZBa/ZH+wgQWBJ8gbw5yluE8mvDO5AG9+NTbb+b72Z+98L5KvldRpSPLQeXW+4MfC1dsA
         r8XlkFegStSyh9MK7rvGASimjFnLSFbQrxyIJ/dELyQWtu5Hrtg8GI4/x6q9qd5UdZuv
         IyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IKMDkwdrLcqX/qesr5m3IU/imK5EeBRe8xlw3bBhjGk=;
        b=OndDjfxnFfyRCgjyVaERWv8O2NmGty75UCt6dJnjk+B+TvOhtO3+edsDGXgxjTjx7I
         BGLT9bRSSLQ+tppTlnXPje4eUHW78jM/ZIOUgAESvC+kPiXys/YTkCAP52cbFNpA0Dzx
         omLcTFbh3hYflr0wH462jhT//kwSsK2tCUMDSuhP5IJ2EnfHkEN4oqaDf53EAdgfIQE0
         TnjqeyGOcGMDh/rk8gqSvNNQMSMkPNTQf7InnHPGiAoWt/8UoiOREBlN/eZRLrFrxabG
         ApAY7AuXRc3wdpPYYdeSwzk9BMB7gLC2RlXP1FCGlsCBYUUeEE7tZ9JzqpXB1Ybvufiv
         PIiw==
X-Gm-Message-State: APjAAAWGw0o6NepVvELA2Po3GFT6hn6r8IC9xZrM/LwBVKb8wjTvqNOL
        mVUfqz+LDr6OyJQlzDswuPI=
X-Google-Smtp-Source: APXvYqwqSfGjDRb3AxYDUp1+tJP8NCNud6YMOtgVKmQl+6U2MiJe0ROsEKCnWIG0ELTffiBXwDg/2Q==
X-Received: by 2002:ac8:24cf:: with SMTP id t15mr3325992qtt.112.1557404117947;
        Thu, 09 May 2019 05:15:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id 76sm980563qke.46.2019.05.09.05.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:15:17 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ath10k: Change the warning message string
Date:   Thu,  9 May 2019 09:15:00 -0300
Message-Id: <20190509121500.4730-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "WARNING" string confuses syzbot, which thinks it found
a crash [1].

Change the string to avoid such problem.

[1] https://lkml.org/lkml/2019/5/9/243

Reported-by: syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/wireless/ath/ath10k/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 970cf69ac35f..a3ecf7d77949 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1016,7 +1016,7 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 	}
 
 	/* TODO: remove this once USB support is fully implemented */
-	ath10k_warn(ar, "WARNING: ath10k USB support is incomplete, don't expect anything to work!\n");
+	ath10k_warn(ar, "Warning: ath10k USB support is incomplete, don't expect anything to work!\n");
 
 	return 0;
 
-- 
2.17.1

