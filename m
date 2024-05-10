Return-Path: <linux-wireless+bounces-7444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DD8C2112
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB841C212EE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3115FA87;
	Fri, 10 May 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oS/5nPAs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AB161330
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333800; cv=none; b=Bh4csQzuGnZQXuZ7KNv56nAHFVF8wvEG4EPPkzdYkGF7ZrnmtZQi70P4PeuH+oGl+0cPxXiWOizYFQscPpeuoji8ITHum9sQdUHAdjSHfG8j89H2PfHtP/GeeSVBi3gaEDkkDLBaVHIajQc/xGUfC+vWfM467ngoOmKrYxewcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333800; c=relaxed/simple;
	bh=8SUPzS2amRyBVXL9koHf1wW7CDp3H+RsFaqDHuNWdU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlxcsberSopCx17YMDY3+Bjk78fqYo+6zhMMf2qB7JiaTtSKAVzlYO5ExaV39AHEhph2iiAwgGgzuTuKN7MjVyLGmcSJLTVrBbDgTewwkzWSXtup8za9bbG7fB+bt9Yo7gukXPk0FCFSGyW7QHY8qicelP6yJABdjLxND/KQdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oS/5nPAs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8SUPzS2amRyBVXL9koHf1wW7CDp3H+RsFaqDHuNWdU0=;
	t=1715333798; x=1716543398; b=oS/5nPAs/DklTAPRkoYsiprWl2piPht8ZY7rYLmSu4ZgWDL
	5/VlkLN/P8tqNCGkPbENdm1mnL0lDn1/hFhYfR5ZiM+/DGgyvrhrrbeum1kFxUPyw7gt4xHkQLxVE
	N74I8JVt9Vp3w9jAGJM3ThtKHsyxyOE6ZhHShWuYzHDceIUuk5uQ2NoeZ8+c0gy0zWo/lkByNXBq6
	KLMzD7FxEqteiLnVfD8Dv1Vb9VrSjhFSpBjzMRhN5t8zlctRZWnn5eeZT4O0NkEyhGqso201XSrkG
	dIZZzl0U2G3ZiNNGzrT8to4kcTFzKyCfJV7v8GHI7iRhUGUEIimDOWnPUaZDii5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s5Mg6-0000000EkuG-2lZ2;
	Fri, 10 May 2024 11:36:35 +0200
Message-ID: <113b4bbf58565fcc84db0ef04338aef9eeb0d2f0.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix 6 GHz scan request building
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Ilan Peer
	 <ilan.peer@intel.com>
Date: Fri, 10 May 2024 11:36:33 +0200
In-Reply-To: <20240510113244.b5f4ef741cc6.I0cb19188be17a8abd029805e3373c0a7777c214c@changeid>
References: 
	<20240510113244.b5f4ef741cc6.I0cb19188be17a8abd029805e3373c0a7777c214c@changeid>
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

On Fri, 2024-05-10 at 11:32 +0200, Johannes Berg wrote:
> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20

Huh, I didn't mean to add that there, sorry. I have to take
responsibility for almost all of this, just squashed in a little thing
from Miri about the SSIDs pointer being NULL when n_ssids is 0.

johannes

