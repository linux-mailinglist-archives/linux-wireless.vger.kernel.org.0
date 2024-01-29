Return-Path: <linux-wireless+bounces-2706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7923684130E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C882FB20B32
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF062E84D;
	Mon, 29 Jan 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="elBEVD1P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5D179AB
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555223; cv=none; b=OfII/FhLn44Sz0BwS0K+vPE4D9Vc1qLzIbfjqKFIU2+LavsjAjAPXe19dzqekWKTP2f8UCKe1rc+tj+mDLg9a0wa+mk4m6OoP2Vd3NB41IW23rOUxrmbr40HcsFmxoTLKI+f+sqt21hVK8TYNeyYRHMnSQ78kG1+dX0vRfQF2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555223; c=relaxed/simple;
	bh=uO0bYzXbD2aa4/QC2zjDM0j2kn2skueJHj3MYOGtwdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N73+7y0f803arBaJ/kyNO8bdb/jbbOwO+eVqjPbnwg1pw2h0wgu9nA9UROfYKTfcKTNBCJPQGwej9xc4qRGaLthRDm1lSmWSiWHDy2Ln6fUnloaFixBfCcQ+yQ4/4hkFk8uEcTSRGHQDBdYwwY/wkETxhGDgRdhA1hVC7Zxz80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=elBEVD1P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eduVrWKSGC3XcNydEmnEOl9Hjdyy0Cr/IM5nZpN62e0=;
	t=1706555222; x=1707764822; b=elBEVD1P7EsNm0VcH6ykxhuSKzTlF6UkwLo74875k2FigRZ
	MywoR6rgX0LfZdSwpF6hAPioTf0rf3LJcHtToLPsesslDZDHoy/iNg8HUjar+2NShrtqsDY407n5O
	WfCJ2spRe53eLapMVqIkH4CoH2jJ8nEPikpSQmzP6OZ/Ou/yqJpIdXzkNwtJnaZogl72zL+c1UEsC
	6NUGlJ4FTKhegVPtNcGbJuYX4IEola8gZgi3NCawZFNxVh7LyfFDSWX6B1SKcXsUqCU+MyuylXH0o
	drwk9nWGRu4JexFMneM+eHxF09VjeqWsZhDxWsbONVt82vm0ks8KX3QG5YIBXABQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWyA-000000050B1-3KUl;
	Mon, 29 Jan 2024 20:06:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: disallow basic multi-link element in per-STA profile
Date: Mon, 29 Jan 2024 20:06:54 +0100
Message-ID: <20240129200652.23f1e3b337f1.Idd2e43cdbfe3ba15b3e9b8aeb54c8115587177a0@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129200652.1a69f2a31ec7.I55b86561d64e7ef1504c73f6f2813c33030c8136@changeid>
References: <20240129200652.1a69f2a31ec7.I55b86561d64e7ef1504c73f6f2813c33030c8136@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There really shouldn't be a basic multi-link element in any
per-STA profile in an association response, it's not clear
what that would really mean. Refuse connecting in this case
since the AP isn't following the spec.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/mlme.c        | 3 ++-
 net/mac80211/util.c        | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f5fe659a1efd..e11297b4dc63 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1671,6 +1671,7 @@ enum ieee80211_elems_parse_error {
 	IEEE80211_PARSE_ERR_DUP_ELEM		= BIT(1),
 	IEEE80211_PARSE_ERR_BAD_ELEM_SIZE	= BIT(2),
 	IEEE80211_PARSE_ERR_UNEXPECTED_ELEM	= BIT(3),
+	IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC	= BIT(4),
 };
 
 /* Parsed Information Elements */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d5293e715558..f110566a496b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4303,7 +4303,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			link->u.mgd.bss_param_ch_cnt =
 				ieee80211_mle_get_bss_param_ch_cnt(elems->ml_basic);
 		}
-	} else if (!elems->prof ||
+	} else if (elems->parse_error & IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC ||
+		   !elems->prof ||
 		   !(elems->prof->control & prof_bss_param_ch_present)) {
 		ret = false;
 		goto out;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c1fa762f0cba..d85a9c5cde26 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1012,6 +1012,11 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
+				if (elems->ml_basic) {
+					elems->parse_error |=
+						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
+					break;
+				}
 				elems->ml_basic_elem = (void *)elem;
 				elems->ml_basic = data;
 				elems->ml_basic_len = len;
-- 
2.43.0


