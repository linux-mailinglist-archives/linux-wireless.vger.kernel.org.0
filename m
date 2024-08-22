Return-Path: <linux-wireless+bounces-11774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444595AADD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 04:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B922837AA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 02:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13479C8;
	Thu, 22 Aug 2024 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N8z8m65q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8250171A1
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292839; cv=none; b=ufzldxEmbjMNcNJGbzDpyaRZeKTfv0hTarr6/EMeu+pkk2Aan/C4pxxjgkG428GStHeErRyARbE+iyk14FNPfDLQmdLzgkv1TZAuVrjwG+fQOF/tIfEp3VGQxpm17N6qKI+VDBQm9ftgCdiwk34F9qo9ogUNByW9kh6vgbRf1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292839; c=relaxed/simple;
	bh=au+Nyqc3EbUzJGEPx0qrlrEPvY0bwqw6kfdN9uZywN4=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=UjC4CTcT7vW2gYyjfnWy2G5sckom5U/y/iEO6xvlGLXfY4ezUReWLzSXeKIHs30KL//cfkmayV1hcTo21duXD8GkdvPTzEccgJkcUxvI3uE4CkPRxUD8eQmiJMQcSnUavDWT8de26lHLaE00S/EOZhCNmKeC8upgVEH8V1xVKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N8z8m65q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M2DsdxE3422127, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724292834; bh=au+Nyqc3EbUzJGEPx0qrlrEPvY0bwqw6kfdN9uZywN4=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=N8z8m65qs6CxSYzkjG4ZWPzDKW1tAO2EzQ0WzaOKgJrcGcGwuYZK8GuDbWfve7deW
	 3Fh00JUbPG4h1w33wVPJtlEwlTGGTNJI56uqXUEW0PR1qi9mSEV42Di40t8X58Rxe0
	 7gzqQw748ndRW1FjXe6LRXqeS5UHXPzsGi+DC4gcIfKY5VA0kt70OUnKaTZ1vERmCB
	 t7OsITOpqqaSFrOda4iqcjYbdfmMazhd4Ipus5z9jqGRDTc0rEToTy9UCFMy2UM1xt
	 JADf532EuD3sJ6bL7oGj6F6ItZP2D5UkEMsUIZ3rkSmc5couDsfo+naqqr/h8nbIhH
	 eMlcJxs/lAu0w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M2DsdxE3422127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:13:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 10:13:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 10:13:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw89: debugfs: support multiple adapters debugging
In-Reply-To: <20240816115700.17390-1-pkshih@realtek.com>
References: <20240816115700.17390-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <71b6706d-d41f-4ae2-908b-dbeb0ec9984b@RTEXMBS04.realtek.com.tw>
Date: Thu, 22 Aug 2024 10:13:52 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The rtw89 uses debugfs to access registers and driver states. To get
> a range of registers, the range value is set and stored to a variable, and
> get the set of register values by the stored range. However, the variable
> is a static global variable, which multiple adapters will be a problem,
> so move the variable to adapter context rtw89_dev.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a3f00afc250a wifi: rtw89: debugfs: support multiple adapters debugging

---
https://github.com/pkshih/rtw.git


