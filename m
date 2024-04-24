Return-Path: <linux-wireless+bounces-6762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0FA8B064C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DD285463
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A715884A;
	Wed, 24 Apr 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cVyfbLpd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898D158DB7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951850; cv=none; b=pQgcuE0DW7uXzuQljkBDIUWx+VWQvq4NiAvL8xsOa2MCESN9fmnB8mdQCyDrTttNgPvgDfs+qUHMxWeep3mSZoZ99F3E11a5mDZ6Xl8n5LWcjF/hIePOXOTAe5ri0foOqA3Mez+e66U19ZQTQhXErDj+k0Rq+epm7FycbGId4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951850; c=relaxed/simple;
	bh=V8p7b4C6CDp0TTv3/UFNRntuk3/leQiq7ModHlvtGIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcTFN5kAxffNT1yzcBkn4rGgQ2FqAo6/CjEEA41SmKWB9gljnD45EuCWVT9z7Jbw07xSuXG0ivAVT5kfziJYWDQkJfFJkQqP9qcgwIGqpJTtP7BfRpdhmZJtAQeM7nHtzLf3lB0an1/59Bm4LbAQjxn9QqA9bIGgDrevNN4CN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cVyfbLpd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V8p7b4C6CDp0TTv3/UFNRntuk3/leQiq7ModHlvtGIw=;
	t=1713951848; x=1715161448; b=cVyfbLpdc6pWRaGL9YlRyOj5ObjPQESiWz6hqmSxvzCttr+
	mznLPuIJ0LgkxxFBsEbQBNnTLItnJ+pcyd+OqmtFbQahn30qe9s0cuXp5HBB1D0jBa8s5yPBq0gcb
	YczYtHXr5vrqYNnoUpMMra+RoCe/erl0ja/SqC7h2DUj3tTPVFo8tftiadUM935w90eLSPt7KU7KD
	7vNp1/wut7xXAlQlwQx+V1gLemztbkFDwwAboKgatRQ1O9TkqgKhQV5sPS8GmtbRTZvxKFAbbDySy
	UcOCmnaC0oZgGDeLiyEnREs68egExbLEfX6fLj7taHAivXyZ8C9rcJh+WQhE8WZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzZAV-00000003UY1-3hjz;
	Wed, 24 Apr 2024 11:44:00 +0200
Message-ID: <3dc4339f5c3f603027c2214058e7e3251652a7f0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware
 state
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Wed, 24 Apr 2024 11:43:58 +0200
In-Reply-To: <87il07t7zq.fsf@kernel.org>
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
	 <20240424065646.1666166-4-quic_periyasa@quicinc.com>
	 <517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
	 <87il07t7zq.fsf@kernel.org>
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

On Wed, 2024-04-24 at 12:39 +0300, Kalle Valo wrote:
>=20
> Exactly. Swithing to use wiphy_lock() definitely one of my longterm
> goals in ath12k. I already started working on switching ath12k to use
> wiphy_lock() but IIRC I got blocked by not being able to call
> wiphy_delayed_work_cancel() without taking wiphy_lock.

That's because I didn't want to have an async version, but theoretically
we could have a version of it that just cancels the timer. If you don't
hold the wiphy mutex already you could even wait for it to finish. It
just adds more complexity there, and I was trying to make it all a lot
more obvious :)

johannes

