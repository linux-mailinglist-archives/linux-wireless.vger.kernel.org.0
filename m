Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B473516A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjFSKCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjFSKC2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 06:02:28 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C801B5
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 03:02:01 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2d2c:0:640:8fff:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 278BC60143;
        Mon, 19 Jun 2023 13:01:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id c1deSmgWoiE0-xsUJ0iEM;
        Mon, 19 Jun 2023 13:01:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687168918;
        bh=wwPYMNt8fn1ICVVJoKhP6jwf9IwAtMcq0I4uvItKMZI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=fnLDf+Enn06EU4IrboAMTtmexDs+ovy9ng+hGmzweUpla3tT2nhkWThxsii63sC9M
         iDmHDez9b9wf65bC4rkdmI2FDBwwGExNkx38w4YCXHcJvxHEPppCqh7jRGmt9P98TP
         +OYnX8CMCVaWbGpndYOSn73dSoxMpEREZBH/XHYE=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlfifi: fix -Wunused-const-variable gcc warning
Date:   Mon, 19 Jun 2023 13:00:25 +0300
Message-ID: <20230619100030.284920-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following gcc 13.1 warning observed with W=1:

drivers/net/wireless/intel/iwlwifi/dvm/rs.c:207:39: warning:
‘iwl_rate_mcs’ defined but not used [-Wunused-const-variable=]

This table is actually used in 'rs_sta_dbgfs_scale_table_read()'
only if CONFIG_MAC80211_DEBUGFS is enabled.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 687c906a9d72..ecad7403ec96 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -203,6 +203,8 @@ static const u16 expected_tpt_mimo3_40MHz[4][IWL_RATE_COUNT] = {
 	{0, 0, 0, 0, 277, 0, 478, 624, 737, 911, 1026, 1070, 1109}, /* AGG+SGI */
 };
 
+#ifdef CONFIG_MAC80211_DEBUGFS
+
 /* mbps, mcs */
 static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
 	{  "1", "BPSK DSSS"},
@@ -220,6 +222,8 @@ static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
 	{ "60", "64QAM 5/6"},
 };
 
+#endif
+
 #define MCS_INDEX_PER_STREAM	(8)
 
 static void rs_rate_scale_clear_window(struct iwl_rate_scale_data *window)
-- 
2.41.0

