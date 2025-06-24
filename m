Return-Path: <linux-wireless+bounces-24429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEEEAE666C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1941F17E24B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F692BFC7C;
	Tue, 24 Jun 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jjjF2km9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8E291C29;
	Tue, 24 Jun 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771623; cv=none; b=N1RYh1j/CsbzyXTSTcPQMlOD9DFX2T1NGNv7mrnzC6V8VI2yixerLRKbsM6YdKg9hkG6pnRvqMK3MH4YVU5vqyQqZN5nIZtKHBti3CiZmLgHkbRSwxaaL9wnflj3BCHLAwKmjw606eQ+ntgxpXa6Zye5lMkQF7alyiKHhPQYoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771623; c=relaxed/simple;
	bh=4Oq/SF/xG32qfmS58AwTENC3gPz6m+J729giDcFj69E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thxogkuRlzCLu1QZtxQCuCVpnVcokQWFhd4HdcZY7oPfz6Vq3yet947KFs2HPqzuD3a4NL9wxDLEB81CCiolgEzy92hSHBq69rRLYFFSoR04ne2k9/VCyxLvLmrLqUF2H8IQqKwbXwgLQ4MxUuj5FlqJVvAEg/UEkeqaXCsLmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jjjF2km9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4Oq/SF/xG32qfmS58AwTENC3gPz6m+J729giDcFj69E=;
	t=1750771622; x=1751981222; b=jjjF2km9QhdJ0PWAdsCMKZ0R3oDEWokQklhMpNVba+vnWVM
	kYbG6oQAdbvVvJn9E1qTjXdVKS4s+ZE02d7jQo+G1Hy7q+VyccIG7wDV55Tx0XUqqpzsdfEX8iNEY
	8piWB9/lXx4ixJohljcS0snvTVounoa97/xiQLc3g17cRe4MSODXS0Tun6DrY4hVcnqlC5kIU5FLx
	S+1oMm2ta2yrcIo41FEEpheJ9y43XpX2wn2KVq9QW7t4sAfnB1qiu//J7N8hzLhi0gnhaYDkDZ9Rs
	xqUklJjx0kWPISzKYIaJG7/t3a9vj47G8XP/lBQMk+wXktNkKlzSeYKhYyZDuR+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU3fu-00000008rkm-1xe7;
	Tue, 24 Jun 2025 15:26:58 +0200
Message-ID: <e83c0841a3875aebcbb830949abc44d909d64da4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Jun 2025 15:26:57 +0200
In-Reply-To: <20250624-fix_scan_ap_flag_requirement_during_mlo-v2-1-c8067d0ee1f0@oss.qualcomm.com>
References: 
	<20250624-fix_scan_ap_flag_requirement_during_mlo-v2-1-c8067d0ee1f0@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-06-24 at 14:25 +0530, Aditya Kumar Singh wrote:
> Commit 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan reque=
st
> during MLO") introduced a check that rejects scan requests if any link is
> already beaconing. This works fine when all links share the same radio, b=
ut
> breaks down in multi-radio setups.
>=20
> Consider a scenario where a 2.4 GHz link is beaconing and a scan is
> requested on a 5 GHz link, each backed by a different physical radio. The
> current logic still blocks the scan, even though it should be allowed. As=
 a
> result, interface bring-up fails unnecessarily in valid configurations.
>=20
> Fix this by checking whether the scan is being requested on the same
> underlying radio as the beaconing link. Only reject the scan if it target=
s
> a link that is already beaconing and the SCAN_FLAG_AP is not set. This
> ensures correct behavior in multi-radio environments and avoids false
> rejections.
>=20

This triggers a warning in ieee80211_is_radio_idx_in_scan_req() in hwsim
tests.

johannes

