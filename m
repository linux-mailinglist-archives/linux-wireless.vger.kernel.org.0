Return-Path: <linux-wireless+bounces-19240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D0A3EA7C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 03:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B168B16B968
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596335970;
	Fri, 21 Feb 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="on63lhv3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6712AF10
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103253; cv=none; b=BE1gohahi2xuxokk2SK1N/tuMgFDnainm0pI+EVMR8dx0rR57+FJ1HfJbcBBWKbfS6KsZW7TNGgVB/NUozBaT5Yb5AumL4m+0/FT/4orDdb/bnUFIgq+83CfzorJqdGzdJSzcQfJOLzkXkifYikQoLakYB2DF/R66xVhy4+1iwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103253; c=relaxed/simple;
	bh=/k5EEQW18UmJJ7n0NR//o/oTlA++Xfd9Vg/sz5IVnVY=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=RMTr/GRgg6hMbLv9PFggUkJg5740qR5eg9g82fo3DWg9WQAnF/08rAgge0HaZ6/M1ae8ni0ljAnOzdNCYSaX6LTWfts45k50RK7zMX4yKDFSKlG6ZvSvSkEsJDqEsF6OJgmCDy8cHjQMXmvjYrj3OVq8lYaJkd4g5HDnTQwMeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=on63lhv3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L20nNkA841606, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740103249; bh=/k5EEQW18UmJJ7n0NR//o/oTlA++Xfd9Vg/sz5IVnVY=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=on63lhv3rsZUTT8thQH/GI0gC/1l13XnOcnvLAKw/DNA5jcKF/CtmPGicTzwpaLnX
	 tB03JYLKaD2+aSpWSO8jxMux/TrGjqfdQ2LZSSFj8VDgnw/BMQZygU1F8bOcxWY/4O
	 sSuBA7ODw1wA1iviYoQ0GIUHIxkXd72mM2PjXSGVDql4Pp/1g5oilN+PBX6HL6lBY+
	 4x5bj5YShPryJXFdXjGdwUL6g1FldkG1sfSCXgUCKGm18u3myElnwCbv0F9EnPtee4
	 KOYFUv3KGEYfqvxP9n9tlYU1vW9amE04Qnvla13J4rH8Xn8ZAwQPmvur5HbfodScfd
	 nnWJKgiQcONjw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L20nNkA841606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 10:00:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 10:00:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Feb
 2025 10:00:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/5] wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
In-Reply-To: <20250217064308.43559-2-pkshih@realtek.com>
References: <20250217064308.43559-1-pkshih@realtek.com> <20250217064308.43559-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5574bb6a-b847-45aa-be8b-aff2c7b6b95d@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Feb 2025 10:00:48 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To ensure secure chip only runs expected secure firmware, stop using
> obsolete firmware in blacklist which weakness or flaw was found.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

f11d042b3a2e wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
2f9da853f4d8 wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
56e1acaa0f80 wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
dc2fc1a3419e wifi: rtw89: fw: add debug message for unexpected secure firmware
e0722103306f wifi: rtw89: fw: safely cast mfw_hdr pointer from firmware->data

---
https://github.com/pkshih/rtw.git


