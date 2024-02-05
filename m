Return-Path: <linux-wireless+bounces-3179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE684A775
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2224F1C27153
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0182887;
	Mon,  5 Feb 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZMiUd+o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9682864;
	Mon,  5 Feb 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162606; cv=none; b=UshWMAveCnCQWnwidR6LA5JLfWNNiAAWSMre1lTPv6EQgt42W3ZiOCollHoN5NMtd/FHFUpjkm/YsVGyMrjJ67vqOmn5AFzS+1mD/0GHzuNegNhj2Ld0Wa7C17zM6jXzNZM0vpyU/c0OvCDLABtt3/XczllqPAdheH2cjIIK3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162606; c=relaxed/simple;
	bh=XGZvM8CnVOoEcpJ+1Zp5FZhnTkRISZtwEBoyYdZSJXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hZzk+/nChsLWYc9eb7rOMTCZlEy8gmYCkXHS+tkrvHAgRD/2Iad5Mq+DoUQe0Il5Y2jUhfUkqwhR8CjUMEEwc3AD5P5RPIOdGvOJBtcY6VqecYrteee7SNpNWChuUn/GBr3QsLcKDjL1v+XHdkiaCbK9HOQUywigpr0Cns1e+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZMiUd+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E5BC43390;
	Mon,  5 Feb 2024 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707162605;
	bh=XGZvM8CnVOoEcpJ+1Zp5FZhnTkRISZtwEBoyYdZSJXk=;
	h=From:Date:Subject:To:Cc:From;
	b=kZMiUd+oD1Tv/xggEn4Lna0z0P144GIQCIwpGyd5Rk9ThIPjgN0P3f6WX5oCRUjeZ
	 HJS4nnSFmw1cbxDn0y6E5fbiWAMWg4Yhk46SkdpEK151wmBYBBR7mvT32LbytYJ0vb
	 DXVGFGDrE4rUjGNJ6GfvUlhSJj33bx53mssoxs5e6Q3dmMTXgbJ7WqNQSvELXvn2/W
	 2TGSDHojrsdBqRRyPhc8EJotFPMtmmbhqFX2dL+DSHOE+2Dzhus2xVesfHrfWhwDTR
	 VMmlcoWVLPreAbJ96tRW9OgibK5GuxabxPvagAly4XULG+an5byPV3vwM6itHJdofX
	 VLM373Q2j2lUw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 05 Feb 2024 12:49:53 -0700
Subject: [PATCH] wifi: ath12k: Fix uninitialized use of ret in
 ath12k_mac_allocate()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOA7wWUC/x3MQQrCMBBG4auUWTuQDC2iVxEXYzKxP2qUpLVi6
 d0NLr/FeytVK7BKx26lYm9UPHOD33UURs1XY8RmEie9EzewTqOXGz808DJnZEzQO74W2V/CkDT
 5fZQDtf5VLOHzf5/O2/YDFLS4Q2sAAAA=
To: kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc: morbo@google.com, justinstitt@google.com, quic_periyasa@quicinc.com, 
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=nathan@kernel.org;
 h=from:subject:message-id; bh=XGZvM8CnVOoEcpJ+1Zp5FZhnTkRISZtwEBoyYdZSJXk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkHrd/6PGEP41x5dM4eL5WyqzX9xV0Wu7/8Kgir5mjL8
 7w65//7jhIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRn/4M36s0uX8kFF4v8qj8
 ZMC4iJ3p7C8W+ULRE1fDmacKCe75zvBXaqJA6WTh8DXX0+8HOVw+K6YSnHLiX5xv3UI35k+/i+K
 5AA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/net/wireless/ath/ath12k/mac.c:8060:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
   8060 |         return ret;
        |                ^~~
  drivers/net/wireless/ath/ath12k/mac.c:8022:9: note: initialize the variable 'ret' to silence this warning
   8022 |         int ret, i, j;
        |                ^
        |                 = 0
  1 error generated.

Commit 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211
hw") added a completely uninitialized use of ret. Prior to that change,
-ENOMEM was returned to the callers of ath12k_mac_allocate() whenever
ath12k_mac_hw_allocate() failed. Assign that value to ret to make sure
it is always initialized when used and clear up the warning.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1989i
Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fb5bf500ed87..4b0521e8fb26 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8038,6 +8038,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 		if (!ah) {
 			ath12k_warn(ab, "failed to allocate mac80211 hw device for hw_idx %d\n",
 				    i);
+			ret = -ENOMEM;
 			goto err;
 		}
 

---
base-commit: b82fb7ef690bd929b88d9aab1d191ff502ed9029
change-id: 20240205-ath12k-mac-wuninitialized-1bc5faf17d29

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


