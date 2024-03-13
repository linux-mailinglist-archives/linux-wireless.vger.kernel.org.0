Return-Path: <linux-wireless+bounces-4692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3487B140
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 20:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B912B25BA7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43402433A0;
	Wed, 13 Mar 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anddroptable-net.20230601.gappssmtp.com header.i=@anddroptable-net.20230601.gappssmtp.com header.b="Y4GOBhOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EF26ADB
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354738; cv=none; b=eJ2A3vsqb+2HNmPqfI9OGhidycWJOeNwTM2RmhcaAqxneILry1RhmRwwPVqDlWw1ZjW3UM0CRudk66COIdKP7bZubjuRoBY4zsyr2waVuqHfQRSqwohJ0BRDAI1pKxmYgpc1ezevzwYAWQiRThXZnNixnf++ZfPTF1N05CP6z4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354738; c=relaxed/simple;
	bh=14Fh00IwVlxxw9ajb0K1/IErGji9ncP+v/SIbvwG93g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KTX7VeH04kAEk1cp+SllNM1BvyIZWAtJBQkM89eTaWJP5UoiFmjknIIG17aF/QPlx1TV+N19VTa5uq7wmy2JiQWgA2WzG392OTSwlsJmH9zdaKUePoKs0uw97yh2tC0KaYpfBsxiqYlu8BUzGyU7WvqSCk/C14QNuEmWR5VpEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anddroptable.net; spf=none smtp.mailfrom=anddroptable.net; dkim=pass (2048-bit key) header.d=anddroptable-net.20230601.gappssmtp.com header.i=@anddroptable-net.20230601.gappssmtp.com header.b=Y4GOBhOo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anddroptable.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anddroptable.net
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131bec457eso187662e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anddroptable-net.20230601.gappssmtp.com; s=20230601; t=1710354734; x=1710959534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJvgob7A4U4r9LWeOKCfii09xCfYDumFtYMdNi1v0SY=;
        b=Y4GOBhOoJjFeHFr8yNJXiLAWnbUUG1FQaUi1k62BTWOBXfyXqad+M2i4pjLXq7YyxG
         4hYwXwg/Psmqf1MhNDJ9F19uRoyOZ4Lkb+qIZM/o9w7+bLpVbJAR+OQ7GbKdVtCYF+Ta
         NLXP7lj+HuKgKBgXBhszb4M7ontzNpGvpJDrRHpOsXeTFAOvQTgcgpvX+MyFVrh+SbJ5
         tH3jRAjyrDu1akf1fmTkfYXR87oK9Et1qdtAsfNeIvrawyAglCskGZqJ5HWNkSmDzJqp
         ZPtvgymqyfBv1Iyuevb5IaFeVHC4YpsHKEaqQEvWpMNu7XQ206q2UvyWvBM5sh8HBJlQ
         O6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354734; x=1710959534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJvgob7A4U4r9LWeOKCfii09xCfYDumFtYMdNi1v0SY=;
        b=NzJsfBE0vgXlh4NY5Xy96oc8LwI5tAB+Bxuodu6HVk3RUagq/H+BkOT/zZvbsyogyl
         I4XQ+gtiMiYIoqu9eMoKp5H9crQo6F7bF8aEKxONQYi4OMzSoyyC8iofjwTy44kUaTlt
         C9REfwSqEHrI0gH/5E9IwfsAL/xWqrd/8p1VbxSjeSMqGcmYLY8ajwcokzHQbgDRYu5O
         rTTT493CRmGgomn6uhJDoEtwC0vxO5zwMNVry952t+EN3voTPVm+OmZi8PGWEVg2xPoj
         T4RVecbsP6zXb+XTqRWYJVxhBzWJh3rjjbYP1ngHFHrtsDuK2G9PMR1bJXV7f3Y4Uh4l
         HMKQ==
X-Gm-Message-State: AOJu0YygWwkOIc2lBMi/KTqWM+QS2Bne+Jdz/BcM3MqoAw2jgpDm6GHD
	BjjIARxMdeqEWs3JO+jB9EZf99zqmxMOLEHA0zcyoVBlNoNNuSmIBFNggXCsOja6da2hxTZIYyF
	gTFc=
X-Google-Smtp-Source: AGHT+IEtIk66u8xfLQcdvplSyrtF/Qton19erH4AwZ3Jigwgl2YzMX/2nh/80Wx3LgE2Bz814+hFqQ==
X-Received: by 2002:ac2:5b84:0:b0:513:c4b5:aff2 with SMTP id o4-20020ac25b84000000b00513c4b5aff2mr1318774lfn.6.1710354733777;
        Wed, 13 Mar 2024 11:32:13 -0700 (PDT)
Received: from bl-64.blancco.com ([193.64.185.110])
        by smtp.gmail.com with ESMTPSA id x16-20020a19e010000000b00513c7c85bf2sm470765lfg.53.2024.03.13.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:32:13 -0700 (PDT)
From: =?UTF-8?q?V=C3=ADctor=20Gonzalo?= <victor.gonzalo@anddroptable.net>
To: linux-wireless@vger.kernel.org
Cc: briannorris@chromium.org,
	=?UTF-8?q?V=C3=ADctor=20Gonzalo?= <victor.gonzalo@anddroptable.net>
Subject: [PATCH] wifi: mwifiex: Add missing MODULE_FIRMWARE for SD8801
Date: Wed, 13 Mar 2024 20:31:56 +0200
Message-Id: <20240313183156.2234301-1-victor.gonzalo@anddroptable.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The module metadata for the firmware file mrvl/sd8801_uapsta.bin
is missing.

Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 75f53c2f1e1f..8b86f95fa32e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -3192,6 +3192,7 @@ MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE(SD8786_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8787_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8797_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(SD8801_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8897_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8887_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8977_DEFAULT_FW_NAME);
-- 
2.34.1


