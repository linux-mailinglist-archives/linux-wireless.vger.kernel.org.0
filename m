Return-Path: <linux-wireless+bounces-5977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D702289CBB9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 20:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131891C21BD2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6139D847B;
	Mon,  8 Apr 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O9YCL8kk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886913AF2
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601124; cv=none; b=MtFU0PZ3TBmzGD81fR9Ak4lEyk/BVspEPdJn3torDEggws2Pdr04TqkDXM/0pAkQ4yJIyJBBtG48S75srYq5CcSBG5fEOT1FdkflnDG6TVNrZV2+7nnCbgLPpCva7R2J6Chs0O+yFbc/WXEZ/Om0TbW+XWIHlW3UcW1nZuf45Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601124; c=relaxed/simple;
	bh=PDbgofTrvAtw+6zyfFvlQ6HE42RMeNgc826Glk1M+QE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhmCANLnr5Y033WBumgCIij3BNgfuHDdXHLO3owwj2S/rHsHAqanjYKJ4yb2FVhhr0Jpe82a/08UZ9XVFNtX7tlwSPjkEv4qM7fVAlPv+J2dfRoN6ltAJ8B18Bf/UAzsuT4ZYX6EWpacwyZV194vGYxc0ke4SH8Hrd4X1VjxKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O9YCL8kk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PDbgofTrvAtw+6zyfFvlQ6HE42RMeNgc826Glk1M+QE=;
	t=1712601116; x=1713810716; b=O9YCL8kkG41EN/DgbgJINvn+c5vIDJ4LGVa6LLOrfcNkTOL
	1H4HbgtTbQXqEpyGuGm1dn/FDBOZCioLLFqc2KXg4RQhzSRdx39S8sLhx2WkwOsNum3EWIAzEnP5p
	xXb28k2Q2qOX5AIv4Dmv/B7teQR/lWF3+Xf7EezL7spc8KtwipIEODk5MyEPYT/a+H9f/+enlKHvC
	g1zc37bW7QeOQIOJCCjwT4riCKjd6a/oY1q5FOtfMkBxg+BqIHDVzZkkZFtqVc8/CS4p0DBctU0BM
	4KxSsYo41RhliVosG2B5GWyULCXd0xGyE1h6QfVoHUj7BQPS1+vPLBubf6pSY6Gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rttmb-0000000GQLU-0j3u;
	Mon, 08 Apr 2024 20:31:53 +0200
Message-ID: <930cc3514cd73b837b9e818061215773444f0ecd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: handle link ID during management Tx
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
Date: Mon, 08 Apr 2024 20:31:52 +0200
In-Reply-To: <20240326045242.3190611-1-quic_adisi@quicinc.com>
References: <20240326045242.3190611-1-quic_adisi@quicinc.com>
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

On Tue, 2024-03-26 at 10:22 +0530, Aditya Kumar Singh wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
>=20
> During management Tx, when source address is same as the link conf's
> address and even when userspace requested Tx on a specific link, link ID
> is not set which leads to dropping of the frame later.

Sorry, don't understand. Please be more precise about the scenario and
why it's dropped.

Also, client mode, so wpa_s is actually sending a link-specific action
frame?

johannes


