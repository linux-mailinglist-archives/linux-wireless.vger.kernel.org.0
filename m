Return-Path: <linux-wireless+bounces-32723-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMRhCMEXrmny/QEAu9opvQ
	(envelope-from <linux-wireless+bounces-32723-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 01:43:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB19232E6C
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 01:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7468A300E26A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7211E1C02;
	Mon,  9 Mar 2026 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Sefhrra7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD45F9E8;
	Mon,  9 Mar 2026 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017020; cv=none; b=LKjs08AsWcOs+9eaMSuTzkwdKW2WXsI8Ucz+wR6xO4eS0z3RSaULiHTG4ydRF68G11xQ3B+F4kdRey65PKNIsxKmd8TiJQMa0ksB/o6w5o4wp/YaSKcDdx+oybaxrW+ubIx/wno2fBEGaJrT78zZHLIgAUpNcdbaNomCAdwE5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017020; c=relaxed/simple;
	bh=kEoIAAn9s67W3k5ZGIKh/wvGszNnhs9k5iKsOLcGDDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9UrA1mj2dhAMz26B+39KKwmHWsBF8UaD71DZ914zINAB4bLBGYQfPVOQIBUvk0eBNrISQWrEHN/TZ8EbJH/+yn/gGanud0+H47No3LFhxI5xRpA4xzrGrgUru8Phr2Qv2WIbVmwI9lYWT3RvYK/SHLx7rpkDaL83wtcDKl8Z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Sefhrra7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6290hOwZ53686148, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773017004; bh=kEoIAAn9s67W3k5ZGIKh/wvGszNnhs9k5iKsOLcGDDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Sefhrra7nebv/noaGG2lp+Hl8IVrP2a9PGhoj1jBsfXnpBfmigMuJ/6yEmSJhsaqG
	 cp1CHp10kaCKxO4Sm22yUy97w6PnVDptTFiFVZMQO18uLaRPfhWmm+4rWTaLRCRrFc
	 o1XWjyHnxlCLCfAkHUahbIffkgHB5F7lGZNoysDnPTiWVLeZ7tFP8tsAGtRQ3OAGXU
	 TyLTPnuEljTy7UkWxCFKJ45+Xr9OTAPDo/8/lHugZFiczo3g6xWZ9KJCByP4ESFhnQ
	 itY/JsbAANcZTfbavwMWVZH0c4AX+oPkzhdsBzD66YOK9bQDNNZGwaVTlfmniyN6GN
	 5X6ehI42NgFBw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6290hOwZ53686148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 08:43:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Mar 2026 08:43:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 9 Mar 2026 08:43:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        stable <stable@kernel.org>
Subject: RE: [PATCH net] wifi: rtw88: properly drop usb interface reference on
 error
Thread-Topic: [PATCH net] wifi: rtw88: properly drop usb interface reference
 on error
Thread-Index: AQHcpLjbvOo/97laWkyK/7R7FXgm/rWbphWAgAnLaxA=
Date: Mon, 9 Mar 2026 00:43:24 +0000
Message-ID: <24edddc6e31e4e369ceae3cd75e4378e@realtek.com>
References: <2026022333-periscope-unusual-f0a0@gregkh>
 <8f573000-97db-4b6c-83ff-a759ac3175cd@RTKEXHMBS05.realtek.com.tw>
In-Reply-To: <8f573000-97db-4b6c-83ff-a759ac3175cd@RTKEXHMBS05.realtek.com.tw>
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
X-Rspamd-Queue-Id: 6DB19232E6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32723-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > If an error happens in the usb probe path, in rtw_usb_intf_init(), the
> > usb interface reference needs to be properly dropped, otherwise is is
> > incorrectly increased when returning to the USB core.
> >
> > Cc: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>=20
> c413737effd6 wifi: rtw88: properly drop usb interface reference on error
>=20

As Johan shared patchset and discussion in [1], drop this patch.=20

[1] https://lore.kernel.org/linux-wireless/2026030625-wrongness-preorder-4e=
1e@gregkh/


