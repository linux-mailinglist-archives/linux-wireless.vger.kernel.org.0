Return-Path: <linux-wireless+bounces-24404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88492AE5D17
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A4F3A4F69
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14042065;
	Tue, 24 Jun 2025 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lFEGNCXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98423C8A0
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747650; cv=none; b=aa2fg3fMk8CwGsRiAZTPvubvVRnGeTUyVWG+EGT8g/7iIEXkPiTlV08UPmVmuGhuwg27zZBVTcu2ml08evlSDQ/Il5gMUZ3r+iVZF4jI7szu2GXPXOt03zucDp3xEE46IE9XacCX4qEACaWPPFoeK6SE3bQUybH6hOrToyNYNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747650; c=relaxed/simple;
	bh=8FT3wFh23WXufYi2fkl1GHFEnwJmwnnVpxszX2W+nLM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=JiDnW4yWY2Qx17tV2EJAf8RQ8q0z/oxrqofJ4AeOSbQXxdZVi2IfUqO/TzBhZnH6lx+w+gbjU2/EL7kEV8QgK0caHhUDU+1GpKPVFlHZVebsVuPptwTp6SkqhFePdyOVRztnVvbBtrYR9UtW1sgCmRfBrcqURs2fFPZjNsZMUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lFEGNCXL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O6lOaH53180034, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750747644; bh=7fBOfeWZKHkwMEbztBP8srMDV3K8vykwLvy2UPTtGmY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=lFEGNCXLM0KjrZwUrOzRXkOC7WC2qeBqsHQNcIomlTjoSj3Nh9HW3bOlFfZ2rLbzA
	 /LuAuXq/9Y9bPEVuE8+csIhbB8Hsu18kroHbpWqc1aO4/Ai0XdD6LbzOiyfgVHH7JK
	 L6Az1qi3NYbcllEY9zK0TFeA6GZwCaH2Pft18Kb+98QtLFrBHfnw80dYY+PYTSvVRX
	 CltRKy7zStB5YRFDNt9Z+bJ9j7VvxQq3lsNDch+pdxy/FDCnyUHNUGg1jSkJk4g7N3
	 NVO8ed+q9Z5y6+nEqg+sK5ZApZCKUImczlgnAkIyvW5er9IJDrgEhqOES9XD2lwMET
	 EikW7OzbrAE8A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O6lOaH53180034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:47:24 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 14:47:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Jun
 2025 14:47:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/6] wifi: rtw89: mac: differentiate mem_page_size by chip generation
In-Reply-To: <20250618124649.11436-2-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com> <20250618124649.11436-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0bb7def2-fabd-435b-bbb9-ccda4f917ef8@RTEXDAG02.realtek.com.tw>
Date: Tue, 24 Jun 2025 14:47:37 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> When debugging or recovering system error recovery (SER), it's
> necessary to dump internal memory to perform status inspection.
> Since the memory page size differs between WiFi 6 and 7 chips,
> define them accordingly.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

9c5c5a920a79 wifi: rtw89: mac: differentiate mem_page_size by chip generation
8408366f61a7 wifi: rtw89: update EDCCA report for subband 40M/80M/sub-20M
640c27b2e0c5 wifi: rtw89: correct length for IE18/19 PHY report and IE parser
7e04f01bb94f wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band
c2852b5a0575 wifi: rtw89: report boottime of receiving beacon and probe response

---
https://github.com/pkshih/rtw.git


