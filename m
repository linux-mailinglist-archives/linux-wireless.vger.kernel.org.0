Return-Path: <linux-wireless+bounces-28963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E494C5C226
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4559C4E9E70
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5DF23741;
	Fri, 14 Nov 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="kxFNtFfy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8427EFEF
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110833; cv=none; b=pNNTYZBgHC8F+Jd/zd4OvmN4QC5B7jBjzzzkLONyLcsgs9GiBUq3ZYVy+XzxZdw8XtDPV0SJpE6e9pkagheffHsBUN3vT0xgohNHfoDjFDiQe5dHvhWiFOZzqI6WGNfhx1LM9nPwT5F4n7gNHvOCKKarE7yQZFSYfBVOSa2FQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110833; c=relaxed/simple;
	bh=2+UjFGYzIZEyCBOztl8SgMmlKcowNMTtHZ6MgQAiYZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6T/rjMmBs3RTUrIRnrBwDLvWL8KeFOpDWjK/6DItSTrhGfle9tHWfC7tcpLZD+sJM7nmCJVgRE6phRxY8jKFuOQdpq5fJGBZBGBT36wfdnziCyORSTXYOEXRFaCQ4Pg30pSlD1/I/4Za+YZQmsRxEr494FzX2FA6DJu7ppGbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=kxFNtFfy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo1637333b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 01:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763110829; x=1763715629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZewwNAzETweWw0yPYxvJlwQljWN9ITM5cUL2olqarI=;
        b=kxFNtFfy3oAAVb4nq75QMG0EFqzOo+XRZ3rQRTr/2OOUVjbeWcjfDl3AN128jOmUFt
         NIPvrjI6XLa0icP287B1kaCk1P0RNPOp/6YuZYkKgCl+9z2iXrGXB3jXs28D3m8IJpCS
         oks+8KVZStXXCquiLkRqyChfX4TztYSlcYOq14jse53+5133Alblw4OM2yHdJ9O7dejD
         GycbHNo1ZLv5+Ao1kB3sN1//Wo3B6f61GOFaKaUtJRnHHCPCYb7a5j6180Z8/J3V5zRh
         FKnKcyEIjfFIayDfmexP2CwbIWWxhlHqYbYNFgLn1QeGQy0szeShhYONA+QPHYmyX1UF
         YkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763110829; x=1763715629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZewwNAzETweWw0yPYxvJlwQljWN9ITM5cUL2olqarI=;
        b=Kzy13MD6VvQqhNi9clQYLy0diWZwcMiZ6gKMQnxovCvczIh2TtyFCSTAjRb4W1gyDu
         bf6dE4xNchwQpe8qnR1aJx4NTA7oD0g649dA8dBeE0zrCLTRYkXosxGmEd7jQbc4yiMx
         Kg3TKSgb0BPv/OTIg0Ge4gU0FLamfkdAkw96wx5oCBBkp71U/rMFm0JtREgJrOY+kpQL
         HXLSiEuVixEf5du5wQ2SmYdnGd5wSasaRiepCBJU62iQWrJxSedtUOzREZKZoJs1JPI3
         hI2T8bnXm44M1sIjRzzxlnxzUEZSxM0a0GIsD5mf9uSgcakGAmLV2XLlIXrG3wp+p55B
         Mc0w==
X-Gm-Message-State: AOJu0Yym1I9xjvp8i5urZ+Cos1/aiM5cqgTG36eKxZOqxEtxMPknKcfk
	Sh2jWbezGYUUTmAP6t3DRTSFf3q2Jo2reHprfRa9AToFqdxUAuQyQwpwHEjXlRlWAdUi6hosPty
	8/QBm+fA=
X-Gm-Gg: ASbGncuwvnerxF9TPf12Jd6DiFY6kITJZKWnHDlJUN+Yw/3plxMxPiBDGgV6xPLXAqU
	BP8azgsUfAVh/oMgMLChQerlOwEAJgzJN7nhEqNyZI3wR86++9QSDEY70dK1W5sxn9CvbF/WgoR
	fvJU/+hCQJsjW3cfJfJDWJ3G4XJEVl9FJwQ5vWTRhhS0D86EXxz64mjUXIoU04ME4eiX6eqmiQf
	rzGT0I6YzSWUuGgpf5RCcmxhxGWeBTs1eGFMztcLD2x3JfiAlbFwnVKS86DqaGU3X2QHiI3vY2c
	6ppJ1+43MQJIhSm6A41Ls5C20dB7o3bqUqFfTrpVL20MaCp1tNrLEMuLslPR9Xc8IkOA9NSvdSl
	wAx9Y1UIsty5SznoPV+/0s06lEcM5G6h7fHvuCVdnx2iG/x687fPe3TC9JlfDod/VvbfvLCquR6
	1FOQ==
X-Google-Smtp-Source: AGHT+IFhGjywM35ZwDhP0srruKUJXDb1u9uEYIDHQXEfJKwtPZ6TzvEH78L6D146tcvacAXmuc32ug==
X-Received: by 2002:a05:6a20:7d9f:b0:351:d6ff:dd0a with SMTP id adf61e73a8af0-35ba259dd93mr3672354637.49.1763110829109;
        Fri, 14 Nov 2025 01:00:29 -0800 (PST)
Received: from essd ([103.158.43.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21e8esm4148621a12.5.2025.11.14.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:00:28 -0800 (PST)
Date: Fri, 14 Nov 2025 14:30:23 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtl818x_pci: Fix potential memory leaks in
 rtl8180_init_rx_ring()
Message-ID: <7sj3dofsdl2itsjll5atntvddigztn375czobtmq2ymxeezsir@5me2m2pjbgna>
References: <20251113165851.39054-1-nihaal@cse.iitm.ac.in>
 <dc6974f6c9f04ac68d0b10a427b0abd0@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6974f6c9f04ac68d0b10a427b0abd0@realtek.com>

On Fri, Nov 14, 2025 at 07:20:05AM +0000, Ping-Ke Shih wrote:
> 
> I'm surprised that people work on this old driver, and how did you find
> this flaw?

I'm building a static analysis tool for my research. This issue showed
up when I ran the tool on all kernel drivers.

> It seems like rtl8180_free_rx_ring() does all things you are adding, so
> just goto err_free_rings?
> 
> @@ -1130,7 +1131,7 @@ static int rtl8180_start(struct ieee80211_hw *dev)
> 
>         ret = rtl8180_init_rx_ring(dev);
>         if (ret)
> -               return ret;
> +               goto err_free_rings;
> 
>         for (i = 0; i < (dev->queues + 1); i++)
>                 if ((ret = rtl8180_init_tx_ring(dev, i, 16)))

Yes, calling rtl8180_free_rx_ring() is much simpler. But the error path
of rtl8180_init_tx_ring() is not setting the freed object to NULL, which
could lead to a double free. Moreover, I feel handling it inside the 
rtl8180_init_tx_ring() function itself is better, to have it allocate
all or none.

I'll simplify the error path of rtl8180_init_tx_ring() by calling
rtl8180_free_rx_ring(), and send a v2 patch.

Regards,
Nihaal

