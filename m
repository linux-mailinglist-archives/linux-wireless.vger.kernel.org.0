Return-Path: <linux-wireless+bounces-22082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F15A9D0AA
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 20:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B32E7B52F7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A5217F24;
	Fri, 25 Apr 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWLSz1ka"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8F216E1B;
	Fri, 25 Apr 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606671; cv=none; b=T7Si1ViUih417qTegztSoR2l0HY26LHH6iyr5WdLH10abFmIhezEgYN6T74GxoFuMar7EzApak1KwlWnmRtHXjWJwWbxNiCMdJY7tMOvfyghIkuXy5htNBz+WvOBjhiZhJ0xyO7rvBduTU+4GYn/L+X6MB5UD+WovfMp3Pg7Bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606671; c=relaxed/simple;
	bh=kqRG1XBJc9DW5Ecd0qIWYW6BijL3k7/p0zlS9agGn1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EfXwRdScZRiT2NS03ctZ/F2XuXFJGlVRl8Rb0A16+7hPHhr6e08rwiEtpdkmK/rbXmuyGySD96xW+D3NN0IbpQk/pvFZgiYHDd1dnoK0bJ3nzcpEPvfdSHtO3wieXKzY+4tB0UbB4l2PgoXQ1OUPDdKOwsB+0fOnQgtyQudrBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWLSz1ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D56C4CEE4;
	Fri, 25 Apr 2025 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745606670;
	bh=kqRG1XBJc9DW5Ecd0qIWYW6BijL3k7/p0zlS9agGn1k=;
	h=From:To:Cc:Subject:Date:From;
	b=kWLSz1kaJ0Ibzi6tDPWApcg7ivnePju8rKj/SBaB0c/jYi5wHP7JBTFgO/EK2SUSW
	 5V+aK+cdxCP1/+l/U97Tkm9PgjuHOlhK87s1jt9un3juXj7sptaI8VDFUmXCKRPbMN
	 WeCtmZeTFZmN8jTRX0j42ZQqXmgLxC8hA+HZA4m2ocO4cAMLirp29fKmqU5llRxyDc
	 /vDgpt/biXLg4VxQDW55IYoqLRyGMtL1/9h6Nfb+dD6XfyMZ69LoSEBQFGnyjTNP2f
	 2rWzSc80AUBtE0hh736gtBSTUk+0dFXo1MRDChDzXEIR/knrvjUGGOMYCrD5NWqd57
	 St26DEUJcsztg==
From: Kees Cook <kees@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	linux-wireless@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: iwlwifi: mld: Work around Clang loop unrolling bug
Date: Fri, 25 Apr 2025 11:44:22 -0700
Message-Id: <20250425184418.it.308-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=kees@kernel.org; h=from:subject:message-id; bh=kqRG1XBJc9DW5Ecd0qIWYW6BijL3k7/p0zlS9agGn1k=; b=owGbwMvMwCVmps19z/KJym7G02pJDBncN9jqps6KXXlo4yvXc+6vhFislq2LfRzo9+DD1Uqh7 g1O855IdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkmTTDfxfHE7XPWU4tW6gY 6aCVat+/O+dh5RvpUBeXQ59zhWpvv2H4n3pl5wfXSykf7U+bv+f2vZX1/IPtH/8LG35Urbd0Oh0 xjREA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The nested loop in iwl_mld_send_proto_offload() confuses Clang into
thinking there could be final loop iteration past the end of the "nsc"
array (which is only 4 entries). The FORTIFY checking in memcmp()
(via ipv6_addr_cmp()) notices this (due to the available bytes in the
out-of-bounds position of &nsc[4] being 0), and errors out, failing
the build. For some reason (likely due to architectural loop unrolling
configurations), this is only exposed on ARM builds currently. Due to
Clang's lack of inline tracking[1], the warning is not very helpful:

include/linux/fortify-string.h:719:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
  719 |                         __read_overflow();
      |                         ^
1 error generated.

But this was tracked down to iwl_mld_send_proto_offload()'s
ipv6_addr_cmp() call.

An upstream Clang bug has been filed[2] to track this, but for now.
Fix the build by explicitly bounding the inner loop by "n_nsc", which is
what "c" is already limited to. Additionally do not repeat the ns_config
and targ_addrs array sizes with their open-coded names since they can
be determined at compile-time with ARRAY_SIZE().

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2076
Link: https://github.com/llvm/llvm-project/pull/73552 [1]
Link: https://github.com/llvm/llvm-project/issues/136603 [2]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2:
  - move "j < n_nsc" forward to stabilize loop bounds (Nathan)
  - use ARRAY_SIZE() for robustness
 v1: https://lore.kernel.org/all/20250421204153.work.935-kees@kernel.org/
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Avraham Stern <avraham.stern@intel.com>
Cc: <linux-wireless@vger.kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index dc736fdc176d..c51a6596617d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1728,17 +1728,13 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct iwl_mld_wowlan_data *wowlan_data = &mld_vif->wowlan_data;
-	struct iwl_ns_config *nsc;
-	struct iwl_targ_addr *addrs;
-	int n_nsc, n_addrs;
+	const int n_addrs = ARRAY_SIZE(cmd->targ_addrs);
+	struct iwl_targ_addr *addrs = cmd->targ_addrs;
+	const int n_nsc = ARRAY_SIZE(cmd->ns_config);
+	struct iwl_ns_config *nsc = cmd->ns_config;
 	int i, c;
 	int num_skipped = 0;
 
-	nsc = cmd->ns_config;
-	n_nsc = IWL_PROTO_OFFLOAD_NUM_NS_CONFIG_V3L;
-	addrs = cmd->targ_addrs;
-	n_addrs = IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V3L;
-
 	/* For each address we have (and that will fit) fill a target
 	 * address struct and combine for NS offload structs with the
 	 * solicited node addresses.
@@ -1759,7 +1755,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 
 		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
 					  &solicited_addr);
-		for (j = 0; j < c; j++)
+		for (j = 0; j < n_nsc && j < c; j++)
 			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
 					  &solicited_addr) == 0)
 				break;
-- 
2.34.1


