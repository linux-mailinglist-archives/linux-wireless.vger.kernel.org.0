Return-Path: <linux-wireless+bounces-14930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132CD9BD249
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443C61C22644
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56B1D63F3;
	Tue,  5 Nov 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eG2pRCAB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D35674E;
	Tue,  5 Nov 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824016; cv=none; b=E5y3qxfaVN8ddZczlgtAIFOD8DjL9XQasI6JkWsact0d5+9sJJCu00g3WTQn5cPy/Bi9f9GcuBvEt9WHdu2k4lMzejJZ8q/XSdymF1PISdUCDFKG2oNTFa6W3tHFj6jxx6zUiMEgHkUs2PuUmYi7TckAO3kLrjjhcHCEBXqtbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824016; c=relaxed/simple;
	bh=veXgStPnAymNYAu46sbiOYtyBUQ03goVMilgZg6Dcbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Icjc+CDihH5n6wmNOjjN9qI/HWwACtOuAv3+ySZ/pzuszpWH+NBmQUdsfFe4vEJ2Mr2YjAxEM86rYLHpIWNKu90boTtgXPCE7AHK5W9kFf48rM752FNraPDXmNUQZRd8oFLALzMoSXHZm+5o/2QFovwtwIRuCVyWtAA9o+Q2JD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eG2pRCAB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kqGwF64LkhtIkTiYBmIxYpW4jX+iuVvsV5FQ8/NziyM=;
	t=1730824014; x=1732033614; b=eG2pRCABiiC0HdXIaMUInwOyQYUUVEjDG2c6RZHCZ4g4sTz
	ZIaCpXUS+Izu4chRoFLzF+9iDDvwB9IRtetJJQYOZKrR+Ki2b8LYwf8w4o2Iz6nChvFqxdVT2T2+f
	JLLuHuSmgGiZ9sPkYpfC4zAkdYj77ldcWCm8d61Ems+q14EaZ4JEb3EP4PCATWmcPsd9uA363/Ve+
	wFRU7kZPxm7gLTEcxAGE66QmU9JoHCf3BEubvECla3xTD5xz8lu/G+R3dACfsQC1E4mhJ0s5FvxyB
	/aTQ3H43vOISv9jF55KzQnwZ3rf8VCB/wGQYiXKOKZ9AZ6grlWLcecRzjeBwDjTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t8MOD-0000000EroH-3uj1;
	Tue, 05 Nov 2024 17:26:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15.y,6.1.y,6.6.y] wifi: iwlwifi: mvm: fix 6 GHz scan construction
Date: Tue,  5 Nov 2024 17:26:36 +0100
Message-ID: <20241105162640.71994-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110521-antler-uneatable-d873@gregkh>
References: <2024110521-antler-uneatable-d873@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Upstream commit 7245012f0f496162dd95d888ed2ceb5a35170f1a.

If more than 255 colocated APs exist for the set of all
APs found during 2.4/5 GHz scanning, then the 6 GHz scan
construction will loop forever since the loop variable
has type u8, which can never reach the number found when
that's bigger than 255, and is stored in a u32 variable.
Also move it into the loops to have a smaller scope.

Using a u32 there is fine, we limit the number of APs in
the scan list and each has a limit on the number of RNR
entries due to the frame size. With a limit of 1000 scan
results, a frame size upper bound of 4096 (really it's
more like ~2300) and a TBTT entry size of at least 11,
we get an upper bound for the number of ~372k, well in
the bounds of a u32.

Cc: stable@vger.kernel.org
Fixes: eae94cf82d74 ("iwlwifi: mvm: add support for 6GHz")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219375
Link: https://patch.msgid.link/20241023091744.f4baed5c08a1.I8b417148bbc8c5d11c101e1b8f5bf372e17bf2a7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index aa6ef6491205..16818dcdae22 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1753,7 +1753,8 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 			&cp->channel_config[i];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		u8 k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		u32 j;
 		bool force_passive, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 
-- 
2.47.0


