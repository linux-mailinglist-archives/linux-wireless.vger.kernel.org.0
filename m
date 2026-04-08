Return-Path: <linux-wireless+bounces-34532-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP1NBOe41mnLHggAu9opvQ
	(envelope-from <linux-wireless+bounces-34532-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 22:21:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FCC3C3B9D
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3C430158A2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2EA379EE2;
	Wed,  8 Apr 2026 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME2LKMB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969D26F29B;
	Wed,  8 Apr 2026 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679712; cv=none; b=L8/0aYle0uJNss6f3u17I6O/iZzpT9z6DxJ7yJLGYp46SXSSlRA7RZflbP1eZx+IXiqc2SQcAQzAp8X8rVQUiYeb5kDzyBXVpTQavJQVzbvQoZUmR+SWkAtyR0bdjyze6+NVWKuBSZDiGqmOeqiGLmgubbvxuSmyGjZJeUxewBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679712; c=relaxed/simple;
	bh=BVou9F0SrGtga1GQXF8xZ89pmIJJKkDR1j3Ghv7t+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aa9V+SY1qbANiVbLiI6zg14Vz8iys2Vnc0uELF6F67gSVfXXNW+vxB0WPQtHITMVt9QDzynk7PP7mgPPvB+YTS1pMual9XzyixNqdxsVWDYfkqc8Fo1OXpRxIm66M7nWqz1bp9JM1pjzWlkchBHQXnqD/Cwjz9iCRBear33rCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME2LKMB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2344EC19421;
	Wed,  8 Apr 2026 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775679711;
	bh=BVou9F0SrGtga1GQXF8xZ89pmIJJKkDR1j3Ghv7t+4A=;
	h=Date:From:To:Cc:Subject:From;
	b=ME2LKMB7bLM1rKawwrRWht9ldeC2LdjqyePI9s6loiNYq0EUFtphoVJeYGL+M+9Nt
	 35IOreY/y82jRevjJCQizmxdNtkbuHz4MvqRAN26VfXVeJyVErmZNwYAYpTNivkmHF
	 mOWLSQhAfKe1TjCqTfWUBDfF9eOTDtjv3MWzpv8zJ8y1rmJNQa5lfgRpV4xEkQWZeH
	 /pKETQiBiw4GOkM+X5cYRSFoVn087SOeCfQjx+ndFuHxSK9e0iZDVQGrZAO5YZj3y1
	 slR3pdYN3Am/EuoQ2bwu1spz9sE6ubn0ja4GMhgT/D3Ex/JhXOfRNoaUYnOAkQ+hkd
	 WvNFiKPlLXKNQ==
Date: Wed, 8 Apr 2026 14:20:46 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: mld: rx: Avoid a
 -Wflex-array-member-not-at-end warning
Message-ID: <ada4nkgytDjxs-Hv@kspp>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34532-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 80FCC3C3B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use an anonymous embedded struct (enabled via -fms-extensions) to split the
header portion from the flexible-array member in struct iwl_rxq_sync_cmd,
so the new header type struct iwl_rxq_sync_cmd_hdr can be referenced
independently (of the flexible-array member), and fix the following
warning:

drivers/net/wireless/intel/iwlwifi/mld/rx.c:2172:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Add comments and a static_assert() to prevent adding new members
directly to struct iwl_rxq_sync_cmd. Any new members must be added
to struct iwl_rxq_sync_cmd_hdr instead. This preserves the expected
memory layout between the header and the flexible-array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 21 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  2 +-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index ac6c1ef2cbcd..02a5bacfb175 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -918,19 +918,34 @@ struct iwl_rss_config_cmd {
 #define IWL_MULTI_QUEUE_SYNC_SENDER_MSK 0xf
 
 /**
- * struct iwl_rxq_sync_cmd - RXQ notification trigger
+ * struct iwl_rxq_sync_cmd_hdr - RXQ notification trigger header
  *
  * @flags: flags of the notification. bit 0:3 are the sender queue
  * @rxq_mask: rx queues to send the notification on
  * @count: number of bytes in payload, should be DWORD aligned
- * @payload: data to send to rx queues
  */
-struct iwl_rxq_sync_cmd {
+struct iwl_rxq_sync_cmd_hdr {
 	__le32 flags;
 	__le32 rxq_mask;
 	__le32 count;
+} __packed;
+
+/**
+ * struct iwl_rxq_sync_cmd - RXQ notification trigger
+ *
+ * (NOTE: New members MUST NOT be added directly to this struct. Add them to
+ * struct iwl_rxq_sync_cmd_hdr instead.)
+ *
+ * @iwl_rxq_sync_cmd_hdr: anonymous embedded header - members are directly
+ *			  accessible
+ * @payload: data to send to rx queues
+ */
+struct iwl_rxq_sync_cmd {
+	struct iwl_rxq_sync_cmd_hdr;
 	u8 payload[];
 } __packed; /* MULTI_QUEUE_DRV_SYNC_HDR_CMD_API_S_VER_1 */
+static_assert(offsetof(struct iwl_rxq_sync_cmd, payload) == sizeof(struct iwl_rxq_sync_cmd_hdr),
+	      "New members must be added to struct iwl_rxq_sync_cmd_hdr instead.");
 
 /**
  * struct iwl_rxq_sync_notification - Notification triggered by RXQ
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index a2e586c6ea67..492c03b8e5a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -2172,7 +2172,7 @@ void iwl_mld_sync_rx_queues(struct iwl_mld *mld,
 {
 	u8 num_rx_queues = mld->trans->info.num_rxqs;
 	struct {
-		struct iwl_rxq_sync_cmd sync_cmd;
+		struct iwl_rxq_sync_cmd_hdr sync_cmd;
 		struct iwl_mld_internal_rxq_notif notif;
 	} __packed cmd = {
 		.sync_cmd.rxq_mask = cpu_to_le32(BIT(num_rx_queues) - 1),
-- 
2.43.0


