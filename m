Return-Path: <linux-wireless+bounces-23045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CBBAB9344
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 02:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B46B7AF2D7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C24C9D;
	Fri, 16 May 2025 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="briFHiwD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943FBE4E
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747356113; cv=none; b=K5bYTrPNCcfcX+cRM74U0H43rR3X0m/kC1S08MczQ688UEcF4DQnAjBYE/KiO81ZZ2l83KIYzkKR0WITu+wcnYk2f6tCfWPo06/hk9WqeuH9U438UJTVwlGL2mWSmQTkifLGY4Lh36HXM+CbyNiGf2+WaCB1RpXuL4a2CgkDffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747356113; c=relaxed/simple;
	bh=xhrPPX8GRh7Qp8D6YqgvU3crt7c6RDztC+DfKajRjsU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=NhRoPIPZJVHD/qE+QEnF519sXjFwubVbOw4JZC/8JbNTH1sYqMgL4kuOZ6lxOehfZhwJK4h/S3c70yETUeSU0yDic426BEM/hgEohLDcp8nCJKXaEPTvQ6zDXSRYQOljhrZP80x7Qyi/4taT2U86ZUwWDIf0KZ9oHvS8JS2jiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=briFHiwD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G0flNeB043403, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747356107; bh=xhrPPX8GRh7Qp8D6YqgvU3crt7c6RDztC+DfKajRjsU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=briFHiwD+D6WJf92sVobvagjPCbfYNMyPKIQmVrCtbWJNk37b6jXVf3wJIVn3rW6p
	 V8pOFaEdOh4TYuHcxAD60Oosx5TrO9sPDH/GYLjJhaO77ne1reiNqIw0gd18bgyXA0
	 YhhKE4a7xu1ucMtxJf/7kSkq1XLBEiFe+Y4a7UDSdHEfLJXpIaRigglH755Y4jwNMz
	 7Kgj2jJhCcT1U6TWcxCcnMjTA8TiaT2M00YZ90tZXd5V0Jt6AIDvR4Nit2P5wKUTDq
	 tda8sWNdy8LkQIaC3qYnlK8GD+92lzjSfBaBJVLEYMPeJf53Ki/dUO9oLyuhdSFEam
	 GZGR3uOMPxljA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G0flNeB043403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:41:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 08:41:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 08:41:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Fix the random "error beacon valid" messages for USB
In-Reply-To: <c248c40a-d432-47ed-90e0-d81ee6c32464@gmail.com>
References: <c248c40a-d432-47ed-90e0-d81ee6c32464@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cc6e7b24-02cf-4499-9b78-7f3d8e7b56b9@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 08:41:46 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> All the USB devices have a problem in AP mode: uploading the updated
> beacon to the chip's reserved page can randomly fail:
> 
> [34996.474304] rtw88_8723du 1-2:1.2: error beacon valid
> [34996.474788] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
> [34999.956369] rtw88_8723du 1-2:1.2: error beacon valid
> [34999.956846] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
> [34999.956855] rtw88_8723du 1-2:1.2: failed to download beacon
> [35017.978296] rtw88_8723du 1-2:1.2: error beacon valid
> [35017.978805] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
> [35017.978823] rtw88_8723du 1-2:1.2: failed to download beacon
> [35023.200395] rtw88_8723du 1-2:1.2: error beacon valid
> [35023.200869] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
> [35023.200875] rtw88_8723du 1-2:1.2: failed to download beacon
> [35478.680547] rtw88_8723du 1-2:1.2: error beacon valid
> [35478.681023] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
> 
> Disable some beacon-related hardware functions before uploading the
> beacon and enable them again after.
> 
> Tested with RTL8723DU, RTL8812BU, RTL8822CE.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f24d0d8c3cd7 wifi: rtw88: Fix the random "error beacon valid" messages for USB

---
https://github.com/pkshih/rtw.git


