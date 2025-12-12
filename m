Return-Path: <linux-wireless+bounces-29716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41096CB8CF3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B7543087F36
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409E30EF82;
	Fri, 12 Dec 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ov7IpqqS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA176322B9E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542865; cv=none; b=DSxpiFhsS16LXMuLTLnqWKbUEfDf+a4gohCsp8kA685I+pHgiN/TxK677NYosMf5stoqlXE/4j+8Q82OAWl+9hl97OVsFoKYDvef9QCCPVpDnxRVZjlfaB0eh2ip7tLqTV11J/cNqqM5b7ORCOw6WZCWVEauT+I1+w7SO9luI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542865; c=relaxed/simple;
	bh=MNxYzI7qBikzzPj3Kp7xpJbVH3KxcSA9sX7kkhVoiRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0kHEnT+s0GE81G+EjRnSzmqtZhRsvkaDJ7d1rOqjQerfUS3idNMxTwLQIoJTrV6iwVPMXtXOp+fu0ZVOQAWCp/k3hZQkaxSh1m7nkmNFGanwdX1tkBTAscCfFsOc71sSGUEhMYh8ZVVtCxNZZ+7oslaQW04wwL2cjbzChKkbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ov7IpqqS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MNxYzI7qBikzzPj3Kp7xpJbVH3KxcSA9sX7kkhVoiRA=;
	t=1765542863; x=1766752463; b=ov7IpqqSVBGrnVatJY0U+h7ZXgsePdUDV5ALcizHuJ5XB17
	5T3liZrpvvFKQUYSZBhY2kcHAJ1Hl0h90GuW/N8XTH/+DeEaAK2U/9/Gc5REWJF32KMlbxZb0dfK/
	VUIjYBQE6LDpCPWLERccFYK13VcbY+knEEsLkE1ZzM71A7QWo5me2TBp+p2fBfSsOdKRoFkvp9KP6
	nPTXtODtGONEBBqa+xLaojunXkMfALLERZLFb8tjZ5llEP3+L8PuTCw7D5eKYftvERHVxphR0nntj
	pQ947H86BN3CdDoYGQhSaIma/zuCofvJnyFbTeuZWmEYNGo/DAEltFIXgiF6LfyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2Lk-00000003TWA-0H9y;
	Fri, 12 Dec 2025 13:34:20 +0100
Message-ID: <438a3bf3725c66615fb2a9922845a2bad0245993.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 09/14] wifi: mac80211: add MIC generation
 support for EPPKE authentication in non-AP STA mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:34:19 +0100
In-Reply-To: <20251211124051.3094878-10-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-10-kavita.kavita@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
> According to the IEEE Std 802.11-2024 specification (Table 9-70),
> the Message Integrity Code (MIC) element must be the last element
> in the authentication frame body and is present only in certain
> authentication frames, as defined in Table 9-71.
> For Enhanced Privacy Protection Key Exchange (EPPKE) authentication,
> as specified in "IEEE P802.11bi/D3.0, 12.16.9", the MIC is mandatory
> per Table 9-71.
>=20
> In the SME-supplicant case, userspace constructs the authentication
> frame body, computes the MIC over that body, appends the MIC element,
> and passes it to cfg80211 via NL80211_ATTR_AUTH_DATA with
> NL80211_CMD_AUTHENTICATE.
>=20
> In MLO connections, userspace constructs most of the authentication
> frame body, excluding the MLE, which mac80211 appends later in
> ieee80211_send_assoc().

Clearly you meant ieee80211_send_auth().

> If userspace computes the MIC before this,
> it produces an incorrect value over an incomplete frame body.
> Moreover, the MIC element must be the last element in the frame to
> comply with the specification. Since mac80211 appends the MLE after
> the userspace-calculated MIC, the ordering is violated.

This is all a correct and good thing to realise and ask how to solve it,
but I'm not at all convinced that the answer is to put 300-400 lines of
crypto code and key handling into the kernel for it.

Might be easier to just have wpa_s generate the MLE, and we simply have
a flag that indicates the MLE is present? Or even just check if the
element list contains MLE for when MLO connection is requested? And if
userspace gets it wrong and creates a MIC element w/o MLE element, and
we do MLO connection, that's too bad and we'll send a wrong frame? But I
don't think that's a big deal.

johannes

