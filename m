Return-Path: <linux-wireless+bounces-19534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C135A47959
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D243B06A1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D937227EA8;
	Thu, 27 Feb 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="anvRc7rF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA122687B
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648744; cv=none; b=Oa8BAbZR4/kC/TwQMkXbcgXfT9SGoN9FrMT9JHyx5c7SX0SbaUFZ8fr2vj6SVSOVncCBxB3F5MVtwVunH9dce+5L4kOwIZj0oopqZTcNfkHSgCybqOCNKZTO+32LvLtmc1w91RwG9BAaojgOaI34jq+yEazUMHqDf9F0HI2JTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648744; c=relaxed/simple;
	bh=OZ667nlR5K4N4gfwiaQsj8aDolpBaxgNKl8SPx17ZhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JrEW/W5Cq06svP9753hq/77IpvqGCJ9YAKNdziwglVtDzPND58b753+YI6nYs1I+SONMEvbARkUGSnt5sdMfSbHPmPShbe3LuKfKQxG5F0q5bMty+I6roKaHbFiNO0BlJzhystqqdmXXJDACSR0UWuwkjR+LXI3i8sm2nnWOehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=anvRc7rF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OZ667nlR5K4N4gfwiaQsj8aDolpBaxgNKl8SPx17ZhE=;
	t=1740648742; x=1741858342; b=anvRc7rFoUJEUjGBnB2m+RvECM64LrKGXBZINLwsD1LTjak
	ZVTCxGbg1iL6RGi/MpWxsdPT2IITtO6VFyjkEarRgrBWWhJQ90oQ5w5oz/smWa/5/YNBbxoO5lCK8
	Xml1Kt9+sAPSNJr0Bp4jEvHujgTn7+8NHcF/0AN2u6GWOUAz/GHA9Ve4KPTDFqByq+zNGpLw0lz7D
	kn0bdPZBqb9IarlrRJ1sf96yBpCza5Id4uy25cZQhIOV14pnJRs5X4bQv5808HP1oF1IpeL2ctYzU
	jF5SJRmNaSigZ8KxH8J6aXfg1YN42xpxKtJNToa1xM0oqeSEOkuq959TR1yxONng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnaFe-0000000CWqz-4APc;
	Thu, 27 Feb 2025 10:32:19 +0100
Message-ID: <900f042d03d34385fa3507610ae291a36ca4885b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link
 statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Sarika Sharma
 <quic_sarishar@quicinc.com>,  "ath12k@lists.infradead.org"	
 <ath12k@lists.infradead.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 10:32:18 +0100
In-Reply-To: <df26e3aeb3724d969f444eab65d8c872@realtek.com>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
	 <bac3fdc3bd39e45150e5b7d60be01b5d732a04bf.camel@sipsolutions.net>
	 <df26e3aeb3724d969f444eab65d8c872@realtek.com>
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

On Thu, 2025-02-27 at 09:30 +0000, Ping-Ke Shih wrote:
>=20
> I have encountered structural (not functional) dependency problem too.=
=20
> Could you share how I can tell NIPA the dependency between two patchset?
>=20

I don't think you can at all, at this point.

johannes

