Return-Path: <linux-wireless+bounces-2542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57683D73A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E61729BCBE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321C66B31;
	Fri, 26 Jan 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k496yD6T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD3657AA
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260320; cv=none; b=GexzCrMYiOHE7wa/+2eClBmYLuNVBpIIjBCiyukbmV7FonUfYHSLu4wgin1Tkh19AevGencshBRDCugqaX7sl5+/BdMjDvExCYpaH+Nsx+J6vaD+h8Q7KH+hVsEtwj+yO9kER7C4A/hI5A1Kcr50VHRSYHkz7vp3qHpm64eS4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260320; c=relaxed/simple;
	bh=ONCfGHHd51GrVZcWhP1DMx1GXU4MJKFvrxBW7QtlNLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgsXI2u3Xl5yOXlf6yb2jdm/BQHy8/Wgv2HP8uqK1pDODtFXJke3gqvInk78mpYbKK2oEsJkii8NQsTUMJWYzsdyQmKtp2olls02l2DQvfF8xCH2QwsfCEyhWyvxOm7EvKFZGj1H+WHLpzXmhq37dmh0t4Dme/OjzrYYCYE8egg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k496yD6T; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QK7OiIxwK47r23t0OBCMZVZnDcUXroUsGg2UpzxRL2g=;
	t=1706260317; x=1707469917; b=k496yD6TRJQAj/uGY5KtBento2vHhK1dcK5Z3GOR6xuL2Yp
	O0gK2iE5iW4sxnHoBvRJMWMFvlxaYoxioP+9HpiD4+GRczDQkAk1gpTP8fzPl8akIR1cUTh8zKV8U
	4arXRvdeXoORtKg5Fnix3qpMZnyySnmTucSyTnpzLJb4mAKtVmzir6zi4QmO7ZBXSjpzcX3vTqFZU
	5il9HU8afcvSRIy8LhWt/vMuLnq5bZU3wwyNUux0afR76L0Qzppc/fIJhmYmd9FcWfIPzRmW8TsEU
	Msi0I/Pmvjep9UiaqCVqntUZjflxQvFSNtDu3fWyIaIoJnNFx2RaVqX72c8eKgjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTIFe-000000014IZ-34ek;
	Fri, 26 Jan 2024 10:11:54 +0100
Message-ID: <3a56c591a03a17e4ad1332b88bcd5790346cdc7c.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: mac80211: add link id argument for
 sta_flush() function
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 26 Jan 2024 10:11:53 +0100
In-Reply-To: <20240125125855.827619-3-quic_adisi@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
	 <20240125125855.827619-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-25 at 18:28 +0530, Aditya Kumar Singh wrote:
> Whenever sta_flush() function is invoked, all sta present in that interfa=
ce

STAs

> is flushed. However, there is a requirement in case of MLO that only flus=
h

are flushed; The sentence starting here could be reworded.

> those sta who are using a given link id.

who -> which/that? They're not people :)

>  This is not possible currently.

reorder the words a bit here?

> Hence add the support for the same.

I think (and hope :) ) you can improve the commit messages ... Maybe say
"Add support for this by implementing the new cfg80211 API ..."

> Passing link id is done currently via cfg80211 op - del_station.

The mechanics of this aren't really all _that_ interesting unless
they're really complicated - we can all read the code if we care about
that part.

johannes

