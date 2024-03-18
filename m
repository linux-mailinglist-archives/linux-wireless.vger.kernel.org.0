Return-Path: <linux-wireless+bounces-4833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988C87E682
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 10:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C67B21586
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C332CCA0;
	Mon, 18 Mar 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NNbIw00t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209E2C6BA
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755758; cv=none; b=X7eml7aydciWXXjLY0jPYhaFBoMugyzQSClQR8yAmhbjH5ayehv9u+2mk2dRQHqiNKHyTlzTJ8v6qnkvlFFODy1ceVpQdMKQNAyPPnaXjR0mWRFJZEc/zfsvjeKI0YxfGf0lQLk1JkXmTdPSK+1CRS+tlLgWwqwzkQLOLqySnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755758; c=relaxed/simple;
	bh=KEYUKK6atuh8tWrndC7zYV4NeJutCPgithR0VrYSaDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqAMcZKp4vWtn8COruPGts9k9ytBOfCc8PrkdixxV8PgO4B0GowyL/xcXjRNL9FnaFqAvJjwFauFejknQWhkjp3OgFQYput3dM8LPSiQ49uqfwgukOwPtoniRBE2v1cMQahsFKg2WTVcd6W1fE8m8lUfBCT/tB9fFtFu6nqgLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NNbIw00t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KEYUKK6atuh8tWrndC7zYV4NeJutCPgithR0VrYSaDA=;
	t=1710755754; x=1711965354; b=NNbIw00t2pB4bG4yycBXh4azTnXMdyySSJwn6J0hxbZXDDV
	MKcNDN2CfB/yBOBeABdK897NyhFtIm/X3a6JB35wvNUuUDqJA+0gDBg7xgwYXhVAmMo4r4fKcCgSc
	38imFoNLsr5WAO32Ed7MYtOD/7W1GKd5mk9nhbSgGzvdFbPctW8+PA37ohExmmEQR4q19HKXNRr6d
	qkL6YYQUXbCfc7IMmuvq2nHk3l7zCJ3ySgo5uXcDCIg4F70ntPK6qy3iCNyw3pfry4teotTeY1AsE
	UMdOjU3Ym1bbBMvA83YxRju3+J0ga/c/UCpUetjfGeHDYdP/foKhuCebuNmvNeBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rm9ib-00000004AXU-0X1Q;
	Mon, 18 Mar 2024 10:55:45 +0100
Message-ID: <5cf776357daf3a612b40a38cfe0328438c90451b.camel@sipsolutions.net>
Subject: Re: [RFC 0/2] Handle BSS critical update procedure for probe
From: Johannes Berg <johannes@sipsolutions.net>
To: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 18 Mar 2024 10:55:43 +0100
In-Reply-To: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
References: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
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

On Mon, 2024-03-18 at 11:06 +0530, Rathees Kumar R Chinannan wrote:
>=20
> Add an ieee80211_critical_update() API to send the parameters to cfg80211
> and call it when event received from firmware to update critical
> parameters to user space.
>=20

I'm confused, _why_? What does the firmware do that changes the beacon
that doesn't _already_ need hostapd to know about it?!

johannes

