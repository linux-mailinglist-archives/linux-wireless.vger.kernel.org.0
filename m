Return-Path: <linux-wireless+bounces-34683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP76LgKI3GnJSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 08:06:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4023F3E7A2F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 08:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB903300566E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 06:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28B38F925;
	Mon, 13 Apr 2026 06:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cxgDztce"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203339151A;
	Mon, 13 Apr 2026 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060414; cv=none; b=HqmmR+cw75hE0rl67y2PDSPJUKZFT2MazaUQMFSyOMH0DbJbEOtCkh3p5IRWY+SBqI3MUNvazh6qgfAz++QS2EB0COE31QazwcJHEgr5xRdbBQ02pwvSc/+M8IfoD2VluLkPTHEwte+42pYJMkGR3sjxkVV7cBax2qpPH1rXkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060414; c=relaxed/simple;
	bh=ldge14U2ZTrn5gfpwDJEyEMUG8SMvBanQgE9gv4PZeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw0r5Ox6wMIv/pUTj/cG/HYebLX3N4rMZSyIqPAZJnbPIxibI69EgSbXpNb8qipSeUySFLX7CADgqP6Cfad4iXvIdvQDqrMrRNw1W3T7JFOl9F9fQDcMQkz6vWJ0dmfo2XNW2FpQtrgmx4tNpc4a8IxUgGhovTFjhL4i25z/7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cxgDztce; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63D66m6dA3739713, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776060408; bh=1Zd3aPozqdg/WXwS79v8IkdTRY21wmzXKgx2HZ0GSvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cxgDztce+GAK7tSJmhw+Az21Rtra+QMO2Rc/iFp3IiQvIki7Ii8t0M/bqDe6rAeXB
	 p0GXXXjz0UFovm0eCPFF0xakBH0axqT6QS9LqAUdqo/JZOHhLPnBlFnL0QPfm1ylYr
	 K8hwxpiHNz9jleqhAuzbUF5d4A6PTCWQc8P2cBGN8J0+A3ApjZpc0qbs55sxkDi04m
	 32XwzNaYBmeBm8KVjm6s4ilLwHW4Fi2eWfOZyb3jqzSrDtl9XOb5C7BLtp7M0eDKYc
	 a2Dp1TL8u1Cz5QGp7a7AhD57XsydwaapOsAR1yCiWIw9RapqvtpFN4EOEEngasgIiu
	 oIDkz4YYt216g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63D66m6dA3739713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 14:06:48 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 14:06:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 14:06:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 13 Apr 2026 14:06:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christos Longros <chris.longros@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: fix wrong pci_get_drvdata type in AER
 handlers
Thread-Topic: [PATCH] wifi: rtw89: fix wrong pci_get_drvdata type in AER
 handlers
Thread-Index: AQHcv08l/6PGuklgkkSJJoylxqwjLbXWH71AgAZ41RA=
Date: Mon, 13 Apr 2026 06:06:48 +0000
Message-ID: <edaecd9667d94544819bebef54a2ca9e@realtek.com>
References: <20260329073857.113081-1-chris.longros@gmail.com>
 <9f5dc9fa3b0747b1b07e27ac7ccf5443@realtek.com>
In-Reply-To: <9f5dc9fa3b0747b1b07e27ac7ccf5443@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34683-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4023F3E7A2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Christos Longros <chris.longros@gmail.com> wrote:
> > rtw89 stores an ieee80211_hw pointer via pci_set_drvdata() at probe
> > time, but io_error_detected() and io_resume() retrieve it as a
> > net_device pointer.  This causes netif_device_detach/attach to
> > operate on an ieee80211_hw struct, reading and writing at wrong
> > offsets.  The adjacent io_slot_reset() already does it correctly.
> >
> > Use ieee80211_stop_queues/wake_queues instead, consistent with
> > every other queue stop/start path in the driver.
> >
> > Tested on RTL8852CE by calling the handlers from a test module
> > before and after the fix.
>=20
> Could you share the "test module" you did? I'd like to know how to
> test (simulate) the io error.
>=20
> >

I'd add a Fixes tag

Fixes: 16e3d93c6183 ("wifi: rtw89: pci: add PCI Express error handling")

> > Signed-off-by: Christos Longros <chris.longros@gmail.com>
>=20
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>=20


