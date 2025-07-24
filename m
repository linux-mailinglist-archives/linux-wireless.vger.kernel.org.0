Return-Path: <linux-wireless+bounces-25978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E606B10183
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8205450C4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39089126BF7;
	Thu, 24 Jul 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wFE065wq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA110E0;
	Thu, 24 Jul 2025 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341516; cv=none; b=RafPs7U+GBZ+4IRTyFZ2VbtR5wsrUi+spCOZPkmxj3o3eJ2o+jpKUAUM/S3vyMRCsAUyncDGZ/14cIDllv8fXTVVmAdsExv36Lm9+Qc7hXTLq/RVrcWlXhyxZMCUOIplMwScFWUJNnl4uebNy86L4Ro1f0p1TUVtG5cg2NYMzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341516; c=relaxed/simple;
	bh=h+tSN5uweuXDdcPyXRUXp5Ssm21YUoWCMOFTFzX139M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qs0qP/Ty1DmN4OXjDETwFHWfzB0tIB7jpgsImaYWSLd4xuGgD1MBrDepHGeQshmGsEyTShmDyZWf7afDrbQiKuYfy/zZhntikJceZSsUd4GfFuSzzHXrSbaHJ2LsLF0dTh9a3AS3Fu/aB+AuRpW1rPU8evgP9jxpyXauslEvnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wFE065wq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h+tSN5uweuXDdcPyXRUXp5Ssm21YUoWCMOFTFzX139M=;
	t=1753341514; x=1754551114; b=wFE065wqtpMXUagtAOZk1CmK7/ZlJVGN/Cuh0qgqJl15JZq
	8Qy7VL2dORrUSEBBkYoCNyPPEffRgEAeYgArOAQnSXjdHBty72PzPDyV0IYOk68YUjctS8hgFiewP
	W2AdfpkQAdHlSRfDzE1Eg5ta0b5fqh9Gij7N/4Utm/RuqnwRxIJdMNGdLG+CkzkYot2nDBqCR3qMG
	SFn2l6VM0Ulal5F7bT4HwnhBb7sAQHP9H8HHrxYXisBP0RUgAoBMosPL93V/tpK13pPI2vuqBO2ZH
	d4BHnRi9s5aihhIpjW6CMh6WTVSqaB28hDlt5L7DjmWGccuXKzRBysqE/j2gq/hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueqDY-00000005Cty-2MSS;
	Thu, 24 Jul 2025 09:18:18 +0200
Message-ID: <b81013d8f7cccb19ab126aebc7bc442c641d0f4a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix use-after-free risk
 in sta debugfs removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Date: Thu, 24 Jul 2025 09:18:07 +0200
In-Reply-To: <20250724071555.442634-2-moonhee.lee.ca@gmail.com> (sfid-20250724_091629_457606_AC325110)
References: <20250724071555.442634-2-moonhee.lee.ca@gmail.com>
	 (sfid-20250724_091629_457606_AC325110)
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

On Thu, 2025-07-24 at 00:15 -0700, Moon Hee Lee wrote:
> A NULL pointer dereference may occur in ieee80211_sta_debugfs_remove()
> when debugfs_remove_recursive() is called on a dentry whose inode has
> already been freed. This can happen due to a race between STA teardown
> and debugfs cleanup.
>=20
> Fix this by checking that both sta->debugfs_dir and its d_inode are
> valid before invoking debugfs_remove_recursive().
>=20
> This avoids the crash reported in syzbot bug:

Maybe so, but it really looks like a bandaid?! Why are we trying to
remove it twice in the first place?

johannes

