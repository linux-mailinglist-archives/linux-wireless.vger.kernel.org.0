Return-Path: <linux-wireless+bounces-21563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CAA8A806
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 21:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCBA1885624
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C952505DD;
	Tue, 15 Apr 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c6q8v7qJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B992512CF;
	Tue, 15 Apr 2025 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745507; cv=none; b=nBNdLaz3fHiGM87sD4a+tDskbAs9KRgul8ZB8XchKmd4o9ZSlvlRdWUoRVxkBtQgaFSL84TSB//Fvx2yT4rKgkbmRpNS5OYvRheeO0tPR2j9JF7FT4jw78BeCp7g13NIyuXy5TLd7tA43IZRF9FAD6BRLV9YLBvfvXvEB2kpnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745507; c=relaxed/simple;
	bh=uXrwHriue1xzFcX0NlnL7L4va+Nr2MvYO+zfZjiUBSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBNhBY6RBNX5rOyenrm3yFABJYLh4EsM8el1/lA2NfCYSqMkpQBtAl86s9Q7zpIovxvkxip+4RbexT01DWVWjGhrqOKATQtYcJCsoc19hCCKhyUPTSmVhAcn0PUKPG78MgiFwvS3H9kxIllYbuZBzdF2UvVRxNunlzApj8LViTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=c6q8v7qJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso3775ad.1;
        Tue, 15 Apr 2025 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744745505; x=1745350305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXrwHriue1xzFcX0NlnL7L4va+Nr2MvYO+zfZjiUBSg=;
        b=c6q8v7qJG/Jc/8j8tvDuvsKJQoiBql6hie7KvxTXOHbaw+H5W3mVX4UNuo9iZ9VA3H
         lce//ibmLinvVjBDGgYE9h10iStqChN0ZKlXsDx9mG/h9VDuwM3kAXtSkHT6Q21KDXHA
         XTLQHg4sQYybEntOOPUJ/nkg/pQCT/mM0VfNDxpyc6FB2cnMEe+pBdi7yMBgLljWUBo6
         6W+m5bDx8wfaS2finuvSrtmoaIWFC+/7LeiJ9pzOJjEYz8h0wh5SXZGcaV8/J+WdjtKi
         EZeQCuITTdf9BquNKRBC9O6V/yKTA3u/gkQNv5BfvDDggiNXcLmWkuZLr+XvQZiesXVl
         /9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745505; x=1745350305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXrwHriue1xzFcX0NlnL7L4va+Nr2MvYO+zfZjiUBSg=;
        b=rl5Sn4Lltdeie/fZ5LdFI/WS8/WNKuV4BBzMDeddWQMHWWxY6PbDyyuVRkxADlhDcm
         OwarZVAUCV2EnfBQobxnIGRMPfbRxuF+ydvuYfye2+WxdQMQzYSU1HKl/XjtY+Y4Sy4V
         nBiGJX0ln/GSq9Nkv3sLrOq/rCIbBdw0Q6Y4LzjTpJqfv7aIzNY/5LeCKcf24IdG1r6y
         CI9SQmMzTOAV1tBo3Do3Fejmai6/KAgPcZaTb+Xm+sCEIby4m9b4BvnDVWH83iZL6QQG
         7ttTpEnzDb4TNMX6PFyuZh2/1bVb9nNLq/cI6yzYSYepw1uklBzGVtvYDm7zHALlJkXI
         n/yA==
X-Forwarded-Encrypted: i=1; AJvYcCU/OLFJ7cHUS9flQr7El8WqOT861J+r3YBJH1gubI4Ujq8zUMMSCSWoYxAQIa9XVGYHRyIhbke7f6DkDgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxamAieCyMcy9Xt5rOLqSFCqq6ooo2/ZTUDoQjsB3RO6xAht3v
	aX8LM9P40gPFMd9dIElfHZyVrRpLTUyXH7Q6u7DxZuRTiUta0Qa7TM2QvNUV9RNTLC49eih/KsF
	GbMHTzcTe2JBi1pM6H5reNRUDmMYjgdmU
X-Gm-Gg: ASbGnctGy+Rcs7coGDqcN+LVugtPQpItpA+r91yppLDElYWF6l8gA4/bYvoD3SUMc78
	7VQGeLoGjPULVxAVUI5vSx1/Suc8dJB9AB7y5Uu/dy7xrhqTBaxEte/JM92ORjwu9Q7LFrELimQ
	pf6n5alAFCHi5E8ENPJnTShC8jIAvJ08xgcoA=
X-Google-Smtp-Source: AGHT+IGQimAHQywtuph0ZEiNuyta8ZWk38tDuzyx8t4xoSPIQI1oj5CZhpjrv2kNypRqIcjiDpKHDIsy7Vamei/H5z8=
X-Received: by 2002:a17:903:3c6d:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-22c30cf9994mr10480955ad.3.1744745504687; Tue, 15 Apr 2025
 12:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com> <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
In-Reply-To: <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 15 Apr 2025 21:31:32 +0200
X-Gm-Features: ATxdqUHuvaE_kTWnp1pw1aEWxbeqUvrLcUHl_SDv9pR8jWo7LjRdHj175WC1HZ0
Message-ID: <CAFBinCDVd6eVFcDzP1N8ayS6OmVZng5ti2jrHfYkbqFY4BdfLQ@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
To: Zhen XIN <zhen.xin@nokia-sbell.com>
Cc: linux-wireless@vger.kernel.org, pkshih@realtek.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 5:46=E2=80=AFPM Zhen XIN <zhen.xin@nokia-sbell.com>=
 wrote:
>
> Rtw88-sdio do not work in AP mode due to the lack of tx status report for
Ping-Ke, in case you want to keep the spelling of rtw88 consistent:
can you update it while applying the patch (or do we need a v3)?
Same question for the other patch in this series.

> management frames.
>
> Map the management frames to queue TX_DESC_QSEL_MGMT, which enables the
> chip to generate TX reports for these frames
>
> Tested-on: rtl8723ds
>
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

