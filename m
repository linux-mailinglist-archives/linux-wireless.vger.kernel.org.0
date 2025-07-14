Return-Path: <linux-wireless+bounces-25364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529DB03CCB
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D295F3AD5DC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B407724503F;
	Mon, 14 Jul 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cECLdLaz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96F244660;
	Mon, 14 Jul 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490943; cv=none; b=EnUeq4cTY1dRRRY7Ap5O9tDOJWAaNqGW5Ely0HUE/oBEl071adSAUQQTSRF6HL7ntu+FZfwUv6o8Ot25w47Ofm1xZb7Cnf4oko3KjiY9ceofC3qlSyZ7o5jr99eYTdwtGhTEYa7fS7eYJMn3vjn/BFrF0pHG5zuQDfM/NZoUxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490943; c=relaxed/simple;
	bh=Q7mHjJIlM1zrLh2J6kLtqfIR0uerU9l9tMz6AXhZJUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WByY4WzKmxMWZRgGO3ZmwDKMGKxpCYiLVQ6HQyfNplNhVPlUInNa/KHrZQnsMJe6RrGEvqONcYoQyvDZzwjA/Z1JRtf6ClUwKNotfIG+aIA0R5aJ+O6l//RpkI00w9glnfdD0MFu8h/iYib1coJcPjOzCMsjig2P95mCtQw+qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cECLdLaz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AIo12JmCL5qs9O/rqxjqYFRpuvTpm98N98ZleGBE5gk=;
	t=1752490942; x=1753700542; b=cECLdLaz6FO83WSsD23mnC1sP9QLDT9y9Qt3WXJFHYvwyLh
	bWPPBHQpPOZaNGrMD24qRHd4S+TvbT99P4QpbeqL8ivozZ2/76SbySAAioPhbE1klIepsCWPlbAhr
	W5aJLWE28J6r4gohtyJYLoDb+lnn5cMeMqQ4sNaLJwvWboMtLg49pJR4POrLi3o0ePvNRu9NQoymt
	HJ7Rv+xF92nO0cj2g7QTdtYGsCuxH2dm2AZO5zJptoPxi6Vr5BNtLn+feEAKzgOt6QnX7UdWiP19Z
	hsHWPWcCYIZszL3k6Bf7cbmw35tPQK9leK55WKS4SLS4Syqc1Dx1x/TYbfHqnQfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubGwo-00000003wxR-3M4Y;
	Mon, 14 Jul 2025 13:02:15 +0200
Message-ID: <791111506ac7772108f00b9dae92fc4fce4217d3.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: Fix typo "ransport"
From: Johannes Berg <johannes@sipsolutions.net>
To: WangYuli <wangyuli@uniontech.com>, miriam.rachel.korenblit@intel.com, 
	akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	emmanuel.grumbach@intel.com, yanzhen@vivo.com, shenlichuan@vivo.com, 
	yujiaoliang@vivo.com, colin.i.king@gmail.com, cvam0000@gmail.com, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
Date: Mon, 14 Jul 2025 13:02:12 +0200
In-Reply-To: <03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com> (sfid-20250714_130040_758163_5B73BDC9)
References: 
	<03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com>
	 (sfid-20250714_130040_758163_5B73BDC9)
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

On Mon, 2025-07-14 at 18:47 +0800, WangYuli wrote:
> There is a spelling mistake of 'ransport' in comments which
> should be 'transport'.
>=20
> This typo was not listed in scripts/spelling.txt, thus it was more
> difficult to detect. Add it for convenience.
>=20
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/dvm/agn.h | 2 +-
>  scripts/spelling.txt                         | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

I don't know who maintains spelling.txt, but I guess we won't merge that
through our tree(s). Also doesn't really seem worth it for a single
instance anyway?

johannes

