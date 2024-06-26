Return-Path: <linux-wireless+bounces-9608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D7918100
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41415284110
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCE15B155;
	Wed, 26 Jun 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YyT1pxff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CB15B57D
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405472; cv=none; b=d33hD6DoAZKL+WraCHQSFCxvS2oADccUdoGYDm6PFf6vskvTbotDjG3jrU+4SDnLnyY5qCAYBvMz4Y4W3mMmoeEci7NcwVrNwo4jGPqkpsCKNKqKF/RHjwNxmkKdUfAtRx7qr6BHinZtWhPqLhFkYNEX3kKZSbKJpYNEOBwAB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405472; c=relaxed/simple;
	bh=uiS0TFQQh/BzyVWwx5GeiytlqOoynVuvOo7iHF6PKEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lbUxJncqGy292yPSIicZ8WSbwazkTMFbVYj0yM1kyrDaQdXCqlOoSS42KswU9JQEyErYhUiAWFQ6SR9oJW7bGBcl8s6DXdI0xsb/Edbk27/YytnGk3W9X7hJmq7Y/xh9EOp8Zxm2ZcR/rZvNHr2F77Fh5tX5WKn1mH/LZsxVHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YyT1pxff; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uiS0TFQQh/BzyVWwx5GeiytlqOoynVuvOo7iHF6PKEE=;
	t=1719405471; x=1720615071; b=YyT1pxffGvJP8ta0xzWv/Nkh6CuaZjkFhL9bg0gzH/+tkla
	MT1aQq5uBdEgfgm5UAfUNtICXaW/PeO1DpHoF2vtbvFHojNsqdMMTMlkulL7BIU680IQMWp+X/Btf
	ZMU/7yzqwkr24s8l4A/LCv5cNO+byf/vsMvH0zG5sk1LDNqNzLJyAFPiTTs3co6hiqPqEL07yrNK6
	+OPsVHi0p1UpjJ3SeuqlH80O54y7Um9PpnqaS0WaRMxdsi5kZWb7vMC1iw2BVVKXZ3MizQXsIzJWW
	PgzwFEwOCIokdmwoTf5ot5iPDYDF2nKHipkhXp3/4e42NbMr2clTByWnMIIMh6fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRuG-00000003eom-1TJz;
	Wed, 26 Jun 2024 14:37:48 +0200
Message-ID: <2670d8e27e9c296e3c0de0572f6387aa9ea3ff93.camel@sipsolutions.net>
Subject: Re: [PATCH v2 9/9] wifi: mac80211: abort active CAC while freeing
 the links during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Jun 2024 14:37:46 +0200
In-Reply-To: <20240626045216.3754013-10-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-10-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
> If CAC is started and the interface is brought down, currently, CAC
> started on link 0 is aborted in function ieee80211_do_stop(). Technically=
,
> by the time execution reaches the above function, all links are already
> teared down and hence link 0 (or deflink) alone is handled. Also, since

nit: torn down

> links are teared down, information on other links is also not available.

same here

> Hence there is a need to handle this in function ieee80211_free_links().

Not sure I buy that argument though, it feels wrong. Clearly you should
be able to stop this from even cfg80211, it tracks whether radar
detection is running, so whenever the link is removed, you can also stop
it there? Doing it on free seems much too late.

johannes


