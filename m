Return-Path: <linux-wireless+bounces-12904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DE97AC3F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEDBB2BD2D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D11482E2;
	Tue, 17 Sep 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="kf6jRO5S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A507F477
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558561; cv=none; b=YOU7LuPa7kcONKMVeXcN9ooSDTDVFKqqYXknuHCR+iV3HV3+wHO9Vrg5dIrwIV4ChJoBuRlstmQaOiFZrrYGeUaKRuFugL6WyamKt7MJGVD/TSQ3++J5xwJLM7mJ6lKVYr+DPR6yLApZS82mDnXl4u5JMvvh9BXjOB3Y7qC41Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558561; c=relaxed/simple;
	bh=biDMup2XPeaQwwinze++JiPkRnA72RkGr7r/hjf3XHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvbdhajVlKiPmsCA5brrF6WI+dSCvysL7PZAzEFbLRYZgtlPRuDKtQ6ZOdD9vlN/J1D5MtODJwvYv9HHj3oaK+S4GAjbbhgq85A4kxeH1Xkn3x+tc5fcTOQPx/P8nbzRINAVK3q0Q6Np4f/YDt9MDoExMC6NcwVA+3/2FTsmK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=kf6jRO5S; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710d5d9aac1so1979859a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1726558559; x=1727163359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXw1lYT02+0Vf8ziiUOEHjvxWnQaB5EzNlXNmrfYuRs=;
        b=kf6jRO5SEinBTeJ8zUjTWFjE0BwATDtVtvNTgavzSMZlkgGx3VHM//RcVXL1VaWqS1
         NbvnisRT/pSC9bIPFWiyujIb1eaK7nILIB8yOt2KAEQB0CNQS2J6FFB38OL+Yg4BMiIo
         1O8aF1RWuurRWqTnsw/AbWsVRhu4CHGu0gDmpuTOqhViphYItBaegWvBt+pCd1hXaxTe
         2V6N0/iwnyaDFNoPd05YxRDu/e1iiFvDckDJ/O0CjQ/3GRdMM1xQd4kXDmDIxSumufyW
         MY9HGIwxMS/CklJwF/9NbASGQHmanYT1XjzE4tt9Bb0eV8LiH81BUe+auvkQUaN9adIF
         YjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726558559; x=1727163359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXw1lYT02+0Vf8ziiUOEHjvxWnQaB5EzNlXNmrfYuRs=;
        b=OkC9w4osiEFPKffHBwGtHQFH7d7PEzXirl2o5YN3opSpSicNwIRp4KllTEYj8rlwV4
         TBEYGJePCPIqOhia0WId11nZ6fD2PWG5nHHww0jmbNLNO7t05OdWG0Wqj478Hpj0GOAy
         KH2r7/4Nf7tIG4d6LlqottpOFKUgzUqMXco3Srgb+NQlhGr/b9aS9rcvHC+2zLqJmsRv
         8YpiWm10g+Mf7ZcIvDd0CNA2QYGQS9dqbZEu5JSh/ejX9tK4VG6vhNzkLAzdJnM+uX+S
         XGPFyekqKojg7ApOlQbPnB68iBKXJNiaQpddmkMRsvAs4T8Ib1hqqp3FgLsL988ZXSEh
         /ZlA==
X-Forwarded-Encrypted: i=1; AJvYcCVJM8MGDqf5RTQd8C3uyi2bfOpNo8WFmgHTMVdUJwam/RBxMCWJFMX+kvmNcPH10ybKyLBQdmeq6P0vMpLkQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVsV7vHp0sSgBJPWd1Jac8p0v1nklYVhyHcVX/ElPKK79CoV6
	R01wqHBu0qroJ9jfI8gYutW9dLDDrkOTe3UKYJeSrgjmPaLNFZLgzgKBH2Gfz7xmfZ7edvH7eGJ
	cMZw=
X-Google-Smtp-Source: AGHT+IEHp1vDwgtZRHoFKFLtTTznHVKZk9j9Bi+KqH9oQjhZyv/HzyXPI0TsB5c9yQz9Aw8c/pAT1g==
X-Received: by 2002:a05:6830:620b:b0:710:f287:7182 with SMTP id 46e09a7af769-711094fc683mr10497896a34.6.1726558558918;
        Tue, 17 Sep 2024 00:35:58 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71239e9fee0sm1398011a34.30.2024.09.17.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 00:35:57 -0700 (PDT)
From: Steev Klimaszewski <steev@kali.org>
To: kvalo@kernel.org
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	quic_kangyang@quicinc.com,
	Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH 0/2] wifi: ath11k: fix full monitor mode
Date: Tue, 17 Sep 2024 02:35:47 -0500
Message-ID: <20240917073547.99604-1-steev@kali.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <87ed5kaxxp.fsf@kernel.org>
References: <87ed5kaxxp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would also like to know this.  I have a Thinkpad X13s with a WCN6855 in it,
and I've tried going back to the .30 firmware:

ath11k_pci 0006:01:00.0: fw_version 0x1106996e fw_build_timestamp 2023-10-13 07:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

and with your patchset applied, I'm still not able to create a monitor mode
interface.  Is there additional patching needed on top and this is just a fix
before that comes?

-- steev

