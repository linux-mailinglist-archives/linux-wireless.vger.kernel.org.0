Return-Path: <linux-wireless+bounces-14025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44C99FD28
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 02:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E3C285C57
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5CA1078B;
	Wed, 16 Oct 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5yhXm81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CBBA42;
	Wed, 16 Oct 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038710; cv=none; b=k1ZiDWLfIF0tXB5zu2JI8NaJVcEkTlo9QVGZCv29KIa/oK8uBqYDhzp97qiej48WVDzQ81GM8lJmgUWgT8jzZpl+hoRJlownOYRiowVuDr5ekwlY7qYyODc7kNjl5CKdsCEdCpnQkQaxEpzwyuZBTPcg+ChlobAZPMhNH8LpuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038710; c=relaxed/simple;
	bh=h/0LiuTcJJi5xVByk4esB4Kk1MBKkOZ8H5VO5I5yi9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnHR4iKLl2BgzosGGmkl1YTHuaRVcWFFHM9Vimlw74vMLab1yCRrJiHKAIKpH8rQhFVoksocQRN+Hg3Hy1DCquU4jI63CPrm8PWcvXWFnMNRsstJDI3ewh4bImGaIAeJeUGcgvyIHHZPmPY43a3y2De95EgMqUOJmT0BWXoRXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5yhXm81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9391AC4CEC6;
	Wed, 16 Oct 2024 00:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038710;
	bh=h/0LiuTcJJi5xVByk4esB4Kk1MBKkOZ8H5VO5I5yi9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5yhXm81qTTez88jN3ABjVLKMZuhPgYT1WznUQP9fytzhr1WpV2EacUy2W/ntDLvF
	 XSOE023SBjSuax5wOd+cLy31PTXWaSkDqE9ueABCxOyTUe2uoySVkpbAqyOTwLuSKw
	 Ljj6tXz6Ut0+R/sTJhBtdN3GSe5f1poSnJhXTm1kAEay2jPRX0PSpPBEEuhet4mZXo
	 d3ZppAXEUVAF6DEVZvSuW81Ube0ERuxUbtFfLJPwfhMn9Jqi3QVpogi/RRvNcnegxZ
	 woQCnwII3KT91mcB+PNBOFE/M1TvstkiqEnPEhBwjPlQfn4pmhHcvzEm/XlSjQ9Yr/
	 4UaGppmzvGUdw==
Date: Tue, 15 Oct 2024 18:31:47 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH 3/5][next] uapi: wireless: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <d9e9d9c1ade33701172b069e7dea728b063b00ee.1729037131.git.gustavoars@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729037131.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in various composite structs, which are currently causing trouble,
from `struct sockaddr` to `struct sockaddr_legacy`. Note that the latter
struct doesn't contain a flexible-array member.

include/uapi/linux/wireless.h:751:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:776:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:833:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:857:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:864:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

No binary differences are present after these changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/wireless.h | 50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 3c2ad5fae17f..b29ab42fa2e2 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -748,7 +748,7 @@ struct iw_missed {
  *	Quality range (for spy threshold)
  */
 struct iw_thrspy {
-	struct sockaddr		addr;		/* Source address (hw/mac) */
+	struct sockaddr_legacy	addr;		/* Source address (hw/mac) */
 	struct iw_quality	qual;		/* Quality of the link */
 	struct iw_quality	low;		/* Low threshold */
 	struct iw_quality	high;		/* High threshold */
@@ -766,15 +766,15 @@ struct iw_thrspy {
  *	current BSS if the driver is in Managed mode and associated with an AP.
  */
 struct iw_scan_req {
-	__u8		scan_type; /* IW_SCAN_TYPE_{ACTIVE,PASSIVE} */
-	__u8		essid_len;
-	__u8		num_channels; /* num entries in channel_list;
-				       * 0 = scan all allowed channels */
-	__u8		flags; /* reserved as padding; use zero, this may
-				* be used in the future for adding flags
-				* to request different scan behavior */
-	struct sockaddr	bssid; /* ff:ff:ff:ff:ff:ff for broadcast BSSID or
-				* individual address of a specific BSS */
+	__u8			scan_type; /* IW_SCAN_TYPE_{ACTIVE,PASSIVE} */
+	__u8			essid_len;
+	__u8			num_channels; /* num entries in channel_list;
+					       * 0 = scan all allowed channels */
+	__u8			flags; /* reserved as padding; use zero, this may
+					* be used in the future for adding flags
+					* to request different scan behavior */
+	struct sockaddr_legacy	bssid; /* ff:ff:ff:ff:ff:ff for broadcast BSSID or
+					* individual address of a specific BSS */
 
 	/*
 	 * Use this ESSID if IW_SCAN_THIS_ESSID flag is used instead of using
@@ -827,15 +827,15 @@ struct iw_scan_req {
  *	debugging/testing.
  */
 struct iw_encode_ext {
-	__u32		ext_flags; /* IW_ENCODE_EXT_* */
-	__u8		tx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
-	__u8		rx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
-	struct sockaddr	addr; /* ff:ff:ff:ff:ff:ff for broadcast/multicast
-			       * (group) keys or unicast address for
-			       * individual keys */
-	__u16		alg; /* IW_ENCODE_ALG_* */
-	__u16		key_len;
-	__u8		key[];
+	__u32			ext_flags; /* IW_ENCODE_EXT_* */
+	__u8			tx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
+	__u8			rx_seq[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
+	struct sockaddr_legacy	addr; /* ff:ff:ff:ff:ff:ff for broadcast/multicast
+				       * (group) keys or unicast address for
+				       * individual keys */
+	__u16			alg; /* IW_ENCODE_ALG_* */
+	__u16			key_len;
+	__u8			key[];
 };
 
 /* SIOCSIWMLME data */
@@ -853,16 +853,16 @@ struct iw_mlme {
 #define IW_PMKID_LEN	16
 
 struct iw_pmksa {
-	__u32		cmd; /* IW_PMKSA_* */
-	struct sockaddr	bssid;
-	__u8		pmkid[IW_PMKID_LEN];
+	__u32			cmd; /* IW_PMKSA_* */
+	struct sockaddr_legacy	bssid;
+	__u8			pmkid[IW_PMKID_LEN];
 };
 
 /* IWEVMICHAELMICFAILURE data */
 struct iw_michaelmicfailure {
-	__u32		flags;
-	struct sockaddr	src_addr;
-	__u8		tsc[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
+	__u32			flags;
+	struct sockaddr_legacy	src_addr;
+	__u8			tsc[IW_ENCODE_SEQ_MAX_SIZE]; /* LSB first */
 };
 
 /* IWEVPMKIDCAND data */
-- 
2.34.1


