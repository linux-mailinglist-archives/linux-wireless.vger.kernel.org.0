Return-Path: <linux-wireless+bounces-29548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5FCA8A74
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 18:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1CD2306E5A2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39048329C73;
	Fri,  5 Dec 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bnntAW9Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2F319848;
	Fri,  5 Dec 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956397; cv=none; b=Pdx6Z23P3Z1TZd8G762IhTOdz4Hsqcw5drGPnxhmZ6JOIg9itseYe9eCndLoHxTEOETfv7gR+ghb1ahjBr5hkpkDAUf1K3IdsZdz7e2V68NCCgOVKZvdGh9jS0W1aLyfDm6ICXLaoeUkPeeEeEoQj2k/JXlTPa+pLi8eFha6KWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956397; c=relaxed/simple;
	bh=QCtIBGiJT1n4sNRGWcjEYviKZ7UHnJsKzJ1FQnnRv1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMVmCJcRNIjUBgc2x/nJq+oDuL91INwgq2mSi3rmRv/HgFPKc6IXKR+B/YFyzgiQZgEjJXsUdhUIZeiiY6gGJrbNMMFfZQ1s3HyJf35mt87Xd14hjEKk01zEMiSch7qgsibyaHr1umtwVhMKSuWt1oDt8dRbR3DI8tOJkcFsVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bnntAW9Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QCtIBGiJT1n4sNRGWcjEYviKZ7UHnJsKzJ1FQnnRv1I=;
	t=1764956394; x=1766165994; b=bnntAW9Zd4F7TWDgvFyOg5HtXGfNmwgXsi4Kz8gQB4HtAii
	5Z+TOjJ1U6CdWRctnNtLYCXsk7JI0cEEGosVd3aqWok7F3c/6nQwtKkoHUhflZLb5Lum+DDlam0Vh
	RKqVpjcaZxbB3HxNbjgZYM8yPkP6EAJwb23viiA6/Js7K3ueOHoGsRcpT9ij2/x8QfLnmzyynAcGY
	OIk0YPMQMipx4cGVmHYg7/SEudlLUE0MQ5SRQKj6bpiHo6a1Heucfnu2K1Ss51SgD37mc6NDkJBFh
	qB+iOvFb0NB6QOj/EhLExCKYT470WkCOieWbCkY2O6Z+oqDW9djRsVrdvG/JZmfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vRZmY-000000072LU-1CXC;
	Fri, 05 Dec 2025 18:39:50 +0100
Message-ID: <717b98574a9037a5e81c929f97cc1258e00ee2f7.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: fix divide error in
 mac80211_hwsim_link_info_changed
From: Johannes Berg <johannes@sipsolutions.net>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: Shaul Triebitz <shaul.triebitz@intel.com>,
 linux-wireless@vger.kernel.org, 	linux-kernel@vger.kernel.org, 
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Date: Fri, 05 Dec 2025 18:39:49 +0100
In-Reply-To: <20251205153502.273426-1-dkarn@redhat.com>
References: <20251205153502.273426-1-dkarn@redhat.com>
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

On Fri, 2025-12-05 at 21:05 +0530, Deepakkumar Karn wrote:
> Prevent a division by zero crash when userspace provides a zero beacon
> interval value. The crash occurs in the beacon timer setup code path when
> info->beacon_int is 0, causing bcn_int to be 0 and triggering a divide
> error in the do_div() macro.The issue can be triggered from userspace via
> nl80211/cfg80211 when configuring a virtual interface in AP mode with an
> invalid beacon interval.

Seems like we should not let userspace do that, to protect all other
drivers too, not just hwsim.

johannes

