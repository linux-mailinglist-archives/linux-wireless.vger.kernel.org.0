Return-Path: <linux-wireless+bounces-20866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BAA72727
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D80175F2F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B901A5B9C;
	Wed, 26 Mar 2025 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaM9/i9i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A619644B;
	Wed, 26 Mar 2025 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032439; cv=none; b=bRpRNkDdmHRsTknVXgQK9hRNwBUabi/J5vPFASVchFoUr/weJAgt0sX5MLcMzddUMVtpUsFXMit7STgWuI6db3LV7CRxG3q1pJ8J/BRuR6k31ZcUGTSOlhngFX0zSqE4gmBd0wFJezt5sglDqZ9Piq8JuaglfYSC0h4VRhCqXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032439; c=relaxed/simple;
	bh=hcNqv06EziM4XfUMLDoHZkf+3cGNbhPk/8HQFmo+Mxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tuMzcWdysR795iNQo6grX23Iiq1ETc0w5GfjR3fonyTYfxjTSbD9G+p1grnAVU8gBQx6RADnkB8S9qVMclWuzQIyPoffvG+J/jXolvCNGogA74ZtUXfM0wW6ru5qFq41BegDeosfRoY/5Ki13uT7veaCFCFIWKHibaaDOeMZO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaM9/i9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB38C4CEE5;
	Wed, 26 Mar 2025 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743032438;
	bh=hcNqv06EziM4XfUMLDoHZkf+3cGNbhPk/8HQFmo+Mxs=;
	h=Date:From:To:Cc:Subject:From;
	b=qaM9/i9i3HfKRZ81MSwAHYXWrQpN32fdqqeZ0t1IYVP/8DwmSmoW7apf6hv0QnciW
	 DDNuhDUVkJeAvjZk914x8MBMBAQMYFf6p+sm/UJKCt8mJ33g2vRwSsHupVvGXX0Pd7
	 xgFclLo+qH1ivWEia2nZ4nkMfd8HbwkXVdE1PUMMl8SlTrnHGHJDfyP3qajqWtqzpW
	 iP+mVrbmRUVEvqvTCc9nzGdtTY5yEZBVCmD4hrAKbJSdOgKOdHoeFvbRh5IU5igoBA
	 YnER1of/BFj+NMi+POiYdu6uUutw30HOZEiQR6vKMx4uQWH/rVgD51kHGaSjkubYcV
	 UKjgJYctjUJeQ==
Date: Wed, 26 Mar 2025 17:40:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mac80211: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <Z-SQdHZljwAgIlp9@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warnings:

net/mac80211/spectmgmt.c:151:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/mac80211/spectmgmt.c:155:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/mac80211/spectmgmt.c | 55 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index c6015cd00372..7422888d3640 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -147,14 +147,14 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	u32 control_freq, center_freq1, center_freq2;
 	enum nl80211_chan_width chan_width;
-	struct {
-		struct ieee80211_he_operation _oper;
-		struct ieee80211_he_6ghz_oper _6ghz_oper;
-	} __packed he;
-	struct {
-		struct ieee80211_eht_operation _oper;
-		struct ieee80211_eht_operation_info _oper_info;
-	} __packed eht;
+	DEFINE_RAW_FLEX(struct ieee80211_he_operation, he, optional,
+			sizeof(struct ieee80211_he_6ghz_oper));
+	struct ieee80211_he_6ghz_oper *_6ghz_oper =
+				(struct ieee80211_he_6ghz_oper *)he->optional;
+	DEFINE_RAW_FLEX(struct ieee80211_eht_operation, eht, optional,
+			sizeof(struct ieee80211_eht_operation_info));
+	struct ieee80211_eht_operation_info *_oper_info =
+			(struct ieee80211_eht_operation_info *)eht->optional;
 	const struct ieee80211_eht_operation *eht_oper;
 
 	if (conn->mode < IEEE80211_CONN_MODE_HE) {
@@ -167,38 +167,38 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
 	center_freq2 = chandef->center_freq2;
 	chan_width = chandef->width;
 
-	he._oper.he_oper_params =
+	he->he_oper_params =
 		le32_encode_bits(1, IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
-	he._6ghz_oper.primary =
+	_6ghz_oper->primary =
 		ieee80211_frequency_to_channel(control_freq);
-	he._6ghz_oper.ccfs0 = ieee80211_frequency_to_channel(center_freq1);
-	he._6ghz_oper.ccfs1 = center_freq2 ?
+	_6ghz_oper->ccfs0 = ieee80211_frequency_to_channel(center_freq1);
+	_6ghz_oper->ccfs1 = center_freq2 ?
 		ieee80211_frequency_to_channel(center_freq2) : 0;
 
 	switch (chan_width) {
 	case NL80211_CHAN_WIDTH_320:
-		he._6ghz_oper.ccfs1 = he._6ghz_oper.ccfs0;
-		he._6ghz_oper.ccfs0 += control_freq < center_freq1 ? -16 : 16;
-		he._6ghz_oper.control = IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
+		_6ghz_oper->ccfs1 = _6ghz_oper->ccfs0;
+		_6ghz_oper->ccfs0 += control_freq < center_freq1 ? -16 : 16;
+		_6ghz_oper->control = IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
 		break;
 	case NL80211_CHAN_WIDTH_160:
-		he._6ghz_oper.ccfs1 = he._6ghz_oper.ccfs0;
-		he._6ghz_oper.ccfs0 += control_freq < center_freq1 ? -8 : 8;
+		_6ghz_oper->ccfs1 = _6ghz_oper->ccfs0;
+		_6ghz_oper->ccfs0 += control_freq < center_freq1 ? -8 : 8;
 		fallthrough;
 	case NL80211_CHAN_WIDTH_80P80:
-		he._6ghz_oper.control =
+		_6ghz_oper->control =
 			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
 		break;
 	case NL80211_CHAN_WIDTH_80:
-		he._6ghz_oper.control =
+		_6ghz_oper->control =
 			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ;
 		break;
 	case NL80211_CHAN_WIDTH_40:
-		he._6ghz_oper.control =
+		_6ghz_oper->control =
 			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ;
 		break;
 	default:
-		he._6ghz_oper.control =
+		_6ghz_oper->control =
 			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ;
 		break;
 	}
@@ -206,15 +206,14 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
 	if (conn->mode < IEEE80211_CONN_MODE_EHT) {
 		eht_oper = NULL;
 	} else {
-		eht._oper.params = IEEE80211_EHT_OPER_INFO_PRESENT;
-		eht._oper_info.control = he._6ghz_oper.control;
-		eht._oper_info.ccfs0 = he._6ghz_oper.ccfs0;
-		eht._oper_info.ccfs1 = he._6ghz_oper.ccfs1;
-		eht_oper = &eht._oper;
+		eht->params = IEEE80211_EHT_OPER_INFO_PRESENT;
+		_oper_info->control = _6ghz_oper->control;
+		_oper_info->ccfs0 = _6ghz_oper->ccfs0;
+		_oper_info->ccfs1 = _6ghz_oper->ccfs1;
+		eht_oper = eht;
 	}
 
-	if (!ieee80211_chandef_he_6ghz_oper(local, &he._oper,
-					    eht_oper, chandef))
+	if (!ieee80211_chandef_he_6ghz_oper(local, he, eht_oper, chandef))
 		chandef->chan = NULL;
 }
 
-- 
2.43.0


