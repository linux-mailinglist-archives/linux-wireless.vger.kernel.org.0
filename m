Return-Path: <linux-wireless+bounces-13351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBD98B46F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ED828399B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B031BC06B;
	Tue,  1 Oct 2024 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N72WzQKO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA007DA62
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764284; cv=none; b=LE0ZbWnlQC0tYA85kn3yzFgHU/zETW4twSS77hDzf3cwDnupqktotMW4fL4uIBLPhBmnHUnYv5rfG/lRoWDP0LmtGiClKPYGd7GBcY7+/1RZIgcSsm+nHhVMWL8GHUHOaNSoyMpWR4OLTsydYW+9ofcDs0H8y2Z1+8o3+smn9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764284; c=relaxed/simple;
	bh=QjTLB22PqAfoqr0bxPJzxHbtm3tz/jvaGjlnDnVoCdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDs/O49Emk+JwwCr6HxIfIUwclNhI1rvvmSMX6CkzcogXXIHYMaTZWCnwXdyfRQ21uh7dwf61NYoiIV7GMVjwuJO39QFi1QWNHUVu4um4qpqMZr7K3r6w1jC4M/Zl2UGMeSwoI42y/+ePrt2lsDQUlvukjrKGpJBwW0r9z4Yif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N72WzQKO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bPR4N0J//5OXmR29nCGbEoccpWjo/sFzUSHK6PXL0V0=;
	t=1727764282; x=1728973882; b=N72WzQKOotzlqSe//uuVHRNaBEIy9KjT7UfayIedfbsHnK5
	oXc2QdS5U7xvzviP+oCQRAThWXcIWYhzuC7xRTvQnsFNoFnmHhg0M6AhORDOk58EXTk+WM+bBl9PV
	7ZVbsHPplgaLR8a+WWjHNNnGcP4sh6F6CpAnmhoJIQAkjsNvC/vMrUYc+ZQmH7pyWNjFMe/7GUX9W
	syHudCnA8vb3oGfz/O/RLX8ch9Qr0K+4zp9mKpEvtKShjsYZ8d7eMErY2zVWI+Nk7K1nBKkGcRmDC
	p0NfQQDJsayuQ5VSBN79kG2q3+h5MTkeC/lNTDFwuBRZGIDOxbF41T0fGs9svrMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svWPh-0000000Ed7L-0MFX;
	Tue, 01 Oct 2024 08:31:13 +0200
Message-ID: <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 01 Oct 2024 08:31:12 +0200
In-Reply-To: <20241001041518.2236297-1-quic_adisi@quicinc.com>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
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


> +		/*
> +		 * inform about the link info changed parameters after all
> +		 * stations are also added
> +		 */

I don't understand that comment - you're not doing anything with the
stations here? And per the commit log it's explicitly _not_ after doing
the AP station. I'm not sure we should set up everything before the AP
station?

> +						  BSS_CHANGED_HE_BSS_COLOR);
> +
> +	}

You make it look like you just moved code but also snuck in a new blank
line :)

johannes

> +
>  	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
>  		struct ieee80211_link_data *link;

I also think you put this code too early now - you're now first using
more channel contexts by way of _ieee80211_link_use_channel() before you
even release the ones from deactivated ("rem" bitmap in this code)
links. That doesn't seem like it could work correctly in general.

johannes

