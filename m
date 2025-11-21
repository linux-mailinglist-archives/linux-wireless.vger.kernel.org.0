Return-Path: <linux-wireless+bounces-29241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33FC7A2FA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 747D93555E3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5233A027;
	Fri, 21 Nov 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doU7WSWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7A341046
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735131; cv=none; b=Nh06o2I8mwV28uDHp4wjlS+ZXc5sQo1661rm7hcud/tV5NSHsuRX8BQRpw/55g+bRtTi9x8PTt6PvzBE79Y907+efoPcKPnihkK3/VAAyhBARqufVKd/7+ImiLm7kkTrHrs4auijdLMsiqBsW6VwNmvjMsEaW5vhkfM3z3RnqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735131; c=relaxed/simple;
	bh=PcdYriELTRxxqyi2zLlAXbiIhevRprgNoH3faDmYI40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qDriRVS7MptM0SEQiytDF1Zs2cjDvUXB57jvAmbQiMv0m8buOt0qrF7ZxVeEJbY7qs6dXcNDRf7nAvsNIf0FUpi1WataELh8JDhRcL5tpibl4izAqfUgGTFdOLGaPQVECxahoikJcPpM1UAnMcylfnzkDngDIuds7NRF6c3s5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doU7WSWL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e982506fso28170945ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763735129; x=1764339929; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2o66V1W0VIii4WKZlNV89eF/qYtMTYUH+9PUIJHPFEE=;
        b=doU7WSWLE3dJxKTIUPCQv2e6uTk66lfrTfXbP8DACrjKXpddgUktkDT5qtW1Q9Lqn1
         W2l2KkBAJ7tXf0YuCVG8XEqbHxS6SwKj3+61msP+Zh1oe3OoXHIQIaTculAaRFnd+ryR
         tC9XLP5ZyVGS2RxwxzRhNq1bY/VLfMaP1jfxnmJuCanHGxR8fPg+LYTNaqgA/b+Lufk6
         LL2sd6ZJOeUlTon75k4/K5bg7demo/AJs1Z7K5Zk4JpJIdYR6LxC2zU7F5VUVKw0nxbr
         COTlWgpzkDoV5/CYJ2RnkV8DtxNw/0K18dw4JixvpDGOxwyIcj/pfDtRtxLZtZJp1lbu
         cvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735129; x=1764339929;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o66V1W0VIii4WKZlNV89eF/qYtMTYUH+9PUIJHPFEE=;
        b=oI9bKQ5uQ03tZUMj0whPfXQY0TsRGXBjJ9PILagDSvhmDl4DJTqdJCpbK+AlY1UVd3
         5VrGVYaVr+DLzEEwCoWorkKLgwGCY1f7lGyEQfg8g1FlQweh6CxRyhESHs0zGIjr9gL/
         cPC6Jz0Cr3CxPGYmJQB6A9vL7HokcJm4qsCO/CGcbzeT0pDxI1uM0GQte/1y2Iv9m/9J
         KSElw60JRNK19lS2ipsPadhoL2B+oqFJeJPbltpsiYZwaoFDrk7l1/q1g9Wm+e9reNnC
         0l6gDIBtPNUzRLvA8q9gBH465HfGPEHdOBt12nrSY//bY+8o6ZY3TYlvoiaOoLLaObD7
         77sg==
X-Forwarded-Encrypted: i=1; AJvYcCU3YZtPuBnhqnaobwth5GSUvftz3eP06TdB3t4GndgQmGe2QtUb0pJO2nlEb2DWy0s2n2Z0XvYmHGIif37o4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKLPmA+wImSxY665/oXE1dFciMusZX4vfVxN3xYvpbjJufpWQ
	OsarxJUlTntmDFDyWeJftVoOqlFSdn58U1yO4/Jp0EBjSuX/g6+QHKQQ
X-Gm-Gg: ASbGncv3aRHRuWNGsA9Yo2qXVDdlZPdpBGOV6hzj+mD6F6K7PaY5SMglw+yffm6F+Kf
	nir2x1r4UMiSrPwsmxdLxxrepRo1jEanZO+bSn3FViSUdMpCotxUlR6Mce0PLrePURbYzNBejYk
	bJLTMkxYpnsfirzFdx/4QiDgIPiQeVfwb60rWUSWVvE5dDliGvTKRVGvufDyv5jC2/lfkPdePI+
	6eFZ3A3FQ6gpykuS7du/5GwhnO6usPd9t3n9EEssn3/iX6EOdlsj9a11Mvk5iRRWJK7GL+rg3P8
	DM77ZLqS7OWmLm8hrVoelCoBwv54aqyD3SWNOD+nLL9gTWU/FiSx5n8UzbCD36exTDRnaZ5Z8BJ
	HEwHzGCfcRoZR5YpZbvuMdvDlgaUfRQHbxTNLHZndkZpq9mewkZRFl5QZLkF/HYuEaErK+1V208
	+OIYROPmwKFQ==
X-Google-Smtp-Source: AGHT+IHrikX+mOrHKT9vmVeCWGYlCMNxVDcD9cXQP3dYFw7N706EKc9U3floYgztSLCn04z/xkfXrg==
X-Received: by 2002:a17:903:947:b0:290:9332:eebd with SMTP id d9443c01a7336-29b6be8c682mr31943015ad.10.1763735128583;
        Fri, 21 Nov 2025 06:25:28 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcd:4575:1ad3:3d1a:3314:cdd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111016sm58167555ad.6.2025.11.21.06.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:25:28 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 21 Nov 2025 19:55:13 +0530
Subject: [PATCH iwlwifi-next v4] wifi: iwlwifi: fix uninitialized pointers
 with free attribute
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-aheev-uninitialized-free-attr-wireless-v4-1-75239da589ef@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEh2IGkC/5XOwW7DIBAE0F+JOJfKYGNIT/2PKgeCh3glB0dAc
 dLI/17qU9pTehzN6s3eWUIkJPa2u7OIQonmUEP3smNutOEETkPNTDZSCdEobkeg8M9AgTLZib4
 wcB8BbnOOfKGICSnx4wDdd/4IIxyr2CXC03Ub+mC0TAt54gHXzA61HSnlOd62L4rYbv47WAQXv
 HdGNbazeyXt++lsaXp183mbKPKR1U+z8ofVnXctlNMGf9n2gRXiabatrOxhzH5ooPGLXdf1G4T
 1peqYAQAA
X-Change-ID: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=PcdYriELTRxxqyi2zLlAXbiIhevRprgNoH3faDmYI40=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDIVyoK7vEV71EUrIv4tTHG4yHf17ctt0d/m6TfYsDDzm
 JjsnN7UUcrCIMbFICumyMIoKuWnt0lqQtzhpG8wc1iZQIYwcHEKwET++TEyXLYV8/icfv0W/xKH
 nz6fJ2kualJaqyu/kHOy/48JBoKXpRkZlvbs2j4zf5GKdYjbBa/NloEuATXRtp2t0ZwH9zA8NQv
 lBQA=
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
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4ae4d215e633e0d51194d818d479349e7c502201..2fe5f744a81cf42e768cc409f1af8823e204946f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -818,9 +818,9 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
 {
-	struct uefi_cnv_wpfc_data *data __free(kfree);
 	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
 
+	struct uefi_cnv_wpfc_data *data __free(kfree) = NULL;
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
 					      "WPFC", sizeof(*data), NULL);
 	if (IS_ERR(data))
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


