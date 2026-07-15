Return-Path: <linux-wireless+bounces-39140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z8EEHgV7V2rzOwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:20:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C305275E071
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ieee.org header.s=google header.b=NQGNb5C5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39140-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39140-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ieee.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2175530FE921
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C146AEE1;
	Wed, 15 Jul 2026 12:16:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469545BD67
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117777; cv=none; b=REs7Zgsrui8LDJORC/S3tQ2NnljuEmSgCGzZSrsfsxs3VkNHbM+RUvxFWbffXgMKWUiEt1V7yoQZAb2XsylKmr4RS/LsfHQkElA0kXDzqiaf6+e5mDLDS6a6cDWoIM/iEtvdR9EIXPVdzqMwKekc8kBb3sOpfWgae1XVmUSEJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117777; c=relaxed/simple;
	bh=lT/7WO1wjfB3oak0cuKJt8DGXn0vntMapQEjDanB03g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQS20JDEF4CgJbZ+XBgNGOAMU8kHg9B+TvLf/kERkdTW+MA3UDXEc3YmwTdFrhZSVy6fi0c5A9jNOI+HvwX5gclmfPX95a1uPJHkQCp5X9uGSOhjzLDRgivgf803ZbXwYu2uxPZ84kPbxT7dGV+W17edBQdEA1lzY9Z+bXYqsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=NQGNb5C5; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ff20870ac7so39953736d6.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1784117773; x=1784722573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYn30NuQBlpDBaqikH9GRFE2pdu5APUaoZom7kBIJ94=;
        b=NQGNb5C5jnfBAQINK7wvlbn8IPZv3rcr2zxxsCoqDbuoSM09Y4mGJEh9XDLG/iAL/3
         qAchGiyBkZN8PDlWyFGef/7O6UzbVIqJrBbe1/Agg1mNf773w698sQOrUuzL2Apb9PVq
         Z5bR2xMkCXmoe2JR/W1paOmNEnbAiDRvckrWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117773; x=1784722573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYn30NuQBlpDBaqikH9GRFE2pdu5APUaoZom7kBIJ94=;
        b=IU0na+4YVpU/45CukKZ/VGsewXXgUnil/yr7Y6lmWfC5fwO8WV5LUlcEFY4nelF3W7
         7w7UjJ6W/7YgXSFaTHJm/GvRGW9YVxoSfPxAgklX8N39rxSSw2hIi/c0IgW+Ka84/Stu
         HlVlEEP9FIVBioeE/8oi//yHqJdw/d68RSmNyxZLYUTSntMCkjMfpTmc2bHSW6RJgWVA
         k6O8Fk4sqC3U7obsS39uHHXsTLin9YB6n/ijAiWtoiU/o6UzNuvqbbo4Wk3cp1YyBOKa
         6QKapnSME5OwxZhZ4TI7yNlWDNLKnox2GXOaVPCDri79G4KLMMguS0LixEBN3v6MDq6J
         zVuw==
X-Forwarded-Encrypted: i=1; AHgh+RpbcbuW0sfSA382v3VYnlbvugNdnU1aX4YNlFwuRzRGzOEwt5EVZp5j1drgzP9PvpPq1xgKdPlq21o1yiicQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUGpsZk/qlrQbTf/JD2TChaTjnZLR5QAf2XLty7vQEdGrJQ+QA
	pnUiN89qPQbhUGOnpBXboMMHTUA1NL9SIvVAFT0cev20T/vCdFAyuHXCDdlou9EEuA==
X-Gm-Gg: AfdE7clUpx/t4l7rmloCLrhF5TVx8b8aXczEGlBdg8chLE+o7Q9RM8RhEO2SWKicTfV
	2dWjwl2srrfOcl5oGC/yd4V1NmkCqjOeaXaE88vXdvlXOAoER5p1bVfJiZzsyIP9FP8mxdPluEX
	6JdJqdNTasqXvGjdRYv7qFVfFR4jQCHooTdmvvAGZejT4PCcjM1N1kWcyQkzecvgaT5ssg5hTL1
	SFdlYnsESDXtgbcpDNVn9FdKJ0MRNP/IQ32i9+gtmPemyx8Gt01sn7ULbyUNYxuOrjqIF+9x0Ol
	EvpSTc2kiBlZvHcRbVOmST6+5OBsxAxwPaAj4uw8mSPhVI/OpOn9El4wgcoCDuRch4i3b+eIlvz
	JXe2QoanP8l+06esmk4W76tLj5HPImeQQOnGM5y22+hJPU5Z65oCCv9rOBHo7nZ7XdV+ORD5w7R
	1ejJ3ZONJJFrVTLJB5oeCz
X-Received: by 2002:a05:6214:500e:b0:8ef:5b18:65ec with SMTP id 6a1803df08f44-9074c70b5cemr66890686d6.15.1784117772692;
        Wed, 15 Jul 2026 05:16:12 -0700 (PDT)
Received: from [10.211.55.5] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-8ffd7c1fd2bsm193918296d6.27.2026.07.15.05.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:16:11 -0700 (PDT)
Message-ID: <358b1215-df7a-427f-89cc-55a6f2cf357c@ieee.org>
Date: Wed, 15 Jul 2026 07:16:08 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/14] net: ipa: Switch to generic PAS TZ APIs
To: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jenswi@kernel.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Alex Elder <elder@riscstar.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-12-sumit.garg@kernel.org> <alJp8jMzcw9EPZoy@baldur>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <alJp8jMzcw9EPZoy@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ieee.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ieee.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,riscstar.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39140-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[elder@ieee.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:sumit.garg@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm
 .com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:elder@riscstar.com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[ieee.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@ieee.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[51];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ieee.org:from_mime,ieee.org:dkim,ieee.org:mid,vger.kernel.org:from_smtp,riscstar.com:email,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C305275E071

On 7/11/26 11:06 AM, Bjorn Andersson wrote:
> On Thu, Jul 02, 2026 at 05:28:27PM +0530, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
>> service allows to support multiple TZ implementation backends like QTEE
>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
>> backend service.
>>
> 
> Please find an immutable branch with the dependencies for this patch at:
>    https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org
> 
> Alternatively, if you think there will be no conflicting patches in the
> time leading up to next merge window provide an Ack and I can pick this
> through the qcom tree.

I don't see any reason there would be any conflicts (certainly
no difficult conflicts) with this commit, so I think you can
safely take it with the others through the Qualcomm tree.

So if my ack is what you're looking for:

Acked-by: Alex Elder <elder@riscstar.com>

Thank you Sumit and Bjorn.

> 
> Thanks,
> Bjorn
> 
>> Reviewed-by: Alex Elder <elder@riscstar.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> ---
>>   drivers/net/ipa/Kconfig    |  2 +-
>>   drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>>   2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
>> index 01d219d3760c..a9aff1b7977d 100644
>> --- a/drivers/net/ipa/Kconfig
>> +++ b/drivers/net/ipa/Kconfig
>> @@ -6,7 +6,7 @@ config QCOM_IPA
>>   	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>>   	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>>   	select QCOM_MDT_LOADER
>> -	select QCOM_SCM
>> +	select QCOM_PAS
>>   	select QCOM_QMI_HELPERS
>>   	help
>>   	  Choose Y or M here to include support for the Qualcomm
>> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
>> index 788dd99af2a4..3cd9e44680e9 100644
>> --- a/drivers/net/ipa/ipa_main.c
>> +++ b/drivers/net/ipa/ipa_main.c
>> @@ -14,7 +14,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/types.h>
>>   
>> -#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>>   
>>   #include "ipa.h"
>> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>>   	}
>>   
>>   	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
>> -	if (ret)
>> +	if (ret) {
>>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
>> -	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
>> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
>> +	} else {
>> +		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
>> +		if (ret)
>> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
>> +	}
>>   
>>   	memunmap(virt);
>>   out_release_firmware:
>> @@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
>>   		return IPA_LOADER_INVALID;
>>   out_self:
>>   	/* We need Trust Zone to load firmware; make sure it's available */
>> -	if (qcom_scm_is_available())
>> +	if (qcom_pas_is_available())
>>   		return IPA_LOADER_SELF;
>>   
>>   	return IPA_LOADER_DEFER;
>> -- 
>> 2.53.0
>>


