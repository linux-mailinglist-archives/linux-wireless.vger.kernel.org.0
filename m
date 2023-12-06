Return-Path: <linux-wireless+bounces-507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7938078E5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 20:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD88F1F211F4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783F47F6D;
	Wed,  6 Dec 2023 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="oSU146QX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370FFD3
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1701892290; x=1702151490;
	bh=9bnUt4mQN0sRHuHZE/bBNs8Z6MZSXk16CG08Vf2hXjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oSU146QXFS+PhvtrMroC6/bnYa4wLzuCKzLmcWr3Ckb0yPjIhj+khldB9XV4QqEgR
	 NjeUloT2t+poIcLfYkoLEBX/3UWl2lKnkQXfHm62H2OXO/dspJpaFf2ookn25RqwZZ
	 U7OtrEhXVIjm4jahmkWiKQTPyteVt0edv3hKukF5i0f+P2GSuWcX82e+f/65Xr/l6H
	 vSwtZgvmfGSHJv/yNNlffCpJS3C2EAgPWhSLJHCZila+KY8cQNFCLrFnvvndsvIs+c
	 y763KJlfIJi4wadS+kWRNFQskL2E0loDvigStgUAA/b2WUy3heLVwHvH0XziUN0Ee1
	 TBNQiZ1725JPg==
Date: Wed, 06 Dec 2023 19:51:19 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <QGXUDgc-RbYOKRZYX_gp7uyKz_WQ4_6b_R9c4Qyd-3oEd4V_vluPJtyJfVqpvcF5kKQ3Ffr3cVXmxAY3jPYQwKSBrusexYYFIPfHJ1qtFPI=@protonmail.com>
In-Reply-To: <20231126142634.3a100e2c@kernel.org>
References: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com> <20231126142634.3a100e2c@kernel.org>
Feedback-ID: 27475468:user:proton
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[RESEND I've made a mistake with list of recipients]

Update:

I've built and installed mt7601Usta vendor driver, which is shown into lsmo=
d output.

ra0 interface appears as shown in the following output from iwconfig and if=
config:

ra0       Ralink STA  ESSID:""
          Mode:Auto  Frequency=3D2.412 GHz  Access Point: Not-Associated
          Bit Rate:1 Mb/s
          RTS thr:off   Fragment thr:off
          Link Quality=3D10/100  Signal level:0 dBm  Noise level:0 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0


ra0       Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisioni:0 txqueuelen:1000
          Byte RX:0 (0.0 B)  Byte TX:0 (0.0 B)

The driver is properly loaded and the device doesn't connect/disconnect con=
tinuously as instead happens in mainline driver:

Bus 001 Device 007: ID 148f:7601 Ralink Technology, Corp.
    |__ Port 3: Dev 7, If 0, Class=3Dvend., Driver=3Drt2870, 480M

Any thoughts?

Waiting for a reply,

Cristian.

