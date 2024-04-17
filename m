Return-Path: <linux-wireless+bounces-6418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AE8A7D16
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643EEB20BC7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336B42A93;
	Wed, 17 Apr 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="abTKk+mt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC540850
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339179; cv=none; b=BuEvZZoqcGMthPaemQlBbG5akAVPr3JZrPyX28pXoafJy+wm7iZI4DwGvDGcwhTl7WZTDJydhP7yaHzjfk0nxLSuIm5fAz5xWc1XVNSZ3NX0QSQNGzn9N4tYVICo7Fktp/mkvZd+x1n9wazWyAopei6FJAXsXlDacptKXCtHYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339179; c=relaxed/simple;
	bh=lZBtMK/m0FBHCiOq6yjBx7dH9Y4CEmd/5l1j8OocR+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJA91Iotj/rsKkn8BOyDpS5YyR6Zfo0cjYJSZNcCBY2f/4P7QxjyQkDihggStIJTLWNAdr4bx4SQJenjZ+pmu4kFVxKDqMcR+Mey+yxjfrC/i8gk9VqBVkPB1gGEiSA6UG2Fy0ObIInLIgfKyNevNur5IurVCTkM21uF4T5Abcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=abTKk+mt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lZBtMK/m0FBHCiOq6yjBx7dH9Y4CEmd/5l1j8OocR+o=;
	t=1713339177; x=1714548777; b=abTKk+mt220c8+eg+nMbev0IERAPKWYEy7Xuat9zhFOKUQd
	cw8rfLyW3FGi4V23KH50evKTF8VFB8l/pm0UAIQeWqWHdts/ld/fsNHOYH6ZsU155mDM5nAfMa/U4
	8oe5clasxqbvxXJ+8/wTotgQ3vt8KTfr2EQBCb0S3/0bpukiX/4Q4sgLZuOLkaL+7ZYKXabl6HYb7
	cLxQO9fX7Tckz4bDlkjCkSIKYkAQId5qFaN3B39GPGihSJN14Jx7uGB0zNGrbRcaERJcD7S0iO8wD
	28Dgrob4k4nXUERn9K1Ht99JOZAyMJ3uTEgdTxyIFDL9dpDCVFOoMSau0B708AAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rwzmh-0000000Ak4c-1arl;
	Wed, 17 Apr 2024 09:32:47 +0200
Message-ID: <fb1b47b6c06bba25230a5dbf144ca5d6c245b0b2.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: Clear mlo_links info when STA
 disconnect
From: Johannes Berg <johannes@sipsolutions.net>
To: Xin Deng <quic_deng@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 17 Apr 2024 09:32:46 +0200
In-Reply-To: <20240410031048.23372-1-quic_deng@quicinc.com>
References: <20240410031048.23372-1-quic_deng@quicinc.com>
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

On Tue, 2024-04-09 at 20:10 -0700, Xin Deng wrote:
> wdev->valid_links is not cleared when upper layer disconnect from a
> wdev->AP MLD. It has been observed that this would prevent offchannel
> operations like remain-on-channel which would be needed for user space
> operations with Public Action frame.
> Clear the wdev->valid_links when STA disconnect.
>=20

OK, so now we have a version that actually _works_.

However, I'm not convinced it's _correct_.

You say "on disconnect", but also do it before connect (where maybe it
makes sense?), on roaming (where it doesn't), on connect result (where
presumably if we do it correct, it's already 0), and finally on
disconnect.

And also in a function that never even mentions anything about doing
something to links in the name.

All that doesn't feel right to me.

johannes

