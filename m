Return-Path: <linux-wireless+bounces-20766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B2A6DF25
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1797A29EF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0425F987;
	Mon, 24 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CvRmnArU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0135F513;
	Mon, 24 Mar 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831878; cv=none; b=XE0ndAkHn8PEsJUOMwRnevSG//oVKCaeySrVrYSEkQUF1akp621GSdsY4XFDlpqEnG8s+dnDM1bR2RMpJeojGYKUUKYAUgnEwk7mZFVRMUuSiEc2DqQnrpBX83GNZ3o17mLTmqgWs9/qc5t4/75e9AXnMRcUhwhB+o73bzcR5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831878; c=relaxed/simple;
	bh=5r8AlL2ffmIbggkYPtSdJqc/B77+6FQNDur1gioL7I4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPxirLNy5inR75Vs4Y+5nmHVHrfZRz73YoUk8lXRMZPVoWrfRCxnYvGrVKKlO+/wDN5Y/2o/SE8Mu/3zTMT3E0TIpPDab4xcaw49/UjP8LO+8eooA4B32P7GHhsR7Ifhvac2eg2zeP2e8Y6cTXCe8TE70TCiLUlvWGwDIDmsRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CvRmnArU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZKwMImC4qCYtUzcYIXLCOqJqgdxuv6+OcOX/N6RFy6c=;
	t=1742831876; x=1744041476; b=CvRmnArUQBE5V7dMBAiAXWYzMaTmwjVK98lxWMEbkYqdVNE
	vL01fi0/EuqP/f0hPiJTn2f5S1G1eBqKcfw3pstlP0xxstaJ96r8GP6QrUF5gC0MqT+5qY0wF/C+1
	v5AeQzyaw41jzAXb3NgD4ikU3A/nKCFY49GbTaHXlA1CQUntcDO/U1oOuc6lgayStVLP8BGBuGwtG
	RrMi3g7v1wd+4t9qK/OfJheYChp3gdBjdsTdUJPeChkue+gdZ/WaVZs0/lWN6HmGUpkpHZ3fHS9X0
	ko4XUJhrwad2/i6rN4YazjDj4dXRxvn9iCNfRgko0MVRxtqA81ASGCuIbwAqvSfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twkBV-0000000467T-2wro;
	Mon, 24 Mar 2025 16:57:54 +0100
Message-ID: <e0ac6ed58b71f0293ec576b45c8e2645c0695d52.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 24 Mar 2025 16:57:52 +0100
In-Reply-To: <20250324085340.46864b77@kernel.org>
References: 
	<20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
	 <20250324085340.46864b77@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-03-24 at 08:53 -0700, Jakub Kicinski wrote:
> On Thu, 13 Mar 2025 13:49:39 +0100 Johannes Berg wrote:
> > Someone mentioned today at netdevconf that we've run out of
>=20
> Don't recall the mention, but I'd guess maybe Jason Xing during
> his timestamping talk?  Change itself LGTM!

Yeah, I think so. Timing would be right too, his talk was around noon
that day :)

I guess I can merge it through wireless for 6.16, unless you have any
concerns? I can also resend it for net-next after the merge window
closes, the wireless drivers/stack changes are almost certainly not
going to have any conflicts, but overall it's trivial anyway.

johannes

