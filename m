Return-Path: <linux-wireless+bounces-22901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCAAB4C93
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDA31701B0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E01EFFA3;
	Tue, 13 May 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dExfaAKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9631EB180;
	Tue, 13 May 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120678; cv=none; b=hlXVwMX2GHW8JDTE+XCdBXYp3lD+z6936wWN0Tb9RR8I6iXEboj4ZMyaY5k9OrUer6X0sPOH7tFi3C6k9R6tIME8jbYuq+KB8HoZBxnSlhPRohg3znmEIbEvBz4YOT1MTbPBrQKKCZrE3LFqsqP+bpzrGdT6wKD8W9WUjrkyN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120678; c=relaxed/simple;
	bh=V5FNwPI2kQgLu1dX+l5kRapdnptiYaNrbywLNE+PKeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huLDab3M6dK3aILefbzLNQ1mzMDMilmJSSW3aOj9Zdj11xepUyVSVRUUnZE8bIDLhMnNpoioREeHVcgaSdHn5tzfCwvsmyTuZp9RrTFZxbEOZpThTiY74C+bzWinNMp5g6HNxGUFKz3YxskFkoSnrOREkJ/LmJ5t3E50GvYmgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dExfaAKW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=usLtNPHMdMJU1a6dRfum36pLhpdLH95VE6zNtQnTF30=;
	t=1747120676; x=1748330276; b=dExfaAKWXmrNj7qCteHnTXeHJB0w+QGhSBjt2X4RCNXMTVc
	H8gEwY5g19IQtGktMSi9Ru+gXdgA46HXEQZ5b3i2O2QWY7gFpm9l6bhJcrMj6+/YYe5/xnIRg9P/R
	nDzS4pD4NbUrgghImtPrj+bPdQR1ylhK7flOcxnqFALbN8GFRCkSaX4C8d9+aNTYAPo8LIoNOGbTx
	VCqQ1RGmMf4W+slgNfrF8eLRalwJi2F6k15ZbCqwkeKrg1GkD3CuqUMejYp2N/ltX3sIYQ0eyfSwO
	npiLDAp4JE2u4fQU3feMrfpr5IRHU5xdw0zQ9cZwUZiFogW8fboTxMEg4Yrww5Rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEjtb-00000005Ix1-2ZER;
	Tue, 13 May 2025 09:17:47 +0200
Message-ID: <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 May 2025 09:17:46 +0200
In-Reply-To: <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
	 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
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

On Tue, 2025-05-13 at 09:26 +0530, Aditya Kumar Singh wrote:
>=20
> -		if (sdata->deflink.u.ap.beacon &&
> +		if ((sdata->deflink.u.ap.beacon ||
> +		     ieee80211_num_beaconing_links(sdata)) &&
>=20

Do we even still need the deflink check? Seems like
num_beaconing_links() _should_ return 1 anyway even though it currently
doesn't, and we need to fix that?

Also seems the VLAN carrier handling is broken.

johannes

