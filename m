Return-Path: <linux-wireless+bounces-25185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440BFB005E9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 17:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF454E1D75
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BA270EAD;
	Thu, 10 Jul 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tKwqQFSB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22262749C6;
	Thu, 10 Jul 2025 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159852; cv=none; b=VYd60YEpE1tMHoSN5qa5DstfzzSldSC+8oK8oiAyAZ92f14nf+ukSdCCr2z1NPCev1NR20MhCWEQuKbcDLnKs22pCPcn7NURjHEqqEudLIslzoXGrjwVGpGNxwzXtqNuI7f2OAoBhLPp7nhwmNun+y0oNYE2v5jvbJWM5ZhRTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159852; c=relaxed/simple;
	bh=T0/vAK+rcjj6nMSP2hUPXvS0f96eutNXjj59x3eyc/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIzfOQTPq58/A5rHtRSKLZB+PSkU1uN+5Kys9XvZU+O1qxvp4iYUOWXqz/CqRX07yDJhg5BwGujGu4DKohOygMVtit1vOh7HD5PblaL1V4wdk2TSW8Ymqh0DIaNnzCrRZEMBDdDCNHgnzEQTHo5iCt/COmOQ0PXUMQ1PnVD+DVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tKwqQFSB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=T0/vAK+rcjj6nMSP2hUPXvS0f96eutNXjj59x3eyc/w=;
	t=1752159850; x=1753369450; b=tKwqQFSBGInw9N00t2yWq6iuLiC5v6qbA2Qn4E3ICZ444T6
	21f6iiKNcY0fxv8SPN4AYV7MflR7QO0S4Z6LH4k24TQoOVgynCmwB1v2clOM4iLd7/qHLmasxIVPK
	wPn66JUNVN8k2v4DqM5ftZ7m/u7Olfzd8/XUxSkxmLrRfzgFspsNIFZAYKkbJHOGj8QaHhwE/DkE4
	W26vhyyA5Dg2vlwSTyxwDnvN2WGhguEejOODRrWR7Oe1JiiagDPPpl14FLhv9rORdbOqXhPY1F4Ai
	sSp59/EP1ysb+Egtyn7ylzLRJk8BIfxcU2rsq3S4FKFje1YnHZKbCbz28QFWkFJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZsoi-0000000EtXo-28nL;
	Thu, 10 Jul 2025 17:04:08 +0200
Message-ID: <3a2e91e108c2155137d7a89be296de70178c2614.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix unsigned int link_id format specifiers in
 trace.h
From: Johannes Berg <johannes@sipsolutions.net>
To: WangYuli <wangyuli@uniontech.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
Date: Thu, 10 Jul 2025 17:04:07 +0200
In-Reply-To: <2D6CF44B8B2BA412+20250710145043.331831-1-wangyuli@uniontech.com>
References: 
	<2D6CF44B8B2BA412+20250710145043.331831-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-07-10 at 22:50 +0800, WangYuli wrote:
> Fix format specifiers for link_id fields declared as 'unsigned int'
> to use %u instead of %d. This affects several trace events where
> link_id was incorrectly formatted as signed integer.
>=20

Why should we care?

johannes

