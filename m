Return-Path: <linux-wireless+bounces-26241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1B1B1FE73
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 07:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1611783EB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 05:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9F265CCB;
	Mon, 11 Aug 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/lv1WEC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EB263C8A;
	Mon, 11 Aug 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889046; cv=none; b=mbJ2/eV+KC0cVs1HHmAgdJCoNUMGqm55DyeQJWRrwbEeigsfRljfBlxUUjsNsnDh5MluDwilSDtzOMqMe7Ahg9IpE3beYKl+y0vIpHwlHNx43SZH2TR+KT5/iRIdQqStJIlqQFI242A6ea6atF2oX/hPLGAL0BNtxyMFrQBD2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889046; c=relaxed/simple;
	bh=sBHtUXCF+8kQokeD5tixxpXogKKwzLwixr+bw4TvCWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eC41CXo3AUsD++mKspkkcqqn+I1Rt0HgNad3qeZjkRkLNzFeYWUml2dawwaZrUuU1ZgsKxw/dQ4Go+Qrywh3zD1CUs7JftEmO4b7LdUatgrl91mzmBLTFqvyGCj31K/wt+u7CTgeSyLMGF/dnJeQrxWK/31BQHuCzqFReRQ0Rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/lv1WEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8292C4CEED;
	Mon, 11 Aug 2025 05:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754889046;
	bh=sBHtUXCF+8kQokeD5tixxpXogKKwzLwixr+bw4TvCWw=;
	h=Date:From:To:Cc:Subject:From;
	b=q/lv1WECJMAhhvfKv8UnEKXXTVlGOadbjNvPXswOXwPm52UTkCC/uuiqn6l9C8LD6
	 5NoexselpTgiOwaPPDV3pVnGO1+Z3xRCm93YEDqDLWww7rcwgx9rQrY+i79pGTZRat
	 1LCZY+IFuqB7R0UoFCMz+vbIpKB04VqO3YT1zPBnIzkxRthD9cOWuqiezeQAjvwAjK
	 lk4K7OiB4EOXzPZ1weUhSlzyxsY7VMDKNXJNglwjmNvUW/bNQiP6X63FqbjyEO6+/b
	 iFDFvX2dAYfif2gE1sBSIc60m9iN9HZWB+JsfS1nDFFX56gGt39LwQGTCBUUt27B0+
	 tNyOnuh32vzhA==
Date: Mon, 11 Aug 2025 14:10:39 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <aJl7TxeWgLdEKWhg@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused structures and avoid the following
-Wflex-array-member-not-at-end warnings:

drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:68:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:60:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../wireless/intel/iwlegacy/iwl-spectrum.h    | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
index 1e8ab704dbfb..f00eb878b94b 100644
--- a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
+++ b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
@@ -50,28 +50,4 @@ struct ieee80211_measurement_params {
 	__le16 duration;
 } __packed;
 
-struct ieee80211_info_element {
-	u8 id;
-	u8 len;
-	u8 data[];
-} __packed;
-
-struct ieee80211_measurement_request {
-	struct ieee80211_info_element ie;
-	u8 token;
-	u8 mode;
-	u8 type;
-	struct ieee80211_measurement_params params[];
-} __packed;
-
-struct ieee80211_measurement_report {
-	struct ieee80211_info_element ie;
-	u8 token;
-	u8 mode;
-	u8 type;
-	union {
-		struct ieee80211_basic_report basic[0];
-	} u;
-} __packed;
-
 #endif
-- 
2.43.0


