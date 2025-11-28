Return-Path: <linux-wireless+bounces-29406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE88C924BC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1480D34F8D2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4572330B24;
	Fri, 28 Nov 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PBPaXhO1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E38264A77
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339670; cv=none; b=QP8y9xsRfJmAzLf1I03F2GPNd95ycs2VfuQ0VsL6aNNPesp6dVuQl8D7/SLAntaa7fXB2YjhacMftR3oxN5PhFnUPtIOFVDDPRRKuMGyAtrYwseqIOfNn6kBEgUKsJ+TYLHr1bdcYrDPVevpCJHHo2z12bABULkZiRbhBM37oEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339670; c=relaxed/simple;
	bh=VPHhI4dqfs7pqLlSE669NbdKRicoWT7NgHfCd8a+RTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njVRl2UHfoKYngyoA4uXnPc8TghmL80LlQIfLdO+hoSUtc/5sNNTFrSmNCoR0UFzIwrFMl9KGEez1GJfDOWRIpaB/pOYbabqn9+7xu/apt4dchezcH0AdHn02rMO68QU6zVS3Qt8ylj0WxdC/DfN5C/4weBSJgNXc1NX3UmuOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PBPaXhO1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CNO3nsiRItTI53ijCtxMlKr0Xqx48OFYyH+3Vl3Cqo8=;
	t=1764339669; x=1765549269; b=PBPaXhO1Dpcf/RNGqwPelV+5OewoGcliUwIn+LTtIB0EqpS
	KAehAl41uxkte/bSwVRIWNcsnEBZhRvDDr+5to3Jhbca2NqkAgOjjLchZLKM3Bb9vwJ6U/KvcBRbf
	RJb/VQVtdILXwgILDUMa6uKZ8RvpC0G78ala1vi9XOP2UTpLutK977FYqxoycmO5LruVmdZjYoGnY
	O03x+9xRO400SkYyb7GosX5dZ63pPrkFwYSq5joO3mG9BiVYTzqkB8O0QvWGbMJ+y8mlctjKpGXQ6
	nrtrimX1u0pHT9BpfxhyJqgti/pBUneg7b/ltBZJSOzCKYjd0dZVQAL3VITNQTVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLF-00000003926-1qAb;
	Fri, 28 Nov 2025 15:20:57 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 02/18] wifi: mac80211_hwsim: disable BHs for hwsim_radio_lock
Date: Fri, 28 Nov 2025 15:15:40 +0100
Message-ID: <20251128151537.0b4006217137.I688f8b19346e94c1f8de0cdadde072054d4b861c@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The hwsim_radio_lock spinlock expects bottom-half to be disabled, fix
the call in mac80211_hwsim_nan_stop to ensure BHs are disabled.

Fixes: a37a6f54439b ("wifi: mac80211_hwsim: Add simulation support for NAN device")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 92427f527286..79cc63272134 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4112,14 +4112,14 @@ static int mac80211_hwsim_stop_nan(struct ieee80211_hw *hw,
 	hrtimer_cancel(&data->nan_timer);
 	data->nan_device_vif = NULL;
 
-	spin_lock(&hwsim_radio_lock);
+	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry(data2, &hwsim_radios, list) {
 		if (data2->nan_device_vif) {
 			nan_cluster_running = true;
 			break;
 		}
 	}
-	spin_unlock(&hwsim_radio_lock);
+	spin_unlock_bh(&hwsim_radio_lock);
 
 	if (!nan_cluster_running)
 		memset(hwsim_nan_cluster_id, 0, ETH_ALEN);
-- 
2.51.1


