Return-Path: <linux-wireless+bounces-36838-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBI8OPlvE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36838-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:39:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412FA5C4682
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DAB43016ED4
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87658281532;
	Sun, 24 May 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="kTexPuxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3832B125
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658581; cv=none; b=oNkc/MGAWZlMuZrNXFHaU7qbK5Ta/pFDhSq5LcDS/m2CS+EJouzdqr3FNBFlNgVPF/WQvNS44YmMQAqTt0bGJDAuE+SkVS10J8apy8HrwRfRkOWpG8XZIj6b9ZR/opCAyGBcpMimhiQ5v85XFwbYvfX7H502TsIhcMJ/KV8c+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658581; c=relaxed/simple;
	bh=ulyB/um8I4Zuj24Mii0xKRyjllYmblKDe6Wn9LoY1+s=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oscpLxxxIBbjbGAUypcWlSrx8Ux4xmu1VvmzDZb0hed515Gm+o1MHjOMhfTYnf6U/vWPfgTF93TNF3enyfVte2/QrU+qSa97HXmwXaV+NFZVShvkDYD+HkdCPycsCLG8IfRgYrwUWDDSdWWzAUq8jtr99X2Kkp6vz13dDiK40PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=kTexPuxb; arc=none smtp.client-ip=62.149.156.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGRiwYwaMdarQRGRiwhW2N; Sun, 24 May 2026 23:33:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658399; bh=ulyB/um8I4Zuj24Mii0xKRyjllYmblKDe6Wn9LoY1+s=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=kTexPuxbPpJrIO0gQ3WNQcsfjCtYzcMHZjKkhfcz59eyackm9+PZBvtWddjE6WgHl
	 nYglnzrDrE+cJn1vzumUo75Rj+7ugtgU7OG/HmhWI3G0wbagIQ60eCONcMcLeHJh2l
	 nDyO1fsTHNN+5TJ+YXbeVIdOJhVpI1++O+GUftJabysb+irrO39N4xGFQThvS4S08r
	 NujU3ZZFtVQ6YOMIybEV2av2Dv8lYFDS0mtBrqXzZuUEM/PpVg9q9CcYEQOH0J7vE9
	 vU3OUj8dDHuPANX/Tmz8nD7zY2bUDeOLDVIkMFzIrheb3YeIUtCtKJ7o/QJys6RLcF
	 Z1Z11LFHGmx2Q==
Date: Sun, 24 May 2026 23:33:18 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233318.7cb14643@fedora>
In-Reply-To: <20260524233228.06b38dba@fedora>
References: <20260524233228.06b38dba@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFD8Ux+30GB8HizqaImeWNT7J1PIet+7FLEN2O5IOHMqx8hYA+jF5a+eWBUdrIZLnQ5ybihOmMh5dVr6wiIp0gSNnsnrttfigrqNsk4u/ba9fBVZfcFp
 eCcKDawthC5Xf3rRcPRzlhgJbps4z09x9js4Qu5wK+4hi+v1DbqaFMIiAh5ylv1XYb84t5KWZk5iBlEAFWWzcQkjXX06nhjZiFMYViQjVt2SnUJOYbQgveqh
 06S10gCTS9+WU4XXI+R5NMWZ1xTe+ImYQEUL75gdyrY=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	TAGGED_FROM(0.00)[bounces-36838-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 412FA5C4682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c
b/drivers/net/wireless/broadcom/b43/main.c index b0e6aeb0b..37c5d9928
100644 --- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2344,6 +2344,10 @@ static int b43_try_request_fw(struct
b43_request_fw_context *ctx) if (phy->type == B43_PHYTYPE_N)
 			filename = "ucode16_mimo";
 		break;
+	case 22:
+		if (phy->type == B43_PHYTYPE_N)
+			filename = "ucode22_mimo";
+		break;
 	case 16 ... 19:
 		if (phy->type == B43_PHYTYPE_N)
 			filename = "ucode16_mimo";
@@ -2405,7 +2409,9 @@ static int b43_try_request_fw(struct
b43_request_fw_context *ctx) else if (rev == 24)
 			filename = "n0initvals24";
 		else if (rev == 23)
-			filename = "n0initvals16"; /* What about
n0initvals22? */
+			filename = "n0initvals16";
+		else if (rev == 22)
+			filename = "n0initvals22";
 		else if (rev >= 16 && rev <= 18)
 			filename = "n0initvals16";
 		else if (rev >= 11 && rev <= 12)
@@ -2465,7 +2471,9 @@ static int b43_try_request_fw(struct
b43_request_fw_context *ctx) else if (rev == 24)
 			filename = "n0bsinitvals24";
 		else if (rev == 23)
-			filename = "n0bsinitvals16"; /* What about
n0bsinitvals22? */
+			filename = "n0bsinitvals16";
+		else if (rev == 22)
+			filename = "n0bsinitvals22";
 		else if (rev >= 16 && rev <= 18)
 			filename = "n0bsinitvals16";
 		else if (rev >= 11 && rev <= 12)

-- 
2.54.0

