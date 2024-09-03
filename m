Return-Path: <linux-wireless+bounces-12436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C579596A972
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C5CB24A5C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B671D79AD;
	Tue,  3 Sep 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnTOSs3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBCC1E974E;
	Tue,  3 Sep 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396471; cv=none; b=bzWZnv7gtdzTPOzjKVkYSt+WG71moKIhapd7RSUZlyreyVA62YaYbGZzPRlg23sGPZ7IOetRZQiObggTcvl7zAVKXbY5SwXdsBK7nh3B7B55hTw4nfLJWOq0MDRLNWg5E04Va5ClFsk6c47thc/gDazRTZCg37/DzR2Yxi06pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396471; c=relaxed/simple;
	bh=+jOhbuIzUGAYMO7CmA8QYLO1aUmswmbfAOUxoe25ewE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNXTsht2OteA8BgaKz3Eh7QHKDUhoYh92sg7y/Orv43pPl5ktBpzriVmPXIEHlzAwL3YjJ0QMUpwJDegMLsBMargwGb6O3Ak2jXNLurlved/duhainogEi5s4k3xcX+BaTnalfiFdM6mb73x4VLuIPumg/AqAiHZz/wPHGlOaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnTOSs3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510EFC4CEC5;
	Tue,  3 Sep 2024 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396471;
	bh=+jOhbuIzUGAYMO7CmA8QYLO1aUmswmbfAOUxoe25ewE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnTOSs3uFliLgM2154pRERx7mVZLjwco9ksDpSUbn06QQz6e1U+wMTahgfugq1I5q
	 tA4tGvFjUcoufIrMNUMxJK7uqkYIuDz56J+NPN1b6ga3WChi+bJ1DRWvmmCSXOvVc7
	 OIncU52xgg76jo6Ix2q4XiBo6Nou/Os27WbtfXYrQrOw9jxppC4/0G+4VAN1ObPbOX
	 yUpFuBoWqfhFbui66iP9Um6/RZ3HK9PNQHWZ6V78t08i6Q9XDO4r4DQmdLM9bBKK4e
	 ES6Ey2Kh3tWe0RaoemwJt9FlWkDoB2jlaQPTsCgvhfysFnGd+PeXBUth3Zrv7B8C0O
	 torUmpyHsMfmQ==
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
Subject: [PATCH AUTOSEL 5.10 7/8] wifi: iwlwifi: lower message level for FW buffer destination
Date: Tue,  3 Sep 2024 15:27:57 -0400
Message-ID: <20240903192815.1108754-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192815.1108754-1-sashal@kernel.org>
References: <20240903192815.1108754-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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
index 56f63f5f5dd34..2afa5c91bc76b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -111,7 +111,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
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


