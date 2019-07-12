Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF670662B2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfGLARS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 20:17:18 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46897 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLARS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 20:17:18 -0400
Received: by mail-pg1-f201.google.com with SMTP id u1so4580724pgr.13
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2019 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w66HmPq4DsASMlERtyuZxwvEbhjRa6bY9sh7WF19zZA=;
        b=Grb/FtAmD7S6qiP7UTPMcpxLI/FOc3jeld4A1buTh8PFgn8eanDSppYavnoTdkPcNA
         awQdxO7iZWj39P8Ru6CmtLAFWfptS3/9OWcnJNtXpUgM1c++KhG6ecw2SXZuH3TMS/xB
         c+YY3/eIquAWrnMIZcuNbSAkkg88tL5NsML5EKS8QE5FymmDdztWt5kRKDoFXCiPY8tS
         3Vf9C4KrUkmCkBWfktU6lRDdG2utkiJ3uUMn0I7D1KiygiqgU11hJdSkXXzL6w7OaauV
         5ZrwkWKXnBpos/ipY2Y4Uy+DuaNvQxZiKQ3MAPGZ/fomO85VLCAcW4HyahNdSRIJDQI6
         +cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w66HmPq4DsASMlERtyuZxwvEbhjRa6bY9sh7WF19zZA=;
        b=TgjBzXNdWmV5qyQ6IjAK0P4ABamHh+R5v4mOKZE7HpHLOOqiid7ED0Gin3nCosRdf8
         aAICVjMwSVxUfkIlptLJbkfRYAZGcy3VLkcurVwH1BOcdlUYCcY4ISE2FA77PXszMKRZ
         KJS1+aCmhMh/7wTVzsFKcvowhZCJi57NQU8Yacg9MXQhL+MNqa7EOWxK1ll+wwjpM2s8
         6tC5ZInVI1uyYCzaI5YKCwyFG8iToblKjZuTkVw6DAb9gbM7wunN4VTBS9F7M37SOOSz
         eoA5KqTWWHvAZluSEJfRtVJk9HSr5I8MWfI3b69amt3F3MXclT+pFzfsGM1oflwHpyJe
         tKWw==
X-Gm-Message-State: APjAAAXjrzkd1LYgjTJDUvAFyTZvrjDCuJCSYUzeG5TFx7soeDS/HKzK
        xq2r7vpEjyfygaXMWytX/ox+jXmQoN6mRrBNSEg=
X-Google-Smtp-Source: APXvYqwZkJvWCP2kEkaaTJ/i9YjTiw1o2lW3XwT/9mh0N24TJP7NfY4x0EnHqdaqplthq1yPxJ+0pf17FvIKfYsQEhM=
X-Received: by 2002:a65:44ca:: with SMTP id g10mr7094676pgs.435.1562890637164;
 Thu, 11 Jul 2019 17:17:17 -0700 (PDT)
Date:   Thu, 11 Jul 2019 17:17:06 -0700
Message-Id: <20190712001708.170259-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH -next] iwlwifi: dbg: work around clang bug by marking debug
 strings static
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     kvalo@codeaurora.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit r353569 in prerelease Clang-9 is producing a linkage failure:

ld: drivers/net/wireless/intel/iwlwifi/fw/dbg.o:
in function `_iwl_fw_dbg_apply_point':
dbg.c:(.text+0x827a): undefined reference to `__compiletime_assert_2387'

when the following configs are enabled:
- CONFIG_IWLWIFI
- CONFIG_IWLMVM
- CONFIG_KASAN

Work around the issue for now by marking the debug strings as `static`,
which they probably should be any ways.

Link: https://bugs.llvm.org/show_bug.cgi?id=42580
Link: https://github.com/ClangBuiltLinux/linux/issues/580
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e411ac98290d..f8c90ea4e9b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2438,7 +2438,7 @@ static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
 {
 	u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
 	u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
-	const char err_str[] =
+	static const char err_str[] =
 		"WRT: ext=%d. Invalid %s name length %d, expected %d\n";
 
 	if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
@@ -2775,7 +2775,7 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		struct iwl_ucode_tlv *tlv = iter;
 		void *ini_tlv = (void *)tlv->data;
 		u32 type = le32_to_cpu(tlv->type);
-		const char invalid_ap_str[] =
+		static const char invalid_ap_str[] =
 			"WRT: ext=%d. Invalid apply point %d for %s\n";
 
 		switch (type) {
-- 
2.22.0.410.gd8fdbe21b5-goog

