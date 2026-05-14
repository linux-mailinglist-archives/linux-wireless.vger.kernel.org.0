Return-Path: <linux-wireless+bounces-36399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NqDOzweBWoASwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 02:58:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C453C7DF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 02:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBE7A301E992
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889572F90C5;
	Thu, 14 May 2026 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZQWcpiSu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256B1531C8;
	Thu, 14 May 2026 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720312; cv=none; b=OtX655GWgj1tmOrzST23rLc2Jiv3L0abin03+LnLbxYH8AP848X+I6j4IqKB9XM8irsT4U82NYYQG5m+l9lEIxvw+E21ImnL6WydqSbbTYyGfADyQXw+OmUKnMI2si7dO57xvykF/lerUEPfHaSF7nLD3w6vSGx3WhNQE5xmhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720312; c=relaxed/simple;
	bh=pKQ49hwtIw1WVDCIHVG9xLAYGREhRwrtQ+deom15G0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWXPkIdfQxOuUy+wZc0TssX+sR6AbbJiNoop8OfCe24UPHfL6jYn5BowVcn0LaH54JDuWxI4GSWECRCYbbMVtLQsb8QV8smLT+m+rB0Pt45K2f0639KE6l/c9EdsgZvO7zUr4NYzvmzNcvuZV/7L24fwSmeQExOlEfflx/BSZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZQWcpiSu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64E0w8bgD1424407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778720288; bh=pKQ49hwtIw1WVDCIHVG9xLAYGREhRwrtQ+deom15G0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZQWcpiSuxMVqmGWX2U7LxZZTdPGEfH8nioKCzq5JoG7/pNGndsO+ImJOda23mk95+
	 Xc5Mot9hJrvQ3W9mNoGNDE/wZ1t8hZMUfag/v2LGxaBBjaBXcWpYNZ5x/7cx4DTBtw
	 PHNbLk9YiziYFs/BKEayNcaAeY2R0UunjqE+vOpUqdL11J4Np6q7Giw9KELG6W5+F7
	 czbCQhlRGHUtfHv+mnaEmWj1UfLJ3FcpK+wFH3SrypaYaX+SxYTi35i4r6DmueR52f
	 WqaiaXMWp+RRNixcYVmD4HCyCKQ3G+nUIkNw6g/jZgusfl4QwAN2iXVwKlJpvkDiRD
	 LsGBve+i5iGAA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64E0w8bgD1424407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 08:58:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 May 2026 08:58:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 14 May 2026 08:58:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "luka.gejak@linux.dev" <luka.gejak@linux.dev>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3] wifi: rtw88: increase TX report timeout to fix race
 condition
Thread-Topic: [PATCH v3] wifi: rtw88: increase TX report timeout to fix race
 condition
Thread-Index: AQHc4wPFdTV6Vqbf5UWFMEx2u7URLrYMsscg
Date: Thu, 14 May 2026 00:58:08 +0000
Message-ID: <696f2c67b1964ada9171b61c920aabc6@realtek.com>
References: <20260513180935.13289-1-luka.gejak@linux.dev>
In-Reply-To: <20260513180935.13289-1-luka.gejak@linux.dev>
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
X-Rspamd-Queue-Id: 5F5C453C7DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36399-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

luka.gejak@linux.dev <luka.gejak@linux.dev> wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>=20
> The driver expects the firmware to report TX status within 500ms.
> However, a timeout can be triggered when the hardware performs
> background scans while under TX load. During these scans, the firmware
> stays off-channel for periods exceeding 500ms, delaying the delivery of
> TX reports back to the driver.
>=20
> When this occurs, the purge timer fires prematurely and drops the
> tracking skbs from the queue. This results in the host stack
> interpreting the missing status as packet loss, leading to TCP window
> collapse. In testing with iperf3, this causes throughput to drop from
> ~90 Mbps to near-zero for approximately 2 seconds until the connection
> recovers.
>=20
> Increase RTW_TX_PROBE_TIMEOUT to 2500ms for RTL8723DU. This duration is
> sufficient to accommodate off-channel dwell time during full background
> scans, ensuring the purge timer only trips during genuine firmware
> lockups and preventing unnecessary TCP retransmission cycles.
>=20
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")

Since RTL8723DU is supported by the commit 87caeef032fc, I'd change Fixes
to below during getting merged.

Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")

> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>




