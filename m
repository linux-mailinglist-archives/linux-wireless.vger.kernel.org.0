Return-Path: <linux-wireless+bounces-2543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1483D748
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E174F294E32
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD431B800;
	Fri, 26 Jan 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yAQhMwRc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C81B582
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260690; cv=none; b=skrtjnIdDaIuw7nVPpoQqHlqMBOaTpaibPk1avlbmgDsA5OciIQ5z90hGdk9+hCiOO2+2p9ppLSo1JgwANLk64F7sTjqW5Z775EMW3Tu9/Yztol5hV0erPTDBC6h518fRX2REaYoozarv+k3V4B0gd5PHVCDSK7KXR9ijNTVT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260690; c=relaxed/simple;
	bh=XW9XS0NOqIdvQgAx8fhu0J99smMxvYMXw0qgURmAd1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MSYASXM0+agJrhXl+OJkpkioHVi9dryE09pQE27GBxtKzFnxFMtOrin2JTaqAkdm4jX6lbTi+8QMghEboTKBGbSGUJW5U88k4Cf+msONoVvwF3oK2ZeB9QwrXdkRJCy+imNu4dwpCUfood6SJj4KE0TbkWmYgfL6kyhSpD/Silw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yAQhMwRc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3BL146MFqoWTSU57Sah2bqwT6gK8dGaT1eXvQU67MXk=;
	t=1706260688; x=1707470288; b=yAQhMwRc3HrBcxUgj4/q3/s0AWg591X/Mj5LW+pPy/HEJS9
	GGUxK9ZWuCZx59ELqEpy8PovGgezl5vKNae+dXp9JZ6ZS2KL04BglCAgWalzW4fQ7QxEIA/bNWo4U
	FDAmxD/aDUQuk+XKOxPF8NtshiGHf+mO6eroD28CW8K4FpCFRY8JL6Yx81rBxID1zfDAjeL4QMj62
	Kqi4oSBCwNuEDiz0jCtQlFKMFrtIcOC1I/5snns5cdoPUXxwKbcxVIDk1v+7LNtcn8D6IXPNj7QxR
	1n9k6889i/OF8Q3yLyNoVXdGpsMQ37vGC+00w0woCbESLrDzS1fYzBf+Hdrq/sjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTILd-000000014VF-3Jmi;
	Fri, 26 Jan 2024 10:18:05 +0100
Message-ID: <bc9e932fd450fb4f8e0c6a35a5ee6087d9c5b189.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] wifi: cfg80211: send link id in channel_switch
 ops
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 26 Jan 2024 10:18:04 +0100
In-Reply-To: <20240125130410.827701-2-quic_adisi@quicinc.com>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
	 <20240125130410.827701-2-quic_adisi@quicinc.com>
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

On Thu, 2024-01-25 at 18:34 +0530, Aditya Kumar Singh wrote:
> Currently, during channel switch, no link id information is passed
> due to which channel switch is carried on deflink always.

I guess I already know what you mean, but ... that's really hard to
parse, can you rewrite it?

> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1531,6 +1531,8 @@ struct cfg80211_ap_update {
>   * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
>   *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
>   *	Bit set to 1 indicates that the channel is punctured.
> + * @link_id: defines the link on which channel switch is expected during
> + *	     MLO. 0 is case of non-MLO.

please use a tab

johannes

