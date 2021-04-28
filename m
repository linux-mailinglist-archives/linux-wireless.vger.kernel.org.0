Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFD36D24F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 08:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhD1Gka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Gk3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 02:40:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2C0C061574
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 23:39:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr7so14087359pjb.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmdASNNRTCEdKqj3maPO6og7+EkKXvrD9dkHaNwbiQ4=;
        b=p9PxkY4z6D3TctxFJ3CqJVTAPNhwpcWwwOndG4Ho+zYwrovS06m1p9aaIXmbQqd9wZ
         DysGKjP3M9coC/TIBisofC5M/K1+K8GCv+spnjZFcFV5o3IH8KwSqMBKzfXkZ0s7zdmH
         pHOE3OZsVl/QcCTBJR2ufOVN89yZ3xY1tg57crRjxvy+UXgNH8JnDdNLN91hBxHB+uEj
         +M0wDSmmWlDv/NOitl2oifkGyVo6+3SV9nfNm9xmJ+E31j14PC8ulip/DIv8Oe8detTa
         PosxQqz54ZxWC3cnq7NZRzBNaNuhv+x0+2yJlwdTaIg+mAvSxXirm2q1mxu1qHiVikkA
         h3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmdASNNRTCEdKqj3maPO6og7+EkKXvrD9dkHaNwbiQ4=;
        b=lGK3gleg4ZALMa0tKU+dmuXaIdPskKA5q9GwAypt16Bo2Xg5X+fhDZa9n8R8BJ0rLn
         GLyuX4nPKlEy8A9JBQ/pzvvkc8MNWbLsMLDOKK+18mYwvic9CWp67Ns7PE53nr71QC6q
         8iaeCQei343OCHRauLhK5S3VCyRk0bCRZr7zy0YRkUK0e8jBl3TcCktemaxt0N1kU3a7
         FOr24qHJSm97jl9Gz7X0kY6PlVrqq2SbdN5hCC1474zuEZrZX+AcY0DKyGPp/vzGd52i
         +/SNXwIhdteD1unuh8M1qZHW3bC7JzB+c3WtAntYFeD4aXotZPnRHFjAkqzGYQoiZGmd
         yPAQ==
X-Gm-Message-State: AOAM533r8IjS1VDhE2iXiuvvyhKK0N9PMjVkPrW1M4qEpj0FhNSmGQck
        p0Fa9/gpSWKlhucmhETIZmk=
X-Google-Smtp-Source: ABdhPJxuhE+s8RxEL1g3QT1wsyE6d/4KZD2bkh5ujka4j+K9oRByF7B56c6M5bNaZKK6khJcvjAz5Q==
X-Received: by 2002:a17:90a:7147:: with SMTP id g7mr30930311pjs.225.1619591985259;
        Tue, 27 Apr 2021 23:39:45 -0700 (PDT)
Received: from nuc.wg.ducheng.me ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id w9sm4043910pfn.213.2021.04.27.23.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:39:44 -0700 (PDT)
From:   Du Cheng <ducheng2@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>,
        syzbot+105896fac213f26056f9@syzkaller.appspotmail.com
Subject: [PATCH] net:wireless: call cfg80211_leave_ocb when switching between ADHOC and OCB
Date:   Wed, 28 Apr 2021 14:39:41 +0800
Message-Id: <20210428063941.105161-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the userland switches back-and-forth between NL80211_IFTYPE_OCB and
NL80211_IFTYPE_ADHOC via send_msg(NL80211_CMD_SET_INTERFACE), there is a
chance where the cleanup cfg80211_leave_ocb() is not called. This leads
to initialization of in-use memory (e.g. init u.ibss while in-use by
u.ocb) due to a shared struct/union within ieee80211_sub_if_data:

struct ieee80211_sub_if_data {
    ...
    union {
        struct ieee80211_if_ap ap;
        struct ieee80211_if_vlan vlan;
        struct ieee80211_if_managed mgd;
        struct ieee80211_if_ibss ibss; // <- shares address
        struct ieee80211_if_mesh mesh;
        struct ieee80211_if_ocb ocb; // <- shares address
        struct ieee80211_if_mntr mntr;
        struct ieee80211_if_nan nan;
    } u;
    ...
}

Therefore add handling of otype == NL80211_IFTYPE_OCB, during
cfg80211_change_iface() to perform cleanup when leaving OCB mode.

link to syzkaller bug:
https://syzkaller.appspot.com/bug?id=0612dbfa595bf4b9b680ff7b4948257b8e3732d5

Reported-by: syzbot+105896fac213f26056f9@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
---
Reproducible steps:

1. NL80211_CMD_SET_INTERFACE: NL80211_IFTYPE_ADHOC
// set IBSS mode

2. NL80211_CMD_SET_INTERFACE: NL80211_IFTYPE_OCB 
// switch to OCB mode, calls ieee80211_ocb_setup_sdata, init u.ocb.housekeeping_timer

3. NL80211_CMD_JOIN_OCB

4. NL80211_CMD_SET_INTERFACE: NL80211_IFTYPE_ADHOC
// swtich to IBSS mode without calling NL80211_CMD_LEAVE_OCB,
// leaving u.ocb.housekeeping_timer NOT destroyed

5. entering IBSS mode, kernel panic while initializing u.ibss.timer, an active
debug_object as &u.ibss.timer == &u.ocb.housekeeping_timer


 net/wireless/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1bf0200f562a..f424ac7633bb 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1056,6 +1056,9 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_MESH_POINT:
 			/* mesh should be handled? */
 			break;
+		case NL80211_IFTYPE_OCB:
+			cfg80211_leave_ocb(rdev, dev);
+			break;
 		default:
 			break;
 		}
-- 
2.30.2

