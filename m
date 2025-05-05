Return-Path: <linux-wireless+bounces-22422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E745AA8AF6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 03:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8716C189005A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 01:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47864191F84;
	Mon,  5 May 2025 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jJx0qjJC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D8A957
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746410304; cv=none; b=DwXVp7VZuGHF/R7l3ruJx6cPy4HTyH2KISWoUmqx0Kp1jqy/CfWQHDgxeJeMGCakuwipfCAxeyKU+iyu273k3Oz/GWOd+fnhb/Aqjk/2ZrB2BOTJ7JaKFctnfKzFNWv8nZXJRrfkjBhqoKUmfe4OhEEi3X0sU+ln5WPk/likol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746410304; c=relaxed/simple;
	bh=8GXMiKbJmjDFU5FXwbDKo3VSA55qdq6JcQJ1hjlqDZ0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=QqJ2r5U15q+OqcgPWRVaRj5cPPjJmJza7c6tpFr0SaQbtHT3WJCjt/opUrnXkHvvSDvt076SKZ9EDNTmnf0If4MeyzWDRcm9k720qIVWGtxC5iRHTmd9LX3BZxNgTXSUTayVeu3QvXSFhdKsD1CJQOZE0/KXwAHZwEh8qxu3tRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jJx0qjJC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5451wJRg93401130, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746410299; bh=8GXMiKbJmjDFU5FXwbDKo3VSA55qdq6JcQJ1hjlqDZ0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=jJx0qjJCW6yiTDNABIziTi1Vy55zrKyhxi+jJ0oshuon2hhaMxdjf+bSTcTwyqmlo
	 ru8ZXwXW496BwbBHqM2DrPgRLkYSjG0dC/WrXOr9cwWywd3SDc8e6yMIO4odJfgVLE
	 mN8egWXU9z5nV2WpmsaoUTLG9g0BjyddgQ6tUVGJWMTCNyKs56AsSiiTcT5WOLeNIk
	 2PRsMR5Ra/6IPwMkrN74Ljsvtd/LFoDTunn4lF51cEQOiSg4U+pYe+pIvnpLqg6dPr
	 3rvcstohof6KQuXZuY8h9END3Eo1nml/sFCtW/9MlxRXsh9LUFbWsPViUv/UnkUi7u
	 XRqn60OQsqR4g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5451wJRg93401130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 09:58:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 09:58:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 09:58:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/10] wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK
In-Reply-To: <20250428112456.13165-2-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com> <20250428112456.13165-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <64b7f579-0357-4933-8f52-9bc290e72d7f@RTEXMBS04.realtek.com.tw>
Date: Mon, 5 May 2025 09:58:19 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The RX DCK in firmware could retry 3 times if calibration value is not
> stable. Roughly each calibration can be done within 16 ms, so expect
> 16 * 4 (with additional 16 ms) will be enough. More, in coming MLO, it
> will do calibration on two path, so multiply 2.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

b47e250e593e wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK
372559788161 wifi: rtw89: 8922a: use SW CRYPTO when broadcast in MLO mode
e6512916eeb1 wifi: rtw89: Adjust management queue mapping for [MLO, HW-1]
6d9e16a961a3 wifi: rtw89: extend mapping from Qsel to DMA ch for MLO
667231dfea08 wifi: rtw89: Configure scan band when mlo_dbcc_mode changes
8bb7dfa6b5b9 wifi: rtw89: extend join_info H2C command for MLO fields
9f1aa1054d80 wifi: rtw89: add MLD capabilities declaration
6173b636c722 wifi: rtw89: Fill in correct Rx link ID for MLO
d0e6c18fff72 wifi: rtw89: roc: dynamically handle link id and link instance index
c3dded779137 wifi: rtw89: introduce helper to get designated link for MLO

---
https://github.com/pkshih/rtw.git


