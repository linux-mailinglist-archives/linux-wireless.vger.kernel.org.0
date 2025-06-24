Return-Path: <linux-wireless+bounces-24418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC17AE60DB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B581192597B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783824EA80;
	Tue, 24 Jun 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QLrkLLUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439E1ADFFB;
	Tue, 24 Jun 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757462; cv=none; b=TwE6e8wx8gqUsEOuvRi7WgEWN0fYavNRJqrv/zqGPy1ToQPj/HPs/jn6hEfkoN2H1mKaxeGvJQM5eGiSnd03aNqZuQuaO74xWriTSzZY7tu0fHHYM37Mlw+X11PtDmO9hMM9d+Bs4J3a6rVSgPXVKuGVkL7TYf3+aYmFW9vjvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757462; c=relaxed/simple;
	bh=pOU5hYJwHu5wTpTam9JSbX5xS+6tNug8uqlx4jsp21U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4WhjNKtNv9eie1e/IbxFxMBcFdXE4NTuhiENveX3Q0XhJ9zgU+ynIZHqg3LuNIJx2zuuP6XJSiRmVOXxlLrCG3DqUacOVoPxJcAusJBJg3ki4fkudsEpvC28YD5BSEBXwG0LPLX53OJ/PLB+EhhR79GZuzA+91SofE9bD2buLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QLrkLLUB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pOU5hYJwHu5wTpTam9JSbX5xS+6tNug8uqlx4jsp21U=;
	t=1750757460; x=1751967060; b=QLrkLLUB8l2nMRRqeSyVNquuv3IA9HTh+fYuLPEDh3wbTUn
	mqp9NoHbNQ8q7uKz6iBx87vsfyCzyJsye+sg7h2ioClYDmjHFNTFJZHPXXxEoeiSSNxfTilFjpbDu
	sz1LHf7nP+hRPI/doGg42CtXkCNvinN7yMfacgmikKjPrv5DAbvW5K2W4L7XOVTrw5/XMy3jtQlkp
	mgn46D/e2ZUDly70Sm1iQqn1BTb4aI10U4NZqfkrDL0OFKRlc1ccsLOpsaJ4pp87G6FiAXH5TsGDS
	qpzOWN+Fq+ckd9eUJCHeap20ysM5uLkaqZpILjlE5sBaW3jCw9XPMIGs0G/Gouvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uTzzN-00000008jEx-275n;
	Tue, 24 Jun 2025 11:30:49 +0200
Message-ID: <845f93f9a7cbe6e89872838dca35a3e43a8abbcc.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] alternative changes for NL80211_CMD_SET_BSS support
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, Gokul
 Sivakumar	 <gokulkumar.sivakumar@infineon.com>, Ajay Singh
 <ajay.kathat@microchip.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>
Date: Tue, 24 Jun 2025 11:30:48 +0200
In-Reply-To: <20250604085539.2803896-1-arend.vanspriel@broadcom.com> (sfid-20250604_105548_328700_E0654003)
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
	 (sfid-20250604_105548_328700_E0654003)
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

++

On Wed, 2025-06-04 at 10:55 +0200, Arend van Spriel wrote:
> Here a series with my idea on how to solve the fact that drivers may not
> support or handle all parameters contained in NL80211_CMD_SET_BSS message
> as sent by user-space. The driver can announce in the wiphy info which
> parameters it supports and user-space can indicate that the kernel may
> enforce strict checking for the NL80211_CMD_SET_BSS.

So since we have the two alternatives now and there was no discussion, I
guess you're looking to me to decide ;-)

I like the way you here expose to userspace what's supported, and it
also seems slightly easier for drivers to just set the supported bitmap
rather than checking what was given in the callback?

With your approach the userspace check is opt-in, though I'd probably
structure it so that for *new* attributes, if any are ever added, we'd
always check, regardless of the strict setting.

I have some quibbles here, in particular I don't think
WIPHY_BSS_PARAM_MASK should exist, and mac80211 should explicitly list
out the ones it supports (since new ones could be added that it doesn't
have), but otherwise looks fine.

I guess in summary I tend to prefer your changes for better handling of
userspace backward compatibility and less driver code.

johannes

