Return-Path: <linux-wireless+bounces-23205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C413ABED34
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABF93A682E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CF235067;
	Wed, 21 May 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qGFoeDdE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423C232785;
	Wed, 21 May 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813060; cv=none; b=sgMAotCQCbYsGO57wQ5SNfOKAo2hBpL847Wevhku0+4FjOzHVXlFFlrymh/gFd8yZmhACnjHKMAOxqAk2c/2JfV3+rLauE+KUGp8MXgVJyaIHSf8Pw0FdYJb0p+yGVIfJaYxTkoui0/E7ZaL2bcmlBnjgFgKf+39ObBCT9IFwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813060; c=relaxed/simple;
	bh=HeVcLu5pe7AJAPaB6hhsXE3LQ25Ay29oZ+Uaj3gjiHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XI6IzpO68rZziZ0cFfwCUwiNz5uE/JhoVlhqAThcAVKpt9+zY06fX1CNBMqodRlkSk1w7t0JE+QfZVHGELRpwcNiKfJOUx+2Hy+1ROM4uDpbRktcL+gj/byJC13Kwd2ETu0VmIoEe1FJ4uUINaH9IkbRYDDqJFj1QrB2poxVNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qGFoeDdE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HeVcLu5pe7AJAPaB6hhsXE3LQ25Ay29oZ+Uaj3gjiHM=;
	t=1747813059; x=1749022659; b=qGFoeDdELxjJvvhY021qcqiNYhevf3kBNrN4QeU/HR3fdKn
	7uIQBgtsS+hP3wYBqI4wbpVyF2rF+1N0hbxL7w7lmdwE6ZO1Z6MRYdQNdcs/nWADWeZzt9cDIjx1t
	fLHFUAyv87KGmj1f9hYnXKqz5OmQYPzmxXo/gJn0c1FLT7YggO0K/t7LgF3Mc6I6q1jmPSsf3ttId
	sGDDbWsOpzuMUKuJjs71oRwEe6Puqj5EAGpQbww0kLj7b44TRO/4NR7Y0SrIptAYT0IoBNfmLSSkK
	bfP3o1FgQveeNiL3p5mgzWFH0m6PlA6PTuYo21egzR776C0tr4M/1Uu2H4k7EDWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHdSq-0000000Dv3Z-18jl;
	Wed, 21 May 2025 09:02:08 +0200
Message-ID: <545397842b6079ac0d51cfa8c49d5b2f13c14f58.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: add sk_requests_wifi_status()
From: Johannes Berg <johannes@sipsolutions.net>
To: Randy Dunlap <rdunlap@infradead.org>, Bert Karwatzki <spasswolf@web.de>,
 	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, Jason Xing
	 <kerneljasonxing@gmail.com>
Date: Wed, 21 May 2025 09:02:07 +0200
In-Reply-To: <8cc4c232-c7cd-4dec-97c8-3573b5e471c2@infradead.org>
References: <20250520223430.6875-1-spasswolf@web.de>
	 <8cc4c232-c7cd-4dec-97c8-3573b5e471c2@infradead.org>
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

On Tue, 2025-05-20 at 15:57 -0700, Randy Dunlap wrote:
...
> That is usually spelled
> Suggested-by:
...
> Missing indentation on the line above.
...

I'll just fix that - will apply it now. Maybe also change the subject,
since really it's about checking the socket flags properly, the main
feature isn't adding the function :)

johannes

