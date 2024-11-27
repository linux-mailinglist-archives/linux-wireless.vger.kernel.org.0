Return-Path: <linux-wireless+bounces-15740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A759DA12F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 04:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FACF284644
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 03:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E641EEF9;
	Wed, 27 Nov 2024 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HiYI1Nlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B821114
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679148; cv=none; b=VFxDXsJf5ozCyED1Lwx98glAZ7rREAsNzz4MXeZZzr8Qt5F7Y8/BGhGgxWbqE0Ig+GMhIvL9kZEc00N3oKT0CxanJptCZjs/XBlXG3xxn5WB3mFfuAQuOPZgRIRuGGdG9rDMS8tJz/xi4CMr+DLWZt2PClj2uTo9lKDeVWYO7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679148; c=relaxed/simple;
	bh=chVBd1kComteto0nTjnb8mF6JWDs5r5nKIXZ1nQpDVo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=LBgT37DUvNGd/03wzk9GY2+bgUYYyXwKOuBxvhEwbmz8AJztiDVEbg6hYrnKlKaRB2aqXq2AwrTeNNmgO0dX9Mq3xnHsvAp3/Csb71U+1NUbavnw+4HyFxNpRwDSFhyVaUR4xPAuSvJ3B7OYjwqj5UtXRp1rHu2HIfjETpHe/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HiYI1Nlh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR3jf3hB2100433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732679141; bh=chVBd1kComteto0nTjnb8mF6JWDs5r5nKIXZ1nQpDVo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=HiYI1Nlh9a9lDQTDcdMy/0vPG2f7cfJR0HIWIaNqdaEAtl+Hd5N2VP/SDA21nCyBa
	 8lvOg2b7bmReK5vcRWMP+++47aBqJmM1TEHqRawx5QClDsfZ4VDTQ+eMxfexNUyfCP
	 dFnoL0ubQUx8JNUOCUxTaxeE+QeMA7n+jQoBMQPMa8XgFYqdoS8tCuqM0WfTYnwQCF
	 EmYomVDBHZC0IIBHbcw9wMsaAxVqvGzSaxaXU8P8kBurOkpmQ9I1ebhvtbLjnWhPkR
	 HXS/AEaWEFnwApbMURHYUgUF+myJDID019fBrO0ZoQGCgDxZQvbzMpX0vmv+jkyebp
	 OMG1xLfZHS3+w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR3jf3hB2100433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 11:45:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 11:45:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 27 Nov
 2024 11:45:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH v3 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
In-Reply-To: <20241120034054.13575-2-pkshih@realtek.com>
References: <20241120034054.13575-1-pkshih@realtek.com> <20241120034054.13575-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1be3db15-1852-4186-a8a3-933362d622df@RTEXMBS04.realtek.com.tw>
Date: Wed, 27 Nov 2024 11:45:41 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature,
> called NOTIFY_AP_INFO, to notify driver information related to AP mode.
> And, one function of it is to monitor PS states of remote stations. Once
> one of them changes, FW will send a C2H event to tell driver. With this
> FW feature, we can declare AP_LINK_PS.
> 
> For now, driver still needs to determine if a frame is ps-poll or U-APSD
> trigger. So, add the corresponding RX handling in driver, which activates
> only when at least one AP is running.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

144c6cd24b35 wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
c821a8af435c wifi: rtw89: register ops of can_activate_links
d2b387bdca46 wifi: rtw89: implement ops of change vif/sta links
a6db83bef0f5 wifi: rtw89: apply MLD pairwise key to dynamically active links
55709b195464 wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
f79257f5b971 wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()

---
https://github.com/pkshih/rtw.git


