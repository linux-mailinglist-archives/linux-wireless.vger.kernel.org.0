Return-Path: <linux-wireless+bounces-29273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F93C7F2CD
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 08:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EF03A50E0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A82E762E;
	Mon, 24 Nov 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW3dn1H5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9592E7622
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969354; cv=none; b=ZI89YJ/4FldOlGbsFCYxEqAWFT3JRyQayc8KDtuH8edL5i/j8TpPeH8osHSp5/MaCcc9BHPhpHD9UGhefAcE5m5+5wq/HI1PIb5wFTz4CQiJ5adHH9hLTz+DVyBdIlG7Gk2GFYZRZxq+6/FMoYXnjgfnZvNGwdYL0My/+Z0yGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969354; c=relaxed/simple;
	bh=TMZv6DiI7YTlWL+GWS0yVxHiJdi4ZO3iSpTQ1QqARek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=skoQnJc/ypMZPLdbNWDV+SRipA2d6StirIWkYXcpbUGivBocNVm+4Xy8jK6rMaxW0Pe1R9XEnrD9oZLxrJK4QjFnxGnjxGuXA3lrmv0BaInD66KZ+77gZebP4nEu/4i6lN0lUlJQuYNKi/EruTL69SuEzP03shzqiunzlMQOLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW3dn1H5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2955623e6faso46362485ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 23:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763969352; x=1764574152; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lL8i4yd9K6cdAsLA9VXTIc7TLjAQjmeneyMWm+Rw4AI=;
        b=mW3dn1H5UNa+sohK/+O52NWz9p6Y8G4SzpcnJC4gRCvJU3d46LFhlXjDs4BMUjy/ux
         9vI3CvJYMFprSqmjzuIhj5/ppy0MaVpYBHUU47Xsr0r9kTl0T4ulQYwCco5S1TbNaVsP
         RWoZKsaJUbUulMdOZTo3tskLzvhygW7eUzooKmxq3pqgXGD2fOtLbCxpdglAgPJXPg/0
         AxXK4KPHYgP6NVUSNNwsIxcimGWxJjlKktWlF8xtZ3AIu27gIHHeBS8qVnvqd+X8Qa+4
         Jl6YKnmQ5n9J3wgjOB1tFd1Zdi9HvQuK/Kc2/4t0RL736ByRrT7Hhr+6zPVHTSlKcUHb
         purw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969352; x=1764574152;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL8i4yd9K6cdAsLA9VXTIc7TLjAQjmeneyMWm+Rw4AI=;
        b=SSvhQoVNFx5L0oEicQsoU9j1MvGiRVfvb7KYGc6xjaXaxwVKktnGUJpRcG/cEGqh3i
         A3nPBS410Yvy4lDzuCripuhnl6h12wUQy5HOEga8vQNgWlzDYa2Honiui5gj9Dkas29x
         P9Ume341p6sjiGljPA3TH/ibHLbxGLf+Q3YtaugNLxHenvJo/gIsL3oKckE8SWZxjpsG
         UCzFkxHHkaaNMstp2ilkZd25uc8iMdJoJ8iUFI3+nqpOsOatjzOqP8W3sdKtmMVm+5kz
         T2CW1limRY6DozGshbG+Rebi/Ys7AyZ+JlKeRUPEBiaNMFlgGgHgZwyst3gLUgcJ1yLZ
         angg==
X-Forwarded-Encrypted: i=1; AJvYcCUHFWakL4dEvNOaofzL5N9yaGC3UHb0+UoqWc99NMEh2XyVRb5+eJTtWeNZprWqEPbW3uNxokJe5Jwi4vlNWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+rXVCQVRPKfZXx7p0GyRuXVzLUyTc1gOusnpXBC3p+unMzcv
	RcGV1h4qVm2O6WwMSrz8X1hJR1UAOEkG0zPrE/Eb6K+m0yCcr9t5N7gw
X-Gm-Gg: ASbGncuLFk7rYgDUhLeF41yMJANDXzxgvLouhPjgt+iVfwWo8bD1TOHKefk8irUFDrF
	Pw8st+vau0BWDhdFCbZLtuuLVAc+SCYANqjLxT2EwhbpBy3/Tbd6GEdC5RhnqIGbAZNcAiOcOqI
	ktEdNqgAi8wkTiJsoitf/hEZiMm7WPhxPbRTluCuJ8aW4YLAbPb2BdBJW/h8eFpOK1y72NdcISs
	2vYPsG/f02JEqowqGNjQ4xpLx0uY3iiU7BMJzRFTIzKAsErZGOBU9wGBj7fC78VeXsaMXHWpdLf
	ts3y/IFHZpt7WjtDSoMzOKnGiTy+I8z55ORbz2yyKNwR2HF5RWPU1QKQ2ck9nyJGshJEMa+gaCX
	5j95kXGJjrtddF1FbAYtrglCrzWvtgHC93KXOJ7Wq1Vs24lbATZteUTivHvlj0jgiWqF4zwYVJC
	pMotn/A755
X-Google-Smtp-Source: AGHT+IH4F6FBvgyOceTbRcvv+S7rQX9Y/kHRwk75+mymO4QNY5NFT01pdhCppW7LNnQTS6sXJ1p/dg==
X-Received: by 2002:a17:902:fc43:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-29b6be9394amr122878955ad.7.1763969351969;
        Sun, 23 Nov 2025 23:29:11 -0800 (PST)
Received: from aheev.home ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a870sm126138035ad.34.2025.11.23.23.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:29:11 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 24 Nov 2025 12:59:05 +0530
Subject: [PATCH iwlwifi-next v5] wifi: iwlwifi: fix uninitialized pointers
 with free attribute
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-aheev-uninitialized-free-attr-wireless-v5-1-0bd6da692975@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEAJJGkC/5XOwW6EIBQF0F+ZsC6NIAh21f9oumDgMr7E0QlYn
 Xbiv5e6Mu3GLm/uy7nvwTISIbOX04MlzJRpHErQTyfmOzdcwCmUzGQltRCV5q4DZv4x0EATuZ6
 +EHhMAHfTlPhCCT1y5ucA06h4hhWeFeyWEOm+Db0xWvqFIvEB94m9l7ajPI3pc/tiFtvNfwdnw
 QVvvNWVU67V0r1ero76Zz9et4lZ7llzmJU/rFHR19DeWPxm6x0rxGG2LqxsYG0bKhj8YdWOlcd
 ZVVijZd0Gp22LuGfXdf0GAgpHp+8BAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3518; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=TMZv6DiI7YTlWL+GWS0yVxHiJdi4ZO3iSpTQ1QqARek=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJVOJ09TLy2/Yv8czhC9KjYRY/K055NcbZGjNcPRzHy9
 tuX633qKGVhEONikBVTZGEUlfLT2yQ1Ie5w0jeYOaxMIEMYuDgFYCLl8YwM+76qND/8G3elpv3L
 1bS0rcXxiUYVng+vybLJ77Au5Fz3gpFhHe8K+wWpa/MKbRoMgiatZbaqUfQNlik0qFs+zVFxjTc
 nAA==
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
---
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


