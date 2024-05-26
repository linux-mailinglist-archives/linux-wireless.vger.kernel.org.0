Return-Path: <linux-wireless+bounces-8070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A68CF6D9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 01:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9124F1C20D9A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 23:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6711EB3F;
	Sun, 26 May 2024 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ORul72eL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1532F46;
	Sun, 26 May 2024 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716767161; cv=none; b=EntIqJ//1sw0ga2yZP2gqXzxvytJFAohvvv/RrWONIsWSiLXaEH4OVpEd3mf/QH/YrfzcNZRW6aSOulcb+Tz1q41n02RzfsTq0cz9Z8fgyMhAY2Mp83wGgoIyX9H5aSr+fyPN0lWko1grYEj3lVW8UgABJ71j3Jz27F9/Kqpy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716767161; c=relaxed/simple;
	bh=qXoqmCSRZqsK09WB7t0kMJUs/2SabjKRrcA53Ey6FAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2yTRF6JCzXX1y36ZDmnfySVkgUq8eFEP99ogacXZeK0ZaI74t52YdDY3XG0eWgo+M3pZaM0x59aAS1CmAlfSFPnK/MQ/eniVjhJ1VabSQmZjfbmW+hVai5qSKVG6mjzz4KhLz5UCqH4q8MEZ2Zfu9mDvqgP8t7z1LoHXpK6bDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ORul72eL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=qiDGAoolFCI/rpAmXM4BDJt2JwmP7vG6h5f5QF4zoYY=; b=ORul72eLkU0mjtxe
	2zuUg98R4TzLgV5yJAc+zJ4LxbhwwEdaW9+GHDuDWzqPc6OzVY/AgwwZCb1vlH8sCbGcgj1RLm8M7
	Yc4Z+4KHGvoiL01rbYlsZdLM+SH9jEMgn658GIe292JxwRj8LZrh7u3P6hGmXAnhq6HxWaCr8ON94
	DXZhcgXdQHDLKtLfrTMtTzWvTvZsm1G5GBWSNp11ICPX6aYjbdsCWSas29pEOJ8m8J5rBxa6xU51y
	lhUc9F5u00V9FVLjJHM+qWfRLgck0X3WkVIfxtrIwTRZwbtZWjLzWKOxc9mA96RHRAFVjBtAyCW1z
	SFLa6Df62XdntjUbDA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBNYp-002bmh-2C;
	Sun, 26 May 2024 23:45:56 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] wifi: brcm80211: remove unused structs
Date: Mon, 27 May 2024 00:45:53 +0100
Message-ID: <20240526234553.286773-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'brcmf_pcie_core_info' was added in
commit 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
but never used.

'brcms_c_bit_desc' last use was removed in
commit cdf4352f5c59 ("brcmsmac: Improve tx trace and debug support").

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 5 -----
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b52..ce482a3877e9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -313,11 +313,6 @@ struct brcmf_pcie_shared_info {
 	u8 version;
 };
 
-struct brcmf_pcie_core_info {
-	u32 base;
-	u32 wrapbase;
-};
-
 #define BRCMF_OTP_MAX_PARAM_LEN 16
 
 struct brcmf_otp_params {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 34460b5815d0..4576b18fcd97 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -234,12 +234,6 @@
 /* max # tx status to process in wlc_txstatus() */
 #define TXSBND				8
 
-/* brcmu_format_flags() bit description structure */
-struct brcms_c_bit_desc {
-	u32 bit;
-	const char *name;
-};
-
 /*
  * The following table lists the buffer memory allocated to xmt fifos in HW.
  * the size is in units of 256bytes(one block), total size is HW dependent
-- 
2.45.1


