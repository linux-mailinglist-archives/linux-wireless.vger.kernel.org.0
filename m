Return-Path: <linux-wireless+bounces-34536-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDIsMTwa12liKwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34536-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 05:17:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9323C6001
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 05:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5E87300DEC1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 03:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF334EF0E;
	Thu,  9 Apr 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZFnjckuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B91DE8AD;
	Thu,  9 Apr 2026 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704632; cv=none; b=QsUOJ+S/tUuoAmP8uSheLO4ebotMPIkPRt45/lzPqGIClsr9Sx77uPjxyJrCYczdLv5Orp3NSEGpTm8v0Lj/Y1lAb9qI6CxsZxBiV2V0U2a5NK3LR8k0P6cC74clr4AORl4xd53o3puMmORWSPgcOWFdvZRx0F+9A2zZZHSNdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704632; c=relaxed/simple;
	bh=eBQnQ3Q/Ba35iP1dXEZOzQWnDggBDM2eI5joCQbHff0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0Ybl3Or9H9oJJdh1KAMUpVU0uqMHUZVtozRKSCNgCgvppjabPSWhLiBqkIZ8IFfbAbAItnSNDATAo4Pph/RJLFxWzCqfFf5DzTL2ALJZGp/bkEpfVL1Le/+XXwAuNfJiRU4VbkM98KEAfumMxnlrVjqn3Ix9xAOu7Vn5LV2RS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZFnjckuV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6393H7cyC247616, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775704627; bh=0yEWmC5dWr77+BfqqO0IrLKlEWiKTA5/B54JaRSlDrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZFnjckuVxKEHUhPOZX1kb76TYoQTRIjuvu2S2ncs49nyGpL2dmoRSKGalvJDRCWSQ
	 i1IiCIpQYyflbNmUjoBbCXweGCqGxwzG1gkzx46BebO44rBG66YvM70AuVWJwf/MF6
	 5grbcVw1LyW1P73G47Z+O/jz67WtM3HrKERqITIv64Ih5DpUnrtn+BYjhuOz6Q6kQf
	 lBR5Imx5Phat8XjXuN++HBuMbKE08qAvqt+X/4cjg+QIvjcXCoP1NlF/jj/eAww58b
	 HLvooMKkILqUnBDtIbHOX6OgDCRslzoH9Dv9UdAWAervdRxymeU1McBbyrUSoTl56I
	 HALBUW3dk4Lbw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6393H7cyC247616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 11:17:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 9 Apr 2026 11:17:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Thu, 9 Apr 2026 11:17:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christos Longros <chris.longros@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: fix wrong pci_get_drvdata type in AER
 handlers
Thread-Topic: [PATCH] wifi: rtw89: fix wrong pci_get_drvdata type in AER
 handlers
Thread-Index: AQHcv08l/6PGuklgkkSJJoylxqwjLbXWH71A
Date: Thu, 9 Apr 2026 03:17:07 +0000
Message-ID: <9f5dc9fa3b0747b1b07e27ac7ccf5443@realtek.com>
References: <20260329073857.113081-1-chris.longros@gmail.com>
In-Reply-To: <20260329073857.113081-1-chris.longros@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34536-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 6A9323C6001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Christos Longros <chris.longros@gmail.com> wrote:
> rtw89 stores an ieee80211_hw pointer via pci_set_drvdata() at probe
> time, but io_error_detected() and io_resume() retrieve it as a
> net_device pointer.  This causes netif_device_detach/attach to
> operate on an ieee80211_hw struct, reading and writing at wrong
> offsets.  The adjacent io_slot_reset() already does it correctly.
>=20
> Use ieee80211_stop_queues/wake_queues instead, consistent with
> every other queue stop/start path in the driver.
>=20
> Tested on RTL8852CE by calling the handlers from a test module
> before and after the fix.

Could you share the "test module" you did? I'd like to know how to
test (simulate) the io error.

>=20
> Signed-off-by: Christos Longros <chris.longros@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



