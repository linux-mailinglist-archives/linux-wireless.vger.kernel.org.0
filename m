Return-Path: <linux-wireless+bounces-25504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BFB06BCC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 04:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C1D56372D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F041428E7;
	Wed, 16 Jul 2025 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2JWK47u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE688B660;
	Wed, 16 Jul 2025 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633938; cv=none; b=XJhohwGv4afCCZn9oKEeiar0LmvWnKT1eoGHeQgceNKUI9i1T82V6MHC+aOZ5mzYZZNqCu+hAxgxX07tMWvRU7HOu/go2uKXh2FiBbl/pxQ1MIqwR/yeoT4pktUmbMqiOvz6DfnbNMOCM3wdPxMbiL/Oid5Y5sHrgq6Hvtm52vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633938; c=relaxed/simple;
	bh=+1u16U4vS2dn7v0o/6oq4Gia80+YfN2DVuNgYAdEeeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j8QG/tLXkF3wYG9spR2wH3dQ7JxCAn3zlDLJJ6xkC9gopUmSsaA+oIfDbizuSyW3JL/RYmKS1wYN3PhncVJ2I8Nw481R+HKEm+Jlv4KiNjvcRjJST5F/zNbMH7/JzCkS0WAINnXbla/77bMtczLzqzkAdtJukhZLncU+5WqfD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2JWK47u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F190FC4CEE3;
	Wed, 16 Jul 2025 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752633937;
	bh=+1u16U4vS2dn7v0o/6oq4Gia80+YfN2DVuNgYAdEeeA=;
	h=From:Date:Subject:To:Cc:From;
	b=h2JWK47uhreeBPFGmYAom7RJvXOFQcdFGYGkYLAyaU+n6AL8GFwO4vvyiWfAN4yKm
	 6u4DDs34IhMYLrdl30zgNdOR6hlLZLFobNXVAuCywq2WjpHiJfKfh/fJ6Cs1av64Jt
	 8DuVY2VlsLxTBCyvL4BdF4jptwL4gFmV0NvxAu6oFUnoy9EGbiU0gpT4adZ+rHNSHx
	 Ujc0+z5gn/KcJTtZe4ycPrzV6I0pg/4d4vnSiL8itLZSp1G6ysgqJG5NIPBeL0ZfEp
	 vaz2BwtlnMnn3iTDmKT99M7ifwhbD3H12ANdFLhvChT0aHeb34poUoKeNPO7e3ZmzT
	 4FCy+k9+4SQjg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 15 Jul 2025 19:45:23 -0700
Subject: [PATCH] wifi: brcmsmac: Remove const from tbl_ptr parameter in
 wlc_lcnphy_common_read_table()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-brcmsmac-fix-uninit-const-pointer-v1-1-16e6a51a8ef4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEISd2gC/x2NQQqDMBAAvyJ77kKixtJ+pXhI49buwY3sRimIf
 zf0ODDMHGCkTAbP5gClnY2zVPC3BtI3ykzIU2VoXRvc3Qd8a1psiQk//MNNWLhgymIF18xSSHH
 qgvd9DO7RDVA7q1J1/4/XeJ4XUqdxNHMAAAA=
X-Change-ID: 20250715-brcmsmac-fix-uninit-const-pointer-d35114a50936
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, llvm@lists.linux.dev, 
 patches@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=nathan@kernel.org;
 h=from:subject:message-id; bh=+1u16U4vS2dn7v0o/6oq4Gia80+YfN2DVuNgYAdEeeA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnlQv69i7iPCH66tmfp7Gl/HNNXNDqecKng+8HquHBJ1
 svXhWu6OkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEmioZGSb77nXUNsqYJsPV
 erD+dknSp+cPfQ/ubjWKbDvSU8Yq58LIMGNm2rVdB7LZZM0ehj8L6W0T/Jh2/RL/ZYtNmw51Szr
 uYgAA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A new warning in clang [1] complains that diq_start in
wlc_lcnphy_tx_iqlo_cal() is passed uninitialized as a const pointer to
wlc_lcnphy_common_read_table():

  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:2728:13: error: variable 'diq_start' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   2728 |                                                      &diq_start, 1, 16, 69);
        |                                                       ^~~~~~~~~

The table pointer passed to wlc_lcnphy_common_read_table() should not be
considered constant, as wlc_phy_read_table() is ultimately going to
update it. Remove the const qualifier from the tbl_ptr to clear up the
warning.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2108
Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index d0faba240561..b4bba67a45ec 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -919,7 +919,7 @@ void wlc_lcnphy_read_table(struct brcms_phy *pi, struct phytbl_info *pti)
 
 static void
 wlc_lcnphy_common_read_table(struct brcms_phy *pi, u32 tbl_id,
-			     const u16 *tbl_ptr, u32 tbl_len,
+			     u16 *tbl_ptr, u32 tbl_len,
 			     u32 tbl_width, u32 tbl_offset)
 {
 	struct phytbl_info tab;

---
base-commit: bbc19fef578970158847a41d9b6b6b218034b8c2
change-id: 20250715-brcmsmac-fix-uninit-const-pointer-d35114a50936

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


