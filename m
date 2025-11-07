Return-Path: <linux-wireless+bounces-28676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C972FC3EDE8
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 09:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8313B3A4420
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1130F555;
	Fri,  7 Nov 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUkT2Yu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DA30E0C2
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502708; cv=none; b=pcwI2V7AnhgkI+xtI0hzfKiYYfVAjS+NV52QryszynPabdCWCOv5zd6+mnFLGcijgeWMxkpD6mUqYmHzlcgylpIfVxv/NywsOwt2P4tbf9qWWkIVBwo3VlBNJfDARMGG9dFIA7xYKr00RrHP/ECmhe0czqLeftOP+6c52Xl6Rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502708; c=relaxed/simple;
	bh=BxMoqcEL4C9okv3x3H9LfHF5qpmIrl6wzAvjResVosA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ThalbQLGpLX7F9HN9TrqoaaJAZ4oSqC+7NZmQp44SFcZ+KeAJvKvVaz6VcklyP3SG9jRtXwXEdvPeKLIoUaJ+dz/IWJqFx4yHVwAXYVkuwP3LwM18bCJdL+C2Ceu9ksRdMOtHka88IEGL80ipe+SoKAANCRBJYvO3vrXzCzMWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUkT2Yu5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2957850c63bso4960225ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 00:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502704; x=1763107504; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HK17ZLRWpug71WMmqP9ssM6jX/oQgX9XQzvvASGt94=;
        b=QUkT2Yu570pW0w0fLBzHQX03ZYtYKvSpNeziHfbtN7bdYjl2MvID7tdY7UoqFIyWSl
         saqjmKPH4g5EMwf5Huo7wRholuCtHM6EnoRdwXROirZ+iCscm7aHiedOsZ5uWKgS9a54
         3EOk6Yn30gw+W1pTcrBb3MACX1Qil43oS76ji/Jybes/Xms2virLMyu39XmmAoBZn2sa
         8dwrtEIBvtSmia3H1ue+l19e9AAxans3ivvqQYVoNgUthKreu9PzbNAAxcrtXhoYZK9N
         1Rubxix92ur6yxwMMgXUW7h2YE89z06s/yGac2lcVXeCZ9emutjHMrOX9Oh0P1/ic7LW
         5Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502704; x=1763107504;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HK17ZLRWpug71WMmqP9ssM6jX/oQgX9XQzvvASGt94=;
        b=kKfGaoCEyfrIRf+DSsrNOMAtfj6u0w9ZFrFLB6QqgegtyHUXfwF3LrxywB+smUYPuf
         JcuHI5KGHfaXMZ7GxXvL7xdUO9ECeVmHKBldgAKtm8w/qWNdpy3465iLYQ8NMVOLBUon
         perjOEWoIB8b0ne4VFeotjzIwWt8C27zC2zwLubgkCo5URrjLQ5v3RiLi5ChRk5h3l5U
         J6fb5WLxUHIvPTbAqiGnfVLJmFkl3c8EkokXGeUSJ61ld0/EIVXPp8pm9TdUeIjjsmGv
         CIPJ1XmVKvHqfpN5iLL5CyT9QJjjK+XGdGEhMXKXBgOKdtoY8IJ/n/mAMUUdXYCD4BBT
         n9sg==
X-Forwarded-Encrypted: i=1; AJvYcCVJqNtiuarkP3y+bYVoRRzsYf87h7vZhnvzDhGRR2N5lANTSJos1J3L7vKTKQj5gtDb+Pa8KPFef9lrh/aNBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKFq/FxXTFowpR6UgCZWYpceZkbWo6Mg8QO9bA8nGtf56lx3H
	l6UZr5O7/GyvwlTGX6JDKF46uvqQk7ptfATD7/udXqecuA3rCpWlkorU
X-Gm-Gg: ASbGncs1P/9tVHj8IDAn9wHu4Z+g1LABRE1aK+5b28cwA+1+aWQRxtxNcLeYDju9KDm
	dbU+Kx+uu9SnRKGNBkKo758YbjifT6tY9gRUU75aLS35fC/i2zaGxoYAdUWKuZXgHTL9huxIJBT
	PnqbwiSl+6HR7pSZgYOYe9zBVVyvmA3Vs1jCy3dPK0+EhIhkM3sDMbfEb9U13JnWVcKXeWrXpKj
	p8+HCfqQeyvvV0L0sNH+HYzOMDkHp5TsU4ImSdC8+4vDQwkl+TNsJ9EQiQe6y39OcZL55N7xaGm
	kuhiQgTNEY9K5Tp0XTO4yM6WecY9E1vIA33lGstdnuzglLp5vXoDuDnjxFFrkrpfSz4x6AIEpRS
	fRW7VbB2SUIfHg1eN/nZMbmGFJKbCzdU3rY1Jo/dA2dHj/hIpRwFZuo97r5bxuirrQibOEhlzO+
	ubZL2+56m7iuM=
X-Google-Smtp-Source: AGHT+IGnqGapeUkxECpNH1g+yh9HToZketvAvIPxW1NFpzGon/GJ24u3Eo8L8WjOz3yRauEMYbOiWg==
X-Received: by 2002:a17:902:f684:b0:295:6511:c0a3 with SMTP id d9443c01a7336-297c96319c1mr10565015ad.22.1762502704224;
        Fri, 07 Nov 2025 00:05:04 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:d67f:d090:f2ee:1569])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc76c0e8sm2000179b3a.52.2025.11.07.00.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:05:03 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 07 Nov 2025 13:34:44 +0530
Subject: [PATCH v2] net: wireless: fix uninitialized pointers with free
 attribute
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-aheev-uninitialized-free-attr-wireless-v2-1-674fc3e5c78e@gmail.com>
X-B4-Tracking: v=1; b=H4sIABuoDWkC/5XNTQ6CMBCG4auQrh1DG4roynsYFkMZYBIopq31h
 /TuVm7g8v0W37MJT47Ji0uxCUeRPa82hzoUwkxoRwLucwtVKi1lqQEnoggPy5YD48wf6mFwRIA
 hOHiyo5m8h66nU10NHTXSiHx2dzTwa4dube6JfVjde3ej/K1/E1GChNo0usQKz1rhdVyQ56NZF
 9GmlL57COrx3AAAAA==
X-Change-ID: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=BxMoqcEL4C9okv3x3H9LfHF5qpmIrl6wzAvjResVosA=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ5V2jLv+D37PSqzJZ813zM4vy/e+VzlvAovhMy+dPld
 vsNx+yGjlIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACYSks/IsPnanduLnF78WjTB
 ZL5uywP15Vvs+u4/k7gcXxhh1+kxUZbhD5f6jQplRT+3o727b5w986bG+kjkuSc8LvkfVPg/KCi
 dYAYA
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
Changes in v2:
- fixed style issues
- ignore v1 of this patch
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-wireless-v1-1-6c850a4a952a@gmail.com
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4ae4d215e633e0d51194d818d479349e7c502201..c31a1187f53a79aeb0837f06250410eec4e7ea6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -818,8 +818,8 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
 {
-	struct uefi_cnv_wpfc_data *data __free(kfree);
 	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
+	struct uefi_cnv_wpfc_data *data __free(kfree) = NULL;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
 					      "WPFC", sizeof(*data), NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..d3a03940b0a2c6a4b0107266cd2fc11ec9745e47 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -996,8 +996,6 @@ static void iwl_mld_mlo_rekey(struct iwl_mld *mld,
 			      struct iwl_mld_wowlan_status *wowlan_status,
 			      struct ieee80211_vif *vif)
 {
-	struct iwl_mld_old_mlo_keys *old_keys __free(kfree) = NULL;
-
 	IWL_DEBUG_WOWLAN(mld, "Num of MLO Keys: %d\n", wowlan_status->num_mlo_keys);
 
 	if (!wowlan_status->num_mlo_keys)
@@ -1785,7 +1783,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 			   struct ieee80211_vif *vif,
 			   u8 ap_sta_id)
 {
-	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree);
+	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree) = NULL;
 	struct iwl_host_cmd hcmd = {
 		.id = PROT_OFFLOAD_CONFIG_CMD,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


