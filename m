Return-Path: <linux-wireless+bounces-32155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNcYHCwAnmkfTAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 20:46:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E141A18C31D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 20:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D77A303BA5F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8532ABF1;
	Tue, 24 Feb 2026 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZIcStBI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1541FC7FB;
	Tue, 24 Feb 2026 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962409; cv=none; b=dVicBHSMl8lF1CbUl1+gu1bA+q8syMYgkwK+OVtpZzNMYgY2+x6RrOTq+BW8bmzmfu4f8ct4qbM4nisGJH5cbO2gao4TQ8HE2Gihm8Equv7BEnfSb1x2CfH5GW4Pkhq40IL7GcPgQGcRztCXlGRxxQ7YBc1cp8ygdiENrYD1YK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962409; c=relaxed/simple;
	bh=WdbkqgfLfo6zRN4JKq8jQL0DmFzINHD01rn1Bl7BB9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jDa56T5cTueL1yCsQujsM4fIQ5frjVJDsoryySqtvEokjPbltZcijTtftsnuQDXEJu3ulj0kYpakj1quERYoqX800V89XZV24sBvf1jYoePKBhqrS5EXO62ilBgIDXCzDYD46rGKg4nxaEd4SBWx+1YYb4Z8b3BdTDH8Z4iM7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZIcStBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF238C116D0;
	Tue, 24 Feb 2026 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771962408;
	bh=WdbkqgfLfo6zRN4JKq8jQL0DmFzINHD01rn1Bl7BB9o=;
	h=Date:From:To:Cc:Subject:From;
	b=kZIcStBINWtJVDs0JwFH2ISDMsaLByMFWhG/h1Eu30Eb/eaWPXF/jbDD98KuPPPVZ
	 +zuPCEeAUnKkFL0kariqlvrF1CV4KCR2cbGdKrY0ICMi2XVfl9BMo3JPgkYM2y52X9
	 MaxmfXopWNRmKjzn1ira3dUbk6TGtwcbOOnSe/20xBng/2+RngxF1bRO68rgbaiLFS
	 6+ueiGFuWRN1LKInoMrLIV1QZLmIEEuYXjOAj4R95M7powViXnssf7ruFrdLqNCRBN
	 BMIPVAk05FoeV6Bj3uwPmiWWkVHEgIBrPMRo1Jya/ax22246ukX86TCPoFxNTq0IEu
	 BkTV1PtBUQ/Wg==
Date: Tue, 24 Feb 2026 13:46:17 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aZ0tGZnmtGckKJzY@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32155-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E141A18C31D
X-Rspamd-Action: no action

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Remove unused structures bss_bias_info and bss_bias, and member
bss in struct roam_ctrl_cmd.

After these changes, the size of struct roam_ctrl_cmd, along
with its member's offsets remain the same, hence the memory layout
doesn't change:

Before changes:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct bss_bias_info bss;                /*     0     1 */
		struct low_rssi_scan_params params;      /*     0     8 */
	} info;                                          /*     0     8 */
	u8                         roam_ctrl;            /*     8     1 */

	/* size: 9, cachelines: 1, members: 2 */
	/* last cacheline: 9 bytes */
} __attribute__((__packed__));

After changes:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct low_rssi_scan_params params;      /*     0     8 */
	} info;                                          /*     0     8 */
	u8                         roam_ctrl;            /*     8     1 */

	/* size: 9, cachelines: 1, members: 2 */
	/* last cacheline: 9 bytes */
} __attribute__((__packed__));

With these changes fix the following warning:

drivers/net/wireless/ath/ath6kl/wmi.h:1658:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Remove unused structures. (Jeff)

Changes in v2:
 - Create new separate struct bss_bias_info_hdr, and use
   transparent struct members (in struct bss_bias_info)
   instead of rearranging members in struct roam_ctrl_cmd.
 - Update subject line - Add 'wifi:' prefix.
 - Link: https://lore.kernel.org/linux-hardening/aZP4RI-uN2001cBh@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/aR153k4ExCD-QTMq@kspp/

 drivers/net/wireless/ath/ath6kl/wmi.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
index 3080d82e25cc..8fbece3fdad9 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.h
+++ b/drivers/net/wireless/ath/ath6kl/wmi.h
@@ -1630,16 +1630,6 @@ enum wmi_roam_mode {
 	WMI_LOCK_BSS_MODE = 3, /* Lock to the current BSS */
 };
 
-struct bss_bias {
-	u8 bssid[ETH_ALEN];
-	s8 bias;
-} __packed;
-
-struct bss_bias_info {
-	u8 num_bss;
-	struct bss_bias bss_bias[];
-} __packed;
-
 struct low_rssi_scan_params {
 	__le16 lrssi_scan_period;
 	a_sle16 lrssi_scan_threshold;
@@ -1652,7 +1642,6 @@ struct roam_ctrl_cmd {
 	union {
 		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
 		u8 roam_mode; /* WMI_SET_ROAM_MODE */
-		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
 		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
 						     */
 	} __packed info;
-- 
2.43.0


