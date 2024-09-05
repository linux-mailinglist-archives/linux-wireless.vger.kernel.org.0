Return-Path: <linux-wireless+bounces-12513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944ED96CC2A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6BBB24423
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D6635;
	Thu,  5 Sep 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZLQ/k0bU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B854437
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499231; cv=none; b=XCePT6npuVkCH7QP1HSHbKwsZHJTneTOPDJq/Rn0rxqKZpdaDHbWaDa+1CgpYuWhjOBB7w5S/ZabeBG36X7hRfo4nnuqbUxlWVXvypxYSyL09I4IKOG8hQX2KCJJuFzu4o9Xzuw9DX1gkQkyms6gCRy9v1g3fezvlK4YBjye0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499231; c=relaxed/simple;
	bh=9fy2gkWcU2RVk1EbFTvxe6ycEpqD5KDBidPFotJBqQo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=T7OOCLg0T/3mV0oYRCo6wrUuDDraJFYR4AJYYmx+gHcnAIj2ovOVWQ+TprgWlpcfDk2iwmCf7WRjneQpUeOJSPGs8po0+jtZpkVc2rNYONckHKjyLJFwlmPUnKUkrIPI/pCDsp9IE4Sm37PiEsYyNme6DZAcrT7Qkt3+mrXj4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZLQ/k0bU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4851KQ5903092434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725499226; bh=9fy2gkWcU2RVk1EbFTvxe6ycEpqD5KDBidPFotJBqQo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=ZLQ/k0bUWJi8XAdMzOhWGARd7en12MWav2nwARACtF87xon6mzpXyAZVKn7LV3M0l
	 /0utUlJkmd2xpawzNy/FF5tVvFaYe4U6ZFCNAt2V+qvTeOIkAHc7b49SXMjTnwVv1G
	 8BKgBsTfO0a2GqFBzMRUjsU/Eb37ALD0fuUrb2XJsen+xbvEP/4m3zoSdsY5vmuS3Z
	 duEMmOu5WqO1/8PsNeRrbS60lJptTXFX/uOqy5OWGczWdqRZIJGVNU2As1AzMBXOmG
	 +MZAT/LVHHggksWoojt0bi6R2YdfwumdlDsVtAMV5OyZIF0G7SjKqFLN8ceVE4dRmZ
	 nQDfvThllO/cQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4851KQ5903092434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Sep 2024 09:20:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 09:20:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Sep
 2024 09:20:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: avoid reading out of bounds when loading TX power FW elements
In-Reply-To: <20240902015803.20420-1-pkshih@realtek.com>
References: <20240902015803.20420-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b558f4c3-226f-4179-a8a0-918250752411@RTEXMBS04.realtek.com.tw>
Date: Thu, 5 Sep 2024 09:20:25 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Because the loop-expression will do one more time before getting false from
> cond-expression, the original code copied one more entry size beyond valid
> region.
> 
> Fix it by moving the entry copy to loop-body.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ed2e4bb17a48 wifi: rtw89: avoid reading out of bounds when loading TX power FW elements

---
https://github.com/pkshih/rtw.git


