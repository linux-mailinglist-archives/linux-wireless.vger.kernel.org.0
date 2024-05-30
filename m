Return-Path: <linux-wireless+bounces-8284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697E8D43D9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 04:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F701F23B33
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB58F4A;
	Thu, 30 May 2024 02:50:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F81BF31
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037444; cv=none; b=o1ZkWXpnrRehE0dHZVZyUgMMxD1X7psM7NbAYp58gBahqoT30TMaR2NAkTHkykjdP3izcnOJBTyX66GqUS0EZrSCN8lrYSyEP/pwk3SEMktk9xVG7tv454orTAGTwEFOfCT60YOoUNeJ2jGN3C+G891bEXJCtFJ13dHzB59RWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037444; c=relaxed/simple;
	bh=6rBSoLSYItIhI4IA52vFOh5r4RZwe9hbxn2NemIyCXQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=BnUPyEV1/UFWyeBmsf17crfKxVktkpeK60sohZNVmkL1ka8Hfb80D8OSvkqbv2hCqVahyT9yM+KA+LxgeFhfHoIFtLg7N60YsMhzEAVgd9Lh/kQWOl1EwMf4tFtQ5IBPnZCGq0XGc4fD0yIJpIW341hMtKtWBcf95z20nItKhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44U2oALe9209482, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44U2oALe9209482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 10:50:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 10:50:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 30 May
 2024 10:50:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v7 01/12] wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
In-Reply-To: <abe3624d-f986-4a24-966c-67defa962e3f@gmail.com>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com> <abe3624d-f986-4a24-966c-67defa962e3f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <465195a7-ac6c-4755-ace0-270a94cf5820@RTEXMBS04.realtek.com.tw>
Date: Thu, 30 May 2024 10:50:10 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some functions moved from rtl8192de still use the "rtl92de" prefix.
> Rename them.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

b21faf0edefc wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
ed4117567419 wifi: rtlwifi: Add rtl8192du/table.{c,h}
dc71f4e142df wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
e769c67105d3 wifi: rtlwifi: Add rtl8192du/hw.{c,h}
af46caf05152 wifi: rtlwifi: Add rtl8192du/phy.{c,h}
8321424134a4 wifi: rtlwifi: Add rtl8192du/trx.{c,h}
c0e4ae46ffa2 wifi: rtlwifi: Add rtl8192du/rf.{c,h}
91f43aee0b1a wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
3f8b94dbff7e wifi: rtlwifi: Add rtl8192du/dm.{c,h}
1d8b5003a55c wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
b5dc8873b6ff wifi: rtlwifi: Add rtl8192du/sw.c
59ea089dcba3 wifi: rtlwifi: Enable the new rtl8192du driver

---
https://github.com/pkshih/rtw.git


