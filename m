Return-Path: <linux-wireless+bounces-10450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF2939F9E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E811B1C21EF6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0E14E2C4;
	Tue, 23 Jul 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vluGaZ4n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0D14A4DA
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733565; cv=none; b=GFk3zrcWAlB8wptIKTVxpy+mxIsE2R1vB7zOLN4JYive5poklQJyQko83tkPLmstAnZgollyMgauvEkuLbCnG7UNRybIE8rhkS/Um10z0MQwgybqzRJace6RucTZfolkRgCWr+IaM51LySAdGSlg4uv1E3f9AOlq0PSq1a1WnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733565; c=relaxed/simple;
	bh=iTBtepYI2jUy+wcoP4xjOMDzjElG7GkoBhk+Ztup4x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nilB+/HmIY9vohpCwhxuWAIRp7kmYwnR0d3SGsxTpKZukLgpSJz8ya8WDGk8S36A2wjrs/xuaSszYJnaTpMPbspThHYVP3fx4zlePheRyBCgUR4JLUR8mhdOk8zt5MOTajf8swMWv2UPgmFt8AMlciRO2IsrkF69UhkVk3kfujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vluGaZ4n; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3e24:0:640:e968:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 9BCC560EF1;
	Tue, 23 Jul 2024 14:19:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EJMs9t67Y8c0-UjZ0iDjW;
	Tue, 23 Jul 2024 14:19:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721733556; bh=B9PheC2i5tSLHVDyR2MFTgbHG3KgpxpkWmE0KKve8H4=;
	h=In-Reply-To:To:From:Cc:Date:References:Subject:Message-ID;
	b=vluGaZ4n+scym4ASd7SyGrvJDc5226d6OhpJ5uwwRpDEy2fAHCSksnOomyoNppbfx
	 y2BRhGqTXOjLdnISawTULaLgwU/LEcxlwa9e4Qt1PKU7p22YVdzLmnepOGro7TFdZH
	 gHB+EMBSXf00+FDSgJYZZdM/ejbpEQT82TelfUJw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e545816b-22ae-4837-9597-86483ad37374@yandex.ru>
Date: Tue, 23 Jul 2024 14:19:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Managing debugfs entries and
 https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
To: "Berg, Benjamin" <benjamin.berg@intel.com>,
 "Berg, Johannes" <johannes.berg@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <1ff58acb-4171-46ff-8a33-821600a8d8e4@yandex.ru>
 <2e57365ad4b0a5e63bf1d54ff776d57d08d462b0.camel@intel.com>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
In-Reply-To: <2e57365ad4b0a5e63bf1d54ff776d57d08d462b0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 12:38 PM, Berg, Benjamin wrote:

> So, the simple way to prevent this error is to make sure that
> ieee80211_debugfs_recreate_netdev is never called while we have a
> station. In the case of this report we seem to be getting there via a
> mac address change (i.e. ieee80211_change_mac) and the sane thing would
> be to just return -EBUSY instead of permitting the operation to
> continue.

Just to check whether I understand this:

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..d5adbe5b3e51 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1173,6 +1173,8 @@ struct ieee80211_sub_if_data {

  	u16 restart_active_links;

+	u32 sta_count;
+
  #ifdef CONFIG_MAC80211_DEBUGFS
  	struct {
  		struct dentry *subdir_stations;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b4ad66af3af3..d8e6e411d754 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -215,6 +215,9 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
  	if (netif_carrier_ok(sdata->dev))
  		return -EBUSY;

+	if (sdata->sta_count)
+		return -EBUSY;
+
  	/* First check no ROC work is happening on this iface */
  	list_for_each_entry(roc, &local->roc_list, list) {
  		if (roc->sdata != sdata)
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..42657afb6d22 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -443,6 +443,7 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
  #endif

  	sta_info_free_link(&sta->deflink);
+	sta->sdata->sta_count--;
  	kfree(sta);
  }

@@ -691,6 +692,7 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
  	sta->cparams.ce_threshold_mask = 0;

  	sta_dbg(sdata, "Allocated STA %pM\n", sta->sta.addr);
+	sdata->sta_count++;

  	return sta;

Dmitry


