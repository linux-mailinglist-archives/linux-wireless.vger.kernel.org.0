Return-Path: <linux-wireless+bounces-26602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF3B350F5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4B81B24E4F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EA14A8B;
	Tue, 26 Aug 2025 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FZph9ykG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983691F3B9E
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171414; cv=none; b=MyYr7q/6+qryamT8nBpuHLglfA69j5cQBqOoHkZXj363onqmPVV7VzsS5HU5LPF9EfckjXlAlWgvEs5vM9HW68EttLUbGmDmUpIg+iQ4KVBtCxGDL+0D8DuXgxH9kBiWttwTQT4KCx7Ku5xLRfg8qPR1e60G6yW7levKILaGsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171414; c=relaxed/simple;
	bh=0IYUIwcz+U3qsSSstzKQAKZvRfKhKR1C4LZtiJFYn3Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Ajvp+ZhrtCBg5KSAArLctB/6WrcJmnlLlbawN2/1bE02O9hSo22i4qGf6NVFiUUH515ZjlIQ5OqwaeRFe/39t7tlw1vYo0ofJnNrm0AoINH72e9XeY5H4sQQxkRYM1gwcoSKzTtLc16c1/Hxkwvi/RIPux2XFQn35y4xS4rOwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FZph9ykG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q1NRcgC705201, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756171407; bh=blp9YTs8Rvv7rtToxXnazit9bcc9JKcxF2dM+Qaz6G4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=FZph9ykGmuHh3P30sIE3W/VXzboZQTLP+56Ow/ecnCiAJJn4Qo3iGZAFGvdBbTeFs
	 uQgYUrXPzjH+7Biun/NAnqQJceIvDJVITssddrjsr8BRCifhIQ5HMwKN09lot7i883
	 gwXGR2sK0MBZuIGTYO2zLMoUZ26+muY4xUiBLNlfQnUoglJX6Z0rneyKo7oh1qsLtG
	 aLgupTVESnOUrvcmznaj+oGjnPgXnVYjmw6UaPr1GVJugZgYqHTtcWZyynZEzTuQ57
	 y50cyCqThvOC6q+TzVkzp9S21aSAP8GATMxV5EU/qSoQT3L9Vd+TwsakwEfrHOzxau
	 ejeUX/zcF12Dw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q1NRcgC705201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 09:23:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 09:23:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 09:23:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <phhuang@realtek.com>
Subject: Re: [PATCH rtw-next 1/4] wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
In-Reply-To: <20250819034428.26307-2-pkshih@realtek.com>
References: <20250819034428.26307-1-pkshih@realtek.com> <20250819034428.26307-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d3943ebd-bc26-4c3b-bcdf-c2ead6f736a2@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 26 Aug 2025 09:23:27 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> To optimize roaming decisions, report per-channel noise levels
> during scans so supplicant can have a better view of the current
> channel condition. This allows it to prefer the APs operating on
> channels with lower noise levels.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

4367000c0e33 wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
f0f3bf4b370c wifi: rtw89: 8852a: report average RSSI to avoid unnecessary scanning
d47c1c6f321c wifi: rtw89: 8852c: update firmware crash trigger type for newer firmware
ebea22c7f1b2 wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch

---
https://github.com/pkshih/rtw.git


