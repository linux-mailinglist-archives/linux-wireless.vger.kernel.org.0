Return-Path: <linux-wireless+bounces-4162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBD86AA96
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8486C1F24FD8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193536136;
	Wed, 28 Feb 2024 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CC3iAzJu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28136103
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110650; cv=none; b=RzGvLfmpx4ZjwR9PvF4o0aXUikWGE4yVqSh4h+TgsMHkrQ0CC+6xlSxAc1ij94vYJPvgj93fI9OCezwxp+md1DZ/E5vBMtUtnS5sg4Z1+UZvHa9qbezORmar+NRadeXZxIM2vQDIb8wInmTuYgMpE6OrQk2v9+yG9GyeQajhHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110650; c=relaxed/simple;
	bh=r7UGfWCcvYvR6Cjokm5UalBHfJnWo+6rlLLoR2GqsPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPcwvFEgqml+5OG27JQbLClqZ6sg2sPr9QziqqvirNrB+wbLaqFfET/gcISQDRcqSE8+vX8WxQM3/vWBnHYgGIgb8bEPaW8J5uMSymZmkCl0ChZU9Z7Yu330Tv/ZUUbB4OKRX7gr5CpQMf0isPitKCvG/XCktYkuZGB8Nbd36vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CC3iAzJu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SJwlyrqBNk2cmNjjnNKUT3Ao3z2tiQ2mPcJUTde19fk=;
	t=1709110649; x=1710320249; b=CC3iAzJuY1zoAOzy+2lSrfucysk7PyFzwVEfKIOTC/Ghi6n
	KAhGLsFRtsCO8KAPvY6rCTg0QnPJ8bFEEajMSd2OSo5u+R9hmb67Typ064U6UNvrzuGW1W77SvC6M
	4xtiBpSHOZGLw6mnkevIVbGABt3lNE5TTX6G0205x0fSusoy3iUBT4ohdLi//ZFm/rvChvsOrbKVr
	OR3mmP02Ui7zpnOaW7swft3nEbrS5wQbJBe+kM3nMNDdH7lMQUEeH2gdCWkiWYfs5NE0jq+1FgJqo
	QyWkOdcKMWU131lOPscsnQHrxIGBm87y8l6Q8wvD3uduZF3yloaxjap0sV2mp88A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkk-0000000C0hJ-2XWu;
	Wed, 28 Feb 2024 09:57:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 8/8] wifi: mac80211: remove TDLS peers on link deactivation
Date: Wed, 28 Feb 2024 09:55:48 +0100
Message-ID: <20240228095719.a7dd812c37bf.I3474dbde79e9e7a539d47f6f81f32e6c3e459080@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If a link is deactivated, we really cannot sustain any
TDLS connections on that link any more. With the API
now changed, fix this issue and remove TDLS connections.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 87a413374ece..685ec66b4264 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -356,7 +356,7 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
 
-		/* FIXME: kill TDLS connections on the link */
+		ieee80211_teardown_tdls_peers(link);
 
 		ieee80211_link_release_channel(link);
 	}
-- 
2.43.2


