Return-Path: <linux-wireless+bounces-12425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797896A92D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA93E1C246C4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191F1E5018;
	Tue,  3 Sep 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVCd6xoF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11E1E5013;
	Tue,  3 Sep 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396351; cv=none; b=faAZcpSsNClKb9aGIzCS48QpVjejSL1fy11qB+KktUxb6E2MCGOy1BY3UVd4k5kJaGfPeJXtAinGi5dbrJSrJF+l0V9K6WCbfvUiJfO6Mxy64r9I8jQkKELvzRyY7Fo9xwp+dBHsecPxgVgcHjwYCPRrul0XbBYEfds5pqbfSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396351; c=relaxed/simple;
	bh=XcxIp7YoaZLmrd8TKR2/KvoO9KUqci+b22wMWP7eZ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyxuwfpPfUEokQgqFXkXktVhvckF6OEjnsSLGN+SW1t4BpBNSHdYWKKNoXJetokmQuMAsdEPiP3OtnRK766ykGnz87FNXdJfirHGV2U6MK+awTyj+V6+I28NOdKutwSnHOE40X7dNAP507lW2kmp/X7YhtgWS43VETCp0BUlmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVCd6xoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DCCC4CEC4;
	Tue,  3 Sep 2024 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396351;
	bh=XcxIp7YoaZLmrd8TKR2/KvoO9KUqci+b22wMWP7eZ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVCd6xoFkEx1mlOhsWZ6BDTcsQmVSTSSU6f922iIBGs8MDWWlMVvjINVxEL9H/2cD
	 rp/SECxRQBGQLBV0R1Lss3uTbhsRlZAjAabVz9OfH3aLUitDn6duobKNSr3Mw3Yv6v
	 tWPHZnD+Nz4z8uw6CXp2300Q4/75GvF7d0wai5CeqRDnS5WVk6BEWmLqAG+r33ZMzF
	 9wIC/qxAc3mbnsvFqKrgJXxIOJS3ty5FHB7IZfulpWPu4YLkpHGklMxV5PKw0Lyvvy
	 3uNAlPjutVoIPH7ZbXtmCzRtkEO1EiNHBZvsJMCZJ+8UHIdEC3K5/s/7cl6OiPJAbs
	 j+CrVsiF4Mn8w==
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
Subject: [PATCH AUTOSEL 6.1 12/17] wifi: iwlwifi: lower message level for FW buffer destination
Date: Tue,  3 Sep 2024 15:25:26 -0400
Message-ID: <20240903192600.1108046-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
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
index 75fd386b048e9..35c60faf8e8fb 100644
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


