Return-Path: <linux-wireless+bounces-21915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7050A98C71
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6E3A6F59
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9182797B5;
	Wed, 23 Apr 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gNXTJKt3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCC57C9F;
	Wed, 23 Apr 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417409; cv=none; b=FCGwfyl59RGQDCUE4pKhdQcTOcK8CZC8t14c9l3GCQQZMJU4JoEXFZNMspYJJJ3c+lh/sIehPW3938blBV1KEikUydk4RkmPK1+ogvikDJlQGCgBUW0yFOsWgRkeifO8vEP1e4F3kSvNeOrlMuV9cbuR1TuH7LQJYL6xgGa+0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417409; c=relaxed/simple;
	bh=iZpLPsAvgSMBjrHhxikN+TSu0jTyN7YS9vhcVs2bazY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t0aBtuOJLLoxZrAO0DKnTO/05SkA8LjbYxVvVgjGkhZ1l6viYaMgg7eFgD6Rbx9mXoQcyG+B+0XqYhpssZzLj2TgWHYtKNK1tyE6GTt33+Z1S/vSg087rq/hNLnBRP4tXHlKFjOgcfDo9DeEPB8b5Vl6vYgApCENY+tgBtvGHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gNXTJKt3; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1745417394; bh=EN8djXH6u15uw3zsP9JyNi6Ci3Uky8jkG+tsGmC/tOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNXTJKt3g/twl9f2Yso6TQzFlvpYG4nxoCUBz5980Fyi3Ae3U63jxgEyPVR+zZNgI
	 XXhCnbgMr4b4VpROjc+oV8x/YrIvvq7ADmyjaHe8gaAYTCNlxMxuP3vYd4KQKisq1Q
	 15wgVYrBYlzJpz3fP9khkme5GNyz/QXQcBVEQ/gA=
Received: from pek-lxu-l1.wrs.com ([114.244.56.254])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E199C461; Wed, 23 Apr 2025 21:56:25 +0800
X-QQ-mid: xmsmtpt1745416585tbycjup16
Message-ID: <tencent_6FF36BC379E97AE3ADC450776CD77EA6C405@qq.com>
X-QQ-XMAILINFO: Nq1uWKlIb9DMOHggUw40dwN+cyJXz8MUAD6YAZlLo0vJwwhe/IiWaFgTy+ZecP
	 Wyubuip1zTvtK79CPW0pAlKYUFl1CcfB2KlAmxgkSbE89acjNqXMVJS/0ZqkTcjAFaPO6yYdxzcZ
	 De8/XePJpTkODZBof2P6UI7S+pSrV0z+64wCJpEySVt1EyOFeAMR0i1y0ZfLAto9QJYVMVomBsi4
	 lkpwmuDZM5PUYCA+mhBEPk8/OXLKjuFIobVevQ7sOXPFqldpo3wCUg9PxfKPHkxfWk1IFLdPS+Vq
	 b/BqOZMpwSilZ/U7BrM0+fahzLGWLqNz4FrFAww60oNEHZFdFnrrR+/xYpdqIWdqH9AGfG6iCKEG
	 ZXnx1GSgLyqR4rM7L7jWUSuOkTvVfx3qBMUcA3FUOyalxOxa9HC5U/mKImyxLrIOJggppAkmgjiW
	 aTe4JMvW/O+CG7L1tgp/rr1L/KZGKLAwj85z7mhLlZznvRCJSVu+TyDV74zxtG4IvrH9LjKkUDs3
	 6i1+qLVO95CzbVQl59iWmdkjFuEajOQWiLEw/cyBS8dv5r8JvV+5K4vOzV2XEJZKg47ufRRVIQKP
	 jkEmJhfNubNvtpjkMm9Ruvbs8UthI60iXDFzLcEXRtw5CM8Fo7JpK8lz5jYI0MuScR/nEQnIt3W8
	 fjQHVQdgr48DGAGuSNiTNH9OEf0OCYB/ZoGzqtJtWcBfIWXbwbCs8/VXgj+UB2qpACDw5QjgieuJ
	 aVwpGOFYFeU00BHcmJVyfAYBeiTWqSI145Mr9qjwU8RrF48fuGs8XYrsUCVDEl2McqMNDmLPApRJ
	 LvkKCmdF+RZrUmHDuIq40z+8IP0zhjJKBUjP5yhf13gY6tR1oaofMGSJddDvoVZnNfJFGF2NZLNU
	 /f+T/WLi0T6TYlNlxZoMF+8RYMdh1hqXbTZ2mLw92ZLaMarNZUyDoJq6fJKYeYiUk3vGosFnbx4/
	 URq1QAQgM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: johannes@sipsolutions.net
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Wed, 23 Apr 2025 21:56:26 +0800
X-OQ-MSGID: <20250423135625.2581425-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b30cc04676a031db8c36df243160992094b3848d.camel@sipsolutions.net>
References: <b30cc04676a031db8c36df243160992094b3848d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Apr 2025 14:53:53 +0200, Johannes Berg wrote:
> > --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> > +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> > @@ -1226,6 +1226,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
> >  {
> >  	struct mac80211_hwsim_data *data = hw->priv;
> >  	u64 now = mac80211_hwsim_get_tsf(hw, vif);
> > +	struct ieee80211_bss_conf *conf = link_conf_dereference_protected(vif,
> > +			data->link_data[0].link_id);
> > +
> > +	if (conf && !conf->enable_beacon)
> > +		return;
> >  	/* MLD not supported here */
> >  	u32 bcn_int = data->link_data[0].beacon_int;
> >  	u64 delta = abs(tsf - now);
> 
> Please keep kernel coding style - the line break there is awful (but
> with "conf = ..." on a line by itself it can be just one line), and you
> shouldn't have code before variable declarations.
like this?
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf3e976471c6..6ca5d9d0fe53 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1229,6 +1229,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
        /* MLD not supported here */
        u32 bcn_int = data->link_data[0].beacon_int;
        u64 delta = abs(tsf - now);
+       struct ieee80211_bss_conf *conf;
+
+       conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
+       if (conf && !conf->enable_beacon)
+               return;

        /* adjust after beaconing with new timestamp at old TBTT */
        if (tsf > now) {

> 
> The comment should probably also move because it's relevant for your new
> [0] as well.
I don't understand what you mean.

Edward


