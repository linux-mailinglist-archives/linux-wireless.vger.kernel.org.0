Return-Path: <linux-wireless+bounces-1449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97255822FCA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEB81C20D70
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D801A5B1;
	Wed,  3 Jan 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rca+/b8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD11B268;
	Wed,  3 Jan 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+gMc6ZjgZLhgJmei/YqHODAZ0YGot54UzT2OGqk33DU=;
	t=1704293149; x=1705502749; b=Rca+/b8G+Djs3uLBmEogg7iuwSX0pGt01wWJLfLWFLTFEat
	QSUw/BJvlqGVxUxldlM0JYQh3YXGMWOEo8rdn8fHFpoh5N7AXS+HE2LaU3y6N0b5y5UiV9353+eri
	Eh+XqMPZA5Cbe2g3MyAeJeF8vcDEAcW4q34kO5pd2C9HvtNGX/x0MT0N7FDfLpkc9l0EHWWPEMOXp
	KWJEmDllpwkId3KWbhxJDhcP+TTyGoi7xza/4ZwD9CT/ZxIQNoh+g4yQIgyIMprTaq54BxMD0xRHc
	9RxUwdva+mTH+X2gd+RGLCg+3S/3TFrLSNcdKiUuiLukFWY9PB32BN1rX1yk0CPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rL2V8-000000039tF-04D6;
	Wed, 03 Jan 2024 15:45:46 +0100
Message-ID: <126b2b965bff0d4d52b15c0b9f72012bd156302a.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-next-2024-01-03
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 03 Jan 2024 15:45:45 +0100
In-Reply-To: <20240103144423.52269-3-johannes@sipsolutions.net>
References: <20240103144423.52269-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-01-03 at 15:43 +0100, Johannes Berg wrote:
> Hi,
>=20
> So ... since we were discussing and wrapping up the kunit stuff,
> I decided to put together another pull request with a few things,
> notably the first kunit tests for wifi.

Err, I'm confused. We had some, these are just all the more interesting
ones with SKBs... Whatever, doesn't matter much I guess.

johannes

