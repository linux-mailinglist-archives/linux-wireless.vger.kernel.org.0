Return-Path: <linux-wireless+bounces-17559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09910A127FA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E20A167699
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60724A7C4;
	Wed, 15 Jan 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AIURZAUs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974A24A7EB
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956677; cv=none; b=nObJ3ylbKgnDAuLCmYvr+Dn2Ir2Ufl7E4WZzD2lPqSObePWLaGkVc/j2xaI/dKpjm9fVlQixyKiOAp+VYJXljpJB3s0z1iQ9eO4mG+ADeYLQbJxCEVKLu5qWgOtQ+DAaOUmtWfDxreC58SPxXh0FiFXfwK5mGSnI3k2wssTJNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956677; c=relaxed/simple;
	bh=PgVNBcDsh3fEF9S+3sQwDR0VhfPAjLamklEBqEfEkGk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=umvhEkD4uExdXrTX7sPbMp+fZV4Gmm5sXo0Eqvr5p13NqHu2BM7zl1sCOY6YBpHQ+By8YdYmp9lIQuJ424YYnj57e+uohWHMTzLu/3/9PUDDlSDuS6t3Iu9nnSKusBs4PzWugcUi/JBeZrQW9QUhx70O5wx9Bca8jjLW4lMZ35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AIURZAUs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1304928866b.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736956673; x=1737561473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61qpqz+hm3qQrmLmzAGUfGSJ2GhlyTptrqixt9Wb55U=;
        b=AIURZAUsHtIkKCtpLTqz4j5n7vX9XJUzkScp49Li3bjJ+REvDe0r6jf6FSuCZsfGF+
         mL4tGKmvQDZFdCv9iTV4NQHFOMPvCW0mTp1/qmu/l545TZVocwTF7FkE3a9eGIsnM7nf
         eZFJG482blXtcauZfnnlRBEFIkh2/IUTey1qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956673; x=1737561473;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61qpqz+hm3qQrmLmzAGUfGSJ2GhlyTptrqixt9Wb55U=;
        b=GOlHuZR/NOq4AjL83duzgdOQ834w/o7TqOK5CVSOg3LSMWXajyS9dspRUNEYEPFSI0
         mIS6lq56iGY+FDrK7psGZhAkVcYZibuBfkgKb1f2ah9D2Jp0skGAA9ojbFn8kpyh71RE
         SenkERLYL+q7wvtcj/WxjWfqBPtINjHYZ00jD0oUyv39W44Datr3qAXyAivBpDOc4n1F
         KtWnyMiCXfpoaKqq4SZUSaWe80wZDzVTzM8/ys44H5cBIqbK4+meI8GJWhuu9FOwxanJ
         U5X2bkKoumHaEO6Y6azu/n5han6Ea3FuhiZEL8ipinaF0fuhuAGeo4oyiqVJ69vX6Lho
         7BjA==
X-Forwarded-Encrypted: i=1; AJvYcCXpPio++BA43qum8Z8cnv1Sn12YqP+F0FHXYQEcl0Lw/f6qLoVD17f4/bpBrh/u4QLTN13xfWKyiADFh2+Zmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydLWMDWsBSgUI6mVvT/I46l9J+P9D4eE43kMKEXU2snhQUvFlK
	2og9EwHOlOOVucDGl3lbJ4xmrrjlSeBmTXXsgxWRlvOXXLJkxr1k7p19pAarLg==
X-Gm-Gg: ASbGnct/JgAh21nVmU+MxQGzjZXjB2D8j6igebwDTbkyOrTkJzbArg2/n55nmKqT8qI
	rGNw9P23CxlHNATeiXPSFS/npX9nS4ZAZnsZwxGcDh7NM6qduPeZyR+/yT3D1yU66V255cXgQ8D
	B5K71afnI4p71t168WFaeYA+R9cNOx/N1029MkmncBEtG3WC3BcQ8LFgAEXsiA//nYXnS/4+yI0
	fcm94KbtlMcMatGEATBj4uqq4e4BuLeD8MHjoo7eN4xubOy/EXNj37Vap6pDyYsfLrWn+uqvuoC
	Xy3czus8u2MASytEvK4=
X-Google-Smtp-Source: AGHT+IHbv12zipSWsVJAhQHRCL3rwRF99VutRgAlzJeAX/zqf4aChIMW6y1V3UGv9uZyGCnVnAu4eQ==
X-Received: by 2002:a17:906:f58a:b0:aa6:b473:8500 with SMTP id a640c23a62f3a-ab2abcaafb9mr2739548566b.42.1736956672786;
        Wed, 15 Jan 2025 07:57:52 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9649939sm766824066b.182.2025.01.15.07.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:57:52 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <stable@vger.kernel.org>
Date: Wed, 15 Jan 2025 16:57:51 +0100
Message-ID: <1946aaf7418.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <Z4Yd515dhZApbxPz@windriver.com>
References: <20250110134502.824722-1-marcel.hamer@windriver.com>
 <4020e574-be5d-43e4-9c04-1e5a708e70c6@broadcom.com>
 <Z4Yd515dhZApbxPz@windriver.com>
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

On January 14, 2025 9:20:33 AM Marcel Hamer <marcel.hamer@windriver.com> wrote:

> Hello,
>
> On Mon, Jan 13, 2025 at 08:28:33PM +0100, Arend van Spriel wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and 
>> know the content is safe.
>>
>> On 1/10/2025 2:45 PM, Marcel Hamer wrote:
>>> On removal of the device or unloading of the kernel module a potential
>>> NULL pointer dereference occurs.
>>>
>>> The following sequence deletes the interface:
>>>
>>> brcmf_detach()
>>> brcmf_remove_interface()
>>> brcmf_del_if()
>>>
>>> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
>>> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
>>>
>>> After brcmf_remove_interface() call the brcmf_proto_detach() function is
>>> called providing the following sequence:
>>>
>>> brcmf_detach()
>>> brcmf_proto_detach()
>>> brcmf_proto_msgbuf_detach()
>>>   brcmf_flowring_detach()
>>>     brcmf_msgbuf_delete_flowring()
>>>       brcmf_msgbuf_remove_flowring()
>>>         brcmf_flowring_delete()
>>>           brcmf_get_ifp()
>>>           brcmf_txfinalize()
>>>
>>> Since brcmf_get_ip() can and actually will return NULL in this case the
>>> call to brcmf_txfinalize() will result in a NULL pointer dereference
>>> inside brcmf_txfinalize() when trying to update
>>> ifp->ndev->stats.tx_errors.
>>>
>>> This will only happen if a flowring still has an skb.
>>>
>>> Although the NULL pointer dereference has only been seen when trying to update
>>> the tx statistic, all other uses of the ifp pointer have been guarded as well.
>>
>> Here my suggestion to make it a bit more simple...
>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
>>> Link: 
>>> https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
>>> ---
>>> v1 -> v2: guard all uses of the ifp pointer inside brcmf_txfinalize()
>>> ---
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>>> index c3a57e30c855..791757a3ec13 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>>> @@ -543,13 +543,13 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct 
>>> sk_buff *txp, bool success)
>>
>> Instead of checking ifp below you can simply do following here and be
>> done with it:
>>
>> if (!ifp) {
>>       brcmu_pkt_buf_free_skb(txp);
>>       return;
>> }
>
> Thank you for the suggestion and review. I considered that when doing my 
> changes
> and then thought it would be more efficient to only check the validity of ifp
> when ifp is actually used. To skip checking it on each call to this function,
> since it seems unlikely ifp will be used on each and every call.

Actually, the function will mostly be called with a valid ifp instance.

> Before I create a patch with your suggested changes, I just wanted to check if
> you think it would be better to just wrap the two existing if statements in a
> new if statement in that case, something like this:
>
> if (ifp) {
>    ...
>    if (type == ETH_P_PAE) {
>    ...
>    }
>
>    if (!success)
>        ifp->ndev->stats.tx_errors++;
> }
>
> And then keep a single call to brcmu_pkt_buf_free_skb(txp) at the end of the
> function.

I understand your motivation. My generic approach is to bail out early and 
thereby avoid extra indentation levels. Although this function is in the 
data path I think the null-check for ifp is negligible. Could consider 
using unlikely(), but that requires profiling data to justify using it here.

Regards,
Arend



