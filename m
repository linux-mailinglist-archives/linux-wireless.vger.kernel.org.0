Return-Path: <linux-wireless+bounces-26681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730BB37D5D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE03D1BA36AE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24A32BF5B;
	Wed, 27 Aug 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghKpYgB5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC491F4CAF;
	Wed, 27 Aug 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282561; cv=none; b=TFRoP93XWMHJXxIR6Mx+cchCA56ilkevAWhTPgMAscly2qFO3ydbEmCly9vNFwbh1t7L/sS3gMpdxa4Lrsa/iaQ78yjy6hLlZaReb8n1ku4iDMuhOhpQ9G/6ftbO0pg8Cl0biF9zZv8uT0IJeFWoqdBDkdA0i+L3l+077LmLKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282561; c=relaxed/simple;
	bh=G8Kcj4hpm/ps8M7MNIHmeqljxSLkj8VQnGw3Yyky3J4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mMGj6+Jof3DR/ubv6voH4FTcvuqWMXMU8uLemHoVidzwcRhAn21APfLxk+qoaJvhkhoUuDXQSjQN+0M3Apab7VHFja9dK44E6Q2lM378zLCAqJKQhShMjxkpA91NEhYASHTpK51p6BtPQRYqefqngsbDAHZDDlfp1HT/wevqrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghKpYgB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11342C4CEEB;
	Wed, 27 Aug 2025 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756282561;
	bh=G8Kcj4hpm/ps8M7MNIHmeqljxSLkj8VQnGw3Yyky3J4=;
	h=Date:From:To:Cc:Subject:From;
	b=ghKpYgB5x6DFrxctb4Rk+rWnbGKNkkLlPEHCMY9EiKLrzyG5hysoICgEFaUKHHbTL
	 e3Onx7XNIVmXj/3Clv9IqYmE36FLLtmoDwGRsM60wRMScsp6UlwnqaECGaWbcAkqA6
	 ZdEog3d7HFHxvhYkmwQcfW/ss9jCEb8BVuzv5hO5Fq+1LevAUkip5Ic015bqtQDn9Q
	 H70OfC63IGhbdWBxYCtGHIGfrqCnHtVRJNFWN/gXiDJNyCaKALbpHpG6WY8MckpNbc
	 xytHay/6pazKbN5YBjjXDTYNdCXSBJes4gB4n1Fb8kEvfkSKroy9WOGZ5cUfOfMlGe
	 DMlyMSdhKxv5A==
Date: Wed, 27 Aug 2025 10:15:54 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: mei: Remove unused flexible-array
 member in struct iwl_sap_hdr
Message-ID: <aK6-usANI1UPtFVo@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused fexible-array member and avoid 14 of the following type of
warnings:

drivers/net/wireless/intel/iwlwifi/mei/sap.h:318:28: warning: structure containing a flexible array member is not at the end of another structure
[-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mei/sap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
index ba1f75f739c2..f985ab90d41c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/sap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -300,13 +300,11 @@ enum iwl_sap_msg {
  * @type: See &enum iwl_sap_msg.
  * @len: The length of the message (header not included).
  * @seq_num: For debug.
- * @payload: The payload of the message.
  */
 struct iwl_sap_hdr {
 	__le16 type;
 	__le16 len;
 	__le32 seq_num;
-	u8 payload[];
 };
 
 /**
-- 
2.43.0


