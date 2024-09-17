Return-Path: <linux-wireless+bounces-12902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC097AB42
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 08:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A141F22514
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A949634;
	Tue, 17 Sep 2024 06:05:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from IgnazServer.ignaz.org (IgnazServer.ignaz.org [37.252.120.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC94594D;
	Tue, 17 Sep 2024 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.252.120.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553139; cv=none; b=qwwhALryJS7M3tkACQJa5A2l0B9+lUoywSdyijKw+zZhqjsmHhpcUaWryq+F7/eM3APrnNl7TcqAB2yOW7wcsJqpVEgK3cFHL1Ebt3+L48iGTfQVl9VEtA8bzOFOixupf9DL43xPlTU8Q5tRrunLRhHl31Sq9NYAnEi57WmptEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553139; c=relaxed/simple;
	bh=Rr4Y2ybYGAWjCT9Yn8ZtwWVTKmY/yDpP3URlGCQIb5I=;
	h=From:To:Cc:Subject:Message-ID:Date:Content-Type:MIME-Version; b=EBpqpWRWAyDN/WwlsoQFf8WKPJwuQx2zSOriBSuGvyJLn5S7LowK0Biub2M2eWJGu5bXY72XbgM5Y2v9Y+QyWjB23t3GC+FwOCegQ8cTomii29qp6ErmNeo2EdBo2EYtafoi4Tnxa+srDuXMfWIc9R8atY/G1AyMFuTLXvIqYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org; spf=pass smtp.mailfrom=ignaz.org; arc=none smtp.client-ip=37.252.120.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ignaz.org
Received: from ignaz.org (localhost.localdomain [127.0.0.1])
	by IgnazServer.ignaz.org (IgnazServer) with ESMTPSA id 837D33FFBD;
	Tue, 17 Sep 2024 07:57:30 +0200 (CEST)
From: Marcel =?utf-8?b?V2Vpw59lbmJhY2g=?= <mweissenbach@ignaz.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: RTL8852BE wifi no longer working after 6.11 upgrade
Message-ID: <20240917055730.Horde.pVyI-XF1MRA_zUQ5BDJZ4lC@ignaz.org>
User-Agent: Horde Application Framework 5
Date: Tue, 17 Sep 2024 05:57:30 +0000
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there,
 
i upgraded my Archlinux testing setup from 6.10.9 to 6.11 and noticed that my wifi is no longer working. Here is the output from the working 6.10.x Kernel
 
04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller 
       Subsystem: AzureWave Device 5470 
       Kernel driver in use: rtw89_8852be 
       Kernel modules: rtw89_8852be
 
On 6.11, loading the Kernel Module fails.
 
After veryfing it is not an Archlinux issue by manually building the Kernel from kernel.org manually, i can verify, it happens with an vanilla Kernel too.
 
Here are the relevant parts from dmesg
[...]
[    4.687462] rtw89_8852be 0000:04:00.0: [ERR]FWDL path ready 
[    4.687472] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x23 
[    4.687477] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x83F0 = 0x70000 
[    4.687486] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687501] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687516] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f3b 
[    4.687531] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687546] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f3f 
[    4.687561] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687576] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f57 
[    4.687591] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687606] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4f 
[    4.687621] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687636] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdf 
[    4.687651] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687666] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f37 
[    4.687681] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    4.687696] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f53 
[    6.376153] rtw89_8852be 0000:04:00.0: [ERR]FWDL path ready 
[    6.376163] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x23 
[    6.376168] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x83F0 = 0x70000 
[    6.376178] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4b 
[    6.376193] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f43 
[    6.376208] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4b 
[    6.376223] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f41 
[    6.376238] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f3f 
[    6.376253] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    6.376268] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    6.376283] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f57 
[    6.376298] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f47 
[    6.376313] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    6.376327] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    6.376342] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdf 
[    6.376357] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f35 
[    6.376372] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    6.376387] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    7.135332] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow control off 
[    8.097173] rtw89_8852be 0000:04:00.0: [ERR]FWDL path ready 
[    8.097183] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x23 
[    8.097188] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x83F0 = 0x70000 
[    8.097197] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f53 
[    8.097212] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4b 
[    8.097227] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    8.097242] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f2f 
[    8.097257] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4b 
[    8.097272] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    8.097287] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    8.097302] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f31 
[    8.097317] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f33 
[    8.097332] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f33 
[    8.097347] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdb 
[    8.097362] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f33 
[    8.097377] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    8.097391] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    8.097406] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdb 
[    9.817051] rtw89_8852be 0000:04:00.0: [ERR]FWDL path ready 
[    9.817059] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x23 
[    9.817063] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x83F0 = 0x70000 
[    9.817072] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    9.817087] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    9.817102] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdf 
[    9.817117] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdf 
[    9.817133] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccf7 
[    9.817147] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f3d 
[    9.817162] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f35 
[    9.817177] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    9.817192] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    9.817207] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[    9.817222] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f55 
[    9.817237] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f53 
[    9.817252] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f47 
[    9.817267] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f47 
[    9.817282] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[   11.536604] rtw89_8852be 0000:04:00.0: [ERR]FWDL path ready 
[   11.536615] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x23 
[   11.536621] rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x83F0 = 0x70000 
[   11.536632] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f35 
[   11.536648] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f55 
[   11.536664] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890cce1 
[   11.536680] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f7f 
[   11.536697] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[   11.536713] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890cce3 
[   11.536730] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f31 
[   11.536746] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[   11.536762] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4b 
[   11.536778] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f35 
[   11.536794] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f47 
[   11.536809] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[   11.536825] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f47 
[   11.536842] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f57 
[   11.536859] rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9 
[   11.536874] rtw89_8852be 0000:04:00.0: failed to setup chip information 
[   11.537455] rtw89_8852be 0000:04:00.0: probe with driver rtw89_8852be failed with error -110
[...]
 
The whole dmesg can be found here (with an Download button on the top right): https://ignaz.org/nextcloud/index.php/s/gMtZCxS5wjtWSYc
 
 
 
Best Regards
Marcel
 
#regzbot introduced: v6.10.9..v6.11

