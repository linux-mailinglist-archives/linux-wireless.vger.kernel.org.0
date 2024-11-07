Return-Path: <linux-wireless+bounces-15100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9283C9C0922
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611F42847AA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220D212D12;
	Thu,  7 Nov 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aBBxzSrq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E22212D21
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990602; cv=none; b=fZHKpqCNCHCOmFaiODtCOSrEys9cny8Oxvh7BoCUHkVIVXwPOnGyBLi7Teq1VH//nCFHkgnpg8wHno+1xR5KoLo//66EMrw6T14nglQclUWjd7+LTSvWchx9HZG53Ny7IAWTuBBrAgWd3I2+m96tg/ln8LqaxJs/4YtqMGrYlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990602; c=relaxed/simple;
	bh=LWcwKtjM3IfaNUsTW58fnr/taI2PRVbxxgZLmVbZZVo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtcB9I/p5hJataA27rSCWlR0Q+FgA3IoEzcfkBrUPdB201qkducmvevHd2jFBf8taHHNvPcLqzgo6FH9s42U9W+VGzqPVu8kfjoLcJRHEzfxpmYnJ9D9M2yn6YB4EB4Ske+N7w542uG8pj3+IMFCXebwto65tqKz/G6msaLVO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aBBxzSrq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2YPEw41MM5EXJUZJ41g+OWBRiZwko6U08g8AUSYHwSo=;
	t=1730990601; x=1732200201; b=aBBxzSrqZJh4S4kqN2hyJ7gyJp431MEu2Aj48ldVI0cM3kR
	/gPjOroYrvvxALmX0o6EoGi3zvCvqRQbieUCzeCPFBTIFEZe0sRcS7+UG0hRjMZlmH/k37oKsDuz5
	oN8+obPNnk5xt87KTPWbCWtuwg6flnEkcLB+PbSEc5DRvRyiqn8EFw/nbcfAlCz1ci/uLArlB/4tH
	3sy89JqYLCpupONtzaK1+8jQkPrjoCqqRTCrdHoSlMJ4Ogy0ll355qvT5F51pHkaD391UheGzLqlq
	gn+hvTgiDAimQyrMXFnkhOAofvRjWIi1EvoHGG7Xfw4jN+Cna813iI4lCXIiJ3LA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93jD-0000000GSUF-0Rr6;
	Thu, 07 Nov 2024 15:43:19 +0100
Message-ID: <73b1eb45e666aff20cf1debfdee1b60b44b82b46.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 15:43:18 +0100
In-Reply-To: <20241009164904.3906438-2-greearb@candelatech.com>
References: <20241009164904.3906438-1-greearb@candelatech.com>
	 <20241009164904.3906438-2-greearb@candelatech.com>
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

On Wed, 2024-10-09 at 09:49 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> For drivers that can report the tx link-id, account tx
> stats against that link.  If we cannot determine tx link,
> then use deflink.

I was hoping Miri would look at the other patch ... but now that I
consider it again, this should probably come with some documentation
updates? Right now, it only says:

 * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
 *      frame should be transmitted on the specific link. This really is
 *      only relevant for frames that do not have data present, and is
 *      also not used for 802.3 format frames. Note that even if the frame
 *      is on a specific link, address translation might still apply if
 *      it's intended for an MLD.

and actually it's in the _control_ section of the TX info, so it's not
generally even preserved over to the _status_ section.

So rather than reusing this, we probably just need to introduce a new
_status_ field for it. And probably make it link_id+1 so 0 means no
value (this works because link ID 15 is invalid).

johannes

