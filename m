Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155D3786911
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjHXHz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjHXHz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 03:55:26 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E74170C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 00:55:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id BA0BC603D4;
        Thu, 24 Aug 2023 10:54:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nsFdET9WwmI0-OEH6mo4p;
        Thu, 24 Aug 2023 10:54:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692863690;
        bh=AfYkJSCKHAqWsERHvZQ7Utd958ZltNw48aNsHiisNYc=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Ooo38xcoZdB3Mh4BLrUOEzSsX8KUNXSRldh68JQ9Gi/bJO6N6MJGaniWKgRMqRY/H
         wjmCmgsZSkzWgqbc19J5Qx6m/qghgLHgbRBkTEwf6GVEJUMX90NtDMSpEjzaMO4Q1Y
         VkILn07txt1ma8b/Uw3Qq/wKNswrYyLSeDAX5V00=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/5] wifi: ath11k: remove unused members of 'struct ath11k_base'
Date:   Thu, 24 Aug 2023 10:50:45 +0300
Message-ID: <20230824075121.121144-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824075121.121144-1-dmantipov@yandex.ru>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove set but otherwise unused 'wlan_init_status' and
'wmi_ready' members of 'struct ath11k_base', adjust
'ath11k_wmi_tlv_rdy_parse()' accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/core.h | 2 --
 drivers/net/wireless/ath/ath11k/wmi.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b04447762483..650972f9d146 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -901,8 +901,6 @@ struct ath11k_base {
 	struct list_head peers;
 	wait_queue_head_t peer_mapping_wq;
 	u8 mac_addr[ETH_ALEN];
-	bool wmi_ready;
-	u32 wlan_init_status;
 	int irq_num[ATH11K_IRQ_NUM_MAX];
 	struct ath11k_ext_irq_grp ext_irq_grp[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 	struct ath11k_targ_cap target_caps;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 23ad6825e5be..a5cf97368a14 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7222,14 +7222,12 @@ static int ath11k_wmi_tlv_rdy_parse(struct ath11k_base *ab, u16 tag, u16 len,
 		memset(&fixed_param, 0, sizeof(fixed_param));
 		memcpy(&fixed_param, (struct wmi_ready_event *)ptr,
 		       min_t(u16, sizeof(fixed_param), len));
-		ab->wlan_init_status = fixed_param.ready_event_min.status;
 		rdy_parse->num_extra_mac_addr =
 			fixed_param.ready_event_min.num_extra_mac_addr;
 
 		ether_addr_copy(ab->mac_addr,
 				fixed_param.ready_event_min.mac_addr.addr);
 		ab->pktlog_defs_checksum = fixed_param.pktlog_defs_checksum;
-		ab->wmi_ready = true;
 		break;
 	case WMI_TAG_ARRAY_FIXED_STRUCT:
 		addr_list = (struct wmi_mac_addr *)ptr;
-- 
2.41.0

