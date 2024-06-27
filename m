Return-Path: <linux-wireless+bounces-9652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAEF91A1D6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720431F217E2
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91141A94;
	Thu, 27 Jun 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Juj4jR7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64019819
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477988; cv=none; b=f/CO5NdCaV1nGJ9S7sRP0uvIbhNXdRPFMXwKiQWrYNXFZblvHfcXGG31gBL6XrHeX2xyVtM5bkOFfUclGvPbN/x9rR2P95ytSw9+O7wHzm+blWzw98Ex/inCTzv8KNGeqNM4TOITtgPFakcsPqUumKEfvdWUEaqWdiYKTqwDZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477988; c=relaxed/simple;
	bh=5FsEHgvZVuzUgnXuxDeKQOATB8qcggzPpt+L2/Oizdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=be3Kh2d65D5DXd4hjy4TJm2+NRtGhHVpz7OumyfwKK6d0A6Inxk1ySrlWII2UuCaYdsEZGhYyIR8xgbQm+NPjq2usD9ZO/Nw2RbOnJkfsd36TM90yxGeJg+b9r1AwKEF96FgiOLTm3uniiJJQ47a1BacJHnk9j2vQdrjVgQzjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Juj4jR7L; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Z1l9m0/birrRMoJwBkPXkFQ1mm9TH0fyVlEUeeG6Aeo=; t=1719477987; x=1720687587; 
	b=Juj4jR7LhcTFTC31/Ns/Eft5mHZCJ8BOL8W4l7AtR7VUHUNHXKlhb/fbU9ZQPTMS46XL3n/eblj
	N2SXXC9GlLAbvC6C6Zzef6C1O8AVKYjdMjpH45fZaY1uezui1vj63e9ZZu7r1feD9Pzqh7Rg2V9zT
	Q5ruA+fJTM0w2qSsdxH8XDAZFa7ev9BcAsDBl7KX/rYr3sjEgLGV/99J16yShIMPaV/y2det3Fc4Q
	0m9PaMPM10mGRGdocbviemZQFYv/hjS94x3a7y+4UomLeQBXMuSasTGlKSQPBT8n3PU5TvgYP340Q
	ulUzsk7qH1ocUeq4P44733yn2oyFrMLWkOUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMklr-00000006bAW-2lJ5;
	Thu, 27 Jun 2024 10:46:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211_hwsim: fix kernel-doc
Date: Thu, 27 Jun 2024 10:46:22 +0200
Message-ID: <20240627104621.3b2dd62adb2c.I8a4c469b674e5eac737378a1ed2358b57d01613f@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some kernel-doc in the header file was mismatched, fix that.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index 21b1afd83dc1..28c1db482e79 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -257,7 +257,7 @@ enum hwsim_tx_rate_flags {
 };
 
 /**
- * struct hwsim_tx_rate - rate selection/status
+ * struct hwsim_tx_rate_flag - rate selection/status
  *
  * @idx: rate index to attempt to send with
  * @flags: the rate flags according to &enum hwsim_tx_rate_flags
@@ -295,7 +295,7 @@ enum hwsim_vqs {
 };
 
 /**
- * enum hwsim_rate_info -- bitrate information.
+ * enum hwsim_rate_info_attributes - bitrate information.
  *
  * Information about a receiving or transmitting bitrate
  * that can be mapped to struct rate_info
-- 
2.45.2


