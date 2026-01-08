Return-Path: <linux-wireless+bounces-30573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB71D0324E
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C242F3001FD0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F84E20EF;
	Thu,  8 Jan 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gbPuy5FD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E84E20D3
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879627; cv=none; b=LCjhepG5OwWwVeX6MHTiGj1ObujSPqOx9FovY63E+aJcBhaMTuJBNeusf+GMrT7YAr+PCNgsvKnAXJVGDDHcFy/wPv7kFgFrTYc5NoSfzt4GgU6wd0iPLm9MSsoSNan6BzgmZuKsCgvK0atMwUdth6R7NV2Z+Vfpa3K24LgWqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879627; c=relaxed/simple;
	bh=7fWlb+ob0WstEVaO7HTiiW44Hjljax7/cTA+pLOKVWQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nScsLSNtRxwG3UhbCII+bEedhqzuYZSM2iHuFoINKqTtufXpgYtrxVggMkhp8Qab3bzKJ8ztpxUkRp1eeeRQcF9kWlm4qLOL2sFVwD1C4ZT4grPFkfpYrpj04OrzZzJY8i23OoR1t7pOiHG3eAqXW9dYall7ntvHr30r9CCoblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gbPuy5FD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3YTzXlOTdqznWOj03ZdJKMsx/zYWtIOwwIsskScqXxA=;
	t=1767879625; x=1769089225; b=gbPuy5FD3pF9ar6lc0p0pBKhUK71odWPjC46f8S7HqjRbsv
	07hRs9MlWMfwL6MvmEjgKjLWA6kuq7Y5E5KJfyxeOmDPs7Uex0rciM4CgXeFlP0x+o/JlS4VeUKkW
	kOVAmmWfx0yMgxdRKezSqx4UK7TruUFYwLqaucmcxqso7CTBW3L6yyZYRhP1J092K2D0qMKFi5i98
	Ax5UbBhNLKPtUYxZ6IxOW4VIOy6v4LaWMfRVuEG3H4/LEHmwrI2ppQcsv+tHBXqWC0Mz2c5oCqbt7
	/H4UUwEGwyI67H5TlLhLJ9yjYCE703fuBFeeE3f1gAujEquVC7SFfrODDTXd2mwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdqFN-00000006WiM-35lm
	for linux-wireless@vger.kernel.org;
	Thu, 08 Jan 2026 14:40:17 +0100
Message-ID: <ad57671c50ba36d2181acda0bf1ea7007e99da78.camel@sipsolutions.net>
Subject: [RFC wireless-next 47/46] wifi: mac80211_hwsim: enable NAN_DATA
 interface simulation support
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Thu, 08 Jan 2026 14:40:17 +0100
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net> (sfid-20260107_152522_133062_95293F2F)
References: <20260107142324.45386-48-johannes@sipsolutions.net>
	 (sfid-20260107_152522_133062_95293F2F)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

From: Daniel Gabay <daniel.gabay@intel.com>

Enable NAN_DATA interface simulation support by adding it to the
supported interface types. This completes the NAN Data Path
simulation introduced in the previous patches.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/n=
et/wireless/virtual/mac80211_hwsim_main.c
index 7d6c223625ff..7c48bad3f2b5 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -6367,12 +6367,9 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
truct genl_info *info)
 		param.p2p_device =3D true;
 	}
=20
-	/* ensure both flag and iftype support is honored */
-	if (param.nan_device ||
-	    param.iftypes & BIT(NL80211_IFTYPE_NAN)) {
-		param.iftypes |=3D BIT(NL80211_IFTYPE_NAN);
-		param.nan_device =3D true;
-	}
+	if (param.nan_device)
+		param.iftypes |=3D BIT(NL80211_IFTYPE_NAN) |
+				 BIT(NL80211_IFTYPE_NAN_DATA);
=20
 	if (info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]) {
 		u32 len =3D nla_len(info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]);
--=20
2.52.0

