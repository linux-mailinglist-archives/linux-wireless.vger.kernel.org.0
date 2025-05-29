Return-Path: <linux-wireless+bounces-23497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D4AC7FE1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF757A8E25
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E91DB551;
	Thu, 29 May 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emily.moe header.i=@emily.moe header.b="LxOVsix1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9sOwg5J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C533E4
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530160; cv=none; b=M9VpYzKO6gv6bZDLyVZnY0hXO5OPWYubyrixAnFtXRCZOFD2ICIa6HdqTocjd94mD2jKcDPSR+KbOfqAyzX1rs96BPpYjstHXBRQ356jjqvPLtTaZ9eK62y/67atfy9JM0fwkJc/axp2qHpCjdcWgbgFiDMt03K6zQPL4BlkcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530160; c=relaxed/simple;
	bh=Wp4vJGT0gG9WdCWfyMiNV23sf+IfXLWCXkbJEyVndco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snWveIKzHNNHmiaK0owXL8xcCAMEaUU6XI8TSOp+11ROJjHiNDk70Wtuw6TVsLLi9dm4PZVl06iLkj3WUng04vdqb7QKz2XddYm0FC0F8DSMVQrhzzZ+VVsYz4o6EpvLgfkBmYY6pwDLzK8OCM+uc2NkoDAk8QdVP5TZOpYU7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emily.moe; spf=pass smtp.mailfrom=emily.moe; dkim=pass (2048-bit key) header.d=emily.moe header.i=@emily.moe header.b=LxOVsix1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9sOwg5J; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emily.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emily.moe
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DD7461140122;
	Thu, 29 May 2025 10:49:16 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Thu, 29 May 2025 10:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emily.moe; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748530156;
	 x=1748616556; bh=+5XrwQcXjTJzUM2MFfvkIx9eS2VzpJsm+RPNfXTZeFM=; b=
	LxOVsix1UCiEECy1oFMxqGyX3OSUHipGIUqjcO9/MAyT6J574kF/78UhaAbSfM1v
	WC6Fl9YHPQt6aX/uh3403vR+Sm3Zs2MhQnTBS6X5AENHAFcyq+pN6wTRwBLEVZ2L
	6Hz9IK+dY1MAVD1/sBOi9ZMosP6jsZwipbW8n94ys4pBcJUlLKAwtnqNsaaBHT1K
	JNc5TKSCmmaQ5YBZkQP3HgXFEYwSm8lkTyNttd2bPKZ55viFzWtH5++dZzNFX1Ao
	7AKVWJOpLw32DIoWJ8Z0f89TW0rKkjb+rchDKqtWgWmPd+7goDPaEKmWiOLlX5sK
	EX1SCIzCGxUft7iQXIElMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748530156; x=
	1748616556; bh=+5XrwQcXjTJzUM2MFfvkIx9eS2VzpJsm+RPNfXTZeFM=; b=B
	9sOwg5J51+3tVqCol4NpQ+0BgLwr+FWbGqg8Gp0QvvgZkI4TSv5zrRe4UXeQnYVL
	I8nVLj2fiKV4mjoOjF4laTti72fN6wTqiG1y2/GZFT+EhsrOCxzE5Rg8tQCrPXsH
	lp4e+vzjbFaf+KTiJZdMAcwpwNgOhCO/j14tci6DYPsZWw8uzX1emNKnNywWHpAc
	7vPdJXn3K91c5KoHv4d4h2lsPCDfaWAvl0AzPojKgQtF2u5RkTaLpGy2ARBaPuc8
	vH6Im21bzE2EWQvn9ZNesxqC7RIXWjaGLfmLG1qpbE3yUdbMlgQS4zyug06igqP4
	qEYA17A/D8qorsb+n3WsA==
X-ME-Sender: <xms:7HM4aDwkDYu2wil-7KrYlHOXk83v8PnRqToAtcRVTZhkmRLQgLDo_g>
    <xme:7HM4aLRxbLq78yNOVtX9iCb4W3TYkPTJTgam00JOYUsHos9Zpr40BxzVN23Ro4usL
    k9on5W2u-zGWgo2ztM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieegudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepoffhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhho
    mhepgfhmihhlhicuoehlihhnuhigsegvmhhilhihrdhmohgvqeenucggtffrrghtthgvrh
    hnpeejudduledvffeuteekveeffeetfeethfelieehjedviedthedvvdffgeeuieevvden
    ucffohhmrghinhepohhftghomhdrohhrghdruhhknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugiesvghmihhlhidrmhhovgdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    esvghmihhlhidrmhhovgdprhgtphhtthhopeifihhrvghlvghsshdqrhgvghgusgeslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdifihhrvg
    hlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7HM4aNV5pK_6Z2T5-qe1zafaIWVBl3gVx4mc2KctKayqkjV-BajS6w>
    <xmx:7HM4aNipvNmQI6Lbn1sH1M65BTybEl4kmEfsVzIcfijACKZy4J73lA>
    <xmx:7HM4aFAlUFXaQ0ZwUBEmOrzJyoPwFMC6wxnr7St9mR4yRsZ_sq-IgA>
    <xmx:7HM4aGJfTJtgyyMX3F5jds0o14IF02GRKZ3lO4_FfAIx1Wweb-MYXg>
    <xmx:7HM4aKV5MjtxscjCu4X2s_RxL_EFaB0twb-lAqjyxn1q1H2udQfidUye>
Feedback-ID: i3c8944dd:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55A3D2CC0081; Thu, 29 May 2025 10:49:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Emily <linux@emily.moe>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Emily <linux@emily.moe>
Subject: [PATCH v2] wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band for GB
Date: Thu, 29 May 2025 15:47:56 +0100
Message-ID: <20250529144854.31931-1-linux@emily.moe>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529135706.31269-1-linux@emily.moe>
References: <20250529135706.31269-1-linux@emily.moe>
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
Sorry for the list spam; I didn’t notice the typo in the commit
subject line until it was pointed out to me out of band…

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


