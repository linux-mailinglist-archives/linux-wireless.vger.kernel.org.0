Return-Path: <linux-wireless+bounces-1980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DF82EFF3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC90B23279
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741581BDC5;
	Tue, 16 Jan 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9rRJPdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B61BDC4
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso1849255ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412807; x=1706017607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RXSZ57asIJ1S9ZoFWjiF7/5GzY/vykrABpUUkh6oFg=;
        b=l9rRJPdKl0cgth3LA70brNW/MwllcGqCBnuuW0eLElQm64Uwu1+/3i8KU2cyq9GN2m
         CC4aR989vonuJQ0NLF9WqgwkcD2Ehx1Wb+Xd61PMJcc2edqu+A1K6B9fkzAPNeOZM4kE
         Pa+/xohkuuZnYFYBUmtXiXCinZNYFAvseImUWl4zfhVOCaM+4Y1FjXVybTkhrE6oBcS2
         DcxP4QyPwVS7U73bU8ZMEfnsVbv5HWF77YigK/k7bo7+m2nvS4bbVnmySBvnzEkr0E/o
         qTLDFrJ9W3JAaWuIRCq2NUv7wiDBAkCgSFQfF20HY3rqp+d/e+0Lm0x0LmL9f364iNsn
         3WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412807; x=1706017607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RXSZ57asIJ1S9ZoFWjiF7/5GzY/vykrABpUUkh6oFg=;
        b=fLRS0tk4SWcwLpWnZI0xkCTweryb0WuMjH2V/y6/lXxQgJHj6PfAjlddqS+ZkCEzXz
         dTHn2kT5Hq4FyPml2H6EIm9DitAgqNTdMFCRrD3jrGPkVvYwdLmfLW2tbD1Nlf2mxFke
         q8MRPyvPIgdv9qWwOSjyLhsHVdKXQdInK5E9EPj4Ntd2Ls2Drm5SQ8xKEUFMMZ9aotu3
         Su2Q0bDmVTUCmP7TVpbteWCGj/b2D2yqgtpXkd8/LlUjt6LPTeOAuIVdGFz2Ulp3c3Gw
         daC00oyB9If0xqLvYSXZkYERRzQKJqhNFDXp9tn9E50Odg+KZGp/8P4q5wnLSB03nqRu
         5UhA==
X-Gm-Message-State: AOJu0YwZoCqx+E2/Y1LJCePKYnrLRNeeushquu2UAuky6T1RL7CBQ3Xw
	u0mHGOTuneinkEv6q4S/VdqsYUzU7KUouYDF
X-Google-Smtp-Source: AGHT+IHRppKr0SMNo/eHudKhEiz1jm+n5NZW3iFKEoYdAzvswNLqzXjZlADJzddWzEgMyheguiyMGQ==
X-Received: by 2002:a17:90b:344b:b0:28e:7baf:6fb5 with SMTP id lj11-20020a17090b344b00b0028e7baf6fb5mr378285pjb.64.1705412807085;
        Tue, 16 Jan 2024 05:46:47 -0800 (PST)
Received: from localhost.localdomain (125-229-200-221.hinet-ip.hinet.net. [125.229.200.221])
        by smtp.googlemail.com with ESMTPSA id rr11-20020a17090b2b4b00b0028e821155efsm1124761pjb.46.2024.01.16.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:46:46 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: martin.kaistra@linutronix.de,
	Jes.Sorensen@gmail.com,
	bigeasy@linutronix.de,
	kvalo@kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH] wifi: rtl8xxxu: add missing number of sec cam entries for all variants
Date: Tue, 16 Jan 2024 21:46:42 +0800
Message-ID: <20240116134642.2898-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116095001.399500-1-martin.kaistra@linutronix.de>
References: <20240116095001.399500-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Hi Zenm,
>
>On Tue, 2024-01-16 at 10:50 +0100, Martin Kaistra wrote:
>> 
>> Commit b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP
>> mode") introduced max_sec_cam_num as a member of rtl8xxxu_fileops.
>> It was missed to set this number for all variants except 8188f, which
>> caused rtl8xxxu_get_free_sec_cam() to always return 0.
>> 
>> Fix it by adding the numbers for all variants. The values are taken from
>> the vendor drivers and rtlwifi.
>> 
>> Fixes: b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP mode")
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> 
>
> Could you please try if this patch can fix your problem? 
>

Yes, my devices work fine now, thank you and Martin for fixing this!

devices tested: MERCUSYS MW300UM (RTL8192EU)
                MERCURY  MW310UH (RTL8192FU)

> Thanks
> Ping-Ke

