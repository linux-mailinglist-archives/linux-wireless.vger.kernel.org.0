Return-Path: <linux-wireless+bounces-20150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F11A5BAE0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 09:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DF816BA85
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD41EB182;
	Tue, 11 Mar 2025 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Gd/rDyrb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F25224251;
	Tue, 11 Mar 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681880; cv=none; b=mZUYha5LUbEql+kj9kmC34CyFd/moR6OLN3gnMcxcJNOFg1q7zHjfTKnHxqu/isLQJC9WudP9lYJO7KesZ4xdN/PnxWa4MD8j8VY1y47Wldaqk0tO3ALzmh9XMbVGTIndE7WhmYElD21qpNNdKmPHwIH6H/Uug7X/Dr374Htu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681880; c=relaxed/simple;
	bh=uq4l37xY33wQzcIfykqADPximmfzxDVqSGBzJxov3Hs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htgGcxfL7ScNDatgKimQarhdR4yxhulU1eQHpBs1xxLB+p1CUbAfgMisHaEMPd5yPXWNI+j3LGNJpwW7sEmBH/5HXNCbC+pQ5lZWKVxoEePC50pzCGIp4mUAj0hHZav9+2LpiPzuPg56e/ExAk6+ZuSC/Wyv1O38Bv3TFPKF8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Gd/rDyrb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52B8UNm94588832, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741681823; bh=uq4l37xY33wQzcIfykqADPximmfzxDVqSGBzJxov3Hs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Gd/rDyrbry8LtNamFACFIsvZLvXEXmqgZf1xFMZ++hkasL8aC5NgQYB3N2HNjByPT
	 oXLBbxkDRvyjAL6rYZ8806Sqpg9F3+WYWZCCi2FssVikLhhwYXo14aE/oxpTBWRxT+
	 wEb3wuXwwt1BByDzJ2aduKpcdfGCdh/FqhJrUlQ6wkzasuiycvN1q0KFwE6qq8neKk
	 5C/hv2iMjdtcLSXdgLMk8KYlqJ6LOrZWUCBJwXBC7hSk10XJ3/SUY/x4c8DKYqI6lU
	 r9L0Q6R+e9cqcXJY0dgx8Gf/0RGeDEG7XItGQRNF5QcGFZBONpSv2FqptfACsBoYBD
	 UAE5TmFYlc3+g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52B8UNm94588832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 16:30:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 16:30:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Mar 2025 16:30:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 11 Mar 2025 16:30:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
        "greearb@candelatech.com" <greearb@candelatech.com>,
        "michael-cy.lee@mediatek.com" <michael-cy.lee@mediatek.com>,
        "nicolas.cavallari@green-communications.fr"
	<nicolas.cavallari@green-communications.fr>,
        "emmanuel.grumbach@intel.com"
	<emmanuel.grumbach@intel.com>,
        "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>,
        "mingyen.hsieh@mediatek.com"
	<mingyen.hsieh@mediatek.com>,
        "chui-hao.chiu@mediatek.com"
	<chui-hao.chiu@mediatek.com>,
        "quic_adisi@quicinc.com"
	<quic_adisi@quicinc.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
        "bo.jiao@mediatek.com"
	<bo.jiao@mediatek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v10] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Topic: [PATCH v10] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Index: AQHbkkaLU9jfzMwpsUyUi0gFPwPxsrNtmuMA
Date: Tue, 11 Mar 2025 08:30:22 +0000
Message-ID: <f469eccfb2344a6098267a1ebd2a3eb6@realtek.com>
References: <TYCPR01MB84376878FE505F773182062B98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB84376878FE505F773182062B98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
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

Shengyu Qu <wiagn233@outlook.com> wrote:
>=20
> The current WED only supports 256 wcid, whereas mt7986 can support up to
> 512 entries, so firmware provides a rule to get sta_info by DA when wcid
> is set to 0x3ff by txd. Also, WED provides a register to overwrite txd
> wcid, that is, wcid[9:8] can be overwritten by 0x3 and wcid[7:0] is set
> to 0xff by host driver.
>=20
> However, firmware is unable to get sta_info from DA as DA !=3D RA for
> 4addr cases, so firmware and wifi host driver both use wcid (256 - 271)
> and (768 ~ 783) for sync up to get correct sta_info.
>=20
> Currently WDS+WED config is completely broken on MT7986/7981 devices if
> without this patch.
>=20
> Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>


