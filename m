Return-Path: <linux-wireless+bounces-25426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737EB04DB4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC9E7A5A56
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534B2C326A;
	Tue, 15 Jul 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O4PtGEH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF42C031E
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545441; cv=none; b=ev9Yxil9wlTxzVleK3qDYkm8+VSz9ohcq534BH2siyYA2pTLQK3fED/cDAX3+3ukf7UeYSVWVC0A/oVROJt1TgpoVMigUYQNm5UZ+oDbs5vXqn4kxL73uaA3AJuXS7/W/B4zhPGIhjht41C1lzUscQiTT1Ktd7fc6OK4OmcFnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545441; c=relaxed/simple;
	bh=Wb1amVlWY0gPqe6FLhVQbzE8+rnAPSESMy07/DM03FE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=gOJDHuQMQfqvcIcwZhYaSjvfKNFfYqnMRM3WisMrZFsyLWdSkFOjHBecduZWwS3ILvkgU2s5klw0jIIfZ9G4oHv7h4zpeOuY9OIa2sjdAUybt83eD7nwnb3Z18T34OjgAJSzuiIKSRddYlRvy3NsBj0nP+0lHowm8gO6JWAokGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O4PtGEH/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F2AZygC3816546, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752545436; bh=KoRNK8R5S9fz5XBG9kusLpNjQVbKrlUvU+7Uy0eeupA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=O4PtGEH/mSuF4KwuFQb2hvvuNrZ2AI9nROq7LI4o2RIDO+NgAz+GFwC6dokuI5yz5
	 oNaXeZIcUqI5GvX9KVqsYknYQCyhGpMN4/G3+Q6jcvQuC9zr5uU009Dh7Z07G+h233
	 IUfNQRoH32vwXcrUejBMCcXXsVGl7c+z1EBw4l+REvtvNLrU44UIOWY/esfgQ26xxd
	 FbazCho0DV5itLXv2OFz/mk3FaPixGfEf5rxJFg3b2GUEW6FpxTXBaCK2u43GqcSRn
	 JP1XQHsyDNQG6y+pNZYHIvlQfRLohuVV44kQPfKSzBsSU4Kedjo8/Pt8UmhUw8VP4q
	 MKFtcEYDlkHBQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F2AZygC3816546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:10:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 10:10:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 10:10:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Fix macid assigned to TDLS station
In-Reply-To: <58648c09-8553-4bcc-a977-9dc9afd63780@gmail.com>
References: <58648c09-8553-4bcc-a977-9dc9afd63780@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c9d87474-f4fe-4239-b3b2-d923bf579e53@RTEXMBS04.realtek.com.tw>
Date: Tue, 15 Jul 2025 10:10:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> When working in station mode, TDLS peers are assigned macid 0, even
> though 0 was already assigned to the AP. This causes the connection
> with the AP to stop working after the TDLS connection is torn down.
> 
> Assign the next available macid to TDLS peers, same as client stations
> in AP mode.
> 
> Fixes: 902cb7b11f9a ("wifi: rtw88: assign mac_id for vif/sta and update to TX desc")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

526b000991b5 wifi: rtw88: Fix macid assigned to TDLS station

---
https://github.com/pkshih/rtw.git


