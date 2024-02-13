Return-Path: <linux-wireless+bounces-3516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF135852B8A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 09:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E173C1C2268E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53D224CE;
	Tue, 13 Feb 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="prEoMQUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A92208B
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813930; cv=none; b=EZJJz4T21ppXJ6yXzO2wFkkKDDw0ZWuMBO0qe84/IErc/g+oCMDw6cv1PkTaieYEkl3bT6AIXBMMcfdnvno1uzcadw1VqSoTBf6MRaBTiBXiAVxFJ9/Wr/IcipM8867kr5bGDyqPVSnoPp5j00X4gC0VoFvV9JBLV1GOETbo6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813930; c=relaxed/simple;
	bh=6VUjqglBNJeJdPp7+NGQQDoJxcf1uKviPCQubGYhibU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tPwBtKDycrmSkFxkvwv/4sfwIrD47Qr680sg68A70HrUj1htvNo1RykE3rBaDzHO8t6Kxn0hY3uxNvExZWg9aCmWpLxQ+4qQzbwEHdYuSQjI6aZ4pyQ74Wn03Zf+qwbPnl46n384z+EleKcrh9KFs+ttHCCp7a+B5z52vb6SH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=prEoMQUw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6VUjqglBNJeJdPp7+NGQQDoJxcf1uKviPCQubGYhibU=;
	t=1707813928; x=1709023528; b=prEoMQUw0mcU4OJrylTGhjzCCxEwDoGgG+rZVsu4eCQQ3Ji
	Kh/aiiXhx4PddGw0fVbcyecKzoeQ0op1meypgM/E/NsWjluQBhewnQIPzwpR3Z+N3YFLD2f+RsxCU
	O5CrQmrl9dVA7MuYBhon3UIbSp663zC7UsXVOuuFUnEa8PswsyIaDetq187F+MFiVPy+16xcrJkJE
	VrtEt/fU/kHf9NBoymWh9PHMRiJ2YQ9tWIM8+lL3c3JZwLvE642tWT6KNJtwDnmbFTvRaE529iFb6
	xVIKpwV/ZeHY5rmxB5drxZwOFfxHyN0NmrVQNkU84zGo2yvRQtIIOBp4qOfjLyNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZoPq-00000007YIn-49vi;
	Tue, 13 Feb 2024 09:45:23 +0100
Message-ID: <f3fc78d1a73ab8e8ad5d8df75d0589190f926220.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
 <ryder.lee@mediatek.com>
Date: Tue, 13 Feb 2024 09:45:21 +0100
In-Reply-To: <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Uh, sorry, accidentally sent too soon.

> > > I'm mostly asking right now because I want a reliable way to test the
> > > work I'm trying to do on the client side though, so I could also live
> > > with some hacks (inject through debugfs?), but having it for real wou=
ld
> > > be nice.
> >=20
> > Okay. I'm right now working to add basic test case in hw_sim for MLO CS=
A=20
> > (on first link) as we discussed. There is need of a few mac80211 change=
s=20
> > in order to support for other links. I'm checking those now. Once done=
=20
> > with these, then I'll take up critical updates.

OK. I also have a few patches that I was working on. Mostly client
related, but maybe these would be relevant for you as well:

https://p.sipsolutions.net/f9e976055a616eda.txt
https://p.sipsolutions.net/054dcb0502247890.txt

Sorry about the format - once I've fully tested them etc. I'll send them
out.

johannes

