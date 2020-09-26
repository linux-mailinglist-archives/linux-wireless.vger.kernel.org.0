Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7AF2796FC
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 06:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIZElw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 00:41:52 -0400
Received: from pop31.abv.bg ([194.153.145.221]:59768 "EHLO pop31.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgIZElv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 00:41:51 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop31.abv.bg (Postfix) with ESMTP id 202411805D2F;
        Sat, 26 Sep 2020 07:41:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1601095305; bh=NBoM7xucqGVPhQlPFsVP3VizDYxlBMvz96widjoQicA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=pyi9Lk54zuk1uX6iWYePZ30V28UXFJs3LurZ7/B8YYOMlzNjZHJM5XneC2nJy8CXS
         q2z3rriX8cdeUNmfCi1g9b2mfXTA3GklR+8kRDaai1oY2KsYPssjz5+t9R7/hfPIQ7
         0p9mtcuN1RvBKIz5J1uYv7reHNvy8k9Yhq+A7Mk8=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Sat, 26 Sep 2020 07:41:45 +0300
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <20200922102434.42727-1-nbd@nbd.name>
Date:   Sat, 26 Sep 2020 07:41:42 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        openwrt-devel@lists.openwrt.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD88F09D-5FEA-4A15-B586-95843830F737@abv.bg>
References: <20200922102434.42727-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix!

With your latest suggestion, it takes between 10 and 17 hours for the =
connection to drop, then long five minutes to reconnect.
Notice the order of code execution in the original code of =
ieee80211_sta_tx_notify():
probe_send_count is always cleared when ack is true. But before clearing =
probe_send_count, we need to check if ieee80211_is_any_nullfunc() =
returns true and probe_send_count > 0: if yes, we must call =
ieee80211_queue_work(). You cleared probe_send_count ahead of time, so =
the condition to run ieee80211_queue_work() will never be met.

To spare your time, I did spend one week to find the cause, then another =
learning every detail about the code and testing various solutions, =
including those you proposed. While I do not have experience with =
mac80211=E2=80=99s design, I=E2=80=99m quite good at preserving the =
exact behaviour during large scale refactoring. And in my fix I tried =
changing as little as possible to keep the patch small, preserving both =
your changes and the original design behaviour.

Good luck, and thank you for being a long time supporter of this amazing =
project!

Georgi

> On 2020-09-22, at 1:24 PM, Felix Fietkau <nbd@nbd.name> wrote:
>=20
> When a frame was acked and probe frames were sent, the connection =
monitoring
> needs to be reset, otherwise it will keep probing until the connection =
is
> considered dead, even though frames have been acked in the mean time.
>=20
> Fixes: 9abf4e49830d ("mac80211: optimize station connection monitor")
> Reported-by: Georgi Valkov <gvalkov@abv.bg>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> v2: reset connection monitor when a frame was acked (not just for =
nulldata)
>=20
> net/mac80211/status.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index 7fe5bececfd9..cc870d1f7db6 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -1120,6 +1120,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw =
*hw,
> 	noack_success =3D !!(info->flags & =
IEEE80211_TX_STAT_NOACK_TRANSMITTED);
>=20
> 	if (pubsta) {
> +		struct ieee80211_sub_if_data *sdata =3D sta->sdata;
> +
> 		if (!acked && !noack_success)
> 			sta->status_stats.retry_failed++;
> 		sta->status_stats.retry_count +=3D retry_count;
> @@ -1134,6 +1136,13 @@ void ieee80211_tx_status_ext(struct =
ieee80211_hw *hw,
> 				/* Track when last packet was ACKed */
> 				sta->status_stats.last_pkt_time =3D =
jiffies;
>=20
> +				/* Reset connection monitor */
> +				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
> +				    =
unlikely(sdata->u.mgd.probe_send_count > 0)) {
> +					sdata->u.mgd.probe_send_count =3D =
0;
> +					ieee80211_queue_work(&local->hw, =
&sdata->work);
> +				}
> +
> 				if (info->status.is_valid_ack_signal) {
> 					=
sta->status_stats.last_ack_signal =3D
> 							 =
(s8)info->status.ack_signal;
> --=20
> 2.28.0
>=20
>=20

