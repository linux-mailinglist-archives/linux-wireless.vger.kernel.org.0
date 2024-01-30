Return-Path: <linux-wireless+bounces-2789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D828420E8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E111C2778A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DC60DD4;
	Tue, 30 Jan 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tz8+wydD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0D60DCD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609646; cv=none; b=Q1BwG0V2lJym6ijHGPJ4sr0hQ3pMkBcQuMG2gg8CvWor4sQbCL6ulVNjZmXKzyNJasLbyhNNpxjvcLiQXNooqS1sm/UdUI3qzCE9/uK59cgBGZm9uGtr1hK3mPe0uqW5S/z7JVMKpQIfhQxPZNOl15sVfcETrZ1yFmYjDePdLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609646; c=relaxed/simple;
	bh=EmZVO2g+njL17OWT1UBlcPlueCtZdC783pilJk5h554=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZs1/GGdOZLEAEG52WFGp/XVv2/xfgH8SI3RxE2F4zqvqjaOvPNLZnqP5WhouSuBr/eumHNA/niUK4a/grjcLfLkqRV5UBFnao0BSqsna+T2TK/2BL+4MM6H6wVuJAYw3Yeqrn9EgHn6CZtvrkLern78r/BNeOC9mQeNyuedhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tz8+wydD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qUtffOyz4aM+e8E44sEHeA/FwOFJ+v8wuv44yuIiT0A=;
	t=1706609642; x=1707819242; b=tz8+wydDqbNvB5k5Bv+l9UDVZypoMYyJ075M/zBoClMAsWU
	2oFheaFXB4MkfOcSF8HcmVu7i/Afpcq5bLyGdfNd2JvpLRyZJ35y4FAUwbF2mjzdjhRm2G5J3NBGK
	g1ki9vKKTRtG87Qn5UNSGo0cJPKe4LP4yzIfR9UPyrqMwsgInn0VIz2BOxT3Vvqud/7SW4lrvOxUW
	FttyfNoT5WcfjYH6LZXmXp4Q+ryFPN1TvsYSvil/VevHfYLp4AWkJ2FYaotPyNTyNDHWH+rF9NvCJ
	HZaLtF02fOcdiUF1UdRVLk7GmRaSYFMKL3j726s8IRzTvGLz5SlD+fNuPIBHKiyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUl7u-00000005yjL-12dn;
	Tue, 30 Jan 2024 11:13:58 +0100
Message-ID: <184a2907d637cd924160681b40f1caffa2fa1e92.camel@sipsolutions.net>
Subject: Re: [PATCH v7 1/5] wifi: cfg80211: send link id in channel_switch
 ops
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 11:13:57 +0100
In-Reply-To: <20240130043225.942202-2-quic_adisi@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
	 <20240130043225.942202-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
>=20
> + * @link_id: defines the link on which channel switch is expected during
> + *	     MLO. 0 in case of non-MLO.

please still use a tab (only) :)

johannes

