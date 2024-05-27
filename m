Return-Path: <linux-wireless+bounces-8107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AEE8D040E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AEA1F22948
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D2916D9A0;
	Mon, 27 May 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPKor72q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13241C6896;
	Mon, 27 May 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819453; cv=none; b=CJ7a7S8Wz/4u8RbxjNr6XScc/JULS8wybCQsN1PQzxZ+7fL91cHZndnGpzjgsUeA7hfMCNolFfYyXbaXX6/91AjOzYS08OK8c3Je+5E049suCoMHSHtLIrkoBw40gIXsnsm+QMMWYd/h74n5OTXIiF6XIM65gLe/8qlqMDsiHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819453; c=relaxed/simple;
	bh=h1pMCSLym4U08Im4cOy/p6rA1EwTOlJ1wEVEyDx7II0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEd7MM0AUG22b6ed4KFrnTT6I0YL8LHpINE86LvOpNWgYvQImXXMiMU89Hxiu0uS2uNuQJXifTOKBgS9U4jAtTFuT2wJ5R6l8oOpRHH/jPtiP7Q1pQjDHPD4G0BztE2J7/Ptiw1VybVTCJOUU6JQdMbqxN16w4T41facNhHHVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPKor72q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F946C2BBFC;
	Mon, 27 May 2024 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819452;
	bh=h1pMCSLym4U08Im4cOy/p6rA1EwTOlJ1wEVEyDx7II0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPKor72qXqRUwfQa6VSqwWtHwMn+qMo9aIc+WlD+Y8sKnhq+mBdK3gSErV2LYv8Qk
	 syHNOh9tl7S1uTU4KKIiikEi2O2Q8DBSqILGAKpPLL6b4otJI7D5+0GVRge4IkezOO
	 zvzk2Ug7bojYReW5zbV5WyQw9fu4BwcU4joirgKKFW0jegBQLAF2pnPu7pYR5ueOFX
	 NYxwvBGw9nQT2mbpzllzUr6O0XcQs3MOzLMkunU8BK+rhkCFYTfaexqnq7cAaX1cMe
	 2NoXSKSnYulQQZny5BjYfd4+XOEnRzUkQPVObLKlyrKcvFHVD9mQo+st0EKAltf1p0
	 2gRP+/glp7OJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/17] wifi: ath9k: work around memset overflow warning
Date: Mon, 27 May 2024 10:16:41 -0400
Message-ID: <20240527141712.3853988-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141712.3853988-1-sashal@kernel.org>
References: <20240527141712.3853988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 61752ac69b69ed2e04444d090f6917c77ab36d42 ]

gcc-9 and some other older versions produce a false-positive warning
for zeroing two fields

In file included from include/linux/string.h:369,
                 from drivers/net/wireless/ath/ath9k/main.c:18:
In function 'fortify_memset_chk',
    inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
include/linux/fortify-string.h:462:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  462 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using a struct_group seems to reliably avoid the warning and
not make the code much uglier. The combined memset() should even
save a couple of cpu cycles.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240328135509.3755090-3-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath.h        | 6 ++++--
 drivers/net/wireless/ath/ath9k/main.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f02a308a9ffc5..34654f710d8a1 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -171,8 +171,10 @@ struct ath_common {
 	unsigned int clockrate;
 
 	spinlock_t cc_lock;
-	struct ath_cycle_counters cc_ani;
-	struct ath_cycle_counters cc_survey;
+	struct_group(cc,
+		struct ath_cycle_counters cc_ani;
+		struct ath_cycle_counters cc_survey;
+	);
 
 	struct ath_regulatory regulatory;
 	struct ath_regulatory reg_world_copy;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 6360d3356e256..81412a67c1cbd 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -135,8 +135,7 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
 	if (power_mode != ATH9K_PM_AWAKE) {
 		spin_lock(&common->cc_lock);
 		ath_hw_cycle_counters_update(common);
-		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
-		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
+		memset(&common->cc, 0, sizeof(common->cc));
 		spin_unlock(&common->cc_lock);
 	}
 
-- 
2.43.0


