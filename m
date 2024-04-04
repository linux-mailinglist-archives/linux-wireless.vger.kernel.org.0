Return-Path: <linux-wireless+bounces-5857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729398982AF
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 10:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F94A1F22538
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5B57899;
	Thu,  4 Apr 2024 08:01:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36156B86
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217670; cv=none; b=lNG50okR9xqjTcm8KAkK6G3v1d5rGrpQq6v82XMROEfv4st1ptMy7uXP2LqGuLS1N1ZvcC2Pyf9kfAwNpvms5hLkrVWuljbGdkLl35T9XeCXBoe3KHPkJbikd/b8UwVek2vLtbqKgRdCfTu5E+psDANBrGSLJbkHtXzlD3tQiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217670; c=relaxed/simple;
	bh=yYRdnPdooSHQqxg5Gsp2P8Ym7L+j30WaxlA8Ky6vf2Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=E2RQv6wn/K5p/FBDlkgl7ROODIGplCILYG4wdP5BJKUWV6vYjEG5YLURIN+LfL4ee98hVbzUxI+E43ePqAZW5scLNmyhji9rSfH2DNdsI0RrGxTnRMSF8v2kbYEjSKJdHED2TeEssuPq8Qdwg5M1gloiZLqBlGDEiIdFQkMcjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 434814e641770135, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 434814e641770135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 4 Apr 2024 16:01:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:01:05 +0800
Received: from [127.0.1.1] (172.16.16.152) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 16:01:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: 8922a: configure UL MU/OFDMA power setting
In-Reply-To: <20240401063818.12880-1-pkshih@realtek.com>
References: <20240401063818.12880-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <16642a67-0ec2-46de-94b5-383678cbd8d8@RTEXMBS04.realtek.com.tw>
Date: Thu, 4 Apr 2024 16:01:04 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> 8922A needs to set UL MU/OFDMA power and fine tune power
> error tolerance for proper response to AP's trigger frame.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

155b10aba428 wifi: rtw89: 8922a: configure UL MU/OFDMA power setting

---
https://github.com/pkshih/rtw.git


