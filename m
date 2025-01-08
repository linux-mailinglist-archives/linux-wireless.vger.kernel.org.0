Return-Path: <linux-wireless+bounces-17185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A80A0556E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636CB165FDB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DE1AAA03;
	Wed,  8 Jan 2025 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nLeJ/MLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675631A0BE0
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325262; cv=none; b=O4NI1iuPKZulwfNHiSCjXsc98wqFnkoYky2jpRDBwZ/g3iTF3KdgpVE4qCAMd9inTU7ElI1CSnclVe6N6OjhvPFDXB1g+Y9SQ7J7R8igFot8c7qT7ZjIUj0Zct+ZA+tkho6peWCyjEwvLFGScwKKXHfJJBgepWLapSIaWBR7CGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325262; c=relaxed/simple;
	bh=FBDbkViZwvJ/3/PchkIeNYDIx8dWW03VLbrLPWEt7SU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwpzGUuHwCiq8xpAL8m9ciPHWvkYLoO27URqKMPPMDQhZlyrOqu4wNW5kIJ/Cof8A30Ojo0E3cCpCW4jkQgH6eQk2Zfbr4p2bcFK7PaqAxM8Ka5kTWMdU6cE9qw47an91il3ws9mnzhG6qKTibsygxeJGGA4jPT17RiyG0y9KJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nLeJ/MLV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JQoaI2I8hK0vCJL5Xk0t1rqg9LLvN9K0Gc1DUp9qi20=;
	t=1736325260; x=1737534860; b=nLeJ/MLVWanlh5i2FhVJP0S/2Z0xGWNIU2hIc5stf46o9ip
	KcHLfS0R2CWn/H1w/Y/ZdJQp89BGRoI9gOx5U7OT+kBq/pXWYgT3IPVtrsKSTJeveM/LgeMXIlUiW
	TBzxQatPwxJR+mrkHyo4wEFVoG4WZm7ef3UvybSfLDAV9xdZ9Fe8s6MDpn0iYwAxWeZiYn8k36wRc
	nVIc6bZo1MvZYZtuHJdW1AhV4+GPXthRa5A7Hzb0ZAexfcoJTrcbreQxQWay71l3mdKydVATHuT2u
	wRClwc2G4YOVEuFfjwsoa13yssSUFY3XWOxtjUK7fjfv3MrYygmzNMEPySxmHJmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tVRW4-0000000891n-36R0;
	Wed, 08 Jan 2025 09:34:16 +0100
Message-ID: <6f61f6eaf03eec99f0f30d01501bc60f8ead1270.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: mac80211: update ML STA with EML capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Ramasamy Kaliappan
	 <quic_rkaliapp@quicinc.com>
Date: Wed, 08 Jan 2025 09:34:15 +0100
In-Reply-To: <20250107174802.1793252-3-quic_ramess@quicinc.com>
References: <20250107174802.1793252-1-quic_ramess@quicinc.com>
	 <20250107174802.1793252-3-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-01-07 at 23:18 +0530, Rameshkumar Sundaram wrote:
>=20
> +	if (params->eml_cap)
> +		sta->sta.eml_cap =3D params->eml_cap;
>=20

It would seem to me that 0 is a valid value, so you may need a separate
"was the attribute included and we're changing the value" flag?

johannes

