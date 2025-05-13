Return-Path: <linux-wireless+bounces-22906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC839AB532A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4797F1894665
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9927E7E1;
	Tue, 13 May 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ml5ZobSb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6C27EC6F;
	Tue, 13 May 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133304; cv=none; b=HLQYaL8O/10RwLgpETNnWYSKGcqAr+ebqrK8MBNPdrzc1jwrZ852JhZJ2eS4sgTyUhNw9Gh1SaNZQYZVFONpRrIx++Jh2QwghNfVSHxmVZ0Spb3ieuNrxBID7TGoirvZfCRLyae/v49Mt/n8y9JPxAfjmrKkVxoTCaN1vmGvzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133304; c=relaxed/simple;
	bh=GMz6vZhtI/7cP5TitjZoIOK6D+Yj5u5aTf6YXDhzv0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEgmOfkFKU3e5SGEUv2zhwq31O7X/Cff/snHjklH6IOvdYOUZOm2n4mOD2hY2VwTPrB45XSXzi9QqYhsjUQ59DYZ0/+zFMID7jy2ZcJn3ZeoIwNBQKbpXKluNmxYjah8+ryIwNVV+BCe1fjtT33o9a0BkKyA7j9qRNRnC3U30cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ml5ZobSb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GMz6vZhtI/7cP5TitjZoIOK6D+Yj5u5aTf6YXDhzv0E=;
	t=1747133302; x=1748342902; b=Ml5ZobSbFnveGtOFEvLWTZWSqJZ5I00eRRVg5o8PRpQJSYW
	2gSfKmP0XQVcq+wQYvsOSj73Yu1yz0SJSV4FIT/ISRiihwEzuErg6wiNICgwCv/+/8feeogpcazRP
	VPb+tKetN3RwUSfrJ2UNG398WlnmZy3efdN6s7LFdVCMh5ks3gCP/cL3mFgLzx6ryY3SZ+X7NF1Rg
	nDkDolMDg6uBocX3/VnSOIkiqM3S2fgVxd5sh3mzsB9xW+WeZV90eNcfJi7FF52C5L3TWOPiwPTwX
	ntxAPha93iL+YHKTwb1gdFMVGGoxp+FZ3XP3A8VtJPZPzxAQhsi0Y7+Ef4n5TwSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEnBL-00000005UNi-1UHK;
	Tue, 13 May 2025 12:48:19 +0200
Message-ID: <d211e634532031322a77053ff912394714b5ff35.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 May 2025 12:48:18 +0200
In-Reply-To: <77fe950d-c5af-4c28-8b0b-bd1aa08d885a@oss.qualcomm.com>
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
	 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
	 <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
	 <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
	 <296b9aa887022258f8ec8e4f352822c24b41ab82.camel@sipsolutions.net>
	 <77fe950d-c5af-4c28-8b0b-bd1aa08d885a@oss.qualcomm.com>
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

On Tue, 2025-05-13 at 16:02 +0530, Aditya Kumar Singh wrote:
>=20
> Okay sure let me first send a clean up. So,=20
> ieee80211_num_beaconing_links() should return 1 for non-MLO as well?
>=20

That would seem logical to me? For this and many other things non-MLO is
mostly equivalent to just having a single link (apart from the address
translation.)

> And callers should test for =3D=3D 1 instead of <=3D 1.

Not even sure that matters enough to need to change?

johannes

