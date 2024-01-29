Return-Path: <linux-wireless+bounces-2674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E36B84090F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1D1C22848
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9C1534E6;
	Mon, 29 Jan 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oXsbplN+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391C152DFE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540041; cv=none; b=F1m3BXKaQT9/0ChUZGn64drEmS5nllth7tVWi5i0nQRn9cjP+Qbo0DWmfsjl0rizQKSsiSaBwwkL+9VoddVpu/Md4ofNRMOImwXc23ZIL61vLoyDfkl6m+7cNKgQoSSaQ7sRykdEuHE6Mu0V6xrIWVXmPo7KL7KqQ44IHPNZ+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540041; c=relaxed/simple;
	bh=d5c1VRniPh4A9jfhAwhGkNcMlX1FllSlEWfc7NsDhaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWRlMmIMbzXXfpftqeRHL6pWluHUr0Wy73H0ucz/fVfwIygx53j9ANnanzPaw5rEtfnD5G+3G474zXAF7A5OLiESCM2qmQvjJyUwlb479ENY0337ZX0qq+2dg7sBy6jF0Ucj7qyv6MT2DaPutq5mhr+tE7oGtKTRkHhr1J1KHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oXsbplN+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=mqz9hLBz81iSEMqEuKPudljkR2rtEieZcHN3QJALTMw=; t=1706540039; x=1707749639; 
	b=oXsbplN+c/nmvvSsVljXCL/9Xs5BM6WRC1FCNuayx+I5nw0nb510CNN4K19UoPZp8Yi/wxnh3OA
	zaG2a56VaO4BRHBtkZd6EFpaCtrekVYdGrGhpuvQipZ+BaXOtB+urv17q1KN51mcgSaC73WGIPvx6
	7gUtDT7kwjndcj9Ca3/UOXqLvLYsME4TfF3QInpH1Pc8KadOtb8ENarVcGPZc7rUnjjDV/jL5+N8f
	v/5IQcxqlsjW5261gik5vnZBq+WDClxf3LoeyDgeuLBOVI71h96jHzBTvocZsmDtshH0fDOKXezaL
	dSjUx6jVJtuW79MQRxzBHfnnGn7d/Rr3qaqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUT1I-00000004tM2-2aF3;
	Mon, 29 Jan 2024 15:53:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: set station RX-NSS on reconfig
Date: Mon, 29 Jan 2024 15:53:55 +0100
Message-ID: <20240129155354.98f148a3d654.I193a02155f557ea54dc9d0232da66cf96734119a@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a station is added/reconfigured by userspace, e.g. a TDLS
peer or a SoftAP client STA, rx_nss is currently not always set,
so that it might be left zero. Set it up properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 489dd97f5172..321698012e12 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1869,6 +1869,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
+	ieee80211_sta_set_rx_nss(link_sta);
+
 	return ret;
 }
 
-- 
2.43.0


