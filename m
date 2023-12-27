Return-Path: <linux-wireless+bounces-1293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85781F192
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6777AB2140C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2643F47761;
	Wed, 27 Dec 2023 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xvc4qGAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387C46B85;
	Wed, 27 Dec 2023 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u2wnuuLQYT1m8FdbY7tnB65SRTLaJoA6JvL7yUFYK8Y=;
	t=1703704716; x=1704914316; b=xvc4qGAC2Z+1lxNzocrSdlU4jPyM/c080xqd2eRPcboR2fC
	SqB8UHFUzSW9y73IsqLPfM/dIZ0RCpkMC+i3F+XAU8PTEftX7GleVAMJiTwADftSrd29F+/cTajED
	S6HTDiYPmAIgGcqx+949+uBAFj/o9utv54Ee54kh7iSXsIyem0EHj55nz/jUBJfcMJumD+lRpuop7
	wNJS6Xug6/LEy5Mtj/dij99clWqVb4xYiFcyrvXH29YA+WAEdNlUTCkOCro8CK+/exxIaxD3ZPdNr
	PTCfLMdbnZkHntLFe6xSiOOTNPGg3SgLv+uHIrmQypiEVzlZcXBzO9l1gegsAOuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rIZQA-0000000BHAS-2v1t;
	Wed, 27 Dec 2023 20:18:26 +0100
Message-ID: <4274b2d3892f548f3a56fd6040d4a9c1109069d8.camel@sipsolutions.net>
Subject: Re: [linux-next:master] [wifi]  ce10e8653f: hwsim.prefer_eht_20.fail
From: Johannes Berg <johannes@sipsolutions.net>
To: kernel test robot <oliver.sang@intel.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Linux Memory Management List
	 <linux-mm@kvack.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 27 Dec 2023 20:18:25 +0100
In-Reply-To: <202312271555.3fbe1cf4-oliver.sang@intel.com>
References: <202312271555.3fbe1cf4-oliver.sang@intel.com>
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

On Wed, 2023-12-27 at 15:41 +0800, kernel test robot wrote:
>=20
> Hello,
>=20
> kernel test robot noticed "hwsim.prefer_eht_20.fail" on:
>=20
> commit: ce10e8653f8b6569ea5d4f96917b5eaee7437072 ("wifi: mac80211_hwsim: =
support HE 40 MHz in 2.4 GHz band")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20

Known issue, should be fixed in hostap master.

johannes

