Return-Path: <linux-wireless+bounces-14844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D779BA534
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AA2281E68
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BB1448E3;
	Sun,  3 Nov 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="lybmVG6N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCD16E86F;
	Sun,  3 Nov 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730631701; cv=none; b=IUmVN1mRjVTXmE2Ey1mK2vI0b4uTyFvJ0QICVxJ/uHELURoCvPicl9WUQEb8tLiLAMxk9hIRgePOXKEUWGtuKyPX5Zc/qCJmiAx4D71xzt/AA51Aq0cmk1qZa4pmuHP8dgcWmQzzsrPWvMyOVEjgVPj1bJO+X1dTPqyrBavbXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730631701; c=relaxed/simple;
	bh=+wsgetk5/sonAYIBPou7wSVPc/FmkisVd5K5rj9Vc88=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ViVZugJg7jPbDgqlG5JLDstAsZqLJKt9wm4f0420Sr2WEcI8F2P3XT+pU8qtNNyBkfUBeTOcNfaMZgB0HZJw9cgbWMSuRJHbMRTLgRMI+0QBIJ1zieXW0RopUtc23pGaLgkDXOCCFFYm7p6d9nxrwZZFDgf58BDIxOvpXliZB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=lybmVG6N; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730631691; x=1731236491; i=wahrenst@gmx.net;
	bh=+wsgetk5/sonAYIBPou7wSVPc/FmkisVd5K5rj9Vc88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lybmVG6N6PFBRvqOVzHGGRHjPqWzctv/x/qTaAsfSJt4VZt56MnAU6nvYPKUewN4
	 lW+n99Vfo499qu5Iz/m13QzWslJ9kUarO9hNKFvYiU58oF+hAb/VyjsjJRvoUymzW
	 n5tNlJcf2+ktS78Q037/7WpHv9SQY+eWdP56Z7jDI0Nv9j/vJWd9nage4yhjl5acL
	 HwXvzf6bP6zruX3/nzmd4zeZlD2zkPi+ced3uuEpu+CPigYjtJqIf343ylavnL9zK
	 lZq66sgFXrC8HVvOHQ4yhqMm2C4HXi2xTwipYq+AxwA1NNeLFj9kGvroQW2sNw7id
	 3+sWajszsbVKzvKpRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1u3tiA45j2-00qqmf; Sun, 03
 Nov 2024 12:01:31 +0100
Message-ID: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
Date: Sun, 3 Nov 2024 12:01:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Subject: brcmfmac: error messages while entering suspend
To: Arend van Spriel <aspriel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 SHA-cyfmac-dev-list@infineon.com, Kalle Valo <kvalo@kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ScJX5vdiGXdW9kUo7g4BFBr602OvFdMP1SUxDBuqk/XBnj+Cig
 ThLXQFAUmwHgB5RLJVinczDijot4P1zqdkq97hu2W9TWpm2iM8v0sq/l5LVakeZ2844g8C/
 9yoN2cDotesf4aIPhu9AH1uQ3xwunm17uHOVwWxOG8x8o9qg4jpFkU5taaIra9RIDqyFwB3
 UByg+b13HM8lOEP9H413A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rtgKeTex454=;EMSWUCt74aDLX75m6SrPwZofiVd
 GniyW8sczTVu/EkhY9SySfkACpeMGiL1tbCww8X9VkFfL+mz5Ka3htqRD07u8/mbh4WeS+7Ad
 oYEROJXcsATgYSVe89G3uUdgZKQnMVa+P81cNdqjbAREPU2rJa5jm7VIT1e3zN7OwUeN8ukL5
 QJ2Ck5XYMYB2JBkUJkUt+xL/a2ZmnCjTGui3yIbviQZuL7wN48X7QzmbqFFu39BuhDxYYwKIv
 3Rx6XFzFdNke3tcGoW9IJzqPCuudx6Ds5sS5sxIK2mbrvkoSQQcpFATjFKMkoaIumPFjj0da/
 rAse7ytMp5yHnOLt9ir9xeXJAl/YpZTQfp5z6lCipvcKQQVdtrnZrwPrUKejzjCaLiv/WSnlx
 6ZoIAoYHhXav0jwKwjds+pmS3AQsQModmwMBqh5VlyiEyW4EwdUpnj5eP3MZ1eoUj2sTrd+SA
 Yi4hzWhy6QD+usHXh5+2QG6hnpRmc7WS9fekUOVkdn/EcULGzJbANbSGAEe5cqtiLpNIjD+bF
 1Ox8aytXKZrx3CCNDHXUki9OWT4EqKlCAmP0QiRy5KPgWhM1j09YH9W5FUuAu9aWbkafDgRls
 ydJ6iXp0anXleTlTLe7P+/UX6MFNs4Th8YMYzXXIFlauLq0Yv97oPl1d+DXxlm0vM60ygsFPq
 UzJ9IEA03SH/xFbLFLiWawSsVpla2mzYfF1NLEmLeoQOEQDAh1DaCbJySGQGlMeyn2Kafw/qW
 KgWdobnpygkRgp7I2efCQB+RvvxV7XRANW1n9qJA4DpD8rNFtdmx2ID3O/H2o3eFTMooUiu9I
 eSvtdZXV12+b1m85dtRtG1Cg==

Hi,
I'm currently working on s2idle support for Raspberry Pi 3B+ (BCM43455
SDIO). During the tests with I noticed harmless, but annoying error
messages from brcmfmac like this:

[=C2=A0 383.186640] PM: suspend entry (s2idle)
[=C2=A0 383.190107] Filesystems sync: 0.003 seconds
[=C2=A0 383.247470] Freezing user space processes
[=C2=A0 383.250291] Freezing user space processes completed (elapsed 0.002
seconds)
[=C2=A0 383.250379] OOM killer disabled.
[=C2=A0 383.250385] Freezing remaining freezable tasks
[=C2=A0 383.251677] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
[=C2=A0 384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. we ha=
ve
nothing to do.
[=C2=A0 384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: error (-5=
)

These errors are not new and I assume they have always been there. I'm
not an expert here, so I want to know is the problem here that the SDIO
interface is shutdown before brcmfmac is suspended or lies the issue
within brcmfmac suspend itself?

Here is a calltrace for the error above:

[=C2=A0 384.291308]=C2=A0 brcmf_fil_cmd_data+0xe0/0x114 [brcmfmac] (P)
[=C2=A0 384.291347]=C2=A0 brcmf_fil_iovar_data_get+0xcc/0x134 [brcmfmac] (=
L)
[=C2=A0 384.291384]=C2=A0 brcmf_fil_iovar_data_get+0xcc/0x134 [brcmfmac]
[=C2=A0 384.291420]=C2=A0 brcmf_cfg80211_get_tx_power+0x58/0xd4 [brcmfmac]
[=C2=A0 384.291458]=C2=A0 nl80211_send_iface+0x1e8/0x584 [cfg80211]
[=C2=A0 384.291549]=C2=A0 nl80211_notify_iface+0x58/0xd4 [cfg80211]
[=C2=A0 384.291615]=C2=A0 _cfg80211_unregister_wdev+0x40/0x27c [cfg80211]
[=C2=A0 384.291682]=C2=A0 cfg80211_unregister_wdev+0x14/0x20 [cfg80211]
[=C2=A0 384.291748]=C2=A0 brcmf_p2p_ifp_removed+0x6c/0x98 [brcmfmac]
[=C2=A0 384.291785]=C2=A0 brcmf_remove_interface+0x170/0x1ec [brcmfmac]
[=C2=A0 384.291822]=C2=A0 brcmf_detach+0x60/0xfc [brcmfmac]
[=C2=A0 384.291859]=C2=A0 brcmf_sdio_remove+0x4c/0x188 [brcmfmac]
[=C2=A0 384.291896]=C2=A0 brcmf_sdiod_remove+0x24/0xa4 [brcmfmac]
[=C2=A0 384.291933]=C2=A0 brcmf_ops_sdio_suspend+0x100/0x1c8 [brcmfmac]
[=C2=A0 384.291971]=C2=A0 pm_generic_suspend+0x2c/0x44
[=C2=A0 384.291982]=C2=A0 dpm_run_callback.constprop.0+0x74/0x134
[=C2=A0 384.291993]=C2=A0 device_suspend+0x110/0x3d0
[=C2=A0 384.292002]=C2=A0 async_suspend+0x24/0x3c
[=C2=A0 384.292012]=C2=A0 async_run_entry_fn+0x34/0xe0
[=C2=A0 384.292022]=C2=A0 process_one_work+0x150/0x294
[=C2=A0 384.292032]=C2=A0 worker_thread+0x2dc/0x3dc
[=C2=A0 384.292041]=C2=A0 kthread+0x118/0x11c
[=C2=A0 384.292049]=C2=A0 ret_from_fork+0x10/0x20

Best regards

