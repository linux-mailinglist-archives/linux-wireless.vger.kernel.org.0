Return-Path: <linux-wireless+bounces-23496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D1AC7F5D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADCF1897283
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1E1C84C0;
	Thu, 29 May 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emily.moe header.i=@emily.moe header.b="H24xHhyk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G8NoJiR/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2121A314B
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527156; cv=none; b=Xl23obYMDYvuZIjezXY+tW36jrJivVXepv0yeVRKCPUhfDOMx36HPeXsVbux5SzT99fR2G82FIIQ1om2tMabT698bfMZ3IIV/jJaQ4tukB6D7kcpjAzLsJ2lAOvIYkFD5coFJVjqces+YIs0zBvYxW1lzkhYfI6KBjjTQsXw6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527156; c=relaxed/simple;
	bh=SDXBJeZDufUUNi7JP+RVhYtDN7duFGRTyQoASfCkRFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHu4yYk1p12hg3UNNsXNDeKJ+NwWYdJ7531GKDLKxxUTJ1zQhRSXRhxFjz0tRK1/qZu7viwKZYL/7gM5KAyvJBW+NjuVQabUvUjsu5dtXJ7G+gE2MKrg2hOd+4eLw5dqKt9qj6ppmnMB0OIadrMEivgaYqgItghZLmzzt0r6Z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emily.moe; spf=pass smtp.mailfrom=emily.moe; dkim=pass (2048-bit key) header.d=emily.moe header.i=@emily.moe header.b=H24xHhyk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G8NoJiR/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emily.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emily.moe
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADBDB25400A2;
	Thu, 29 May 2025 09:59:09 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Thu, 29 May 2025 09:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emily.moe; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1748527149; x=1748613549; bh=Lx
	tQC1MUVZHNaNGyRdqTime6CdwJkwSW3XxqC34BelE=; b=H24xHhykCa6vFG4Bze
	siSe6RJnC2Qe2u4r6Icu5rJy+X3fyV3XQzAS8Za5ict0LQ3XvQOtZYXx5BBLOlUn
	xz4FxJakTwmNJ/4/Elh2FQGpbtI4mlNBFXY6UgVD+IAO3tAnkfqXefo6yz1WOBQJ
	YAbi7QXjs96tZm5umIKfVXl/q0q/ZNtscXmkH8Fy6TsLPTawO6DNONMIEHeBRTaE
	EssE3o0HrqEUpbHr5g+71ZI5mWO9gFnjdoXQpqC4gLau435aTV/2QBj2I9ZzzMGT
	to8fXfRuXH4UNnmi9CrdVMlAa9IlL1YeGNiH+i+aRdzmuCAoQFu4kHRiRnOBZZT8
	j3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748527149; x=1748613549; bh=LxtQC1MUVZHNaNGyRdqTime6CdwJ
	kwSW3XxqC34BelE=; b=G8NoJiR/ZG2DxbNmVRGyyFtpgCXC9aBhYNYHqxFT3w1p
	4DkQEgR3SLKxGhEJq+S/PAd7c7bTLDEXgYBs7sXyPSmRAC4BagKQgO6n8agaCy6L
	CFeTfxwnFXDPdz+IklB158LO8lKlLGCJeTJd+RYRvY8++wIpxAcSm4FMQXM1UvXQ
	71KZP7heQiwra58ufg6JbswXchwC0udm2B2x0YAcOwm/rboH/QDegXS5sQzqzuP5
	ED7JpLbL1GGb/VZe/HAMhK5X6BasbSopmgO/ZpJoryMsoTe7ECv2wVPVjcA50Q3l
	ksBOynVudoMHLNt7jpRdjg0ed9dZa8/9/0EIriIHMA==
X-ME-Sender: <xms:LWg4aCpe1gjks2PbcyIBbTlmZit-7FwOZWQpkWKd9JeaRlmsTTJ_PA>
    <xme:LWg4aArwjd5QskGyKp6zayE1bubn3rYawYI0b2ay4H4Yi5pv850nDUy52rGK3sPSX
    dAQ050lBd-zN_Gvwqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieefvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepoffhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhep
    gfhmihhlhicuoehlihhnuhigsegvmhhilhihrdhmohgvqeenucggtffrrghtthgvrhhnpe
    eifeejjeeigeejheffueelhfeifeeugfekfffgudelheevieevgfekhfekgeeitdenucff
    ohhmrghinhepohhftghomhdrohhrghdruhhknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhinhhugiesvghmihhlhidrmhhovgdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesvg
    hmihhlhidrmhhovgdprhgtphhtthhopeifihhrvghlvghsshdqrhgvghgusgeslhhishht
    shdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdifihhrvghlvg
    hsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LWg4aHOIsDQQFrTYURhXWOFces_H10kH95RNctlF3NDOEJG-k-yXLQ>
    <xmx:LWg4aB7XqNJR-deT-VszsW2z5GE9ZZ8Gdmb96GHVeVMHlFJZYrIPGA>
    <xmx:LWg4aB5QFPOwD3TdEDvCms020hdreserrGZuWXlAHO_kQkU__0mPpA>
    <xmx:LWg4aBitLyClOShc5A2ReAdOiYYUL-F0pB4sd_6TSPpRLxIM6uZXyw>
    <xmx:LWg4aMPSIBJRcaEchgEeGl-5f0RkUMeYnclXPweGWPsXkdxLq-nyuIbJ>
Feedback-ID: i3c8944dd:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3AA972CC0083; Thu, 29 May 2025 09:59:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Emily <linux@emily.moe>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Emily <linux@emily.moe>
Subject: [PATCH] wireless-regdb: Permit 230 MHz bandwidth in 6 GHz band for GB
Date: Thu, 29 May 2025 14:57:06 +0100
Message-ID: <20250529135706.31269-1-linux@emily.moe>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Emily <hello@emily.moe>

Similarly to the changes in 6c7cbccaee121772a23fa0efdfefcdd8a2369985
(“wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band in
ETSI/CEPT”), the Ofcom regulations for the 5925–6425 MHz band [1]
have no explicit limits on bandwidth:

> Maximum mean EIRP of 250mW for Low Power indoor and 25mW for Very
> Low Power indoor and mobile outdoor.
>
> Maximum mean EIRP density of 12.6mW/MHz in any 1 MHz band.
>
> Techniques to access spectrum and mitigate interference that provide
> at least equivalent performance to the techniques described in
> designated standards specified in the Notices of publication (See
> Section 6) for the 5150 – 5250 MHz band must be used.

I cannot find any material online suggesting that the use of 320 MHz
bandwidth is restricted in any way.

[1] https://www.ofcom.org.uk/siteassets/resources/documents/spectrum/interface-requirements/ir-2030.pdf?v=335258

Signed-off-by: Emily <hello@emily.moe>
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index e331d4f..c2ed384 100644
--- a/db.txt
+++ b/db.txt
@@ -722,7 +722,7 @@ country GB: DFS-ETSI
 	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5850 @ 80), (200 mW), NO-OUTDOOR
-	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, wmmrule=ETSI
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-6
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


