Return-Path: <linux-wireless+bounces-17765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57652A17442
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 22:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074521887B65
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AD1EF094;
	Mon, 20 Jan 2025 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xiWodpLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F98199EB7
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737409300; cv=none; b=uvfGEA3BDeR/os2I7BVnvPeLwTHLJbkUhTChuHCMXxtt186cZeEEYtd+Ydf2gcnHOSicN3jHE3CtgNJP1U+wVnhk4ZGdd2ATRTwes/57ut3iKkRwfnhwbE18QN3CJAx0h5S3y8E36X1R7/+MazLlnIQJmBX0Ny5nyYXsS6u+JzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737409300; c=relaxed/simple;
	bh=gKJ2ppT4hgfkVKcoXjI1niMALLcVCG6GLjf84QJcGkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2ludd2PaD1uJIiYHsh8yyynH8h0RSCY1yZ3eN5YvEW5thoo1hqYAlE72IQP9KVmgAge5dnZha++rdW5sba3s5afSJcfATAW7SyJkiwOiQuNaP62UAq+Yls1H4Tz0JyQPmfSsTAm3XqU4AqHRZ3zi8gltyzdsMEC8oL7C9g4Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xiWodpLl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gKJ2ppT4hgfkVKcoXjI1niMALLcVCG6GLjf84QJcGkc=;
	t=1737409298; x=1738618898; b=xiWodpLlXvXxPN2TOnmL6VEewPY5pioERsZ7F4Emgk6zrTq
	RrlTSCSoJWzxax4kur+6goB6Ag8EdVw66ZR8EpTsxL6gaPfYFoO/YR4QtsEUsjkyio37WtH741KX9
	WiR3BhkLaqOKMbL1xWHjNY1EQZxLmREazi3jRntnXaMkrwUuIZrcy6H4y2cWkk70GSJyqIhx7eTra
	gBuwiHNeaRjIbWiVKrulrjgy2gOdfPU/INj+dtHvRoM9oe+V5+wNGdD6vqOkjXM5mkJt+crcP9h1s
	BGTo5qoi9h+35JMCbTjVqpk2SSHWPPmchE9coJYi0rbm+pNXKW+PdNMxVNHyr49w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tZzWT-00000003tSA-0bfN;
	Mon, 20 Jan 2025 22:41:29 +0100
Message-ID: <8543cf2d657b0b975830434eddaf76c35dee8c23.camel@sipsolutions.net>
Subject: Re: [PATCH RFC v2 09/12] wifi: cfg80211: add accumulated statistics
 for MLO links
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Sarika Sharma
	 <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 20 Jan 2025 13:41:26 -0800
In-Reply-To: <e484a38c-90ad-4ff4-8b86-2b714dabb6d8@candelatech.com>
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
	 <20250117124554.3719808-10-quic_sarishar@quicinc.com>
	 <e484a38c-90ad-4ff4-8b86-2b714dabb6d8@candelatech.com>
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

On Fri, 2025-01-17 at 07:59 -0800, Ben Greear wrote:
>=20
> While at it, can we define these a bit better?
>=20

No. We're not going to do "while at it do random other changes", ever.

johannes

