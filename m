Return-Path: <linux-wireless+bounces-27245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D5B535A7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3A55A7A50
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7826A1BE;
	Thu, 11 Sep 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P9fMD42S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B51219301
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601284; cv=none; b=mbySBtHzk+n3LHDwWwmSQ1ZlzstO/qP2l+cGHcwdedrxQldDABJuTQ9yCwW+J2lL3hIr610v4FZ7U9qcxPw6whMIVPdWrIeVEIVloEePaxQRVsjicAjxkFQnYBnMSuX8JezYa9II1qc7LL9CiUusxVmvmIjMwECI04rxkuMONDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601284; c=relaxed/simple;
	bh=ZtX3QaZ7wuqWxawW0K+S5/F7I5J12WueBoqqQ1KKYVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsfmzBdAPsJk/71Gh9yTsqoDmSCNUcUdhGv44uvH8nEI6Wvjr7B/GiEowiPmYCIWVwe7UKSAnm05tQ4pSWgcrwWpkCHDj+4JcSE62a+vEBu2P250fklT3C1VloW3zMpAuFOLWY39dGFZjpM6S5S9Vjnojjo3+uJCUZxrNEyb4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P9fMD42S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZtX3QaZ7wuqWxawW0K+S5/F7I5J12WueBoqqQ1KKYVo=;
	t=1757601282; x=1758810882; b=P9fMD42SaYvpp8qusCd1pqvlerLXDjfgt90g30CO6jp1GMh
	CIu9AWuTCYjKmMQFno3auuQKk7xQwCF5ByLIyyQcfdE+FTQVjtLxB+nVoMmSJD1wU4NQVP8Kv+C8C
	pe7C2Ev2Ua/j8zV1dpnXOcKD3JtcsgcDjhJcK9VEvSIjp1prM2BcXS8bTnHs3RpbDI6e5kZlAUo2Q
	UO+eUIa2DQH8VVRwsM0SdBrUgne1gX1wJIAdROJXnKi6nDjNnycONyjLkaRK3oKBnDDFTy0OTmdDZ
	tF1rTOiY3LxgO/lQhBYN2VYdNJum8JLrVNc4iBdb1iss4BC+48ayRkqdathyB18Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwiNj-0000000FRuo-2eYz;
	Thu, 11 Sep 2025 16:34:39 +0200
Message-ID: <634a2226282c6789dda27a7140612a9a1dc6ac2b.camel@sipsolutions.net>
Subject: Re: [PATCH v3] iwlegacy: Add sanity check for il->stations[] array
 index
From: Johannes Berg <johannes@sipsolutions.net>
To: Chen Yufeng <chenyufeng@iie.ac.cn>, stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org
Date: Thu, 11 Sep 2025 16:34:38 +0200
In-Reply-To: <20250911142910.1277-1-chenyufeng@iie.ac.cn>
References: <20250911142910.1277-1-chenyufeng@iie.ac.cn>
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

On Thu, 2025-09-11 at 22:29 +0800, Chen Yufeng wrote:
>=20
> Fixes: 0cdc21363cc2 ("iwlegacy: merge common .c files")
>=20
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>

There also shouldn't be a blank line between those.

And it doesn't build:
http://wifibot.sipsolutions.net/results/1001358/14227313/build_32bit/stderr

But please don't use the bots for patch validation ... make sure you
build your own patch _before_ you submit.

johannes

