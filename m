Return-Path: <linux-wireless+bounces-15925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361449E5625
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA22E18857D3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D0218E99;
	Thu,  5 Dec 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MNLk/03x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A8217725;
	Thu,  5 Dec 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403629; cv=none; b=CZMC77mHG9q7Td90Kv6PaiNWYsGCNKwS/B5xZ1xmQ4T567P8uw20OaYZi8KjzvSQ0I57GkYurDSzdmrmrtZAZTsiCiJMVKYimXKCz0m5kESniwAV2lUi/7+fJuTl5GgoIZJSxYaH8nnGyFR+afi2eAEJHWyN0I370x4h5L28HXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403629; c=relaxed/simple;
	bh=or95HAQ/MJEZQzO5GHrb+zYtt7NQX+MZZfZkhYMzDyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lniUcfbKafkDsgRY1xiEzEa0xEW/y/1xvi875eNURKjaB0OaGVlWJggOdPjLufgByI26vUfLeZornUqSuo6JeVYp3bIjT67krxBEF+wueCT5T/BSZ+hMx1TWQAwMWp7t1RgVGh+BOq9oHvtG0b52Ww6dMlxR1xht/8tNqhvt5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MNLk/03x; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=or95HAQ/MJEZQzO5GHrb+zYtt7NQX+MZZfZkhYMzDyU=;
	t=1733403628; x=1734613228; b=MNLk/03x+H1512ZmVRLmFMwbmf5tJ2YCQSasC3/dYxIonFN
	QkQjbI/DhmDu7fcjJW4ncACHx35fVQ4fEBhj9G1kBa/JWUj7WLHrxx+Nr+HPzWNsCD27adc6/ju1H
	3zeFQ+Ii4gvbPjJo/WVg22r/rCk/2KRD0weIYAgWDMrA7E93xXk4Zn9d6xGHMsmBkV+RaGyLt4qLe
	oLmXBL3WJHpmBrv7tbFw7toeG3w3NgQ0fBId60vTrCaTdKipnEk4jKUK77iT7nCf7t8XseGgIIoio
	2JVuf/Zj6GwPnw5at2EqaHjQMcVatHvvd+M7JPcz+UHGdUZotWCwHStiozZr0B8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJBSx-0000000B8ss-1Pvh;
	Thu, 05 Dec 2024 14:00:23 +0100
Message-ID: <d421f8067ea54bcfc38a9b021ebda13515145c45.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: re-order unassigning channel in
 activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Dec 2024 14:00:22 +0100
In-Reply-To: <d0acd2178504d76770e9267ef6e7f5c04b50eab3.camel@sipsolutions.net>
References: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
	 <d0acd2178504d76770e9267ef6e7f5c04b50eab3.camel@sipsolutions.net>
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

On Thu, 2024-12-05 at 12:43 +0100, Johannes Berg wrote:
> >=20
> > Therefore, re-order the logic so that stations are handled first and th=
en
> > channel is unassigned.
> >=20
>=20
> This causes memory leaks in my tests with iwlwifi.
>=20

And also firmware crashes because the station is removed while it's
still being used.

johannes

