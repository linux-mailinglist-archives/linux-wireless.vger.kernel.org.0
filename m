Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB27C6FDA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjJLN7B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379089AbjJLN66 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 09:58:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54279B7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 06:58:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD9CC433C9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697119136;
        bh=jF+7IMp5CgKRFx2BgekeEO1YriNortFU8RNFF52/nTQ=;
        h=From:To:Subject:Date:From;
        b=M0331rq1filE3VKlz0Ai205HRTH9cpyHukB1mslKfnIg1/s+QyUaCYRfIwYOb1W9c
         6Dpi5JevtEiFP68fDt/tbT0VSdoc5nvl5V7fImXERajxwOM1Aj4w4R+Ivml/UA8Rh4
         /RAdjLTERC0sYxkQ50dbLxepwA7Djq/p7QjoBB+FjttiCTNmasojMbIKfdHf2qWbWw
         qwMX8DG0hitB1nH9FXGielvP94cGVDAFDpid4TtPV6RQWihMo4zcY46FzWg5y0w9ql
         YWdGlaH55bSvKV/o0psS4euLs5ZZhsRRQPz95LJLW2nXCLak0bS7MjT3oJwonaS1IV
         I0FGKFg10dDjg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] wifi: brcmfmac: fix format-truncation warnings
Date:   Thu, 12 Oct 2023 16:58:52 +0300
Message-Id: <20231012135854.3473332-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On v6.6-rc4 with GCC 13.2 I see:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:52: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size 4 [-Wformat-truncation=]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:9: note: 'snprintf' output between 9 and 17 bytes into a destination of size 9
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:55: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size 4 [-Wformat-truncation=]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:9: note: 'snprintf' output between 10 and 18 bytes into a destination of size 10
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:50: warning: '/' directive output may be truncated writing 1 byte into a region of size between 0 and 4 [-Wformat-truncation=]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:42: note: directive argument in the range [0, 65535]
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:9: note: 'snprintf' output between 10 and 18 bytes into a destination of size 10

Fix these by increasing the buffer sizes to 20 bytes to make sure there's enough space.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 09d2f2dc2b46..83f8ed7d00f9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -19,7 +19,7 @@
 
 #define BRCMF_FW_MAX_NVRAM_SIZE			64000
 #define BRCMF_FW_NVRAM_DEVPATH_LEN		19	/* devpath0=pcie/1/4/ */
-#define BRCMF_FW_NVRAM_PCIEDEV_LEN		10	/* pcie/1/4/ + \0 */
+#define BRCMF_FW_NVRAM_PCIEDEV_LEN		20	/* pcie/1/4/ + \0 */
 #define BRCMF_FW_DEFAULT_BOARDREV		"boardrev=0xff"
 #define BRCMF_FW_MACADDR_FMT			"macaddr=%pM"
 #define BRCMF_FW_MACADDR_LEN			(7 + ETH_ALEN * 3)
@@ -238,9 +238,9 @@ static void brcmf_fw_strip_multi_v1(struct nvram_parser *nvp, u16 domain_nr,
 				    u16 bus_nr)
 {
 	/* Device path with a leading '=' key-value separator */
-	char pci_path[] = "=pci/?/?";
+	char pci_path[20];
 	size_t pci_len;
-	char pcie_path[] = "=pcie/?/?";
+	char pcie_path[20];
 	size_t pcie_len;
 
 	u32 i, j;

base-commit: 618071ae0f7e8c1aeb9b1b1e9ee876bcc3f045fc
-- 
2.39.2

