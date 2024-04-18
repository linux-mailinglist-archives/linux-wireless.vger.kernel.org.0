Return-Path: <linux-wireless+bounces-6507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8AE8A9560
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E71FB21A7B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF215AADD;
	Thu, 18 Apr 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LIGL2uMz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D115AAB2
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430356; cv=none; b=sEnZzm9cB6cfuFBZzhvkqPlbY+EmQhmg7LWeufPCqP6rELdlu5Ocle1aPXu/+bGq0dCTu7ZooKNKmg+mN1kxymVIIjQm5iSw40q3KC7rWypXhVjpILbZXn1WkTd0xOhMwu2XjLwzbc5sxwybFqMGc6ARFv5BIk/K3lG1lOsFNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430356; c=relaxed/simple;
	bh=FZWjRDeZ7I3Jm48qImbEx1ZJtfTBKfdaZZR1Si5EMds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7pi5YrCusOybkC5qaB+Jit/DHHWbx08GTSFdf679bqM8tgMY4X5SVGs+DpQZJ7++3FzzSZc1zp0v5WOjUt1vdZTW7OOtLhgu8dOK9WPW4vfxN6sWLeJ7pwWf/Kyh7ZvdZvJio2LebTQAZu57QjvvGhS3c5mW9OUQFM4X9GpN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LIGL2uMz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QU2gUPFup3r6nTJn+Hbmd95Utnrgxk9QPq90kMGKeSk=;
	t=1713430353; x=1714639953; b=LIGL2uMzPmI7FafcJ3o0eDl4Kyq/gYZzcX4QPH1poQetZ/k
	d0Rbnv+UkLRa1NejMT1+crJm8ZkDN9WbPSSJppZCpEzfaadZbTUirpebVz3TqAee2pG5mObH0LANE
	+iDhEC/7q52vp7kXM/u5sGHt6F2hleF6ww2X8i9fD034uHi7mjVBNhu2wrWw6KUdMxgcDBWphGwa6
	9TzEywqSUtdjpcbc+oPy9Sa9tAdH+pimzyCexDv7MQvlsXO0buORbm58W/GlhySQ2NebNeuZcHoML
	YeGf+DMCQ4AnEBRDRiEhTgwO/qB6d1WVFGsdh0OzNPn1vFn0bHHsdY4UUTiVvn/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVI-0000000CIvO-3vD7;
	Thu, 18 Apr 2024 10:52:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 2/8] wifi: mac80211: mlme: re-parse with correct mode
Date: Thu, 18 Apr 2024 10:52:20 +0200
Message-ID: <20240418105220.5e0d1fcb5622.Ib0673e0bc90033fd6d387b6a5f107c040eb907cf@changeid>
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

When doing re-parsing in ieee80211_determine_chan_mode(),
the conn->mode is changed, and the whole point of doing
the parsing again was to parse as the downgraded mode.
However, that didn't actually work, because the setting
was copied before and never changed again. Fix that.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index db7128f6c901..98cb475a14c8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -616,7 +616,6 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		.from_ap = true,
 		.start = ies->data,
 		.len = ies->len,
-		.mode = conn->mode,
 	};
 	struct ieee802_11_elems *elems;
 	struct ieee80211_supported_band *sband;
@@ -625,6 +624,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	int ret;
 
 again:
+	parse_params.mode = conn->mode;
 	elems = ieee802_11_parse_elems_full(&parse_params);
 	if (!elems)
 		return ERR_PTR(-ENOMEM);
-- 
2.44.0


