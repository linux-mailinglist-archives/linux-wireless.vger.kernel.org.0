Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4B27A19C
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgI0PLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 11:11:09 -0400
Received: from pop32.abv.bg ([194.153.145.222]:52502 "EHLO pop32.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgI0PLI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 11:11:08 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop32.abv.bg (Postfix) with ESMTP id E43941FC58;
        Sun, 27 Sep 2020 18:11:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1601219461; bh=g906jOoz4kTs7iGyNm/JYeJwGXlZIQ6y3pgUgs6zf8U=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=JuFT5JV1QuibmGwaKg8rT0NwqGqsHZPVQOWtH90tKpONKiojKlbDn1fUDdtZlORfi
         NqMv2LRrAzqJ9ETh+TLiBO7EWwE+t4UZXlAv/IWWmbAAICxDCRgX5phDRlJcaKMrwa
         sLtsSpyWYCy4GfAQJDngiQY4+/8TQ4bEBAVnFOTQ=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted); Sun, 27 Sep 2020 18:11:01 +0300
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <20200927105605.97954-1-nbd@nbd.name>
Date:   Sun, 27 Sep 2020 18:10:59 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <4ED2AADF-092B-424E-A5B5-C2A371C88A92@abv.bg>
References: <20200927105605.97954-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix!

Here are some interesting tracing results based on v2. My tracing code =
is below.
The only printed output comes from this line, so it looks like the other =
places were I added tracing were never executed.
[11428.907823] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11459.636346] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11490.367121] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11523.141354] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11555.917399] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11586.644909] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11617.375977] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11650.147750] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11682.923378] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11713.649688] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11744.376130] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[11777.150797] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0

I just started testing v3, and so far it looks like this, but we need to =
wait and see if there will be any disconnect events:
I wonder why we experience an increase in probe_send_count every 130 =
seconds?
[  105.489078] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  136.204809] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  166.924520] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  199.690445] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  230.401303] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  261.110496] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  293.869304] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  324.580664] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  355.291914] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  386.002786] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  418.762544] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  449.473091] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  480.186644] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  512.941192] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[  545.700283] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  576.409210] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  607.119928] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  639.877866] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  670.588159] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[  701.298701] wifi: --- ack  probe_send_count: 1  vif.type 2:2


// patch.v2 + tracing
Index: backports-5.8-1/net/mac80211/status.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- backports-5.8-1.orig/net/mac80211/status.c
+++ backports-5.8-1/net/mac80211/status.c
@@ -1129,6 +1129,8 @@ void ieee80211_tx_status_ext(struct ieee
 	noack_success =3D !!(info->flags & =
IEEE80211_TX_STAT_NOACK_TRANSMITTED);
=20
 	if (pubsta) {
+		struct ieee80211_sub_if_data *sdata =3D sta->sdata;
+
 		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count +=3D retry_count;
@@ -1143,6 +1145,31 @@ void ieee80211_tx_status_ext(struct ieee
 				/* Track when last packet was ACKed */
 				sta->status_stats.last_pkt_time =3D =
jiffies;
=20
+				/* Reset connection monitor */
+				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
+				    =
unlikely(sdata->u.mgd.probe_send_count > 0)) {
+					struct ieee80211_hdr * hdr =3D =
(struct ieee80211_hdr *)sdata;
+
+					sdata_info(
+						sdata,
+						"reset connection =
monitor  probe_send_count: %u  nullfunc: %u\n",
+						=
sdata->u.mgd.probe_send_count,
+						=
ieee80211_is_any_nullfunc(hdr->frame_control)
+					);
+
+					sdata->u.mgd.probe_send_count =3D =
0;
+					ieee80211_queue_work(&local->hw, =
&sdata->work);
+				}
+
+				if (sdata->u.mgd.probe_send_count > 0)
+				{
+					sdata_info(
+						sdata,
+						"!!!  probe_send_count: =
%u\n",
+						=
sdata->u.mgd.probe_send_count
+					);
+				}
+
 				if (info->status.is_valid_ack_signal) {
 					=
sta->status_stats.last_ack_signal =3D
 							 =
(s8)info->status.ack_signal;
Index: backports-5.8-1/net/mac80211/mlme.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- backports-5.8-1.orig/net/mac80211/mlme.c
+++ backports-5.8-1/net/mac80211/mlme.c
@@ -2505,13 +2505,46 @@ void ieee80211_sta_tx_notify(struct ieee
 	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);
=20
 	if (!ieee80211_is_any_nullfunc(hdr->frame_control) ||
-	    !sdata->u.mgd.probe_send_count)
+		!sdata->u.mgd.probe_send_count)
+	{
+		if (ack && sdata->u.mgd.probe_send_count)
+		{
+			sdata_info(
+				sdata,
+				"+++ ack  probe_send_count: %u  =
nullfunc_failed %u  vif.type %u:%u\n",
+				sdata->u.mgd.probe_send_count,
+				sdata->u.mgd.nullfunc_failed,
+				sdata->vif.type,
+				NL80211_IFTYPE_STATION
+			);
+		}
+
 		return;
+	}
=20
 	if (ack)
+	{
+		sdata_info(
+			sdata,
+			"--- ack  probe_send_count: %u  vif.type =
%u:%u\n",
+			sdata->u.mgd.probe_send_count,
+			sdata->vif.type,
+			NL80211_IFTYPE_STATION
+		);
 		sdata->u.mgd.probe_send_count =3D 0;
+	}
 	else
+	{
+		sdata_info(
+			sdata,
+			"probe_send_count: %u  vif.type %u:%u\n",
+			sdata->u.mgd.probe_send_count,
+			sdata->vif.type,
+			NL80211_IFTYPE_STATION
+		);
 		sdata->u.mgd.nullfunc_failed =3D true;
+	}
+
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 }
=20


// 333-trace.patch for v3
Index: backports-5.8-1/net/mac80211/mlme.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- backports-5.8-1.orig/net/mac80211/mlme.c
+++ backports-5.8-1/net/mac80211/mlme.c
@@ -2505,13 +2505,46 @@ void ieee80211_sta_tx_notify(struct ieee
 	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);
=20
 	if (!ieee80211_is_any_nullfunc(hdr->frame_control) ||
-	    !sdata->u.mgd.probe_send_count)
+		!sdata->u.mgd.probe_send_count)
+	{
+		if (ack && sdata->u.mgd.probe_send_count)
+		{
+			sdata_info(
+				sdata,
+				"+++ ack  probe_send_count: %u  =
nullfunc_failed %u  vif.type %u:%u\n",
+				sdata->u.mgd.probe_send_count,
+				sdata->u.mgd.nullfunc_failed,
+				sdata->vif.type,
+				NL80211_IFTYPE_STATION
+			);
+		}
+
 		return;
+	}
=20
 	if (ack)
+	{
+		sdata_info(
+			sdata,
+			"--- ack  probe_send_count: %u  vif.type =
%u:%u\n",
+			sdata->u.mgd.probe_send_count,
+			sdata->vif.type,
+			NL80211_IFTYPE_STATION
+		);
 		sdata->u.mgd.probe_send_count =3D 0;
+	}
 	else
+	{
+		sdata_info(
+			sdata,
+			"probe_send_count: %u  vif.type %u:%u\n",
+			sdata->u.mgd.probe_send_count,
+			sdata->vif.type,
+			NL80211_IFTYPE_STATION
+		);
 		sdata->u.mgd.nullfunc_failed =3D true;
+	}
+
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 }
=20
Index: backports-5.8-1/net/mac80211/status.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- backports-5.8-1.orig/net/mac80211/status.c
+++ backports-5.8-1/net/mac80211/status.c
@@ -1148,8 +1148,28 @@ void ieee80211_tx_status_ext(struct ieee
=20
 				/* Reset connection monitor */
 				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
-				    =
unlikely(sdata->u.mgd.probe_send_count > 0))
+					=
unlikely(sdata->u.mgd.probe_send_count > 0))
+				{
+					struct ieee80211_hdr * hdr =3D =
(struct ieee80211_hdr *)sdata;
+
+					sdata_info(
+						sdata,
+						"reset connection =
monitor  probe_send_count: %u  nullfunc: %u\n",
+						=
sdata->u.mgd.probe_send_count,
+						=
ieee80211_is_any_nullfunc(hdr->frame_control)
+					);
+
 					sdata->u.mgd.probe_send_count =3D =
0;
+				}
+
+				if (sdata->u.mgd.probe_send_count > 0)
+				{
+					sdata_info(
+						sdata,
+						"!!!  probe_send_count: =
%u\n",
+						=
sdata->u.mgd.probe_send_count
+					);
+				}
=20
 				if (info->status.is_valid_ack_signal) {
 					=
sta->status_stats.last_ack_signal =3D



> On 2020-09-27, at 1:56 PM, Felix Fietkau <nbd@nbd.name> wrote:
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
> v3: only queue work on nullfunc frames status
> v2: reset connection monitor when a frame was acked (not just for =
nulldata)
>=20
> net/mac80211/mlme.c   |  4 +++-
> net/mac80211/status.c | 16 ++++++++++++----
> 2 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 50a9b9025725..7c04d8e30482 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -2508,7 +2508,9 @@ void ieee80211_sta_tx_notify(struct =
ieee80211_sub_if_data *sdata,
> 	    !sdata->u.mgd.probe_send_count)
> 		return;
>=20
> -	if (!ack)
> +	if (ack)
> +		sdata->u.mgd.probe_send_count =3D 0;
> +	else
> 		sdata->u.mgd.nullfunc_failed =3D true;
> 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
> }
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index 7fe5bececfd9..88a736f3c413 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -982,10 +982,6 @@ static void __ieee80211_tx_status(struct =
ieee80211_hw *hw,
> 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
> 			ieee80211_frame_acked(sta, skb);
>=20
> -		if ((sta->sdata->vif.type =3D=3D NL80211_IFTYPE_STATION) =
&&
> -		    ieee80211_hw_check(&local->hw, =
REPORTS_TX_ACK_STATUS))
> -			ieee80211_sta_tx_notify(sta->sdata, (void *) =
skb->data,
> -						acked, =
info->status.tx_time);
> 	}
>=20
> 	/* SNMP counters
> @@ -1120,11 +1116,18 @@ void ieee80211_tx_status_ext(struct =
ieee80211_hw *hw,
> 	noack_success =3D !!(info->flags & =
IEEE80211_TX_STAT_NOACK_TRANSMITTED);
>=20
> 	if (pubsta) {
> +		struct ieee80211_sub_if_data *sdata =3D sta->sdata;
> +
> 		if (!acked && !noack_success)
> 			sta->status_stats.retry_failed++;
> 		sta->status_stats.retry_count +=3D retry_count;
>=20
> 		if (ieee80211_hw_check(&local->hw, =
REPORTS_TX_ACK_STATUS)) {
> +			if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
> +			    skb && !(info->flags & =
IEEE80211_TX_CTL_HW_80211_ENCAP))
> +				ieee80211_sta_tx_notify(sdata, (void *) =
skb->data,
> +							acked, =
info->status.tx_time);
> +
> 			if (acked) {
> 				sta->status_stats.last_ack =3D jiffies;
>=20
> @@ -1134,6 +1137,11 @@ void ieee80211_tx_status_ext(struct =
ieee80211_hw *hw,
> 				/* Track when last packet was ACKed */
> 				sta->status_stats.last_pkt_time =3D =
jiffies;
>=20
> +				/* Reset connection monitor */
> +				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
> +				    =
unlikely(sdata->u.mgd.probe_send_count > 0))
> +					sdata->u.mgd.probe_send_count =3D =
0;
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

