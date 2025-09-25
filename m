Return-Path: <linux-wireless+bounces-27654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B1BA1084
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BBB1C20D25
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0323957D;
	Thu, 25 Sep 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M6dCXonH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECF3191C8
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825070; cv=none; b=CWLJkgM1M763fe+Lhqo8/jgwQaUtQzIaBkouhwlwnhcUgxDmV/3z0T1nKyQ6qWs2CEZrLSXv/u/BGyk7b2HJ6I73adqcGpfqknWv7s8++hauRHnPmeJ+gjibvjseiY3KsiYUs+da2whVLN3+GoN8JNToBpOdD+Bl/TbA/t3OZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825070; c=relaxed/simple;
	bh=U2Y1oZnw0CPSvphNGIRZ/c0Hw/FN3c04/zntgc90mKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ip951ZjA0xaipBeMoBw1pqUUFX0kdNtfi6SD6N+JsEGQ8duw0wMNkgrnuV2kRuzyrAOV0z9MD4uhSQ2eoId1K9WT/Jtg40kmt0vrrUs5TU7O9tQn8FPt8JC6pSXjEJVLarboNkSeJ2wm7m2uxUNgLy4fGM3H9va9PaQbAQLGyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M6dCXonH; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-244580523a0so14497935ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 11:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825068; x=1759429868;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdZ7JXoUq4xQim4IeeTfkCOZr7doJLlGQb8qr7xzIoM=;
        b=OnkQFQvOH5aOAJR+4fzKIwPopckmGkI5uK/q7Y7MExQE3QpuKGmrFWAryqvepxgc7Z
         hzy28nF7gQ6axB6wWa4roPztZELtDVjNC8IRcOiDYTAuhbIsqiSGMUOrSna66E3p2eMG
         fwlRxtDhy4otPExVm9vdSdaqhrKiYRfcf5T1ml/+JvIbA96iFGVHdRtVztlfiX3W0lLr
         +v40+6ippZlBSmdeUnotcmIYz2cLmVs5InkR5bmYvyPRnmIM0jKTVzxNxPF5zO3Gm/2A
         av8z/Aq1DrJY/Cn1pQBA6Ua8Ta57t51017/4+U3WpcUGB3w605m7FdrTxT63TnB2ddr3
         qovA==
X-Gm-Message-State: AOJu0YxEutq9ap0WKs4/+ov8et30Um/tB2S0P1RbFvAY8twzBKJHMBKE
	sbTvwv5PI+uR958NAhdSyqVB1ayb6ff3Euq6rAReaqghm9gFHCWUfI/jmAJplhVXmhMTjy0fefc
	59yv1Gg+rpKRmzwF031Ko+UzDSsh7kV7DYd4tO5yfPJsUjpfmoUaJKe6lFfP+FxOhNiQ1z+TbDV
	0fGv9+in1ei1fi/SFgUTZJmnzXkemBkwxWK4B64vzQRmRseFORUVZd56dj/W2pYPYyvHuIVDkCO
	7kWQa6K2Sn2kqrTKRgqNdEqoHu6
X-Gm-Gg: ASbGncuaoRsnB4rPkSn0CV1uD41vHHnWeYNJ4pzlt07n2CezoCocWLfjH8e2eDFX5Ay
	wOHerN3f2zRsx/n1B28EYbF9/5FL9Tfb7bXdAKAcZHV4ztnEfBxMjg8wyfV1kxe+mJKi4wv7YFC
	O9mGTuzNjemXFz8cgwptB94pVIGB3NIzpHqeqJWN1F64Hi7WrLzuba82ZinPXD0vHR297O7Nj8m
	eJJWI9j0xboPFWhHHdJqpdtscPxS5904Z9ZDqE+dYwp85hF6qVrXFXJZ9SMGPVxmkGPxNgmyf/2
	8keUsi0gt83KwNcQFFKFcfPaWP8X3JVUZjzGotFJsY030Pp4WhVXaNlAzxNP5LWj8xne/8oH/f6
	rbezOv0lp2xFXYSxNRQVSPVswuh7nbXNvVxwnagcJ/7JiKs8J8f+K3sQtf+H6WDJPCJu+SiAl7h
	jpxHA=
X-Google-Smtp-Source: AGHT+IF6vt1fztKJtvvjhlVFFeHJjCqH6jRVHZc07lNxAJYS2OlU/+NndP37uYmicy6nYOn1a221PIy7cvry
X-Received: by 2002:a17:903:2442:b0:250:999f:31c6 with SMTP id d9443c01a7336-27ed4a3165amr41320555ad.32.1758825067893;
        Thu, 25 Sep 2025 11:31:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed66dd03asm1982825ad.23.2025.09.25.11.31.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 11:31:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2f9dc3264bso179044266b.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758825066; x=1759429866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kdZ7JXoUq4xQim4IeeTfkCOZr7doJLlGQb8qr7xzIoM=;
        b=M6dCXonHyI41Yg3HfWyaYMVvGqPu4J7fvh7ysJm0fhcW4R56UyPUp6AX2YBqwU6w+M
         Wd4Q/HEIhHvMyqqcuAzBKsmqku6xyMpUu0bwp35Nk7ONHKKXIu3Kz+lpDZ8b0nLlGS6r
         6Cbd5LcYwWNgxmqwdBVxO5izkUvvLB3JtArIw=
X-Received: by 2002:a17:907:3e21:b0:b34:99e3:3a88 with SMTP id a640c23a62f3a-b34bbccf844mr430955366b.58.1758825065690;
        Thu, 25 Sep 2025 11:31:05 -0700 (PDT)
X-Received: by 2002:a17:907:3e21:b0:b34:99e3:3a88 with SMTP id a640c23a62f3a-b34bbccf844mr430953266b.58.1758825065213;
        Thu, 25 Sep 2025 11:31:05 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65880sm213136266b.45.2025.09.25.11.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 11:31:04 -0700 (PDT)
Message-ID: <02ff0c6e-f2e5-450e-9666-3ce8b8404f86@broadcom.com>
Date: Thu, 25 Sep 2025 20:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS
To: Hsien Chou <s311332@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev
References: <CAE3HL_yv8t1Rkd+jLfQMkc3YrNONQp0pRFESV+v92ECf_+7Xjw@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAE3HL_yv8t1Rkd+jLfQMkc3YrNONQp0pRFESV+v92ECf_+7Xjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/24/2025 4:53 AM, Hsien Chou wrote:
> Hi Arend and everyone on the mailing lists,
> 
> I'm reporting a driver crash in brcmfmac that can be triggered by an 
> iPhone with iOS 18.6.1 or newer. This issue *allows a remote, 
> unauthenticated device* to crash the Wi-Fi driver, leading to a denial 
> of service.
> 
> The full details, including complete crash logs and a step-by-step 
> reproduction guide, are available on the GitHub issue page:
> https://github.com/raspberrypi/linux/issues/7033 <https://github.com/ 
> raspberrypi/linux/issues/7033>
> 
> For a quick reference, here are the key details:
> * *Affected devices:* A Raspberry Pi running as a Wi-Fi access point.
> * *Trigger:* An iPhone with iOS > 18.6.1 attempts to view the properties 
> of the Wi-Fi network.
> * *Root cause (based on preliminary analysis):* The driver panics, 
> possibly due to a malformed or unexpected frame.
> 
> Please let me know if you need any additional information to debug this 
> issue.

Having the kernel .config file from the Raspberry Pi would be helpful 
reproducing the driver build. Can you provide that?

Regards,
Arend

