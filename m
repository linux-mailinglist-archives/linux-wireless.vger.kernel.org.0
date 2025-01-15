Return-Path: <linux-wireless+bounces-17560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21DA12806
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1007188B5ED
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03E14658F;
	Wed, 15 Jan 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LHA5zXzG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C8136E37
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956935; cv=none; b=qv0nLV/zDQkbv/8qcbxiMiS9N9IXNV4zWWxerTHAG952658X8UP8hprsinBL6Z93uVojy+r6pqeANIcO57lVwy5hvt/vNiy18bQbqcUMjJAezU08tVY92r2pB3cr0O71W/xH/qP3BclwDF5O592WrPfhMsrkQedjR4pbT3AQ2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956935; c=relaxed/simple;
	bh=ooYSt/USoEcRsL+E5RG2pqHwAcATH4QY2Zlex2YNDyU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E7L3WyJLQCT96NpfqjP8H9FEKb2nOdEbZ/I/H5RYQChZ3bR45HcTjdrwc17bpLNppBIyT6v6aVxTU62HX24kAMwiiroK8LQbNLBjE1kqfbdWF66GjwYKmgqPhs32GFStCxu+7gpf3bim9LZocjtp9NdKQj11iu42aOdMlUxx3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LHA5zXzG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1305964066b.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 08:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736956931; x=1737561731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glnRRdkwbnhhqV0Qbje3TwYkcW6HGVA3+UV2AwzHbCY=;
        b=LHA5zXzGR5dGh1iNySB4Q0LAUOvmQ53lOxOMSeWY2P0vB29VO3QLje0Sx6FKQbPEWX
         nXmmCWeRcetrHk8kHQ+lxrJ8ABJtNE//kIAN7fXJ6lwH/nTd0rSFVk14HLKKt/s+bbf6
         Q+0b4ElUcCi5eAMtEdRBoebzTkG09n0oLji0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956931; x=1737561731;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glnRRdkwbnhhqV0Qbje3TwYkcW6HGVA3+UV2AwzHbCY=;
        b=GnobdM/SnH5U7Q6kGpgFYso8aMsvhNWUdDpeLBkUff2Gzs1uu+KPDEs0QCWoWrY5vW
         vHsNXXBNikEn79puFJ9qjuYMzgr9F1lzZ5b5zitboSYqZ3vMY02MBqhFpqWUJRD4N/g0
         Y9zimkfxpYeILagZvDhpwhlwZ9L5LRl9CoGxaSoeU8uZw6NpggGF8drepbsR2ceUU1yQ
         XOshadTMYP32jYHtMmTePSwff5mB7liH0PmJ9wbetHzVBVA3u55d2c4o1lqZeSHJM2/n
         wq6kFAb+5AhCfZRL8TJiDh29tjXcRVX4Uc1rgcy79qoUOVpVVghec7EiHa9xrtjET0bs
         mLmw==
X-Gm-Message-State: AOJu0YyFL/aHQB2MUbwvfXTEA7TsqGPdAoS0vqBCqNRT/nqy25U1WOg4
	7ewPVl9f9XCsqQUigCfWwvDOc++z0u582vlOqaarw0WkvIPCf67qtzPkANo1+w==
X-Gm-Gg: ASbGncss2UxeCTUx/1hGEZvBaDvfKsZfe1IpnrqBAk40V5CGlHA+Tn/ItUyORn7VgZn
	f3rzHQAipp7UVz6oU0KlmuKcPKtOqTtoJVHW7GJKMcrY2Qpmp4LFS4bU6iiGS57QP7iGp6pvNNS
	6oFxjP6wHs+r0I+O2I7aKTjGzjFUfyUku2wGIeq2Cl8SPxOJHXQebwMJtOMTcwmPyskjXV3EEiy
	YQESHSNoF0kXEXACcJ0QztaiXMnrzSzuX4ukzvWI8GaqYk+Yga9JVpVvqj74QaaDekN8o0yyXL8
	a4ya1gVODajmGh9P3Kc=
X-Google-Smtp-Source: AGHT+IFU20YNTPDooQLRDInr/5Zuj/4IAWibdx9co9oKVemVTrW5HRL73n26bZC66AHFuZXIoMEYzw==
X-Received: by 2002:a17:907:36ce:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-ab2abcab441mr3116490166b.37.1736956929567;
        Wed, 15 Jan 2025 08:02:09 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95625a5sm768900966b.114.2025.01.15.08.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 08:02:09 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>, Marcel Hamer <marcel.hamer@windriver.com>
CC: <linux-wireless@vger.kernel.org>, Marcel Hamer <marcel.hamer@windriver.com>, <stable@vger.kernel.org>
Date: Wed, 15 Jan 2025 17:02:07 +0100
Message-ID: <1946ab35c18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <173695421441.512722.1081406482312817540.kvalo@kernel.org>
References: <20250110134502.824722-1-marcel.hamer@windriver.com>
 <173695421441.512722.1081406482312817540.kvalo@kernel.org>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v2] brcmfmac: NULL pointer dereference on tx statistic update
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 15, 2025 4:16:58 PM Kalle Valo <kvalo@kernel.org> wrote:

> Marcel Hamer <marcel.hamer@windriver.com> wrote:
>
>> On removal of the device or unloading of the kernel module a potential
>> NULL pointer dereference occurs.
>>
>> The following sequence deletes the interface:
>>
>> brcmf_detach()
>> brcmf_remove_interface()
>> brcmf_del_if()
>>
>> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
>> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
>>
>> After brcmf_remove_interface() call the brcmf_proto_detach() function is
>> called providing the following sequence:
>>
>> brcmf_detach()
>> brcmf_proto_detach()
>> brcmf_proto_msgbuf_detach()
>> brcmf_flowring_detach()
>>  brcmf_msgbuf_delete_flowring()
>>    brcmf_msgbuf_remove_flowring()
>>      brcmf_flowring_delete()
>>        brcmf_get_ifp()
>>        brcmf_txfinalize()
>>
>> Since brcmf_get_ip() can and actually will return NULL in this case the
>> call to brcmf_txfinalize() will result in a NULL pointer dereference
>> inside brcmf_txfinalize() when trying to update
>> ifp->ndev->stats.tx_errors.
>>
>> This will only happen if a flowring still has an skb.
>>
>> Although the NULL pointer dereference has only been seen when trying to update
>> the tx statistic, all other uses of the ifp pointer have been guarded as well.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
>> Link: 
>> https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
>
> If you submit v3, please add 'wifi:'.
>
> ERROR: 'wifi:' prefix missing: '[PATCH v2] brcmfmac: NULL pointer 
> dereference on tx statistic update'

While at it maybe rephrase the subject to:


wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()


Regards,
Arend



