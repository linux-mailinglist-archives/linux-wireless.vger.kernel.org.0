Return-Path: <linux-wireless+bounces-21916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A0A98C78
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203E83AACDC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764627933B;
	Wed, 23 Apr 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mywv7ElR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521527978B;
	Wed, 23 Apr 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417469; cv=none; b=HUJeSDLrCgQciC8tTr1iewPUnUIKmy6mpgraxaiWLdUIXRN0ww0iq1iEWbJTrR8WMYJwy2sSm+5W3ZVdOP8n1BcB6wvu1JwefbcxOsOCGIDwIEwMPMWLbWYl15qTkbmZy4D3byP1n+iI4+RzOgH9N0OcSkGQ6bvoYaxh3FHALHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417469; c=relaxed/simple;
	bh=DxgRAbIstATXW5M23FxiIrvYPtzKeVPBO3qAfWnhSSI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rq2lVrmYCWEeoQnX38YhFLzI5mvkOM3k6BXVDGTF4cwURbFIhhKKQbLeGNckszqlG1/h4f11YC7dCHMNm1JAtERO5P/6NFrwEOULa/bjyUAPXqyedU+1e0cgVQNMPE4eKKm0KMeyMMGKp3zl+TmxFCKgeDgtenF6P4OtAgoqh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mywv7ElR; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1745417459; bh=bJPgo03Pl/DvgZ9aMjbqY7ZBGwNtvORokcAeOraILmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mywv7ElRKE1uYgX3AB7VVBccI7i+1QpwwjiL/EFQF4OluxFTCa+m93lKn18ZgWq9H
	 Jl+CtGCy3Nzyr+vi6lGFeDshHOGynwHBrXh292tCWCyrrgbjUdBeyDalWc0YJu3Tfn
	 CBinsXug6655mo7NaR59VQ45ksVKjz3etQGVbhJs=
Received: from pek-lxu-l1.wrs.com ([114.244.56.254])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 2B89AE20; Wed, 23 Apr 2025 22:10:56 +0800
X-QQ-mid: xmsmtpt1745417456txxpvuiwg
Message-ID: <tencent_FEF364E367496283BA444AD771577226CA05@qq.com>
X-QQ-XMAILINFO: OblCMDpF8T+NsMQO+UkCWvfSgewBhoCO7FVPHJAW+tCV8p82N/a8iWcEciuqoP
	 QNckbJhTyot7F9vE50bFqrft9MmlYirVxYjiCl+2dtZaG25DSpgO7iisXh1Oj+ba6XrqN0VtLNyQ
	 ERs0SqlMS+D1euKDZltgZ32EueKPW/90NVujVCDyVW39uRw9GyE89LOjNSjnL++IRjMv7QygSu37
	 brxtp1qno+szkXd0fjdDthyXkHhWlC3TlGoZFpuGy7DXel7I/ve5LQsrVrZ87Q624mfqHg0ggRx0
	 IfFrzS1Hr8D+CNAwzE8zeH/0d1U/WiVqFSXBLwgLGB7hfMWI+1Q7A2P/goCVnOdkl5pKNg3P3bdC
	 WRfeZXRRO18tICDRspyUEAYZkXiF+pv4dBk0WldKNckT8CG0MlKE7N/vEltnX1WL8aANN+YNrJ/i
	 OIJvMOCXzBu25IcLViZR+AEgPQlfJLf3EJvD9JssfZts5aSc3dT9FiTTuhJBIIdHFvJV7vLsd759
	 tgpuqw93Iz7DrBbKFBIkRlNMa0mtrrkf3qfCM6PmuZJfVjhWrxk51o4U46LIKzDVgiFea9rxdMdz
	 HyfXgVLGEA5kKEmgJvW2kZOjXcObpiLBUx3kby+qNa4NnUbjlyjh5pFb+OdU9u/m6qr44K2O4M5X
	 o3OsyHlT7VyEEES9Cu9WWhVwIa9x3sI0wU1OuUIDXXnde6M2pfXaZ7CskFlrQp2NwoDOLUVGl/JE
	 J/CTN/dNMJBSHaJn0kCpqQEF3YFqTpoltrRn8Vjri1tkh/05ERuJCQgx2UFBlw8aDyOZk1q961H0
	 MVjQ/yISrSungjhYEAAWukkViM6SVzTc4LMQ1LMk6TVZE11BKusMpAScU7Jz0C7Fmc8bXn16473k
	 RxA/ALzXc3PJsj6MbyXKwZ1sR0PEnG86TSQSq6cKsSDWsXZBudruXUo/Yrgre/jKafqG6A2HGi/e
	 IHDJrue+ACKXq6iHpkJU0KFqqMrOHh8hx5Lgcq+tZ/L2d+8gleU/NU01ojx/QGLunNEqrcIyB+WT
	 4GEFdTWg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: johannes@sipsolutions.net
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Wed, 23 Apr 2025 22:10:57 +0800
X-OQ-MSGID: <20250423141056.2594990-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <ff63580712b8f20b4be7b38a31bc3bb9d69a4820.camel@sipsolutions.net>
References: <ff63580712b8f20b4be7b38a31bc3bb9d69a4820.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Apr 2025 16:04:04 +0200, Johannes Berg wrote:
> On Wed, 2025-04-23 at 21:56 +0800, Edward Adam Davis wrote:
> > On Wed, 23 Apr 2025 14:53:53 +0200, Johannes Berg wrote:
> > > > --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> > > > +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> > > > @@ -1226,6 +1226,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
> > > >  {
> > > >  	struct mac80211_hwsim_data *data = hw->priv;
> > > >  	u64 now = mac80211_hwsim_get_tsf(hw, vif);
> > > > +	struct ieee80211_bss_conf *conf = link_conf_dereference_protected(vif,
> > > > +			data->link_data[0].link_id);
> > > > +
> > > > +	if (conf && !conf->enable_beacon)
> > > > +		return;
> > > >  	/* MLD not supported here */
> > > >  	u32 bcn_int = data->link_data[0].beacon_int;
> > > >  	u64 delta = abs(tsf - now);
> > >
> > > Please keep kernel coding style - the line break there is awful (but
> > > with "conf = ..." on a line by itself it can be just one line), and you
> > > shouldn't have code before variable declarations.
> > like this?
> 
> Looks good I guess, not sure you wanted bcn_int/delta to be calculated
> before or after.
It will be all right.
I will send V2 patch.
> 
> > > The comment should probably also move because it's relevant for your new
> > > [0] as well.
> > I don't understand what you mean.
> 
> The "/* MLD not supported here */" comment refers to the [0] - it
> explains why the [0] (rather than link id) is OK. So it also applies to
> your [0], if you're going to put it before the comment then IMHO it
> makes sense to move the comment. With what you did now the comment is
> still earlier though, of course.
Oh, Got it.

Edward


