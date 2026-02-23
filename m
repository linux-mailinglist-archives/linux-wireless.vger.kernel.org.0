Return-Path: <linux-wireless+bounces-32081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NUTALwq3m2nm5AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:10:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0439D1715F3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA0A300B11D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809F19DF62;
	Mon, 23 Feb 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Jqifmlj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BCB640;
	Mon, 23 Feb 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771812613; cv=none; b=epF/FH2ShD+2Z9//+jnw7f173GD7XC5QznWkl66+a1JQooE68C06t7pruVnNm+H0gfjzdVYRA2Bcvt/AE3QyVpNRybxuVkGgmC+1q+ewNMHnRMOKzslRof8HMLLqV18IDy1U1de3WmA2hcVKiBEgPHkD5bdivFZQhTRitJqCk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771812613; c=relaxed/simple;
	bh=WqE2Ki3DDn4D+xYFR0rEjXZPh6lsto+FPuWr0Uq+X7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWHN/WQNW+m0pPggRaNUcOWSqufJHbi+sEqnA/a/fZBKOZmMSa3yD/SewHRLv8EYuMe39FEQ6TsHOEOxdyt6V5RrEB/wYCujMgKZnEVqnWAk+UpLmNuG0M3ovDL6x6bp055625dfsVnvstAmABkpiPTLDU1praI3Rqn/MP9Xslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Jqifmlj9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61N29P7u84175276, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1771812565; bh=vhUmJifiUzk7U7pvzi/tfytjSa/DgdglV9z1YA/95kM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Jqifmlj96xz7FGOVWMzbavfPk6siuqF4dyVFzJoHV2+ND9z8GEs4Is2X5wOdWTBhX
	 QE0RWUB3Vdr4t5K2DNeM7rvZ9ZWleSw1t5XzrjgeeVK0rb6kablm5ftk1rTvxuHKIF
	 QBT+vdNN34xDUSJiivlCI0AbrETYVQkwi6sFmYWigqAGaKiSsW/0StovzBaGbs9OG3
	 t6H5ITm0DpsRGMZyhzTbp4nlSveStvAqBVw7qNvjHo4J5icnvYEAi7IBmdzE7Ywu/u
	 tX3tdNLAw7X36ggMzdF8DpiaMYl/Y2utW928O7II9j22uu7//Tl25Hp+o9hleTmuY/
	 FWkUOLHTVKKxA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61N29P7u84175276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 10:09:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Feb 2026 10:09:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 23 Feb 2026 10:09:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Jian-Hong Pan <jhp@endlessos.org>, Kalle Valo <kvalo@kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bitterblue
 Smith <rtl8821cerfe2@gmail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: check for PCI upstream bridge
 existence
Thread-Topic: [PATCH rtw-next] wifi: rtw88: check for PCI upstream bridge
 existence
Thread-Index: AQHcok4HmClvoMlInUC8rFkPRHXykrWPjhrA
Date: Mon, 23 Feb 2026 02:09:24 +0000
Message-ID: <42615e24cf4a4e19979765b3bdf07d8c@realtek.com>
References: <20260220094730.49791-1-pchelkin@ispras.ru>
In-Reply-To: <20260220094730.49791-1-pchelkin@ispras.ru>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[endlessos.org,kernel.org,canonical.com,vger.kernel.org,gmail.com,yandex.ru,linuxtesting.org];
	TAGGED_FROM(0.00)[bounces-32081-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url]
X-Rspamd-Queue-Id: 0439D1715F3
X-Rspamd-Action: no action

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> pci_upstream_bridge() returns NULL if the device is on a root bus.  If
> 8821CE is installed in the system with such a PCI topology, the probing
> routine will crash.  This has probably been unnoticed as 8821CE is mostly
> supplied in laptops where there is a PCI-to-PCI bridge located upstream
> from the device.  However the card might be installed on a system with
> different configuration.
>=20
> Check if the bridge does exist for the specific workaround to be applied.
>=20
> Found by Linux Verification Center (linuxtesting.org) with Svace static
> analysis tool.
>=20
> Fixes: 24f5e38a13b5 ("rtw88: Disable PCIe ASPM while doing NAPI poll on 8=
821CE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



