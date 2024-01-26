Return-Path: <linux-wireless+bounces-2548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0D83D80F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF22C1C2A8B6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B81862E;
	Fri, 26 Jan 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JyjxRhqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421C17BC9
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263531; cv=none; b=MBUhamav9OkFLR6nsfvdSbhLIHqmBghxLCmAx3JU/BFcCAxWrtinNNnCLhElW6b7S/oyHUc7WrqQL+1EN2p1e7A4K+2Hmyu6dRzHIoYJI1m80/SuemtaZ+lIFnHgqd+CgjNEZ4PS9k7/6cHv8cmsNWBGwL7l7wR51t+mpYPZM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263531; c=relaxed/simple;
	bh=QR7HlmwN3F/Gnb7XCRGN3KtO9h15iG4+v/IswelfeFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCuId97+N6z3YTQhyAmc2z1p+YrgOrHSCsBePr6gb1bdrcRFKh8tVuLZkUhiJi7YEGIkXpxeI6AbUd7wC1mIuvbkVaOUd29ttKvxJBJY8GZbm46ypOk1/QPGxoQ8toBW255WLev+AO+Aiv0JCzF73gywN2fqrH5PwyPxiAzbD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JyjxRhqR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QR7HlmwN3F/Gnb7XCRGN3KtO9h15iG4+v/IswelfeFg=;
	t=1706263529; x=1707473129; b=JyjxRhqRKYnwj5Hyq5SK+H/3YkufFsYBxYi/JS94n7ZqwhJ
	nI+v4OS6Vnove8xL3bcGNy26HrEI7Pipn1891+3eTfMSaCclLFo27XSlb/FVnhontb9Mj2KBbvjuy
	U/kEHPZ15QGxM9tingHdkmsKVm8kDy6Gu/6lcq3AyyI73ZsisZtFB0vDhH5/dbv16bZMFS5j+JbCY
	TBnWZi8ebzht4513qsxjtWr3dVVasp3dcQa2c2LyygS3xSkvI6O2/ZZf74mmkd2GHqb+Yo0CiMbTn
	3iQ7wCjyWbPccFgGGtzZ+tFG/EAK5WV6y9K7nJLF8dLrCySOv4Jxq50RFpxE4LGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTJ5T-000000016J8-0Aye;
	Fri, 26 Jan 2024 11:05:27 +0100
Message-ID: <9f8d3d53f34fba4cbacb8731bc8bb1da9bfb4d45.camel@sipsolutions.net>
Subject: Re: [PATCH 0/1] Re: wifi: mac80211: don't ask rate control with
 zero rate mask if scanning
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	lvc-project@linuxtesting.org
Date: Fri, 26 Jan 2024 11:05:26 +0100
In-Reply-To: <20240125090737.49673-1-dmantipov@yandex.ru>
References: 
	<58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
	 <20240125090737.49673-1-dmantipov@yandex.ru>
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

On Thu, 2024-01-25 at 12:07 +0300, Dmitry Antipov wrote:
> Well, the literal approach to "not even use the bitrate mask for scanning=
"
> may look like the following. It fixes an original WARN_ONCE() as reported
> by syzkaller, but I'm definitely interesting on how to check whether it
> doesn't break something else.

I will always run the hwsim tests in hostap, but I'm not really
concerned it would break anything - this was never really _intended_ to
cover scanning in the first place.

johannes

