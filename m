Return-Path: <linux-wireless+bounces-19257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134BFA3F1EF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 11:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461B5165A8B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8D205506;
	Fri, 21 Feb 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NBA09sM1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B331EE7BC
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133505; cv=none; b=VSdHKtFe/KV/1I9LCuL8pmZk3Kw5UbeEMTpOrS/FA+tBHlZqTLNs7KZ3PyTCwyIQds/9uA2Pc78bmr+oI/WX6nnm41kgx+jbXSu+F2mNJ7+1ozl02BQ6iivdrgymzDB99agYtnbZuJY/ztJTKChTQTNrHT0m2BMDBBoNaXD9SmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133505; c=relaxed/simple;
	bh=yudXVVtyoYfFLmphk4E8ZAYZV8ytVfAr/z0W7ALN9zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRfs3SQmw99GgqM0KcpUIZ1DrDK9LCIvHqY59VgsVkjE12/Wfwi7k9WmZWWFW1dgymb4EzY/Wa6q8SB3i/pBbGnoBFagG/RakQr0ZrDoEzCtzPlxizfq3NrIx3Qjsc5bmU93KmB/svQIScf2p8D3ryFdQPJgWmBn7YDLKRCUcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NBA09sM1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/X30HHVT+unRj+j5qqu/0+DyqeLXkLH1U92Zjg11+5E=;
	t=1740133504; x=1741343104; b=NBA09sM1qGjt8g5Vr7MEaiTFXAeeHDbpUpC9c3dIh7UooaV
	+Ah0bp7XGAaD+kOHuOskPLzRDLztNJ9Rjs31URwtQ7OsxHjIQaNyMtzDIQ/bgJWtdspL5Uj3JAK0k
	RPbn8O1iQfkQySKaIFY/t/Z4hnH1vp+r5Sm1xgiTp4SquYlJyIZAzxJHq1kbRLoP580rtJlgGhB7l
	pDyPOVyqW2H5Xq4mOw/Ep7VnOU1rCYWiM6N2f4TnLn6u1UZGzTPI6YED/70raEFMJil/EqnXBhZ5l
	sxkHYpNope8sFQnczjtQ/SI/4K5lV6uQUw/aLqQS86BUVaKpmNCnWIIBY0/QfoOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tlQDH-00000005Cok-1Dik;
	Fri, 21 Feb 2025 11:24:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 2/2] wifi: mac80211: fix vendor-specific inheritance
Date: Fri, 21 Feb 2025 11:24:51 +0100
Message-ID: <20250221112451.fd71e5268840.I9db3e6a3367e6ff38d052d07dc07005f0dd3bd5c@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221112451.b46d42f45b66.If5b95dc3c80208e0c62d8895fb6152aa54b6620b@changeid>
References: <20250221112451.b46d42f45b66.If5b95dc3c80208e0c62d8895fb6152aa54b6620b@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If there's any vendor-specific element in the subelements
then the outer element parsing must not parse any vendor
element at all. This isn't implemented correctly now due
to parsing into the pointers and then overriding them, so
explicitly skip vendor elements if any exist in the sub-
elements (non-transmitted profile or per-STA profile).

Fixes: 671042a4fb77 ("mac80211: support non-inheritance element")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 3d5d6658fe8d..6da39c864f45 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -48,6 +48,7 @@ struct ieee80211_elems_parse {
 	const struct element *ml_epcs_elem;
 
 	bool multi_link_inner;
+	bool skip_vendor;
 
 	/*
 	 * scratch buffer that can be used for various element parsing related
@@ -400,6 +401,9 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (elems_parse->skip_vendor)
+				break;
+
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
 			    pos[2] == 0xf2) {
 				/* Microsoft OUI (00:50:F2) */
@@ -1054,12 +1058,16 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		multi_link_inner = true;
 	}
 
+	elems_parse->skip_vendor =
+		cfg80211_find_elem(WLAN_EID_VENDOR_SPECIFIC,
+				   sub.start, sub.len);
 	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
 						  non_inherit);
 
 	/* Override with nontransmitted/per-STA profile if found */
 	if (sub.len) {
 		elems_parse->multi_link_inner = multi_link_inner;
+		elems_parse->skip_vendor = false;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-- 
2.48.1


