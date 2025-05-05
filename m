Return-Path: <linux-wireless+bounces-22494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A1AAA25B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA06E18851A0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641812DA0EE;
	Mon,  5 May 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdbtgOm6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A0280A32;
	Mon,  5 May 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483682; cv=none; b=LIZ2VXJkGHUOHPYoWDATBlmgjN/OFCDPQdI0A/0l4fGQSruir+I74rS1eeXpUKMbzGRchbugKoITsv7NPIsbUWZe/9ZXTbbSlR1TBCyt6w7F27TeT6/wYZGa6NojM51eMLTfx8VxhjPfVsvyReryl5ScVuOREniYesijYEpKjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483682; c=relaxed/simple;
	bh=pmMmIMX15bASaqVeXuuJA4NxP6y6CTdqjkUf1uyftM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSOo7VUYUd1LgYXH+fDTweHjEfiIz7V8p5sbnJVib38C11SAKat4UPv0bH/o/F/mvQ9oQ9IqLDxYbsvnzxkfkjVWLv2dcqPAswBSiPUX5+/w7KgtSYiHjA882qHRql7i8TfoCfSkFV/3orZSS3ojPDT6/ldyJTZsn/aZ1Wp7GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdbtgOm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A7CC4CEED;
	Mon,  5 May 2025 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483681;
	bh=pmMmIMX15bASaqVeXuuJA4NxP6y6CTdqjkUf1uyftM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdbtgOm6afnK1If2/Ey5M+omwY8fBZ7Ze+YhIvPjd99esKWE4IrBK97rTCeg/xP7O
	 YmQAt4+BR7DFnkAsjC/o4E/em5NeQ5ISYjqsDyRXy/XEiguHDVy1bSFw6hzb61b7vU
	 R79evPKANLPkr08TuZCekwjfQFnofovLOwuw1ZiRF1bRa1qcDl1Xhu14U6CR8ZaIfC
	 +EqVUT8XsjEnrOnCRUDvGB5bQJXWxz8csjqNIh/diwiyeua2JqCRELXjuRVSZRFJCo
	 2T0h4Z85A10t9l1fJ+lqyhQXqCB2PrygyZZU9wRSYzCXwjPruqMkVxG2C8aOEPSUjc
	 5AyYrY9j0HKXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@treblig.org,
	ilan.peer@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 177/642] wifi: iwlwifi: mvm: fix setting the TK when associated
Date: Mon,  5 May 2025 18:06:33 -0400
Message-Id: <20250505221419.2672473-177-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 3ad61970ac9e164be1b09b46c01aa942e8966132 ]

When running secured ranging and the initiator is associated with
the responder, the TK was not set in the range request command.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231427.603dc31579d9.Icd19d797e56483c08dd22c55b96fee481c4d2f3d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index b26141c30c61c..0a96c26e741b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -773,7 +773,11 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 			target.bssid = bssid;
 			target.cipher = cipher;
+			target.tk = NULL;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
+
+			if (!WARN_ON(!target.tk))
+				memcpy(tk, target.tk, TK_11AZ_LEN);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
 		}
-- 
2.39.5


