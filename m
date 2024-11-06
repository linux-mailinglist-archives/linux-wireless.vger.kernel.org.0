Return-Path: <linux-wireless+bounces-14958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441399BDED4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753F51C20A11
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D6192580;
	Wed,  6 Nov 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RZRLqXK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F7191494
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874363; cv=none; b=AINB4ZkBpL032eXh7XHRTwBUljpHa9CV4SH5nO6cMjIjznnpH5gJtf6gkD5cPE+3e/bcwqNsaFFAebmI82WzeUl5ZrDPDaNc0rmrIUrW6McmQpa9EG1QHDs+1OrRztsd+TJmAYLvCDDBLtZO/5AEUv0ch98K41sLBZlR1wWNE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874363; c=relaxed/simple;
	bh=8eKKe7cvRWMfzHer0OoRrBT6g1qBWYCKxNXW8w0Ks3A=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=mqcJK35xqcKHj8kyQL5VLl/5IR+0V1iL7qspOJgBSqcA+z/Z5tEgqhk8nh/Oo+kJtRAWcnfS7PE4iWwmJINW7KwPXy5HsokAJ+qITGsauZh9iySwuyqBGLHPu2ScPZAXB20zcuhCRLkADsLBst34ULznyA3QhYc4NH59SJWDyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RZRLqXK0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66PwCU22310187, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730874358; bh=8eKKe7cvRWMfzHer0OoRrBT6g1qBWYCKxNXW8w0Ks3A=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=RZRLqXK0ctVozfrc/UwVXhf4lXBRL9VjhUIsoMw5mOv4ZlhhQX4H7p6GHSUw0ZVnl
	 UWFiQUCcOhL3/hC1+x+XeSSZs7kbMAOOFxp0IDFCsXd+1b0snhqymg4nTme2xlB4wi
	 HfSPF2kuypL4YzKR51ZLOJiNo468n03dXK6k6XegyyFwSG+iRZPccGJYmB4PbI+umg
	 0Pzhchsw4mvr8QvXiVjxP6VLumklBkq7om+vFZqqAv/b8L+bcqOC0pdIredCeqHFRy
	 bZuLNRmPLrMZtZKRANy1hKEzXXjKSW1j9R0hakh/K6sdg5AKZNgbQnVBrHOp79ttLG
	 Z24/9FoDHJ8ew==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66PwCU22310187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 Nov 2024 14:25:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:25:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:25:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: 8852b: change RF mode to normal mode when set channel
In-Reply-To: <20241030091603.6073-1-pkshih@realtek.com>
References: <20241030091603.6073-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1f4d21f3-1ae0-4957-bfed-cd1d257646aa@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:25:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Set the RF mode from 0xA(low power mode) to 0x3(Normal mode) to avoid
> abnormal TX waveform in OFDM rate. Originally the RF mode will be changed
> to normal mode by the firmware after entering LPS once. Therefore, this
> change does not affect power saving.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

927f19c8efd7 wifi: rtw89: 8852b: change RF mode to normal mode when set channel

---
https://github.com/pkshih/rtw.git


