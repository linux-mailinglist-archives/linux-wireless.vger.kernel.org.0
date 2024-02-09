Return-Path: <linux-wireless+bounces-3409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986A84FCE9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 20:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF0828F751
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 19:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE874E3A;
	Fri,  9 Feb 2024 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EdjSMCDK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492882866
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507175; cv=none; b=XJ0P5zvutp6v7wpZxQoeGscYaFITryX4wbhcUTzxL368eAPn3FaSkKzD6MIA72jMQYh+qkzT1v4G1zMDopUWHlIEwMQz6REBsqqX+2u5+oKTe5oEhg2Ms6SXu2hNe9kntK1RwkgVmnI7/mlAedF5d3BCumwPiKbN35jPxYcXTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507175; c=relaxed/simple;
	bh=BXqFgpDauNuiWmnVG1m9eeAtSVwQFJXVDIzKMAUiwz0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9JX86tM3J3Eeid5IT3TSolBLwE2pE0eRceA0jHfFYrwPXylE31c2pwfXM7JgOikiQOyJCyQKrX/kMKRGNBIWhXTmd5tXW8wmVIlWOC/6qV12gpjhexMD+/n+prOIQa5GGyM5yDWDLARN5+2Jn/7ngUT9H8OU4xWMRPRGiBm628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EdjSMCDK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L3r7jiMaFIQSUlzx3fyDZAoO1VpfT68htmj+rfkd5Ys=;
	t=1707507172; x=1708716772; b=EdjSMCDKy05dsfQtomUESoLv8HormsUBuVr+yWFydcjOHDr
	HB6p8JHQwSxj+B4ze/jlLKmsMV0qhyK6kIBeKmQla7yEWFywT1Cld1XMXdKtc0Nwylm3xe0+e6vYR
	V4l2SE033KqeVcrWfQxh+83J86X0I36iADsEjVkexhwzU/pzVsW80odE8Dlp4lWqxvEshtdX9wBP0
	LIn+bFrCzGsYlepb94h4MVfS/7nWKmSrrtoAxrp09R3wd4u6t24ayVab3aGXZIQeNhVh0U4Y6TBr7
	QO2YhNY51JVbrYDQpOKg4e8lNqHEqBx3tN8giWztrLjdzwiWO1lVN3soVRoyupBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rYWc7-00000001KO8-2wFj;
	Fri, 09 Feb 2024 20:32:43 +0100
Message-ID: <d3f6cdef5b05fba8eadedf67129c9c49471a08f0.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 09 Feb 2024 20:32:42 +0100
In-Reply-To: <20240209184730.69589-1-nbd@nbd.name>
References: <20240209184730.69589-1-nbd@nbd.name>
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


> -	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) !=3D 3)
> +	n =3D sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high);
> +	if (n < 2)
>  		return -EINVAL;
> =20
> -	if (ac >=3D IEEE80211_NUM_ACS)
> +	if (ac =3D=3D IEEE80211_NUM_ACS) {
> +		local->aql_txq_limit_bc =3D q_limit_low;
> +		return count;
> +	}

If we keep this, it should probably check n =3D=3D 2?

But not sure I like it - in other places ac =3D=3D NUM_ACS means management
rather than not multicast; could we just check something like

	strncmp(buf, "mcast ", 6)

instead? Or "BC/MC" matching the output? Though we don't match VO on
input either.

johannes

