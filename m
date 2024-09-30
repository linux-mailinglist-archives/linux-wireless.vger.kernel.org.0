Return-Path: <linux-wireless+bounces-13330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE47198ABA0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B402AB209AF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87A192D7F;
	Mon, 30 Sep 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXWxXmCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B62AD1C
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719640; cv=none; b=GQaCqhDqh5G2nFzND/r78n6Y0uCrFcPiySqHt4wUflamzO3s7rY0aR2snpCMtLT6094VqctP1tr5GBw2I8x0w8qstzZKaeuGoK7iqtRICdcbITX/whzAu4bmwfvtVYshDE3pLHlchgvCHP7Drt2ekF5k6IkdVf1sViwgRiXvo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719640; c=relaxed/simple;
	bh=HXCh/GCAr4rX7gWtUxZV4HNlpytWJvjub+fJ5k5iWb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjEUfexUxOSJPZ5syOQIjr1eb4+tU1AjrFkzChhm5mCBa1erVyHRTvVSIR89ModIpWH03EynLAgGTscWWWvZ0GpaWQ+SKmMMhTrBxeAIPgGxvmdzW43caVAejbd2IB7I17hqoLqbtVWuA9o5xk7jmEyhLHm5mQSth6vT0gd2JZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXWxXmCQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b0b2528d8so51533185ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719638; x=1728324438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nK8llFJkF8LApWIkRdav7HwjYfpKPyCI6xo40jcWBiQ=;
        b=ZXWxXmCQwhVDU9KQx56dAglV4FvyMC7ae16yUEbGD50P9UyoibdWCfrSBZ+DxUbg+k
         FyS3ME1T1GYwHar9NvFQk6hcyQGdCozoaV910YXcTBgo7qyxA+b68OsQQkrwbQsZ7gq1
         L5cCb4eoj9Y+7FxA7MpCx5ZNogzk+xm5fsjvQLtRf9ukWjpxC9IOSMBMvdzkNjep4oB5
         aTSmSMQVFGwUlsw2j3FxzPbCsm/ysswIUnhnX4yVC/MWEUSdxVjAp2XutDkVKu/sjd/h
         s5qgg8A+wwPCkcB6pM0+lA/epjQugdTX5cCRAUHJCB/Eo2AGYP1eGuQJIaoWloqnDJUq
         nBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719638; x=1728324438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nK8llFJkF8LApWIkRdav7HwjYfpKPyCI6xo40jcWBiQ=;
        b=OlBHlm1XklTqM9Kj71aGPrI3TaN4s47E5B8LFT4hxn6CrPIkUIYCOTxWF2qMXGrs20
         sqADWqx6fu/LzNon+UkNn1l3C3GdnTSY3IagNmxIOJIT5++ZNeB4zmt7CmOqlW8O50Hb
         dBwOYLL09tVXK6BqaDwFAt5AWgZVCtJN7u5+PmRyPWUQW0TD51+P8nAgWstApukSJLvH
         CuqZENzBqsZZHe2wGZI0avSFxcEjO3vlIn/0FQ211CKsLpVLBPOt/MhHn3pLsz5GXK/i
         Jd5h+NqduJaQfz3UTJXQmaKgJuAMRhOJjwXHCWAEFXQujF69fItgd+0DSRjLkJ3KDPD6
         Lqzw==
X-Gm-Message-State: AOJu0YxnlGvkdv/HYIbpsuQZtido4C6prmVyxIzjTRxodkg4F8EV/E4P
	h4XKEQpkXQA9flLG1b5zDUEPOoBb9ZiKkjyxKm04uVrpsvNq7Stgnuo0akd8
X-Google-Smtp-Source: AGHT+IF/6epFhJIhht4TdMpZz5FPlb3Y8ST+YTe+quV79lBkDayRD5Wa3KULa5VzadN4pyLr76biYQ==
X-Received: by 2002:a17:903:41cd:b0:20b:9841:b457 with SMTP id d9443c01a7336-20b9841b70dmr35750555ad.47.1727719638474;
        Mon, 30 Sep 2024 11:07:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d9fe05sm57439295ad.93.2024.09.30.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:07:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de,
	jirislaby@kernel.org,
	mickflemm@gmail.com,
	mcgrof@kernel.org
Subject: [PATCH 0/2] wifi: ath5k: add two PCI IDs
Date: Mon, 30 Sep 2024 11:07:14 -0700
Message-ID: <20240930180716.139894-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These have been hanging around OpenWrt and never upstreamed for some
reason.

Rosen Penev (2):
  wifi: ath5k: add PCI ID for SX76X
  wifi: ath5k: add PCI ID for Arcadyan devices

 drivers/net/wireless/ath/ath5k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.46.2


