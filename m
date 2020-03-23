Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E218F881
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCWPZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49288 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCWPZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxX-002WVN-IN; Mon, 23 Mar 2020 16:25:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/7] wmediumd: pass actual signal to hwsim
Date:   Mon, 23 Mar 2020 16:25:37 +0100
Message-Id: <20200323162245.fa68912fd1cb.I4b0b2f3785ffe221a4b646496071da5f97f662c0@changeid>
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

Not clear why, but despite actually having the signal, wmediumd
always passes -50 for the signal strength. Fix that and pass the
actual signal value.

---
 wmediumd/wmediumd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 5e89e83ca72b..e7374d9b9639 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -464,7 +464,7 @@ static void send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
 	    nla_put(msg, HWSIM_ATTR_FRAME, data_len, data) ||
 	    nla_put_u32(msg, HWSIM_ATTR_RX_RATE, 1) ||
 	    nla_put_u32(msg, HWSIM_ATTR_FREQ, freq) ||
-	    nla_put_u32(msg, HWSIM_ATTR_SIGNAL, -50)) {
+	    nla_put_u32(msg, HWSIM_ATTR_SIGNAL, signal)) {
 		w_logf(ctx, LOG_ERR, "%s: Failed to fill a payload\n", __func__);
 		goto out;
 	}
-- 
2.25.1

