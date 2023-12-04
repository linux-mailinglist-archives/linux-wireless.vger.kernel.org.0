Return-Path: <linux-wireless+bounces-393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F4803F76
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F91F212C5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B233218E;
	Mon,  4 Dec 2023 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1+Cq7vZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532D35EFF;
	Mon,  4 Dec 2023 20:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F2C433CD;
	Mon,  4 Dec 2023 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722028;
	bh=Oe/XzUk1VemmFJ9zSC9J3wWmOiOIwp2Vd4qep/nEW4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1+Cq7vZZnfn8FrP6d4qzjKbHTW14/3YfgI67YrcoazmugWsMl28CFVUG7Lrmtu8o
	 D1DuJIQ7iGf3LvAeX7LwH3O59ZAExBcFPWLb04sA3v6oJwbcmpaBXfjf1AM8WdC7sm
	 +KJ6zkbez7o1nvQDOeJldh2d8vpZJkSitD21+wUnt2NX7Blzz0wW8Kko6/RxrxUKVD
	 WWlP/bdqdUG39LY3L8whXj3gTv6SR8wMTizT3Gr2HF/v80/6FeX0v00+LhW9BIIUUH
	 Atvb67AYnNoM/TI3xZTiYZnBpKzGL+MKN5Tyi1TBXP7yolpiHpZp8CsbZqCgN/fyoi
	 7P7jCKDgf8PCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael-CY Lee <michael-cy.lee@mediatek.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 12/32] wifi: avoid offset calculation on NULL pointer
Date: Mon,  4 Dec 2023 15:32:32 -0500
Message-ID: <20231204203317.2092321-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

[ Upstream commit ef5828805842204dd0259ecfc132b5916c8a77ae ]

ieee80211_he_6ghz_oper() can be passed a NULL pointer
and checks for that, but already did the calculation
to inside of it before. Move it after the check.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Link: https://lore.kernel.org/r/20231122030237.31276-1-michael-cy.lee@mediatek.com
[rewrite commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b24fb80782c5a..6971bf16031f1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2790,12 +2790,14 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 static inline const struct ieee80211_he_6ghz_oper *
 ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 {
-	const u8 *ret = (const void *)&he_oper->optional;
+	const u8 *ret;
 	u32 he_oper_params;
 
 	if (!he_oper)
 		return NULL;
 
+	ret = (const void *)&he_oper->optional;
+
 	he_oper_params = le32_to_cpu(he_oper->he_oper_params);
 
 	if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
-- 
2.42.0


