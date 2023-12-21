Return-Path: <linux-wireless+bounces-1176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946781BEFD
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 20:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB180B253C5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47D697A6;
	Thu, 21 Dec 2023 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sb+QoArk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B77318F
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SazKN5I6TouJa0tg7zPtvLEos5DjILmuhn5hRGHHvI0=;
	t=1703186025; x=1704395625; b=sb+QoArklA4yItoCWa4anqm6KHJp7yADYoydT/0tzHwJA22
	en2ZiSQBURElIfh/tiJg+reM3oPXY91RTJeyuHCpoz4X/N8KxJnx90na1myewHyjtL4d3QkL+wzZ3
	5QflesV9wuR7gexQ7RAF16mvf8UYs3n7pO02Tc4pjMra852Tz66zIXr035KIGKV7iaFehxbgVT0vS
	ag9ngeLns1bu0uIXDPzm1NoJ/orrPDszrh83pvWdZGlNM/jWHEAn5ICsloCWfMrvOnAB32qpY6Rmw
	RWdOMZDK8778PDXkftwPUUiptpne3YZ/+AfUy2sqQeyav33PBNZOcVEqXp/68YMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGOUH-000000034Ct-2NuI;
	Thu, 21 Dec 2023 20:13:41 +0100
Message-ID: <0500067b5d2722f0546ae588934de18aa28b09b0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/13] wifi: mac80211: rework RX timestamp flags
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Gregory Greenman
	 <gregory.greenman@intel.com>, Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 21 Dec 2023 20:13:40 +0100
In-Reply-To: <05944e81-3c1b-485b-82f8-15b8cb991a4b@quicinc.com>
References: 
	<20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	 <20231220133549.d0e664832d14.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
	 <69e18f8e-0157-43db-bd11-78ee945d9912@quicinc.com>
	 <a817504ee11fd9bca316312b40218f82c56ec7b7.camel@sipsolutions.net>
	 <05944e81-3c1b-485b-82f8-15b8cb991a4b@quicinc.com>
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

On Tue, 2023-12-19 at 15:16 -0800, Jeff Johnson wrote:
> On 12/19/2023 2:43 PM, Johannes Berg wrote:
> > On Tue, 2023-12-19 at 14:41 -0800, Jeff Johnson wrote:
> > > now the code can return a value that doesn't map to the true/false bo=
ol
> > > enums
> >=20
> > No, it cannot, at least not if 'bool' is implemented in a C99-compliant
> > way :) It's not actually an enum, it will return 0/1 in the machine
> > register even with this code.
>=20
> Today I learned something new. Guess I'm still carrying baggage from
> pre-C99.

Which is not necessarily bad - there are to this day compilers that
implement bool as if it was an enum, and then it can hold values other
than 0/1 ... but at least for kernel work we can assume bool is
implemented as specified :)

johannes

