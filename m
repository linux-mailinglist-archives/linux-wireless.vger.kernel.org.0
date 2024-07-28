Return-Path: <linux-wireless+bounces-10583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CB93E903
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6B92815DE
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304715A0F5;
	Sun, 28 Jul 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DCoftUIi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1944374FF
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722194718; cv=none; b=YsP67TbuxL18MsjI0wAwFMUBTHqxzk2JO+ql7ncbCbSSRjxiznQaTUDAkns3UKvdLE/ZlVZEChAL2mFV57P5ZCM12Yg2Qwe2VmPM/p1MUOz64L98MTKeOJCr87bXwPCpSABPvxv6VpaRkfelHTrDS3dVB9caJwTWiM0rOvO4Fbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722194718; c=relaxed/simple;
	bh=mkD+pnQoWQ7eVS8rbYWYtfG/sVeN5zK9kcjFacq3dBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL9Ul9o1WK6n53veZTvtst0GUBowIPmyNdtd+EP73pNWKx+4J46ChgsYAb3mKAhDdox3N4cUygxd/NsXFw3caAZAX5jxMZKKpfahcGqOm93oFOAHS2O8qbyD7MaHblNgrBHYvcQt9txlyz0OX3ljNFBo4dqWrFsHF5VI0OF9KY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DCoftUIi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd66cddd4dso20941565ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722194716; x=1722799516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f+wqnIJzZWn7NokOEwvwfzE9hT2Ng4Dl0RfD/YdY2vY=;
        b=DCoftUIigjj9u/i4YpwaCx/8A0BEpdPlYpA64PCRXSu9o40V0ncYBWb4Lbg9jYHn6x
         L7ioTMjrLaUzATbQc4S7+3edgS/NlvmJnx407P2YcvIxdek/+WgrstA93l52joijamxn
         KENgkTYOMwPcMSBtOqU4eH5LfNbq9S///fxNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722194716; x=1722799516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+wqnIJzZWn7NokOEwvwfzE9hT2Ng4Dl0RfD/YdY2vY=;
        b=m3Gzr1R8EgdFWtEsSBur6huipuSo2oUu36qayXdJy/1H6QsZRM7cdDbQt0BfFr3VCT
         h1qcQQsK5fTOAcd5qqSISeGhAb/3PLN8BxzxE/heTjk+ns6nbs6sYfl7B7gl9Sv9xXsp
         xF3QJZ9yWBXJQbw3LBlHmO4QNQe0vAXb87eEV5CckE7L769od3JAFg1dMSd1pLSfK7Np
         ykiMykBYq99gkn4taBaO72VpuFNKVlY2XO37bhPCxcR3mKyEkg8I3xYUGvAVPDwig4RZ
         pyARlatwVrTjnuUE8915RhIaMZ4t0YeVT3oe1s1W0fdzF9G+5hqRG5CEt9UnOonV3bGC
         Pkng==
X-Gm-Message-State: AOJu0Yw9S1U3eXMVs3JLQaEaNqdKKj2iC+rQZYsxH9VLwfNXa700J+nq
	F/aeTz3jeSDoO7rKsm/SnweqQisvQfl9Fv9fkKvs9o7d2LKeEEADMCcC7ADb70Uq2Yg4aOJey3C
	3U0qT
X-Google-Smtp-Source: AGHT+IE/kxmrVbnvdESwxPvmKBnmLokPDpdFpayXTt5gjEyzNlfu5RF373gIlPR9fsQJ1DVA1zMWsg==
X-Received: by 2002:a17:902:e850:b0:1fb:9280:c970 with SMTP id d9443c01a7336-1ff047e4559mr84718625ad.7.1722194715757;
        Sun, 28 Jul 2024 12:25:15 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cf1da9sm68318785ad.90.2024.07.28.12.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:25:15 -0700 (PDT)
Message-ID: <f171a55b-41be-4193-b9c1-046d66afb578@broadcom.com>
Date: Sun, 28 Jul 2024 21:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT] wifi: brcmfmac: add flag for random seed during firmware
 download
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
References: <20240728191845.12577-1-arend.vanspriel@broadcom.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20240728191845.12577-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/2024 9:18 PM, Arend van Spriel wrote:
  > Providing the random seed to firmware was tied to the fact that the

[...]

  > @@ -2710,6 +2712,7 @@ static const struct pci_device_id
  > brcmf_pcie_devid_table[] = {
  >   BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
  >   BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
  >   BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
  > + BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
  >   BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
  >   BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
  >   BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
  >
  > Please test if this works for you. If functional you may add this 
patch as
-> is in your series. Would also like to here from the Apple chip users 
if this
+> is in your series. Would also like to hear from the Apple chip users 
if this
  > approach works for them as well.
  >
  > Regards,
  > Arend

