Return-Path: <linux-wireless+bounces-15036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B99BFEC5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE2D1F22691
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D1195985;
	Thu,  7 Nov 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdoeqA7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF3802
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963233; cv=none; b=aC/Tl/0aBQusDtxaxbkrC7uFWC2SGl7lEot6v3FgDUF/eL8AvNr2yv1kfjKhUNWEqxNMLM+eSmOOR0YoTOykUOlC3GKJbfgACVU8TipcygxBi0azecwwCq7uYXtxoFKCtjv1+zed2Ea5UeKjqzjMSyIOKCIvN1Nmi11tcP7lPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963233; c=relaxed/simple;
	bh=wHOIxj+8w3p90uKoUrKdvo0IqQru6g4KW5z+9GrrHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNHwyNnyYsfKQ/ERmpc7SDvKjWTKpFniA2WHmn+rQizOSvv5yNW9aGUs1ii9Q1m5XzYv4rLqvriqd7AUijETF1JcJj5PpyWkAk4iCdZkhx8WyNLK/xuwKdGac1J+rwdIdYweFOqIoE8O+BCCG/EbYCs5boqyC0sRfAPn+RyonVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdoeqA7o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-210e5369b7dso6383385ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2024 23:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730963232; x=1731568032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXwvkzuMSWisEHYi6gtfRWt+2t/5l3MicfA9CZimLuQ=;
        b=MdoeqA7oz3txLTh3AOPdf1ynPQi4It/mMt62AM+YZaMQbwVlQk8ivo/7u0O2dK+8Gy
         rigmqG15QyaOlTDcGtImOdzq3DsDdHhHKgc2suL8phtFszMN9AiWgHmt1BFg7Acz8onj
         bh6/N40EBdjgDCoFFQ1z2gVJp/F+S3VOpiyEg49wNcJvuXjdhRnjQYwPOC9PamGKptJj
         QzOxcba4xJsYeruCmMnM9F/1HRoIgYrx92lIdfOiRn1X7cLCN8hXf3UtXEUqFkzi/JzJ
         q+Uva/gVfHrvvXSVeAcS79+vfVoct6DAIMJfaxauZlxdSb6ARcInPBxBdW+A99hxu7KP
         v+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963232; x=1731568032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXwvkzuMSWisEHYi6gtfRWt+2t/5l3MicfA9CZimLuQ=;
        b=YaU/ZJoxJ112uH+lpCvVbm7KLLKcrwpc3H76t9Xs/E7zHrDMhCpwy7pBiBMpUZV13T
         HqiIH0auYIoARFytkt8czguQNb0Q5qo/hCoYxFI8AqlSi9lVM47GCla+NwNIhyAMZmFC
         oJVgheBBVS87hMWo+k/bJpfuE718ADUrLP1hXZ+lGcPrFZJKBvGVZhRvQ4LtxVEfplLj
         9QTASzcHRCZMKepEwrcfEHIdAToHRzOAp/6ihp3wTYhq83+5hk1YGQ2udLfbCPXptMxQ
         9NKVDD6VbinGReCxOTnvKhtpiMUcV/aRwENveb47zfULLElgjbdVSpWnEBePuI0FZzhQ
         PepA==
X-Gm-Message-State: AOJu0YwEXIONeXb6g6AJXiJe6vtA5dTvJLpk4hvFczybr/v8c5+FQeYu
	zTj1NliAE7nHb4jc/PuAlbGO2I4v3yJE5Ouxg4iOp/Wc6vfkXkQK
X-Google-Smtp-Source: AGHT+IG7IOCRivpdcJe2O+DzhjtHX7RPugR1UINku9p6l+02xj3o//FPA3Ns9jYNQ04QZBy3n45vbw==
X-Received: by 2002:a17:902:da83:b0:20b:5ea2:e06 with SMTP id d9443c01a7336-2111b018c41mr302354805ad.56.1730963231495;
        Wed, 06 Nov 2024 23:07:11 -0800 (PST)
Received: from localhost.localdomain ([1.200.146.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e45ef0sm5621315ad.153.2024.11.06.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 23:07:11 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH] rtw88: Add firmware v52.14.0 for RTL8812AU
Date: Thu,  7 Nov 2024 15:07:07 +0800
Message-ID: <20241107070707.1438-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241107004830.14261-1-zenmchen@gmail.com>
References: <20241107004830.14261-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This file contains the firmware for RTL8812AU and was was extracted from

Hi Josh,

I found I typed one more "was" in my commit message, could you please fix 
this typo before merge the patch? many thanks!

> the vendor driver v5.13.6-23-g232107d9b.20210820 from
> https://github.com/morrownr/8812au-20210820

