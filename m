Return-Path: <linux-wireless+bounces-20124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF22FA5A714
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E687A8582
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14CC1F0982;
	Mon, 10 Mar 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRD7/F6J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B71EF398;
	Mon, 10 Mar 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645424; cv=none; b=gPiBwWdLi3nRf9AHXKg+Sr3WS2ttClkuTWkOGzpsRK7uQcbgRQ3TfxZ7CKttKeKVtAIueQApnIP0meDxwyMAxWKn4gOkB67MrAEWFupH6NIFl3hxXzic4fqnCv25Z1P+0JnPkcv1FTdz7kSKaxfMh383L4PDEAaZ7BM87dYcr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645424; c=relaxed/simple;
	bh=y2vB5VLFr3e3/HEwicy0eo+5v4Jm5b4+FPrqBJd8ICA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IMhhU1XEvP85r/6EFaQ88WRlqfYq7K2k9eR+BSDszjU9sCHqBf8e+igeWO2pwDrqIR2gOLObFIwiIZ/kRaN2g4km+ccXHxIQVcwToizOlQHtqCt1717zqyQeACY06sFyiLEvZRB/EhpuvjMNqI6+EIEcC77u8WvDRU+5McvHQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRD7/F6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5A9C4CEE5;
	Mon, 10 Mar 2025 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645424;
	bh=y2vB5VLFr3e3/HEwicy0eo+5v4Jm5b4+FPrqBJd8ICA=;
	h=From:To:Cc:Subject:Date:From;
	b=sRD7/F6JDqS4jQIsbj4grEcW1m+r1zx242I5Ljvup8dNxyiVYV8oloFSF6fTf2KyI
	 W5CZLR7HtxprWrfuBCgYNlxoc5rz1yRHTNpLO1cl7t1XZobNrGHQznlzMqTIFdld0W
	 dlUs/dV9Jy/x0717g+w3vUM1jDCIc/808mCojU+58JXv+aEozQ8vIfM+pMg3qsjcmI
	 V+Z0pCUidxulAMDvOf44nBR1h+uNpVTXmcUYnl1s1AFEfiPpxRS/0lsi7zrTIH90NG
	 jE3iQXy4JACDOEJ+lnLBlIwK8Ln+xUzXxk4dSYPgbR8HLlf73j7HA34ltXkiKLqdgw
	 ZKsnkZDYwt8Kg==
From: Kees Cook <kees@kernel.org>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: carl9170: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:23:40 -0700
Message-Id: <20250310222339.work.654-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=kees@kernel.org; h=from:subject:message-id; bh=y2vB5VLFr3e3/HEwicy0eo+5v4Jm5b4+FPrqBJd8ICA=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn03LyrX2rPb158/c6ZLE3c1rnHlzhIztHyGPhvUZFi cu78053lLIwiHExyIopsgTZuce5eLxtD3efqwgzh5UJZAgDF6cATOTEK4b/YRr/moKWmtTfsui+ LabWnXTvxEGHkItWcRp/Z07byyfOw8hw3NgiM2KjyF5r2wdiLw0Nwhcff9SzSv9Wci5/YBPL0p1 sAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/wireless/ath/carl9170/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
index 4c1aecd1163c..419f5530f885 100644
--- a/drivers/net/wireless/ath/carl9170/fw.c
+++ b/drivers/net/wireless/ath/carl9170/fw.c
@@ -15,7 +15,7 @@
 #include "fwcmd.h"
 #include "version.h"
 
-static const u8 otus_magic[4] = { OTUS_MAGIC };
+static const u8 otus_magic[4] __nonstring = { OTUS_MAGIC };
 
 static const void *carl9170_fw_find_desc(struct ar9170 *ar, const u8 descid[4],
 	const unsigned int len, const u8 compatible_revision)
-- 
2.34.1


