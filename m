Return-Path: <linux-wireless+bounces-15103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45219C0AB2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620A6B22D1D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E75212181;
	Thu,  7 Nov 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QMDXrHRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111120F5D1
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995416; cv=none; b=IiTJ2Nqtya/2HuY0m0uXzxKZUmUooag4ipyN4MQvXD2ANOjZepc4lbNUwVgmlkkAnYVhZcFfKHSQcZg3Pb+0AueXCTYc2LF12Wc3QxuUNyzvmz3Nyfl/OXjGvMPtJe5sgOejxsaz/o0LZkPlD/UFG2iUO1aEnUH4gF7wzsPk1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995416; c=relaxed/simple;
	bh=UwD12zxoINccKUkOXLWaCWi2yMDdFbo6CeI1/2JPhIY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxPASs/WVnrhYCtaB3DITxdblXv48d3xibvTRBbgtweamEol1R+u2ODIV3/tqdZ4a+Nh+vMLmQSqkfEMMjzACRdwBrehNxYHyFc3A2ZapSUA9o7BYl+w3Cz19AWUr5fUTunVwF/KK2KpCdbsUYnShSe7+rFBubyN4rBDPonF+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QMDXrHRK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UwD12zxoINccKUkOXLWaCWi2yMDdFbo6CeI1/2JPhIY=;
	t=1730995414; x=1732205014; b=QMDXrHRKEJFV/B4aWI2J2XAXavehiwgOdEYvZ2Lpn73gnSd
	a62nyAk+Jaa83SSyxj5huinpMBjSndohFAVQZWvYRF4ltBcNUVlNdkVhaYEnjStPA2s8xKeP9ynDm
	KdxSeKxDP8dD1gKi95biWQkK1I9zgkrDIHlr/13nedAYlx+i+5OH+Qa/lXtAtCqRGOQZxnBxJ5kuD
	ytlWM4K/rvsy5G49bjRugcB5stD3pYAj2YlLN0EASjNlT56bz+YzaNss1KbKkN9RyrhZWVKSo8nwo
	oj8tnC3Zf0B2wikQXpIMQFgSQCx2JlHpwfjaBxFVzU0u1QQUVayQtMcGI/H4o3gw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t94yq-0000000GU6F-0B08;
	Thu, 07 Nov 2024 17:03:32 +0100
Message-ID: <6acbfb8eac3e14983a877334bd0470c424e752a4.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 17:03:31 +0100
In-Reply-To: <f42ab1f0-83d0-0a12-1389-2e37463ac910@candelatech.com>
References: <20241009164904.3906438-1-greearb@candelatech.com>
	 <20241009164904.3906438-2-greearb@candelatech.com>
	 <73b1eb45e666aff20cf1debfdee1b60b44b82b46.camel@sipsolutions.net>
	 <f42ab1f0-83d0-0a12-1389-2e37463ac910@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-07 at 07:51 -0800, Ben Greear wrote:
> >=20
> > So rather than reusing this, we probably just need to introduce a new
> > _status_ field for it. And probably make it link_id+1 so 0 means no
> > value (this works because link ID 15 is invalid).
>=20
> Where would you like this new field added?

Well I guess we can take four bits from ieee80211_tx_info::status.pad or
ieee80211_tx_info::status.pad2. We could also do it out of status.flags,
but that doesn't seem worth it as long as we still have the pad?

johannes

