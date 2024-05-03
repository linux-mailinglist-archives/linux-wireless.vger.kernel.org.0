Return-Path: <linux-wireless+bounces-7131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26F8BA7C8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0744C280DC5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DE146D47;
	Fri,  3 May 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TWOnk1Wz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19419139CF1
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721434; cv=none; b=Uuu+RWOv8Nak83pyP1GG3wmcnu3FAeF1HLdSRdx2FrpDveFdCk3Uf9RgpsZXeL4bft7DJ8zGw8vjrqUtfcE9ubfAwEaUv9eCppYAp/nbkqV0ShyUtuu9c85gj+/VdyPNZ1+DA2ybavEaXWRDPkEk2RcxiRZpLzzL4U+9aTPOAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721434; c=relaxed/simple;
	bh=dKo0Z91tgLvGRSS1P/vRqhhsNrROxVkRsdMCAt/7o3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mp08DnJiwabWHUEPYnqBfge0K8up77O3wZqN2rv1UDSIxULO+k7YPnAwMXGSFVs/WzdWeVL00kerysl83Bh9ZaPBcVGDSDVvWXPZ5J3elDd06GieyQ1jsKOOdGQgsv7hP35hTuYqjzbqlRLcPtccKvx8qsoBzRHEwzpZ7ey7onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TWOnk1Wz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dKo0Z91tgLvGRSS1P/vRqhhsNrROxVkRsdMCAt/7o3A=;
	t=1714721425; x=1715931025; b=TWOnk1WzohgeUwqaHYQMicB2jsFYe73wYM09lU7P3KC/cNw
	z+UNj9F9t5yyG2waTlKWMkacOPYrunWUXmauVf/Ff1ORm/8Tzt4HvsYESi7n/4HQ7HPvqh/wNY3AN
	3F4z36AJDqD3sO3slWJFzbHS4yAwYjJGaoWsDkb7zGJmbCvsB6X5ejCouQsbC0PnpPRgdjbKRIvvo
	Ljpmx5CAX//trmSPnaSyL+WNCRm7tc0KsQ6keHeaQBi6fTvVbLaMD28KAyb0FG77uian5N4daBHEj
	3rvyY0B8hVVLdjplDLkFUI8DDkxJ5PP2V9ecTigIgWoKfKp7K2mDQqhLcXNIUSKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s2nMy-00000001cIQ-3UtR;
	Fri, 03 May 2024 09:30:13 +0200
Message-ID: <8d6b5aab2ccfcb90547536fd334a6d69ca7b6943.camel@sipsolutions.net>
Subject: Re: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
From: Johannes Berg <johannes@sipsolutions.net>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Fri, 03 May 2024 09:30:10 +0200
In-Reply-To: <c6891df6-0b34-43d6-b931-16a3da577407@quicinc.com>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
	 <20240325201031.10837-2-quic_pradeepc@quicinc.com>
	 <8efc258b698acd504c1fc699d026b906bf383894.camel@sipsolutions.net>
	 <b4fb2e9f-b7af-42da-be97-9ae1560ebad2@quicinc.com>
	 <a313c313ab41325843092dc8445386dd802ed115.camel@sipsolutions.net>
	 <c6891df6-0b34-43d6-b931-16a3da577407@quicinc.com>
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

On Tue, 2024-03-26 at 11:36 -0700, Pradeep Kumar Chitrapu wrote:
> >=20
> > Yes but ... you document AP and non-AP STA, but only implemented it for
> > AP?
> >=20
> > johannes
> Sure. Thanks. will fix this in next revision.
>=20

We got to v3 and you didn't?

johannes

