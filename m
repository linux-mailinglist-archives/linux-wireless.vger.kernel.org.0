Return-Path: <linux-wireless+bounces-29475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D66CAC9FA94
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447EB302D5D3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7430F7E4;
	Wed,  3 Dec 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENdWrDi2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C930C37A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776522; cv=none; b=SV7RYqLH8Mvua3b0yd1wmm6em/V/JrETkP3OcIlDjOTJLE65jPu2C0zC9OEPIwFeE9RM/uw6BAsKtWbl7jiHmajpoUQw/I/Ou1yZZ3CpEP88aALxmfR0B6r/Qk4DwYGiaebU3wR+o2HXQzWQS2You9lSGRODZJjj3oPzFyuzR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776522; c=relaxed/simple;
	bh=hAqsnrCrvPDMdNs30u4o5b1kDn+bC2ncbZf0JyQnbe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q2MrRta2FAQDYHyWxPcYAFbAyqbPs/tyOaPnGbVYn8WvjL/hlpG6Wv6oIfBCkrQaZjBAgPKQIg9qzDztT1YX3riaftEtTyHTEs4T1s5Cu5RJhVttXOq2G9wSw+ICQArwR3LzdWlJR7JcRjAGrVF/OFO0yq6APeXTd1RGb8hhVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENdWrDi2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso9787168a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 07:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764776520; x=1765381320; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0O71B0+ZytGmg78nzlOLpDFk0Q5PkQuHuikjI5daKfI=;
        b=ENdWrDi2CK3OZlLdDx2jTjtCbQ2ynb9Xld/VM3a03ysJrAEvSzBkCOnAdEvIjJUWFQ
         nbrIhijTloayRawO0rj+8X5Rd8CYPdOkjjA4XcU59wTGsB5St4lKMYxYPO0P1gF2iimt
         cwThEWMQWC2YLCHSooDqOjqXS4HtLh7Yz3sfXW5ga585/Bu+OoaFxyvg/Do92qaT79NQ
         F6RiKGL7pQOT6DCKwFdqs76Zl+hk0UkvhSWuUvT73xZVLnKkhEygqsfO8qH8OS3uktBL
         GL8DdHA3nSpuKoE+o46aOTzfzsbS5PnSUHJRZnD2AvFlZk5a+nBdi7wcun8/WuQoS7x3
         XI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776520; x=1765381320;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O71B0+ZytGmg78nzlOLpDFk0Q5PkQuHuikjI5daKfI=;
        b=ij9tyojr4nqzQlcMM6+ylJssadkL9G949hTgWZ/WL35udk/5gaBcIRnMB273yLQzVj
         qVD3K18LErJ4d5NsJSCXrpJtpifB689S0ub7sH/kOavxEaq9ygrmELlfidXS6fXcHbbS
         cxgA381SYvk/F8TYZ3f2J6wIuYYI8E7BUwL3BinQ6K42E57zooD0kuDUIWBAbrMQjnqD
         SxaC6fq/LnaIamd08cmh0SEu1KNEXJJFgJbGPy4XpCQUSQEWIl98RJ4bbfsibmDMLMjo
         DrcMdp+2XHP8mqV6fCLbzLIxC5IuF2vPs/OY+BhB7RLQbxpRwiXvWcSjLcud1THEtH0C
         kQjA==
X-Forwarded-Encrypted: i=1; AJvYcCWfgw19g3MzDSI8DKGr+y69N0N2U4y52+v4VQ6lAwQT5ZS7F1tLHeF+bDZMHLsasMz8S7NILCD3YTmQquP17g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9VsNDuMb4sXQW2BoMs4AjQCqlFSpErwmEL5sNiKySdueCdSn
	legg3hjzbYaj/C7oM9g/MS3AAdgJ7uKIwn2FMxskICF5Iot4uUnHYyqz
X-Gm-Gg: ASbGncvGPyd2Sr1tbiOXdmocRzkfkbPvdyxygDauwaMXH5nMPB9QmRUcdrRFOKQmQia
	2RmfIxO8PqmytF6YcnY18xyPpRBrPspuQmMrDM8B+zKQiF0F9X8jLR6KUBUiDnv79qTkd26TJOI
	8QrqghOOAASq52EGniCYbzAw2PEItBB6tqhtQyBA4i9FzwtOXRwr/oL08EOGqT5/wDlu0yD/H7W
	jkiElzUJz2Y0DsgRx6B8PD6Jd/FCphrVK04AUDa2gJYL76veTdU41ZDEffgGqbmtbhtVwnVpucC
	uFs3JJUQ5ZGYvJ6uvKudI5168wEZD83OFnZuxxZVxPs97XLVR0mAqBZXEesSB6OTCcnZPgL6wHC
	KUd0tXzPib++j5lIT0DNZJdzn+YGthyIKk99/jKR6bEhkQOevHFWEq8mwE/4HBtwZmM/7HfsQHK
	XvgbbGl0WU
X-Google-Smtp-Source: AGHT+IEIjabFKeYRWheKkFzPBkpGjwLB+9Eglpm14ogtBvVyA3LeNq5gYQEnE12Gw1OZLMhYxlxovQ==
X-Received: by 2002:a17:90b:3b81:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-349126bc47fmr3083050a91.20.1764776519823;
        Wed, 03 Dec 2025 07:41:59 -0800 (PST)
Received: from aheev.home ([106.215.171.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910e7af86sm3148580a91.9.2025.12.03.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:41:59 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 03 Dec 2025 21:11:55 +0530
Subject: [PATCH iwlwifi-next v6] wifi: iwlwifi: fix uninitialized pointers
 with free attribute
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-aheev-uninitialized-free-attr-wireless-v6-1-95716a6f0409@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEJaMGkC/5XOTW6DMBAF4KtEXtcVNv7tqveIsjD2OIxEoLIpp
 I24e11WVrqhy6c3+t48SIaEkMnb6UESLJhxGktQLyfiezdegWIomfCGS8YaSV0PsNDPEUec0Q3
 4DYHGBEDdPCe6YoIBcqZdAK1E7MAwTwr2kSDifR86E1yHFSPSEe4zuZS2xzxP6Wv/YmH7zX8HF
 0YZVd7IxglnJXfv15vD4dVPt31i4TWrD7P8l9Ui+hak1wae2bZiGTvMtoXlCoyxoQENf1hRsfw
 4KwqrJW9tcNJYiM+srFlxmJWFbbqgglOWWy1rdtu2HxwCE1JGAgAA
X-Change-ID: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3742; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=hAqsnrCrvPDMdNs30u4o5b1kDn+bC2ncbZf0JyQnbe8=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDINolw0Jv+1jJl62YrT4uCXLfUzZ1ytCzu0cpb1eq2Km
 pCKK8+KOkpZGMS4GGTFFFkYRaX89DZJTYg7nPQNZg4rE8gQBi5OAZiIaRrD/zyuSzeFlF5bnagN
 6tp5c/Vkow2fnwa5bTt0suor98QTR5YwMuyVWflu6bbJyqk8e7t8E1o0VV09ZRamHWhxnWqVVbB
 pLg8A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

It is better to initialize and assign pointers with `__free` attribute
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes in v6:
- RESEND. added Reviewed-by trailer
- Link to v5: https://lore.kernel.org/r/20251124-aheev-uninitialized-free-attr-wireless-v5-1-0bd6da692975@gmail.com

Changes in v5:
- merge declaration and allocation of `data` pointer
- Link to v4: https://lore.kernel.org/r/20251121-aheev-uninitialized-free-attr-wireless-v4-1-75239da589ef@gmail.com

Changes in v4:
- moved pointers declaration to where the allocation is
- Link to v3: https://lore.kernel.org/r/20251111-aheev-uninitialized-free-attr-wireless-v3-1-26e889d0e7ee@gmail.com

Changes in v3:
- fixed commit message to include iwlwifi
- reverted unused variable removal. To be done in a different patch
- Link to v2: https://lore.kernel.org/r/20251107-aheev-uninitialized-free-attr-wireless-v2-1-674fc3e5c78e@gmail.com

Changes in v2:
- fixed style issues
- ignore v1 of this patch
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-wireless-v1-1-6c850a4a952a@gmail.com
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 7 ++++---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4ae4d215e633e0d51194d818d479349e7c502201..a240fd2052bd1f029cbb59abe5edf84c2227b397 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -818,11 +818,12 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
 {
-	struct uefi_cnv_wpfc_data *data __free(kfree);
 	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
 
-	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
-					      "WPFC", sizeof(*data), NULL);
+	struct uefi_cnv_wpfc_data *data __free(kfree) =
+		iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
+					       "WPFC", sizeof(*data), NULL);
+
 	if (IS_ERR(data))
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..e4e4f35b762a445a98df1c725e053fb9bd07affc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1785,15 +1785,15 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 			   struct ieee80211_vif *vif,
 			   u8 ap_sta_id)
 {
-	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree);
 	struct iwl_host_cmd hcmd = {
 		.id = PROT_OFFLOAD_CONFIG_CMD,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
-		.len[0] = sizeof(*cmd),
+		.len[0] = sizeof(struct iwl_proto_offload_cmd_v4),
 	};
 	u32 enabled = 0;
 
-	cmd = kzalloc(hcmd.len[0], GFP_KERNEL);
+	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree) =
+		kzalloc(hcmd.len[0], GFP_KERNEL);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


