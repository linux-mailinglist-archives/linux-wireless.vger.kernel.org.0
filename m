Return-Path: <linux-wireless+bounces-19913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C0A54A48
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504FA169FEF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57B204089;
	Thu,  6 Mar 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vjc/xxcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B56201022
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262762; cv=none; b=URF9GGnoaOxxvRJeI30fA6Loqjs5rfUdESKh+JisCd6BlKthsHGFO2IfwbaUVdv6Wixp+bRLC5MoJ3Qentvoj83UYiK6yCQn+wLNNYZ2qIDrGf6gc+WGrlrgW8KJPjZWtO+tA0gXqt+XHjvDdDGuJXiMvkws2LtygkaN4BsKgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262762; c=relaxed/simple;
	bh=b70l3XNMSbgL9GHJ3Cb3Q15vZeV4J/WbLfUNTy5wTZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRY2nufqXXldHK4EspdTx14lPfjozt/QBwRxc96i+AN6WqWnfNdRNGeOiIZppb0308npJLjh19Hs8K7zN+sXNpbhgjgcLIngWDF/DWEownzwu1mfd2iQt4WrmRWFDDKfqUXldlm8ky/ihQ3ZeEqWGV1cb7gGZfrKGsZpERLuf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vjc/xxcJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b70l3XNMSbgL9GHJ3Cb3Q15vZeV4J/WbLfUNTy5wTZc=;
	t=1741262760; x=1742472360; b=vjc/xxcJehQM4UN4vkngeZ2/ptkLaonvtB7hmTWrxmIqtjI
	O2vonPElmt7pGJfdFPVaBsqpkCFw+vuI42rbvpI3Kx5PTacQwTkrfXW7tpuhEBD8lCpQPWozq/rNk
	Is51dYodl0Oqh7Im5v98RUNequENfbhr50i72QiGtjgBNPskTBR8D3JKl5Tu9IG9JT0rOo6dMwCy4
	v15TOr+wvm2/j1GuIh0rppSHG4Tof9LUSiBQdJNG/9IwZ28s8eCOuZ+Et026BTM2xPW8QRhA/Mlze
	fKlLPAG72EcZKHbjtxqn41h07cGozECVjfuu6+vJ6sva4r5WfUDmiK6Jh/lR8ZwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tq9zA-00000002pU2-3NGI;
	Thu, 06 Mar 2025 13:05:56 +0100
Message-ID: <dafd4da6ddcdbbde8a0effb9d51443bed57ad5be.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4] wifi: mac80211: correct RX stats
 packet increment for multi-link
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 06 Mar 2025 13:05:56 +0100
In-Reply-To: <20250306062459.4089284-1-quic_sarishar@quicinc.com>
References: <20250306062459.4089284-1-quic_sarishar@quicinc.com>
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

On Thu, 2025-03-06 at 11:54 +0530, Sarika Sharma wrote:
> Currently, RX stats packets are incremented for deflink member for
> non-ML and multi-link(ML) station case. However, for ML station,
> packets should be incremented based on the specific link.

Should, I agree, but then they currently get lost entirely, no?

So shouldn't this be part of the per-link statistics series?

johannes


