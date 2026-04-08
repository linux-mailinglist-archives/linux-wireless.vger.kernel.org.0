Return-Path: <linux-wireless+bounces-34531-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJQGEpK41mlxHggAu9opvQ
	(envelope-from <linux-wireless+bounces-34531-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 22:20:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CF3C3B69
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 22:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D9DC300752F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8E391846;
	Wed,  8 Apr 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE95iFB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EC38D6AB;
	Wed,  8 Apr 2026 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679629; cv=none; b=FeQgrkY7cXYrV9vJaEyKTSv4DFH7jx/gn7Bj3oL2pwLtM3kZpf90GrmVdQ7WSWsDHCdbf2pgeX7NYtDk7fc1Eu44ui304FSuYyGxIF7YqQSfIpi4zstrsS8i2bA3UjNuyz+DaEV2mSEIaoZk/rGj3gaIx01JEQ/NGVgcI8hMOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679629; c=relaxed/simple;
	bh=JHJ4QinlnrF8WrNXZvCq4WRQrio33RdljaeZwcyewWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SHGd63UcT9LxvaqmMX9I0EwpZ3FjM9Bd4d7jGHplZwkt3FiWG/3eAsfGCzyD18h7qdk1iUbRsa74xSmV4iwHjpwcuZWGFiGQ198jlXdhW32aMw5Fkl/T66JzOT1JxWAq7iY7XByDvuRkkeBY2nliqxBEteA74aA7NyMrwwfgZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE95iFB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D10C19421;
	Wed,  8 Apr 2026 20:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775679628;
	bh=JHJ4QinlnrF8WrNXZvCq4WRQrio33RdljaeZwcyewWg=;
	h=Date:From:To:Cc:Subject:From;
	b=FE95iFB7p02sEPxjxJZ6mN+30YFlKABSCBTsvKpqBEmKdqXnnID8AfNdQ//UNgcDp
	 032uovvjSHyOcOsq5hufYPnIX8jGb8SdY+430y/urnufwVtfyaRSHSbr9Epf+EMpUV
	 yrWdD3Ixsz/szlAzTpktZHrZiL+wofkoZxQB9OCGkQkzJ/roQP8aAGBWUF63+AL6D6
	 YIl+6zhJjZIR9ov3qs0vplWTKgpYLIDWNeEfk8Avmo5DVshOkBK+eh9gP9AfyGXVo+
	 +VEbPQl8tKzauDsrUOwrwFMDu6ueo8RM0AH6Eqgb2qLLkODyylWE7z/FooqADogiwj
	 08Yvcb8bu3Bxg==
Date: Wed, 8 Apr 2026 14:19:22 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: mld: tlc: Avoid a
 -Wflex-array-member-not-at-end warning
Message-ID: <ada4SvJPdt2DahPG@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34531-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 016CF3C3B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use an anonymous embedded struct (enabled via -fms-extensions) to split
the header portion from the flexible-array member in struct iwl_dhc_cmd,
so the new header type struct iwl_dhc_cmd_hdr can be referenced
independently (of the flexible-array member), and fix the following
warning:

drivers/net/wireless/intel/iwlwifi/mld/tlc.c:544:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Add comments and a static_assert() to prevent adding new members
directly to struct iwl_dhc_cmd. Any new members must be added to
struct iwl_dhc_cmd_hdr instead. This preserves the expected memory
layout between the header and the flexible-array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   | 21 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  2 +-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
index b6d79c678cd8..bce4097fee27 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
@@ -51,7 +51,7 @@ enum iwl_dhc_umac_integration_table {
 #define DHC_TARGET_UMAC BIT(27)
 
 /**
- * struct iwl_dhc_cmd - debug host command
+ * struct iwl_dhc_cmd_hdr - debug host command header
  * @length: length in DWs of the data structure that is concatenated to the end
  *	of this struct
  * @index_and_mask: bit 31 is 1 for data set operation else it's 0
@@ -62,14 +62,29 @@ enum iwl_dhc_umac_integration_table {
  *	bit 26 is 0 if the cmd targeted to LMAC0 and 1 if targeted to LMAC1,
  *	relevant only if bit 27 set to 0
  *	bits 0-25 is a specific entry index in the table specified in bits 28-30
+ */
+struct iwl_dhc_cmd_hdr {
+	__le32 length;
+	__le32 index_and_mask;
+} __packed;
+
+/**
+ * struct iwl_dhc_cmd - debug host command
+ *
+ * (NOTE: New members MUST NOT be added directly to this struct. Add them to
+ * struct iwl_dhc_cmd_hdr instead.)
  *
+ * @iwl_dhc_cmd_hdr: anonymous embedded header - members are directly
+ *		     accessible
  * @data: the concatenated data.
+ *
  */
 struct iwl_dhc_cmd {
-	__le32 length;
-	__le32 index_and_mask;
+	struct iwl_dhc_cmd_hdr;
 	__le32 data[];
 } __packed; /* DHC_CMD_API_S */
+static_assert(offsetof(struct iwl_dhc_cmd, data) == sizeof(struct iwl_dhc_cmd_hdr),
+	      "New members must be added to struct iwl_dhc_cmd_hdr instead.");
 
 /**
  * struct iwl_dhc_payload_hdr - DHC payload header
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index 78d6162d9297..b6f41a8c138e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -619,7 +619,7 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 int iwl_mld_send_tlc_dhc(struct iwl_mld *mld, u8 sta_id, u32 type, u32 data)
 {
 	struct {
-		struct iwl_dhc_cmd dhc;
+		struct iwl_dhc_cmd_hdr dhc;
 		struct iwl_dhc_tlc_cmd tlc;
 	} __packed cmd = {
 		.tlc.sta_id = sta_id,
-- 
2.43.0


