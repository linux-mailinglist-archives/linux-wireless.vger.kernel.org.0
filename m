Return-Path: <linux-wireless+bounces-5778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89891896280
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233B01F231EA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796586FC6;
	Wed,  3 Apr 2024 02:33:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EB4C92
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111627; cv=none; b=co67G91QQZAO0kF2Cf4oQL0keDz9FPIW7hpEQXySzP7m/nyPynEd4NnLj5HubhTDG28Ya8+NwPcOTmJrqdlkuog53IFuq1d0pFr7+Mrc3xdVTRwE7PRm8aw2d8/7B1ReCL2S7K680uRalW812Y3GhUCWSUQ3OYyGAYEr5ENQy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111627; c=relaxed/simple;
	bh=HZZaqdgMYR29ZS9HiZSmYE2dBiDU5fw7aRdPR5aSbr0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=fVRjS9DqbOuawVkSBpT9MWBC6uDy3ICG0AxT9FPyJoU7iN0qrFeFGO5ZB9bSrMVQSqZ4+EYFsdqUQmbNJGowU+AM0uqSUbxmIITJaaTrUXuF6i6NibzoCrRbyi0vhKcFPOZelxrtlqKQ9xlHq+BaLe4CxVonkqdlE2IgGDtLx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4332XeAaA432749, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4332XeAaA432749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 3 Apr 2024 10:33:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 10:33:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 10:33:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>
Subject: Re: [PATCH 1/3] wifi: rtw89: 8922a: update scan offload H2C fields
In-Reply-To: <20240328052656.18823-2-pkshih@realtek.com>
References: <20240328052656.18823-1-pkshih@realtek.com> <20240328052656.18823-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8d41370a-0f7b-4258-9fcb-2be59e6f988f@RTEXMBS04.realtek.com.tw>
Date: Wed, 3 Apr 2024 10:33:40 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Update scan offload H2C length to fit new FW format.
> This change is required after FW version 0.35.15.0. Since the first release
> of firmware is 0.35.18.0, we don't maintain backward compatibility.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

6599924c1c27 wifi: rtw89: 8922a: update scan offload H2C fields
e2e32a192ef1 wifi: rtw89: 8922a: download template probe requests for 6 GHz band
ef5d5c52d4a9 wifi: rtw89: 8922a: add beacon filter and CQM support

---
https://github.com/pkshih/rtw.git


