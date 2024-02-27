Return-Path: <linux-wireless+bounces-4104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40015869A09
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E5C1F22714
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9DF14900F;
	Tue, 27 Feb 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="le6QiN0/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1D145B24
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046711; cv=none; b=MbD9Gh2i9XStCWeVX1Vbwa0Sh2CmnUAakhNLlBG4kFJELWLJXt+MHRBgXZfDI5hWtyqCezm5E80NOj4LPUz7Yj4Ipj7SnJSXgQEpxal2iQBVVKOoV+tsRBkB56b17LSgIo2ZgqoNydjStO1GfUrzio7H1yo6jc29fQqKppLvgvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046711; c=relaxed/simple;
	bh=/Kmt/HFUBeRZmflLvOQutfVSNFYpEsx/c0puFabwAwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qeW1wPoScs4Rwtictx2N8H7oRRrLheBGp/D0VMLEb/httZF3+I6qXOHvH09puUyLLViSC4hh29xq7LSC7q0kbBJnR75yWe9RZ25ELCWXccgMMCvPdS1uV93Bx551vMBZXGVvir/OedHlnrJNokf0/Ify9zVoGHvz6sapg+NEgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=le6QiN0/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/Kmt/HFUBeRZmflLvOQutfVSNFYpEsx/c0puFabwAwc=;
	t=1709046708; x=1710256308; b=le6QiN0/vYGUrnNZKEw1HeJfNtv07YEVqs2KBdVNP0fNC5D
	WlHXkpSsk/UK7PScJ7j65H/rLMOpt5s81+2c4BKZj3n2/RQOlMMzPtpFbe1sq8xmf/IRQ3OjX4vmj
	hZmGdc1PSEk7fmxQPjsPXgo6YFhkkzkvjfOpZTYX0+Ba3pKaSXTA2BuBT0fIv8mSHxpTuO+zQ4cxr
	HfP4wlh7/dqj6ybKYVk4oyNM1/QMdorrIhtj+W/4sCTZHDaJebXOwBjuXw43HHSvNkbIkgA/jwi2e
	CJKZfuLfbshvW8vHRdTQoWIFPk+yEzTtRO+PsHuzVuV/9s4+avpdZ16/u1DJuejQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rez7Q-0000000Al16-0b6K;
	Tue, 27 Feb 2024 16:11:44 +0100
Message-ID: <f7e9edcb7c1d08144dddcd493aff869a80888cd8.camel@sipsolutions.net>
Subject: Re: [PATCH 2/6] wifi: ath11k: add P2P IE in beacon template
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kang Yang
	 <quic_kangyang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 27 Feb 2024 16:11:43 +0100
In-Reply-To: <3582b1ea-e103-4b7f-b34e-6457964bdb93@quicinc.com>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
	 <20240226060203.2040444-3-quic_kangyang@quicinc.com>
	 <42652a06-33f3-445a-bd8a-da4633fa52f8@quicinc.com>
	 <b20fc717-654d-4e64-920f-699fe3ec5598@quicinc.com>
	 <5c5ad99d3c2f3b9915b440057eab6618639cd31f.camel@sipsolutions.net>
	 <3582b1ea-e103-4b7f-b34e-6457964bdb93@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-02-27 at 07:05 -0800, Jeff Johnson wrote:
> On 2/26/2024 11:32 PM, Johannes Berg wrote:
> > @Jeff: NL80211_IFTYPE_P2P_GO is not used by mac80211 internally, it
> > translates that to vif->type=3D=3DNL80211_IFTYPE_AP && vif->p2p=3D=3Dtr=
ue.
>=20
> Yesterday I was looking at another patch and while doing so noticed this
> as well. Too many years of working with our downstream Android driver
> where we use the P2P iftypes directly...

I do sometimes wonder if this was the right decision ... but I think
it'll be quite difficult to change it now.

johannes

