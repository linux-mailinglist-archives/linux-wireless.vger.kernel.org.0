Return-Path: <linux-wireless+bounces-20197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90FA5D2C3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 23:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF0189D01E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 22:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12D220693;
	Tue, 11 Mar 2025 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTwkWIw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB081E832A;
	Tue, 11 Mar 2025 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733724; cv=none; b=hwIZca/fk4+kjQjkd8hcaptyoX57bSZBXhJ+01u8e726Ta4ZfSclyEGjfFMRlllSHRquA8GiuMBKWOmBzC6ZqiDtN0dFpRHKlmBWeVRq26X2AdVMw6Cgi8xYvwPlIdVJYe80dU804dMuLH53wOXqvpDUFhoY/lMcBhpO25zqafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733724; c=relaxed/simple;
	bh=8LhBOTPARzPmuaHkaCOPg2MTWjuHpabjQf0063SJ6m4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6ncFQSX7rWfx6NtMqib1qXZDCe6nh3eCt/MQu8dtfXLcxiauyKieMDb4owg6KFono6U4oh5knTpKEainmreTo3jO6/q8DKqK8zQ37O47eolKZLqMjq+xswIqlIDvDDfyPzhqb2AyOwE3RuHGJth3HbpxexEZOt8qrtrz/J3cIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTwkWIw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487A8C4CEE9;
	Tue, 11 Mar 2025 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741733724;
	bh=8LhBOTPARzPmuaHkaCOPg2MTWjuHpabjQf0063SJ6m4=;
	h=From:To:Cc:Subject:Date:From;
	b=DTwkWIw+p55EdCE4/SsJxj6rhv7fbHwKk5YrZkdtIZbQsI1em5SJf7VLxKJ90DdbA
	 fitaywaGAu9rsSugUvvSR/+7A/PB3DzMofX24LKWtSMC9IyizhxmqrV0WV/ZEJZVR9
	 Shb51rzEafZ6SeP5CxMxsGFd/+oDGwHDA1NRTNmont45G5pldxn4Hd/yxepYihuTdZ
	 N43ObsKGiEpDl0lQdylaJNvPmXouYY+v4jyGTUUiRSDipgITx25SqSS8e8CT93nXP0
	 IMmvNiytdC2v0+BuIFzlduLiRseY4HIq+gSgBZ+dm/6PrBSEbMyM/oseFCiONGQoGX
	 LKlmwexqIz/nA==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Alexander Wetzel <alexander@wetzel-home.de>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: zd1211rw: Add __nonstring annotations for unterminated strings
Date: Tue, 11 Mar 2025 15:55:20 -0700
Message-Id: <20250311225513.it.620-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=kees@kernel.org; h=from:subject:message-id; bh=8LhBOTPARzPmuaHkaCOPg2MTWjuHpabjQf0063SJ6m4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkX9od3HHKflnKxeC7LmqfRx3kiu5ecsuG4s/b+IVGpx Jb/jX3OHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNJLmb4H6VuYP0w8vesTo5W UeUJwuaH8rfrc6smhSrcaZNZziL3meGfee1GjqrKrxYhPEHx5baiwppbJrT+LszP2MnMJT3ttjg 7AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v1: https://lore.kernel.org/lkml/20250310222318.work.395-kees@kernel.org/
 v2: correctly split and fix subject
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Alexander Wetzel <alexander@wetzel-home.de>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Shaul Triebitz <shaul.triebitz@intel.com>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index f90c33d19b39..9653dbaac3c0 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -21,7 +21,7 @@
 
 struct zd_reg_alpha2_map {
 	u32 reg;
-	char alpha2[2];
+	char alpha2[2] __nonstring;
 };
 
 static struct zd_reg_alpha2_map reg_alpha2_map[] = {
-- 
2.34.1


