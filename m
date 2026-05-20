Return-Path: <linux-wireless+bounces-36730-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBAsKxQNDmo35wUAu9opvQ
	(envelope-from <linux-wireless+bounces-36730-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:35:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35C598777
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADE893014C64
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4A3469F6;
	Wed, 20 May 2026 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="fhfCiSh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-172.mimecast.com (us-smtp-delivery-172.mimecast.com [170.10.129.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461A340404
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305539; cv=none; b=E4HrGry+qLde1F/TUSf86+JsySir1cq9IoI69z2WtXy3ZYgV1NR2pc1hTEDGYmA4mvD0Bc+my/HtM0oIEgHwJwCV7W/b08SbZ6jgecyeqT3QFzgAq2VL9opYjpyuSvd7ig1HvLnAQ1j5hFvNCcc0eQhTUYRoY80edIkyZNZZTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305539; c=relaxed/simple;
	bh=xCGPosPoOBqmiHmmAMZeLaQmUo6jTO0qDbWxKThBXkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HlsppRjrNo32w9WZwj55z/EU8xd3WbnBaS5NNGpq/AK15VwpemUVi8GiFUH/72+UfM3jqoLxOmPAAbsEClDLFQCqyrsFmM9YAsgGc2n4OP6gE5HpAwBxzrWWo/ywRLBeENZrt4M6x8rM/rc2HkCHz1gXp5ctomMxnoRBX1FqBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com; spf=pass smtp.mailfrom=valvesoftware.com; dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b=fhfCiSh7; arc=none smtp.client-ip=170.10.129.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valvesoftware.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
	s=mc20150811; t=1779305537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCGPosPoOBqmiHmmAMZeLaQmUo6jTO0qDbWxKThBXkQ=;
	b=fhfCiSh7K6gNg5hhaohfSH7Gqxxv+82Ct7Ir4KYzher2gQLeNR3fhbjYsYXOWgfUZd/tQE
	ItL2+zr3of4mee2yf2+UvtJ8ZSU7+pudYRLu1JHjHyNypc5zTeRLs/U1KoFAfmgi8QGvUV
	o/+bSEYE44SPdE69JS3Tv54c1rhxYWs=
Received: from smtp-02-tuk3.valvesoftware.com
 (smtp-02-blv1.valvesoftware.com [208.64.203.182]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-373-ShAMSSOoMY6Iy8aR3uiwKA-1; Wed, 20 May 2026 15:32:14 -0400
X-MC-Unique: ShAMSSOoMY6Iy8aR3uiwKA-1
X-Mimecast-MFC-AGG-ID: ShAMSSOoMY6Iy8aR3uiwKA_1779305533
Received: from antispam.valve.org ([172.16.1.107])
	by smtp-02-tuk3.valvesoftware.com with esmtp (Exim 4.97)
	(envelope-from <sabae@valvesoftware.com>)
	id 1wPmeL-00000004qw2-3SNG
	for linux-wireless@vger.kernel.org;
	Wed, 20 May 2026 12:32:13 -0700
Received: from antispam.valve.org (127.0.0.1) id h1o63q0171sc for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:32:13 -0700 (envelope-from <sabae@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
	by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
	with ESMTP id o202605201932130035107-5; Wed, 20 May 2026 12:32:13 -0700
Received: from mail2.valvemail.org (172.16.144.23) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 20 May
 2026 12:32:13 -0700
Received: from mail2.valvemail.org ([::1]) by mail2.valvemail.org ([::1]) with
 mapi id 15.02.2562.017; Wed, 20 May 2026 12:32:13 -0700
From: Elliot Saba <sabae@valvesoftware.com>
To: Greg KH <gregkh@linuxfoundation.org>, Johnson Tsai
	<wenjie.tsai@realtek.com>
CC: Johannes Berg <johannes@sipsolutions.net>, Ping-Ke Shih
	<pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Charles Lohr <charlesl@valvesoftware.com>
Subject: Re: [External Mail] Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add
 hw_info sysfs attribute
Thread-Topic: [External Mail] Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add
 hw_info sysfs attribute
Thread-Index: AQHc52CHOsKUzQ+SEUSORaNAsdGbNbYUb+IAgABMgwCAAAMoAIAB5JEQgACcKACAAA9+Dg==
Date: Wed, 20 May 2026 19:32:13 +0000
Message-ID: <9ce7404ea7bc480786b5ed0bb2182157@valvesoftware.com>
References: <20260519072415.25746-1-pkshih@realtek.com>
 <efb61959e14e4f57b78fbd49a563398e@realtek.com>
 <83ddb427597663b947c49afd835014f2bc1033f2.camel@sipsolutions.net>
 <2026051957-refract-barge-b21e@gregkh>
 <b8640de28c5e4a94a3c2bbc3a101c1fa@realtek.com>,<2026052025-daringly-prolonged-5b2a@gregkh>
In-Reply-To: <2026052025-daringly-prolonged-5b2a@gregkh>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20260520005434; ds20230628172248;
	di20260507172443; ri20160318003319; fs20260520154049
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: sabae@valvesoftware.com
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202605201932130035107
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z2P0yRJsW3MlfS1sCL6_tx412xGA0zwLBEwxfPYBEb4_1779305533
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[valvesoftware.com,quarantine];
	R_DKIM_ALLOW(-0.20)[valvesoftware.com:s=mc20150811];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36730-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valvesoftware.com:mid,valvesoftware.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[valvesoftware.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sabae@valvesoftware.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2C35C598777
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Greg, Johannes, thank you for your time and feedback on this patchset=
.

The purpose of this information is to provide access to two pieces of infor=
mation, a serial number (also printed on the outside of the device, used fo=
r product tracking, RMAs, etc...) and a GUID (random entropy that is intent=
ionally difficult to guess).
We use the GUID to establish=A0a direct=A0connection=A0between the USB netw=
ork adapter and another device.

To directly answer your USB questions, unfortunately the ASIC used in this =
product does not support customization of the USB serial number; all device=
s have the same USB serial number.=A0 Indeed, I believe there is no mutable=
 state on the device at all except for the e-fuses that are written at the =
factory to write these two values.=A0 Given those constraints, we're trying=
 to find the best way to raise this up to userspace, and we're grateful for=
 your feedback.

This USB=A0device is expected to operate on both Windows and Linux hosts, o=
n the Windows side we have a custom driver that allows our host application=
 (Steam) to directly query these fuses and setup the network connection app=
ropriately.=A0 We're attempting to upstream this capability as much as poss=
ible so that users running a vanilla kernel can take advantage of these fea=
tures as much as possible.

With regards to permissions, we'd really like to make this serial number re=
adable by non-root users so that the pairing functionality can work out-of-=
the-box without needing special udev/tmpfiles.d rules to adjust permissions=
 to allow Steam to read this information, but we are simultaneously sympath=
etic to the desire to limit trackable/identifying information by default.=
=A0 Of course we can adjust permissions however needed for our own Linux di=
stribution, but in our effort to support the rest of the Linux ecosystem as=
 best we can, we'd like to do our best to find a solution that would work e=
verywhere.=A0 We're open to comparing against any existing precedent for de=
vices that necessarily require identifying information to perform their bas=
ic function, if you know of any.

Thank you,
-Elliot Saba


