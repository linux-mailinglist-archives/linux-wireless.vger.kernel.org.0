Return-Path: <linux-wireless+bounces-8105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998998D03CE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F811F2189B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54C184100;
	Mon, 27 May 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7+y6deD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1515F3EE;
	Mon, 27 May 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819373; cv=none; b=m9iHfOyoz2qnCXdsNzWPr9mCzZ9vUE/Z0T3sZ2NDHnV0FRJ13+Ro5uJ6VhO9sWh4wSl1Q/k7OX6heCCycK0NNL+qBAQgokV+tDu/ebd/9wYe3BeoyyoPHRlfE1oXNnywIsRfUs3n5GUJhsaHifEtAJwwEKagUHfuak/88bz6qJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819373; c=relaxed/simple;
	bh=w0vmZBDzbk578MELvFQHfDRJTmtOoR6IqlfaComYh3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az//18HMhM0XyNRrcxRR2At9z5sb3GQJ3FwZCeZhtZsGed+YS3d8CAK93vM3XIkyCsRyWPnKTIndsbmx5Xi90Xgx7nK0G+0d+67XRqj+EYVl4ZmPUS+U36bUyfWnV9hme21EvGri2wt5lao+rV41IMD4fkB3hiDb5S/1/hVd9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7+y6deD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE736C32781;
	Mon, 27 May 2024 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819373;
	bh=w0vmZBDzbk578MELvFQHfDRJTmtOoR6IqlfaComYh3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7+y6deDduc7GR2qWmUUlVMBnkWJCBZ3jUvJhA1JWBeSaWgiRD02eI7tC+FlCeNcO
	 5/Zo+knTfpcyEcf8CsYt3KIfXHbUm2XfsFvT12i8+JtkSGXZVPfvd5PpdmSVZpo6GR
	 zKhlQfzJig93qHPGvUA/iWzBVWZSHYvT7zxCGKhVnqbaPnATVxecJ2JUU7ko0d6vJL
	 ZcYaxNGPXPOMZAOml4/JHX64Z/NNK5oM2o7uhcEuHucPs7OasGiW27z3v5xIVNUAvP
	 yDYVSKcYQjr2XgqmuQP91EOtVKFMt5jV+WYTUEdxomOXTK4JRD/QIeYPQx9GskTvId
	 tREQAJtthlw+Q==
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
Subject: [PATCH AUTOSEL 6.6 05/21] wifi: ath9k: work around memset overflow warning
Date: Mon, 27 May 2024 10:15:16 -0400
Message-ID: <20240527141551.3853516-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 1494feedb27db..aa271b82875e0 100644
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


