Return-Path: <linux-wireless+bounces-2901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6D844952
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC11C2227D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638538DE4;
	Wed, 31 Jan 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nbmFrQB1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F638DDB
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734955; cv=none; b=okiABm490AaWAlG8BC1I3STbCST2F6ID2xDR2mM55teSGOypfI7PsakRcYV04WdoRyCQ4H7u9zKH5mvAgcwFpOFMN4KBgkieK+oEeUZ+lnPKs+VZhz68Hncs5p8o8UqZLJiQDmCS7nRnV0PAzSUzT1uVC8BnVH6Lga3+tbDzEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734955; c=relaxed/simple;
	bh=ZDh86Uv67Z6uQ3ysh7aa9tK5jPSIFJ7Lj1hL+HvBAp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObZkmFJkHNlkNS3wqSoqpNXrbzo1c0YSFsHKg3HuH+wUif9Bs97pC8DHtHEk6m5qiH1fB07gKtTpMwwohOUMHkjT8I2XCI56/SfaKCMqL1BotlQSSvMsVXJQwWUdEks+LV4G6Uq5w5Znz6KkJt9kdHR/sdQbtrui1y94iqXPOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nbmFrQB1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=mMSU3H20KzjUl0X6XA0sgPYHH//9UEzlT4aIYFRLtg8=; t=1706734953; x=1707944553; 
	b=nbmFrQB1imytiPGjEwTMbYpHxLVAH//7dAUvpVnqeO0be7jeX/Hy0UYk9PVwBJVYN54EVkqE7cw
	KaQjH1Sq6ZAVB08zqFRxrKzHszmkHvEp+oaRVPc7bIv3dYLc6klOZidS03GDPEGSj060stq131Zwv
	v4xmCaCDPNOQQI+xKBqDWM/lT7lAk5RdaYFlvCXyehJ3uaLEeRv+d3hcwRMrxKXWrBOiePcEqfKPY
	48eCB/JC13x71ydvkacI4o1u0yL8y9EXgpSNrgSX7A8dtnkZ/ovIKxXI7qpMG+RFENIEfRLESK7Gj
	7rb+iT2944830mGm/D6alXyLgqm/rWB4Mb2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVHj4-00000007QkF-3pRF;
	Wed, 31 Jan 2024 22:02:31 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: api: clean up some kernel-doc/typos
Date: Wed, 31 Jan 2024 22:02:27 +0100
Message-ID: <20240131220227.7fd507f09bb1.I278edc9a3d5de7fddcd84009a93c494c42686b68@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add some kernel-doc for a union, and fix a couple of typos
I noticed looking through this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index f15e6d64c298..362161369884 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -242,9 +242,9 @@ struct iwl_mac_low_latency_cmd {
  * @esr_transition_timeout: the timeout required by the AP for the
  *	eSR transition.
  *	Available only from version 2 of the command.
- *	This values comes from the EMLSR transition delay in the EML
+ *	This value comes from the EMLSR transition delay in the EML
  *	Capabilities subfield.
- * @medium_sync_delay: the value as it appeasr in P802.11be_D2.2 Figure 9-1002j.
+ * @medium_sync_delay: the value as it appears in P802.11be_D2.2 Figure 9-1002j.
  * @assoc_id: unique ID assigned by the AP during association
  * @reserved1: alignment
  * @data_policy: see &enum iwl_mac_data_policy
@@ -317,7 +317,6 @@ enum iwl_mac_config_filter_flags {
  *	If the NIC is not ACK_ENABLED it may use the EOF-bit in first non-0
  *	len delim to determine if AGG or single.
  * @client: client mac data
- * @go_ibss: mac data for go or ibss
  * @p2p_dev: mac data for p2p device
  */
 struct iwl_mac_config_cmd {
-- 
2.43.0


