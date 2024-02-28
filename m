Return-Path: <linux-wireless+bounces-4151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308B86AA6C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ADC1F243CE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD733080;
	Wed, 28 Feb 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C9MSgolM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEF2E852
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110154; cv=none; b=VAlcbuVnwOJ8/9C9lHjMflCYuwSnuAHisMbrdNJeG3alVL/rbFI0CNdvXb8GULA9sUyK2O48Ll8EtqkhCgLeGAs5dqTR8DRTLhUtx/sEj6UoSGOjOgKn+4k1GBu2iVFuLilEnjeR65Ibm8rWXkE0FIPNT2UZb1yocOtFh5X/ZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110154; c=relaxed/simple;
	bh=6qsFQwGKR7PDtIFw/0jhbaNki1V6r/CkU0vKb0uBeBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMqYBMFguUzVCh8YgnC3+DIIg7c3BPrG30fVjOm2c4yFzZfORcVAn2aZBDnYCnR9rCx6uOZEccatjMIaHS5FuFVkFnM4I6WZInClRQmUT8CUAPIZaFzZE25+/pi/XV5uiikqMScoAu2XsW/MyPqo/pobAiFsDAolOZzW17evhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C9MSgolM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L/QMi87Nm5EYaVKhY/t/4j9baOhGOCRe35/W+r2riLU=;
	t=1709110152; x=1710319752; b=C9MSgolMsS/pFtgFyvgKzyGX6jhQo83taJbOkOuCDt/MdH7
	dJeNVjzmIVDa8wJwQTYXo3lODtW/w4huISLHtAqe/KSM27exjAzGZe0KiUrDE2aY1UZu8sDj27fWF
	xznoqn04wpQdGOblNw3yzrUYnR3daj9Nor/A41pIFJBDvg9MGY7ExijJuI6niyx1kJ8g6BraMZdQu
	ZwnKhelc0LRluUsto+9+r9Y3D+N3lwrovVLwIFtZMbmLh727OYmSZB+sY/OX0Gel2IPWPKKhy/xyo
	oDx8if5I2OKyp/geXlal7MRHITLmFtQkLcNT6xQViP/pwTCUjC6y3FWOJkLiCyHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFcj-0000000C0BC-2jEm;
	Wed, 28 Feb 2024 09:49:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 7/8] wifi: mac80211: remove unneeded scratch_len subtraction
Date: Wed, 28 Feb 2024 09:48:15 +0100
Message-ID: <20240228094902.44e07cfa9e63.I7a9758fb9bc6b726aac49804f2f05cd521bc4128@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084901.18661-10-johannes@sipsolutions.net>
References: <20240228084901.18661-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We're always using "scratch + len - pos", so we don't need
to subtract here to calculate the remaining length. Remove
the unnecessary subtraction.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 804323858977..73e52504ed97 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -862,7 +862,6 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 					      elems, params->bss,
 					      nontransmitted_profile);
 	elems->scratch_pos += nontransmitted_profile_len;
-	elems->scratch_len -= nontransmitted_profile_len;
 	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 					     nontransmitted_profile,
 					     nontransmitted_profile_len);
-- 
2.43.2


