Return-Path: <linux-wireless+bounces-4644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6EB879F13
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF911F22520
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EABE26286;
	Tue, 12 Mar 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="Wor/gn2S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNxn49X3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF96D39
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283485; cv=none; b=jZsl9luk5tI2/Az8qLMJeS6VuGTQSEQhMJyE0Y061JYVRvI/YDnwTKfdMGXSRW9k7I0ce1nCMx3DVetCQPIyscwr3yvMT80kBn96jNsBh6xa9GIU7EFXE3RjkfMkEAYKxTqc3CIu+VMryBOLwhZ5pLbRH1vhFVSjnfauP1LQuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283485; c=relaxed/simple;
	bh=Vo5WxhL7YUoUDSjHOzaYuuqBEUJi4fHLafuFAu+2JuI=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=fnrx1iymrYpK9xPxvHZ7eF+FPw6476ZOVMLEFkYFrtFaQ7zuEnAGuoDfXFds9qHUclGgesBP0El0EEs6ISoY7JI5sSkmlkvBJ1pQRsQFxWrExtS1N1xWx22bmqDrgi2EpG2j0rupMBn98l5BlZ4VzrBwQbezPvgc8ufV35++20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=Wor/gn2S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNxn49X3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A0C1013800CB;
	Tue, 12 Mar 2024 18:44:42 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 18:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1710283482; x=1710369882; bh=fcor0Ekpu9hijxoFT1Wzj
	o/7fTl7DLMdXpdafme4vzM=; b=Wor/gn2SWOZo0kWn3f4dhnato0lay6Re9lXjr
	UjEtxVJp0TpPlSDlhI43pQiJO4ZjOjw8YdbnEYJOJ6sA1UuM9n5FBrxJKoZJjpgv
	JYg0yuZyom5jh1ukPipJsHdhMEKdLzv5sGD/xyOvKQIdHdcmDFg/AMA2Ib/dGMiI
	jP/7VsXNLfqitKmZoEbivd5vhP7Tc0tX+xcNz5x/15gWKTbvLeI+B6xP09w4WwAu
	ybS7sNYxabAZj0YcfMeLGv2uDkeYAI25Bngwy3JtP3G9Ow4Uxj8eDBjZJRreRmQZ
	EK0WTAR3AINZHqhjsjh6wrsYLSPbZ9/sCdWAPdD2EkpbvV9Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1710283482; x=1710369882; bh=fcor0Ekpu9hijxoFT1Wzjo/7fTl7DLMdXpd
	afme4vzM=; b=SNxn49X3eZJX86eFsmcIdQ+0+/+uFGXyccDZvc2gmCMD+sEVjze
	s8mbbQQFpHLnx0K2W7tktdnZl+XhNVrJG/ZsGs23rTX8PEK2bfpJ5H/KKQSEqjSW
	5zTzA1ZRBrTU2YCd1HKHLoysZbFaZ+WrJ+uwT/x175X0/oz4QX9Sfm6gKxCnUVZY
	47nu5S25zAFSEnlMp26PHCsP8pedWisHt6tKWqJmgzaWAgB2eHPPpGnY2usgkoYy
	XdZF/H5WeMIF7Cwy+Y908lhhi8lXyV8Oe9lwWPiEpG46uxEs822NfF6KBDxAjtbR
	8pkvPQst/QvcpdnjWKBb1t1huSdSRFZItNg==
X-ME-Sender: <xms:2trwZbXRTfgZ3mEz7Hej_tdSMzug8-76oNhY9Ii0e11jAnmLdKm7ZA>
    <xme:2trwZTkEXTTTpbG7vYDeMbuXs82KM8TIRAdrLViMYZ6SBInLVA1IoFMsbdVBa49bo
    UpeQ5GHdm-GKy4hKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvfevufgtsehttdertd
    erredtnecuhfhrohhmpedftfihrghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshht
    thhorghsthdrtghomheqnecuggftrfgrthhtvghrnhepiedtffduteffkedtkeehtefghf
    fhveffvdffueduiefhkeduieejveegvdekleefnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:2trwZXZaUifECbh2V_ogRDem8Qnrm3IN5fdFR_1RTCGF1mtfAYAbww>
    <xmx:2trwZWX0Abk9927j-20uDfI4O3iXHlzGNDa_y7e1DsA9KLpe_ip0mA>
    <xmx:2trwZVmRx6ZB3erkJjRvNomEId5Tp3fymhdlQeCwW6UN9x3tJ9u9VA>
    <xmx:2trwZTd1gfw1pZ4upv_Rwd9Mf2ghI2DSCjNbR_Is4HDuLUvgmu_chA>
    <xmx:2trwZbiqGPRCpJlxD7P0uzf0L7UVsSvk_KUwtilqkDZHTSbh5kEvJg>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EBB9FA60078; Tue, 12 Mar 2024 18:44:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
Date: Wed, 13 Mar 2024 11:42:44 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: pkshih@realtek.com, linux-wireless@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Subject: [BUG] RTL8821CS panic on entering power-save mode
Content-Type: text/plain

Hi,

I have an Allwinner-H700-based platform (Anbernic RG35XX+) which I am working on mainline u-boot/kernel support for. The RGL8821CS chip on this board works when configured with a 32MHz clock and 3.3v VCC and the RTW88 kernel driver, however the BT is unstable with extensive logging about LPS state entry failures, and the driver will eventually crash with the following:

[  830.797592] ------------[ cut here ]------------
[  830.802268] firmware failed to ack driver for entering Deep Power mode
[  830.808931] WARNING: CPU: 1 PID: 67 at drivers/net/wireless/realtek/rtw88/ps.c:105 rtw_power_mode_change+0x130/0x180 [rtw88_core]
[  830.820663] Modules linked in: btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress af_alg rtw88_8821cs rtw88_8821c 6
[  830.846661] CPU: 1 PID: 67 Comm: kworker/u16:4 Not tainted 6.8.0-rc7-next-20240308-00004-gee0f4864bb48 #8
[  830.856231] Hardware name: Anbernic RG35XX Plus (DT)
[  830.861198] Workqueue: phy0 rtw_watch_dog_work [rtw88_core]
[  830.866831] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  830.873796] pc : rtw_power_mode_change+0x130/0x180 [rtw88_core]
[  830.879763] lr : rtw_power_mode_change+0x130/0x180 [rtw88_core]
[  830.885730] sp : ffff800082fabcc0
[  830.889047] x29: ffff800082fabcc0 x28: 0000000000000000 x27: 0000000000000000
[  830.896192] x26: ffff00000e670900 x25: ffff0000042a2b80 x24: 0000000000000000
[  830.903337] x23: 0000000000000001 x22: 0000000000068dbc x21: 0000000000000000
[  830.910482] x20: 0000000000000000 x19: ffff00000e671fc0 x18: 0000000000000006
[  830.917627] x17: 0000000000000000 x16: 0000000000000080 x15: 076e076907720765
[  830.924772] x14: 0774076e07650720 x13: ffff8000825a26c0 x12: 0000000000000954
[  830.931916] x11: 000000000000031c x10: ffff8000825fa6c0 x9 : ffff8000825a26c0
[  830.939061] x8 : 00000000ffffefff x7 : ffff8000825fa6c0 x6 : 80000000fffff000
[  830.946205] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[  830.953348] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003264500
[  830.960493] Call trace:
[  830.962943]  rtw_power_mode_change+0x130/0x180 [rtw88_core]
[  830.968565]  rtw_sdio_deep_ps+0x8c/0xd8 [rtw88_sdio]
[  830.973547]  rtw_enter_lps+0xec/0x148 [rtw88_core]
[  830.978387]  rtw_watch_dog_work+0x298/0x2a4 [rtw88_core]
[  830.983746]  process_one_work+0x148/0x2a0
[  830.987771]  worker_thread+0x2fc/0x40c
[  830.991530]  kthread+0x110/0x114
[  830.994768]  ret_from_fork+0x10/0x20
[  830.998352] ---[ end trace 0000000000000000 ]---

FW version is 
[   12.561710] rtw_8821cs mmc1:0001:1: Firmware version 24.11.0, H2C version 12
[   13.471889] Bluetooth: hci0: RTL: fw version 0x75b8f098

Thanks,

Ryan

