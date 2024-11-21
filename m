Return-Path: <linux-wireless+bounces-15537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9219D451D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 01:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75584282BA2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993F2309A5;
	Thu, 21 Nov 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tLhdQAcT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF022F2A
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150131; cv=none; b=JIJFe6QUfTX3UKjy5bAqtKEbAJH5i0oX4GmOi1hhaeluGLfrOgWEDMoKQh0lX1Qa5ba7rj7VM7Wq0y0AGak12And00wrfb8fLG5ShcvHhyFC/7YHmKxOBgmQhXWaaxroG52fEW4TIxUX3o6rEX4TTXcOHf7y3PcIhZWB8dHjSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150131; c=relaxed/simple;
	bh=QkJZu5Nn7QM7A7H8cYeOIs2WP2aiHqRbcjhLV+DFBM4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=rGtwrKEskafU30pJ0JrgkFc57ltQs1/kKGuM6VFBnqSawx2fCb7zr77JWv3BKRDkuE9e3Rq0Jsyv3YRjOz1hf9e9kX4TSHK5Pgqcydj7uXZpYgECE+KKQ54kSKPvyhgk/Rw8HlgipTRBD1Ok33Uzu0m3daBEuKVaxpQ5MHmATws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tLhdQAcT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AL0mg9B3652415, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732150122; bh=QkJZu5Nn7QM7A7H8cYeOIs2WP2aiHqRbcjhLV+DFBM4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=tLhdQAcT8DA0wZxRhM9FVKC8vNyTzjknVmP7lqLY6e+fNlmYrfrEZRn0dVue7jTP2
	 M/AIolaHtLuM/7RB/5uIQ6onFcU8zpP0R88O13zRIq8QxPTyz0/6cPQ7ltwY4yLYRY
	 jUJ1iRBNG+2pWXW6sDxdBwIkQE01zT7uKlbnN9O8dsJSzJyibU/U7Q0mExTzGB2UXZ
	 fsUMhP2ThfeZ1IGbxWMH1Uhx1xQPh2uAjL2EggiyDUyZzWLkWN+X3XnqPc+zmTL1Lv
	 bECmY643wYPWVY4ULHVtbZIIk34EqmEGfUA9Qw11itoIikr4XRUWd0FhWZBLhMryhf
	 GN7NNWSJUbMQA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AL0mg9B3652415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 08:48:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 08:48:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Nov
 2024 08:48:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2 1/2] wifi: rtw88: usb: Support USB 3 with RTL8812AU
In-Reply-To: <19cda72b-f1f1-4b69-8369-0e4376b646bf@gmail.com>
References: <19cda72b-f1f1-4b69-8369-0e4376b646bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7e154488-70d1-4113-a79f-f8f4a2f835f4@RTEXMBS04.realtek.com.tw>
Date: Thu, 21 Nov 2024 08:48:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Add the function to automatically switch the RTL8812AU into USB 3 mode.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

82a35723a67c wifi: rtw88: usb: Support USB 3 with RTL8812AU
ce5dea83ee8f wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au

---
https://github.com/pkshih/rtw.git


