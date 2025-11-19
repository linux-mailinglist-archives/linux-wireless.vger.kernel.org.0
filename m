Return-Path: <linux-wireless+bounces-29123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED15C6D2D2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0678A4F38B4
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074EB329C77;
	Wed, 19 Nov 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVfXMWOZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB16329C63;
	Wed, 19 Nov 2025 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537612; cv=none; b=MokaGeDTJqoy57qnJ/ybeSwDKUhcZiyKjx8lBykEwbMqMstuQvMynBmKCV8LqoDqpfT6euyrerbrFeyDJap0IcHOr0ykYzkXSOUaYH/qyy9wgYs/IAEeDwQm0uug2+khPXacTVtmmt9UYx9BzuOe1P/CQlpiFG/AxYXaRoq0xnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537612; c=relaxed/simple;
	bh=hzLn6HUZT1V5SgjCxnqahCqRIO50AEXutoBBEZJR2Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O2/IoZyEb/R99ZvJ9to85kmDDFF6gutgc4dnFhQXYZ9S+kScz4GgRNattOGfXppMolDMJ8bM7dXaOny+GUF5BIv3Ak9YyH6LfFCbR13wuafchxiYzlkM98dXXup2Qbqjt8Zr9CAOv4kSKa5pNmEbNLEBMiWlnmQxnJjEm9XLjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVfXMWOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BADFC2BCC4;
	Wed, 19 Nov 2025 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763537612;
	bh=hzLn6HUZT1V5SgjCxnqahCqRIO50AEXutoBBEZJR2Mo=;
	h=Date:From:To:Cc:Subject:From;
	b=gVfXMWOZ+GHAcnOeBva8CHjVYOWJnHRYJ7q1kv7hauibYexL6CG6YsmsmVsmK4cEx
	 hsUHQYfSJRXeKLVm3GhcJiJyH7Uda9wJTBSIEGuk58igKxESLOoQraguUQVavr28qI
	 SP9haC9htSZzoYiU4hRCJYZEZMHwDy+ioiPwMGPkHsQ0ujesly2G7hmMbXbfJAhMBX
	 8C+YP0m69kvdJowCs3UY8yFG1+4yg/2OV/D9sHWCGcxJNn/ufIvxfe41MGH9l61REb
	 w6Z02uaiRbdX2udbIXJLlO5c7lD3uAJr+W8WMJfFVMcbJzpjBekTqUj/cd2HLUFPMD
	 rVauyrBYLwyCA==
Date: Wed, 19 Nov 2025 16:33:26 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] carl9170: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aR1yxjmzb2DM2-Uq@kspp>
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

Move the conflicting declaration (which happens to be in a union, so
we're moving the entire union) to the end of the corresponding
structure. Notice that `struct carl9170_rsp` is a flexible structure,
this is a structure that contains a flexible-array member.

With these changes fix the following warning:

drivers/net/wireless/ath/carl9170/carl9170.h:382:9: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/carl9170/carl9170.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index ba29b4aebe9f..b13685e22a0d 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -375,11 +375,6 @@ struct ar9170 {
 	u8 *readbuf;
 	spinlock_t cmd_lock;
 	struct completion cmd_wait;
-	union {
-		__le32 cmd_buf[PAYLOAD_MAX + 1];
-		struct carl9170_cmd cmd;
-		struct carl9170_rsp rsp;
-	};
 
 	/* statistics */
 	unsigned int tx_dropped;
@@ -463,6 +458,13 @@ struct ar9170 {
 		unsigned int cache_idx;
 	} rng;
 #endif /* CONFIG_CARL9170_HWRNG */
+
+	/* Must be last as it ends in a flexible-array member. */
+	union {
+		__le32 cmd_buf[PAYLOAD_MAX + 1];
+		struct carl9170_cmd cmd;
+		struct carl9170_rsp rsp;
+	};
 };
 
 enum carl9170_ps_off_override_reasons {
-- 
2.43.0


