Return-Path: <linux-wireless+bounces-32580-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sbHUMF8xqmlPNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32580-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 02:43:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EB21A4EE
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 02:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC4B302E920
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8EA2FC893;
	Fri,  6 Mar 2026 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZbKwprol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840B149C6F;
	Fri,  6 Mar 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761436; cv=none; b=tRpdIzB8wn9mDO3uyPA53ID5WatxMeTVsviIx+yCW00Jqo5OQMXiqvUf90hOtM79pnLe22uR3GMy8yaBmwXxgzcULycnbTpaqsGtV2+Lwf8fbmQmZxD+bdP/lRrQgPO5GyRImYMISaM4tVyTfpUxd5HZAv/eUH7OC0Uy5YwJP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761436; c=relaxed/simple;
	bh=9ZjZmBXy47rkEVFQ0MTMMZ+4owFlcNzssZC/p/7JUP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpRHF44r2U/MW0velmuoB4Hcuo63kvkoKDvmspoDqYMKmj1Vye4s67Z2J+afVdAHRGzHcpkZ7QSKSDKiwc3U9TbqdbfHSuPNzhe7J5rq0NYNv3Z9EX0D/mTeGa2xgip7U8OJDRBRJqIXfjQBX3Turck374VVEyvnKDFxqfaYOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZbKwprol; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6261eVMY12462861, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772761231; bh=w8U8sv4RgOb2NvWqxWiVPoWZ9xup2rPwC/rgrKn8kO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZbKwprol5DaNEnOUhRXQpFu5ooLFS8fuzDMl3POBChQgQ4uNmEQ6/HuEsEShlCzeu
	 kLmeJLJ87xXOjL4B/magetU4wQ6/UgxDJqukEArhu9z8MqRcRM9QkAl13wZuvff0GB
	 WYlve8pXXLaMUKJwFl0/C1WEzorogDOpsbo5N6B9kc7Lhk96Uxv9gkStd3wrr4iT48
	 6+Hz83kgMaHsEYlvUI38etif0XXyvtkzEXmBaYO52GxYn/xbzYtXsJOgbiDi3FumCC
	 cyFBuqpCTXSwacR8Gd25u4cuJ6D6lwrdI4WLdDB216zo/iYRDynSJK2RuaSuTtkTM5
	 MwpcFY0mSjLJw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6261eVMY12462861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 09:40:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 6 Mar 2026 09:40:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 6 Mar 2026 09:40:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johan Hovold <johan@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen
	<shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Hin-Tak Leung
	<hintak.leung@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        "Nicolas
 Ferre" <nicolas.ferre@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        "libertas-dev@lists.infradead.org"
	<libertas-dev@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH 00/13] wifi: drop redundant USB device references
Thread-Topic: [PATCH 00/13] wifi: drop redundant USB device references
Thread-Index: AQHcrJBJgpW9edckl0WtWY+w5y49ArWgtZSA
Date: Fri, 6 Mar 2026 01:40:31 +0000
Message-ID: <0c75afbbe7bb419cab648f94191fe47f@realtek.com>
References: <20260305110713.17725-1-johan@kernel.org>
In-Reply-To: <20260305110713.17725-1-johan@kernel.org>
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
X-Rspamd-Queue-Id: 242EB21A4EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,vger.kernel.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-32580-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

// +Cc Greg

Hi Johan,

Johan Hovold <johan@kernel.org> wrote:

[...]

>  drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |  4 ----
>  drivers/net/wireless/realtek/rtl8xxxu/core.c       | 11 +++--------
>  drivers/net/wireless/realtek/rtlwifi/usb.c         |  4 ----

Acked to changes of these Realtek WiFi drivers. But I'd like to know why
rtw88/rtw89 aren't included in this patchset? Greg sent a patch [1] to
correct error path of USB probe for rtw88. In the discussion, he also
mentioned the simplest way is to drop usb_get_dev()/usb_put_dev() like
this patchset does. Will you share patches for rtw88/rtw89? I so, I'd
drop Greg's patch and apply yours.

[1] https://lore.kernel.org/linux-wireless/2026022333-periscope-unusual-f0a=
0@gregkh/

Ping-Ke


