Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DF72E563
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjFMOLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbjFMOJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DD1BD0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EEA662BF4
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FABFC433F1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686665362;
        bh=HGUJPj8Zb2nczOTlJUfhU7bQeSCQyXzXYC+YrzNKh3g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EMYHYbGB0ylaYfz4/EMBU7qI/7X8I7rxvBN0QkgxknuHOm04rMqExjwsW68ooKdLb
         YTOGSoO3ehGIrLL6bE99tNhiT5kF4pSlwXd0e+5bF7Rt7v6lzLBtGfoFs+zBbHFDBo
         PaqMJ/5v1C/H3VYqewWpPZizF2bAf5WbrmRpWwIIfVctdQ6fSFIAKcsoOKMur9wogb
         Y5ahfHVqpWrAE8bFx+DUlnNh/p4x5+1fyVpb6AEQsu//lasLhm0iWlVnc+Urw6wYBY
         cjHT4BK1RJ+fsE1Iu4I5osfTNNjpjyTcaxlsML92NqPaDDNsW4Y+ZqjSLfnK7pmqMr
         FrOQwhjoqYI3w==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] wifi: brcmsmac: fix gnu_printf warnings
Date:   Tue, 13 Jun 2023 17:09:16 +0300
Message-Id: <20230613140918.389690-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613140918.389690-1-kvalo@kernel.org>
References: <20230613140918.389690-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With GCC 13.1 and W=1 brcmsmac has warnings like this:

./include/trace/stages/stage5_get_offsets.h:23:31: warning: function 'trace_event_get_offsets_brcms_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Add a workaround which disables -Wsuggest-attribute=format in
brcms_trace_brcmsmac_msg.h. I see similar workarounds in other drivers as well.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
index 488456420353..42b0a91656c4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
@@ -24,6 +24,11 @@
 
 #define MAX_MSG_LEN	100
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 DECLARE_EVENT_CLASS(brcms_msg_event,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
@@ -71,6 +76,9 @@ TRACE_EVENT(brcms_dbg,
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
 );
+
+#pragma GCC diagnostic pop
+
 #endif /* __TRACE_BRCMSMAC_MSG_H */
 
 #ifdef CONFIG_BRCM_TRACING
-- 
2.30.2

