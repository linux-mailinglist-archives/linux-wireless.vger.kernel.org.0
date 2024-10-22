Return-Path: <linux-wireless+bounces-14323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FB9AA31E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604B61F24669
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36E1537D9;
	Tue, 22 Oct 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hq20jLTD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C8199FC1
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603754; cv=none; b=PKCELFxxl17U/y4+kso59k8ZT/0e7yEV67nLG4vl8Ybx5AzWXHv5UqKyhgbaH9+qnKiR0kMBKc65/j1Pjv9YHOLFlo+r1xdN5VfXsj7fx5Svh3zChdqw1g3882VoIVrECjWLvfLiaBp5qtRLHUZ/XOe9unA8hnipuKvXwH9EgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603754; c=relaxed/simple;
	bh=zWtObovD9c1HYqiE/NV+2jVm6gv2qyvrQVQGFDV2DfQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCt7LnQ++FXsZdmKzxiu3pFTBr1S13WZ+6lDHTvsU6iZyeDmRcMDG/Cy/n0Vd04IvBwNib5L2Sgn7f6Uhau6/MmrUh+v3TgeGW4U7DoGhNMpKrDkXBc6ABsHs016unQ27zohN6N3LTTXEGlQtfRTEz+dOVC08ZTmBmF4xQfCY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hq20jLTD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0piA9ZJgNvD+34z6X7Id8wtJdye2wLVnTedIySbTwkM=;
	t=1729603752; x=1730813352; b=Hq20jLTDeCS6xP0YUw6DDUU+IwGa5t7IFHxsd5o5NPPsxYV
	jZlKycUo+JlcBVY9qGDoYuimnxTo45VAjetJXZp40knh2mkRvdT1TpqnDgwhP81iq803FvY84Q5m3
	l7XNif+gn3eBgKwWFCuvw/umXTyfpNgXpTJxvt6FkP5/h4q1Zc7ZQwUq9lZzVNXAv4siEAVT/D9g0
	N8c/vSwF3kmEMisUEwxq250Dug7oxx2ziyawtYBVL23a/Zms0mKtDjOAHiEBABVeUhrS3jACnfLvB
	T1irHRZ4d0K9fec6L8MbDHK3UXLaSVqO+PUqaMGovkYR1QkkEi7EO36Zwpmuj7zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3Ewg-00000001kdD-1ffS;
	Tue, 22 Oct 2024 15:29:10 +0200
Message-ID: <404d0ef8b9a5e70dcab331a5ee73155313464d06.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211:  Remove NOP call to ieee80211_hw_config
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Date: Tue, 22 Oct 2024 15:29:09 +0200
In-Reply-To: <20241010204036.1219896-1-greearb@candelatech.com>
References: <20241010204036.1219896-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-10 at 13:40 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> If changed is '0', then the ieee80211_hw_config takes no
> action, so just remove the call in
> __ieee809211_recalc_txpower()

Hmm. I think it may have done something in the past, so perhaps this is
a bug that needs to be fixed instead?

-       if (!local->use_chanctx)
-               changed |=3D ieee80211_hw_conf_chan(local);

in "wifi: mac80211: simplify non-chanctx drivers".

But maybe that's exactly the previous patch? Would be nice though to
have that in the commit message, or if it's related maybe even squash
them?

johannes

