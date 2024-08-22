Return-Path: <linux-wireless+bounces-11777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AA95AB2F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 04:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022641F26116
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 02:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8BD179AE;
	Thu, 22 Aug 2024 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cPE3xttL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE04182DF
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294731; cv=none; b=S5HqwMgGfgsSLHZ2oVpqEVCLrjfV7ZZ+wgHvOqW9xVo4Nob1pxAjtgy7Co4YdAFOD5TN+U8R3F3rbR7hWX6YtuUu3CsIkXSosgQ3CU890SR/gDXj135faAlm19wXFvo7GhzGOTkDNbqEYmycrOjuZDATuCdwPimgrHQxmzK+61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294731; c=relaxed/simple;
	bh=OMNdQOpVQCx++X8aG8HGGv0N/bQXz5kqW8xisnlqf5Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=IUwr6vkPJq7YGOfxz4IEB8HXSwI7mTCaH4QQVf9omQsjGeh01pEkHsKGuix6cxzGDlpQqwD7aICQxNXABndUdmmWv6w5lXEoCaMHU6xTk1QGq7v/zIwnSe+c5t3HMFdZJiP4d8PAQSxGi8z6/CD0mLxizBwqnaDIk1BXBp/skEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cPE3xttL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M2jOO313471089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724294724; bh=OMNdQOpVQCx++X8aG8HGGv0N/bQXz5kqW8xisnlqf5Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=cPE3xttLzZ9kz7+IxvWt3JZlNt2sSp479P+uKa0hbgR2Cs/NilS+e34/VCWcSm2lu
	 8P5vXzTIpu7btcTwz/6qlJ5ncCmZfCxjdDA1BoBhQV+R2MyEsHtzAbcUznjpRhQLuq
	 S4a7ATixBu25OszCNkFdbRGrbM+N/f3n1yI5EHRIk9OBaSfH5QPfJWnlZIsqcakklr
	 pLDB+HEsM3ZAA3zaTjaRmy6Op+gxsKY4QjGVDXPAVOVYEgdtEDHXU744LgFNTU5eHK
	 1dxM5p+rrjHdcwGOzYa8hJbgwGaXVNz4LXFEabR/ONF2EXyqEjMY5Ru8vGo1Ncl9z3
	 hjzboKT6EOFwA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M2jOO313471089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:45:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 10:45:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 10:45:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0 for RTL8852BT
In-Reply-To: <20240816124614.25592-2-pkshih@realtek.com>
References: <20240816124614.25592-1-pkshih@realtek.com> <20240816124614.25592-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <be4514c8-e1f0-4d1b-984f-161a73a5c4d2@RTEXMBS04.realtek.com.tw>
Date: Thu, 22 Aug 2024 10:45:24 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Add the firmware related version code for RTL8852BT version 0.29.90.0.
> And add the version 7 report control structure format. Firmware will
> collect counters like mailbox count, RF on/off count, and some Bluetooth
> related counters into this structure and pass to driver periodically.
> It will help to understand how the firmware mechanism working.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

2c29f70b3884 wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0 for RTL8852BT
e43175dc045d wifi: rtw89: coex: Update Wi-Fi role info version 7
b0923d48529c wifi: rtw89: coex: Bluetooth hopping map for Wi-Fi role version 7
6833337585dd wifi: rtw89: coex: Add new Wi-Fi role format condition for function using

---
https://github.com/pkshih/rtw.git


