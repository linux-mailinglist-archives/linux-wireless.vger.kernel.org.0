Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68C74E1B0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjGJXDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 19:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGJXDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 19:03:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF62F9;
        Mon, 10 Jul 2023 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eeNKKnFfqVsbTDrMCi8dJOr2RFY9P/RKFkjoayT3ATo=; b=qjHRJLwzXLCekl5/nn+XtGvqYg
        T5bZ1vMSQFwsG+GI5HMnt+uJRMYn2OwiCXHSneGISwRBIpd0ndwiWUBOX2WsYzto1H6PIC0VjOGZa
        zAaUDVnO+MX8Yr4lGoARU5WlQBknH9zLUFp8u0Jd4pn53tb+glXIWJ8zzONM8lYJsdNXR2fkUI5od
        R/lXRbvintmfFws2ud4QDXuNjKPJX7f0dYS8j2BKcV+W/eN5WvMsZDDHDLTYEN6Wz2CXKdDZkE0Lz
        D77yg1UuBN7E7q4IswO+Pf3DGFPgNrMK8K+Z3fd3sSI4NbNRLnrK/zvm8Z4hePwoSqVx/ceh+Zr0Q
        xhA9d7Rg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzuW-00CuO1-3D;
        Mon, 10 Jul 2023 23:03:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     netdev@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [PATCH net 06/12] wifi: radiotap: fix kernel-doc notation warnings
Date:   Mon, 10 Jul 2023 16:03:06 -0700
Message-ID: <20230710230312.31197-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230312.31197-1-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a typo (82011 -> 80211) to prevent a kernel-doc warning.
Add one missing function parameter description to prevent a
kernel-doc warning.

ieee80211_radiotap.h:52: warning: expecting prototype for struct ieee82011_radiotap_header. Prototype was for struct ieee80211_radiotap_header instead
ieee80211_radiotap.h:581: warning: Function parameter or member 'data' not described in 'ieee80211_get_radiotap_len'

Fixes: 42f82e2e62ae ("wireless: radiotap: rewrite the radiotap header file")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
---
 include/net/ieee80211_radiotap.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -21,7 +21,7 @@
 #include <asm/unaligned.h>
 
 /**
- * struct ieee82011_radiotap_header - base radiotap header
+ * struct ieee80211_radiotap_header - base radiotap header
  */
 struct ieee80211_radiotap_header {
 	/**
@@ -575,6 +575,7 @@ enum ieee80211_radiotap_eht_usig_tb {
 
 /**
  * ieee80211_get_radiotap_len - get radiotap header length
+ * @data: pointer to the header
  */
 static inline u16 ieee80211_get_radiotap_len(const char *data)
 {
