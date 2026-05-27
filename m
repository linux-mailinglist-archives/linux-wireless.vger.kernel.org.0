Return-Path: <linux-wireless+bounces-36994-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KO4J/S0FmpjpgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36994-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:10:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2F5E1924
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B031301E822
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1DA3E714C;
	Wed, 27 May 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="C7CYZWAF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A63E277F;
	Wed, 27 May 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872963; cv=none; b=guXr2NAteV/oK9ten25+T8FMQrv/tRI+gHdxgGyRFpqZDgImfxAOtQJQgExXcZ8/hiGMO0Cjj1sTk+V54TNdt1XjV/mWtzDVFy4CDvk1eSVLraK5JEXjJ7bAl4hl5GmM4ll2kVo+gPVuVRT62TbpT2bx3mJQks//b5R861r0hW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872963; c=relaxed/simple;
	bh=vzoo95YI4OQsuRuaJuDJx427z+CcEVxZzy5X9IIKetA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GCIFU04bcwn3fbxRcdZQrIRRqWJ2jHrIpVwdb6Vs21nK2AfOEZOviIcn8VkjYm5HEGG4DYEt9+Mf1hhr2ItnQpmEcPIqOYr9LnVFAPAY3BY8tbJoWo3gdJCI2fvICgxgJe1nHGfkrjElmVCAfneDUJ/63ayl0+Gh16IN4Uu8zgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=C7CYZWAF; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6904DC01BE;
	Wed, 27 May 2026 12:09:13 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:1a::1:10])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id X8VR7K0XJSw0-UAZ19Y9I;
	Wed, 27 May 2026 12:09:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1779872952;
	bh=bKNvoIKWs8rt1p1/xgViVNVlhP27k63LgvgrDzBDcnM=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=C7CYZWAFDWicK+2c0A86LuKVT76ZMwVpCZRxLIIrr94GBU5FO0KHWPgHP9DzVkQxF
	 P0s86jTGkpqEvwVyd7m/Im/ADhTiwRQbjnFBluRUrSXfOD6f9/NcfdPwRZnncTRpxf
	 qXdM46xEaTSKDWd4t1/1TOjqZYo4e5/9ABOG/fL0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Hong Liu <liu.hong@intel.com>,
	James Ketrenos <jketreno@linux.intel.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ipw2x00: Fix potential NULL crypt->ops dereference in libipw_xmit()
Date: Wed, 27 May 2026 12:08:33 +0300
Message-Id: <20260527090833.521511-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,linux.intel.com,yandex-team.ru];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kniv@yandex-team.ru,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36994-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,yandex-team.ru:email,yandex-team.ru:mid,yandex-team.ru:dkim]
X-Rspamd-Queue-Id: 38D2F5E1924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

crypt and crypt->ops could be null, so we need to checking null
before dereference

Previously the commit
e8366bbabe1d ("ipw2x00: Fix potential NULL dereference in libipw_xmit()")
partially fixed that same issue in libipw_xmit().
This is similar to CVE-2022-49544.

Found by Svace static analysis tool.

Cc: stable@vger.kernel.org
Fixes: 1264fc0498e1e ("[PATCH] ieee80211: Fix TKIP, repeated fragmentation problem, and payload_size reporting")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
index 6e16060834b8..ec455e680030 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
@@ -450,7 +450,7 @@ netdev_tx_t libipw_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (; i < nr_frags; i++) {
 		skb_frag = txb->fragments[i];
 
-		if (host_encrypt)
+		if (host_encrypt && crypt && crypt->ops)
 			skb_reserve(skb_frag,
 				    crypt->ops->extra_mpdu_prefix_len);
 
-- 
2.34.1


