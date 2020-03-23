Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7B18F883
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCWPZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49324 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCWPZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxZ-002WVN-6V; Mon, 23 Mar 2020 16:25:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/7] wmediumd: don't treat management frames as noack
Date:   Mon, 23 Mar 2020 16:25:42 +0100
Message-Id: <20200323162245.19716cc94db4.Ib4a8bb12802840a3b9ed7e2e9ca1748a4e77e6ee@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323152542.68696-1-johannes@sipsolutions.net>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It's incorrect to treat management frames as noack, they're
retransmitted just like any other frame; fix this.

---
 wmediumd/wmediumd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 14ea63b6ba69..d756dc4be5b9 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -321,7 +321,7 @@ static void queue_frame(struct wmediumd *ctx, struct station *station,
 	}
 	frame->signal = snr + NOISE_LEVEL;
 
-	noack = frame_is_mgmt(frame) || is_multicast_ether_addr(dest);
+	noack = is_multicast_ether_addr(dest);
 
 	double choice = drand48();
 
-- 
2.25.1

