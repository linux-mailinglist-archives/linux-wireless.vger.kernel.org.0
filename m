Return-Path: <linux-wireless+bounces-10360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E892E935120
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575BBB209C6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8A71442FF;
	Thu, 18 Jul 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qr2ir7aB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03213DBA2
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322714; cv=none; b=VfIdvO8eLN5eZIqbP+LW9mzh3TBJxrpM2bWeWWB8tq6NQjxJ53HBlwN1W0R/86BroweGubu+HYacMpMHT2DlxtxgmbM4xiunY93J1VKdtKqUpI1xcUPDTsYMV5PP3/qjpl1fsvkxlDU9GloCeQm/pc0rh2yqL4J279FMLRVJgaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322714; c=relaxed/simple;
	bh=3zfbbS37MUFj474xYhH7+D46b0Ivdu1rXer2nFpzq00=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Kwq59qi4nssyq1pbZVoscYrm+Jxs3rCHinXU698Al/PG9YECnk4YI0L4SnI+t8M31ANkIIrGVzBieX10N9uSohsRSpIXmj3XzwyKtjOtQID78NIXcgjJ5PokmZpOHUVIFWemMuTA6tfWtC6bA2i34Tt+OIf5t6ZtK0K94je+z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qr2ir7aB; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id E90B8672C8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:03:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:63d4:0:640:3833:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 7806460A99;
	Thu, 18 Jul 2024 20:03:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id h3NNKh1o6Cg0-jKlntQHo;
	Thu, 18 Jul 2024 20:03:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721322225; bh=ik1leWECDtVRpfb12IUUdKQ5I/5erigduxzW7uacuMY=;
	h=Subject:To:From:Cc:Date:Message-ID;
	b=qr2ir7aBIF/IZLl4YkEgAFggHCrwMBETQTXHRFWao2WbaH4gGMqHBo+ejEhiZ8zfz
	 IWWzBO8G43k8iai1uQNOlzXBfTOoXj0GkdVOBfaoCdU4kkWPuHZMdxpb+I77qp390c
	 xT9bK0WW+178L+XpzNs9Er47Cr7nh5RmoUnXuuBQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <1ff58acb-4171-46ff-8a33-821600a8d8e4@yandex.ru>
Date: Thu, 18 Jul 2024 20:03:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Berg <johannes.berg@intel.com>,
 Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Subject: Managing debugfs entries and
 https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following quirk looks like a (briefly tested with CONFIG_KMEMLEAK)
fix for https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774:

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1e9389c49a57..8224257e5d93 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1284,7 +1284,9 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)

  void ieee80211_sta_debugfs_remove(struct sta_info *sta)
  {
-       debugfs_remove_recursive(sta->debugfs_dir);
+       if (!sta->debugfs_shared)
+               debugfs_remove_recursive(sta->debugfs_dir);
+       sta->debugfs_shared = false;
         sta->debugfs_dir = NULL;
  }

@@ -1319,6 +1321,7 @@ void ieee80211_link_sta_debugfs_add(struct link_sta_info *link_sta)
                         return;

                 link_sta->debugfs_dir = link_sta->sta->debugfs_dir;
+               link_sta->sta->debugfs_shared = true;
         }

         DEBUGFS_ADD(ht_capa);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9195d5a2de0a..d76ba36ca794 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -708,6 +708,7 @@ struct sta_info {

  #ifdef CONFIG_MAC80211_DEBUGFS
         struct dentry *debugfs_dir;
+       bool debugfs_shared;
  #endif

         struct codel_params cparams;

So what about managing debugfs entries wih krefs? E.g.:

diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9195d5a2de0a..1f4561533530 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -466,6 +466,15 @@ struct ieee80211_fragment_cache {
  	unsigned int next;
  };

+#ifdef CONFIG_MAC80211_DEBUGFS
+
+struct sta_debugfs_entry {
+	struct dentry *debugfs_dir;
+	struct kref kref;
+};
+
+#endif /* CONFIG_MAC80211_DEBUGFS */
+
  /*
   * The bandwidth threshold below which the per-station CoDel parameters will be
   * scaled to be more lenient (to prevent starvation of slow stations). This
@@ -563,7 +572,7 @@ struct link_sta_info {
  	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;

  #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct sta_debugfs_entry *debugfs_entry;
  #endif

  	struct ieee80211_link_sta *pub;
@@ -707,7 +716,7 @@ struct sta_info {
  	struct sta_ampdu_mlme ampdu_mlme;

  #ifdef CONFIG_MAC80211_DEBUGFS
-	struct dentry *debugfs_dir;
+	struct sta_debugfs_entry *debugfs_entry;
  #endif

  	struct codel_params cparams;

Dmitry

