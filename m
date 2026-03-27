Return-Path: <linux-wireless+bounces-34088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EdUMYmOxmlLLwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 15:04:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F02345BBE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 15:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D82633019179
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86EA3EE1DA;
	Fri, 27 Mar 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="N3SQruBS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32C17B506;
	Fri, 27 Mar 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619910; cv=none; b=VZQeMruU2HshStWvHtBARTR3c2SP8u9hl6yv2eGLhgeOE1dr6BCrNsT+pXvjmTXg3dTYYTvMCjFEWrNJa359LcdhexJrO29dwQi6R3p1HU2edcKeMv68CuoTiWH4U/gCnW2DuC1dxxcKZIQkXLSUUfLlq+E3/MvWIBEzS63FTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619910; c=relaxed/simple;
	bh=MFl20hUvm/0xpajaT2/SCnk9mnEOrbCajLDMyvRRahE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbk646ih/aecQr0lLD8+6rXsnZS8l+lrrh3w5mqYgdpaaQtnLFrw9eJviYQsApSaSs1GGhgp1fonuSNAZi23kUTi+yHwVzKb5+8KP9MYqUtnFoE8lkEbOJAFrrB1Nt7Vhqj4Me0WEF8w6bzMtC086EkF+s3K54JZjo5womjTg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=N3SQruBS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1774619907; x=1775224707; i=georgmueller@gmx.net;
	bh=uqbuCo4BQ9URaDwVUkMNthUuEw7eI6NUi9jDL5WrL80=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N3SQruBS82zk3XzffKCYhJ1VyCSU3O13PabaiYu3ywiKP3ASWKjsClxEgCof97le
	 kd+dZdZjIIUFQXA7yrWZDmq/aAksRY5ctjo5Om23zEqMMq+cGBWutNQd3XYvY8NtC
	 TK6kdl3mmrEb7BIsUjTf4/guvfPyHncjFXxYAKPv5DdpuarTgwWh28tWd9G0DscDg
	 IPjN+dmNPzrIaxX/bTqsdrEgYQx/DR0xhY7BLKPnFfc3p09qa+G72g61pBU3xe5iJ
	 srKDZ0iEF8Agj8qAmMb4GMWSwAeQeD3RIl244uix+fVxvMHBuSun8pbRZMTTMZBmm
	 9S+m1fIj4VH3dzL3cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1wEgQS09zv-00GRzD; Fri, 27
 Mar 2026 14:58:27 +0100
Message-ID: <4161102f-dcdc-4780-9bf5-26961a1360c8@gmx.net>
Date: Fri, 27 Mar 2026 14:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] wifi: rtl8xxxu: implement AP mode for 8188EU
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260313135321.3196688-1-georgmueller@gmx.net>
 <984b3534-aaad-48a2-ad96-ff1f26e924da@gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <984b3534-aaad-48a2-ad96-ff1f26e924da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qzq4lpFVXSIPxnuxWZllVT0vhfTTeYiYdK3ZVQH30QSdcolM6f2
 cAj35XqUpXvMYuolG0jBamacb9X++v0/nrFPkKQXUifVLo2LvgWIONVdQ9WMDnkEkrlHATA
 Gr176VU1KX+WNqKLzsBSz9aZDX1l8samDRD1Hw8AT33A1gBIu15LRL4RKaWdfoLPQ24gx4D
 13buGoKsw5xNcVvLDhNrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hnqt9ywIPIU=;wFronqHux/qcPoc0AWRvjOwWZGC
 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
 7au3V77XVlNnF1NN8UJwYldC9eD99awWA==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34088-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45F02345BBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just to give a litte update:

Am 14.03.26 um 00:14 schrieb Bitterblue Smith:
> What are the issues? Were they happening with your original patch
> which only added supports_ap and max_macid_num?
>=20
> Another thing still missing is the macid in the TX descriptor
> (rtl8xxxu_fill_txdesc_v3).

I added setting the macid in rtl8xxxu_fill_txdesc_v3 and the other comment=
s to the
patches.

There are still some issues:

In a test setup, I connected 5 different devices to a host running with a =
8188eu wifi dongle
running in AP mode and a web server running on it.

All were able to fetch a web page served by the host.

Sometimes the connection was a bit stuck, but this recovered after some ti=
me.

In the logs of the server with the 8188eu dongle, I sometimes observed the=
 following messages
in dmesg (with debug messages turned on):

   C2H TX report type 2
   rtl8188e_handle_ra_tx_report2: len: 24 items: 3
   rtl8188e_handle_ra_tx_report2: TX report item 0 not valid
   rtl8188e_handle_ra_tx_report2:  valid: 0 retry: 0 0 0 0 0 drop: 0
   rtl8188e_handle_ra_tx_report2:  valid: 0 retry: 0 0 0 0 0 drop: 0
   rtl8188e_handle_ra_tx_report2:  valid: 1 retry: 5 0 0 0 0 drop: 0

another thing which sometimes occurred:

   rtl8xxxu_read8(020a)   =3D 0x00, len 1   # <- repeated 50-70 times
   rtl8xxxu_send_beacon_frame: Failed to read beacon valid bit


What I observed on one of the clients was DUP ping responses. I will try t=
o debug this with
a wifi capture device.

Best regards,
Georg


