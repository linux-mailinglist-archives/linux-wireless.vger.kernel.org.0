Return-Path: <linux-wireless+bounces-25230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FCB00DAD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3CF5C19F6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C827A92E;
	Thu, 10 Jul 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="XWDrwWII"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435522338
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182428; cv=none; b=TGAmU3p1ssk7C2UlfnJPIPwLBOzvIR8vhKNZgXVj+Oyjng100qUN92Fm8iMFt7GB9a+nunlqGYomJ7WhTIB34uLAV/JXnIoDsLm1/5Dbt99yFhAWncgB60fOKW39r5UPyZ2HtYMUmM7i+2LsspNDVtnVlrs3MPWn+hONxh+LoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182428; c=relaxed/simple;
	bh=I3o8eNyQ9eAEQ6Y7wW2CXdKWOGczz3bPOYBMZEKko6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N16984+z1LD/zZS5k6bUikruokhybIxC0++eHTazCpA6Ukf2d67wFMa2d4e4xHhCHXOnV/5DDScMiND6frEaGpsvjx806uIRHEbOkXYA03I7C7Z/1uPXVWpljM91n6H/yfhIamfz27LLiIR6jhIJss1S42YGPRZGKQ7FiU/ND7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=XWDrwWII; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A8820509987
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 21:14:57 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AE9252C007D;
	Thu, 10 Jul 2025 21:14:49 +0000 (UTC)
Received: from arrendajo.lan (71-212-32-17.tukw.qwest.net [71.212.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E001313C2B0;
	Thu, 10 Jul 2025 14:14:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E001313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1752182088;
	bh=I3o8eNyQ9eAEQ6Y7wW2CXdKWOGczz3bPOYBMZEKko6U=;
	h=From:To:Cc:Subject:Date:From;
	b=XWDrwWIIp/u0o+wlvANv8ZEw2NcwdMRuEOa70YyWY3yqYWvVg3wkdHMbOIw4KVVqL
	 F9E69Uq0O75t5zwCwl5gnhZRJ2gpkzEMZhAXv17+28H4dNqwGUVUekE2vndTFCFj3c
	 6npgqa5rPWQfEdHH9RbirknkwdbMk86k7JDQsDV4=
From: Alex Gavin <alex.gavin@candelatech.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <alex.gavin@candelatech.com>
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: Update comments in header
Date: Thu, 10 Jul 2025 14:14:30 -0700
Message-ID: <20250710211437.8516-1-alex.gavin@candelatech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1752182090-AV6M5RyOB9Gh
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1752182090;AV6M5RyOB9Gh;<alex.gavin@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

- Reorders 'HWSIM_ATTR_PAD' to after 'HWSIM_ATTR_FREQ',
  matching order in 'enum hwsim_attrs'
- Change references from old commands to new names
- Fixes typos

Signed-off-by: Alex Gavin <alex.gavin@candelatech.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index f32fc3a492b0..fa157c883f7f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -62,7 +62,7 @@ enum hwsim_tx_control_flags {
  * @HWSIM_CMD_TX_INFO_FRAME: Transmission info report from user space to
  *	kernel, uses:
  *	%HWSIM_ATTR_ADDR_TRANSMITTER, %HWSIM_ATTR_FLAGS,
- *	%HWSIM_ATTR_TX_INFO, %WSIM_ATTR_TX_INFO_FLAGS,
+ *	%HWSIM_ATTR_TX_INFO, %HWSIM_ATTR_TX_INFO_FLAGS,
  *	%HWSIM_ATTR_SIGNAL, %HWSIM_ATTR_COOKIE
  * @HWSIM_CMD_NEW_RADIO: create a new radio with the given parameters,
  *	returns the radio ID (>= 0) or negative on errors, if successful
@@ -126,24 +126,24 @@ enum hwsim_commands {
  *	space
  * @HWSIM_ATTR_TX_INFO: ieee80211_tx_rate array
  * @HWSIM_ATTR_COOKIE: sk_buff cookie to identify the frame
- * @HWSIM_ATTR_CHANNELS: u32 attribute used with the %HWSIM_CMD_CREATE_RADIO
+ * @HWSIM_ATTR_CHANNELS: u32 attribute used with the %HWSIM_CMD_NEW_RADIO
  *	command giving the number of channels supported by the new radio
  * @HWSIM_ATTR_RADIO_ID: u32 attribute used with %HWSIM_CMD_DESTROY_RADIO
  *	only to destroy a radio
- * @HWSIM_ATTR_REG_HINT_ALPHA2: alpha2 for regulatoro driver hint
+ * @HWSIM_ATTR_REG_HINT_ALPHA2: alpha2 for regulatory driver hint
  *	(nla string, length 2)
  * @HWSIM_ATTR_REG_CUSTOM_REG: custom regulatory domain index (u32 attribute)
  * @HWSIM_ATTR_REG_STRICT_REG: request REGULATORY_STRICT_REG (flag attribute)
  * @HWSIM_ATTR_SUPPORT_P2P_DEVICE: support P2P Device virtual interface (flag)
- * @HWSIM_ATTR_USE_CHANCTX: used with the %HWSIM_CMD_CREATE_RADIO
+ * @HWSIM_ATTR_USE_CHANCTX: used with the %HWSIM_CMD_NEW_RADIO
  *	command to force use of channel contexts even when only a
  *	single channel is supported
- * @HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE: used with the %HWSIM_CMD_CREATE_RADIO
+ * @HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE: used with the %HWSIM_CMD_NEW_RADIO
  *	command to force radio removal when process that created the radio dies
  * @HWSIM_ATTR_RADIO_NAME: Name of radio, e.g. phy666
  * @HWSIM_ATTR_NO_VIF:  Do not create vif (wlanX) when creating radio.
- * @HWSIM_ATTR_PAD: padding attribute for 64-bit values, ignore
  * @HWSIM_ATTR_FREQ: Frequency at which packet is transmitted or received.
+ * @HWSIM_ATTR_PAD: padding attribute for 64-bit values, ignore
  * @HWSIM_ATTR_TX_INFO_FLAGS: additional flags for corresponding
  *	rates of %HWSIM_ATTR_TX_INFO
  * @HWSIM_ATTR_PERM_ADDR: permanent mac address of new radio
@@ -151,7 +151,7 @@ enum hwsim_commands {
  * @HWSIM_ATTR_CIPHER_SUPPORT: u32 array of supported cipher types
  * @HWSIM_ATTR_MLO_SUPPORT: claim MLO support (exact parameters TBD) for
  *	the new radio
- * @HWSIM_ATTR_PMSR_SUPPORT: nested attribute used with %HWSIM_CMD_CREATE_RADIO
+ * @HWSIM_ATTR_PMSR_SUPPORT: nested attribute used with %HWSIM_CMD_NEW_RADIO
  *	to provide peer measurement capabilities. (nl80211_peer_measurement_attrs)
  * @HWSIM_ATTR_PMSR_REQUEST: nested attribute used with %HWSIM_CMD_START_PMSR
  *	to provide details about peer measurement request (nl80211_peer_measurement_attrs)
-- 
2.49.0


