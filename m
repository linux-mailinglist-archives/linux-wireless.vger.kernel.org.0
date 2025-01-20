Return-Path: <linux-wireless+bounces-17760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D0A17200
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E7E160F15
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5771E3DD0;
	Mon, 20 Jan 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O+rqv+h9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF754438B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394502; cv=none; b=SssWuoEpxitBnSA5/Nap9jbIAgowkV04U85P6rJ+f6Q1Sb3IlNlnB6YDGohXa5VIEpHhxPO1327p2wbBXDwh90Y/H4BDpDVRy1Ty8dCvSG5HhEzA1kcpgl7WtpnqYMWZkuf4HcWNmrZWytOxFen08YnpXZa/XUIO4QfOP2kyBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394502; c=relaxed/simple;
	bh=6d66yM+xgDJutwLyOnyWoIMPVsEQgmzcnobANBv9S4U=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XldKzBYqGqL0hLmYfTTIIJbO2xONbQim6B63h3WiyoBmLAjKKnpofSnX0f1Rn1EfICZ6YyQoTttdnFhQfzv+KpWPgKL8ftnyOo5uSBzFm6ANcChCJSYvYM2jgVHCX3O5eAreN2WnJqhy4SDhUEyhz54tK45UA3ZzbpmWscUGALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O+rqv+h9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso856309066b.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737394498; x=1737999298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5kQ7bmCIJ8FWDhkXOqLPHsLOMSM5XeSP5R6rXiP8aM=;
        b=O+rqv+h988LHDQkl7hREsNE1qPv0+RJfZ2eyc1jilwFBlsRYHCB2Gdg5n1SC/PUbF3
         2c7Kujg7P6f6tJoSTWHNfbDquzDTpiybMFbJfrrxK0YmrzhJQ7a/ByhB2YWwCL5blGKR
         0RCl+04LXD9l40nzqUPTYzEkBb89YZV4rrHZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394498; x=1737999298;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5kQ7bmCIJ8FWDhkXOqLPHsLOMSM5XeSP5R6rXiP8aM=;
        b=gNR/7y1RJQJ9drDwyzhoDiOwyog25z0cHLjDedk85fPYc687s4htSNQQmvz5kGokJx
         yaMQq+/anX8j58FVZfa1APEtliAl5qYhCOJ6cXcv0syQFmciRHSHQ2LUojn/TCNqI8tD
         23dZ373/QGHflbw++dLOK9vfKseXe3eXrf9dZtjxuWJ2Kh0xXoysj8ZMnDqhDSWxZkhR
         crOZubIjlzviJiGt4LFNlN+704Jhuem1l53jJloiu0AX2grXf8el3GOQpMbIzAZkRei1
         WEy/T2a9rh9uGO8XMEeUJ2Zo7HeoHr5zUzUJt9pMPk0C5LhKThOmclb47TQNiHsxBjbp
         nGDA==
X-Gm-Message-State: AOJu0YwfRh7ta9aETfVlRDoa4uBMy45qVxBpAvLcKa4Lf3jgQONtroPS
	aQJagacMbdxyKOo4MB0bP9cMVGBfNi7pssKUnPTY43Y4Sm+jMzTZ+9vdqblN/Q==
X-Gm-Gg: ASbGncvdlAgsyJdGJ1nnaxvzKzI0Jt0EGu3RpsaHGa8uFS3cDAZEoE5gYEV2Cu53S27
	sKEhLvY8tkCW75Y92rEv5EmjLm7aj2p8Ga78un4IhDHlJIW0g27bs6d7lLO1r0/7j57FMdRLvts
	lu/m4vbAhtNdZxsEE/HLkjS1qzgLwbwUcCFzVFyjJVGb41EDNB2hEBaE7zvjxDjA42NfqwfoynE
	QK+qK9xZioHzpYPE6K49CpWUsEy9VLyd/Vsy4BJSmcfMNyPIv00a/CaRhis0nrnyaMpKBPhnkV2
	Y5J/BCceG/pf6IuztTFvAGtI8iR6wnYP
X-Google-Smtp-Source: AGHT+IF0K+J8L23wNoj8Xuer57iaUxyiwZ3Xud8AZbBiC/3nWRn0xLpD+DOJ7xcc4zZ/mjTqKzGjew==
X-Received: by 2002:a17:906:794f:b0:aac:1e96:e7cf with SMTP id a640c23a62f3a-ab38b2003e3mr1061679266b.20.1737394498072;
        Mon, 20 Jan 2025 09:34:58 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab632fa9f6esm53544466b.115.2025.01.20.09.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 09:34:57 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <gargaditya08@live.com>, <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, <j@jannau.net>
CC: <linux-wireless@vger.kernel.org>, Orlando Chamberlain <orlandoch.dev@gmail.com>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Mon, 20 Jan 2025 18:34:56 +0100
Message-ID: <19484c82200.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <06B76E82-BA57-4195-87E5-B0935BDD4EF6@live.com>
References: <B606F666-4A6F-44D9-B956-0B3E88E286E9@live.com>
 <06B76E82-BA57-4195-87E5-B0935BDD4EF6@live.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [REGRESSION] Wi-Fi broken on Apple MacBook Pro with BCM4364 Chip starting from kernel 6.13
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On January 20, 2025 5:56:35 PM Aditya Garg <gargaditya08@live.com> wrote:

> So it turned out the changes in the following commit broke wifi only on T2 
> Macs with BCM4364 and BCM4355 chips.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/broadcom/brcm80211/brcmfmac?h=v6.13&id=ea11a89c3ac64ada9d8b7f7de279cb6385ed194f
>
> I’ve sent a patch with the fix here:
>
> https://lore.kernel.org/linux-wireless/47E43F07-E11D-478C-86D4-23627154AC7C@live.com/T/#u

I saw that. I briefly look at the kernel log you sent, but couldn't draw a 
conclusion from it. Great that you looked and found the culprit. I will 
acknowledge the patch.

Regards,
Arend



