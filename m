Return-Path: <linux-wireless+bounces-5172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9788A3B1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5DD2E0936
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A5148823;
	Mon, 25 Mar 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YuU/EZbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC241869D3
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360043; cv=none; b=Zz900bV57ouboRHwPrE84KHFa146rrDBBljqYYiuM0zynbAXzfrzc1Eyrca+3abYdJkA4+NV8mOifdthe8bp4Qq0tAQh0t6rq618fNBfdrvljFg+LvzYiPkGAVYnCTLeE4PYAIxMUwPHDZFwZ40REpL7FXFU7BAh/rplZiugZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360043; c=relaxed/simple;
	bh=6pijbRLvBqblq1qEKDSEGAclPOx1WC5er47SvIapkY8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mr6ZfvFqMLZz4BS3iot1TtixNke6ECjHH9SIbkcOioaTYxGDViwxeYwF4zpruPaw2rMuccsrF25uhkxjjnc3qafYngNqk8P+187bMZmVohKY4L38q5WI25czd4lLOiNSeJ6byd9l3HAe4XssIxC9LwLTrKNOXdUxJeasWlH4FyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YuU/EZbM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6pijbRLvBqblq1qEKDSEGAclPOx1WC5er47SvIapkY8=;
	t=1711360040; x=1712569640; b=YuU/EZbMyHTY9Gr2cjSQNcTJCy+flYkc/OA88xc08lMNtNV
	3SDtPUh6qoNBMw48m9OuQNsK7WvkmzRAnRG5X7r0R4cfQRsB1MYR9+0BHk3VlGW+yzxvr2oxbWFAB
	w2nMhs6Ti9GHFMcHEv0oJh7SV168S6d7AI84AF5g+E3D5sFUpKUpcYj6pwXO74zboyn8vaOtxJNU8
	aV/vVMn25DZZgmCW1/jR3v/RFsVYMMYkT8RCnWKGgbI87wPidp4dDuMfKRmZw4WTrfbeUL+5048+g
	UzA/DTRdZNr7bZ/NSI/jq+jWJdmoSDhA5HmCn098p+NkjIeSwyCZlZa4eZ3dUQcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rogv9-0000000Djgl-2Iou;
	Mon, 25 Mar 2024 10:47:11 +0100
Message-ID: <661c532c30e9fa218cf0b3d30da0bb65aafc4e8c.camel@sipsolutions.net>
Subject: Re: Access to ieee80211_conn_settings in the driver?
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Mon, 25 Mar 2024 10:47:10 +0100
In-Reply-To: <1df701f9-3f27-4887-a9ed-60cf2f12beb4@candelatech.com>
References: <1df701f9-3f27-4887-a9ed-60cf2f12beb4@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Ben

> I'm interested in getting access to ieee80211_conn_settings
> struct in drivers.

My first instinct here is to say no. This thing was only introduced
recently, and it was ... difficult ... to do. I don't even want to
imagine I'd have had to worry about a whole bunch of drivers using it
for random purposes as well.

> Specifically, so I can deal with disabling
> 160Mhz in mt76 even if peer is 160Mhz for instance, on a per-station vdev=
 basis.

Not sure how that even makes sense? You have the min_def in the chandef
though, so you could do some bandwidth tricks there for AP side?

> Actually, 160Mhz is bad example, but in case I want to pass other
> association config info into the driver, like disabling as much of
> OFDMA or MU-MIMO as possible.

No idea what that means ... I mean I guess we could add somewhere
(bss_conf?) a flag indicating "things" are needed, e.g. if you're
connecting 160 MHz is it VHT or HE or EHT, to set things accordingly?


> Is this of general interest, and if so, any suggestions for you
> you'd like to see it implemented?

I'd like to _not_ see it implemented :)

johannes

