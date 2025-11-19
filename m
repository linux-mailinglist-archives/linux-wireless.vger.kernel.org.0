Return-Path: <linux-wireless+bounces-29130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E4C6D9DB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC94F385D76
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4F33508A;
	Wed, 19 Nov 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGyXwTRW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E52E7F07;
	Wed, 19 Nov 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543292; cv=none; b=fK6MQRCbbXDY/+UtHgMx9Kl88u49VZ/5EQlCNCZnHfI3TRP6SW468NmEpudMN0gnGpJhNYO7a42gKRZ9kZe6taZFVvsjMztQmcFadXUHs6nPpaOSoLSek3d6I10X/yZcXwLnXdx/eoR3nfM3321QDxCoyXSADdK+AErjITNP4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543292; c=relaxed/simple;
	bh=mF8bZikvWMcU6cjYLEICnPp3nb1+X3n/NUpUMI/AtSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NO6tLahdCWTSVxdYYWFvUyzA388Z00m9RD/VIE6ugetJ3vJ/oKz5KYB+g9mYjiCiHPYZHs6/PFx1ZjV3OiAsNIwtY3x7wEJW9dDfTusZ3awGjBzwOoEDI7CFb4BmK092Uhmote8TXsGxbDeX9MOJTanXzrZVh2aPmCB8MaWsnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGyXwTRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0218C113D0;
	Wed, 19 Nov 2025 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763543291;
	bh=mF8bZikvWMcU6cjYLEICnPp3nb1+X3n/NUpUMI/AtSw=;
	h=Date:From:To:Cc:Subject:From;
	b=sGyXwTRWT+seTmFxiw/EwuYPCXcb8CZhVQ3I4+9p52uAN8wnCZPUkwONU4tdUE9fd
	 +aIcj4AStd2NSfrvNUVhTAuWlFBogVqXByo+H8GJl6QreSyJEqhL/+Y4ysPA2pp4oF
	 XBYXd6FRQA6vkjyDoqDn73oj6+ZqbBWAE9n0YHjsS62k6vOjQK/GjAGl20sDxXgeVN
	 RzoVhgC70jw0VEZJdT1xZWk0+xWbsqVaWkTQCQ3EsZmGWLKzZUiH60dLmETlpiqyB/
	 gzgsg5YcRsS7ZqJXk74119tZIIbIIR25ckw1z8fgQXPVj4sAO/tc8pYQDxI5BZuMe0
	 bst16PYeHWawQ==
Date: Wed, 19 Nov 2025 18:08:05 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jes Sorensen <Jes.Sorensen@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: rtl8xxxu: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <aR2I9Sere0W-4VZz@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declarations to the end of the corresponding
structures. Notice that `struct urb` is a flexible structure, this
is a structure that contains a flexible-array member.

With these changes fix the following warnings:

9 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h:1951:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
9 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h:1945:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e595cc..48b598b06523 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1942,15 +1942,19 @@ struct rtl8xxxu_vif {
 };
 
 struct rtl8xxxu_rx_urb {
-	struct urb urb;
 	struct ieee80211_hw *hw;
 	struct list_head list;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct urb urb;
 };
 
 struct rtl8xxxu_tx_urb {
-	struct urb urb;
 	struct ieee80211_hw *hw;
 	struct list_head list;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct urb urb;
 };
 
 struct rtl8xxxu_fileops {
-- 
2.43.0


