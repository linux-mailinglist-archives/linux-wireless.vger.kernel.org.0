Return-Path: <linux-wireless+bounces-11043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03194978D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 20:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC02A1C216D4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52425757F8;
	Tue,  6 Aug 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEtm+6EU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611E7441A;
	Tue,  6 Aug 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968761; cv=none; b=RPChqb+ixBlYAnsW8K7N1Dh4t68NuQNbu0FLKQEgbeg2duF1XTzyZaw7ftbsEu+1tHK1Hvflm/MPL9L7QTBE5UNoFMt+GYgA9ZypbYMYTlOUga9DSIQQuyoKFKXR0JWy4EmuVz9p1CHwjXjF+pdXwW0WqyWD+Qcjpd3U4mbbFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968761; c=relaxed/simple;
	bh=lotPUQ9QRBFAHLBZdlRIVzGHFm7a/eTQA7EXznivsSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ce/LU7wHmj1PxUQnkiaegU3+Q3IiH1ZOE5zDgq2/lFA6GKq6alVvq1nL9ruDpv1nCPaBGTwJtI4QiMXGnO654wP1qlBvyoVimG3juJz0/hdFKdqVprmk7VKIomdOCZ0WlMX/JcTGn/9tH/WSPZbt8iUMeyHEirLRm8G3RiF/6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEtm+6EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65189C32786;
	Tue,  6 Aug 2024 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722968761;
	bh=lotPUQ9QRBFAHLBZdlRIVzGHFm7a/eTQA7EXznivsSA=;
	h=Date:From:To:Cc:Subject:From;
	b=gEtm+6EUxII0iAG2BETCHFLkkM98uMi1CuRWpnNgP2XvcSOH3gWODCdP0VwDqOQVb
	 5ELqwrMkHnhSagYlFipBMyTnzHcO/859AKSc3h/WCI/IisLyjCG0MAclmJ4+TVWgPq
	 d5sdEbFXppmYXIRprj43abCnp8KE+EOFQmNsk/eoGBQXqsdPkMLrMr9i3W3t7bArNE
	 1tIbrltZJgGcZltatkM/AveXHkHQtQrokW7PKaGjBv46J7wW6vPNJQTq57704sU6ln
	 2sen803610k0X4GH+2mpp8TPGpEt4U0vSl/v1vnFDWkI0IMmQ/rt3Aq5wXRGIaqnSX
	 gMVZa6MqOkqag==
Date: Tue, 6 Aug 2024 12:25:57 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: ipw2x00: libipw: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZrJqtUpCI+uCeb4D@cute>
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

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()`
helper to create a new tagged `struct libipw_hdr_3addr_hdr`.
This structure groups together all the members of the flexible
`struct libipw_hdr_3addr` except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct libipw_hdr_3addr` to `struct libipw_hdr_3addr_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct libipw_hdr_3addr_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

Also, remove a couple of unused structures `struct libipw_ibss_dfs` and
`struct libipw_assoc_request`.

So, with these changes, fix the following warnings:
drivers/net/wireless/intel/ipw2x00/libipw.h:403:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:420:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:433:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:441:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:447:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:460:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:468:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:476:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:592:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw.h | 46 ++++++++-------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index 9065ca5b0208..bad080d33c07 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -345,14 +345,19 @@ struct libipw_hdr_2addr {
 } __packed;
 
 struct libipw_hdr_3addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	__le16 seq_ctl;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(libipw_hdr_3addr_hdr, hdr, __packed,
+		__le16 frame_ctl;
+		__le16 duration_id;
+		u8 addr1[ETH_ALEN];
+		u8 addr2[ETH_ALEN];
+		u8 addr3[ETH_ALEN];
+		__le16 seq_ctl;
+	);
 	u8 payload[];
 } __packed;
+static_assert(offsetof(struct libipw_hdr_3addr, payload) == sizeof(struct libipw_hdr_3addr_hdr),
+	      "struct member likely outside of __struct_group()");
 
 struct libipw_hdr_4addr {
 	__le16 frame_ctl;
@@ -400,7 +405,7 @@ struct libipw_info_element {
 */
 
 struct libipw_auth {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	__le16 algorithm;
 	__le16 transaction;
 	__le16 status;
@@ -417,7 +422,7 @@ struct libipw_channel_switch {
 } __packed;
 
 struct libipw_action {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	u8 category;
 	u8 action;
 	union {
@@ -430,7 +435,7 @@ struct libipw_action {
 } __packed;
 
 struct libipw_disassoc {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	__le16 reason;
 } __packed;
 
@@ -438,13 +443,13 @@ struct libipw_disassoc {
 #define libipw_deauth libipw_disassoc
 
 struct libipw_probe_request {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	/* SSID, supported rates */
 	u8 variable[];
 } __packed;
 
 struct libipw_probe_response {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	__le32 time_stamp[2];
 	__le16 beacon_interval;
 	__le16 capability;
@@ -456,16 +461,8 @@ struct libipw_probe_response {
 /* Alias beacon for probe_response */
 #define libipw_beacon libipw_probe_response
 
-struct libipw_assoc_request {
-	struct libipw_hdr_3addr header;
-	__le16 capability;
-	__le16 listen_interval;
-	/* SSID, supported rates, RSN */
-	u8 variable[];
-} __packed;
-
 struct libipw_reassoc_request {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	__le16 capability;
 	__le16 listen_interval;
 	u8 current_ap[ETH_ALEN];
@@ -473,7 +470,7 @@ struct libipw_reassoc_request {
 } __packed;
 
 struct libipw_assoc_response {
-	struct libipw_hdr_3addr header;
+	struct libipw_hdr_3addr_hdr header;
 	__le16 capability;
 	__le16 status;
 	__le16 aid;
@@ -588,13 +585,6 @@ struct libipw_channel_map {
 	u8 map;
 } __packed;
 
-struct libipw_ibss_dfs {
-	struct libipw_info_element ie;
-	u8 owner[ETH_ALEN];
-	u8 recovery_interval;
-	struct libipw_channel_map channel_map[];
-};
-
 struct libipw_csa {
 	u8 mode;
 	u8 channel;
-- 
2.34.1


