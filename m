Return-Path: <linux-wireless+bounces-6511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D671A8A9563
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CFD1C20D73
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8015AADA;
	Thu, 18 Apr 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s8rm0Rce"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C615AACA
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430358; cv=none; b=i3d8KlBJXGuEWDLHKkPpS+FwTAvTNSurceV75PMv3XsXsP7PYOAFOiSpBV3lF5RwBls6Z4S2XUnLlbiwgcxZLJX1ttb+AETkXal4lE11lhBCOsvctzW5sNsU74VyBpgCok2l/wCBXPR9QAIx/cyc8BI+eUXa/hUhCcfvvLnM5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430358; c=relaxed/simple;
	bh=vAWkDa5jUKiMHqZBlTNC345dG2WBtzYy1qkZ4fVFJNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giSfr/zBCmI6jKzHsd5hbBycoQ7ecSV09p24J8lG53K9o+8rIBhxH0acJfV+pBJ0F9soN1xI+sInHxBzw5rHkHGJRr2Nz/mc6NAqFlpFeiXoCqeetf0BRC2XKi9hD7haRSZjLnO15K1nEEpkOxtrGpctlzK5Y36GA4lmKhbOQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s8rm0Rce; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D/u2jsp8cLgU+425jsad0NTt3fx7STSVK2rsPR3RWgg=;
	t=1713430355; x=1714639955; b=s8rm0Rce3ZsdTaCdVvcKCEFmm7DZPSyeD6R800jKDlVCqBn
	J0syopx67ngLhrBYeRv9m9GSHxcMtchksgD6DZDO3EiiPC9Dc79Su4yrZyE+dvujr9pKFE32+Jo8I
	AoZQ+x+JVMV/7+Zbwa7TDteTKJraSkb3ImkO2GZkLMV47+idP9GMztLzxLsUo/Q8UnpORB7gF6ZEy
	PLyIFsnCJgHBhWjB9XMoXgd/KjUrS8FUnaQvem5R6bung/Y4nE6Q1qFhC56SVT9EoRdkVwYOMh154
	DB4fTubOQUkAAKqJRLNCeybFWZHvaV/YJIFAxKCgQw6YKJbzPMhzsUI4vHUmOvjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVL-0000000CIvO-2i90;
	Thu, 18 Apr 2024 10:52:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 6/8] wifi: mac80211_hwsim: init peer measurement result
Date: Thu, 18 Apr 2024 10:52:24 +0200
Message-ID: <20240418105220.e1317621c1f9.If7dd447de24d7493d133284db5e9e482e4e299f8@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
References: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we don't get all the values here, we might pass them to
cfg80211 uninitialized. Fix that, even if the input might
then not make much sense.

Fixes: 2af3b2a631b1 ("mac80211_hwsim: add PMSR report support via virtio")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b55fe320633c..59e1fc0018df 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3899,7 +3899,7 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	}
 
 	nla_for_each_nested(peer, peers, rem) {
-		struct cfg80211_pmsr_result result;
+		struct cfg80211_pmsr_result result = {};
 
 		err = mac80211_hwsim_parse_pmsr_result(peer, &result, info);
 		if (err)
-- 
2.44.0


