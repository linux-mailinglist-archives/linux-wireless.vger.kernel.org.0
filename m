Return-Path: <linux-wireless+bounces-28724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA2C456DE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AC6134557D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D22FD1C1;
	Mon, 10 Nov 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wNIdLwHJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1722FCBF7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764543; cv=none; b=dqMb6oPPCyxj7MOYJ4o/zen40jPIkubs2UjDlFVhW/K5mVAcyMYFI5+76ppTYOugx9b6bEBYatmDr0VrFAPTm2Lm3poAy3j4fTGpXPYg2laaJXKnOLGVB7A++zKCQq8JKvg4EqtdWkbF8g6mov3tTVycU4hpru0lVSyE2jpVmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764543; c=relaxed/simple;
	bh=pEqrMTADz3m9yu1utLNd76nldhLTDl52BaaM0WjhLpw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ikVzDcbOpOV0LyMkZZcu/sY4U5cqw+97hQ280TdqYL6v0uNjftpqL6AwFQo/gei/H2r49d2HTcs0cIdF3Y+lyq5AmjcICWGeh+To5tJqzyS+1fS5TDvs9NtehN51+RLP9FWCsSDQVAHzGoPycyP7RsHradSQelAnlhUtTZtPZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wNIdLwHJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pEqrMTADz3m9yu1utLNd76nldhLTDl52BaaM0WjhLpw=;
	t=1762764541; x=1763974141; b=wNIdLwHJjWSCE8+9GegTHXcae3FQHnF9snlejIOpAtFnezn
	b6fY920NsYb5g3E4jJUpfKNKzXrDXG80lljgmeVl2Kl9DABlshNQIHhbuq1VmspVVQYw2SMkq6rE5
	YvUTgqqxLjNBo31J3oe1ijJfisPJgA8G3+iggR25nRHnzhjywOCMnaHhQ821/InEx/y0nv7qt/ONx
	uYR4GQ4IclYbENRhFrkA2NidNQEqmptoAvOCzLFDUtbnQ6rfOf4gI9XUi9wAIIgM7mPoFvMHtB58m
	JJvZ8PyOwpi971l+EKUkHzs2SWoEOj8IxMM7OfilWECeNPrZ7yZEd1lucw7X/bsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vINa7-0000000B2Zi-0hIb;
	Mon, 10 Nov 2025 09:48:59 +0100
Message-ID: <541a60c3bb64e882040881f6d4520799f75bfa9f.camel@sipsolutions.net>
Subject: Re: [RFC v2 wireless-next 1/4] wifi: cfg80211: fix background CAC
 cancellation
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 10 Nov 2025 09:48:58 +0100
In-Reply-To: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
References: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
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

On Sat, 2025-11-08 at 20:22 +0100, Janusz Dziedzic wrote:
> Fixes missing CAC_ABORTED event when background
> radar canceled.

s/Fixes/Fix/, s/canceled/is canceled/ I'd say.

johannes

