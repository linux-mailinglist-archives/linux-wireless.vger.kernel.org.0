Return-Path: <linux-wireless+bounces-21797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522EA95777
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 22:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E415171790
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44411F0998;
	Mon, 21 Apr 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejxT8q8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C813FEE;
	Mon, 21 Apr 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268122; cv=none; b=uBzenzF1DI2itx6An1ZjzFLSm6DUAugPtLH+efoTmMzMI4/6Rx3BJUgdY14WQg1rLXW3Jjc4z2t5eJDCQ5uP4RhyjT6unxwQWUx9Met/kNJKfV/l29YkdY+zlRPPQRagKvFnHt59Q/fK3JdvTPTBeIUgmlGfYSjMb/RUGLIFk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268122; c=relaxed/simple;
	bh=SaHUDpG/KtJiabL+vK/44GPnj3+naOMh0+x+Ljuvsyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RqAqjS6FW2wrHp5vls134mBO5bAoKYyi10AaRN9BlX7pWf0OBi6d7eS2DSfhykNU2Pwaa9Cie6h2kNVnnQPPEk0oC9ZrQOMUsjMTdvYJVCdId6EeqHMAa3nBwPBLDK4bgzaeBQv6skbs0QNuxiiLjeTPuTWqqtGzPeW2Gt4tiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejxT8q8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9149C4CEE4;
	Mon, 21 Apr 2025 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745268121;
	bh=SaHUDpG/KtJiabL+vK/44GPnj3+naOMh0+x+Ljuvsyg=;
	h=From:To:Cc:Subject:Date:From;
	b=ejxT8q8pnXRTVR0uHOPywbGftrfJawITRnc09+gHc0oQoRTfs8a7yZpORTxyMU9Pz
	 CGMtzm5qsBZInmtyzg2ybgfyLMqgEmzHqOQEKNMuLzAPvj1CBPLP7vlyUn0YCAglzC
	 dUFap8UgebrB/yeIEc0NMIrUhGsFoqp9dtlhj3eke3o5OuOx3UIuYFhxFCfk4if+xd
	 G86OQTwcbuLasbLSQ1dX/A1jT9LMumhhJM8O0/4uAlnQjtmHx3Tmel1bdN69ciW54R
	 A22j4fdkHiNRIfFySLZja0OT5H27levPXklQSD1NV7AkW8hCRZehrex2TuiYm004n/
	 7YLj8MEgZQDxg==
From: Kees Cook <kees@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mld: Work around Clang loop unrolling bug
Date: Mon, 21 Apr 2025 13:41:57 -0700
Message-Id: <20250421204153.work.935-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; i=kees@kernel.org; h=from:subject:message-id; bh=SaHUDpG/KtJiabL+vK/44GPnj3+naOMh0+x+Ljuvsyg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlsa6ey7+r89tvb69Tdk6bbNUpLVr+uOLDFS8GuqM7I5 uqsVf5eHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPR/MnwP+Pf5HW/2zWCIsK8 Lk4xXu2wwi2mViNxQ31zktSuzVaP3jD8le+38PR/amewuI99yecrFc2tqkwLVIv/esrsX1T2Zvl vLgA=
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
Fix the build by explicitly bounding the inner loop by "n_nsc", which
is what "c" is already limited to.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2076
Link: https://github.com/llvm/llvm-project/pull/73552 [1]
Link: https://github.com/llvm/llvm-project/issues/136603 [2]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Avraham Stern <avraham.stern@intel.com>
Cc: Daniel Gabay <daniel.gabay@intel.com>
Cc: <linux-wireless@vger.kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 2c6e8ecd93b7..1daca1ef02b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1754,7 +1754,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 
 		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
 					  &solicited_addr);
-		for (j = 0; j < c; j++)
+		for (j = 0; j < c && j < n_nsc; j++)
 			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
 					  &solicited_addr) == 0)
 				break;
-- 
2.34.1


