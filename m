Return-Path: <linux-wireless+bounces-21998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99442A9AEF9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F06C9A1D04
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626971ACEC7;
	Thu, 24 Apr 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qbFy0zU9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAC14B06C
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501352; cv=none; b=lZKhLtV3AlzcODan76lPKL6WHv8d7VyIFZOmBEYIBh0JywTAzeCvLJJlw7A1rcE1q7r2xGHM14pEewX6atd9SZ+KReSFxf/BdLhLTyJO+shsl6oTM6exlfASP/7/n2qvWXoGZeeRjUhWDc+f1DgvVF3DBYkYAPvqGMDlqaxE2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501352; c=relaxed/simple;
	bh=v4mwunmGPiH7jVgFBnBw61m/xmX1jt8FAjeCNIJ4fKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G61MDA6A3PLCVtLyld/YTWvtLOgz35GRW3+rHjLhXTtmf5dffMwwcmMS3bW5sT5JhMBsu+zQObTqw5XTB0rToh2OWCHlwIFkt0IvLebDJXAQuUtQSeouQ2qBZOQ7is9pd6FPu9LsT4ozlhwBk4Y3vaYwvjZVBWJNZH2GHHUYHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qbFy0zU9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v4mwunmGPiH7jVgFBnBw61m/xmX1jt8FAjeCNIJ4fKs=;
	t=1745501351; x=1746710951; b=qbFy0zU9ZUeAcp78DEzdgTubVq4owy95D3PTLU3Yif5a6QX
	NvHQQLg60zNN5X5m10vuCMRZrCUGH5hqDgn8gXP4AGk9YCnRWqacRN407qhUSEeiLB1QD+GcZiA4Y
	hE2CbKe8N0zQE2LRZ/4uF5F876xkpQTvrT/7Jnm45nkMJ9JR07MTOD+gRqBbpBgVC8+uikJNiJ4Il
	QuevP+5WxD+BTsgTIsE/7fjRUXxxpuYfpK1VC2gjo+CxCCoLTZS3LZ3cKqczbL/IgyTbg+B3gEiML
	rJWbPX5ri8/esox7J0yS7Bxhnoac0hymUNsFath2vl9j3IZ8EvTL3YtxTL4glnMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7wdX-0000000HCRy-1ejU;
	Thu, 24 Apr 2025 15:29:07 +0200
Message-ID: <93c626d968e02f64b85280cd12f2ad6fa9b0ac74.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 5/5] wifi: mac80211: set tx power per
 radio in a wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Thu, 24 Apr 2025 15:29:06 +0200
In-Reply-To: <097f0aa3-997a-453f-a2b4-c6126ed5e606@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
	 <20250328122519.1946729-6-quic_rdevanat@quicinc.com>
	 <3719131760bb5070378e397d716edde394256933.camel@sipsolutions.net>
	 <097f0aa3-997a-453f-a2b4-c6126ed5e606@quicinc.com>
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

On Thu, 2025-04-24 at 18:57 +0530, Roopni Devanathan wrote:
> >=20
> > Hmm. Is this really enough? What if the link gets disabled and re-
> > enabled on a whole different chanctx on a different radio? Or other
> > things like that?
> >=20
> > Seems like we may need to change how the TX power is stored in mac80211=
,
> > rather than just paper over it like this?
> >=20
> This means that get_tx_power handling should also be changed. So I might =
have to work
> on resigning this.=C2=A0
>=20

Maybe, I'm not really sure? Was just thinking about it.

> I'll handle this parallelly. Meanwhile, can I send out the first three
> patches handling get/set RTS threshold in a separate patch series?

Sure.

johannes

