Return-Path: <linux-wireless+bounces-2273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196F832E61
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358AE1C241D1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F154BE2;
	Fri, 19 Jan 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc6d1e3Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091F1E87C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686744; cv=none; b=TgJ4A/QGf0mryIJwbVMsKuwNRltqqpBsB3WrTxBlyiH5COXybjNINGfjZsbvby8hTl7+NMqcF14Uv62Spu4jGEvbqxWt4jwJS1eeEl0tLUG1tsa72vFIQ5w89iAvYieWuqZdgFM2R/1Ah29WHdpfVtbSWGVaGmfr8U8P78w9xOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686744; c=relaxed/simple;
	bh=xAz598ahmniymYjBSqo/OHOLGvdMfrCdpHhX0q8oMeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES0gpxAZk6WVJsEGrLNtZE3c+l07ZB6p0gnF1kdgX9bTRzaEbm8EBKNoW9nxFgXn2dh9OcuVVbmC/hhgQAQL5J4Kbju/b4ssYrq5P+vwtanlGH/Ai/zeF6pYaMCgr9qXnm04WI9TAuuc5grJbHE9mEi9f1lVEBtjKSkHAqtYw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc6d1e3Y; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bed9c7d33fso35386839f.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686742; x=1706291542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3T3+O1LvQHPEPgo9aRY8T8pOACNC7+ZPEmXJOsVZh0=;
        b=Cc6d1e3YOZvQLk8z8/Og5QqE2E6iW9ZBx97RqBXOsj7nJq36Tu3xIpSBaHYhDnGVis
         xIr3c0VDixK3mWDiJppIfPaK2CqWgekx/fLd7F/l2P2h6iqcXt2rzjrKTyi+7BmPcnvK
         9H6V77bGKf7uoPyRsh2/It/l1K8Sz9PAXj16OKATZzzzLAdDgI/SHArD0yj/Wic0nHxL
         Au3mmsAHJAxtEbgfo0GocJULi01sibTnFyoLFU0ofmPCahl52b15yhuf/znkusxAeXcX
         /x4MfdOyaDBFnc7IcbpVFgbS5Yp5j/CpCblsJFcMLutTfoiEVV7hdrohGKRhAbmx4ixH
         PN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686742; x=1706291542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3T3+O1LvQHPEPgo9aRY8T8pOACNC7+ZPEmXJOsVZh0=;
        b=qV7QEoEK5B3+CnhCTHxSvgx3HVXcJ6GO9wszjMuV064RgPSS/GkGwy1xjT4uMytwyY
         74WNdnNHDcGlc5+pwBiF42onGl8OlVGP8OSxGKxvYf9oYilvG6DVauHotxjKOLUCuvxW
         XLimej4gGjM0M2s7nYKhEsaJfugnqVZkBQd4yOdU1sG0ihk1JZzcodNN/6jSz7LlLtP9
         7Z5+DsCpYJu4aKMSBOW9gHeTQKJAPSaLo7yntXjK0P0lJShSSJj604SFl5fX+TM6eJ1s
         S01rwdu3Tm9ZPTNTiHzVsV+kPLZPTXaexBREGOpEuLZAZRoTcdxHDmNT0LyOKLZUh1ry
         eQYg==
X-Gm-Message-State: AOJu0YyKwBDPGeZzEOW5kexc7Sen2pMLHfXKfWfFpKekeMl3GLBPSltK
	3yKTBUqV7OEw3eXEuC0tu+pPDr0ez6c4wIeGiLuvpB7ce0iAWTwiSPtIPr38
X-Google-Smtp-Source: AGHT+IGOhMCobqctkgdGWTXLSsnhLGhqieknIPS+0vBoKAFbYHvrT2iXfa/ApO1FOfuknRRdQ4F96A==
X-Received: by 2002:a05:6602:258b:b0:7bf:31bc:50a5 with SMTP id p11-20020a056602258b00b007bf31bc50a5mr61469ioo.22.1705686742182;
        Fri, 19 Jan 2024 09:52:22 -0800 (PST)
Received: from [10.100.20.9] ([50.225.159.98])
        by smtp.gmail.com with ESMTPSA id u19-20020a02aa93000000b0046ec7716dd9sm376690jai.119.2024.01.19.09.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:52:21 -0800 (PST)
Message-ID: <08457e37-49f4-4c51-998b-e577731c8022@gmail.com>
Date: Fri, 19 Jan 2024 09:52:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org> <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
 <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
 <cdec259a-b779-4856-8585-f285179e3671@gmail.com>
 <21e925bc-ee3e-4421-949b-b3839d2abdef@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <21e925bc-ee3e-4421-949b-b3839d2abdef@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baochen,

I guess you got this output when qemu/ath11k is not running, either qemu 
not started or ath11k module not loaded, right? Since MSI is not enabled 
in this output.
>
> Sorry I should have made it clear:
> step1: start qemu and load ath11k without changing anything, then you 
> get those errors;
> step2: keep qemu running and ath11k there, don't unload it. Then check 
> lspci output in host to get the MSI vector.
> step3: Back in qemu, hard code MSI vector to the one you get in step2, 
> then rebuild and reload ath11k.
>
Thank you for the clarification, this worked like a charm!

Thanks,

James


