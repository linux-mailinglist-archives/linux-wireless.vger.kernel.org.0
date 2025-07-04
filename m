Return-Path: <linux-wireless+bounces-24804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F1AF857E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 04:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE96F4E7AAC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821BD433B1;
	Fri,  4 Jul 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aPVhR3fc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0E262A6;
	Fri,  4 Jul 2025 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595567; cv=none; b=khsCdN9ZKmvHsqD4OmBst0n40cWP8HcT9VjCLdG8TKWKVEM5oLmN0MDjSqts0fGPL6AQpf2G4MnJSaCtvRK6Txz7tUEZ6WbH4NK14s3YeLo90rqt32GMRZvyAGBmfpmPEbW5oDVrE+SHkioTaHp6WI+h1RKtMtmxtwaUwvglAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595567; c=relaxed/simple;
	bh=pX3F/Kr7D8p+GY/V6wBmiECrf64UH5cpbSxDV558fi0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=D9Um3+EUJANvAEM1966AOiB08twbcQtc1VWRfFIt+1VpKjsSzl7ccoL/QcDidEqqfr5jcwJdjaGIbDiUBUoON1XyC08BPmUOvVcZcsgFg1xvPBn5U3KnkKGBWAapDsW8prqQNyyBwO8fMx2VcORdD0PduGALWMx4draRx2dgGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aPVhR3fc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5642JCcW43569914, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751595552; bh=rThcDRjezbvk84SChZFvc18SFCF2YcEm2TSeu9WVMHE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=aPVhR3fc9O0uZWwaZhti+oec6SRvp/nB2N5T9g1uk3Jx2mc5IQn5gVV7PIELOfBpW
	 AmKycwplxFXvEh2aZYTK34VfxcLUDtOKiF0LfkDiPiqyVv3sYnR5YFrzXcfJ0GxPsB
	 f0eWv81KJndCkbDuS9HlzTuUZ7DBaT84bZFsxAJqe8yWjp6VZovBoHE4h2X99kJNOg
	 hZUUc9yfTopZlHjijM+BtePD8lSBPcIj4z0gUb/ShOuRXZsTja368BykZYWWsRMloI
	 mrdQAlX3TgNTgChcj+Gek40FHNJZFrvDk20HXyQBuyQaZuji1dNopcUH90ISYqLKKA
	 lmhqYqF/XjTbg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5642JCcW43569914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 10:19:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Jul 2025 10:19:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 4 Jul
 2025 10:19:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v2] wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags
In-Reply-To: <c68a8642c325f626ac34ccee71d9d9aa69f0c92c.1750733428.git.xiaopei01@kylinos.cn>
References: <c68a8642c325f626ac34ccee71d9d9aa69f0c92c.1750733428.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fd3ee551-396a-4b0c-8737-7db4b41e1059@RTEXMBS04.realtek.com.tw>
Date: Fri, 4 Jul 2025 10:19:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Pei Xiao <xiaopei01@kylinos.cn> wrote:

> This silences the following coccinelle warning:
>   WARNING: sum of probable bitmasks, consider |
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

34d9a2aa7f50 wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags

---
https://github.com/pkshih/rtw.git


