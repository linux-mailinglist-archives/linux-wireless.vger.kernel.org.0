Return-Path: <linux-wireless+bounces-13511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E2990625
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25961C2180C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B0217906;
	Fri,  4 Oct 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qt1TIu6e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34962141DB;
	Fri,  4 Oct 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052345; cv=none; b=YgOMnK1i4aPI3kPxqwDEq2aMZ6gWgdOeXb6doXzvjFXDEaJMztPPtVkwcD2+U0WBLfmeLksIYm3N8x0s6LtjTj04NpCz+3R4KLY5ENoJcHcYPeUeY3AY5tlmpdrxQ3fQSHmmN4V8uPjNEUzeuRr89LyNJSj7D2AntZ6TZHuZShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052345; c=relaxed/simple;
	bh=c2rK3yLoT9rGelUuUHpH+PCjDo01JmJtLXCwJGFYb+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NylltjE5vkxdjU7HFrNXsJmTJJNsUai4e7HvYW693OGagMS8zY3IylZvAYj9/vj6l+pxfbJVnyubKD8qo8iTCuw/4qNB6j2y6hfYgBVx2SmCyuHnrk2cpLt7131gjZEkVngniw+h63VfluPXAfbIqakOkEHKb/8SqiO3KhVcSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qt1TIu6e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c2rK3yLoT9rGelUuUHpH+PCjDo01JmJtLXCwJGFYb+U=;
	t=1728052343; x=1729261943; b=qt1TIu6e4QvQoD3SPspqnDfIupSFPkg1l1M2MAiiw6BPN7X
	BCOJMAFxc0popBBmMkuc28DPUq65x8sFPvrAQPOe3cTBjJ3S6Nmg2Nosp/6SGRJrH9jyaWFELpM/P
	fP2+aigwBsSnEDgbKkA4buz1irlcdbEpiRD6alw0Eq85b2wQYI5N76xJ4VCiNUbeWALDZ0HUxc3+M
	2sF1+N30+YVn9rDPuRwspEg9472A/pyDX586W5Mn8Jb+i/haC57yYcqkW/pvc5O8Q/I6ZcvniZo0N
	pZz24GLSyzCchYF8JjltTaMD11foP3lxbv2ClW4xjdwKItiQ9DnYVkVgOhVHauqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1swjLl-0000000HUMw-2zAw;
	Fri, 04 Oct 2024 16:32:10 +0200
Message-ID: <4f827b3720bdf09768651d4b008c9716f467c9dd.camel@sipsolutions.net>
Subject: Re: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Fri, 04 Oct 2024 16:32:08 +0200
In-Reply-To: <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
	 <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-04 at 11:03 +0100, Simon Horman wrote:
> We already exclude wireless drivers from the netdev@ traffic, to
> delegate it to linux-wireless@, and avoid overwhelming netdev@.
>=20
> Many of the following wireless-related sections MAINTAINERS
> are already not included in the NETWORKING [GENERAL] section.
> For consistency, exclude those that are.
>=20
> * 802.11 (including CFG80211/NL80211)
> * MAC80211
> * RFKILL
>=20
> Signed-off-by: Simon Horman <horms@kernel.org>

Makes sense to me!

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes


