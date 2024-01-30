Return-Path: <linux-wireless+bounces-2779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E910841C20
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A228BE06
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD5524CC;
	Tue, 30 Jan 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVZiyNqT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E8524AC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597231; cv=none; b=OOeFcvwjFJfET438/oMXABhQkpVPdR+fGtcmoOPu4mPwJ5ZdcwUiC5IHbhfDwi91wjwddw9EiaUrHaukqSYm4W6/8+u8KRYHQCAJu8ZEpj+vvq1PqR5Mo1FBXAbgsF5EFksVVEcJUhH3FFUcATgGspxaLIUR10NM5RwIvbEJL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597231; c=relaxed/simple;
	bh=Z5DIe881UwCU9DDgOmmQOXALIXUP8SI9QhUnk4wRCZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QNV3gmnGSJaEHPFNIkSpiUkldhMbViS9BR99lJ+JLfyWvG/Q1YVGMmMnRbp3TbxSPY0D+pBvT+JeISTCOXF7vpZ1vmFs9SgSU6kEIyz8MWVBtsx5crPH0r4Onc1DmwnSD5Vn20U1zdo+cZ8zRLhrbRDPuOP+xLKydgzwhg3JVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVZiyNqT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5111f9dfce5so28672e87.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 22:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706597228; x=1707202028; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+3/wsx3NS47JcKpNk0wT5zaj/mo2WWMlXJ2KicYJcA=;
        b=QVZiyNqTcwFpX/UdpIs9OoAIZ4b/VtaOVhT/8aW26WFwv+S3Z/YHZNlP4A2aQnvkGr
         IYnrfNSOd/sGxh3g6cl8jB+u4Y7UrZenm+ld+pMZTsZzb3cd3uIM9SCKFtKqm+yH8xaE
         SX+AsBdjLEiMuGzbspYya03JWQLg2ZjAea7QwzX/txw5YnvlM8590cQMFDU69U39DI6c
         WeP8abJdGGnaBS49+t5+TYZwdfHt4Ylpy1FoHGcw/ttEJI3hHrPfbOnZu8Spulnzk8Bl
         vnYYyriQJxHXkjvFMxC5JF+GEQarC7BpAEPIdDNZBr7zETVLLcwQNqTrDv5hxb6KxZmw
         YFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706597228; x=1707202028;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+3/wsx3NS47JcKpNk0wT5zaj/mo2WWMlXJ2KicYJcA=;
        b=jieONcsKd7NYpEt8Hv/1+tsg6uKByyMAOs48VQAAZCsYMOUNBGcoKXWs7gOTqLWr7M
         Rknv3r0rbaxsNiA6yyaURsk05Z48O0rtTFM0iVkusIAdzkV9prtgK1zcbClBhDTIZt7W
         0nTECMi5U8N9ZWA1ZxXsE25Oei7OZRrLCMYhfssGGAyXqumrdLfTuFokioAQ1+dPRmtn
         Tq/F0WuWTSQAjmDCl5Eu7dn1XpWbMSllWsSiXxaL+Kzp42kXwyhnhf4HfDoK1DGw7vik
         ifwtDUkzayEiEMDktpl2pfObQPE+rzi1mL32upKDG0fmtikSqF945Eu7LIdLEK0UpPwW
         fYGg==
X-Gm-Message-State: AOJu0YxjxH969A+/63ZF3pMOLNJWaEz7WW2q8No0rFf2ygMpjYd+ZVDV
	1lW7NcZ8+wWApvOvx2I8K6Fbf7SCm6zsSiuVmMJLmEtVr7iZh0UptlVRs5tFR9A=
X-Google-Smtp-Source: AGHT+IHuTOBp8q9TetwZto+FqfFgxTgf+zUQtYtQGObfcIOml5Gpv73qP1xyxGdib0ojwLeRBndsKg==
X-Received: by 2002:a19:5e14:0:b0:50f:18f7:855e with SMTP id s20-20020a195e14000000b0050f18f7855emr4014975lfb.39.1706597227766;
        Mon, 29 Jan 2024 22:47:07 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d18-20020a056512369200b005101e1870aasm1367068lfs.162.2024.01.29.22.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:47:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/3] wifi: ath10k: fix board file loading for wcn3990
 devices
Date: Tue, 30 Jan 2024 08:47:05 +0200
Message-Id: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmbuGUC/x3MQQqAIBBA0avErBvQqRC7SrSwHGs2FgoVhHdPW
 r7F/y9kTsIZxuaFxJdkOWKFbhtYdxc3RvHVQIp6pcnivcbOWoXL4ZLHcKMjb82gjDOaoGZn4iD
 Pv5zmUj7UHRB+YgAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Z5DIe881UwCU9DDgOmmQOXALIXUP8SI9QhUnk4wRCZc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBluJtqDq6KB3BH4ao2LCbZG3zMTpmYnqCmaMaUU
 EslVyTJTq2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZbibagAKCRCLPIo+Aiko
 1T7gB/9B4JuOVfuG2430l3IsEd1NFbPHLLbLi6xPqWoqsvFRI+vhZmCZ6g9jWAXBb/8FIcujsds
 YlpFu9zJ7ln8SftJ9bzqfmU2dOJQya1Mupy8LY2FdQXmGVUX/axTQRD9pSl4Iz3fSA8IuejE3LY
 RM6OiF/O+eDUGYnIVzAxViy2od7bQ7dmhPpl/GKjkE1NeXs/j0LOg6o0x+sYGbJMkhjpNwS3nvW
 zbvVEiVGEZz5E66W9Y6KKfnYbD9lO4KRLDipspK2Fm1vk7JMbYnwg1CNRJYNBbUHtPjxoWoYMpw
 gJHQclgkXPR9BcuwCMby/lg6R5v0MYvVimIsWx09HWwunkbN
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The ath10k driver fails to properly handle fallback from board-2.bin to
board.bin for WCN3990 cards. This happens because the
ath10k_hw_params_list doesn't include .fw.board* parameters for the
WCN3990 platform.

Add board data configuration for WCN3990. While we are at it, merge
common pieces of BDF support: drop .board and .eboard names from struct
ath10k_hw_params_fw and use the common name instead.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (3):
      wifi: ath10k: populate board data for WCN3990
      wifi: ath10k: drop chip-specific board data file name
      wifi: ath10k: drop fw.eboard file name

 drivers/net/wireless/ath/ath10k/core.c      | 32 ++++-------------------------
 drivers/net/wireless/ath/ath10k/hw.h        | 14 ++-----------
 drivers/net/wireless/ath/ath10k/pci.c       | 10 ++++-----
 drivers/net/wireless/ath/ath10k/targaddrs.h |  3 +++
 4 files changed, 14 insertions(+), 45 deletions(-)
---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20240129-wcn3990-board-fw-a2d97507a712

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


