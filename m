Return-Path: <linux-wireless+bounces-2263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F1832E08
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D220B22689
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662752F84;
	Fri, 19 Jan 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qDu8JHas"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA66D5644A
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684799; cv=none; b=nJW5uNaS20dhDIGHhkoMxV1rZBTGWC5tYODS7QPA3pQYc7XEZlbSslvtsihK1X56aXkKHhSdU2PvTjtv7/xC1mlVIC64Tl2OfyIt/NdAoeE2Dw2MkY/sqImbgE4nVxp9dD6UVQupK2E8O1SajArfuzMRW8PolqiirEZjxH1Tq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684799; c=relaxed/simple;
	bh=5kjuuZZAgbh5qG1AhU6Ww91wS6SIXnE7H7WRcAlw2uw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxoht5L1IaTbKY+XVzzDhBbxBOWldD4XJ2V98wCj3VjWhk0zmU/+uJFNBA1oxUgLkPx+BoE2k5sWeVTwlS+/ucJicQZi1Mf2tG0HsCH8rk4lvAb1SGNCNygkQaGEuSaoPMbUoVbqRtkB1UWgu9/zv3dMxoSxkAMQl98VqZVUJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qDu8JHas; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bDdP51rF0wsqIyog0a3Uo+oqh39UFupDUGditTXtf5E=;
	t=1705684797; x=1706894397; b=qDu8JHass7fglUsONx1oY5/+MRAWNMh3O2LOVFwgiuqiqQ8
	5ap7pmMXZWSlk0QccoA4naB/8h3yUso3hsasVn54blRPcUjw9DK2RVUiE0hBgbNxUSQXuI41JbBz1
	SvQdN5AYUP2TA2VYcUru6oSWCtOtx7WCXxCUQ5+zs8oH69dlAUAlHJv22aZLH5fkwVvujgKAvAolD
	5/dBv4/J0dpo/y3PF2ZjvNb/bQpAmpjo20nHIOJv4k9o/gIAi5EGtD2sFDPP7ndoJ9wcSjMkxxvnZ
	Y/Ke53tH6jkUsZ12vQ3aimd2UV7UKC6xu8XRNelZrp2evwg/7tzzCpb035Zt1DJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQsX4-00000009fMD-1hMt;
	Fri, 19 Jan 2024 18:19:54 +0100
Message-ID: <58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: don't ask rate control with zero rate
 mask if scanning
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Date: Fri, 19 Jan 2024 18:19:53 +0100
In-Reply-To: <b938cafa-0cb0-4832-9883-c6c47e93fa2b@yandex.ru>
References: <20240117124848.120438-1-dmantipov@yandex.ru>
	 <9433d29b643e4cce3a9354282405288c75c45e02.camel@sipsolutions.net>
	 <b938cafa-0cb0-4832-9883-c6c47e93fa2b@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-19 at 11:07 +0300, Dmitry Antipov wrote:
> Hm. It seems that I'm still missing something important, but I don't
> realize why ieee80211_scan_state_set_channel() advances to the (next)
> channel even after ieee80211_set_bitrate_mask() resets this channel's
> rate mask to 0. Note that the comment in ieee80211_set_bitrate_mask()
> explicitly states that there should be at least one usable rate for
> the band we're currently operating on. Why this is not applicable to
> other band(s) we might probe next?

I guess it depends on the definition of 'operating'? Scanning isn't
really 'operating' in this context, I'd argue.

>=20
> > The most common use case for this is probably P2P-style things where yo=
u
> > just don't want to use CCK, but for scanning we have
> > NL80211_ATTR_TX_NO_CCK_RATE for this, so there's really no need to appl=
y
> > the rate mask?
>=20
> Does NL80211_ATTR_TX_NO_CCK_RATE makes an effect on bands other than
> 2.4GHz?=C2=A0

No.

> Note original reproducer triggers WARN_ONCE() after switching
> to 5GHz.

Sure, that's unrelated. I'm guessing the reproducer sets up a (limited)
rate set only for 2.4 GHz and that's OK because that's where it's
connected, or so, but then (software) scanning interferes.

My reason for mentioning was just that NL80211_ATTR_TX_NO_CCK_RATE is
meant to aid restricting rates while scanning, so I'm saying that we
should probably not even _use_ the bitrate mask for scanning at all.

I was trying to let you come up with a patch for learning, but I think
at this point just making one illustrates better what I'm thinking ...
Here's one, but I haven't even compiled this:

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -932,6 +932,8 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly intern=
ally
  *	for sequence number assignment
+ * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
+ *	due to scanning, not in normal operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -952,6 +954,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		=3D BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		=3D BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	=3D BIT(9),
+	IEEE80211_TX_CTRL_SCAN_TX		=3D BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		=3D 0xf0000000,
 };
=20
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -632,6 +632,8 @@ static void ieee80211_send_scan_probe_req(struct ieee80=
211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |=3D tx_flags;
+		IEEE80211_SKB_CB(skb)->control.flags |=3D
+			IEEE80211_TX_CTRL_SCAN_TX;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -701,7 +701,9 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.bss_conf =3D &tx->sdata->vif.bss_conf;
 	txrc.skb =3D tx->skb;
 	txrc.reported_rate.idx =3D -1;
-	txrc.rate_idx_mask =3D tx->sdata->rc_rateidx_mask[info->band];
+
+	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+		txrc.rate_idx_mask =3D tx->sdata->rc_rateidx_mask[info->band];
=20
 	if (tx->sdata->rc_has_mcs_mask[info->band])
 		txrc.rate_idx_mcs_mask =3D


What do you think?

johannes

