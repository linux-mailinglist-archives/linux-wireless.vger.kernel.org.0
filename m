Return-Path: <linux-wireless+bounces-36841-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0wq0HxZ0E2psBQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36841-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:56:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E45C4753
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 077C23001FB6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2A37BE98;
	Sun, 24 May 2026 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="ae+CkOT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB337B02B
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659789; cv=none; b=IPN4rdEfEeO2s/yduCso+AJMNkeHM3QBLhQUVP7XVgfJR2atK+b1N4GyEz+AjPgzT7QC6FyK/acabo3SYuxcJ5l+JfeY+PdBb67Bou0I8FwUo4F3c9K0jLdryOq+1eJ8HBMtbEnaGh6BoCnND5rZ28uV3jqe5QkX/oknNDszYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659789; c=relaxed/simple;
	bh=ihqAdUA3dK4d4sZJzVA0sG91EQtAx2kZHvucSHzv7Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=QUvckXY7zwMzhEIHquuTq22hsR/yhdeoZV2lG3MOYhrHK8qwbXq1jMd/U5JmBM0UyN4nA0ZpZrSss7AkjIOfvivsi3RR6PiMO+WTxy0RSqpZCPAukdPd5T1LIvlcAVKRlbOpOc7ouEGobyEtlWeuqtd0A7cwP2vj3U7EZ3UTBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=ae+CkOT3; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGo5wsRmcwf0DRGo5wFEW0; Sun, 24 May 2026 23:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779659785; bh=ihqAdUA3dK4d4sZJzVA0sG91EQtAx2kZHvucSHzv7Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=ae+CkOT3aUfVZKLGXxoA9yOJ9a+vRzFx+lffWE+nAVcM6OBU5rpRtK6ptVQkTggjO
	 f4leT2k/K3d+q04DNlbKI9NAbKUTGkmum/gDVXYJw4cRgvoPplUnxpBZeChhlwGgHs
	 jb/0l1FS1QlcVgeNvVfoCGDrqM1cl8OwnSetlu/ks3GtgGfyGszdFJ2qhWA/usTa6G
	 tORfvdSQHOILlD4OwdT/ueWwSSf9L2i2+MMpaAQJLhMCPhInfT+Kb4nqIx7xXR9qcu
	 hC7T4dM2e4+ote1lGiJunAU8/kBzVbLYLBLNdf/dHO4kMWOWbGNaCAUrbw9zL/ppAr
	 l36wG41PpFEfA==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Sun, 24 May 2026 23:56:18 +0200
Subject: [PATCH v3 1/7] b43: add firmware mappings and remove comments
 wondering about rev22 initvals
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-1-cdad2c8526c6@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36841-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 811E45C4753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index b0e6aeb0b..37c5d9928 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2344,6 +2344,10 @@ static int b43_try_request_fw(struct b43_request_fw_context *ctx)
 		if (phy->type == B43_PHYTYPE_N)
 			filename = "ucode16_mimo";
 		break;
+	case 22:
+		if (phy->type == B43_PHYTYPE_N)
+			filename = "ucode22_mimo";
+		break;
 	case 16 ... 19:
 		if (phy->type == B43_PHYTYPE_N)
 			filename = "ucode16_mimo";
@@ -2405,7 +2409,9 @@ static int b43_try_request_fw(struct b43_request_fw_context *ctx)
 		else if (rev == 24)
 			filename = "n0initvals24";
 		else if (rev == 23)
-			filename = "n0initvals16"; /* What about n0initvals22? */
+			filename = "n0initvals16";
+		else if (rev == 22)
+			filename = "n0initvals22";
 		else if (rev >= 16 && rev <= 18)
 			filename = "n0initvals16";
 		else if (rev >= 11 && rev <= 12)
@@ -2465,7 +2471,9 @@ static int b43_try_request_fw(struct b43_request_fw_context *ctx)
 		else if (rev == 24)
 			filename = "n0bsinitvals24";
 		else if (rev == 23)
-			filename = "n0bsinitvals16"; /* What about n0bsinitvals22? */
+			filename = "n0bsinitvals16";
+		else if (rev == 22)
+			filename = "n0bsinitvals22";
 		else if (rev >= 16 && rev <= 18)
 			filename = "n0bsinitvals16";
 		else if (rev >= 11 && rev <= 12)

-- 
2.54.0


