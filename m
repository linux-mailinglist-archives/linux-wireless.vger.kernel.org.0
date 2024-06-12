Return-Path: <linux-wireless+bounces-8839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D0904DD1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046A91C238EA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F98168C33;
	Wed, 12 Jun 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VFm/j2lr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A341C65;
	Wed, 12 Jun 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180144; cv=none; b=oJqfM6iPmbfx8PEk1xnT3H0Xuzn0CTICM8I+PNrELg3iYxuV9Zu+akPpgEuGUeOOFAeqWQdHLgOx/PYVzqlU3hLyAIp04ou37ciyR0TdRQU0vKxzTWAAXYzgYr9C6q3prNgVEfRmQ9HCmkxUIouGPNHT4PIALoP0YFHqlL70byA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180144; c=relaxed/simple;
	bh=xwiyBKJDZarFMbm/078sICFMFxTbzgNIbp48eF3Ki88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QCRh00elHz65/BzN/zKUGUsboAK7xx5jU/F2vvUC5OMJi2vTUY7xyf4qCYQhhcCRWZN8l0sxoAvDFhZrBc8kf/K3YRK4GPp3eSZaf2ksC3dIkM/MyITAe2cStre3s4YwfwmCc1+tirrtNuOk86GSJ9+28egwLnxvKA5R9XGyCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VFm/j2lr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xwiyBKJDZarFMbm/078sICFMFxTbzgNIbp48eF3Ki88=;
	t=1718180142; x=1719389742; b=VFm/j2lrsJ4XrmgwQJdUWDLwvPyz2/utqoYqYw5LGSBW1Dt
	9508Gb9wbk1fNqVSjF/rnXnp3Y4suHlfr6wlxw9GkG3KOx5TZFSsPDoouexskCf2hrdfc4zQ0Pu4X
	+/QmT0Dj9hJJiNznYF3sgr4gdJqkMmtjUh7+3x2d/0nUFqOdsw9BKNUmKh74GXSaZV0IluIDeuPNy
	XqOp63lidqKIywEQJc35XRBjtg0pVaHlbtB7WuZFGefeYKkuvmh6r7ttlDYjQW3qmD5ujIt2dQLZN
	3oztkR45ppyp6a65YgKFigb7OMNbSrxIRtQbgLil1Q1bTwB+FrExXIFqYjEhw/lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHJ8o-0000000A301-42zj;
	Wed, 12 Jun 2024 10:15:35 +0200
Message-ID: <5d901b213389c38eb5bd1df37cb8a1c3d82ebba5.camel@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] net: rfkill: Fix a wrongly handling error case
From: Johannes Berg <johannes@sipsolutions.net>
To: Zijun Hu <quic_zijuhu@quicinc.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 12 Jun 2024 10:15:33 +0200
In-Reply-To: <1717771212-30723-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
	 <1717771212-30723-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> use pr_err() instead of WARN()
> for this error case handling.

I don't see anything wrong with the WARN here, it's the user/driver
calling it completely incorrectly.

I also don't really think this is a *fix*, if you used the API
incorrectly you can't necessarily expect a correct return value, I
guess, but anyway it shouldn't happen in the first place.

I'm happy to take the return value change (only) as a cleanup, if you
wish to resend that.

> Fixed by

Please also read
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

johannes

