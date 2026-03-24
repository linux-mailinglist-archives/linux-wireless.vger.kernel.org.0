Return-Path: <linux-wireless+bounces-33744-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEfeLTXdwWnxXQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33744-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:39:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF02FFC9F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E012301AB8A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5F2253A1;
	Tue, 24 Mar 2026 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GtDVt45F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC741A681A
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312725; cv=none; b=VM9XsEqkciIC/VNt6ZkqXBX+buQX2GBYpzPMKGBhoFFinMU9z8FhH1dUXxzzBI81SXefn4nI2ZFI979KYTao+N8Se1VAKjGqDFEq7qjXkI3BAQpswrZ2gdpGAGkxZXipEsjehcVxRNM4w0fqNenG4ssRQoFcLQX7HlBcgFu5dSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312725; c=relaxed/simple;
	bh=FbngYBT2yXHB1NOvK0n79Wwl+5reUtZHHwoyUrSdAmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqO720BS5sS3Y1AuENJPwjUUasccTHfBfwePTepFzqIPxLR/xCvMFjMurpRPXxItHsPYOgiC86xxBbeEXHwsPq37xA2+FN4p6KdfiM7ISjtTnTONyyIX+nDgwFh50ypW+JlC/ksY3i49M3SjmD0Z2qLQdzVRBUSrjGgYfncR44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GtDVt45F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O0cC9E1047942, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774312692; bh=ErZUr7AWmVwtNXzRqUft4tdlK3BYGuyAQLcdfESKEU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GtDVt45FEja11ogEYvEB19R9a5QxnPI/e2nFuUv9IIwmareFyeM0DjkIsEfOTiK/Z
	 endLUSJPKXCa7ihSqZ2bi66MWnbmg0m25ZLCoAGz2BTO7vuoa3DVH1SOU0w+2chkC8
	 Rp1QSW6uzUBjN/YF85MNkRq8kOjPZVMU/zsJHw/FS5kET7dSon6zerSOJBPOHcGhm8
	 vRWeTu/1MuBgKAe15WH9hO6e2wCiKeBQnDHJJiTiucSowr08ZvFeMiQuHzhkNNLSSy
	 XddALvgb82/Hu65MxEJsZW1S8o12DThC0GcSduxmkxfKXUKS4jGXsfFHiE5qxRvvAM
	 61bWN5U03KwRg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O0cC9E1047942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 08:38:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 08:38:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 08:38:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 24 Mar 2026 08:38:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcuOQb90SZVl0Vy0mC7JoZ7Dgc1LW71zvAgABrzgCAAJY90A==
Date: Tue, 24 Mar 2026 00:38:12 +0000
Message-ID: <701291fc012b49979b1fb25b8d765d65@realtek.com>
References: <f2fca9db9deb445c91b1973c6b7ca72a@realtek.com>
 <20260323233334.158678-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260323233334.158678-1-lucid_duck@justthetip.ca>
Accept-Language: en-US, zh-TW
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33744-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 32FF02FFC9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lucid Duck <lucid_duck@justthetip.ca> wrote:
> Hi Ping-Ke,
>=20
> Thank you for the review. Answers to each point below.
>=20
> Mailer: I use a direct SMTP script -- git send-email had a hang
> issue on Fedora 43 that has since been resolved. v3 is sent via
> git send-email. The patch applies cleanly with git am.
>=20
> Uplink data (USB3 5GHz, 10 runs each, DWA-X1850 RTL8832AU,
> kernel 6.19.8):
>=20
>                      Unpatched    Patched-32    Patched-64
>   UL avg:            844 Mbps     763 Mbps      840 Mbps
>   UL retransmits:    3            0             0

If you have RTL8832CU, can you have additional test on 160 MHz bandwidth?

>=20
> 32 URBs shows a ~10% upload regression on USB3 5GHz. 64 URBs
> recovers to stock with zero retransmits.
>=20
> > Can increasing 32 get better performance? The stress test with
> > small packets might yield low throughput?
>=20
> Yes. I tested 32, 64, and 128 URBs per channel. The difference
> is most visible under parallel streams (USB3 5GHz upload):
>=20
>                      Stock    32 URBs    64 URBs    128 URBs
>   4-stream:          858      556        837        849
>   8-stream:          872      565        830        833

Not sure if people want 128 URBs to have a few better performance.
For me, if there is no objection or restriction, I'd take 128
because this driver can support RTL8832CU working on 160MHz
bandwidth, which maximum throughput is twice of RTL8852AU.

>=20
> 32 URBs drops 35% under multi-stream load. 64 URBs recovers
> fully. 128 URBs shows no further gain -- 64 is the sweet spot
> for USB3.
>=20
> On USB2, URB count does not matter -- the bus is the bottleneck:
>=20
>                      Stock    32 URBs    64 URBs    128 URBs
>   UL avg (USB2):     250      252        248        253
>=20
> Small packets (USB3 5GHz upload, 3 runs each avg Mbps):
>=20
>                      Stock    32 URBs    64 URBs
>   64 bytes:          139      128        126
>   256 bytes:         441      444        442
>   1024 bytes:        845      786        846
>=20
> Small packets are CPU/USB-framing limited, not URB-count limited.
> No throughput difference at 64 or 256 bytes. At 1024 bytes, 32
> URBs constrains throughput; 64 recovers.
>=20
> > Out of curiosity. Is it possible inflight >
> > RTW89_USB_MAX_TX_URBS_PER_CH?
>=20
> No. check_and_reclaim is called before tx_kick_off, and each call
> submits at most one URB. The >=3D is defensive only.
>=20
> > I think the code self-explain this already.
> > I'd not prefer this comment neither.
>=20
> Both comments removed in v3.

Thanks. Can you additionally remove the comments of CH12, which
looks like not preferred AI-like comments? I will note this in v3.

>=20
> v3 follows with MAX_TX_URBS_PER_CH increased from 32 to 64.
>=20
> Additional validation at 64 URBs: UDP flood (0% loss across 4M
> datagrams at 930 Mbps), bidirectional (zero retransmits), and
> 60-second soak (844 Mbps sustained, zero degradation).
>=20
> Full test data:
> https://github.com/Lucid-Duck/tx-resources-flow-control/blob/main/test-re=
sul
> ts/2026-03-23-ping-ke-v2-review.md

Thanks for your experiments in detail. :)

Ping-Ke


