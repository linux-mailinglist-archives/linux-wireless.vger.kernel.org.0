Return-Path: <linux-wireless+bounces-21130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A345A7A539
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 16:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEB23B0ACA
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFD73477;
	Thu,  3 Apr 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ltrpYDUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317824C065
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690678; cv=none; b=XIC5dCelWstsvK2y862NI+fxtWG0yi+iaB9WlHyOk6W/6BDOLPB1v3b+UUWW8E3bHmKxnUNlEMN1BVlGndmFb+5KwJtVwVQwhLISWZ85KnihYo4bhiMoL4CGKolTMIcBrN8mLHW2/OPFaSYx12zka7DaQDlSUNwLrEoLB4Uqhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690678; c=relaxed/simple;
	bh=juU09XRZGtr1ZctkPgC60Ox8QRq5Egf6r9KxFXQcV88=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ERG/eSzuf107UJB80fpkuVARX+Jgq2svPX4volF2XaqJgzWjBIOpOaCP7so7zJ8Fgv85kJq6bocMOxGWK5SasTJIe8ZaSuJE+NLU+CtMeDRlfe4nQTmf3IhU0B3+lnwaMffHO3YJ+drB68gXknJCDfnsHkhhQHRXX/yVqs+Kvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ltrpYDUl; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id BE6AE6564E
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 17:25:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2db2:0:640:9334:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 8F77B60912;
	Thu,  3 Apr 2025 17:25:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8PZj0mWLiiE0-TiwHkezu;
	Thu, 03 Apr 2025 17:25:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1743690310; bh=KIqAOhEVaZT8a7RbioIpBOOjV5LIul5vyDk/+uf1HTY=;
	h=Subject:To:From:Cc:Date:Message-ID;
	b=ltrpYDUlLZ6O/dX8zB8ymJKK5609Ig2D4UXTdDkPRVT22Hi35Z2tbh/4AluItXMR7
	 KlaSBLJZr0NDSEC7REtUKrnSejTfR54QdlVOKMyne0g+Ksw3xCfOuZZ9lKtp+4eyBS
	 34JFb3L5N1SF667sjxs86QkOnZ8gGl6yGqBT217g=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <95a01ec8-4f2e-4cc0-a107-cb40257f100e@yandex.ru>
Date: Thu, 3 Apr 2025 17:25:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: On 021d53a3d87e ("wifi: mac80211: fix NULL dereference at band check
 in starting tx ba session")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Looking at 021d53a3d87e ("wifi: mac80211: fix NULL dereference at band check in starting tx ba
session"), can the following be useful for older (e.g. 5.10) kernels without any MLO support?

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 4b4ab1961068..1a89ba2aecaa 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -595,7 +595,8 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
  		return -EINVAL;

  	if (!pubsta->ht_cap.ht_supported &&
-	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
+	    !pubsta->vht_cap.vht_supported &&
+	    !pubsta->he_cap.has_he)
  		return -EINVAL;

  	if (WARN_ON_ONCE(!local->ops->ampdu_action))

Dmitry


