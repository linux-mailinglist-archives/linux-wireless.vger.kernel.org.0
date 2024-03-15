Return-Path: <linux-wireless+bounces-4788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E087CABC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 10:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936411F2361C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1ED17BCF;
	Fri, 15 Mar 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="XQLi9zAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGG+9q62"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816B18026
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495047; cv=none; b=pbhX7Xceqg9X89Tw+QgYuhYp0tAVZUe15nyqAzlslouJwkvK8b7Y05dELLmR97ACbhohFRpuJU2bHtK782YHE+cbwXrRdLtDL3VhrXmfJYhbRT0X7hCPgAChG2BxMMiN6f5DtCc1vQXvb6JIIxv+vz1TSXN8Yxa/Qomno8b5laQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495047; c=relaxed/simple;
	bh=t1SpGlUrAQZ074GC9ZyOBS5csCAYiK3V5ubWW0rU1MI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e2fdjeXrmbhre0S2aMwMobNQ9Ucdurfdt4EfLM1AZbnh9Ib9qhXtmwNqFPnUFGw5HKwY7xCqtUeu6K08/veK0oqM3XkYwvWiOEe7teIlucE1rIa9W3n9/5qbIqn11hLpEUkUT4Km36daEhCGH3rFAn/O6NspKSiRQviSM1dd0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=XQLi9zAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kGG+9q62; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 773991140139;
	Fri, 15 Mar 2024 05:30:44 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Fri, 15 Mar 2024 05:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1710495044; x=
	1710581444; bh=txqmZwiJj+7iIcDD/BIE3X1ghO6jVEIa1axhquQiANw=; b=X
	QLi9zAbEX8N/Sgkxy01hI1iyHW9I96B5BB7bp+qm140m902eB0rbftINFDJzkRlK
	tiVGIAvgSw5jBmD1nKWXF4EjUdYU5ybDBci9SIrONugb1fJiIJ/YKYw7BLTWza+Z
	6AUbmbESxtHe23fFSq0ddCjy+50iH6yIfIt/hATpSPKYOi72FpPjvDPe8bXrbtYt
	1vzFfMB1HvULl6r9amGCw4luf8MR4RKrwJQUNQr9T0M0TuR2C+tOb+KSmfHtaZF4
	+DNkEhVb4a+v3RYoZdnmaXJJpsieBqlYjpRuSKHt+RfDAOlMOWb1RUynoNmA4qrC
	1HKrQu8ha9zfs6MxjegCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710495044; x=1710581444; bh=txqmZwiJj+7iIcDD/BIE3X1ghO6j
	VEIa1axhquQiANw=; b=kGG+9q62p9DyNOEfbAWVWlm4pYrJg/QYEqmfm0d6JGtT
	jx6APwZuBoFp3pMu1/BQG7t02fSGO1iwhJv3XpORQ0OfUQuZc/Ju84hRMcEYzbgN
	U0roeMmxUYoq29G9nMH1kZd/QqBr+wwH7WNOM7pGdKZnZXwfRBIWXbVR/2FUhsqA
	a5GayOyiXyh8HOCS7nuzpEOSy/DL+0adbkDV+yEDve4kQmsq+RPPgu6Jv5MRlr5i
	pCayOuNnhvg7dhU1Vpobfn1woLFhdXUf2a2TBSqrHPUPVercjSFdCPElMAX1u2w0
	yepsZb9XFf42YUYZcRI9QU0b8Lj4hYFvWAL4P8OEOw==
X-ME-Sender: <xms:QxX0ZYnpSj1nzP1dnbfCDvweAyoC7XbZMtdzGLBTqUyIcz1iyb05Rw>
    <xme:QxX0ZX2h-MYngc0DkAVZDwWbD55vsxAt514nx8BKwYGshD3mKzetU6C3LPQgNOlsZ
    YAXyZYL76vjKLNmig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfthigr
    nhcuhggrlhhklhhinhdfuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehvdevieegudejueefgeffhefhffevudfhieejgfdtffetlefgteeu
    veeiudeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrhigrnhesthgvshhtthhorghsthdrtghomh
X-ME-Proxy: <xmx:RBX0ZWpoj1VLMVggGuCaEJc0Ca5jNPn7ksXPwX5EdYRcMUrXlGKeqg>
    <xmx:RBX0ZUkderjj1d5osurRMeKGTtrpFYJzRmr5GtQXYsyz7sGZkIpKQQ>
    <xmx:RBX0ZW3S3ctXpdbouOgYyaIe9X_ICVd7qcnA4jZgZxRTfQHiXRcD1g>
    <xmx:RBX0Zbsi4xuBWA515xUG29rtONFG-I7ndJn6C1NXtDDrq3z6RJ-fxQ>
    <xmx:RBX0ZbwEibp7eDiOsPPF4ZaEivvF55sk7ydyIwHZLyIQHpYUF8xz_w>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D7626A60078; Fri, 15 Mar 2024 05:30:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d5889133-4b8b-49bc-a26f-204ee9fcfdbb@app.fastmail.com>
In-Reply-To: <2afd1590823740a2b6a8f7e485a33842@realtek.com>
References: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
 <2afd1590823740a2b6a8f7e485a33842@realtek.com>
Date: Fri, 15 Mar 2024 22:30:23 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Ping-Ke Shih" <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [BUG] RTL8821CS panic on entering power-save mode
Content-Type: text/plain



On Wed, 13 Mar 2024, at 7:05 PM, Ping-Ke Shih wrote:

> Try module parameter rtw_disable_lps_deep_mode=1 to see if it works well.

Adding 'options rtw88_core disable_lps_deep=1' did help significantly, and bluetooth connections now seem stable. I still get a lot of

[  267.074209] rtw_8821cs mmc2:0001:1: timed out to flush queue 1

(1-2 per second every few seconds) in dmesg, particularly during downloads over wifi. 

> The IO of SDIO is slower than PCIE, so maybe we can try to enlarge timeout time
> in rtw_power_mode_change():

This didn't make any change without disabling the power-saving modes, I also tried increasing some of the other timeouts without an effect.

Ryan

