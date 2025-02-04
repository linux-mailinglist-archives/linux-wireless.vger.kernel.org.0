Return-Path: <linux-wireless+bounces-18415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC3A270BA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC87A179A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 11:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1020B80B;
	Tue,  4 Feb 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ttYfBePD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA620B1EC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670212; cv=none; b=JVrB5ctnLAyz/05+bL9Mo9XW2zJoNCG+SmEvmjZaUtqKbpgVUqKk8InMvw7xuZZ/zTJO48TNKyGeZtWZ3rqMjzgYgszJKWYqseqkkBq0Yju80IXCEOUxiHxEGOji5hggSn2BOKMAnsxwcD7buDrieFqllmMbvFvwSY0pLe9X0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670212; c=relaxed/simple;
	bh=abq0YvL7CVg5XRLkWCvA+QrcbOLTvYL6Zr6enxFAsrg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R710xdcn46PLahuARNTppou0ORvhv06j6TYFRmpg56mdcM3WoBD7B+qGOdFtTkHRTfD2DfkfpVX/fZ2elDl+q4PC/8t22fF0WXwGNZ9n2aufvUDED66QxU71hU1X2t27bgOU5/Hg3bFggKOFhv1yRw7c4g6UbACwRYz+Z7cvzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ttYfBePD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=abq0YvL7CVg5XRLkWCvA+QrcbOLTvYL6Zr6enxFAsrg=;
	t=1738670210; x=1739879810; b=ttYfBePDnhgzzfYcalg85AeNQcFNh0o0YNXi9d3HaCmLXGn
	3GUHDgY8fF9bGoh27RsllijbMZspNxOcwEw7ZjwRItL/fERpWkGPFuZWWN3gEF/wl1vr+Cipb0NhJ
	26mSm2pcjZbrKfFvIet2AQfhXYN0NvcqyE0nFx3a79/xlITDlwGXb12eBRbrrJphQ86hL+wApTAaM
	cUAy7o1Mnn1BxdlrjoIoWWzt1JR9gbjmw1EzTT+6s5Bs5x4T8gUm9tIwB+dYr08KdH+DyyM+DwV8y
	xfesHPvAmyiksNOIAzK53nT0WloWuu+emuHAt/68Az7QgJ01j5p/PhhLDUPdeK/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfHXl-00000002eYI-1pIz;
	Tue, 04 Feb 2025 12:56:41 +0100
Message-ID: <f29465a633e7eba09f80548ee728930cfbb4baac.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: nl80211/cfg80211: Stop supporting cooked
 monitor
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Tue, 04 Feb 2025 12:56:40 +0100
In-Reply-To: <20250204111352.7004-1-Alexander@wetzel-home.de>
References: <20250204111352.7004-1-Alexander@wetzel-home.de>
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

On Tue, 2025-02-04 at 12:13 +0100, Alexander Wetzel wrote:
>=20
> But adding a feature flag for that outdated feature, assign it to all
> drivers without knowing if they really support that any longer seems to
> be a no-go. And adding an opt-out feature for something we plan to
> remove also feels off.

I don't think there's any driver that supports this in the first place.
Most, if not all, non-mac80211 drivers supporting AP mode have AP SME in
firmware anyway.

johannes

