Return-Path: <linux-wireless+bounces-31959-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDGgFaTMlGluHwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31959-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 21:16:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE75614FE9B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 21:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DBA930A7486
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D753783BA;
	Tue, 17 Feb 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOEC81JN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD84377577;
	Tue, 17 Feb 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359061; cv=none; b=JaQzPJWhQo1EIBEWTgevXaVelOCtzDHwHftrMJeSqsTwgw3ZvVhirAfg8aCfzPcKJPIAGcAgI7CPBz9aK8JNY6lQnRzIW0pN6PYlEfD5khOk8dOtSm4gkMUFDzrXk7udBuX0gvusN5kKTBx8/pj1V1ixp3bnGQQNhRIDS5NMtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359061; c=relaxed/simple;
	bh=ONjWETjeIq0uvNNrNs6VZfuywvsVa18zXJLtFUJ/lX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MxY9DiaCpoTLFOG4eanCPv4wQQz+a25tOaNVW3U7IdG0cpy38pp3Km4Va1OYrswqsoZfdjcA+W6AGTz2RVtheRixQr94ZMUlwXvbqweGrFJlqdwP8NcWQqkNWL6XckBzGUgV8SMfarOV9ycgZ5G6ymvtRov/pX9UStE0hHuelVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOEC81JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99611C4CEF7;
	Tue, 17 Feb 2026 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771359061;
	bh=ONjWETjeIq0uvNNrNs6VZfuywvsVa18zXJLtFUJ/lX4=;
	h=Date:From:To:Cc:Subject:From;
	b=vOEC81JNzZN35/gTX96e3pupgvf/2Aw4xk4X/DcYQO9Igd8qv3zFQ8kVD0vRkU2bB
	 33O0F45EvhQ2PrZUvfqItKaP/f/2XIRC6t9OYSpuGfekWcJTkTpWIEolCltHdigWPr
	 5ep9WEe35v+zGX5t5Nv40lVoMAGGW67frt2mC+P3vTzqquhSmIXldEMVviOVGYWiOX
	 50OWrCPN/0aLf9WkpLaS1OucgcRINEvbB8wrXtJNg6kxRDr7yYW35DvzFLjTcXuUBz
	 YXBVRu9Cg6X9YJPB9UuchFIHebcp8+RWS0BfS1U2Mr0tCmkERVkQ8L2PhUxEdvZiRD
	 q4lPlJgRxKYEw==
Date: Tue, 17 Feb 2026 14:10:28 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kalle Valo <quic_kvalo@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aZP4RI-uN2001cBh@kspp>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31959-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE75614FE9B
X-Rspamd-Action: no action

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

struct bss_bias_info is a flexible structure, this is a structure
that contains a flexible-array member (struct bss_bias bss_bias[]).

Since struct roam_ctrl_cmd is defined by hardware, we create the new
struct bss_bias_info_hdr type, and use it to replace the object type
causing trouble in struct roam_ctrl_cmd, namely struct bss_bias_info.

Also, once -fms-extensions is enabled, we can use transparent struct
members in struct bss_bias_info.

Notice that the newly created type does not contain the flex-array
member `bss_bias`, which is the object causing the -Wfamnae warning.

After these changes, the size of struct roam_ctrl_cmd, along
with its member's offsets remain the same, hence the memory layout
doesn't change:

Before changes:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct bss_bias_info bss;            	 /*     0     1 */
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
		struct bss_bias_info_hdr bss;            /*     0     1 */
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
Changes in v2:
 - Create new separate struct bss_bias_info_hdr, and use
   transparent struct members (in struct bss_bias_info)
   instead of rearranging members in struct roam_ctrl_cmd.
 - Update subject line - Add 'wifi:' prefix.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aR153k4ExCD-QTMq@kspp/

 drivers/net/wireless/ath/ath6kl/wmi.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
index 3080d82e25cc..d2a5c96fc878 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.h
+++ b/drivers/net/wireless/ath/ath6kl/wmi.h
@@ -1635,8 +1635,12 @@ struct bss_bias {
 	s8 bias;
 } __packed;
 
-struct bss_bias_info {
+struct bss_bias_info_hdr {
 	u8 num_bss;
+} __packed;
+
+struct bss_bias_info {
+	struct bss_bias_info_hdr;
 	struct bss_bias bss_bias[];
 } __packed;
 
@@ -1652,7 +1656,7 @@ struct roam_ctrl_cmd {
 	union {
 		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
 		u8 roam_mode; /* WMI_SET_ROAM_MODE */
-		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
+		struct bss_bias_info_hdr bss; /* WMI_SET_HOST_BIAS */
 		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
 						     */
 	} __packed info;
-- 
2.43.0


