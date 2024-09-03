Return-Path: <linux-wireless+bounces-12418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3E96A8FD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936871F21127
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B51E2034;
	Tue,  3 Sep 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl3WWVtM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C61E2007;
	Tue,  3 Sep 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396261; cv=none; b=IsFyGWez49VLcU1CssfALLPi1EqSdkGjwMEYBcb/5+Fr4XbjH99Fko1/EPfm5WDNcH9YoUwZJH81Upm9AnNfqCiuDM65sMYAKkH1891kR2zB4QzTTvM0tn+0TRsBmvAfYpsy42LVkcAKjkGYKMRmq1n0sa62bpyYeFNoemhPyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396261; c=relaxed/simple;
	bh=oBOhc0KQk16SjPzJz3+EVLQB5ROJGUTUFd6HwGv8WOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg+NSnJoY8yzgcldp5AkzRRdS90c0zzuJ4agHNYpwqGYfLxTUiGBZZbTlDN7f62bhi77l0CqyIk0p7o1SQi1Wkeg1LnYE/Dt5EBKCWWMgxnIeOToZD2B+JBJjSqyqikRL7v78u1xlpolyQzruEFmJJk+p2sNUMxRkhtgykQWF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl3WWVtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B257C4CEC4;
	Tue,  3 Sep 2024 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396261;
	bh=oBOhc0KQk16SjPzJz3+EVLQB5ROJGUTUFd6HwGv8WOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bl3WWVtMDlCAddR/s/An5bIriM1c4qgd2ZVatuc/M+Z+6v8K/HGN3mHOqPKfyk7Vi
	 /0PFMvdr27QrUoCJp2JTcaDzv/42KnZaZWczuDFiN1taziBBykGfqnTFVz3IwsbeA+
	 qIobpFYg7CmAITRZiwlzRJeZpqT09iVjjuk81qzh61kA/xam2r2mG6/VsAD3jCz0vN
	 JnGOnzrH8UZcSTrSgDPgPbFo0vpTGq1fLBCzeE/GIWRtOHKMR8xYIGJoT1AH50JSen
	 WocW5X0Tvw0Xh/B9q5qLmKyFTJOc0z/b7OIXyHYXgc58T5TEWO0dUKKywW91E83PR5
	 b08Ma8L3mf0JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Len Brown <lenb@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	daniel.gabay@intel.com,
	ofer.kimelman@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/20] wifi: iwlwifi: lower message level for FW buffer destination
Date: Tue,  3 Sep 2024 15:23:46 -0400
Message-ID: <20240903192425.1107562-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit f8a129c1e10256c785164ed5efa5d17d45fbd81b ]

An invalid buffer destination is not a problem for the driver and it
does not make sense to report it with the KERN_ERR message level. As
such, change the message to use IWL_DEBUG_FW.

Reported-by: Len Brown <lenb@kernel.org>
Closes: https://lore.kernel.org/r/CAJvTdKkcxJss=DM2sxgv_MR5BeZ4_OC-3ad6tA40TYH2yqHCWw@mail.gmail.com
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.20abf78f05bc.Ifbcecc2ae9fb40b9698302507dcba8b922c8d856@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index fa4a145468601..9be41673650ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -68,7 +68,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 		}
 		break;
 	default:
-		IWL_ERR(trans, "WRT: Invalid buffer destination\n");
+		IWL_DEBUG_FW(trans, "WRT: Invalid buffer destination (%d)\n",
+			     le32_to_cpu(fw_mon_cfg->buf_location));
 	}
 out:
 	if (dbg_flags)
-- 
2.43.0


