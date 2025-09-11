Return-Path: <linux-wireless+bounces-27247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E158B539D2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 19:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4200BAA054D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002521019C;
	Thu, 11 Sep 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kfrV26PX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114D31D757;
	Thu, 11 Sep 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610104; cv=none; b=ow+5p5OunhxaGK5sCP/wijcCOAWCrby3XFE2wImQys04J//mLZh3tzu78JlX66W39xieTJyC5+grrSnOv2PefHuZEgnyMjDl2k9JJGexMzjU2pcPbzAxbv9nEk8najFLDlZJ22F58m4/y1x6vMntqcX0xG4KhwslF1AXGt0KHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610104; c=relaxed/simple;
	bh=nwoalD03XPDUyFyFgtYtWKIblQ9hGe8r6/ATfDBnpA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7H8M4bYUYU62syHdpa4Wawi6QXRbPcXTi6E7esmuNevkrms81mYGL5/NweoySJWDx5OFKNLmntO6mfESIJ5LKSO5urF5V7vH65Rc2uUf1Z2F4SH/z/1w4fKlJL3kzKiudtkFUcSEVJsEI3eMD5nZt2CVMG7KHP6v3+lR6kgGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kfrV26PX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nwoalD03XPDUyFyFgtYtWKIblQ9hGe8r6/ATfDBnpA0=;
	t=1757610103; x=1758819703; b=kfrV26PXgRMFq/XEXrfMDd+G1rNofugoIGN3/29zWTls/KY
	ZycTsW4zMUkj29se27A0x70CW9gFgPMbatXuc+TdASiFWN0M5ngTHzgjERAMOG53tZ9yPVTJevGXI
	mVt+O+vXkKHyebybf2MtoFuLIPMjJdRbED52aiqAWZ1qWo7KhOyOWfrCQy2EcCWH/cwf+agwWr9vD
	2Wi8a2BKjGcAVmrQfMxgPg9V06y6OPbhggxZCdsA8oQxvj/tsfINWwnrLVTaDCqLiRGjpOnGsNAsU
	sSl0GhF9ulpruCEs2hzGLZ2IIMK3WjIvFfCIvnmRs8GiIiN0iZOS2l02Ljr6+YIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwkfz-0000000Fcoj-3pOR;
	Thu, 11 Sep 2025 19:01:40 +0200
Message-ID: <2da9103af3f341f05bc8c42e4425ec15231498e5.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-next-2025-09-11
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 11 Sep 2025 19:01:39 +0200
In-Reply-To: <20250911100854.20445-3-johannes@sipsolutions.net>
References: <20250911100854.20445-3-johannes@sipsolutions.net>
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

On Thu, 2025-09-11 at 12:08 +0200, Johannes Berg wrote:
> Please pull and let us know if there's any problem.

Speaking of problems ... we've kept adding Link: tags. If you're going
to insist we remove them then please just say so explicitly, reject this
pull request as well if you like, and save everyone the discussion.

I do truly believe Linus to be wrong on this: assuming a patch has no
need for any identification/correlation whatsoever before it goes into
his (or a feeder) tree (and gets a stable sha1) is akin to assuming it
has no life before it actually ends up there, which I think is
completely out of touch with reality. But he does ultimately get to
reject pull requests, so...

Maybe I should make the links go to patchwork, because there you have
the CI results ... maybe that could be construed as useful information
in the "Linus sense" (phrased that way because to me the mailing list
posting is already useful information)?

johannes

