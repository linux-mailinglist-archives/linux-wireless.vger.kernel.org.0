Return-Path: <linux-wireless+bounces-13-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8487F6903
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB6DB21385
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B514C3A6;
	Thu, 23 Nov 2023 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SAhTNLHJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB1D64
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ITJCzxR8J+1dD23bAsKOSvc66aUksZiFuwJM352tX+E=;
	t=1700778480; x=1701988080; b=SAhTNLHJ1oFdreRDZFL/VXJg/54YiArD1zFKJdCf1xrlEFM
	pmXp4kC6ZolR8/gLFc5eI9XAWeCsS9azfzM862D6SdVNIagZno4jN0PpeKjMJvj4wNs/U1ugDag7L
	c8jzbuRbMm0h7bWga3TbI8nVFVwm2hwUjqWyAQ9fK3kmJ3JU2oK57z3tVCdjoLlouHYPWSbtDOWtl
	hjpciaFAPxQE7y/e0CZuMhkgjn2dnHFl62PffHP7saDfHi21Eekeu3AcObdJuv2VJJHueVJswofh4
	sM5gmYEnh8onEBs/DKlQSuK+FCHdJsqvgjxmNl5hBpjUFfzgqBiNgEZiv+0toYqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAv-00000001Y53-48mx;
	Thu, 23 Nov 2023 23:27:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 08/13] wifi: mac80211: workaround for tests that drop capabilities during CSA
Date: Thu, 23 Nov 2023 23:14:45 +0100
Message-ID: <20231123231436.af4c46e01358.I4d433a27e206996acd79b59e4d3e0c84d33ad9cb@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are some tests that for some reason drop HT (and higher)
capability/operation elements during CSA, which leads to the
code now disconnecting. The affected tests are:
 - ap_csa_1_switch
 - ap_csa_2_switches
 - ap_csa_ecsa_only
 - ap_vht80_csa
 - ap_vht_csa_vht40_disable
 - he80_csa
 - ocv_sa_query_csa
 - ocv_sa_query_csa_no_resp

Work around such APs, but I actually don't think we really
should be doing that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fdcdba2b2c9e..aa1b07c0548a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -919,9 +919,10 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 					      elems, true, &link->u.mgd.conn,
 					      &ap_chandef);
 
-	if (ap_mode != link->u.mgd.conn.mode) {
+	/* W/A for some tests, make that == again? */
+	if (ap_mode > link->u.mgd.conn.mode) {
 		link_info(link,
-			  "AP appears to change mode (expected %s, found %s), disconnect\n",
+			  "AP appears to change mode (expected at most %s, got %s), disconnect\n",
 			  ieee80211_conn_mode_str(link->u.mgd.conn.mode),
 			  ieee80211_conn_mode_str(ap_mode));
 		return -EINVAL;
@@ -953,6 +954,11 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	if (cfg80211_chandef_identical(&ap_chandef, &link->conf->chandef))
 		return 0;
 
+	/* W/A for some tests - remove it again? */
+	if (ap_chandef.width == NL80211_CHAN_WIDTH_20_NOHT &&
+	    link->u.mgd.conn.mode > IEEE80211_CONN_MODE_LEGACY)
+		ap_chandef.width = NL80211_CHAN_WIDTH_20;
+
 	link_info(link,
 		  "AP %pM changed bandwidth, new config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
 		  link->u.mgd.bssid, ap_chandef.chan->center_freq,
-- 
2.42.0


