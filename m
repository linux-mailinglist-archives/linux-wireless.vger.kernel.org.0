Return-Path: <linux-wireless+bounces-6563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722FF8AAB3B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 11:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A151F21932
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A25FBB5;
	Fri, 19 Apr 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pPxwaD6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E14D131
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517951; cv=none; b=kQ3aX6CkwP3ya/4F7mbK38BmZ2en1jby85nQ8SLaMNJ4HJ1z5ZLQEHD9u+OJcv8qcUNITwYv52XN1O20uWVTymRehx/A3mHK5GuNBosJCiOpV3DQJzpenP+cKQLhe7i3tZ/oUQXS1ihYRY0Sl6Xhiw9VwZLycmCuiA+ujeKb27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517951; c=relaxed/simple;
	bh=IzRymLyOIrJMXQFyJWlLBNLGOcrcNaNfCR7RdoWh3/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=crULsSTliBTsL7v3iP3rByGaCnm0iZocntnzJGWjq9Lmd9oxtOWTTFSYIeLBUpP9ULiFoPpioqDfrAW8hSd8wXzsawd7XxFO8RFUAopDm03fOI8VsNWPBJ6M+8TVTkJSNb1FgWhg0jMp24FXbVuN2LAUbdE5/hFv5XdvkMOzGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pPxwaD6t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IzRymLyOIrJMXQFyJWlLBNLGOcrcNaNfCR7RdoWh3/Q=;
	t=1713517949; x=1714727549; b=pPxwaD6tDI3J6CbZEI2SywNQF0avBPomzeJQweLFlVslcbk
	iJAnpNz05k1n5SrBLfCxseSaVMbFoaAKNeBE+Izh/Y5vdX7GAC0toYKT2eYTvJxZex3uAax+XPHWv
	/agLoImpInOGEscrvrsBvFeGmGyfCk9d5GolVYk24ma58vvcgYFpBRBKdai7h0HCn7u5PCWflti0H
	KXyBImo44mHnPRe2YgY9fFDWk5fU9BXyfYLj/nTrxaExVz5tVz3SCkYwJp8WESJ6maq1GEMr1YHM8
	c1CwUk8HJm9hMYjK90ppHSONctn8c2hgliW1SlZZ9Pg1r0Kte914CkG7g+C8GRFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxkI7-0000000Dwwb-3Sxv;
	Fri, 19 Apr 2024 11:12:20 +0200
Message-ID: <e4184e8fb0cd4573564ed8daace08c432757399e.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] wifi: cfg80211/mac80211: add support for HE BSS
 color handling with Multi-Link Operation
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 19 Apr 2024 11:12:18 +0200
In-Reply-To: <20240416045943.576656-1-quic_adisi@quicinc.com>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
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

Sparse complains on these patches. I think everyone at QCA should be
able to *consistently* run that.

Jeff, do you really have no internal processes, it all depends on people
running checks manually? We have our own internal tree first, where CI
enforces a whole bunch of things, and *then* we send patches out.

That obviously *still* misses things and I need to review etc., but
getting the trivial bits sorted out before the patches even hit the list
would be useful.

(Also not sure why no bots complained about this set, it's been a few
days, but who knows, maybe they're just behind.)

Also this set needs a rebase now with the kernel-doc update, but I was
even willing to do that.

johannes

