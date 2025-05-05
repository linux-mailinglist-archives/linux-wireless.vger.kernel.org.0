Return-Path: <linux-wireless+bounces-22491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421FCAAA124
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C4E1A840D7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2FE29A3EF;
	Mon,  5 May 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA3wXR5f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB829A3EC;
	Mon,  5 May 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483563; cv=none; b=ox0UsNovZRPGTcxhJNqLagg9d5L0kZfOPpnxZqGrCWvpVf7LQPbl4ZiQEB4z+ivRxUktsQ5IFOVVw3OMctwQRobrjJOCOd7vBzZMZkH8Scfx2VB3TYTDhIs91ZaXfEG7W8nIV4waA4/FIdqppiUpqynFb52cJiQ6kT0eec+lScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483563; c=relaxed/simple;
	bh=HM5lWcaDvaU7UgyXxccRJE63+mXAVV9HFc/Qp4TbbIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M01jxbJXjYNnOsakH3GV6UWKLdzb5tXAIqI1DZYolu1R8j8ZKq3yrbssABnirZd1WPsjGgkdzbQVfXfEdQ86cIGfqic7KkRwJByJ4YN5jd8KB4Kl5P+zXMNlFr2aT4f2iFTr9eWeECUp7ZHEhfT1R394lcTjLLXGlzI734aJzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA3wXR5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724CAC4CEE4;
	Mon,  5 May 2025 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483563;
	bh=HM5lWcaDvaU7UgyXxccRJE63+mXAVV9HFc/Qp4TbbIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MA3wXR5f8029Xz5XJEI8rxeXB68ppRlXupeEL8XAFOItb30Xh6YBjC82feCsvuzoT
	 POtcqG32qsLfjjUxRQSOfOPriEu7+Pj+1T7Y+OgZpD1muTA3WEQKGwn8i5eKbPTJji
	 Jnc+UHgdy1rmAadpO8Vc8PvmX93ZuVGUcy2uvcKWbtBGh90GjhaFmRnX8B0qFIdZ4G
	 WuPH23o88X6B6HMPDsgCw1fjcsqabodVmJwP3xr5ITnLm+xNA3a7XsABz2UpyDVDCC
	 A99h9wHaB+IG2joXBg+N3TLtJs8as71iI11bjY3w8VT1eqeEd5M7nlXIQ011u8yO1W
	 jSvueNBryT0wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	briannorris@chromium.org,
	s.hauer@pengutronix.de,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 116/642] wifi: mwifiex: Fix HT40 bandwidth issue.
Date: Mon,  5 May 2025 18:05:32 -0400
Message-Id: <20250505221419.2672473-116-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jeff Chen <jeff.chen_1@nxp.com>

[ Upstream commit 4fcfcbe457349267fe048524078e8970807c1a5b ]

This patch addresses an issue where, despite the AP supporting 40MHz
bandwidth, the connection was limited to 20MHz. Without this fix,
even if the access point supports 40MHz, the bandwidth after
connection remains at 20MHz. This issue is not a regression.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://patch.msgid.link/20250314094238.2097341-1-jeff.chen_1@nxp.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 66f0f5377ac18..738bafc3749b0 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -403,12 +403,14 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 
 		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 		    bss_desc->bcn_ht_oper->ht_param &
-		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
+		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
+			chan_list->chan_scan_param[0].radio_type |=
+				CHAN_BW_40MHZ << 2;
 			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
 					  radio_type,
 					  (bss_desc->bcn_ht_oper->ht_param &
 					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
-
+		}
 		*buffer += struct_size(chan_list, chan_scan_param, 1);
 		ret_len += struct_size(chan_list, chan_scan_param, 1);
 	}
-- 
2.39.5


