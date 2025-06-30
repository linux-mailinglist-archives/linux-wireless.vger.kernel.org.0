Return-Path: <linux-wireless+bounces-24668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C53AEDF4D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3AB3A9C66
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48128B4FB;
	Mon, 30 Jun 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fm175RJH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E28A73D;
	Mon, 30 Jun 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290681; cv=none; b=TdOZHmfUEx4YAWN3H5XCwgWHnOCU4Iud7NxBYN8A72zbxUOp4KIOAf0FqUzzL3OXsHQ6sHK0yrYLVaLWpC7zQkEmLM5dmYBaMR/ulwwGJ6E9htUgWV1rfpliyxsHsLhnsaatO6XhgYK/P9x0aEpnozZlpNNI6sPc9pVIiKKFkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290681; c=relaxed/simple;
	bh=pil8rwdyDHVzTwX+qokMXU4HAHouwODl0NcItMy+hb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+D9iW/eeglbQi9rb31bRWgKtRHDbUaTLmbixpSVzEfD/0oImh1rNOmUAO+ldCm6AKWvNMIn3A+WetosOIgRhiE4ye48fcgfm+nrR1CgTv0Ho8XBJ9UL0F2b3CrpqYCjcJDbBadzBoNZtHxOq8UaOKjviu2hpLnsE3n5lMQP5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fm175RJH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pil8rwdyDHVzTwX+qokMXU4HAHouwODl0NcItMy+hb4=;
	t=1751290680; x=1752500280; b=fm175RJHmO2NmbW53IX252IcpDKPWUtkwlAE8FkHcM6zr8C
	xw02Cx2Q0+NqipO8MZxIQPNgb3KcE3jtaQH8v+5gGLY9fZ1uGP8KprPiq/9SywwE47gn5BoA2SS6c
	h6wtetbaaKg7m5I0LNFmY35lpyXzmSrSNB1/qdCmfzRLroOikXM5zQNIKMCVnRKdLRqtA6WPETt6P
	PqvtlD43ut9xIuWuII7fUoBLKXskc61y5ylsH6ws09Uy/JAGMT3dZrhbsUVx0bJRacTK08lPBFvBE
	3RVB3rQjg8Dr9uhTwLOuaqjkYGOcxKk1aBB3F+B813ux428GCusEayH3gs0EWpXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWEhn-00000001NDO-3pFP;
	Mon, 30 Jun 2025 15:37:56 +0200
Message-ID: <282d9d1264c541343462dd7982c4f5dbc029c660.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: wilc1000: Handle wilc_sdio_cmd52() failure in
 wilc_sdio_read_init()
From: Johannes Berg <johannes@sipsolutions.net>
To: Wentao Liang <vulab@iscas.ac.cn>, ajay.kathat@microchip.com, 
	claudiu.beznea@tuxon.dev, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 30 Jun 2025 15:37:55 +0200
In-Reply-To: <20250519015415.966-1-vulab@iscas.ac.cn>
References: <20250519015415.966-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-05-19 at 09:54 +0800, Wentao Liang wrote:
> The wilc_sdio_read_init() calls wilc_sdio_cmd52() but does not check the
> return value. This could lead to execution with potentially invalid data
> if wilc_sdio_cmd52() fails. A proper implementation can be found in
> wilc_sdio_read_reg().

This seems fairly much pointless, if the caller is never going to check
the return value anyway?

> 2.42.0.windows.2

Really? Did you even _build_ the changes yourself?

johannes

