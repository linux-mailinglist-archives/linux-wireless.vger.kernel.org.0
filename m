Return-Path: <linux-wireless+bounces-8111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFE08D047A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECED11F21336
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9681667D6;
	Mon, 27 May 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb7LkGmu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB601667D0;
	Mon, 27 May 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819562; cv=none; b=DaeOn7+MkS4QudQLW53OEXB/gsusPm8rlPqDGcBqsOMI+RZpBlY5dPFeeBDP1DJosfofgMzZs7A5DiJf9KcmF0fvIyI3KfDnIs7B8pPySRTF7OW66hk25cii4kS/TjQqY0nAeRO7fdkEEj3aVUKtz68bJhc/rXxsZquShrbAdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819562; c=relaxed/simple;
	bh=bQw1hBLFgwb02QhDgR5Zh1puQadb/ncCstE5RNT3KVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcIXA4DkpZcC6qPn8PVt6Z/ohQZQjAfzE5STMHVwUEmIjA5AtEORbu75jbLaoplYrIf4EzbjAbHEYgEhhNsctwMppMITNQDN93sWPpBKBhQTpa5awKgKdLzcsLpBQVKpAalOCfZ3BKOAHNUZ8xBJph8nVTXPTr5WoIbtKgfBB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb7LkGmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD42C32781;
	Mon, 27 May 2024 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819562;
	bh=bQw1hBLFgwb02QhDgR5Zh1puQadb/ncCstE5RNT3KVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb7LkGmuwWa7jGVEUrDmFWnoardbbpxxKwcIrk8GXLWQSKxT0P8xDl2l9/Z4heglL
	 IaeKj4fYiZ40gDonxp+YLgpR4aRO2lcsMFoRtsvasZ1Ur5YeBKY+k4xJH8UOcuzGhU
	 LQcF44twVIBDJPR/IC5O5gZQI+9i3Mlb2fhCUzuG6vCwghLjO3SoiQLE87xqtpX+oA
	 cy4703oZb94nsl4rXuRAQoHMi/QL+FUb9A7ZE8NXviE4Cp6NZObSTZDDhT4Uo18mQ2
	 BQxvo7syy/yxSPAJH02E2Y0BnCgcHphvfaXuPmW18c/Ozh8afcrkBogWaQpT2+xgKq
	 zXKOGtopNjHEw==
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
Subject: [PATCH AUTOSEL 5.10 04/13] wifi: ath9k: work around memset overflow warning
Date: Mon, 27 May 2024 10:18:41 -0400
Message-ID: <20240527141901.3854691-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141901.3854691-1-sashal@kernel.org>
References: <20240527141901.3854691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index b2cfc483515c0..c5904d81d0006 100644
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


