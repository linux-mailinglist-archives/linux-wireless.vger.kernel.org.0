Return-Path: <linux-wireless+bounces-11547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E20954822
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 13:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC53281E23
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3A13C695;
	Fri, 16 Aug 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pbuICKkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49A1AC8B9
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808182; cv=none; b=CNDecYcZf+R83FHszs0coRKpoCya4d+0cXFQjJ3YzK8peCznooWo3UDvi4lvtxz5JxS7UFQb93PKbo/kLQiRsVyU9FjJg3lEcJ8GQnkC2Z7fvs0xSEAOhtIcUwuM3Jtv9yL85QU9fi+HGvMTUBDImUVbkarPukhM7JvyaHtr74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808182; c=relaxed/simple;
	bh=aTIeExDiQWwIZfBskl9xqlOHAdL1VPeJxgtzl8Ffs4s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=OgenQv0Sv0NKqewhqUOTCL9Bcj6z6xvDGSuS0v/9SOHikwjK+Pb2QAMzzOroRhI49zZZo79qx2CTqZDqNNqM3ynbHHUy21RQ367H8TCEUifhnkrfS8VyHZMoyJlDHPNKlqVp5JbOq7cCxutyjrcu3yRUGIcJ45dgdKueXDDLybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pbuICKkj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GBaG531979371, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723808176; bh=aTIeExDiQWwIZfBskl9xqlOHAdL1VPeJxgtzl8Ffs4s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=pbuICKkj53uNiLgJFmLAYBYSAcIMT+bPuyvsh+lre724agl1iCq2NgQTDak8FqpFp
	 2KtQpl5z+mEiE3+urk4s8czeZ0gjuEPMRT5mC1cCLo3tXhTSvVB4ZtVO3woao+CD98
	 nXIXKFQz4+uM8uKMMlxlEpkkgZG8PNOdvJrHa6xMXqSlwmN83Kh6dZdiaWIXtE27bh
	 UFDgJb6bJaYZn2U0oEDVkHI0kXWj6X0sKFOMoiHT37U5pM5QkuZlyUJx4zrNjMXho3
	 HqFgfQTQM9FUrNma1AeAzaUPx6m/1Wu7psGdM+8aHAK30vYZa+VuRNxT3pWAkDv2y9
	 wsRmfQKmtbSAg==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GBaG531979371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 19:36:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 19:36:16 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 19:36:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: Re: [PATCH 1/6] wifi: rtw89: 8852c: support firmware with fw_element
In-Reply-To: <20240809072012.84152-2-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com> <20240809072012.84152-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cdd49d6e-6ec6-4742-b71a-17287b68613d@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 Aug 2024 19:36:15 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Firmware from v1 will include fw_element so that the driver will loading
> parameters of BB and RF, TX power related tables from firmware. For the
> current flow, if fw_element is present, the driver will prioritize
> loading parameters and tables from firmware; otherwise, it will
> revert to the original loading method.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

526929a326d1 wifi: rtw89: 8852c: support firmware with fw_element
82baae10d822 wifi: rtw89: 8922a: add digital compensation to avoid TX EVM degrade
56310ddb50b1 wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
45742881f9ee wifi: rtw89: correct base HT rate mask for firmware
338c9cba8d6f wifi: rtw89: 8852a: adjust ANA clock to 12M

---
https://github.com/pkshih/rtw.git


