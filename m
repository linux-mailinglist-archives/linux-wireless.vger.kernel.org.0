Return-Path: <linux-wireless+bounces-29792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF0CC1B29
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FF49300E93C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8941494A8;
	Tue, 16 Dec 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VHBNWi2c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFB2E413
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876250; cv=none; b=iCtX804obBy9/lSf6DjFIRpcFUJmUwoA8HTJzwqYiMlDG6Ha8VqGfZKo/GezVBnWkzwa01O7bBTfS8f6M1ZSOTxopyyZnTOd9togthNzkcILEAiatHqsY04Pv7MJdMXZIDwldkkYdsBTNJL3gReKuYiTMhXcJiiKfel/TnWBHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876250; c=relaxed/simple;
	bh=iRN3+56xo7bcK2zl/9tRqJffNmYywjvTq15/rs9PEZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHBUk/j5opJCvj8PyqWQX6fTd8Dp4NI7mIfmYj5nr68C0J2XyIQduEFM0i/wR/Y8p0ikAr2/6YuGApktqsdxU70JOeCO+uKcPcPlhslmUZ2mDuPNfMBihGqU+UHm5HPwvC7pSsXwXApB9vwc8ZD+5wmG87PlHyS5yXH4gvyvNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VHBNWi2c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L8WqFVLIu9Pu/vu6jTuXI6JmrI7S53lEr12FcF+EtuM=;
	t=1765876249; x=1767085849; b=VHBNWi2cYeZ7o5MmJ0o3o+nHjF6QHIRKmppb9Op8HXuw/Ws
	piN4yykBjQut7gcxBrymBI7Sxnuld4DuNfGp7UF+NMH2WLiW7q9Y3fqqUo0tw+wyCYIkoeRNvqdtc
	3m1EO7FUk399z1/PODq+kUoL0KdUxXTO5iFS6Bm4NAZo6oOct7+zDxgtuUElltl/OkERpQWVdCoOf
	Zm0btm/6hzunmwYcX2H9e7Fg/lhVBdRH39JMUwnz4BzrJvyeehmnlI/By4GuiHa0XlFcjpA11cchO
	+4MxbhROhQY+c9blDbR4dW5CCRaWfXfnIcIeqJfZC/QtwGt0v07ymUPvb1F3ct/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVR4v-0000000AEQg-3anE;
	Tue, 16 Dec 2025 10:10:46 +0100
Message-ID: <0d37920c09f8c9afe244d70232a8ecec540c84b0.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next 08/13] wifi: mac80211: Support parsing
 UHR elements
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 16 Dec 2025 10:10:45 +0100
In-Reply-To: <20251216062656.1738022-9-karthikeyan.kathirvel@oss.qualcomm.com>
References: 
	<20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20251216062656.1738022-9-karthikeyan.kathirvel@oss.qualcomm.com>
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

On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
>=20
> + * @is_beacon: %true if the elements came from beacon frame
>   * @type: type of the frame the elements came from
>   *	(action, probe response, beacon, etc.)

OK how long have you been sitting on this patch? :)

johannes

