Return-Path: <linux-wireless+bounces-28818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90CC4B2F1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8B13B66AE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2DE346784;
	Tue, 11 Nov 2025 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gj+GVmso"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693823446BB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827084; cv=none; b=kE0D0oicMUr5posqac43vA76tFLJMqFjkpFmmc4hSbWjy1wkxa3LCAk1ZRHHLLmB13OsO2Rhzhbp1yo58gJGLA37f7PI8lbJor+T++pI0yrYoip3D+xpy7p3CP0ykuA6xBOKAAnnlyqRraRGzh6dtsjA8Wpt/viQpSLvnw/VKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827084; c=relaxed/simple;
	bh=vrDXGqyDTeaJAoYiqGUcFlJliNguEFX7yLfQ4FOjJA0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=iqXutC97+0kLNPQFE6z+ihrbIrQ4v9X6GA8IFeD87pwm4XpfZqpPrGd6Ru2B12L6a9XEFEtEf7mi5gFk8eUdFDeNmVlT1w4fE2cZcsNpdGg6HjhGF8INaXi4tABS1EgftPN5THS1sTqX6/u2r+8Zl8Aqy0DnReI4FWFSy7grlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gj+GVmso; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2BGYP02891316, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827076; bh=SvAIF7zAOcyUBpMnvnwiN8FkVRwnMLSsjmGmWzAQ8+M=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=gj+GVmsoGaU0DhZ8f2gdhphu+eoAO8EEtbaADl5sqCyhr6Q0cxWWEDUXNQq7be6IN
	 98XxcvmPBMEFmM1ILzRJ0QuHuhxVQfcUlQ3oN/SM975RFurbDXgPT4vTF5fcVm9c16
	 XdRbOkvqJxd4XGHFIwvFtTiM5pBRWNFmG7X4LfyGK9YWL/RH7NfZlJpaghDWtnvzxS
	 j26TJnKk30bxaOjldWbXvmx1Fq23lz9yTlgYRuD9kN8IqsOCyCyEg4+jgP3UM1fm14
	 WGgNyLB8STOO7Qdywte4gcbWaLef2anrdtIRy423tosu4vrX+TLJWdncYxefywsBLC
	 wHdvoF6gXqJeg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2BGYP02891316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 10:11:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:11:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:11:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:11:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <dan.carpenter@linaro.org>
Subject: Re: [PATCH rtw-next] wifi: rtlwifi: rtl8188ee: correct allstasleep in P2P PS H2C command
In-Reply-To: <1762390172-21091-1-git-send-email-pkshih@realtek.com>
References: <1762390172-21091-1-git-send-email-pkshih@realtek.com>
Message-ID: <ac29a4b4-0e1f-4c79-a60c-11c96c4e6a5d@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 11 Nov 2025 10:11:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The "->allstasleep" variable is a 1 bit bitfield. It can only be 0 or 1.
> This "= -1" assignement should be "= 0" as other chips and vendor driver.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-wireless/5c992936-4e7b-4c0a-abfc-0ec0fb9ef9fd@suswa.mountain/T/#t
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

12e6bea1aac8 wifi: rtlwifi: rtl8188ee: correct allstasleep in P2P PS H2C command

---
https://github.com/pkshih/rtw.git


