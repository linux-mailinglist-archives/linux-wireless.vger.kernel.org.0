Return-Path: <linux-wireless+bounces-17427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8457A0BB17
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235D61689BA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DD243355;
	Mon, 13 Jan 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jp4pcKg/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E09243353
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780290; cv=none; b=gXLSRx0SkZzjhCVr6SaHu7rW8cc2oAhPNkAavH3eKofKwGEMZQKNFu2UdYPvZsz6pgIgClXP+0hP8wNUa3fX7ZG/n8aqRFL/AhAFlK2w+MSF6a4Wbym7e5GnX+WnZ0E+wwlvY3ohzvOPUmtOOyBlfyDVGhL/Ra+/55a3Rt4bz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780290; c=relaxed/simple;
	bh=Rn9iapgDk3yyxazd/Cjj+/iynmQ3Bay85/x2hh4Zvkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoWSsgPS5Jwk9Jmt2jN6TbPnw7i/geUQ43xwS4XF4j1Jx5hwej6EJqpA70rL8FGqaTR98XmZCWabIUz2Es+dFtoeRY0EbCj6ujR6ntNuNXc9/xol9YYRk0oZpQNSPVDf9yO6d59Z1uG2oZ7022ugViJ0llxNAK7AQU5273kqoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jp4pcKg/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Rn9iapgDk3yyxazd/Cjj+/iynmQ3Bay85/x2hh4Zvkg=;
	t=1736780289; x=1737989889; b=Jp4pcKg/naNDqXonIBB3BmgDFXqDlQ3DTXA13aXi6M+KqlD
	KD9sWlCcj5z+qPELmB+9BzLblVzw0eGFfA6e7a9Bf/fe3lc4hcIhXiBDIVcBxtDFzMsukyRUY0PHc
	tj+Dj0V9eXMlOeMSfHn7EoeBSWL6f4qpmDc+ewCGuGjDUCdHKSD3Pvd5B+y00EuwRO3lP2/swI8Th
	o2eEhhvOlJWQsCoZ/kLL7xXhG9CvWIwod5LR7HllBVfZugBixB0nfCe93ybgJbQHpB/SU9TBFObiW
	5QvCMpxpaWHnyY4nf9EzlAb4F1qo6+nJxcL6+kb7EFYSnqg4yQKQMlyD/lHfaVWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tXLtF-0000000DeBt-2hCl;
	Mon, 13 Jan 2025 15:58:05 +0100
Message-ID: <db24c2eecfcdb1e5b77e68891ec2c15390ac80db.camel@sipsolutions.net>
Subject: Re: [PATCH 00/17] wifi: mac80211: updates - 02-01-24
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 13 Jan 2025 15:58:05 +0100
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Pretty sure you got the date wrong, but the format is strange too - I'd
appreciate if you could just use ISO YYYY-MM-DD :)

johannes

