Return-Path: <linux-wireless+bounces-12431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC396A953
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3EB1C245B2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA71E7676;
	Tue,  3 Sep 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1sDiJE1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E11E764C;
	Tue,  3 Sep 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396415; cv=none; b=LtS1oUxFdRo5tM9rHrcL+UXnL3EjlXLbRNk3jq0YDOKG/DaHRQM9mlsxWOkLMPU680Z1uv2KxBNuLumOIn2bNAmJ1D5e2DC87OmKVbG1b7V4i+1E4Vps60PQz0HzJ9JYPKwKkfl2z79Lv6HfFuqXAPkRdgeGKBbTmdVp3SAd80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396415; c=relaxed/simple;
	bh=JLD2imCXUXYTDThU53cPyAV4fsvRIsQweED4xthw85A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzxuoxKy9Cld2XasgurR5JZq7ZjLhUUZrJdjriPvGhPN7jsp+QsbKxuuK/fF3490sVeyfqzFsXz5eW7b1y4Mi042G1T0wEeKxokGIwSbLoPvpagz4/koIKGRtMD8CLmkA2PppKac/8lwVdJUFwtGKV8g85xWsZglIq/6Sg9WwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1sDiJE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7694C4CEC4;
	Tue,  3 Sep 2024 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396415;
	bh=JLD2imCXUXYTDThU53cPyAV4fsvRIsQweED4xthw85A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1sDiJE1y3HMYnEZq1NpgPks8PbJfqylx3vglB9DLpSOpd/gzT4x0usfmw+IPgDaD
	 AEJoiGIILLjtudw06hLyniggSRDeol3HXpxizwfVY+soCdE1JMqy8BWWBm9OyMawLE
	 4cYP2hA3vR/1mThvSQY4099OQYSW/H6uFqHun2/SfFN4FofBfvCFzpDcgu79Umct9S
	 qqwlw9SVs9ys8LyfUfnUXaNb3DkMyne4oF4xNuvPPrntwxmdXrRk0nDM42j+lSfHWG
	 dCri0g0atT9cTKTPwj3YZ9fwbBy84LFZhRaqt8eUxiB2sf9UR9bTePdEhfMKPaHqTf
	 mk8XKGkXU7HWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Len Brown <lenb@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ofer.kimelman@intel.com,
	daniel.gabay@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/12] wifi: iwlwifi: lower message level for FW buffer destination
Date: Tue,  3 Sep 2024 15:26:52 -0400
Message-ID: <20240903192718.1108456-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192718.1108456-1-sashal@kernel.org>
References: <20240903192718.1108456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index 239a722cd79d8..ae55bde3a57a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -64,7 +64,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
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


