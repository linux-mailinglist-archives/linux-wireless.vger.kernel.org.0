Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB66699D3D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBPT6E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 14:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBPT6D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 14:58:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C03B233
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 11:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=KHs2AeR1yP7T6fcAppFJZ2Re/SmHPZ4f4BskqUk80TM=; t=1676577481; x=1677787081; 
        b=hiR2j8OnQCzpWtLrvMazm3Fw98m+Tl1GkNzfp/+NtyZ9VbHTFLA7aa4EPCCxOXtUbEZHEveKQ8d
        R172F3Gazo3lG4xRUYzBsA5O4vykOLod1yvB+0iNqFqHXbCzrOVsFJfYWUnBnodmn28K+HIHpN5ia
        H4JnJqB0SULQLKS9HKVcGzoQWPbPuFkwIoXvjV651P/wQxT5cwVhObu6ndU7W4JxUgI3zYA+Rc1mD
        NgbiUkX3TkcKvWGsC3FjPLwiJ6nt9RbAU4OJnCWqnCFcPOc7Vs+wziWF48HnRUIVGc7groXvfQPur
        gzmXTFhMQt0p4H4bPSoTkB+PzV7MAD4suyAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSkOC-00EBGe-2l;
        Thu, 16 Feb 2023 20:57:56 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: remove unused iwl_dbgfs_is_match()
Date:   Thu, 16 Feb 2023 20:57:54 +0100
Message-Id: <20230216205754.d500dcc2e90c.Id87df297263f86b5bba002f7cbb387abc13adf53@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This inline function is unused, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 78d8b37eb71a..3779ac040ba0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -438,13 +438,6 @@ static ssize_t iwl_dbgfs_bf_params_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
 
-static inline char *iwl_dbgfs_is_match(char *name, char *buf)
-{
-	int len = strlen(name);
-
-	return !strncmp(name, buf, len) ? buf + len : NULL;
-}
-
 static ssize_t iwl_dbgfs_os_device_timediff_read(struct file *file,
 						 char __user *user_buf,
 						 size_t count, loff_t *ppos)
-- 
2.39.2

