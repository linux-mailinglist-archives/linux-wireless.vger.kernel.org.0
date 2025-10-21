Return-Path: <linux-wireless+bounces-28151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C5BF7177
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 16:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E42D5474C3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435B2F60CD;
	Tue, 21 Oct 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MU02TDUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B033A032;
	Tue, 21 Oct 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057026; cv=none; b=iLVFLikWJ1w12uqjCvVoM89zCxDAhmX7GLz0CDKb2Yz/HuUqcu6wlFJLwlv26FWkJ9x0ihZWFu+0lC2q320D1QQH8YqFi5gv2AjJQ43v7t3EF69BSZ3bYTbKVk+hQ+CVVDK8AMu/DDrndw/QHf/rVvdT/4FajN4QidvOS1/jEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057026; c=relaxed/simple;
	bh=6yv3xeioCTIhUI0epdU1FmxXFWsVBiP/Cy7QjsBiGKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ix+cLp9H9YMoBh9LsVs2fXvWMFKz1ZrmvUxXgZ/IbD4UosZ1IkPxrUbMwS2z1kydnX/W8SmB71q6FahvYimoYph4oLye80XehmP3Xb2RHGLoBZAxyBYrHKXE60q4REftYvmwNBpGv6F/RwmYEVswqZUKF42p6VRz2LdZq4v52sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MU02TDUt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6yv3xeioCTIhUI0epdU1FmxXFWsVBiP/Cy7QjsBiGKE=;
	t=1761057025; x=1762266625; b=MU02TDUtJkRse0dXHMU5+HCF7IW5Yubq3GgZgf2KZnR7wN/
	tudJKSukLcCRlAY/LHRJKj0+Ws8uH7Kr9ZNTRmAzc1njLlEvW/00cs8OnEb00jZ08bvvELLr4UgiN
	QdMjN5C3vj1km+MiJLXRO6LpksR09qgXUUUUfa9xVQCZ9hAldfgVJuzMCEfnV2Q4E01NGwVPKHaY/
	3Nphh8YxvYW4GgRqApAM+9HItJv2uthyLZfUWHFNmJWkn/cHasdIcWi/+6+HZVW+2nDVDBlsRbiQH
	kt6ybfYJT/c0STEs57ZPT9iA09fQ6g5w7oluqBuRbeAmRqDTCpc4cKNnx0L4NF4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBDNW-0000000C14h-0dPU;
	Tue, 21 Oct 2025 16:30:22 +0200
Message-ID: <c93a5030eac4a0042e5773fa49037a35c9239027.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Remove unused wdev_to_ieee80211_vif
From: Johannes Berg <johannes@sipsolutions.net>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Oct 2025 16:30:21 +0200
In-Reply-To: <aPZl0LFtls2LA6uf@gallifrey>
References: <20250619005229.291961-1-linux@treblig.org>
	 <aOvZ8FHp7-tliei2@gallifrey>
	 <30b9e7eebfc99330857f7a81c72b9eb23ea6406d.camel@sipsolutions.net>
	 <aPZl0LFtls2LA6uf@gallifrey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-10-20 at 16:39 +0000, Dr. David Alan Gilbert wrote:
> So what is it about these out of tree things that needs these calls;
> why don't the in tree ones need it?

If you have a mac80211 driver that has cfg80211 vendor commands, it'll
be called with just the wdev, but will need to have the mac80211
corresponding vif in most cases, and if it's e.g. called for a monitor
interface, there might not even _be_ a vif (and get NULL here.)

johannes

