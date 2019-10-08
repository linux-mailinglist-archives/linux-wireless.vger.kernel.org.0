Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF43CFF4C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJHQxv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 12:53:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40202 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQxv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 12:53:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so14621324ota.7
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TO34/XLF7MMwZNQDORRoF5NnGumt+zIPeUOrhbl7GH0=;
        b=g7FeHb2pcsj99+eO8O728lAxGEgatpPK7HVzvMTyM6xZYrWcm+5LooA6aBYdCzlDvx
         YIFZVA5WgLMgK9lOvUZkAmGiUvNjs8IcjhsdRKO/fy5BV3IiLf/yiMc3gTmfnpPL1r2E
         JaWbSaNznRXRbad3n8UPTan48BZTdw3CJ23ISPI0t3UeyiiGJCApoTUBLNtbsOR5RE3l
         LLTEKArYwUFmPF4I0OAIriVzP1JUxfq5u4+BM89AmQmyC8ac0t6DlYf4nrJ4DjaVyU0Q
         dUaHf9nLvztBdDJLzGbtKr1/mO+uzdW5nzFULd9D/gh78frqWuyLtmYcO5tqAdzMmYcL
         GxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TO34/XLF7MMwZNQDORRoF5NnGumt+zIPeUOrhbl7GH0=;
        b=dbBVHUN2jilG/3/YDS3LFBIXR6Q/HXa4bU5TI4xpIJzk/IgLt60+e4olm0m9dx3GR3
         +sT9c0oh20P0vyuICkGmltHYEdSAD/ds3a0JpFeX+x07oFItqHXzizUHAeOhy0pWQmNM
         J5U8VnXVLcuxAHMhI+LzBPQSbHmhPPNrMunSIZ6jVm/2xiLXt6by0PIenpbKPN2u6yEI
         pyCxHF5q5rlBfcEiTYQU3Tb3EYCYB9GdqgM0fMTUgB+4KyeXCn71WARcRLfllmamDbpD
         8BZ6DtOl/Ib5UQz1UT5eLW4wgSVM0U8K54nscdrjgXUFLb8DQ6p+YoN39UCoGEy/p2ab
         31KQ==
X-Gm-Message-State: APjAAAX7D5v9Yg2f8MYJQaX6/pRn1kpSrGf8vMmdhxsau2hjHQG4FU2s
        TrvfDGyZTQadwkjDGm4vlf1Ymnr9
X-Google-Smtp-Source: APXvYqwBq712vmuPYGr7+gL+Hp1kV1NAuBSCzXBALLPAPl+oEWDF13PVeWXCHMPjQGsYZzQ2MUY0YA==
X-Received: by 2002:a05:6830:4b2:: with SMTP id l18mr27521194otd.9.1570553630039;
        Tue, 08 Oct 2019 09:53:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 93sm5707057ota.16.2019.10.08.09.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:53:49 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] nl80211: trivial: Remove redundant loop
Date:   Tue,  8 Oct 2019 11:43:50 -0500
Message-Id: <20191008164350.2836-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211_assign_cookie already checks & prevents a 0 from being
returned, so the explicit loop is unnecessary.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 net/wireless/nl80211.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d21b1581a665..57bade7ea41c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8227,10 +8227,8 @@ static int nl80211_start_sched_scan(struct sk_buff *skb,
 	/* leave request id zero for legacy request
 	 * or if driver does not support multi-scheduled scan
 	 */
-	if (want_multi && rdev->wiphy.max_sched_scan_reqs > 1) {
-		while (!sched_scan_req->reqid)
-			sched_scan_req->reqid = cfg80211_assign_cookie(rdev);
-	}
+	if (want_multi && rdev->wiphy.max_sched_scan_reqs > 1)
+		sched_scan_req->reqid = cfg80211_assign_cookie(rdev);
 
 	err = rdev_sched_scan_start(rdev, dev, sched_scan_req);
 	if (err)
-- 
2.21.0

