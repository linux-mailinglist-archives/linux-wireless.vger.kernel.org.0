Return-Path: <linux-wireless+bounces-12411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5596A8C3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FF11C23AFD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B74126BEA;
	Tue,  3 Sep 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpO0GpUV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04A126BE9;
	Tue,  3 Sep 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396162; cv=none; b=tSZBeBP2xZsyVrT8WjtVq5EuPRICSZaK5daa7+95stpHnYSBPK8fC/nE6QBtSq6U/miljnKAxPgvOiC1oXUeiYRbeUCz71hRGvY0eN1Gi0UzXg5Qs6r0l6tDXm30302BLqbKOq2s9UQ2Grv7+2GZotlIr5RzEA0jbXX91eTj/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396162; c=relaxed/simple;
	bh=kjyojcWz/twT70ashaH0xMjK5Xz4p9TI02bSnkdANPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXdqYzVFab0LKyEBjZsT+NY/P0FavkMcJQ72J8F3js9PhiSx7BA9ulPm4Lnjw4rL0GuAkof9zwopuB327BpgeTkZ+/+KG6dkJIzK2C+lJ6fop2EHX0S4wz6AiT56ScWCzPpRui2f8hoDmctHfz1KUsKZP3Eb1H1+g943TfDCeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpO0GpUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDE6C4CEC9;
	Tue,  3 Sep 2024 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396162;
	bh=kjyojcWz/twT70ashaH0xMjK5Xz4p9TI02bSnkdANPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpO0GpUVyf8o/ScRaJIkHX3yS9OwrmI5yg07J71ZAgGw/s8jpMGNB3nmX4motzNTM
	 5h9jvlXNs6TSZLSb1gUTYGs/nhtPM8uk9QmK9zJk8/9gLb8p5agz8UefQmvvcmvTMK
	 aVx4J59lCfOQY4+wMX/EEpSgM8KwxomgcJ7uq5Kc6wxpxdynbDRnBF0o2gq2UTW6DH
	 mdY04xQYo5ugcDuYWranWyAeLteS5zzypY5SqH98/OwLjodMqbVwIHsO8W68hC9OwH
	 kFqJhRi+vJNzMRtsDMd4FFyatM2fzSB7yHWDuvcuRZi1XVb/jQq1qXABCvVg3sFV3L
	 +Qx4AdNtvZNrg==
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
Subject: [PATCH AUTOSEL 6.10 16/22] wifi: iwlwifi: lower message level for FW buffer destination
Date: Tue,  3 Sep 2024 15:22:03 -0400
Message-ID: <20240903192243.1107016-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
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
index ebf11f276b20a..37f0bc9e0d963 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -89,7 +89,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
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


