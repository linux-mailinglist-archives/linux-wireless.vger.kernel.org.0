Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981937BE756
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377262AbjJIRF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377138AbjJIRF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 13:05:58 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405F9E
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 10:05:52 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4110:0:640:2904:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 6AFC160034;
        Mon,  9 Oct 2023 20:05:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id n5g4L74DRiE0-xiA09JoW;
        Mon, 09 Oct 2023 20:05:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696871149; bh=suQylW4wQuqL3zRtHomsHrDX9wT8ZTJMOLS9TZPzx8E=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=mh8mk4gIxzs08IwfLJwOWQUy2DlxiH7LEneTbi/UPwQ9kb2XYGM8awikvYvj6dhJE
         lVSwkhlQPs/Wm+/b6Yze5uk8wQmVcD97xPjPeY9fpDW3/tengaRb41ltIdJPqgb+FG
         kXgiS32+k/uKsreM+JDDCs+vlZXxFZ68Ku0hEBjA=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlwifi: check for kmemdup() return value in iwl_parse_tlv_firmware()
Date:   Mon,  9 Oct 2023 20:04:49 +0300
Message-ID: <20231009170453.149905-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'iwl_parse_tlv_firmware()', check for 'kmemdup()' return value
when handling IWL_UCODE_TLV_CURRENT_PC and set the number of parsed
entries only if an allocation was successful (just like it does with
handling IWL_UCODE_TLV_CMD_VERSIONS above). Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index fb5e254757e7..6cba18547549 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1303,10 +1303,12 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 		case IWL_UCODE_TLV_CURRENT_PC:
 			if (tlv_len < sizeof(struct iwl_pc_data))
 				goto invalid_tlv_len;
-			drv->trans->dbg.num_pc =
-				tlv_len / sizeof(struct iwl_pc_data);
 			drv->trans->dbg.pc_data =
 				kmemdup(tlv_data, tlv_len, GFP_KERNEL);
+			if (!drv->trans->dbg.pc_data)
+				return -ENOMEM;
+			drv->trans->dbg.num_pc =
+				tlv_len / sizeof(struct iwl_pc_data);
 			break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
-- 
2.41.0

