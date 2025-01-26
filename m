Return-Path: <linux-wireless+bounces-17979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC6A1CF0A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD631886674
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1C5672;
	Sun, 26 Jan 2025 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFTjz9Ab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAE25A655
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737931991; cv=none; b=uZNV1l3yAnPU3ELp+QA3v1xgV3MVxQtmtNPdTPbMQmnYgrqmAlA+pQgHRTLsJFN7Eo4Ns2mMgU4XKkJhpZs0EdicCFLCq97i4S3qxq7xGL2lnOI5hUJifoDby3Wtay+ik6QLIeKIjdUqRKGt7c2qO0Ng4yu2d4YzUXRoJxFcH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737931991; c=relaxed/simple;
	bh=wTgq9ReGdNZjZPSM8F05nSHvlmoz4scXJ6IeWR4N5/g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IEu85sEElNIkTlfPuR0ElQFac2ZknWbILARRUJ1n87CroyR0QZ/C/oCzgKRN3GhdAq6Rig4VceCm0MPXHNhlMD1BBi8/e8pw0MLqVvgsQBSj8IJBMiYAd4DhLdzp4SRImXyqkCEjME+a8F1GCTuSlznZPOt17Ta6XiAa+ykcG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFTjz9Ab; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso3370566f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737931988; x=1738536788; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXa5xNlUm0hAjDHRPv2plx/3cNinp35S4lC7Y6LOuRc=;
        b=DFTjz9AbTkbyjsTHsl8+Jd5M0p3rCgwioCi6mO6D185hwFFKhwTv+ZeZ8jhN4H3Jcx
         rkSZzSxSppASn6MQUGcNPPeQ80orYRhebrsKkNEIXiHG7ZriTAYHJwSywxLY+oMpvpWs
         F9vZTaRipchIj49Td6X/xy+yhzPsQZxveQxyxMP9T/F/sdelo1QNOXd6mauDmTai8rnC
         4luDCkA2SRVfODE3kP9BhhI1cQWGnx6cIiWEb46OIpTxO79TNY7JYQFJZC3NyX3U7+4U
         R3lFFQ19tm3kE5tTb4CkVLGeC99mBq4TIs3eoKlGkbRTtyNXcWDIYnAoafZpw1/2MgO/
         hZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737931988; x=1738536788;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXa5xNlUm0hAjDHRPv2plx/3cNinp35S4lC7Y6LOuRc=;
        b=Gdz6QdIKBRhuWZhrxV/nEHDjl2ZU6EznjJlkFgfzoa8cnrSlNLyxZNCUB+j6GiaoOw
         VnyNoQi0CVjXIDOV072S3GFHTVh8Z3MpJBnvh1nyWkKVB7G3NrI+uj212LGNV//f9OR3
         sK9PlDxV/pd8bj1rBjK5UKrFBK8cQmGnDZ4mN4vKYQgifz088PKDzHLCKkacesOxfOdI
         lN1uLMg6EIF7YwIeL5n/+IorIEfG9U3uoyP9oGEcygqISfztks+YH5Ycr7jx4Wm2xMSt
         OwLPB/wG+J53QSOKryNCSZZuK+ACL7CkfdnBrAwuLSFoHC6yGjUCXuij9a3zjNYRDcSQ
         0PVw==
X-Gm-Message-State: AOJu0YyRrxekoQcoHcLXioubm+PamFQL6MeIP9/VdaW7mp2Fz7u0zm0+
	W/jQ1eyAyp9AZm2dCpA79J6p6Tvie1MR0b6C0rgiASNfXUP5TQW6Uq5JSA==
X-Gm-Gg: ASbGncuiFRvkCjMxzOVLLvlI9mcC7T7bhUTMEjraYImwtFpLk552hWMggj5z8aE1eOx
	K9LVoOheoCx2Weu/rQenbZXY0NgCZQJcrshgC87kFbvQ5HLy4A6aOthIeZrMxRsOPHcvlXFngqc
	WkqwWExTuKZxMQSCOoUAzBgBcAqpsSAlsbagpEvi2EV9sTOzsY8mW8ViBoYL1Vniabw/GlHqZhs
	qKsocNGe6nHFHx+zp7ZTsQzBO1KrfgxEaagcrY6vAX6tcchAGvPFM/TkX7ulARrXwcQMI2i3SXN
	DRgKpD2iDXNW
X-Google-Smtp-Source: AGHT+IEl5EEHTnb+in7RpBMsZMQGukzRnZqpxfvfj+/fz2llm8MfkCTBuCERqdK1qAFLQVirRnmN9w==
X-Received: by 2002:a05:6000:1864:b0:386:3e0f:944b with SMTP id ffacd0b85a97d-38bf57b75d7mr30805853f8f.37.1737931987809;
        Sun, 26 Jan 2025 14:53:07 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb101sm9495004f8f.66.2025.01.26.14.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:53:06 -0800 (PST)
Message-ID: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Date: Mon, 27 Jan 2025 00:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 0/7] wifi: rtw88: Prepare to support RTL8814AU (part 1/2)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few small changes for RTL8814AU. Mostly it's about supporting more
than 2 RF paths and spatial streams.

Part 2 will have 7 more patches to prepare things.

Part 3 will be mostly the new files for RTL8814AU.

Part 4 will improve performance.

Bitterblue Smith (7):
  wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
  wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
  wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
  wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
  wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
  wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
  wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU

 drivers/net/wireless/realtek/rtw88/fw.c       |  14 ++
 drivers/net/wireless/realtek/rtw88/fw.h       |   1 +
 drivers/net/wireless/realtek/rtw88/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw88/main.c     |  14 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  20 ++-
 drivers/net/wireless/realtek/rtw88/phy.c      | 149 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c |   2 +-
 12 files changed, 158 insertions(+), 61 deletions(-)

-- 
2.48.1


