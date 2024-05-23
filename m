Return-Path: <linux-wireless+bounces-7984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4A8CCB3C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D441C20B3F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11833086;
	Thu, 23 May 2024 03:41:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D6282E2
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435677; cv=none; b=RycXKD1iRJ/kdP3HxHeAnfjbOXCK6K0KIKI12jdFptyPFNmQssQJm1TKwedaTFoR5m9U7LrnkAqumDuFKokpMSv6cy399DnGPdzPGJ5vYXdCZfNGCFZV3H+tYS7xPo2khby6NLVdBq5s3lk9u9rO2HHV+HqeTtkUq+HveajovqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435677; c=relaxed/simple;
	bh=k6m+mRSOp61iUcmhKZUrQ5xxRn7QhGBfVXYrGJVMJgs=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=HO1rbH/Q/NJXVYjGgHwhdIIfEB9fJMYSFwp8MI7Vvcf996XjzeGnwMCPerHfcY4IS/AfoYW2FsPsiG8SPvlpLkR1CcoPEA5Pgfzvj4ia+S3EWwmW0f2EDz0eEFL35q8K7ucuVqAYIKHLOJoTm94NUvmVGf/ymknD1cKYqJdUVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44N3fC2m9470376, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44N3fC2m9470376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 11:41:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:41:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 23 May
 2024 11:41:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: correct hardware value of nominal packet padding for WiFi 7 chips
In-Reply-To: <20240517013639.11643-1-pkshih@realtek.com>
References: <20240517013639.11643-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c244db5c-cbf9-4218-9a4b-d5338f2dea0c@RTEXMBS04.realtek.com.tw>
Date: Thu, 23 May 2024 11:41:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The hardware value of 3 for WiFi 7 chips is padding 16 or 20us selected
> by hardware automatically. Correct the value to resolve interoperability
> problem. Also define enum to be more readable.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d5b96a4a3159 wifi: rtw89: correct hardware value of nominal packet padding for WiFi 7 chips

---
https://github.com/pkshih/rtw.git


