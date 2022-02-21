Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AB4BDB8B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378487AbiBUO4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 09:56:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbiBUOzm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 09:55:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F617AAD
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=yACwa+XKnP7HjUkXbvE1u/uJVq60I8VL7Dxf+3P1VnY=; t=1645455319; x=1646664919; 
        b=bE25SCMebRhVSDOo7zyz0kjWo3DU8PDDW3lX3VPUVheCjbHijdUeGoC/lofPu+GrNiknl6i4L9G
        sSVENkYy7Vvl56fkYjaEWtJ+KVflqBI4usDuLBJJeOWuLHlBHU9EUTnqPQeunEM3izYOjMkny4sEH
        wpRJkb5QyX36KCV0A4OvZBAEA15sVOMHQYD9G7cSy2q++liQ/W585y4QwcgtVHqODx1pHwk0LxlaT
        mo91rRKVrFzyB/DKp7krGSsmJt+f5016PuZhmHaC+u+tIjzPWJZ5sQ+akyFdhrqDY2QaVNbHmgEiN
        o4JASsuEsV5gZtr0PpRu87TlWiCEZhUSdlSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nMA5r-003rvi-UX;
        Mon, 21 Feb 2022 15:55:16 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: fix CONFIG_CFG80211_EXTRA_REGDB_KEYDIR typo
Date:   Mon, 21 Feb 2022 15:55:12 +0100
Message-Id: <20220221155512.1d25895f7c5f.I50fa3d4189fcab90a2896fe8cae215035dae9508@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The kbuild change here accidentally removed not only the
unquoting, but also the last character of the variable
name. Fix that.

Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 1e9be50469ce..527ae669f6f7 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -33,7 +33,7 @@ $(obj)/shipped-certs.c: $(wildcard $(srctree)/$(src)/certs/*.hex)
 	  echo 'unsigned int shipped_regdb_certs_len = sizeof(shipped_regdb_certs);'; \
 	 ) > $@
 
-$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDI) \
+$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR) \
 		      $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR)/*.x509)
 	@$(kecho) "  GEN     $@"
 	$(Q)(set -e; \
-- 
2.35.1

