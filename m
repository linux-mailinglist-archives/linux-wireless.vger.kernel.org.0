Return-Path: <linux-wireless+bounces-10779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A9943CC0
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9488B1F27D45
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE31D3639;
	Thu,  1 Aug 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3sWPoVv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03413A243;
	Thu,  1 Aug 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471493; cv=none; b=Odk4RjIiPHrnhfoqYkxL1vhem1JKRUSuBZ8Y0KAOQ2+38WBKuXpNKBKny4/oQeBcnaXhjbvrehHEe+/n9z3iutPlw3HSZEHklCOLUukn9AOKo8r7sz5qkjFese0zMNwYMvtEaJpK72RveKUwUogtq3N2zo39o0qnZDpkiQP34Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471493; c=relaxed/simple;
	bh=ycidui46Gmttz+Hw1zuY0ii6yJV6fpP0BH2pgijwDMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svVCnpf6WtlWYjSFAqImMAJBfc876ktWIHwalTKymWyB9zhZk71tX/YW9tE1YZRIERri9S1El/VvhNRjCAb1CgmZN5w1rF5CHMEXkKJDmqHlq1BAA5o5SDD+4JUveihOjthoCoEFUhVlFwfnEyuO7Eg0HZ3Qqv2Afy/H7ZVTIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3sWPoVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF6C116B1;
	Thu,  1 Aug 2024 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471492;
	bh=ycidui46Gmttz+Hw1zuY0ii6yJV6fpP0BH2pgijwDMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3sWPoVvoEsaZ1PemiHL1uyzLJ+aO085r5utS5kVQ8V4z23t9F/gd8GLDY8hDtfTY
	 b40tIwGIclMtLNGZCrcSwRTL3d6bJUu92laLmUB3H0brQtUR8yUD6yDLl+9X/NRN2W
	 uqrpmZhICLF0b5KFvyt/uAiqDuMp1L6RyuS3SoKBtCbrsc1WkjPg0DlpmjhhnHuXWk
	 CT0u7p4yYmHR91rN2pD7iLE22ruHvbL7N2xpgr7urYnmu5wV8UL3x+lOoo8+y+Msxh
	 UZGR8i8SqUhflJYniKUVEB3E/k+T5Kl7hmb5sM55aoc8dpN60DpHnFRvlqJRZ/6FV+
	 18g5+idr8Cx+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	shaul.triebitz@intel.com,
	quic_adisi@quicinc.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 109/121] wifi: iwlwifi: mvm: don't send an ROC command with max_delay = 0
Date: Wed, 31 Jul 2024 20:00:47 -0400
Message-ID: <20240801000834.3930818-109-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 187accaa328dc4de98064eef176841b8a4716f96 ]

The firmware can't handle that (it will crash with ASSERT 300A).
This happened because we looked at vif->bss_conf which is not
the right bss_conf to look at in case of an MLD connection.
Fix iwl_mvm_roc_duration_and_delay to iterate on the active links to
get the right value for the dtim_interval.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20240703064027.e12f8d84c8fd.I3dd9f720c678c06ec7a5bf7ca56e21cf0b614c8c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 31bc80cdcb7d5..97cfd72312f2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -984,12 +984,21 @@ void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 				    u32 *duration_tu,
 				    u32 *delay)
 {
-	u32 dtim_interval = vif->bss_conf.dtim_period *
-		vif->bss_conf.beacon_int;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+	u32 dtim_interval = 0;
 
 	*delay = AUX_ROC_MIN_DELAY;
 	*duration_tu = MSEC_TO_TU(duration_ms);
 
+	rcu_read_lock();
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		dtim_interval =
+			max_t(u32, dtim_interval,
+			      link_conf->dtim_period * link_conf->beacon_int);
+	}
+	rcu_read_unlock();
+
 	/*
 	 * If we are associated we want the delay time to be at least one
 	 * dtim interval so that the FW can wait until after the DTIM and
@@ -998,8 +1007,10 @@ void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 	 * Since we want to use almost a whole dtim interval we would also
 	 * like the delay to be for 2-3 dtim intervals, in case there are
 	 * other time events with higher priority.
+	 * dtim_interval should never be 0, it can be 1 if we don't know it
+	 * (we haven't heard any beacon yet).
 	 */
-	if (vif->cfg.assoc) {
+	if (vif->cfg.assoc && !WARN_ON(!dtim_interval)) {
 		*delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
 		/* We cannot remain off-channel longer than the DTIM interval */
 		if (dtim_interval <= *duration_tu) {
-- 
2.43.0


