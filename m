Return-Path: <linux-wireless+bounces-28149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CADBF6CE2
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248173B8E6F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25C2F39D0;
	Tue, 21 Oct 2025 13:35:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318B337B9A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053706; cv=none; b=FD0yLGLsN0Qkz/NQ6cjMEOuRgDDoWNgtNPs2e1RKFzdvt2kg7vMBGla/GmoVOFrkF5MzxZB0xXq/wXiWdJqvpiNav9CoJvWtlQVh7bMynijm6uTD63I2Si8mmOMKMKBlVP/3MaWS5HehQ6B2wSvuz5B3oy6CS8R6pbI4jYCny8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053706; c=relaxed/simple;
	bh=CdBLYukLBkEcnCz9jaYTg3QKqBsok32FkD3P7I1/STs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL1zECJSGV1T1hwmUungLJ3atPr33VhXT5iDf0TSte0h00rSkoGj1EWDCQOEz6x6ZwgMqtizbf+prjGlzwQeix2J4AFSpHQtdGwnmG/O0EiEaVE0AY/7maM+j2RUjst6Th+0kuvPU0+7U3SZJkdNAsxU9no0NuGQmTvj9zWzvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mathieu.digital; spf=fail smtp.mailfrom=mathieu.digital; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mathieu.digital
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mathieu.digital
X-Pm-Submission-Id: 4crYCx38m7z2Sfc1
Date: Tue, 21 Oct 2025 15:33:48 +0200
From: Mathieu Chouquet-Stringer <me@mathieu.digital>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE
 operation in association response
Message-ID: <aPeLvMiYF42HNDrR@nosurprises>
References: <20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
 <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>
 <aPd48eufR6OY45__@nosurprises>
 <8350f937fcab78249f840bf835f744c0b953124e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8350f937fcab78249f840bf835f744c0b953124e.camel@sipsolutions.net>

On Tue, Oct 21, 2025 at 02:19:36PM +0200, Johannes Berg wrote:
> Recently, the test result was about a week ago, but I don't know when
> the people testing it got it from Aruba. I'd imagine they would've
> gotten a pre-release version to test with, but I don't know them, or the
> Aruba folks involved, so it's mostly conjecture ...

Fair enough and yes it would make sense. I guess I will be on the
lookout for the new version.

Thanks for getting back to me.

Cheers,
Mathieu

