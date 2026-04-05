Return-Path: <linux-wireless+bounces-34355-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPHxF2fz0WlYRgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34355-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:30:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB339D640
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 497CB3018767
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524B3537C5;
	Sun,  5 Apr 2026 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRF4Jnfh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40862351C2A;
	Sun,  5 Apr 2026 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366955; cv=none; b=BD1FtvfV3xqYFAF8nUde9YhMGZ+Bm7P0jUdjm9dZkosE/Zn4KvbS9yBZv+50RE4z7djshPP4+KcMqIutOXul+4UOvWFM3CwyKdQZ3KzjrFiWOX6AvY2LjfkkfaAPTHlN6mdzk9YesSgLB54B3CB6WDzksnfcpV7Y2gaq06zCo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366955; c=relaxed/simple;
	bh=P7N79mZSIUUEmlci1wydd5YAVIsZ5EiCk6ap0u2SJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcLVvqJCoK2QMdUr/Em3RQVpWJ1njwCLQh+hMiQR9B0fo3jnpLprjSsn+nmuuiOwrsyx7tAtG6WmIXXywJLfmwCjIxM8kWIcoFLo0ACWVubw8a4GSa26U+J+FFQhqFjlj6vXoWeEtYWn/Va29x4nVsgH2Ju8jZ+/jBPlre31gX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRF4Jnfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0906C2BCB4;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775366955;
	bh=P7N79mZSIUUEmlci1wydd5YAVIsZ5EiCk6ap0u2SJlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRF4JnfhzMnEa9rt51PiljUD8JzXZhy0AYjoCOW04JqAWdAMRtVAM6FWnjZASZzW0
	 mM7nLjTXLs8a+9EjxZTn+1J+WaEHS+XChfXFstUhwZmfpsQ+PTj7m9k/gIRZIz9/Y7
	 f7he3QQS0WZWpOanL3YdvFNCGkHKN5VMpENFoP2JwyDEU49FX1ekYSRqZZ/OEG1Fxc
	 Mx6ebgUUmsWnlsMt96CZit9lPJfHOfINU8fcCtiFu9c7GUxbzc6ZefJD46zu4bQR9N
	 8f71WAaH9VTsRFdE+1ct5E2B6CpDDi7S75bIFPty2qnuI1IuNzmshs0aOYRoh2Qqu5
	 l+/DdyhX2/Z6A==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next 4/6] wifi: ipw2x00: Depend on MAC80211
Date: Sat,  4 Apr 2026 22:27:32 -0700
Message-ID: <20260405052734.130368-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405052734.130368-1-ebiggers@kernel.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34355-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21FB339D640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While the ipw2100 and ipw2200 hardware is "Full MAC" in the sense that
it handles management frames (like association and scanning), it doesn't
implement various cryptographic protocols, such as the Michael MIC
algorithm used in the (deprecated) TKIP.

Currently ipw2x00 accesses Michael MIC via the crypto_shash API.  Yet,
the mac80211 module already has its own Michael MIC implementation.
ipw2x00 is the only code in the kernel tree that needs a Michael MIC
implementation that doesn't already depend on CONFIG_MAC80211.

Just add the dependency on MAC80211 so that we'll be able to consolidate
the Michael MIC code in mac80211 and remove it from crypto_shash.

Alternatives considered:

  - Move michael_mic() from mac80211 to cfg80211.  Probably not worth it
    just for ipw2x00.

  - Move michael_mic() to its own independent module.  Again, probably
    not worth it just for ipw2x00.

  - Copy michael_mic() into ipw2x00.  It seems better to avoid the
    duplicate copy.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index b92df91adb3a4..13d69f94c889a 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -3,11 +3,11 @@
 # Intel Centrino wireless drivers
 #
 
 config IPW2100
 	tristate "Intel PRO/Wireless 2100 Network Connection"
-	depends on PCI && CFG80211
+	depends on PCI && MAC80211
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
 	select LIBIPW
 	help
@@ -62,11 +62,11 @@ config IPW2100_DEBUG
 	  If you are not trying to debug or develop the IPW2100 driver, you
 	  most likely want to say N here.
 
 config IPW2200
 	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
-	depends on PCI && CFG80211
+	depends on PCI && MAC80211
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
 	select LIBIPW
 	help
@@ -149,11 +149,11 @@ config IPW2200_DEBUG
 
 	  If you are not sure, say N here.
 
 config LIBIPW
 	tristate
-	depends on PCI && CFG80211
+	depends on PCI && MAC80211
 	select WIRELESS_EXT
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	select CRYPTO_LIB_ARC4
 	select CRC32
-- 
2.53.0


