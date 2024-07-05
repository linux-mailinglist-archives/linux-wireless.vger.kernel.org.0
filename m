Return-Path: <linux-wireless+bounces-9999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F766928007
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 04:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DDF1F224A5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA5FC11;
	Fri,  5 Jul 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fvWn2H+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A171B950;
	Fri,  5 Jul 2024 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145168; cv=none; b=FzKHSZ0F6Ek0SFWRis44z3x1d5n9ktiNUwd6PIDjaTRqaUuJKTdwWqjo7E1uoYhDMPSDzZc22fsPFwjQsahIRPKGze/e6isLznY5FBWpYGYEMj4x/bJnk/Ju2LOCNlwujMsYXzI0X76NivkNCXetMnDGwFF6wKqVgjniAa1swGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145168; c=relaxed/simple;
	bh=Pb3NJouw4vk9PNYWD40KEFnW2e3GX2Bd4h7TAepauvU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=hW16jvvRRuMhRHIRzf4TCxNNYGkCq0T8RpoiTniKbUdm9KlIu+sBp2d2agBMkJKWoZ4M1YfA6aAiJyv5DwFOFD5ang1MIlce5odzO+bCuFSFMODcq0YuuJuw3IS6mR5V3FD00S8IXN/tpoptA6x3iL/z8pCxJGUqmQ6glcyRyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=fail (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fvWn2H+T reason="key not found in DNS"; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46524wPM24099883, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720145098; bh=Pb3NJouw4vk9PNYWD40KEFnW2e3GX2Bd4h7TAepauvU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=fvWn2H+TW1RKKEgsMqTP1AW9uAnHzLViPF84l/CUGgyn9V5zuYrdQQFdGgFPG8rdH
	 ezxOymAhT6cW+9Ld9CjVlVeZuxkD2TiXg49fgB3PjpFzsVEFyJzipGXSCYjkfnDVqT
	 LaNSf6pqQ/pis2y6FSOJEYP4PNsEkyPO1d4tbvLS8Y+jcmQUombKpuXMe9w+hzWgHD
	 WBPskzzpmYzIL3k2mYvlC2Tei0IakX4iNPf0FbKIfscb6QP686ELFrWUmswVFMiiF4
	 MDoI0UeQwhDEN8ktSpcrEpG3qlBRRVnTurzCc+DP9v5H3Ec2QWJ/Gf1a1VS4mFnr0F
	 8A0NUfzWp6Miw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46524wPM24099883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 10:04:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 10:04:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Jul
 2024 10:04:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Aleksandr Mishin <amishin@t-argos.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()
In-Reply-To: <20240703210510.11089-1-amishin@t-argos.ru>
References: <20240703210510.11089-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <865e1d0b-72fd-4c9f-8160-07b205681a10@RTEXMBS04.realtek.com.tw>
Date: Fri, 5 Jul 2024 10:04:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Aleksandr Mishin <amishin@t-argos.ru> wrote:

> In rtw89_sta_info_get_iter() 'status->he_gi' is compared to array size.
> But then 'rate->he_gi' is used as array index instead of 'status->he_gi'.
> This can lead to go beyond array boundaries in case of 'rate->he_gi' is
> not equal to 'status->he_gi' and is bigger than array size. Looks like
> "copy-paste" mistake.
> 
> Fix this mistake by replacing 'rate->he_gi' with 'status->he_gi'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

85099c7ce4f9 wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()

---
https://github.com/pkshih/rtw.git


