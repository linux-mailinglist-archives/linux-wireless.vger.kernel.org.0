Return-Path: <linux-wireless+bounces-35506-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL9EFT7m8GmoagEAu9opvQ
	(envelope-from <linux-wireless+bounces-35506-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 18:54:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4A489681
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D0DE3003997
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B833DEFC;
	Tue, 28 Apr 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="gVFY5SGd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656D33BBC5
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395248; cv=none; b=HuNTAAo4yGJIszyrP562hVdl5ZOlDXd6JBoiz7KfCnGVwDiC8pHbb5RO4VD2akyPO56Zp9x58mea7tyh12hS9mwx5DLd5L6e6vOZWyGNAHl7l9ziyB19Vyj0qMldGPUoRn/G1uvnxk0QcWGRD9OW2E9/k70Ir0fnmuAwivcTNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395248; c=relaxed/simple;
	bh=rzWf/oQSHbkLcV8GwzpmrSWI0KfR0fCQpV3xi0rt5Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWre81z6qo4OID1DImEoELcsN/Ug5D1uR3PDep8q1JP5er20aUI176ASRCbH50WLQ2gwiAcBw99iioMD6x+3+VLOAQMgtGaOF0eG37Kl+QfnEyTSvQh4Z8K7F54OCHKf/eQzw2JN4ivNHHVInlFhPwBPwEUCFd4OexYbJNYfnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=gVFY5SGd; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69498319ee7so11700eaf.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1777395244; x=1778000044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
        b=gVFY5SGdeZ2JrpdQhfBOXtmU5OBrbNQbhEkaFelzzC8oIWbT3S+tNOJrkfLM9fewnq
         Oh9d14toNjEhcJm8pUr4qhRqyuMFBdQBuJLymgs//dxzGjLfe2/k7B/8mJIT7/lci9eY
         lJMTxKnO9jwE194fEOlgT0QYHkmt9cDMVFPYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395244; x=1778000044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
        b=cXy2xvg+WXa0ozk+mecxcvDfCwbdtZFG7BkXPprI3YCk3D/U711/S9tQt/ZMP2kea4
         IfWWvY1wMESrg62dlCs6lxkfx4QV3Helh6B/B9dMbO5jIn084qd0djVN4Ust5/BlarO4
         wCI3XAMQP/yZfYppaS2ABR7rTzIqNcuLTv6wXljR0UUWur6+rDs56z/aCRicoavlFX8c
         zAhXadJKEnrbTS4EVnxo8YcGidOlR3Hob85p20+G/0ID+dP08cRsqyKN26vQnXRijgoR
         m3ZZluPuNgxsv/yfq0DhopgYnUxChvv1LKkjrT2DhjN9jWP2um53UxSS8QjUmbIrl3v3
         IIcg==
X-Forwarded-Encrypted: i=1; AFNElJ86Xz5zedHYnc+plyJG+AWgUsLKPHWUlvvcLo23Hyk7obrd1uIz6+PwFvCKtM8LttRNDKduph2RrL276M9Yzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2UkUoP07B2+L+tvtRKHqaYQyQ+0g9Jbai745cFHXP91PIAr6w
	XXDxTNpZbtAWd4gXgU94HeeSRydBP7YJXSena7vT3KG2ZP9al8vWIV9YCNMinvY7YA==
X-Gm-Gg: AeBDieu5icySqd2Ome+EAzdROzQaFueZhQi0ty+tfc+CAfIkrZ+3CFWkLH1Pjj/25J6
	lEhF9qhNVn13u74b/kO7jBiKpsxjw6exEJ6oX+z1z+Zfav+r7+b7aAmL8jnaI3eDK6o/2AM0DL7
	EG4VGD+BoI+GxplzW1uf2oaeCE4YQOcv4Et0D871Dk7QpgtpzAQ9SicviiRDT/IkBf+8ub8jeAZ
	sS5IHd/He/1FjwF0oUdvK4R4O2iptdIzNPNp/YqFtGodoVKfh8br/tKMS4kX4lnvGA8GP01Dt0I
	ahBnF7GkYC94Zk/uKmqLUQsV2Wd2ELImfEMPUaU6S3QhdCurEVfgY8HUl7IxB8l+JeGMeCQtEPo
	3sGkNs7NaXZDMIyIRUUqU0EHNswXU73JcOofsYPAi9z50OKsmUj48XyCOFwthIMok98a5X244o2
	7E9RPXodigcMVDrLVYYI4VEB2QLt0FEq8U2AMX2IN8Kpk4n5durcZJHcvAArw/6KeUYhzRS+quf
	AR0zbM=
X-Received: by 2002:a05:6820:4b05:b0:696:13e9:6863 with SMTP id 006d021491bc7-6965c5ee294mr1871158eaf.2.1777395244239;
        Tue, 28 Apr 2026 09:54:04 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-433effdc79bsm2240677fac.18.2026.04.28.09.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:54:03 -0700 (PDT)
Message-ID: <aa2b2823-05b2-49a6-bdd3-622523497a0d@ieee.org>
Date: Tue, 28 Apr 2026 11:54:00 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] net: ipa: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 21B4A489681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ieee.org,reject];
	R_DKIM_ALLOW(-0.20)[ieee.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[ieee.org:+];
	TAGGED_FROM(0.00)[bounces-35506-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@ieee.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:email,qualcomm.com:email,ieee.org:dkim,ieee.org:mid]

On 4/27/26 4:56 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/Kconfig    |  2 +-
>   drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>   	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>   	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>   	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS
>   	select QCOM_QMI_HELPERS
>   	help
>   	  Choose Y or M here to include support for the Qualcomm
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4..3cd9e44680e9 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -14,7 +14,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
>   
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   
>   #include "ipa.h"
> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> -	if (ret)
> +	if (ret) {
>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	} else {
> +		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> +		if (ret)
> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	}
>   
>   	memunmap(virt);
>   out_release_firmware:
> @@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
>   		return IPA_LOADER_INVALID;
>   out_self:
>   	/* We need Trust Zone to load firmware; make sure it's available */
> -	if (qcom_scm_is_available())
> +	if (qcom_pas_is_available())
>   		return IPA_LOADER_SELF;
>   
>   	return IPA_LOADER_DEFER;


