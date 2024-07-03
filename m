Return-Path: <linux-wireless+bounces-9896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E619254C0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78901F25735
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FA136E2A;
	Wed,  3 Jul 2024 07:38:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 011394DA14;
	Wed,  3 Jul 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992297; cv=none; b=Pf5yMfyu+tduwYBze8rQsBkgW7SJoBYYN+VF1EXfIXyjmdOTfoghIPS+D9G3D4XazHlBIHrmZtQMgTco4czOcQ6cRCyPkAZczDX3q5ZeHmg3HHNw/Bzde+MBhvNusFzSDylzfw/QUHpBNO4GKMtZ/4DRd4n7kobVVm2RZrJT1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992297; c=relaxed/simple;
	bh=5jagiKmtXakGpPGsAgYG6voU1kDL/YWcFy95b21TfZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=bbC1h/M+vOGDJZiqtIUcJxo0Sadvxf9Ll+4fOwYxXbm6FryneVFXxUbsLcYfHkuTk/qd2MoVa1pHcV3yK8oy6fHxSkzs0kw2bx2UpFEje/QPu4hgEaWK6U/PFKI2AbgKxojAd8JneLSitmPkPOcEu3IFHcX+VHXkzORHmY4Fw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2F029604B3B70;
	Wed,  3 Jul 2024 15:38:07 +0800 (CST)
Message-ID: <114387f0-02c3-b4bb-7b79-6589e790add3@nfschina.com>
Date: Wed, 3 Jul 2024 15:38:04 +0800
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
In-Reply-To: <19076e6bec0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/3 12:42, Arend Van Spriel wrote:
> On July 3, 2024 3:42:18 AM Su Hui <suhui@nfschina.com> wrote:
>
>> On 2024/7/2 23:39, Arend Van Spriel wrote:
>>> On July 2, 2024 5:29:27 PM Kalle Valo <kvalo@kernel.org> wrote:
>>>
>>>> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
>>>>
>>>>> On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org>
>>>>> wrote:
>>>>>
>>>>>> On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
>>>>>>> brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes 
>>>>>>> it to
>>>>>>> brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage
>>>>>>> value.
>>>>>>
>>>>>> Since you're going to be resending anyway, please delete the space
>>>>>> char
>>>>>> from the start of the line.
>>>>>>
>>>>>> It's weird that brcmf_fil_cmd_data_get() uses the uninitialized 
>>>>>> data.
>>>>>> It looks like it just goes to great lengths to preserve the original
>>>>>> data in io_type...  So it likely is harmless enough but still a
>>>>>> strange
>>>>>> and complicated way write a no-op.
>>>>>
>>>>> Not sure if it helps, but I tried to explain the reason in 
>>>>> response to
>>>>> patch 0 (cover letter).
>>>>
>>>> Would it make more sense to have just one patch? It's the same issue
>>>> anyway.
>>>
>>> Yes, but I would solve it in brcmf_fil_* functions (fwil.[ch]).
>> It seems you will send a new patch to solve this issue.
>> And I guess there is no need for me to resend a v2 patchset or just one
>> patch.
>
> I am not entirely sure. If both gcc and clang would warn about using 
> uninitialized data I would be fine with these patches rolled into one.
It's sad that gcc wouldn't warn about this uninitialized data. And my 
gcc version
is  10.2.1 20210110 (Debian 10.2.1-6) .
By the way, I found a funny thing about this uninitialized warning.
Just with the patch as follows , gcc will give a uninitialized warning.

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -130,6 +130,7 @@ static int brcmf_c_download_blob(struct brcmf_if *ifp,
         u32 status;
         s32 err;

+       err = brcmf_fil_iovar_int_get(ifp, statvar, &status);
         brcmf_dbg(TRACE, "Enter\n");

         chunk_buf = kzalloc(struct_size(chunk_buf, data, MAX_CHUNK_LEN),

It seems that gcc only issue this uninitialized warning in some sitution.
I think it's worth a patch to fix this uninitialized problem.  :)

Regards,
Su Hui


