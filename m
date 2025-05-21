Return-Path: <linux-wireless+bounces-23234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE4ABFB6E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80B17A46CF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C70622B8B8;
	Wed, 21 May 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PGzWzlMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CD1E1DE8
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845694; cv=none; b=fmZ7OV1ZDQaTGpJ5UOXAPU8gTJis/F/F52RS4KamkGwoR0ANhH/ql15+s+bJiOpUI/s15FP2cvD8RhQNB5IQpQY8RaUFFzrFwm2zPN1EgYtdN04l/e2iLclRdtb4K8/V6FCpwfXQUYUjmaZ1LgnYWXBQt01PlniE7OIKqZ48Ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845694; c=relaxed/simple;
	bh=flCaq1EnM/0NPI8sXoTLAeszUygfWWKDUJe84E+v44o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnt9ByITueue8wI+b0y6uiyrYHo3NQDnIj8N74y+rwJKsJ7BXuSITvAyXD9q+WLQXLVjJwYGZ19Ljg6AxbWWlEvABwoPyugnnkP5tdLHL8ZdQdCc0rqaEjE0fZBMvcA8ZCpEpjSjKR+eS0jOZV4ZQJwpGFgDQVDOGjKhlCQf+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PGzWzlMt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=flCaq1EnM/0NPI8sXoTLAeszUygfWWKDUJe84E+v44o=;
	t=1747845692; x=1749055292; b=PGzWzlMt3WRTmvXbj7dolVpUpv3KANHau5BeiJHyNp0OxEl
	mdqHDHguWEIRCzf3XYCMimSnEHGC4PFldD4Vy6dNmgWxi4rh7HMXiLkqkxKejiyR1Mv+EZDBOePAZ
	JFnVf/rOx7XaHCVGFfULxRJUsvHeSmQdAhfRfiFjjY+5Akz85panYxuMPlylEYQt9v07qqMmTzAjo
	hFiCg42kj5SciH5th7qJvMLqii0TFc4SXHYvwonn3Bgm36WqUQXCOvMqy4oweFrnCniVFjZK2jc1v
	mgzZhmSNaNmsCBq2eRuxaOApAyJ9q/3RzbQrg4JBRjM5v+6tOtOD1AtrqZ8EYJOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHmVU-0000000Eoiv-36R6;
	Wed, 21 May 2025 18:41:28 +0200
Message-ID: <e928cd9c93134aa7df585835e07a601a4ff3dbfb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 18:41:28 +0200
In-Reply-To: <e49bd19a-b8ac-49d9-9cce-80772e8ac0b5@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
	 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
	 <e49bd19a-b8ac-49d9-9cce-80772e8ac0b5@quicinc.com>
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

On Wed, 2025-05-21 at 22:00 +0530, Roopni Devanathan wrote:
>=20
> Using 'int' leads to adding NLA_U32 policy. I think using 'int' is
> costlier than using 's8'. Can we just revert back to using 's8' instead?
> There will still be a default value of -1 and the radio indices will not
> require u32 value anyway.

I don't follow. You can always take a U8 value and put it into an int??

I think that NLA_U8 is a bit useless if you have to range-check anyway,
since an NLA_U8 attribute is actually the same size as an NLA_U32
attribute, it just has a more restricted range (but you restrict it to
the n_radios anyway!).

But I don't see how this is related at all.

I think 'int' is better internally, and NLA_U8 is fine externally.

johannes

