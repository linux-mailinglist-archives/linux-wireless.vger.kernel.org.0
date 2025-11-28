Return-Path: <linux-wireless+bounces-29401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D6C924B9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0E19350EDE
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56D262815;
	Fri, 28 Nov 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V9pg/mOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1333032B
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339668; cv=none; b=bsujl+d6l25QBNvvJDLKGg4NL8+C80uVo6kxaagH0UZyIsKlzFZKNJicwcCAOVnqDH8lhRtnBKXwNSjWXNMQiBzz5FAa1r1sU7Ztzayy2cakxgekipirR+0Vo9RFidwh+b5hoA2IdsaklCgrYqpPJyDyCX//kOFcZ4mNGJV0PJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339668; c=relaxed/simple;
	bh=746Zq7gVkANx6MkpL3g9CQw8S7WqSKO7/Dqbuhsh5rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvGQPZivsYdN6JRb84e8zdYsj082pWAs05rXPBv+kTQHjQwdH7ZvBPSqP7FThStePI5yOmfoh4JZy2VYEGbd5ku5vJraorxbSNPV9jcM6xbxsK1Oy4Ai/gwns3LpuIENfZxQeUqFMnf0z9uhlcIb4LfnkOsN7mYA8rlVfSPZzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V9pg/mOK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HWngYy5Bs7h8JJ1xJSubC5BxccBnPALClg9pge4gx1w=;
	t=1764339666; x=1765549266; b=V9pg/mOKQdUcBuEZC3ZmDXQEk5OFa3cLZCXlNuYuXGJ+ZOp
	MICOfZZsOeAmbEGIjeA22sE0wwxKZr8OnXlzLcwDNV70OAE9WGtpJjHbOlbuZ4s8wAcBHwB6vB2xl
	CKc2QUvxuEBAbC7rkOUqyX6/Zc4JWBaXDbqPlNpL0ayVkvo7RpOPXSoDrNc9yX3eDDmXJS5xZgqPP
	SooTlCPdi9RlR6o3XwwFFwibUEINX1micW3NRZJYeNBVicWjcwKYFzy5BGoT3W5lU5rCNxgigUR4s
	fNvNRkzYCj5kYVorrVHyJs+dl6TDKkqO27hSk/OAd4lV0ezJzFGtC9QUNXCA039Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLI-00000003926-3IxL;
	Fri, 28 Nov 2025 15:21:01 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 03/18] wifi: mac80211_hwsim: remove unused nan_vif struct member
Date: Fri, 28 Nov 2025 15:15:41 +0100
Message-ID: <20251128151537.67fdaf6e0ee3.I35d3eae582461af7ee25c63c56b13adff17cf20f@changeid>
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

The struct also contains nan_device_vif and that is the member that is
being used.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 79cc63272134..dc0ef30f96b1 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -760,7 +760,6 @@ struct mac80211_hwsim_data {
 	enum nl80211_band nan_curr_dw_band;
 	struct hrtimer nan_timer;
 	bool notify_dw;
-	struct ieee80211_vif *nan_vif;
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
-- 
2.51.1


