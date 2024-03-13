Return-Path: <linux-wireless+bounces-4698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71E87B29D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1151C215F9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764924CDF9;
	Wed, 13 Mar 2024 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="LAet/sVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+FNuDBW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54F225AF
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360704; cv=none; b=EGkr4IPnBs9poZA85BUtI/kuxqeIPTYpSTts1tW7jiPlmvDBdX0ehYkfODqq/i2og4OrVHpOcMk3GLGpl5ZlyOzspkH7he3ENnNQ2Zj+HSejwbR5/gI9HDZtRCkfG9NNL7PMN6vzPv/BInMdAhm2lxbmo34rVUa7Le1vVILha2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360704; c=relaxed/simple;
	bh=2m0C7ch1xH1O8hDXN+WRm34/IKnji9tgr6vSQ2U+Ex4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=biQSYYeIbt57tHK4gU7fDgQfYXLfEmNEqv1okg8EHVLpQEU1CmkysxStHoWpfevrHjqM/zssUPg3i4Li59tc/W19iEBVPhsjnBhQWjWRPfaQ/KKqU2aKkezarQkRjzzNvtFJKuJJgS8kV3Psr0usyWlgA5UbnW89Ox80opUpuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=LAet/sVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+FNuDBW; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B2F811C00072;
	Wed, 13 Mar 2024 16:11:41 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 16:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1710360701; x=
	1710447101; bh=wb0FXIrSDvkxIEWnvmcKLFK2rBTR+GDQDrOfET6lYWM=; b=L
	Aet/sVOawAlaCeE+74nWCtyEZ7LopDDnYFEu1HWYFwugGAmzHzF3VzuKLZllbi2U
	DRx0PcwB4A4o/cn8C+AS5dPNBFBbBZP5gTX0gX5WxzWM7eRQ8bglbe+N7WrpsIsz
	8UdKEvjWmO2JHV2H3faYpUp8YN6KUo+q6xDYd438kdC9R61QY76KZ91oY7V+zatz
	pUJrTZEpfMqKzTZ4kVIb/n8VYWbpuRFa7sJULa3rRX80R40ZBFyM5H70ZueRRIjA
	mOYiLRzqY39Ef2Pn4A7tNLxWNtuLpMAKiFL5Aj7quaPZtSP+2dW+fxS299LAZtVZ
	LHkDT76vvvYEXnaD6FU5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710360701; x=1710447101; bh=wb0FXIrSDvkxIEWnvmcKLFK2rBTR
	+GDQDrOfET6lYWM=; b=e+FNuDBW7AzdZ90wyBiG/qBzziEo4URzFc6q4m8W/qR8
	r5VRjHjtP0Lc3/rLG28pDzoIM2IqJUFl1qOQU2t1I3D/w0JybC8S8IJE5VBMWuey
	MTVWm81F6P/ltd+G7nG3Ob2rhvLY8tkSHtKA6o8Hz78VpJhqWJ6WqPn38hMGAXwm
	5X1jmd+ZpTIPz1xShPLhFJrHTpwECI+GYHMx7HFt1JFlGDHPFsLi8ezECW7LVGCQ
	PsBypSMGpdnpi0dwvSKLSCAnWTrOUSQmBShatAZDynZfirGT23T3xEz9DX6wGuul
	MnVwr9w3jdBYs73aDGC6HFM4gAL64chjMi7QmLafBw==
X-ME-Sender: <xms:fQjyZTmcy7iTP0iu9SrBEk4HDnxrq2G9tOEe9vyES54exqlWoVaE_w>
    <xme:fQjyZW3WjldoNquzTF9nj3ma3U1T8L9h9MemsBWWE6oA89qhtk5hKTLuSAn3b2g1U
    kr4O2M9lfO-gJU5Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfthigrnhcuhggrlhhklhhinhdfuceorhihrghnseht
    vghsthhtohgrshhtrdgtohhmqeenucggtffrrghtthgvrhhnpeehvdevieegudejueefge
    ffhefhffevudfhieejgfdtffetlefgteeuveeiudeijeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrhigrnhesthgvshhtthhorghsthdrtg
    homh
X-ME-Proxy: <xmx:fQjyZZqSU8ZCJfXaJlD9fTRX9SnPYWu2a8df-JjdvH044KsQcBs2EQ>
    <xmx:fQjyZbkzJ36rD_riKzkZoFS6aYkPYDUf_vQANaWTKiZ0rrE50PvWpg>
    <xmx:fQjyZR0A-UeZbs1F9xy9guf3vfrrM4gI_GDLLK2aF6vUDnQEIsMegA>
    <xmx:fQjyZau2wRwIdq5k0iqM9VbS37Q75uJEc71SgfmxXGlz9QNTv3nCLw>
    <xmx:fQjyZfATJ7K5iHMFPyjVkxVT3V_ZX8qGZSg-c7_IdK7uwgJ53qNPDyD76pc>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0544BA6007A; Wed, 13 Mar 2024 16:11:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d16f8068-d6b2-4f10-bf9c-1e2fb77d91ee@app.fastmail.com>
In-Reply-To: <2afd1590823740a2b6a8f7e485a33842@realtek.com>
References: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
 <2afd1590823740a2b6a8f7e485a33842@realtek.com>
Date: Thu, 14 Mar 2024 09:11:20 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [BUG] rtw88: RTL8821CS warning on entering power-save mode
Content-Type: text/plain

> Did the extensive logging of LPS state happen always? Or happen after a while? 
> Try module parameter rtw_disable_lps_deep_mode=1 to see if it works well.

No after about ~2mins or so. Thanks I will try that.

> The IO of SDIO is slower than PCIE, so maybe we can try to enlarge timeout time
> in rtw_power_mode_change():

Good to know, I will try that patch also.

> Not sure why this could lead crash, because it is only a warning. 

Sorry yes you are right, it is just a warning. The WiFi does continue to work.

Thanks for the reply, will try your suggestions and update.

Ryan

