Return-Path: <linux-wireless+bounces-9881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A22924D32
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DA21F23426
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92B1373;
	Wed,  3 Jul 2024 01:42:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 58CA51FB4;
	Wed,  3 Jul 2024 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719970926; cv=none; b=GfqIjeh0II1/TcimWm8KLHdAZ00WhmiKB1KYC2FmzY1aLxu9bZnJrCWe1KZXX7y0Lkcf5tcfYHY8borugcHKT5AymNKF9jWJZDFQq/gdwzFGssK55BYm59mxKG5UAluWWNCL4yD86Xnv4PKQtnaYQWW0z2xabfor10xecbI2Gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719970926; c=relaxed/simple;
	bh=/0w+i+Lr65ap+CUE0bx3iXZmGu8G7R70ai0Z4Ilzjm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=ZxLQj4DWGiSANux5JNSndL3KsL3Jp9TKBNyyl9Kwl8AUkv6ZDq5ETAn6lvJakXjnCdXOMGlqV2sU+nbVy37uEVeNnaBeU8Q1oHRgwxdthBtf4JNYdjWsMQMXqnu9aD+DaPBOc2FZkyzlv83L0aNs/o44VZnCGmkMkuvitJg45yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 515B16047B688;
	Wed,  3 Jul 2024 09:41:46 +0800 (CST)
Message-ID: <36cef2a8-10a3-928a-d962-3599333d9ac8@nfschina.com>
Date: Wed, 3 Jul 2024 09:41:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH wireless 1/9] wifi: cfg80211: avoid garbage value of
 'io_type' in brcmf_cfg80211_attach()
Content-Language: en-US
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, johannes.berg@intel.com,
 kees@kernel.org, a@bayrepo.ru, marcan@marcan.st, quic_alokad@quicinc.com,
 zyytlz.wz@163.com, petr.tesarik.ext@huawei.com, duoming@zju.edu.cn,
 colin.i.king@gmail.com, frankyl@broadcom.com, meuleman@broadcom.com,
 phaber@broadcom.com, linville@tuxdriver.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <1907419a888.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/2 23:39, Arend Van Spriel wrote:
> On July 2, 2024 5:29:27 PM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org> 
>>> wrote:
>>>
>>>> On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
>>>>> brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
>>>>> brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage 
>>>>> value.
>>>>
>>>> Since you're going to be resending anyway, please delete the space 
>>>> char
>>>> from the start of the line.
>>>>
>>>> It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
>>>> It looks like it just goes to great lengths to preserve the original
>>>> data in io_type...  So it likely is harmless enough but still a 
>>>> strange
>>>> and complicated way write a no-op.
>>>
>>> Not sure if it helps, but I tried to explain the reason in response to
>>> patch 0 (cover letter).
>>
>> Would it make more sense to have just one patch? It's the same issue
>> anyway.
>
> Yes, but I would solve it in brcmf_fil_* functions (fwil.[ch]).
It seems you will send a new patch to solve this issue.
And I guess there is no need for me to resend a v2 patchset or just one 
patch.

