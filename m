Return-Path: <linux-wireless+bounces-24254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7EADEE79
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487CA164AE9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D782E7186;
	Wed, 18 Jun 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiNzpnQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BE1C6FE1
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254837; cv=none; b=JwIZgz79kxloDABA02nFmpM6Babh/7MN6I48x4/OXJ90OoQkw6P7BzDKsJr8wWTJWTfaRJDcolS5y6Y99sZR8JfnAblPdrMzPivdZI6mb3HRBtZEjcA3hCIQJPgsxEGhaSU9boYqXzp+eCP/EG8YxMzb2WByjRQkjj7mICOAy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254837; c=relaxed/simple;
	bh=Z4V01MLZESzwGBkAkImpp7dlu8lBl2UODevc73mSn8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=snwrx6UV9L6ADwdW7oePKZrOAfwdClZsvP/XtHeOEi7QrA9SaoKcqOVLgJ2A0Q3ANVHNnwHkd8+DeuHocCdXAG9l1f+pp3PosZWizTTCF4hbJVOoju1p6UONkUjU7H34EehrxRapjruxTze0ud3ZPkGNKS5CxhDtDug9259Z44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiNzpnQu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a365a6804eso5228043f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254834; x=1750859634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9iHFK4Wu3lM+7UQYCc0HlsoBIPTA/6S25BUs4Czy3k=;
        b=QiNzpnQuDiAUBbvixydQg0txAZkVKmVpt5fDifr6jLgFxgXO/JUJqYOp3oQpuZ0u2D
         AuKRtwLZbCWcQ42WvNqR4uPZxOh4aIYemRCa/YtFi4ZgPyzKDGpktg20FZlyYXABC+a+
         lSZkTbnEWWd26nXcb56bhnmkh/vgINeP2IOWhXbsHwdy6ahW+QhzMoKmHqMadQQxoJAi
         zjjnQvF0yLICgZtB9N7msC4q9rdlErs1/d8nnZ0rtqAaMEjn5ciAsSXJZt7fadQ5ShH8
         pdy0jG4HePRoRFs+F2HZRAqvtoJwoHnc1249elkeUwgL1Z0cO8ptfA0BukOWTxuEKji9
         MAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254834; x=1750859634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9iHFK4Wu3lM+7UQYCc0HlsoBIPTA/6S25BUs4Czy3k=;
        b=pSnidwl4Ij/5bx9MqqxiST5JUs4n7qzgZVi/8BEe2DDXRk4hZsRGgfWoY4mrMOCQGw
         uVBqoNsPLBKrFMAtO3VHbwI2kO550zjdHvu5Utpo3A51TcDeUa30qqp12qtvwdsQUxrA
         phOx+HvbqN6Y8zalS9yU7aJVB0yLo0cfSla8CNyhpjTb9etbvb4T+4xGSkie2FzB+bfI
         UN3DbvqiOJB+2srvSDS36cIgHBC/GD+C9uT2Hbx9b1NgkXhG1XYBKp/3oYWbX3Z1Ew86
         2Idl2uvUkprGW1XToorquicXED3VPj4akywM71OT5VlgWxBQblxqwhkrphq3I61xzjbB
         wNBw==
X-Forwarded-Encrypted: i=1; AJvYcCX6aGyY551s3KadxKbgcEpF69oEAARmXbaoPOhEAYI5T/OYSkEmZAm45J8RLfHQbubMclAKGCpQ5zTTYfXJlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHORNOKetV49FolrluAX37YYW2IMMQlXdet29M5kondMx5D9c/
	KI0cKEJiLNEihwPyBHaUO6RnkenhiDSkRFFq/RABZND4V3QlJ3A4ncO1
X-Gm-Gg: ASbGncvR3nj4zbzDWzOMetjyefYEvf+Pw3QSrvBfD9iDbAhvoU3ODtzuiVVfEWY0WWl
	q3RqOC1jJj4iVYEDoBN3ieEQD9oDGi/515+XlS3slHwRrKyC3XqMDQ4svbt/IKegE2PCxK0ab25
	cxLcxZOv5Pg3kIsi/43B4fUc4kXJIHT6qXZIa3xXFSBteRoO56cqslkhELgY9spQ10n5SXMekUJ
	7anHvYixiePO0oJTfwTPp7dJy4h5V3up0fn3E8outUP69SgnOIrk8OrjRalBHBf4VDXDUN3dOXz
	LqMz6Cp5qJsgf4jNIutIu5bqOnZriaqGiTBtDkDmTgKk96H8pJErNi3cTjFawu0QSLSAxw==
X-Google-Smtp-Source: AGHT+IE2NePt7SqUHQN3Qm995fxHtxJAbY9sLV64LWUkprEHVBtBPdCQqCLDoMxBanurtf62RxCMZA==
X-Received: by 2002:a5d:5f95:0:b0:3a5:2cf3:d6af with SMTP id ffacd0b85a97d-3a572e2de24mr13606750f8f.45.1750254833397;
        Wed, 18 Jun 2025 06:53:53 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b3c0d3sm17036621f8f.79.2025.06.18.06.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 06:53:53 -0700 (PDT)
Message-ID: <9ef72bde-58b1-46ea-8e2f-798978674a4c@gmail.com>
Date: Wed, 18 Jun 2025 16:53:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <c1ff2155-ef01-466e-9c34-4437ee57656c@gmail.com>
 <deb6c812cd0e4e00a513f251e62d2f81@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <deb6c812cd0e4e00a513f251e62d2f81@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 04:51, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> There are a few differences in the power on/off functions between PCIE
>> and USB.
>>
>> While the RTL8851BU appears to work without these changes, it's
>> probably best to implement them, in case they are needed in some
>> situations.
> 
> The difference between RTL8851BE and RTL8851BU is very small, so it is
> reasonable to combine them with conditions of hci.type. If other chips
> have much difference, please define array such as
>    pwr_on_func[RTW89_HCI_TYPE_NUM]
> 
> It would much easier to update the changes from vendor driver. 
> 

It looks like RTL8852BU and RTL8852CU will need very similar changes.
I don't know about RTL8922AU because there is no driver yet.

>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 


