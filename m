Return-Path: <linux-wireless+bounces-8595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5200E8FDECB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B26282AC8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6719D8A1;
	Thu,  6 Jun 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="CXXAS1/P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A5101CE
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655778; cv=none; b=hgd2IFCFiAvS6LjWvT0Kuf8QG0aAcHglcociTGgfOUwFzj0Lr3aAV+eI5eBjtCEYJGYTl8wRu5MkYKEdVnkXSTbFL3tiEiBXNLOUAP9eDm/F13378/RftjXMBUG2UQYb4IIFdRr9wTTGi+barIDVD2DGuTWswyRT5R0zTmKhQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655778; c=relaxed/simple;
	bh=QniNBHFBjNpHW42p4169P4nSYU7cMib/5vAn4Yx6I94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iv+7GG+U89jP6D48qN7dTKkrJBAdxSMTvZR1ji4kdHmKknVkHf/piZwTcQECd83pxxmTJYNXwZz7Vebz/mZzKm2x1CiEulLA926X1XmOdeh0E5Uv8QH5nBqfZT/kP+xh/ICnu7HifmfLgBeC/1cxrBZUcTI+Y/r+p/W+k+7ujrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=CXXAS1/P; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1717655252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uvawg7ksAXn3cGtmIHO5GFc/WnmihS0YDy3kfH+pyHQ=;
	b=CXXAS1/PcWSb0T7qSWZ0CtRqIfEfLVtS7lSU6FKRW4XZ87pv0rZbXcV607aBxwJwq+huwT
	V9N5MxtsddzrCScf/hw9rdszuhdy06kHpTqIomPkDpNrF89YmPdx4sW7CC8JXds0gfcVnL
	7ufvdI3ZGEbLdyepSY0bNvkM0/JTxhg=
From: Sven Eckelmann <sven@narfation.org>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>
Cc: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org,
 johannes@sipsolutions.net
Subject: mac80211: scan ignores next_delay calculation after first probe
Date: Thu, 06 Jun 2024 08:27:30 +0200
Message-ID: <2540184.6tgchFWduM@ripper>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2441207.8hzESeGDPO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2441207.8hzESeGDPO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>
Date: Thu, 06 Jun 2024 08:27:30 +0200
Message-ID: <2540184.6tgchFWduM@ripper>
MIME-Version: 1.0

Hi,

I was debugging some problems when trying to scan for BSS (and they were often 
not recorded on channel 1) and noticed some potential problems with some code 
changes by you. Not necesserily the changes itself but the parts which look a 
little bit like they were missed.

With your commit d60277ac3fc9 ("wifi: mac80211: apply duration for SW scan"), 
I can now set the duration in SW scans (thank you). But __ieee80211_start_scan 
just overwrites the calculated next delay of ieee80211_scan_state_send_probe. 
So for the first channel, the duration still seems to be wrong.

In the past, the version from Ben Greear just overwrote the value 
IEEE80211_CHANNEL_TIME (from ieee80211_scan_state_send_probe) with the value 
IEEE80211_CHANNEL_TIME in __ieee80211_start_scan. This slightly odd behavior 
was introduced in 8a690674e060 ("mac80211: Support on-channel scan option."). 
And even when it didn't made a lot of sense to me - it didn't change the 
behavior. But now it seems to be counter productive. Maybe you can check this 
again and maybe Ben Greear still remembers why this there in the first place.

The discussion is about this part (which overwrites the correct value for 
next_delay):

static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
				  struct cfg80211_scan_request *req)
{
[snip]
	if (hw_scan) {
		__set_bit(SCAN_HW_SCANNING, &local->scanning);
	} else if ((req->n_channels == 1) &&
		   (req->channels[0] == local->hw.conf.chandef.chan)) {
[snip]

		if ((req->channels[0]->flags & (IEEE80211_CHAN_NO_IR |
						IEEE80211_CHAN_RADAR)) ||
		    !req->n_ssids) {
			next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
			if (req->n_ssids)
				set_bit(SCAN_BEACON_WAIT, &local->scanning);
		} else {
			ieee80211_scan_state_send_probe(local, &next_delay);
			next_delay = IEEE80211_CHANNEL_TIME;
		}
[snip]
}


And here is the code in for ieee80211_scan_state_send_probe which always sets 
next_delay to the correct value:

static void ieee80211_scan_state_send_probe(struct ieee80211_local *local,
					    unsigned long *next_delay)
{
[snip]
	/*
	 * After sending probe requests, wait for probe responses
	 * on the channel.
	 */
	*next_delay = msecs_to_jiffies(scan_req->duration) >
		      IEEE80211_PROBE_DELAY + IEEE80211_CHANNEL_TIME ?
		      msecs_to_jiffies(scan_req->duration) - IEEE80211_PROBE_DELAY :
		      IEEE80211_CHANNEL_TIME;
	local->next_scan_state = SCAN_DECISION;
}



And maybe you have also noticed that your patch missed the calculation for the 
passive scan in __ieee80211_start_scan. It always sets it to 
IEEE80211_PASSIVE_CHANNEL_TIME. But I would have guessed that the calculation 
should also be 

next_delay = msecs_to_jiffies(scan_req->duration) > IEEE80211_PASSIVE_CHANNEL_TIME ?
	  msecs_to_jiffies(scan_req->duration) :
	  IEEE80211_PASSIVE_CHANNEL_TIME;


Another part which seem to have been missed by your patch is the 
scan_state_decision helper code in ieee80211_scan_get_channel_time. It looks 
to me like it could now under-estimate the scan time because it doesn't handle 
the duration information.


Kind regards,
	Sven
--nextPart2441207.8hzESeGDPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZmFW0gAKCRBND3cr0xT1
yw42AQCiogEOf9A9V5Xws/TlY9axvhn88UVZAOQU94K/90x5QgEAqJQ7G0TdHZYH
SVw+KbvZY+wXJ+NjS4REuZOE3AON5Qs=
=RMCq
-----END PGP SIGNATURE-----

--nextPart2441207.8hzESeGDPO--




