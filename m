Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAE105CC3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 23:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUWmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 17:42:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46902 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUWmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 17:42:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id a16so2157493pjs.13
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8xVnnb4REmk/y8wDQaGHyK5EjWgjXNRx9E/IlK1whA=;
        b=YWo9R4emEpHvLAqMMddNF6cIn2+dBBz6+FCDvCXGBwpPeo+p5xskW1E4ryK30vKXz8
         5D04yJ6TnP8yw3P87ymcNJAnVV67ZL++85PoM3/r2uDo2Et4DMJkepR1LiUNFWhjpZWO
         3TH8i42OYgaB8J7OzNgtvZHMmM64GluJ4uiic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8xVnnb4REmk/y8wDQaGHyK5EjWgjXNRx9E/IlK1whA=;
        b=KpcSYk2FtKv8qwOj92OSCzJKMDQerLQMKMPdABvidpszRx62NW6zbTbAPjtTgxWZsz
         FNNUlQW7HltkaggH82Eb90Tcxy1zmf/FExG92wM3qwwzeNSVkCVwmMi3c2RBc6JQyb8A
         AHhtY5p4bgdn20Rd0Vcu1lG0Qi5ni6UFidOa58oHWpTnIy484r2NkG9brjiLxFsGXXbI
         SaE0eAhsweZxtLvYxoP/npfA0mPd7Wijr/7vh99b8Pw3cKKr83FFY5E5NikChCo7c19l
         D4rTf9KbOgIyUQp3bCkWE6n0Gawmu2BqPeREmLhiszm7U9lGmOlWAcXtP03qCmiljDiM
         m9RQ==
X-Gm-Message-State: APjAAAXB0uKsGnR7KWmrEeuIiFc9q6hM6QGdYIgfJ2p5T5UODK95QNmu
        wSKZdO/CnFbU/0bcV+aP/9b+MA==
X-Google-Smtp-Source: APXvYqzND3SN+5Di2oNOTXF14jVxzgtTYpH/dEE1ZxUQYjDM7ZDbRxMbnWQMstL++EVpBnhixnMPUA==
X-Received: by 2002:a17:902:7402:: with SMTP id g2mr11275615pll.6.1574376128309;
        Thu, 21 Nov 2019 14:42:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id ay16sm615028pjb.2.2019.11.21.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 14:42:07 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] iw: scan: fix double-free in error paths
Date:   Thu, 21 Nov 2019 14:41:39 -0800
Message-Id: <20191121224139.58281-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hit when, for instance, I'm stupid enough to type an invalid scan
command:

  # iw wlan0 scan -h
  BUG at file position lib/msg.c:572:void nlmsg_free(struct nl_msg *)
  iw: lib/msg.c:572: void nlmsg_free(struct nl_msg *): Assertion `0' failed.
  Aborted (core dumped)

Fixes: 2f74c59cf11e ("iw: fix memory leaks inside handle_scan")
Cc: John Crispin <john@phrozen.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 scan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scan.c b/scan.c
index 1418da73a624..bfd39e4b1a1c 100644
--- a/scan.c
+++ b/scan.c
@@ -448,8 +448,6 @@ static int handle_scan(struct nl80211_state *state,
 			}
 			/* fall through - this is an error */
 		case DONE:
-			nlmsg_free(ssids);
-			nlmsg_free(freqs);
 			err = 1;
 			goto nla_put_failure;
 		case FREQ:
-- 
2.24.0.432.g9d3f5f5b63-goog

