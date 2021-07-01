Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297083B9487
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jul 2021 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhGAQMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jul 2021 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAQMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jul 2021 12:12:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E58C061762
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jul 2021 09:09:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lyzGG-00EI4p-V0; Thu, 01 Jul 2021 18:09:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] iw: ps: fix "get power_save" documentation
Date:   Thu,  1 Jul 2021 18:09:45 +0200
Message-Id: <20210701180945.45abdb0d4f52.Ifdc6ce8fdbf252019c080f609b6d95cec23d84ee@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This doesn't take any arguments, remove the "<param>"
string from the help.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ps.c b/ps.c
index de36d2b4b4a8..124bf75ccc1d 100644
--- a/ps.c
+++ b/ps.c
@@ -75,6 +75,6 @@ static int get_power_save(struct nl80211_state *state,
 	return 0;
 }
 
-COMMAND(get, power_save, "<param>",
+COMMAND(get, power_save, "",
 	NL80211_CMD_GET_POWER_SAVE, 0, CIB_NETDEV, get_power_save,
 	"Retrieve power save state.");
-- 
2.31.1

