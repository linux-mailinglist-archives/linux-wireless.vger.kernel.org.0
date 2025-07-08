Return-Path: <linux-wireless+bounces-24955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DFAFCF2B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 17:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC37A5682A1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48B2E1C7A;
	Tue,  8 Jul 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gBQ5dSSg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042792BE042
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988371; cv=none; b=L8vcsXcdxF3IYsvea2nKEMmLBvTIdLIsxVTR+muE04e/zh6MIC3EqN69LAryCUAMaYY96b7Mr6a08X9/nZC9tzCjopVse0zcbcpKnOJMAZIbGHFvL7zsvZCzrIPZq5ycIWeNZDmCNKHI3SY+BPhv7nxEXa4eQxrkk7GcACI5abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988371; c=relaxed/simple;
	bh=PzRCamzAryM4qVnQzurRdf8ZRO6DcWB2CI47zbDLJ08=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9IY8R5FZfiWVZJprUIOT1EY1Gp+x8KnSyPBHt8bASXrFlJIglD7ijX4Uj3S292PBaeJ0cKn7H854ii0MaVMksdIqyviFCN/iDrfEAB3R7Fu4s3tSP4V1CozjGYZbFeDk5phEAdADaXXWYKeSa6arACCpVndOgKR7ZsMpZFqlZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gBQ5dSSg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kT3qZnijMzn3X2PbyZy6ULleL0IZeMqbpLgEQ3j4q6w=;
	t=1751988370; x=1753197970; b=gBQ5dSSgys74j8FjWlr82Fzz5Z4lnDMer5eZBR4TXNgsa+G
	1gX8zbz+YZuSsypDh3gwCnBE3cAW+LEWB08XLkQULbuxR8gfPNSzwBNZe+4HqySqcgDt6x5sMohUC
	bj9Y5UjYbYAjPDlqxBQ2mBsnTj5Z5LZaGauSEG9bJoNjZM7RBSaXSjB9R+jyxt0yNNmi2T5Ic0J0P
	kuB+VpFJlG6ikcMJLJE4b1AoiYYKWstouNADwMnNPCcQPbpe0PeDhxxpOH4piTOqKxZGYT/PNibfJ
	Y9Woe2MFCOaJGeiHIMc+LqkpFd6pGzezIgAfEQsfRiNGe6WfxKHy779zheO75WKg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZACt-0000000C1SW-1WgR;
	Tue, 08 Jul 2025 17:26:07 +0200
Message-ID: <b1d4ec44d7ce817ffb98db7293578c6a9b1351fe.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 17:26:06 +0200
In-Reply-To: <9161a3ba-e5b7-4cbf-ae1e-242e1baf5040@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
	 <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
	 <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
	 <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
	 <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
	 <ca3395ac1d47fe25b57df7da692a7891f02d88d2.camel@sipsolutions.net>
	 <9161a3ba-e5b7-4cbf-ae1e-242e1baf5040@candelatech.com>
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

On Tue, 2025-07-08 at 08:16 -0700, Ben Greear wrote:
> On 7/8/25 07:46, Johannes Berg wrote:
> > On Tue, 2025-07-08 at 07:32 -0700, Ben Greear wrote:
> > >=20
> > >=20
> > > So I added new counters, and I wanted them named to indicate it is wh=
at is reported by
> > > the driver, not something specified by the mac80211 stack.
> >=20
> > I'm not sure what you're arguing. I know you did. I'm saying you
> > shouldn't have done it in this 1/3 patch, but rather in 3/3 or maybe
> > 4/4...
>=20
> So you want this moved out of the first patch too?  That makes no sense
> to me, but if you want it moved, let me know to what patch so I don't
> have to guess and go through all of this again.

Of _course_ I do, I don't know why this is controversial to you. Don't
actively _hide_ something in a patch that purports to change something
else entirely. This is a whole new feature, completely unrelated to
"assign tx-stats to the proper link".

johannes

