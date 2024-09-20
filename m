Return-Path: <linux-wireless+bounces-13032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A897CFFD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 04:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED251C227E3
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 02:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F55DF5C;
	Fri, 20 Sep 2024 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ow8c9BQB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D1C148
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 02:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726800958; cv=none; b=DZzDBlACFhzCgjtLDc2cNU6ggnq5vJY1PbuHAQap5OwMIDyzw7eovpUk5cphtemmdRTRkgwDNhSy9iLDjOYs1Q8X+IIQ+uQD+STY+o4BNSPveGHCekXnHOLEI0YTJTEeeY9qn+DTCvm9L2kSeUDKyD62NLBfS3GtdGLnYn6zBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726800958; c=relaxed/simple;
	bh=jSTG6fVdes6Mpely+BFttGEn6jOmz8aPMyVMMIjZxVg=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=ecAc17JaHIqmmHERKZk00rZNNnblzxZ7t2c0s1E8ZSxFe/pgtIX3aZI90ke872fc5wLuaQopab21txvvHxO7uBQG8KbqEOsWbDx+mLKvLMxwWSw6Z+QHHCZhwJEj8MMi/MefIoVXIl3fGZtTTeeMueeDXAblchV5s6t1f0zRhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ow8c9BQB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48K2trqE7459246, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726800953; bh=jSTG6fVdes6Mpely+BFttGEn6jOmz8aPMyVMMIjZxVg=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=Ow8c9BQBnZQOR1/+p3tzX1UjG5aujqA6NXASxqfka5MIWJ23rcVTQ8SYr9WLx8bJ4
	 NVpGG42cSBSywzBocva4MyB+v8I6rRNmzeGlV7X9dpoNxMV4+6/tgcO7qMvXiiK6VD
	 a73VlU0Hu8KOvcJtVv0ubuXVFIFmaCz7nxmIA6XUUjhatPAi2oSpCUqFW27YFDGr4J
	 IfmzVymcn5MVXekyzGrsa7k7nzOaHf8Bd3o8K9qRpTuBB9t0xcb0DUM3ooO/ieeDu3
	 tTkSu0eNv64DemMEj0s0wu1PBb/y11IB2WBi0esXKDr/oCLulgqOhn1iw+b6MKhMLJ
	 +N3ri5IuMUwBw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48K2trqE7459246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 10:55:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 10:55:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 20 Sep
 2024 10:55:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/5] wifi: rtw89: 8922a: rfk: enlarge TSSI timeout time to 20ms
In-Reply-To: <20240913071340.41822-2-pkshih@realtek.com>
References: <20240913071340.41822-1-pkshih@realtek.com> <20240913071340.41822-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <897bc8f2-e82b-41da-b7e1-6c9038519aa7@RTEXMBS04.realtek.com.tw>
Date: Fri, 20 Sep 2024 10:55:53 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Firmware needs more time to execute TSSI calibration command. Enlarge
> timeout time accordingly, otherwise driver throws messages:
> 
>    rtw89_8922ae 0000:03:00.0: failed to wait RF TSSI
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

2e8fd540c081 wifi: rtw89: 8922a: rfk: enlarge TSSI timeout time to 20ms
cd0d81d101b9 wifi: rtw89: 8922a: rfk: support firmware command RX DCK v1 format
8d445310ba61 wifi: rtw89: rfk: add firmware debug log of TSSI
6f540670456e wifi: rtw89: rfk: add firmware debug log of IQK
bd25f45f0896 wifi: rtw89: rfk: update firmware debug log of DACK to v2

---
https://github.com/pkshih/rtw.git


