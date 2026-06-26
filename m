Return-Path: <linux-wireless+bounces-38134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kqgKC8sePmo8AAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B66CAB3D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=lGkUUP1v;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38134-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38134-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 808EB3044EE5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AD3DC4B3;
	Fri, 26 Jun 2026 06:32:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A543DB62E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455571; cv=none; b=tcrxdiGgsaMfYRq9wsvtyl8CmTttNi+CxYAn0Cml2fyQsJyGc4GMlaDJeXN1wVuptnp7LUwrixmcOS3M68ayG9qtxrj0vERVl2f26TlQEyaVcqoIttH5BZthU1WyQs3Es26aTnKXkYVL+2yWJ4AHgrMy9MptwBa2d90K7+P+Pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455571; c=relaxed/simple;
	bh=jh7nryGEKabYgpd+PfRGwc0d27nBce12mposWAI1iFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCXPmQdvlZukH/9T2LTXfIzGIbGp4iDUh7mJ3nup8fhWKWPpvkzBYWF4RNF0353yx0h/Ag7ETthx2qX80iUFOEcHw6jEoDTNrAJD+J1PYdORH0ton/X0xS/kbqxj0n+NkHd8C+LrXDAi7m4MZFndgyDTw44AtrUhhYlPdYiJXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=lGkUUP1v; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so1422339c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455568; x=1783060368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcgbUEbRV//HZf8rnCos9XTT1qb4oAzB+LdSj1teGwU=;
        b=lGkUUP1veDQG3tCyZ5bWIHEe2s9348Ne51cTTaAer6NRmDRVY4C/WxRKnm2zXWfjy2
         PqNKECxZjeZfw0Gp06o5Uf5hsXJKog6XKuYHK4Ufv85dTsTYVs/9FbzSdmL9clpD+FnY
         p3FcLa+v6DoSLSXBIA50RthO76mbHShdQPNomwYdmVmNFz1OjRA6lq0f5mloDxC2MOgO
         ewns0VKUDz7JTlOtLreIRO51yEdSleLnuwY78PfBCaOHZZpv+r3tP9S+Iywt9LRq2sHg
         S/LetjaI3tu5YXpAJXS8pwAsgU1aFwsLUdQ4ejHaaulvNSm7026wrGMnr2t4O/a3vfWz
         6UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455568; x=1783060368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcgbUEbRV//HZf8rnCos9XTT1qb4oAzB+LdSj1teGwU=;
        b=Vncbj3+NHvazfkQ3joue8bRb4EUwp+0tAdJa3K6ryS7J93MGbTpVp+xoKngA+kx+L1
         aK13smF0Pb4KHGZBZLgMmx24QQRsiHew2Lu4kMFiizwIg/QVbUK3pBBkv/fvAMtINDjl
         Mll83Xfgw13O1zoGawMvTO1ekIpy6PHW4TUhgyzzIFD5PWyXKWRLb1hKmlgl0KNY8LiV
         phpoq6ZmcMkruT94EHWyYNqKkUReUyLbQBLDfoP4lpOntCHKyuKRZINIja9zbNnl87nP
         eQBtcJCHb7BETR5oVRw0bRbCI6+F8a/ujUSbNxZ8e+2pwmOgB+eyJt9pQ3UfdMFi9+tj
         cL8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8nGSt9T7tFcwMUcjZ5xpKes0arrohubOKj8SVOSXnwER7U0xcGFSvOUNWdCsbB3Hq/WPKsFTARrMV/yBz9dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFSSoIm5jAz7BDpzk8rS6/fMA43wbQogNmfGisBiqXCZmkYlv
	1ISmguQF3JO498zya0IUJqJ7MnyfQ75sogARAl2YvUHGoo2uv9J2wJDzVuUKocIRK6qppIRQxqw
	v1xkRYBg=
X-Gm-Gg: AfdE7clV2OVIxCLadroj9+o08OVj+3Cqv6+qqpc/epymTXslI1B/YEkIju7Je4jpnXg
	BUR7J7vqUUXQQHnZAcHMo5v0pUZW3NhF7VXMlvRmyR7g+w/i6iv2AXR84zx/54F5HYc7qJFrCtm
	FvaoNjVw35y/EN2ajde68iTBXBXsMLY2Nb4cIMrNh/efnlD7pBucQzjKayzbl+/Q6ykBpJH8kQY
	IfpLcPo3hRlJlTJT2gblJu5aCUGWdojXaO89npFAs0Bd5Tpc2yM5GNDyVAGzrGGMsgH0Dnlfyul
	f+pRq/cNWOutwixEE72Hw8jZCMFaToxHp0zL2OoNqjTeCqREds7UKymQZPu9FaJC2iaenz2DamX
	iv1DI6H5xtz7qLFPJnY2ml9oq+WYhuIyOci3lcWD8EpADsWxbPu7N3GV/sIEX2j7wxp+0Pe4ea2
	4qhHlQuaSA232tkaGugJUHknrdNw3NHPalDYuq4NOmksNUGCOfaqLiTMUiFvEFebyRHrStE/H/Y
	hmqLBndG1F3otRH7D68NJzIJ47t294=
X-Received: by 2002:a05:7022:6727:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-139db93a89fmr4012264c88.0.1782455568353;
        Thu, 25 Jun 2026 23:32:48 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:48 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Ulf Hansson <ulfh@kernel.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 23/33] mmc: sdio: add Morse Micro vendor ids
Date: Fri, 26 Jun 2026 16:29:19 +1000
Message-ID: <20260626063014.1275235-24-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38134-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:ulfh@kernel.org,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:lachlan.hodges@morsemicro.com,m:linux-mmc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 386B66CAB3D

Add the Morse Micro mm81x series vendor ids.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
Hi Ulf, since v2 we've made another slight change to the name removing
a "B2" suffix so even though you acked v2, I suppose it's best to
recollect again - sorry about that. As last time, the patchset is
split once per file following wireless driver submission guidelines,
but will be a pull request with a single patch adding the driver +
sdio ID once review is complete through the wireless tree.
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0685dd717e85..bbffad9ae88e 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -117,6 +117,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_MORSEMICRO		0x325b
+#define SDIO_DEVICE_ID_MORSEMICRO_MM8108	0x0809
+
 #define SDIO_VENDOR_ID_NXP			0x0471
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
 
-- 
2.43.0


