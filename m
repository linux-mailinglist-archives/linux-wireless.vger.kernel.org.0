Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F372E55D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbjFMOLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbjFMOJn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DC1BC3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE9962DCF
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B7FC433D9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686665361;
        bh=NFbjDPlRqQu+fn9/WqwxeIA8pjAggPFRDv1uv5ut/so=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZkKe7pBhOhsITcWoW6ESgjLBchu3M6YrizPpBNcm4KnU7CV2lh68TZ01GfmZqJJvy
         81lYgeGY10P64J95rag9GZTmzufvp6Orftm+hDvr7QiM3EHP5Tx/PhrCNIjtFnQ4rp
         C3YqrJBbUM3Zqiu/usbdljFUl+gQJtKmKkavNFleyoY0HvpnP7j/8lTY7ILThSy1nN
         0XQly28lbO9bPx+6ab0hBduH0FHzdOnnnAH12FsDjsKEJL6Q41CuSR+JlrTSxfxFaf
         +2+AitTuu1A/jTQXgBA5/nbA0EbPOMndPHSyZ2h8zrnL9ZK0ICj8J7epnfLtp16IOb
         7MtftWrn5+Tig==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] wifi: brcmfmac: fix gnu_printf warnings
Date:   Tue, 13 Jun 2023 17:09:15 +0300
Message-Id: <20230613140918.389690-2-kvalo@kernel.org>
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

With GCC 13.1 and W=1 brcmfmac has warnings like this:

./include/trace/perf.h:26:16: warning: function 'perf_trace_brcmf_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Add a workaround which disables -Wsuggest-attribute=format in tracepoint.h. I
see similar workarounds in other drivers as well.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
index 5a139d7ed47a..5d66e94c806d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
@@ -28,6 +28,11 @@ static inline void trace_ ## name(proto) {}
 
 #define MAX_MSG_LEN		100
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 TRACE_EVENT(brcmf_err,
 	TP_PROTO(const char *func, struct va_format *vaf),
 	TP_ARGS(func, vaf),
@@ -123,6 +128,8 @@ TRACE_EVENT(brcmf_sdpcm_hdr,
 		  __entry->len, ((u8 *)__get_dynamic_array(hdr))[4])
 );
 
+#pragma GCC diagnostic pop
+
 #ifdef CONFIG_BRCM_TRACING
 
 #undef TRACE_INCLUDE_PATH
-- 
2.30.2

