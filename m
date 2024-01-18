Return-Path: <linux-wireless+bounces-2173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0AF8318C5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE21F2829DB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569524200;
	Thu, 18 Jan 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkQvPcqw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4B241EC
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579066; cv=none; b=TyiTfU1gSSPwLT5zWwk2vlyrcMmQMslCf8xajjXdIldA1lDZjKyx/W5W2pvMROIG+XTuvzxZpCnE4aEnasDqfT+lksGtJk8CH8U85F1IbKbkVE10EhCI3OCptMXSN5cZg7jH91IsL5GBhvKyi/sgn3dxoQgJD5XmcG3z1UsQDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579066; c=relaxed/simple;
	bh=Wh121JP8x8AmS5peorUr151OphZrzm5KKw/zHdXOdwU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=dnXN/NrzGG7JEIUx/16+VCcED4ZoordWvQnJNBa/sV0xmtSnybk6fZi/ZzDQmflmKNB3AeW2lNW8ad0Keyyb4dIbnJyvwv8Un4SXkA0gubRXoA7IYeGaKWWu7GbQRBnMRA4Xsrac5tq2ieDQuE+ApAwWkoDwsw3WlfcK2bKlhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkQvPcqw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a14e12772so5199791cf.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 03:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705579064; x=1706183864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSbItnDJtAhxdKJPq8p4fHzqx0G+7KhC+yFQZDNr3BA=;
        b=gkQvPcqwZB9z0LQmFczXTRdDf8YKCQKdcyJJkke7nmAY2ggVO3Bb/Bg/l79IYHQMhR
         MwtZYQQFX6YbzrzfYwlVeeQcuDum0tyEAE6yJopriR/UxNDHe8hyFD+obpk8NJv8K451
         Zcm0ZHVf1ixMV/TmNUxhUpBOGo6tfjX37rlCRIvcjUBnA1S2D2viMpiJ+SvnJhpHdadR
         j8CKiqBHWlJEgzD4YrH+UaTYlx3vWsBH+NSbXWPFjW+Qso/TIFuy2d5JTkiJ3joGh/f1
         sMqrDld0UdIwELs3H/cEI4eUfwtKzdyPd43bAc+rKU2bat7gdQ+R8Sc1dmu91rnpokQJ
         kbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705579064; x=1706183864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSbItnDJtAhxdKJPq8p4fHzqx0G+7KhC+yFQZDNr3BA=;
        b=mOmGWZF3+gCqlBPpApXI6h69Y2/ngO0mEafxN841NGuf33KhNp5PMHVJ0pc+RfbC01
         uupr5ORZtgwLU+tKhZxUWWkug8gx3eImgkxqwGGB4wuBWUMzu1AKip1q6q8b1RwVx0Tj
         WZcuEajAvK/PAY5QuiYC1ht7810C8zM8sAXXKYwobFQwLw8bKFTW7Gyy3DyxkCO0sxIW
         6bzFVNOEs0ZqsDO6iY0DvHDTNzJuc2j21+6coeAd7/oqwl5CgJNbQgV1Vh9A/bn/j7sL
         U5/AMfmPELer0kfuEZ34tO7HXtaiy/sZNHVRRF7oRXFMMLqVhvA4cOpalkEPtBfAA6WT
         Fe8g==
X-Gm-Message-State: AOJu0Ywf9b6PtqCMPYl7l0qSVadBES6FbstSE0yvjgONxRF/DeBkwrOH
	Kk99uCkJGMxgVOHvh90BqLAeZiVipeEiBvBpf/cFqnrFjQUPXxfC
X-Google-Smtp-Source: AGHT+IFfN1Yfj0ecUq2EF/XWCk0GxZk8O47qDiTzBs3vwwPxKerB6XTV01iItV7m76NwjOY9ijK8qg==
X-Received: by 2002:a05:622a:2cd:b0:429:cbe7:243f with SMTP id a13-20020a05622a02cd00b00429cbe7243fmr703983qtx.60.1705579064060;
        Thu, 18 Jan 2024 03:57:44 -0800 (PST)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id cp8-20020a05622a420800b00429aba4a360sm6659465qtb.81.2024.01.18.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 03:57:43 -0800 (PST)
Message-ID: <2aa115c7-b8b7-4bb6-a559-840e723edc3b@gmail.com>
Date: Thu, 18 Jan 2024 12:57:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [v2] wifi: brcmfmac: handle possible completion
 timeouts
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>,
 brcm80211-dev-list.pdl@broadcom.com, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20230614075848.80536-1-dmantipov@yandex.ru>
 <170557695372.2924528.2049717324928380180.kvalo@kernel.org>
From: Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <170557695372.2924528.2049717324928380180.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/2024 12:22 PM, Kalle Valo wrote:
> Dmitry Antipov <dmantipov@yandex.ru> wrote:
> 
>> Handle possible 'wait_for_completion_timeout()' errors in
>> 'brcmf_p2p_af_searching_channel()', 'brcmf_p2p_tx_action_frame()'
>> and 'brcmf_p2p_del_vif()', adjust related code.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> This is not simple cleanup and I feel that these should be tested on a
> real device.

P2P testing. Ouch. Let me first have a closer look at the patches ;-)

> 2 patches set to Changes Requested.
> 
> 13279707 [1/2,v2] wifi: brcmfmac: handle possible completion timeouts
> 13279708 [2/2,v2] wifi: brcmfmac: handle possible MSI enabling error
> 

