Return-Path: <linux-wireless+bounces-1775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE082B9FA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F199C1F24AC7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945621B286;
	Fri, 12 Jan 2024 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="JBG4ZcpQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316A1B27B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so4842826b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1705030490; x=1705635290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ng2OfZDJvEV+KTtUP/Iio6uQuCO0WLybP1MXx3qAmCA=;
        b=JBG4ZcpQ82N6IQtfRVxd2SIf3QHipmPID23TLmnF+wBdV1exCaQRC6LprC3FhQTxiU
         84T6MLSnL54Vatqyob+dEySqgeeAedSe5foL4nLz40GnsD3mve1JMeSYrXxTAYcV2tQs
         YI1SnKeEmW2KrBPHWURMC9wM6oEZ33Mq0C0SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030490; x=1705635290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng2OfZDJvEV+KTtUP/Iio6uQuCO0WLybP1MXx3qAmCA=;
        b=s933U1E5A12VFvvSneSpO/Ma0dRKmw7tJ3JfAkAfrWJAfgz4Axjt7Aw5aZS8kTyDyV
         nlYEBiR6GrFZXtJn6N/H3Lp7zBZpFoI+FaNfSHC+qbzVgh9470+83Ry1nuYS5DbUbLVr
         R2VXAw2WeQUIQuB7ULpMK2dClnGbUQdS3AmG+J67DWyN9IXD4rumV2EBwW+ZBVMYgtTU
         D5VJF9yCcKFHs3c3g6FdsXbNt0pBcWwNJBHrF6s3PW6j571uUlTMqEy+AA8xHw/YNjms
         w2fUEpzaJ2p56mFc06lNy+Glyz94GVqdXyJ2fY1mgTyfis7MLM16x4UkyiysvbH+G+da
         w60A==
X-Gm-Message-State: AOJu0YzwAnDxusmM/Te/HOvIFJiDwBnrm4VtnnNtf3m5ji1nXJhFFIeV
	JG2f3d4qp42v3RieLuc8Ll0WRs2/fDST/4/oOa1+Sl8WHVn/
X-Google-Smtp-Source: AGHT+IHFtcunXsNmNQWWgxts/QgkDGL+6kZo4yKuvCLxafR3Ah7Vm39mWCaRyRxxzY5YnWKDNJTCbw==
X-Received: by 2002:a05:6a00:a0e:b0:6db:3b3e:7460 with SMTP id p14-20020a056a000a0e00b006db3b3e7460mr468557pfh.4.1705030490339;
        Thu, 11 Jan 2024 19:34:50 -0800 (PST)
Received: from p14s2i.. ([2401:7400:c808:b52:9565:61c2:9ce0:d352])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm2062369pfo.152.2024.01.11.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 19:34:50 -0800 (PST)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Singapore (SG)
Date: Fri, 12 Jan 2024 11:28:29 +0800
Message-ID: <20240112033321.23052-2-me@ndoo.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
  - Update comment about raising Tx power upon TPC implementation to specify mW values
  - Extend (5470 - 5725 @ 160) band to adjacent 5730 MHz to enable Ch 144 similar to US & TW regdomain, instead of using AUTO-BW

