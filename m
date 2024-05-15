Return-Path: <linux-wireless+bounces-7672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC08C61DA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C10B22AB6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA3487A5;
	Wed, 15 May 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FyhkqvhR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4B47F65
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758749; cv=none; b=MGZ8y1OABExIppQOvtr3buqxMCkz6ir3g5TVgOrW3Yq4WXjSHAyDOqBX/UXUE83/5/+9Eve9P1ilYZjkdLJJ75CxjMBvdsrDvpYvXmuq3UlJMgrWoLY7f1teW3epmmWErVAAUPIjkWUqNa6qR460Fb3f1fkaK7AUwEJl8QiIfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758749; c=relaxed/simple;
	bh=SM8ELfmV9u2nQkNMOr5fKc1VuePA5bLJ4/WwZ1WJiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UymRjY3PqgnXBcCm/mjaArYCT0Foim+9FS7AUv1t75ptzW4/2BA/m/md8Wj7UZ4VuUKLVSTwBzlh96hBgdlvcOv0ki87XyQqgIGQpnnFXqneQMprqPN9KxLz5038SxVgGbO3xNr4ODsq079FFKKNDWSbyRse5vVYPby7Bgf9hwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FyhkqvhR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PYQ2vBrL0Etnw1spfHKb3QrP/OeXH0iSYL3MeUP3DIw=;
	t=1715758747; x=1716968347; b=FyhkqvhR/YVOoD3zH86aOR6JjL+cvjXZ/EYqMc7XY5D7v5K
	FqSO4hrmDdNgVr3T43A3UrPzdB3TRpCBFGKHaIeIApl7MX1DWuyw3Knj1B/fPWypIr5n+4MqDgRcK
	DmMphoeYjTiWzxYZiKUsAqOjZT98NNNlXnWe2Y/9ShcetTGumPEpDPolTEta3gyd8bByWTXMLIJ0A
	2IokPram9Hl2plaPIuXZiF1vpWV8HRUXYYsf0iBaZ/Fe32BD16c+AvOxKyvZ/nuDCUyfGD8RD974V
	PNJjiSz1mqhpP9uokW3HsCIaiCwI5riPLzTcDcANoKzZIZyEuUoxj5+DAAnlB/PA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79E9-000000063rL-0I4x;
	Wed, 15 May 2024 09:39:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/6] wifi: radiotap: document ieee80211_get_radiotap_len() return value
Date: Wed, 15 May 2024 09:38:37 +0200
Message-ID: <20240515093852.143aadfdb094.I8795ec1e8cfd7106d58325fb514bae92625fb45c@changeid>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515073852.11273-8-johannes@sipsolutions.net>
References: <20240515073852.11273-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Document the return value of ieee80211_get_radiotap_len() in
the proper kernel-doc format.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/ieee80211_radiotap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 925bac726a92..91762faecc13 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -582,6 +582,7 @@ enum ieee80211_radiotap_eht_usig_tb {
 /**
  * ieee80211_get_radiotap_len - get radiotap header length
  * @data: pointer to the header
+ * Return: the radiotap header length
  */
 static inline u16 ieee80211_get_radiotap_len(const char *data)
 {
-- 
2.45.0


