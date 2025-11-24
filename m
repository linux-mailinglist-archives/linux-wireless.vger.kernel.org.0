Return-Path: <linux-wireless+bounces-29281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D2C7FAB2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 10:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0BD64E3900
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33640298CDE;
	Mon, 24 Nov 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n2DGW8F7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B562F5A2E
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977088; cv=none; b=CreltabVcYgRc5h0AJkcCPXt/M2u3y0B1b3z+TdMpGvYYFG7U413x0CSs2JHfD2Opjibx9697gwKC2/yiUCLj2jZXsh2Mit6IYznI84fC83NedlfVWURYIn6RlWMbc32MejMJT3cKZZi2+pup9lMyrWE/z8GDdmOKHbwhIkWTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977088; c=relaxed/simple;
	bh=Zyx3ZJ3sSxVN+wAEceiYONte8aFNCfh7h36hqBeYM/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYRBOStvnp/jn+48+7Mzw1pOCcZ8M9HRfJ9bL+U9f3mNMwbbvSUGfAZA001LmzB6DQh6s8ZGdiaAHDUV4fz3VfVxoZY60uy6hhdg/XpQnCVzt42pQHMvSN9Usm8Xrq19hbcI1HSmgd03vZQ7mEI5j2kpSAOZv5wdM/nAf83TWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n2DGW8F7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q4FBwxA07+ffxmHHVnqxkU5EgkVx0Akd/DndSKYMs+8=;
	t=1763977086; x=1765186686; b=n2DGW8F720KHpOPv0zHmiEdg6LWRloxhTsNIOLLyktdNy0V
	7wSWdQS4SDhnb78RlHRhBZ1mWY7dnjqb2oKbIr7WWXm6WIJpcNTu2VKa+JTSaR+9eIqSoqvY7vH68
	t/WtBQZnLZ/FiGWeI55XiMlkwKnNtYJl3NdzTiPaYCbRUeuBlCnEcZpcoxE/9BCwBKbG9SgAhYP51
	kj4TDmwjVk2lHr9l3jMWj2vGUC++JoOEUVmtk/4nNS8Ewoxdgiwq5j54ZFU1uib7BDN8mSHjxJbfp
	lJsxR8qxvwT6hXPIYaoahDgeb0MgYMo6XcEGytB7cRRebdkEqNL36G6U1YReQZJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNT1H-00000008Y1e-1Tit;
	Mon, 24 Nov 2025 10:38:03 +0100
Message-ID: <892a96466efca5b1f91bebfb81ec1ba4bdcda7e0.camel@sipsolutions.net>
Subject: Re: [RFC v4 wireless-next 1/2] wifi: cfg80211: allow send/recv
 tagged EAPOLs
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc: linux-wireless@vger.kernel.org, j@w1.fi
Date: Mon, 24 Nov 2025 10:38:02 +0100
In-Reply-To: <CAFED-j=DABs8dTqLdSs0Qs19xQty_1bEnu49dQmkam=G6jC-Tg@mail.gmail.com> (sfid-20251111_174213_504436_2FAFA088)
References: <20251109193543.2858854-1-janusz.dziedzic@gmail.com>
	 <eeb4d8484a590d39590dbbd71d0924851115b0ac.camel@sipsolutions.net>
	 <CAFED-j=DABs8dTqLdSs0Qs19xQty_1bEnu49dQmkam=G6jC-Tg@mail.gmail.com>
	 (sfid-20251111_174213_504436_2FAFA088)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-11-11 at 17:42 +0100, Janusz Dziedzic wrote:
> pon., 10 lis 2025 o 09:46 Johannes Berg <johannes@sipsolutions.net> napis=
a=C5=82(a):
> >=20
> > On Sun, 2025-11-09 at 20:35 +0100, Janusz Dziedzic wrote:
> > > Base on EasyMesh spec and traffic separation we have:
> > > "If a Multi-AP Agent configures a Primary VLAN ID, the Multi-AP Agent
> > > shall send EtherType 0x888E frames on a Wi-Fi link in a Multi-AP
> > > Profile-2 Network Segment with an 802.1Q C-Tag with VLAN ID equal
> > > to the Primary VLAN ID."
> > >=20
> > > Add option that extend current control port implementation when
> > > NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN used and allow to setup
> > > VLAN id for control port frames for both TX/RX direction.
> > >=20
> > > While easy mesh AP could serve both fronthaul + backhaul:
> > >=20
> > > RX accept EAPOL:
> > >  - with VLAN tag (backhaul STA) - strips tag, forwards to userspace
> > >  - without VLAN tag (regular client) forwards to userspace as-is
> > >=20
> > > TX (controlled by hostapd per-STA):
> > >  - For backhaul STA: hostapd sets NL80211_ATTR_VLAN_ID,
> > >    frame is tagged with Primary VLAN ID
> > >  - For regular client: hostapd omits NL80211_ATTR_VLAN_ID
> > >    frame sent without VLAN tag
> > >=20
> > > Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> > > ---
> > >=20
> >=20
> > Having some indication what you changed between the versions would be
> > good, I barely remember older versions :)
> >=20
> > I do note that on RX you document the "good" but not the "bad" case: th=
e
> > VLAN tag should be stripped, but that means userspace cannot distinguis=
h
> > if it was present, so I suppose the driver must drop frames that didn't
> > have it present? Then again in mac80211 you implement that both are
> > accepted, but then it seems userspace should know which one was tagged
> > or not?
> >=20
> OK, maybe report it as
> +               cfg80211_rx_control_port(dev, skb, noencrypt,
> rx->link_id, vlan_id);
> And if we strip add NL80211_ATTR_VLAN_ID, so hostapd could check assoc
> multi_ap_ie/map_profile and AP map vlan config and reject EAP without
> tag?

I don't know what's required, but I guess that works?

> I also think about smth different. Add vlan_id to struct sta_info,
> then hostapd could setup sta_info->control_port_vlan_id after check
> hostapd config and assoc multi_ap_ie/map_profile.
> So, for rx/tx path we could decide base on sta_info.
> For STA_IFACE we don't need both tagged/untagged support.

Is it worth doing per station? Seems the only consequence would be
checking/dropping in mac80211?

johannes

