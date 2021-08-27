Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6326D3F985C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbhH0LMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhH0LMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 07:12:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9317C061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=PaNmqfCsCpP/US9pmoql1HEAMDRBYyvJ50yCDf1kbi0=; t=1630062680; x=1631272280; 
        b=L6EvrLJ6bHhziKL3r58ATfE9F8tVlHaqWdCfm5B13ntemzq++5MBGSLQratCGYJ8Ky25T6K0P7/
        WHPW+rH8JRxNZAqbSCOhDElL3iEFpU2522LpzlIxmmnzgxmxc++4pZcdQwHz5S4afr27M+9wiMWu5
        Wfrv+DY0JT1+7VT54JBIPAZq0odykSGdYiJ8HtHaZrt879ZaR2l9tpAI8SalyDSPb9YcLUuRlfuPy
        zleQDTVLOt5GZxisZtkdiHbVJjkehLY9DpqrbLuAX4Ofbg9w4ufaxa2UfURGAVpVqXLMalnzYf6nx
        7Kp90QWfn6yvMdHHUle7O/gsh3+EoUPPeKMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJZlT-00GaHR-Ke; Fri, 27 Aug 2021 13:11:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: honour V=1 in certificate code generation
Date:   Fri, 27 Aug 2021 13:11:12 +0200
Message-Id: <20210827131112.dc5492458d55.Idefe4ce8f9681a5ad576d3c6e57c7bff142244de@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we generate the code for built-in certificates, honour
the V=1 build option to print out the script doing it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index af590ae606b6..756e7de7e33f 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -26,7 +26,7 @@ endif
 
 $(obj)/shipped-certs.c: $(wildcard $(srctree)/$(src)/certs/*.hex)
 	@$(kecho) "  GEN     $@"
-	@(echo '#include "reg.h"'; \
+	$(Q)(echo '#include "reg.h"'; \
 	  echo 'const u8 shipped_regdb_certs[] = {'; \
 	  echo | cat - $^ ; \
 	  echo '};'; \
@@ -36,7 +36,7 @@ $(obj)/shipped-certs.c: $(wildcard $(srctree)/$(src)/certs/*.hex)
 $(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%) \
 		      $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%)/*.x509)
 	@$(kecho) "  GEN     $@"
-	@(set -e; \
+	$(Q)(set -e; \
 	  allf=""; \
 	  for f in $^ ; do \
 	      test -f $$f || continue;\
-- 
2.31.1

