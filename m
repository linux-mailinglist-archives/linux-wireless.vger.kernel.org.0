Return-Path: <linux-wireless+bounces-4914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7831880222
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232B4B237BC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788B83A05;
	Tue, 19 Mar 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xyDzx/KT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F183A07
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865044; cv=none; b=aeZeBEnLiWDjfRmpmLkFCrrAMpqkj5qJVUJeQ6EsN6Tm8lqvW+VZoRNrUKNDph4DjqljRM5qzPWqyVLr+WabUFd/630kSlcxawyZgHscDxM9Sl+BXARvgkSmI8Jo4Lp6wkykJ9lX7JAC/RI0OSI7SLzyBgLYGBDVLyLJbEzNO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865044; c=relaxed/simple;
	bh=lqSO0zTAxsze7+nbBOX4ukwhpzjX5RPtH+52iGF4Umc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDoEBIQ/lXvWkdyGl8rAOv7sjSILS8mvSRyq2IaYjWtzxU2GZVLVy5GaJFvucyOni5bJtQh1f6daKADXELddjH4UwYKD4N3hQoACNH7Q5FiASNCwLnBQX993940bANA9yGwR64dhSq/ih7CMHZJvoRiEeZ0/eV9nb4t+r0S/Pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xyDzx/KT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q348DOBFXBdG81gOjLwZ5UmQPVvXe3/tV78L0KKvSjA=;
	t=1710865041; x=1712074641; b=xyDzx/KTrN6rdxsNCSn2/iyGIAAcugPxu8MRXyEUysQqD+q
	yn8/Vwvb5XygcEXYW1jpsJIpVltYS69zLRXxg8Qq4JsNcGyf7gVy+7pbsL9i5cbr+EHN3Yd7SH8tQ
	SV/CfJWXicBDE44wksilBw7EUee3a2UuKtOlfY0pHHMgpHu1FAImLgl7QfbN0nPp8KizVU+LJvj/i
	FW5j559xFCA2PPaA/u86HXw8mWNDe4VFIVgWdgHW/CxeiOWCjXeGzr0kjXGr3LIsrrgHD1+o3K7VB
	geMgRZyMzrYuJFV2yCR48umfIpKoCEvBZq+5Avx5RfUCpS+Pb6dlJZQAF7rnvWzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rmc9O-00000005mhT-0gs2;
	Tue, 19 Mar 2024 17:17:18 +0100
Message-ID: <6af0d6e3a2c5a67f261f559f8cc28eae0224f34f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround too long expansion
 sparse warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc: linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	shayne.chen@mediatek.com, ryder.lee@mediatek.com
Date: Tue, 19 Mar 2024 17:17:17 +0100
In-Reply-To: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
References: 
	<5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-19 at 16:12 +0100, Lorenzo Bianconi wrote:
>=20
> +	pwr =3D max3(pwr80, pwr40, pwr20);
> +	mphy->txpower_cur =3D max3(mphy->txpower_cur, pwr160, pwr);
>=20

Oh nice, I didn't know about max3, I had a different patch at some point
to just chain the max() with extra variables :)

johannes

