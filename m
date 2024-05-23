Return-Path: <linux-wireless+bounces-7995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FE8CCFEB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CA6B21A8F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49613CF96;
	Thu, 23 May 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n4kX0asJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202054FA9;
	Thu, 23 May 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458740; cv=none; b=rE47nz78UqhS8wNX1mzIKOpj93UldfPZHUHNBiB90xBhWRpthBGPwVShH5RVa3Cx54AO3X3SwRZtMgNW9JFO9hAJW8GCKZmGttIIBAc/jFu2kgzDBSt2IR0k1pHzTQu7fqhkgcRoDXjZMCbfWRzUysWj8h2VCI/dE0DqJrrzwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458740; c=relaxed/simple;
	bh=p93URBzyg0Jvf6+HXExvml57wxsAqkDZrQy+YNck1Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHkgHx97x998Mq09B3BI3vboO3ELgsSxFl7zxLI4HQc3UFvVC1c7fitDAjHDR0ZJegwANRe3z5roYcJC+LyFhyWdhtq19CbrIQl7LpLnXvPtgQoc6WK3AgJv39XPFl4xC7yA0ZLMP2okL82LgRwJId+8Lvbevhjz+PXOoeOeRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n4kX0asJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+P/eQDosxBeUaoWDIKIA4+eNBAo+H3Pt2ohS5winJn8=; t=1716458738; x=1717668338; 
	b=n4kX0asJ5VHK/o8xyt0yA1fzqiM6IAnp7el2LsnMgqGEBIKf1vXGvd9FytHMoavJurUX/RP8hjD
	AAZHQsLISk7ZWObjysxw3wl1P+guQrvAi4WlwaHCjDLLFCCdvv7Df/+olxHAJLtd9agwfj03It5GT
	wpQfW1uDyQpEk44lTNC0LMWRTuS0NbwfmqnHRXCmFT/x0TPEVqcu5FFortgMgubn96F6g+qzYZmDO
	wd9WHBR2eulKz0lLVVGwbPGpXsjH70W07NCUDge5v86w/muTF1Et6iRuGs0ddu5x51RfGl3bNM6Rk
	PHN42XIbAaMhnoPJA2D36iQbFoqJFpkuLTYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5KJ-00000005wQq-1GL5;
	Thu, 23 May 2024 12:05:35 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: cfg80211: validate HE operation element parsing
Date: Thu, 23 May 2024 12:05:33 +0200
Message-ID: <20240523120533.677025eb4a92.I44c091029ef113c294e8fe8b9bf871bf5dbeeb27@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Validate that the HE operation element has the correct
length before parsing it.

Cc: stable@vger.kernel.org
Fixes: 645f3d85129d ("wifi: cfg80211: handle UHB AP and STA power type")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 127853877a0a..8daed8232b05 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2128,7 +2128,8 @@ static bool cfg80211_6ghz_power_type_valid(const u8 *ie, size_t ielen,
 	struct ieee80211_he_operation *he_oper;
 
 	tmp = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie, ielen);
-	if (tmp && tmp->datalen >= sizeof(*he_oper) + 1) {
+	if (tmp && tmp->datalen >= sizeof(*he_oper) + 1 &&
+	    tmp->datalen >= ieee80211_he_oper_size(tmp->data + 1)) {
 		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 
 		he_oper = (void *)&tmp->data[1];
-- 
2.45.1


