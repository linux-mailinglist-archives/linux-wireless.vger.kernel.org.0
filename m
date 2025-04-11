Return-Path: <linux-wireless+bounces-21446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA7A86057
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B7A4A12FD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E351DF27D;
	Fri, 11 Apr 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tA6go3xn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA710142E83;
	Fri, 11 Apr 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381008; cv=none; b=kbxvt0qmamVVV31itAxFyMmSIEtp/2i/aXyQs4oiptbZVjt+J8FENMzV/9M/RcjmF0S+jSru41qvUHz/xfxYtUnB0uHeXk84j8Hsy7wMBT0Vbhd2Mg7BPM7shS55WnHsnTQeOSTDHQ5UoEtIpwZFV9X7CMDZFzN7MzG9gfVt59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381008; c=relaxed/simple;
	bh=NgSspYQjjtxV6nQ1JE099Z0EhIrP3J6QIaliJuNZ/9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRkoZZCTYEfYRc5OHcCrvWOdBaem7zVhvkOaguySaM3+K5k51RAP6toTUC9Dby3p1AMep3bWQSDbQ7Xxu0Ge7jNkHyN82ko0TbkvlzmpQ2HKTZtWtktwmUfb7H8zGrsoMVZKW/yq4sJdi8g0U8S62c2l9Ig49hVjVDhQJ/C+eqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tA6go3xn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NgSspYQjjtxV6nQ1JE099Z0EhIrP3J6QIaliJuNZ/9U=;
	t=1744381006; x=1745590606; b=tA6go3xnzaskVg3OcVXnTP1QeBU/vhgxtX7xuCx0FFLa1PI
	R6b8Ov+H9djbQnh1GVnvgL1mVFmy34PTW+q4uQEf7dKPFgnxCZyuw+b3/eWYZyKfW4ytBAzbN1Yvc
	Ub4Zbj+t0DYEFsffQG/fz2JNdBbyDNjLooveEDhSiynvGIrKrGrYLeKpZ7b+OsfVmcNf2X5D1lVe0
	5Gw46vjLSkPd9ZFXwQgxBPhwouy+zCJbo1ETQfL2KigLVrXKr52vDfRfwa/nNI+iYStLtXq3zbnqu
	sPNYmAsIMEMTlP2c5FZVSMs2UFgRwtW6FEJqVUpWjnm17rK+Goj1Z9nsGlP+kjuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u3FBT-00000007h0y-3jSV;
	Fri, 11 Apr 2025 16:16:44 +0200
Message-ID: <2dc343bab463c629754ad69245e5fe2955a58cf1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2025 16:16:43 +0200
In-Reply-To: <20250410215527.3001-1-spasswolf@web.de>
References: <20250410215527.3001-1-spasswolf@web.de>
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

On Thu, 2025-04-10 at 23:55 +0200, Bert Karwatzki wrote:
> This commit breaks the mediatek mt7921 wireless driver. In linux-next-202=
50410
> my mt7921e Wi-Fi controller is no longer able to connect to a network.
> I bisected this to commit a104042e2bf6 ("wifi: mac80211: Update skb's con=
trol
> block key in ieee80211_tx_dequeue()").
>=20

Thanks for the report.

Remi, I see you've been debugging it already - thanks!

Nonetheless I need to get a couple of fixes out, so I've reverted it for
now. We have a couple of weeks to fix it even for this release, and the
bug has been around for years, as far as we know.

johannes

