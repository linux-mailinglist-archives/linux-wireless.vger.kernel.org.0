Return-Path: <linux-wireless+bounces-5142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF28866A0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 07:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE640B22A0A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B13BE4C;
	Fri, 22 Mar 2024 06:14:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACFC121
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088053; cv=none; b=O+M0LoSQEkwa0bGvCmzw2JHuFiB3A3TN7zipv+iMe73VGmOjkIOTRWLPPFEPzv4S4yQezAB13vhpX8V1b6XNyJwISkl3L08x8wLAFauYp0hsfxvIaXbp1M+YhZINCdUfI78xsjATsPEDMbB9Vc7elY9X5+g62qer4XgjCvmNOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088053; c=relaxed/simple;
	bh=N7ZYKtKr2G6xoECmnyYfuhX38bYEu0iq+eU/N8JU8ws=;
	h=From:To:CC:Subject:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=q2VQH1BFGRN9XFt/K641jDeG6n58iuBZXNgd+KXZ0IMJopTnNyWW9raIPApsnQ4Kbr+rgUnX6cfG8X41i+XYTdebS5qEx1FK912KTsnfBoW9OXtvN44y8rEHVlgIEk3UX7aCyyhou+v7V8TPXj6MobyD36UhPUCmmbjKVb6yDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M6Dp3Z21511682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M6Dp3Z21511682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:13:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 14:13:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 14:13:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 01/12] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com> 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e85ff026-b264-41bf-addf-d9da178f3cc5@RTEXMBS04.realtek.com.tw>
Date: Fri, 22 Mar 2024 14:13:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Different channels have different TX power settings. rtl8192de is using
> the TX power setting from the wrong channel in the 5 GHz band because
> _rtl92c_phy_get_rightchnlplace expects an array which includes all the
> channel numbers, but it's using an array which includes only the 5 GHz
> channel numbers.
> 
> Use the array channel_all (defined in rtl8192de/phy.c) instead of
> the incorrect channel5g (defined in core.c).
> 
> Tested only with rtl8192du, which will use the same TX power code.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

I have reviewed this patchset. Set patchset state to Changes Requested.

[v3,01/12] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
[v3,02/12] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
[v3,03/12] wifi: rtlwifi: Adjust rtl8192d-common for USB
[v3,04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
[v3,05/12] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
[v3,06/12] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
[v3,07/12] wifi: rtlwifi: Add rtl8192du/trx.{c,h}
[v3,08/12] wifi: rtlwifi: Add rtl8192du/rf.{c,h}
[v3,09/12] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
[v3,10/12] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
[v3,11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
[v3,12/12] wifi: rtlwifi: Enable the new rtl8192du driver

---
https://github.com/pkshih/rtw.git


