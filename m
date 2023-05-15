Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215BC703DB1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 21:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbjEOTZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 15:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245186AbjEOTZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 15:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE517948;
        Mon, 15 May 2023 12:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C6BD62299;
        Mon, 15 May 2023 19:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CDAC433D2;
        Mon, 15 May 2023 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684178691;
        bh=C4wXwE3SPYYJ5PgdOQEua70Xotse/PA3G9oTdV89q3o=;
        h=Date:From:To:Cc:Subject:From;
        b=KvDlSowej9w11xUBHag2aqhuCFCP0F3u4EfeKILBNNsqpIcU0dccNWO71WMmo3ylV
         3pRRZ6+nWsFdzLcyeUSSdtoaY2XVtf92vBREFxb0drolV19E++uxYdBbxBe8tZ569N
         pvvf+J0rz9lmAqsPaFsGJqxmusFzNE4/WSP+PRbRUfvDjuqFsJqyBP8Bgiq+KaZ+N2
         8og8sVCcwNjLRx+9VEZcNx0NEonYI6dsjO8m+VoI8GvtW6WpWfwg6pyBfPXMIoX90D
         1/Trv+ggdmK9DxOqrp4dPgMi3VIsnkZSus9RLioTbQxXGhhG9fyKxe9bWmOSiqOxSj
         rfjgSMIsZKVlw==
Date:   Mon, 15 May 2023 13:25:39 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: wil6210: wmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <ZGKHM+MWFsuqzTjm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zero-length arrays are deprecated, and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations alone in structs with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members alone in structs.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/288
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/wil6210/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 9affa4525609..71bf2ae27a98 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -2763,7 +2763,7 @@ struct wmi_rf_xpm_write_result_event {
 
 /* WMI_TX_MGMT_PACKET_EVENTID */
 struct wmi_tx_mgmt_packet_event {
-	u8 payload[0];
+	DECLARE_FLEX_ARRAY(u8, payload);
 } __packed;
 
 /* WMI_RX_MGMT_PACKET_EVENTID */
-- 
2.34.1

