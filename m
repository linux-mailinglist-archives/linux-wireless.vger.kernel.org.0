Return-Path: <linux-wireless+bounces-28245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B3C09496
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DBB1C27971
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD233304BD8;
	Sat, 25 Oct 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxFoZYsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3B303CAE;
	Sat, 25 Oct 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408826; cv=none; b=BVVtB87dNo47/hHktRW+1tBiL9XJrjmlO725wXzFYFpSg2MWNXwXPQB+VymCGVRZWljeFn+UoR49LAkVFTr7npT8XwtfIHo0FoZeJmmIBK5evT/i8G0A/A3hGQByxEjL418B7noatHVktfEIFD8EjagW7OguNDqqenzhaVVc1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408826; c=relaxed/simple;
	bh=z4rvL6eEdv03PpEBgEOwBeT9c65weET/LCt+IiPxbTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQgtKyU8Nk3qiCCVHXvaRLr0iaZfvABnD8WnrFtYD9v0jOSbS6jOOGBb0e4AVI92479Pp9vKultSxIVYec8/iR4CwhNgUpJSefWPjzcZIesinFSB6lTScsmLNobDNR0GldMcsWVIAiNOFe+z2V57NsdALN2ZRjqhyZT+ZKVj+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxFoZYsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38142C4CEFF;
	Sat, 25 Oct 2025 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408826;
	bh=z4rvL6eEdv03PpEBgEOwBeT9c65weET/LCt+IiPxbTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxFoZYsj6TC6v0EXW36X6SI79NqID4UJrkC1vxUtdfFxOSknPoZhKayAxGR7VQWiU
	 U7SiIkoXeWxPbkRzU7OyrmScGEdmEWKMagTgIsUteHXo8XCYxz4IvmehmrQwwuI3C+
	 XT8yuuFoVMwTH0Cvg+pVL27eJxfsdSvbukBfvVTToiMgWG/jvcBHpaxNONvnz6/B1w
	 ZRVr9pHK4xOqtJJ7fKh3U/WTV0R4YYxCXy89K6tM5LrJuMdrZbprL/f6Lonr8VS+ar
	 IlvosK7NNH8AOYVwInBf+31WqU/A+ZZMovJIDRUlETi5mfu/Ny7XoxM0BEXiZtgmO2
	 leTmTgL0iMmuw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-5.10] wifi: ath10k: Fix connection after GTK rekeying
Date: Sat, 25 Oct 2025 11:55:19 -0400
Message-ID: <20251025160905.3857885-88-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

[ Upstream commit 487e8a8c3421df0af3707e54c7e069f1d89cbda7 ]

It appears that not all hardware/firmware implementations support
group key deletion correctly, which can lead to connection hangs
and deauthentication following GTK rekeying (delete and install).

To avoid this issue, instead of attempting to delete the key using
the special WMI_CIPHER_NONE value, we now replace the key with an
invalid (random) value.

This behavior has been observed with WCN39xx chipsets.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # QRB2210 RB1
Link: https://patch.msgid.link/20250902143225.837487-1-loic.poulain@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `drivers/net/wireless/ath/ath10k/mac.c:298` now replaces a group key
  that is being disabled with random bytes instead of sending WMI’s
  “delete” command (`WMI_CIPHER_NONE`). This directly addresses the
  field-reported hang/deauth issues seen on WCN39xx when mac80211
  performs the standard “delete + install” sequence during GTK rekey;
  those chips simply don’t tolerate the delete command, so the previous
  logic routinely broke WPA networks.
- The intervention is tightly scoped: the new path is gated on `cmd ==
  DISABLE_KEY` and `flags & WMI_KEY_GROUP`, leaving pairwise keys and
  normal installs untouched, while still issuing the same
  `ath10k_wmi_vdev_install_key()` call. Complexity stays minimal, which
  keeps the backport risk low.
- Adding `<linux/random.h>` at
  `drivers/net/wireless/ath/ath10k/mac.c:19` is the only ancillary
  change, and `get_random_bytes()` is universally available in the older
  kernels we target.
- I did look for side-effects: mutating `key->key` could matter if
  mac80211 fell back to software crypto immediately after disabling a
  group key, but that flow is rare (HW needs to have been using the key
  already) and, in practice, the key is being deleted precisely because
  it is no longer supposed to be used. Against that minor theoretical
  risk we have a severe, reproducible loss of connectivity on modern
  hardware.
- Because the patch fixes a user-visible regression without altering
  ath10k architecture, and its behaviour aligns with what ath11k already
  does to survive the same firmware quirk, it fits stable-policy
  criteria and is worth backporting so that WCN39xx users can keep
  stable kernels connected once GTK rekeys.

 drivers/net/wireless/ath/ath10k/mac.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 24dd794e31ea2..154ac7a709824 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/bitfield.h>
+#include <linux/random.h>
 
 #include "hif.h"
 #include "core.h"
@@ -290,8 +291,15 @@ static int ath10k_send_key(struct ath10k_vif *arvif,
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
 	if (cmd == DISABLE_KEY) {
-		arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
-		arg.key_data = NULL;
+		if (flags & WMI_KEY_GROUP) {
+			/* Not all hardware handles group-key deletion operation
+			 * correctly. Replace the key with a junk value to invalidate it.
+			 */
+			get_random_bytes(key->key, key->keylen);
+		} else {
+			arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
+			arg.key_data = NULL;
+		}
 	}
 
 	return ath10k_wmi_vdev_install_key(arvif->ar, &arg);
-- 
2.51.0


