Return-Path: <linux-wireless+bounces-36843-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L6LKDF0E2psBQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36843-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:57:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1795C4786
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BFF3301627C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29137CD45;
	Sun, 24 May 2026 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="APIeCE/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921937B3F4
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659790; cv=none; b=g8/PDVAqFdGD/rlvKd5DWAeDZP0ZplSP5f96MpNL5FYgTbncW7Ul1Nf274bCElfBaRxuS99DWzTP+0DikWPv7w6WDd0rF2VhFI1cR6tedIH4iUGc+GL80eQTlV5PbrHoixtlbomzCDiLcqPiKkKvDzeDsit49mqbRD28LAs3JW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659790; c=relaxed/simple;
	bh=e/hYjV7INXbX4jjE81sUHqotTmvH3P4OPUaxzlGVb8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ejq0QcRgJkQX774/DZCbiBbEyziV7+vsMg4xn7Ws+OzkE5dh5rlK9329j4Fr/2TbKxqn2/PH+uIxpNLVViuckwPCvA/rz/tTRJpAF/cM7qjG12B54xVenB2zq9kRX7qC4qnDuaqBCQjQTIvUdhcF68J3HWq3WP5RluajVxpodnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=APIeCE/h; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGo5wsRmcwf0DRGo5wFEWL; Sun, 24 May 2026 23:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779659785; bh=e/hYjV7INXbX4jjE81sUHqotTmvH3P4OPUaxzlGVb8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=APIeCE/hGljhK2AdEk9ZRavDZhq1rbw2O7xexR5hQ5rKJ9uqTfpPGP5BIKLbgfvZ9
	 c3NkbAVYR5pNpZAK+lj3jAjs/WHsYSjOW4beM39Wzbjcl8xn3/FyHitJU+i9TolB+I
	 mZYBCPc670R1BEoXT+VmRtAQAy4eF/Dl/mKijByc6fVSA/YRVR/ApjMFALdVo32znl
	 pdHgSjZdo2TN4QPGese5AzCxzr4q8rvHMDFN6o62hnXUgWzuTCk3ncT6Wlvdy4Fi5O
	 QpBQDMYjZQuX+xATF7MqECcCNGGd+pa5A5r0ccf1PaW0kJx+C6FVcPP6okZFSzg1Gn
	 TnRpFSpMXjJBQ==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Sun, 24 May 2026 23:56:20 +0200
Subject: [PATCH v3 3/7] b43: route d11 corerev 22 to 24-bit indirect radio
 access
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-3-cdad2c8526c6@gmail.com>
References: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
In-Reply-To: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alessio Ferri <alessio.ferri@mythread.it>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfK6e4tZhO5nbXI139+tskn3ZldskwfZS0yAkmZzdcOiRqB5wDe+cpYChzUy/iHFxUhoVp6ah5tm/xaN8TPVJUQrwkYksZlAIe9yIAVsmHrTjgL+TX1og
 HjWJnTDeXqY/mLXoEZFeQito8onhlhJuL9iHTYF4Y6kr0garwS6/ceTopffj2vVF27c9FcGjybi74l96GO1XPhhFjz0aw5NclsV5DLN9cDKQNey8hPuI9Mr4
 xsWV1tci4PZrxsE+vgaHc1n3T2mR59exei4b+jy6mXj8/5tJHWS0S4i0M3oMLhO9ROIqQB6eu5UVlcItQfFfdjQNE/BiBtfF/aKPe3zEtco=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36843-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 5C1795C4786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rev 22 backports the older 802.11 core but pairs it with a radio
in the 2057 family, which requires the 24-bit indirect path. With
the current dispatch, corerev 22 falls into the legacy 4-wire branch,
reads garbage for radio_id, and bails out with -EOPNOTSUPP at the
"FOUND UNSUPPORTED RADIO" branch below.

brcmsmac handles the same silicon family with the equivalent
dispatch in drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/
phy_cmn.c read_radio_reg() and write_radio_reg():

    if ((D11REV_GE(pi->sh->corerev, 24)) ||
        (D11REV_IS(pi->sh->corerev, 22)
         && (pi->pubpi.phy_type != PHY_TYPE_SSN))) {
            /* radioregaddr / radioregdata (indirect) */
    } else {
            /* phy4waddr / phy4wdatalo (legacy)      */
    }

b43 does not support SSN/SSLPN PHYs - they are rejected earlier in
b43_phy_versioning() at the "unsupported PHY type" switch - so just
adding the check corerev == 22 will do.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 85ea8fdd9..783af26cb 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -4563,7 +4563,11 @@ static int b43_phy_versioning(struct b43_wldev *dev)
 		radio_id = b43_read16(dev, B43_MMIO_RADIO24_DATA);
 
 		radio_ver = 0; /* Is there version somewhere? */
-	} else if (core_rev >= 24) {
+	} else if (core_rev >= 24 || core_rev == 22) {
+		/*
+		 * D11 corerev 22 pairs an older 802.11 core with a 2057
+		 * radio that requires the 24-bit indirect access path.
+		 */
 		u16 radio24[3];
 
 		for (tmp = 0; tmp < 3; tmp++) {

-- 
2.54.0


