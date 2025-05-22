Return-Path: <linux-wireless+bounces-23271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6AAAC0443
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C13A34F2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097891C245C;
	Thu, 22 May 2025 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hqwk+rY2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776061AB528
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893120; cv=none; b=TYD7H5m+/PmSSDEhmTYREeEl5Fiy8KhWKbt7R6jjxCeyScV5dhNNpnEMspzivKUUn4aX1j4xJN6z+8pYkVEhyVvdL150Ujp63/W6ABXM1d9ZCF4iVjCrTtGuJKImox0atsx/vJ9DygHNd59gaH0/8pysryJgq2BQVbD+6ZO6ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893120; c=relaxed/simple;
	bh=FesNf8gTSD3Z5gCpq67BN8pPfYORLITTqwkzuE2xVJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=abylWVqcguNheYj2OCzj3i/s2Zb6wkFGY3qobXXvCyWSC6PZwwjM/nflgWyzVkjZcDeBIj7JMXhNoeF4kBn70Lds7szZ5kR297/Na4/GpPjMstSrth83XSPTba/2yHsFxEcn8oyFw5ZGNC/wXurwA/38Sl3t5EFXJHA08iIIBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hqwk+rY2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FesNf8gTSD3Z5gCpq67BN8pPfYORLITTqwkzuE2xVJw=;
	t=1747893119; x=1749102719; b=Hqwk+rY2ZPOK+MF3XVoz3Au5RMtgy2e86yqq0EfMzq0n1uC
	fBBnNe/xbAQRnvWAcV+YBmPTVHWS0wVYIdxRYWqYf1sW79fr/S/oy2l50Ao6hbA1ZWhtEv8NPJwDQ
	RPfsc9UTkK0uU6VS2wPt+Me9E9EVOhpaQZsclOTuqzqymZcv2LZJ6CywCR9uDr0qW8u9SMa+AJcZ2
	Fw/2zVgn9N7VuEV8V5nlYlMT0u79mpcapSqQ7jU6hD9we9L8Vn5TpY4MrZLEveB3s+lWHZVZnb0I1
	rJjw86tciA/YTXYpn8YOgOhgPauI+5VUtG4d0qnW52VWAZySiMh+eI8HqGvYiHNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHyqR-0000000GAsO-0D2P;
	Thu, 22 May 2025 07:51:55 +0200
Message-ID: <41ac222861e4667a66afb97b9b0346722ec616b7.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 22 May 2025 07:51:54 +0200
In-Reply-To: <3e19960a-4809-4215-b6ef-d66d6dcd87df@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
	 <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
	 <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
	 <45ce63e59fbf1c49ca295f23f802c2a6eebfdfaf.camel@sipsolutions.net>
	 <4bf37331-5989-4b60-8981-ed20cd79969b@quicinc.com>
	 <df3d08425fc7d5db127ccf2e84c258b7c728b751.camel@sipsolutions.net>
	 <3e19960a-4809-4215-b6ef-d66d6dcd87df@quicinc.com>
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

On Thu, 2025-05-22 at 11:20 +0530, Sarika Sharma wrote:
>=20
>=20
> Yes, there might be chances it was used before.
>=20
> Shall I do this cleanup before this series something like cleanup to=20
> maintain consolidate data for tx_packets and tx_bytes as nowhere it is=
=20
> used per AC?

Let's just leave it for now, this is already enough in a series.

johannes

