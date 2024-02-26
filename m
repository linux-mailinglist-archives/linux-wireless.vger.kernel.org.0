Return-Path: <linux-wireless+bounces-3994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36A866A27
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916CE1C2048A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC917BCB;
	Mon, 26 Feb 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KRxhKicw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86504175BE
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929628; cv=none; b=oZXpwvHf9xSD+sLG9bb5ufa6aLR51JRnY6QrLG6jDNa0PRM62YYaZ/9hm5WtDqmZm99ZbsBqur4jpT8mvSfFN1ieH/5ntaQQx/tA5tfX4rp1Iz/lvQKPXrO3w5JO5L5/K0E/UIdPXW+7kAfJNrXXXrJyfA0ZFdL1yc5gLO7C+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929628; c=relaxed/simple;
	bh=bXbkr3Ua7gnH0CladtXLi3lDiAFSa8BC8xmtXLqmFEY=;
	h=Message-Id:From:Date:Cc:To:Subject; b=ml6IpgZKq8/mMpuZZkkQ6Sx+MIEBb/qSuAolEHUlzEHqmEg58B0kzpoMmsTtaFWhRRN/zLaVrHQtyYUmK9Gh0R6Wo3WkI1kIlC7r11ycIoxu7w2Ud7SpbYV3hra93u+n2w79kh5SDsCnFgoKIEGTPP/mrOaidgGKhsuNiPaxy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=KRxhKicw; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2214:0:640:d6b5:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 5AF6160B73
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 09:40:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EeQ2Vo5Vx8c0-1JaTRGbB;
	Mon, 26 Feb 2024 09:40:14 +0300
Message-Id: <20240226094016.1JaTRGbB@mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net>
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1708929616; bh=dhhClbjQ4fTG003rDPn1QRj/2kBo2uNBq1zldThR+DA=;
	h=Subject:To:From:Cc:Date;
	b=KRxhKicwPkH9QOy8yngKFT43jdkKNtP1y+t1XsojKV3xMqALGUEwMt91DbyXPVVKp
	 IwZTeWumUTP3ViRFJiFqXdo/FfO9+QGcrpwRkg1cHSRgXZoVDTqnsl++G78HrjnA2T
	 0yxUzC7/MjBIiGV39A9060c0OVaUeOXddOrFpkEE=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by localhost (sSMTP sendmail emulation); Mon, 26 Feb 2024 13:40:14 +0700
From: "serge" <vasilugin@yandex.ru>
Date: Mon, 26 Feb 2024 13:40:14 +0700
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi:rt2x00: don't overwrite SoC specific bbp init
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

SoCs rt305x have the same MAC version but SoC specific bbp init function

Signed-off-by: Serge Vailugin <vasilugin@yandex.ru>
---

--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -7257,7 +7257,8 @@ static void rt2800_init_bbp(struct rt2x00_dev *rt2x00dev)
 	case RT2860:
 	case RT2872:
 	case RT2883:
-		rt2800_init_bbp_28xx(rt2x00dev);
+		if (!rt2800_is_305x_soc(rt2x00dev))
+		    rt2800_init_bbp_28xx(rt2x00dev);
 		break;
 	case RT3070:
 	case RT3071:
--

