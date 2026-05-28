Return-Path: <linux-wireless+bounces-37067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMnWFkt+GGoskggAu9opvQ
	(envelope-from <linux-wireless+bounces-37067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:41:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1336C5F5CAA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBE49301CFCF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E213FDBFE;
	Thu, 28 May 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="GSetKNaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DE3FD946
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989695; cv=none; b=lX/sTKfq5idKyzV4KDc/mdWz9Z5JgQlQFHw5ONrOLnCxae3fY9Hk0rY/Zbx37Za+4C7620agJknR3mnbU8M+4eZo6WiQFfVTd3IoMB4+aJlYZDvbQYkSpqVEfMv0Jr+fL/XAENu/qETIor/oGWE4DpXSNyBQtITn3eRCA9w1k0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989695; c=relaxed/simple;
	bh=19Z+zdaXGI3FYfSGWQoCBXevBSvCZqWMLW3DMW3r/lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=P9IcbBgH0M0kq3H2RYn7tP5V66IosZh3ceR3pEJ75yyYo7aGmisW6yHvEkv5P2bqwjwb9HF8RG3e78iE7MgpOtwweSlyOYO6Ei2yZimPOa8qoosSesfNK5sgFrz9KrBpMmYonCxG9a/U5jJSNNqeNXSN1hYbh7qgmvaFxTk65z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=GSetKNaj; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Sea5wczvrrbJKSea6w6A39; Thu, 28 May 2026 19:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779989502; bh=19Z+zdaXGI3FYfSGWQoCBXevBSvCZqWMLW3DMW3r/lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=GSetKNajeSjQPvm6v9X83qDUhcXhY4+R2ef8/HQNnHNIEDa7/tdvN0jnNbXn4MEhK
	 WIvjBgty8cIu5/FzX8DEiP5hTMH6R9XIC0ZSq2IxUO4uaC9ZZYI/eLzdHlP/jKxwWB
	 KzgfCOPXay1hqZG67LcBSUIGSRvQMNh4n0HybTomHYUalwPZ1le9QJJLy4Kf444oWB
	 YeJ7YvwUIzeEb1Z66FJSd48X18bF7qX7AAB4vFze16YLhdVgbGSokZOpF0SIU34MUp
	 kwTmuZKfbhrWC8R1wVqvWyZ/GJo44WOWe8fLpdKZggeVT8lDCskvtojjMuDDPJDklZ
	 aAQQQzji4M6GA==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Thu, 28 May 2026 19:31:35 +0200
Subject: [PATCH v4 1/7] b43: add firmware mappings for rev22
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-1-464566194d47@gmail.com>
References: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
In-Reply-To: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alessio Ferri <alessio.ferri@mythread.it>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfOUW+OMsbislXLVfjghoLiIMSllfjXG3jKhyT1qtr1TPotfGmGoeb8vIdxFRzON3ha+X1I01ALnINSxjunIRNJpkd+hb2Tso3vfQ6c4Al8AAeBDPURzQ
 29rmtnLnULRa/0VO3EcRCGmWXrooQhLCSqu40xytABMkKlcKB3hRVoC95GKPgsnpJAd3K9lN6GO5nNKsx17R2Mutn7NSdr9S/uiqb1CtsCb/hg8E+yllqt/u
 ISNj8R6MRy9W4IQM8xcXYODVPcwBRGWI658r2/xDq9z4g/xbS34L7GLyOev25WmdqYS+z22dTV35Abi8K3uXSBOpyhKw+cyRTuLnPPUyqtk=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37067-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 1336C5F5CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

add the specific firmware mappings for rev22, and drop comments wondering about rev22 initvals

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


