Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964357352F5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 12:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjFSKk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjFSKkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 06:40:15 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C8102
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 03:39:59 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2d23:0:640:2dd6:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 534D1600D7;
        Mon, 19 Jun 2023 13:39:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZddVL5hDR8c0-QmVnjIaj;
        Mon, 19 Jun 2023 13:39:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687171196;
        bh=FZKFBiQVDyShcC1qqzGWcNfoLpNCQzZvn3yzgg9sSMY=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=OWEr32cyphGzzXRDWw1lyy3qsmCivOx1ELJlWrxshr/nDrRMfnGnRua03xuteDTQ8
         3GPQaGlQuVztZ1aj/ro0qz9N1RzKdQsnHRdAeTJBMo13tDsT+gmSyOxRqijTeRb6W9
         GxVKJ8q0m2vaYIRbqhg4JRXF8Ew8M4DtUK/9pazc=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: iwlwifi: dvm: fix -Wunused-const-variable gcc warning
Date:   Mon, 19 Jun 2023 13:38:56 +0300
Message-ID: <20230619103900.300628-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <6abc24f254fd265f8f533ef52e2798c617e30359.camel@sipsolutions.net>
References: <6abc24f254fd265f8f533ef52e2798c617e30359.camel@sipsolutions.net>
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
only if CONFIG_MAC80211_DEBUGFS is enabled, so the whole thing
may be moved close to its actual use.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: fix title and move iwl_rate_mcs to rs_sta_dbgfs_scale_table_read() (Johannes Berg)
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 34 ++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 687c906a9d72..e0c3563da8a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -203,23 +203,6 @@ static const u16 expected_tpt_mimo3_40MHz[4][IWL_RATE_COUNT] = {
 	{0, 0, 0, 0, 277, 0, 478, 624, 737, 911, 1026, 1070, 1109}, /* AGG+SGI */
 };
 
-/* mbps, mcs */
-static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
-	{  "1", "BPSK DSSS"},
-	{  "2", "QPSK DSSS"},
-	{"5.5", "BPSK CCK"},
-	{ "11", "QPSK CCK"},
-	{  "6", "BPSK 1/2"},
-	{  "9", "BPSK 1/2"},
-	{ "12", "QPSK 1/2"},
-	{ "18", "QPSK 3/4"},
-	{ "24", "16QAM 1/2"},
-	{ "36", "16QAM 3/4"},
-	{ "48", "64QAM 2/3"},
-	{ "54", "64QAM 3/4"},
-	{ "60", "64QAM 5/6"},
-};
-
 #define MCS_INDEX_PER_STREAM	(8)
 
 static void rs_rate_scale_clear_window(struct iwl_rate_scale_data *window)
@@ -3089,6 +3072,23 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 	int index = 0;
 	ssize_t ret;
 
+	/* mbps, mcs */
+	static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
+		{  "1", "BPSK DSSS"},
+		{  "2", "QPSK DSSS"},
+		{"5.5", "BPSK CCK"},
+		{ "11", "QPSK CCK"},
+		{  "6", "BPSK 1/2"},
+		{  "9", "BPSK 1/2"},
+		{ "12", "QPSK 1/2"},
+		{ "18", "QPSK 3/4"},
+		{ "24", "16QAM 1/2"},
+		{ "36", "16QAM 3/4"},
+		{ "48", "64QAM 2/3"},
+		{ "54", "64QAM 3/4"},
+		{ "60", "64QAM 5/6"},
+	};
+
 	struct iwl_lq_sta *lq_sta = file->private_data;
 	struct iwl_priv *priv;
 	struct iwl_scale_tbl_info *tbl = &(lq_sta->lq_info[lq_sta->active_tbl]);
-- 
2.41.0

