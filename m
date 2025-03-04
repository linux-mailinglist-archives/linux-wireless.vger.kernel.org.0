Return-Path: <linux-wireless+bounces-19743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A463A4D3EE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 07:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57091894424
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB81D7E35;
	Tue,  4 Mar 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="bnqZxSVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1621E3DE5
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070013; cv=none; b=TqmxS9h7GLwwz+ynKWc6leB0+6IQv0pt0nyjK8E3qlbdxeAXhz0beK74vM/ZTFsxZxVYSrk53WdUsXdLyqWA0QFNW2wkkyKBkTQ6C2UX2QYhepUzLtzpzDWqCLgOlbc7TRm/1RTqyBya+UEuOA6RsW7ASQExCcna4AymE0rR60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070013; c=relaxed/simple;
	bh=0L9jk7jDl4R7Tch+PFoZUAPpOUQGpTxhl+ZUFKtbat4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH1T7gXHs4y0wpeQfnY09fD6RIZNXQPSPQ/HEVA6OoTmhsCjHrDBUm0seN4U2DULmhc0Ogcx+AfNfsch6JEeL4E1IUfmvpItszHqgnFEjKWeky+jHAphql3mPjT2jTzrJ7i4OV18a85dPwG14WH6V9zhCwSoK4D5rK3oxEl1VEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=bnqZxSVb; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f417de5e25so2585026b6e.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 22:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1741070011; x=1741674811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L9jk7jDl4R7Tch+PFoZUAPpOUQGpTxhl+ZUFKtbat4=;
        b=bnqZxSVbDFqNV6psdfJMuqY7320OSzHiUmp+C+40y9qH6vFrEW1Ssl2+cLGfQrGruR
         PUFWUTx/EEsgrFP60M4b8YzeoNqeiOM4bbc0OO2GdNQzkyKA8DhXKNK6DlVcPl7TtT9v
         fMdX14sFXve2KCPt5IMx/aa+EGDgyDX3zAETAScAT7miq97JiFTqVAxQ05Lvm/+LQ2Vj
         kDL7Fru70kaDNczmGIjVDFLa7Mkh4xrg5IVn1QMP9MS1H+xaVGv9jcbaeYZSAELWHVUu
         mQBwfJ4v6jtcO+OdErZExycent1d0c15q5JkyPUomkW7u7GVzPuRVOO6nFR3GUUga5uS
         I0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070011; x=1741674811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L9jk7jDl4R7Tch+PFoZUAPpOUQGpTxhl+ZUFKtbat4=;
        b=nkLCnZiSZ5KPKtkmIUFpnnfnRCI04eGIqBr/nuWj0iIvGHlcoldvCb2QVuM/Latt3c
         /ISOxJHS1h+/9RD3Bp3eQMM8PQe4UwUbsFMVA+TgY5r0ntwq0fvAkGQnZxXPsGch2SNA
         VhzF4KtsfhKvm46j/+UFT0vWZzqlKtuCh5fIoI15ERwf7+3X25jXmVrvMZIH7N1s44j/
         9cOqBxMmktlK8T4MKQFbS7dVp7QRTxaaY5EnWLifshgq6eeKM1hPjqRcG796uvd7qVYm
         9Xk+Lc9Ylhv3IwC5okkPPSlI1nS5AHW0IBDdIAqqHEkp9Y3ZU23panO/aXjA7QWYtE/3
         V6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDhW3+1eF4GUSMPKR/shohL7TKNm3iEIPsUt4svVftmkSKkH2MiX6L49qRhrq7POdxLyx5Nq5ekw1sd2sgBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9aCzX1KVMuoorv083bSEsV1ettlvbVMbFsCE7jUId3ZWepIH
	GDFjuZBcnTw0Jgo5/5sUdmpBBd4zginLnDCzmpzIUSTtwQYlZZ9m6NZsge+yF5k=
X-Gm-Gg: ASbGncuP2O32e0jKCHONazwzM7mi3ozTDDcTX/A1mK/UNeIooW/DggDr/iCLueguuSz
	VGxzIrleFUZjj/DLpe/xWFNgQ5RWvVQtSxJP5UZbmbJ+kdArKR2VdBtLwd/KX5bq5Fkh34iiuLq
	WtXNjR26bjCCeKl494XNHSrzDMnfQOeNR3icSfEF7PezQvMkVFyOcLt+fFJ39F5r0X2INRJIrS1
	bbY3c999WWvrJY6yYLFDCxju3JSmpsQZ6PuiuZayzOHaJjkdA0crcp2V66S3USP2kYQ624z5zSX
	o0lXiSZ1LD8WeRDKsECTo7Nr9sr8NeBeOcYBAuorp7GZ6queVSMwrpeeyUJJeRPoUnUzS2KagQY
	/zduQ7BxDLNUy
X-Google-Smtp-Source: AGHT+IF836u3HRurnaD3JNQQMkTOVJFkdb7saaYaAdjJKb8CcB9Uh6cD4rojnwwaZzpJu95yORRjaw==
X-Received: by 2002:a05:6808:2e96:b0:3eb:3b69:8ff4 with SMTP id 5614622812f47-3f5585254ffmr10749480b6e.15.1741070011245;
        Mon, 03 Mar 2025 22:33:31 -0800 (PST)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f66e8449f6sm539684b6e.1.2025.03.03.22.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:33:29 -0800 (PST)
From: Steev Klimaszewski <steev@kali.org>
To: hzyitc@outlook.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: ath11k: pcic: make memory access more readable
Date: Tue,  4 Mar 2025 00:33:28 -0600
Message-ID: <20250304063328.33762-1-steev@kali.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ziyang,

With this patch applied, on the Thinkpad X13s which has an ath11k, I am seeing
the following:

 ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c soc_id 0x400c0210
 ath11k_pci 0006:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
 ath11k_pci 0006:01:00.0: firmware crashed: MHI_CB_EE_RDDM
 ath11k_pci 0006:01:00.0: ignore reset dev flags 0xc800
 ath11k_pci 0006:01:00.0: failed to receive control response completion, polling..
 ath11k_pci 0006:01:00.0: ctl_resp never came in (-110)
 ath11k_pci 0006:01:00.0: failed to connect to HTC: -110
 ath11k_pci 0006:01:00.0: failed to start core: -110
 failed to send QMI message
 ath11k_pci 0006:01:00.0: failed to send wlan mode request (mode 4): -5
 ath11k_pci 0006:01:00.0: qmi failed to send wlan mode off: -5

I'm pretty sure this isn't supposed to happen?

--steev

