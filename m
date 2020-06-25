Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72C209F44
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404932AbgFYNJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404922AbgFYNIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22EC08C5C1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:54 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRca-00BrnC-JO; Thu, 25 Jun 2020 15:08:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/9] wmediumd: add -lstdc++ for SANITIZE=1
Date:   Thu, 25 Jun 2020 15:08:36 +0200
Message-Id: <20200625150754.5b773d0f5e50.I3d0915b84d33b5a770cef1c1273bd33ac4e72d7b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625130844.22893-1-johannes@sipsolutions.net>
References: <20200625130844.22893-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It appears that in some scenarios this is necessary to get
the right version of the library, otherwise some runtime
linking can fail. Add -lstdc++ as required by -lasan.

---
 wmediumd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wmediumd/Makefile b/wmediumd/Makefile
index f75c4e8b4e3e..fa94eb01fbc2 100644
--- a/wmediumd/Makefile
+++ b/wmediumd/Makefile
@@ -56,7 +56,7 @@ OBJECTS += lib/uds.o lib/vhost.o lib/wallclock.o
 ifeq ($(SANITIZE),1)
 CFLAGS += -fsanitize=undefined,address
 # apparently these have to come first for some reason
-override LDFLAGS := -lasan -lubsan $(LDFLAGS)
+override LDFLAGS := -lasan -lubsan -lstdc++ $(LDFLAGS)
 endif
 
 all: wmediumd 
-- 
2.26.2

