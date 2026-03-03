Return-Path: <linux-wireless+bounces-32392-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBKcFrzspmmQaAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32392-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:14:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E61F1319
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818AE305FFDE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2802372EE7;
	Tue,  3 Mar 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rPb3EYo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB036405D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546783; cv=none; b=ogNV3Z8apDnlLw3RJfGrMRgwsINANR8y3oE1jfsWkxtOCSw15sAMxfM+j98E4HQTu1PNV4Hd9eZL4WyLWxmCGUjujruGsPBaHI4OIbZy1aFWG1jMYfu0sC8+ZAGJc8/F5DyqVlLKMwL7OMUnQ/TcD6OtiJtxHE37n1vCa/LtANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546783; c=relaxed/simple;
	bh=Ii8CuEPx014yFLXEjSwEPEO8dIwaincA4uBbBER0aKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9V0vCgwp+qIJRLjMNqrch4uhUJFHI75rkvpCoCAqEUSU5jbBZzcn3AhGpP1qy6jBvoGvW89cSaF5SZIWuUHoRoeD28KamAFuaIvvFl4k9qm62DB4mHe6UJ0iFZKkBMjEbvQuBTc4Dom6N8q062fWIEoTaocQj+ZztWIZt1lYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rPb3EYo+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=KeBz1+drcHl5dzzi6kjU++2SPo/aqeb9+5FoYyrFAvY=; t=1772546782; x=1773756382; 
	b=rPb3EYo+w9Y0RAMCr5EZffAyd7mIm+3SGJc/Z1aC5IKCM2f6UPQGEp+uRDhfxGHw4eKOy5kQboB
	88J/QHrW7fWDY4yYirEcFwj5YqiEYzFTcjMZAiMVuhtHjKjy4o46T0wpx1edbDzHIvqniklbXqT5Q
	QN/fvZj6bDCm7iiQpW+c20WZe54syQBuBrpnW3+WT5DCWT5mjmwyzzqQZ7Pdvg1oNGsR3yuuxRv2B
	HbzO0WmoohmxMR2A3bCqACnr7iRgIKB4hMdKtrL/eGmxBhaha/ZfemjnASlLHJChr/sIjh6Ne0DMl
	wGWv69sP2Ez/BlF1YOAjK1iH1zJW2gg2GSKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQO8-000000078ze-1mXE;
	Tue, 03 Mar 2026 15:06:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: remove stale TODO item
Date: Tue,  3 Mar 2026 15:06:14 +0100
Message-ID: <20260303150614.5f4b91c2490e.Ic49b55bd211129e05b1d035ad468d033cf24c0e9@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF5E61F1319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32392-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

We've addressed multi-link operation, nothing appears to still
need to get moved around.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 2875ef7d7946..f1b1bbf2a2d4 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -510,7 +510,6 @@ struct ieee80211_fragment_cache {
  *	during finalize
  * @debugfs_dir: debug filesystem directory dentry
  * @pub: public (driver visible) link STA data
- * TODO Move other link params from sta_info as required for MLD operation
  */
 struct link_sta_info {
 	u8 addr[ETH_ALEN];
-- 
2.53.0


