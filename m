Return-Path: <linux-wireless+bounces-23361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C455AC2272
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889451C03D29
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480322126D;
	Fri, 23 May 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HDmYlkPw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD1221D87;
	Fri, 23 May 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002455; cv=none; b=R8CVF+RfOrxdim0t8yYkf3i36YVvO3MRNDwVkTt2FjId4S1KEnM5rULR1ggC9jRdm2vR2ug9DxvnT6PvmV3Xs0UWaVAEXZ+jV9hXCAJrZvZGQdH3dz57nNuC5E6yyjnI4NPzlpLMhUOu8ZgUCfHeaZIKmFiy4BEvuOrMMzeNFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002455; c=relaxed/simple;
	bh=9KHFCK51wlKg6eWT4vrHrBHoBQTzfxk81ECyzC/o33U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClbcGsrX3++oVupEKKjyB8SIiOYY19Aesr/s5juc2pr3p8xdYoMzFuIRzOAm7AJvqTMSdifoAT2ha9/D5KAuDbTYtw2rn9n9QVVdn/GcfJv7RhP1xowTSGSxLMeJlPUDBj7An0jGHRQwxEY3CskWXwPEmrusVb505+Tc+xDUR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HDmYlkPw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ekv9cqIQOQ/6GI/BKfxSdxc8wDhUIaB1EUea43SuH1A=;
	t=1748002454; x=1749212054; b=HDmYlkPwmixhV0nGyAUHSVSRZeGeX/GQ1d/bwo6fUHq+EFJ
	VNW0H4nwXxNh7gJXnhACxlf3zf5Aw0UIg9d4Rt4i3zGFK7bTKkbqmA4rzWG28Dc8v3HYnCY9UBl9d
	FhKS0RDrivaexgq+KmT9hCH8hnvxOVFKrNtBwDs4Byf/e37AeQbjpb6m4JxbBIJs8r7psyegbL9YX
	jH+qrh/M92iI9sbPfx7uO1vljFgclGjcwXs9+b0n6CWeLR+jvaBQ1Skgvv8UKwjq1PnDCPsa4p83G
	CO4/KBRIAf/kp3SBXMQSGiMPWHcxPFyau/rfXZ3hmyZjt1oL169wSQt+0XCUSn9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uIRHu-00000001ZBN-3D09;
	Fri, 23 May 2025 14:14:10 +0200
Message-ID: <d7b656f2e44833f17cb4d15dc7fd985db8c9b485.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: fix iwlmld-test link failure
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@kernel.org>, Miri Korenblit	
 <miriam.rachel.korenblit@intel.com>, Avraham Stern
 <avraham.stern@intel.com>,  Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Benjamin Berg <benjamin.berg@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Gabay <daniel.gabay@intel.com>, 
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 linux-wireless@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 23 May 2025 14:14:09 +0200
In-Reply-To: <20250523121019.2196490-1-arnd@kernel.org>
References: <20250523121019.2196490-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-23 at 14:10 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> If the driver is built-in but the test is in a loadable module, the symbo=
ls
> are not exported, resulting in a link failure:
>=20
> ERROR: modpost: "iwl_get_cmd_string" [drivers/net/wireless/intel/iwlwifi/=
mld/tests/iwlmld-tests.ko] undefined!
> ERROR: modpost: "__iwl_dbg" [drivers/net/wireless/intel/iwlwifi/mld/tests=
/iwlmld-tests.ko] undefined!
>=20
> Enable CONFIG_IWLWIFI_OPMODE_MODULAR in this configuration, to
> make those symbols visible.

Hah, thanks. We were just debating exactly this fix, but I think if
CONFIG_INET is _also_ turned off, we still have another link issue, so
what we have now is actually the below (maybe the Fixes: is wrong then
though)



commit 800fe085168e073910d8a0b758df0399d3c38323
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Mon May 12 14:04:33 2025 +0200

    [BUGFIX] wifi: iwlwifi: ensure iwl_average_neg_dbm is available for kun=
it
   =20
    The function was not compiled if CONFIG_INET was not enabled. Change it
    to always be compiled in. Also update the IWLWIFI_OPMODE_MODULAR check
    so that the symbol is exported even if only the kunit tests are build
    as a module.
   =20
    Change-Id: I02014d338de26768533cd07225780563393b4591
    Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202505120905.ceWoI4rO-lkp=
@intel.com/
    Fixes: 1f52f7f0abe2 ("wifi: iwlwifi: move dBm averaging function into u=
tils")
    Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com=
>

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wirel=
ess/intel/iwlwifi/Kconfig
index b2fb1dee59c0..e4a3fe2eaf57 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -105,6 +105,7 @@ config IWLWIFI_OPMODE_MODULAR
 	default y if IWLMVM=3Dm
 	default y if IWLXVT=3Dm
 	default y if IWLMLD=3Dm
+	default y if IWLWIFI_KUNIT_TESTS=3Dm
=20
 comment "WARNING: iwlwifi is useless without IWLDVM or IWLMVM or IWLMLD"
 	depends on IWLDVM=3Dn && IWLMVM=3Dn && IWLMLD=3Dn
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c b/drivers/net/w=
ireless/intel/iwlwifi/iwl-utils.c
index 9edb8f512058..0049a8ca60f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
@@ -82,6 +82,7 @@ int iwl_tx_tso_segment(struct sk_buff *skb, unsigned int =
num_subframes,
 	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_tx_tso_segment);
+#endif /* CONFIG_INET */
=20
 static u32 iwl_div_by_db(u32 value, u8 db)
 {
@@ -193,5 +194,3 @@ s8 iwl_average_neg_dbm(const u8 *neg_dbm_values, u8 len=
)
 	return clamp(average_magnitude - i, -128, 0);
 }
 IWL_EXPORT_SYMBOL(iwl_average_neg_dbm);
-
-#endif /* CONFIG_INET */


