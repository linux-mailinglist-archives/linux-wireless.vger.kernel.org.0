Return-Path: <linux-wireless+bounces-36762-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OdyOjQPD2qSEgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36762-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 15:57:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF4E5A688E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 15:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06815312A5B1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6B3D6CD9;
	Thu, 21 May 2026 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hur8ZQCp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136123D6CA3;
	Thu, 21 May 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368779; cv=none; b=kRfxr2PsenUF7nY8QtSP4NfLuSeIJscly0TYtt0U5rSe4EvUiFIaWMZej6zswiYg8byQTK3GaH2ZfaRMGEU5GkaCEajo7RbfE9EVXrkIYTe3iNYVLLGZh/ehq2Y/XjsW56tG/igweRboO9krW6jT/Ds3JxqlPXiWMRQ1gGPbb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368779; c=relaxed/simple;
	bh=4CwzAHf/G1dzaf9XIWG7E/awDbWag9aswjlEhBuYBYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Whn0JxOLUOXZz9Np6DWiBGJOPM+h62qA7aN5vMxLlgpZAbErHBOA0+LebvYxH4sFmYD7BSwycfa2RRwtY1tXPZAWB9myv6z2XKigyUd3XFDozLHOEzqaaqj+dPe38e/rOyF3H50plLMBN3URDck8fB9SrzPD45J2ICvtbt5WKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hur8ZQCp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64LD685g81329069, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779368768; bh=9HOnHfpwTEhGXwZHsgU++ky2CqzHfnmwlOMWg6Ubs90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hur8ZQCpgK3tE8fRC+k4j3Nv94gQ8VNMQw+V00R9lZuNXDt4SYyqI2IOK9GM6Ukwu
	 wpa8nCRb/2gsJyr1WllzbcKsFe2DwWIWQ3/Af/ErMiVYZEmKo3LhxsHX1qXn2G2SLT
	 K3vU66Ofi4OFHJWMS9Z6JDvoBvlq+FaTfBAFGrOFZjHzbFRQwQw9EYcuhC3FuxtFka
	 pn+cvfACmy5cPSJKqpebg6X/EkGoh8CNNkNgPIzstCvoJ6DVlP7GIy5LAyYOdxWGfB
	 lQkWKn+r+pJloP2B1ekHW2HjzuM8ksqHOJxVb6RFGADFCvtkFw3l4FpFPQEKkSoCwF
	 CCwMQa2l8jBsA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64LD685g81329069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:06:08 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 21:06:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Thu, 21 May 2026 21:06:09 +0800
From: Johnson Tsai <wenjie.tsai@realtek.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Elliot Saba
	<sabae@valvesoftware.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>,
        Charles Lohr <charlesl@valvesoftware.com>
Subject: RE: [External Mail] Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add
 hw_info sysfs attribute
Thread-Topic: [External Mail] Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add
 hw_info sysfs attribute
Thread-Index: AQHc52CHOsKUzQ+SEUSORaNAsdGbNbYUb+IAgABMgwCAAAMoAIAB5JEQ//+gswCAAIUIgIABApcAgACMGtA=
Date: Thu, 21 May 2026 13:06:09 +0000
Message-ID: <fe2a612385f8439a820272f442314d37@realtek.com>
References: <20260519072415.25746-1-pkshih@realtek.com>
 <efb61959e14e4f57b78fbd49a563398e@realtek.com>
 <83ddb427597663b947c49afd835014f2bc1033f2.camel@sipsolutions.net>
 <2026051957-refract-barge-b21e@gregkh>
 <b8640de28c5e4a94a3c2bbc3a101c1fa@realtek.com>
 <2026052025-daringly-prolonged-5b2a@gregkh>
 <9ce7404ea7bc480786b5ed0bb2182157@valvesoftware.com>
 <2026052152-pureness-blinker-9e5c@gregkh>
In-Reply-To: <2026052152-pureness-blinker-9e5c@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36762-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenjie.tsai@realtek.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 4AF4E5A688E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thursday, May 21, 2026 18:58, Greg KH wrote:
> On Wed, May 20, 2026 at 07:32:13PM +0000, Elliot Saba wrote:
> > Hello Greg, Johannes, thank you for your time and feedback on this
> patchset.
> >
> > The purpose of this information is to provide access to two pieces of
> information, a serial number (also printed on the outside of the device, =
used
> for product tracking, RMAs, etc...) and a GUID (random entropy that is
> intentionally difficult to guess).
> > We use the GUID to establish a direct connection between the USB networ=
k
> adapter and another device.
> >
> > To directly answer your USB questions, unfortunately the ASIC used in t=
his
> product does not support customization of the USB serial number; all devi=
ces
> have the same USB serial number.  Indeed, I believe there is no mutable s=
tate
> on the device at all except for the e-fuses that are written at the facto=
ry to
> write these two values.  Given those constraints, we're trying to find th=
e best
> way to raise this up to userspace, and we're grateful for your feedback.
>=20
> Then where exactly does that "serial number" come from in the device so t=
hat
> it can be read by the kernel, if not in the USB device itself?

The "serial number" we're talking about right now is not exposed through th=
e standard=20
USB descriptors. It is obtained via a vendor-specific H2C (Host-to-Chip)=20
command, which reads EFUSE data into the rtw89 driver.=20
Both SN and UUID are stored as specific fields within that data block.

>=20
> > This USB device is expected to operate on both Windows and Linux hosts,
> on the Windows side we have a custom driver that allows our host applicat=
ion
> (Steam) to directly query these fuses and setup the network connection
> appropriately.  We're attempting to upstream this capability as much as
> possible so that users running a vanilla kernel can take advantage of the=
se
> features as much as possible.
>=20
> Great, why can't this driver also query the fuses?

Yes, the driver can query the fuses directly, similar to the Windows driver=
=20
implementation.
In this RFC v1, the H2C implementation is intentionally omitted to keep the=
 discussion=20
focused on the sysfs interface design and gather early feedback from the=20
community.

>=20
> > With regards to permissions, we'd really like to make this serial numbe=
r
> readable by non-root users so that the pairing functionality can work out=
-of-
> the-box without needing special udev/tmpfiles.d rules to adjust permissio=
ns
> to allow Steam to read this information, but we are simultaneously
> sympathetic to the desire to limit trackable/identifying information by d=
efault.
> Of course we can adjust permissions however needed for our own Linux
> distribution, but in our effort to support the rest of the Linux ecosyste=
m as
> best we can, we'd like to do our best to find a solution that would work
> everywhere.  We're open to comparing against any existing precedent for
> devices that necessarily require identifying information to perform their=
 basic
> function, if you know of any.
>=20
> My objection is the placement of random sysfs files in the USB device
> directory, for something that is not a USB device-specific thing, but rat=
her a
> driver-specific thing.  If this is a driver/device bound specific thing, =
then put it
> in the device that the driver creates and owns.  NOT in the device that t=
he USB
> core creates and owns.
>=20

We completely agree with your concern. Since accessing these values require=
s=20
driver-specific commands rather than standard USB requests, they should not=
 live=20
under the USB device directory.

In the upcoming v2 patchset, we will move these attributes under the wiphy =
device=20
managed by the rtw89 driver. The paths will be something like:=20

  $ cat /sys/class/ieee80211/phy0/sn
  3642000123
  $ cat /sys/class/ieee80211/phy0/uuid
  aaec2b7c-0a55-4727-8de0-b30febccbbaa

Additionally, these sysfs attributes will be strictly limited to Valve's sp=
ecific VID/PID=20
pair and will not be exposed on generic RTL8852CU devices.


Thanks,

Johnson

