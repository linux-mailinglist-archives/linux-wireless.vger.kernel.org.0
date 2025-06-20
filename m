Return-Path: <linux-wireless+bounces-24285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF1FAE19C2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577035A6B3F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7EA289E21;
	Fri, 20 Jun 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kQ/V+ajN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66D28A3FC;
	Fri, 20 Jun 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417998; cv=none; b=tviRB4fIgcx3Wcj7Pl//BYffdCia0Dnb2umpdbVYxivCGFzODh80J97jQm1ieL1Op0Gnacyx87wMno3Ww1TSD+6MnmhmzUYb1EzH93y1mexjlxSf2GAYWiPc6qiYWFqiQpZFDFd/VKJVFvelUs85pfiv5/th9v+CMkxrNuEAFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417998; c=relaxed/simple;
	bh=bXefAwmW9Eb5Uk11ip/sPq3qLjW7ZFuVSWtxu3qOQzc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmBC+awa0nAr0l+Vq51YrV+s16DNP6jMbg5YeSDoElJb9YocRD2Suvbb5aCAZVWet/oOB2MEKLZTgYatmZ/VANrPTiP+n/d2eoXHihMtC4QIOWm2zAygamf4J7IycdFTbVWXEpuy+fCp9bpa0o323TMK14aU0obqEVXV2ZjTviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kQ/V+ajN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KxYyaOsKHFnnmAIRCwOjfSx9XxN7zIV+mBa0tllY+BQ=;
	t=1750417996; x=1751627596; b=kQ/V+ajNmq+YQiOwe0sfR1tw19e7aQU0+DdEvbysHdBUvm7
	lVJZGN+VBtVvdHzG3dVguqKhzIrXLJ2S1+LpPwRNQLdfMw9w/J1X3LJKv/at84fCEAjLCVil5sceU
	kQlkjsoK2xRSQHBCv9A4cWFfcaIXEURl7nl7HamySlt+rAHS7T4Ehm24NMvJPNm7X4102wL3ixFNf
	FK3FfzV7IAS8cjwXjzzn1hCpqVvqyCbvFH93/lGBvl7Qk2x1ZicisKv3PXHWqrVAfWy3s+QCpYtTi
	wpgWmyq6Oa4IDH03tLfI7uMVMmjNMw7QIgsFLN7z8QRlreMCHy8VH2dGxTetzS5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uSZgF-00000002faT-2TrM;
	Fri, 20 Jun 2025 13:13:11 +0200
Message-ID: <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no
 AP is associated
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Date: Fri, 20 Jun 2025 13:13:09 +0200
In-Reply-To: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
References: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-20 at 11:20 +0800, Zhongqiu Han wrote:
>=20
> - Rebased on top of current next.
> - Update the v2 code implementation:
>   - Remove zero-initialization of frame_buf

You could keep that I guess, but we shouldn't claim it's any relation
with fixing the bug. Just as a cleanliness thing maybe?

>   - Remove WARN_ON and early return in ieee80211_report_disconnect()
>   - Change the return type of ieee80211_set_disassoc(). If
>     ieee80211_report_disconnect() uses the frame_buf initialized by
>     ieee80211_set_disassoc(), its invocation is now conditional based
>     on the return value of ieee80211_set_disassoc().=20

I don't understand this change ... surely syzbot couldn't have run into
an uninitialized buffer after the WARN_ON since it has panic_on_warn. So
why all these changes:

> -static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
> +/*
> + * Note that if ieee80211_report_disconnect() relies on the *frame_buf
> + * initialized by this function, then it must only be called if this fun=
ction
> + * returns true; otherwise, it may use an uninitialized buffer.
> + */
> +static bool ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>  				   u16 stype, u16 reason, bool tx,
>  				   u8 *frame_buf)
>  {
> @@ -3935,13 +3940,13 @@ static void ieee80211_set_disassoc(struct ieee802=
11_sub_if_data *sdata,
>  	lockdep_assert_wiphy(local->hw.wiphy);
> =20
>  	if (WARN_ON(!ap_sta))
> -		return;
> +		return false;
> =20
>  	if (WARN_ON_ONCE(tx && !frame_buf))
> -		return;
> +		return false;
> =20
>  	if (WARN_ON(!ifmgd->associated))
> -		return;
> +		return false;
> =20
>  	ieee80211_stop_poll(sdata);
> =20
> @@ -4168,6 +4173,8 @@ static void ieee80211_set_disassoc(struct ieee80211=
_sub_if_data *sdata,
> =20
>  	memset(ifmgd->userspace_selectors, 0,
>  	       sizeof(ifmgd->userspace_selectors));
> +
> +	return true;
>  }

here to have a return value? It's only false when you had a WARN_ON()
which means there's a bug elsewhere?

>  static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata=
)
> @@ -4448,6 +4455,7 @@ static void __ieee80211_disconnect(struct ieee80211=
_sub_if_data *sdata)
>  	struct ieee80211_local *local =3D sdata->local;
>  	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
>  	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
> +	bool report_disconnect;
> =20
>  	lockdep_assert_wiphy(local->hw.wiphy);
> =20
> @@ -4477,20 +4485,22 @@ static void __ieee80211_disconnect(struct ieee802=
11_sub_if_data *sdata)
>  		}
>  	}
> =20
> -	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
> -			       ifmgd->driver_disconnect ?
> -					WLAN_REASON_DEAUTH_LEAVING :
> -					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
> -			       true, frame_buf);
> +	report_disconnect =3D ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEA=
UTH,
> +						   ifmgd->driver_disconnect ?
> +						   WLAN_REASON_DEAUTH_LEAVING :
> +						   WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
> +						   true, frame_buf);
>  	/* the other links will be destroyed */
>  	sdata->vif.bss_conf.csa_active =3D false;
>  	sdata->deflink.u.mgd.csa.waiting_bcn =3D false;
>  	sdata->deflink.u.mgd.csa.blocked_tx =3D false;
>  	ieee80211_vif_unblock_queues_csa(sdata);
> =20
> -	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
> -				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
> -				    ifmgd->reconnect);
> +	if (report_disconnect)
> +		ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf),
> +					    true, WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
> +					    ifmgd->reconnect);
> +
>  	ifmgd->reconnect =3D false;

So all of that also doesn't really do anything.

But then the rest of the patch also doesn't seem to do anything, so what
am I missing?

Does the bug even still exist? Looking at the code now, I feel like
ccbaf782390d ("wifi: mac80211: rework the Tx of the deauth in
ieee80211_set_disassoc()") probably fixed this issue?

johannes

