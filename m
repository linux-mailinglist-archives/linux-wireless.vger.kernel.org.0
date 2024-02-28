Return-Path: <linux-wireless+bounces-4145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C686AA66
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492851C21797
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF232D608;
	Wed, 28 Feb 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CngXkI+2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F92D03C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110149; cv=none; b=K+bbCVG/ZoeAP5BjlLEQkQ5Uxb6jLHI41KDBfWX1GeALA1o8JxwSkV1zguV6qEHUsInBVeYywgTmQzx9ARkoMSOFzPBdjtwgbqaU3COMHxu5BSDnwSn70UoBBoAYAb/YkFFZ9Sn50gogvAoZ7PQrT1R3M7/Ixuo5uNKglFUnWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110149; c=relaxed/simple;
	bh=5KKFBh1tF2E4tKXxGF/UOVMJYzRymGqFBgy5BlghBAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecFYyWNgEshJ9fv80PrqKRu+yAAzr6kgz+8uMcDBjvKqh0SlgNTec1lGEjTHX+YyYfn15SaqHQO//F/X5ntVShAXLdaGkI85vGRaDWd0bc1fee3Y+hwxiBVQ/msCwceIdtYr1EnbMACMvZIyxq0gbVERsFRIeIs0DtHOMwzGJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CngXkI+2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H+XwrbdiD4rnC/9MUfRE3p0qdR70VLvZQpYrE5v3SSo=;
	t=1709110148; x=1710319748; b=CngXkI+2Ewr0LQH6e5SZhuQzRUlRj/lAUnlOwmd6g+RTPLT
	yEdFsbMN2w6g06ast0c850ia2OZpx2sAqvHKiZwEJcQLQJCDZmK1nIwTPxwUza12RWbcBEArGl6n8
	XH+5MgYuBMeEJJyiq1xvMCjodh0q6ENjHT4BFfkYcGx/gj0e4U4Sg4JHbdCzp9tpKXZRyouNTEjuD
	qWNV64qCBF7jtsbw0eOD/QmAdpmS06MgjlpJw84r3Xuz4gvnkWB9WQ9iCe1y2gUG6H3RiouMe9vh2
	/a0FqEersaAtd+9XADWG8wYcrMZI05Hmdu269pCSOquL8lYW8OMPxZC/BIlLNi5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFcf-0000000C0BC-0m26;
	Wed, 28 Feb 2024 09:49:05 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/8] wifi: mac80211: update scratch_pos after defrag
Date: Wed, 28 Feb 2024 09:48:09 +0100
Message-ID: <20240228094901.9da35f39eeb7.I7127f2918ec4cba416fcbc35eacaea10262c1268@changeid>
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

The scratch_pos update here was lost after defrag, so any
other uses of the scratch buffer might overwrite it.

Fixes: a286de1aa38f ("wifi: mac80211: Rename multi_link")
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 196a882e4c19..233c761823d3 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -800,6 +800,7 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 
 	elems->ml_basic = (const void *)elems->scratch_pos;
 	elems->ml_basic_len = ml_len;
+	elems->scratch_pos += ml_len;
 
 	ieee80211_mle_get_sta_prof(elems, params->link_id);
 	prof = elems->prof;
-- 
2.43.2


