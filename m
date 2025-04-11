Return-Path: <linux-wireless+bounces-21435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5688A856CF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB873B9A49
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BB29614C;
	Fri, 11 Apr 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vbEX9y5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E71D86F7
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360867; cv=none; b=DbqDtezvD8cSX6wq4rYwm5euLqBzzhpCofi0MOj+XbvoTxzsDcm/dkQ7d+cAq5/4NujnK4OYPsV51cjE8a2BFQZz7S68jBcknDR5i3hgZV1mS/1feqcaF2XPfZxK57va7IXmpjuUHkhwJXZ6VCfo0J8Jt3AJY1ATt4R8Ot4PSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360867; c=relaxed/simple;
	bh=Zo9242HXTwRAK7IhTxgtJz4xZq6YJz+wHJcKgoslaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZNKRarBuj3cNenCWlUK8ighv+PhIAxx7xBh4jZTpikcAemu9LYPa1WBvd+wRdHcLzERI2m/py4qCSL0CA39/+id42HAF1WVxa9xXHdjjG8Rl512P7okOZfJfLYMo/EPjad87z3lXYj+Gpv5kEd1s/xAy9v7i4jBMAdbdepJiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vbEX9y5i; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=xnDPlXztfA4M7pubAl70kH19DOTiDS/UbWiP+bd28k0=; t=1744360864; x=1745570464; 
	b=vbEX9y5idPpaLBoFju0ZCJOFDvArhVKzMHwEvtE4vabnRLoUbsULlynsRVslC1dnF8smpPFFU1J
	kO4sjceSjbrlBbvy1EjKyiwj1JLeJip5c4hR8ZUvF0xLH1g3V7WpQZ2T6gDviRTIZrfM+NNi290KF
	8Ez3+R3xHTTJByrMNFMGYfPJaR1vi6IYca68cKEfmsSifzv+RpUCrEB/JqJgfrCwvIx0NUku2BmFE
	k0tHm4f3mU1p3ayZunU8Tqz4hY8Ix2/4wAje1ppsBy2I8I/xO16hI8ktvErgmxmp5HL/dRXEwYpBr
	Iie7REXiCDV0l+iVXwEjBFFXug30VAoQBokA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u39wV-00000007TVP-3lPE;
	Fri, 11 Apr 2025 10:40:56 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless] wifi: iwlwifi: pcie: set state to no-FW before reset handshake
Date: Fri, 11 Apr 2025 10:40:54 +0200
Message-ID: <20250411104054.63aa4f56894d.Ife70cfe997db03f0d07fdef2b164695739a05a63@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The reset handshake attempts to kill the firmware, and it'll go
into a pretty much dead state once we do that. However, if it
times out, then we'll attempt to dump the firmware to be able
to see why it didn't respond. During this dump, we cannot treat
it as if it was still running, since we just tried to kill it,
otherwise dumping will attempt to send a DBGC stop command. As
this command will time out, we'll go into a reset loop.

For now, fix this by setting the trans->state to say firmware
isn't running before doing the reset handshake. In the longer
term, we should clean up the way this state is handled.

It's not entirely clear but it seems likely that this issue was
introduced by my rework of the error handling, prior to that it
would've been synchronous at that point and (I think) not have
attempted to reset since it was already doing down.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219967
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219968
Fixes: 7391b2a4f7db ("wifi: iwlwifi: rework firmware error handling")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 3ece34e30d58..472f26f83ba8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -147,8 +147,14 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 		return;
 
 	if (trans->state >= IWL_TRANS_FW_STARTED &&
-	    trans_pcie->fw_reset_handshake)
+	    trans_pcie->fw_reset_handshake) {
+		/*
+		 * Reset handshake can dump firmware on timeout, but that
+		 * should assume that the firmware is already dead.
+		 */
+		trans->state = IWL_TRANS_NO_FW;
 		iwl_trans_pcie_fw_reset_handshake(trans);
+	}
 
 	trans_pcie->is_down = true;
 
-- 
2.49.0


