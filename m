Return-Path: <linux-wireless+bounces-28516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A15ACC2EE8E
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 03:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 022EB4E391B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DED1DE8AF;
	Tue,  4 Nov 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XJjVoz4+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E806D515
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221739; cv=none; b=Myc4GjsfL6DbCjYSTGMx7xX60ZL7O3mgaZgszWq+4OWK3eTLuJQH/SSBc265OOTJVT2fcX8hpbh6pr6QJUIGKq1onuqg9/OL5B2DCz4tPfIDqy0/mej4ka5sOiugVRGta/Sc1GR3V+pv3N+inSglWCSE+MUFnRLoQ4AiWXcECaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221739; c=relaxed/simple;
	bh=E8FJ9Y4BFcOarr6chyIXiaGdAduCCpp+G65VuPqUBCU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ElzEWKZHolGbJDTdkZX8OzoepWv0yxyoCjav0YnS9ig21A1SxGyarhEnuRDJ6kPTJ+t0/xZssalL3tz38tFIPphipsnqJ14KLDkPw4D7LRnJTiO0/7vQ5jNEbtaU4C5Nwg4KrdX91qjoCl1swGnJsQnwJZrbt14KirBotMp9rTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XJjVoz4+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A422EelC2483063, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762221734; bh=nCJCxCeRYeN7HZAvyvDDyWi49mYsYd8nPpF46t0WQDM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=XJjVoz4+zI2aiIaFK9Vfh/4asdPqQjAULYCju2cQ5ZsUNcPCNhzHoVX7SIi2k94WB
	 3arHCH4uFERM5T9xsHlravTH1W0Eu5rCXqwEwRFTrMU88znZoJ8SWzpaT1odUw2fwF
	 77HfiIzQgVnWuGvg6dTGScot8EiGYtifkzpLDgyf63bl40QuOdGoC0tfBH2nq2FW5v
	 vxQfm37UZchzdmpPXCbJlcNR3p2rM8z7kgDgMhwkETU180sh1PsihVHC64+/06Xup+
	 9OpTZy9YIDFh2KIr7p4GO9wyBDMiJLJkMVOdwmdenlSQfQX6sbiwKalQGk0lziyy+b
	 FJkXLNDBmUSkg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A422EelC2483063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 10:02:14 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 10:02:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 10:02:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: 8822c: use fixed rate and bandwidth to reply CSI packets
In-Reply-To: <20251027070259.18931-1-pkshih@realtek.com>
References: <20251027070259.18931-1-pkshih@realtek.com>
Message-ID: <b4fa984d-dca2-45fe-9690-eb6482834834@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 4 Nov 2025 10:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> AP could trigger beamform and send NDPA packet with 6Mbps rate
> on bandwidth 80MHz, but RTL8822C can't reply CSI packet with
> the same setting. Therefore, force to use OFDM rate and
> bandwidth 20MHz instead.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

71ee0d565985 wifi: rtw88: 8822c: use fixed rate and bandwidth to reply CSI packets

---
https://github.com/pkshih/rtw.git


