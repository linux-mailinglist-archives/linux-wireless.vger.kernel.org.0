Return-Path: <linux-wireless+bounces-17307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4AA08BE2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16211690A8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050720C485;
	Fri, 10 Jan 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b1uruFfy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C720ADCE
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500965; cv=none; b=P34Ere3x2GKFceqWdbrPCC6xKU6W6VMk0g13VP8m8+FfoowTMmtj18nNT0uBZGmtbqys3DNVqJkhudooZ6jEjiqZU2L/Uwh3Khjcbvh3p6SRxY6T8ys4u97j6vrdCEgbAe1DdQ90hxljvC6iSJwiiVxKo+RdthZY2iVAbvrnVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500965; c=relaxed/simple;
	bh=Oj0Pyv/7KCJl9be35y2SZKulyC08NhSOjRQrbyrmiTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijqA0r6SZBh/IxWVXttp6It1QnrpXbjkbaLjrbmn5U0TtgQqXWevxL34ZRdjXwAYkDtlOr/u35YhzsGefTK8OlHIz3qv8tXim1/7nGhb1N5MJyjVAnzp8VsXsNIG+Ng5hSsu9aU4a/ZdTmXsETNIsg+I2LbpuyhlUHGSmH17a5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b1uruFfy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Oj0Pyv/7KCJl9be35y2SZKulyC08NhSOjRQrbyrmiTA=;
	t=1736500964; x=1737710564; b=b1uruFfyUpWxMITNpGoCSU6LgR3v8dtiPrxEScmsKnO7uJG
	zjcpq6zNnTLHGk5DPaWIVqiTeNCQPFLJCtfGh4y9s/+6ABnXQluVnsa2RNFRUmtNIrW2WVr+I79Bg
	QFjwxYy5vpXhmcG1P07CcLivSRIvOsDFYV7QhQmwjp4nErFB0B/qwOkbXA3wnAyK9Js7bIJg/7726
	NI2ONJe7ioTx2u6RZLaOKMLWnuQ5go9JkLPNfDaWbw7TTfL6MklXzEaQeLrsLI9pcbMdApl2tykb2
	jlU9jQc+d6KUUCp6ZQDjMdQBZKzeKTvkskl+S4RgujjGd6c8VyxH2aamhonqt51A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWBE1-0000000ASoD-0lj3;
	Fri, 10 Jan 2025 10:22:41 +0100
Message-ID: <18f299f82fd440f4067fcda1e1bc48e831ed7768.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 5/7] wifi: mac80211: add support to accumulate
 removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Jan 2025 10:22:40 +0100
In-Reply-To: <20250110042449.1158789-6-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
	 <20250110042449.1158789-6-quic_sarishar@quicinc.com>
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

On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
> Currently, if a link gets removed in between for a station then
> directly accumulated data will fall down to sum of other active links.
> This will bring inconsistency in station dump statistics.
>=20

What if a link is removed and then re-added? Should it go back to that
link? That would require keeping statistics per link rather than
accumulating removed.

johannes

