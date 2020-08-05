Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214EE23D0C4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHETwi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 15:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHEQvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 12:51:25 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0A7C0A8890
        for <linux-wireless@vger.kernel.org>; Wed,  5 Aug 2020 06:55:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c16so25596828ils.8
        for <linux-wireless@vger.kernel.org>; Wed, 05 Aug 2020 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T0iHC5DzypW6poy3NDVtNkEOvm1za2UqY6n/ov5xw0A=;
        b=DAhkOvAYaZ9UtoECfWC2gAqYzdQdZu4/OTZhHotTaCMraihBeTETAb2o+tdVB+R9c/
         fgruEjKoM8VG+YdsLo4GUZF8VaCggzTi5h3uToTV2f2Sv1hwOpZ5HvtTKuXa2Y1A6q3O
         zX5fNDo98uB0Sok2zX9/YQGJMJ6y+B1u0vCnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0iHC5DzypW6poy3NDVtNkEOvm1za2UqY6n/ov5xw0A=;
        b=iu8HQuu1Wnq6X0XH30oAcM9DBxLLMDgscgnmark6KdrX+162Uwbqo/QUEEfbz10zwR
         p6lIcp3dKquOz5CmX4fBHu/Ibm5cU3t8y/+P06O04meT0/AHxmosfxrpRMbHzGnLIV7T
         s+qBTkXraiRHTslNn88Svvbgo9ASKzBZ+RqCOvtl2gyBN0ej/6D9/LIXLftWTcL9B4QO
         p2+iQAwU1XFNg89dZilv5kuW3SS/naryIHN+m+RptqwqnAZyn7J5m2KUz/ACDRrbqaXd
         dtKrCTy28r3JyShqWQ5QFjeDxGBTT942tJiNzXkyDg8UbngPwic+TrpQAXcuHYK3U89B
         eshg==
X-Gm-Message-State: AOAM532nj/yFwSMqbyc9uuvjrxB4IdaMB75oGoF7of/znnhxvS98AzRN
        XOfHeJh69jMAoqPP959Xkr8RLw==
X-Google-Smtp-Source: ABdhPJygRlU9l3OctXlmAVj+p1MKYQ+VT9ZvU9QPRbxWDqUzC6q+bEae4dy82QDhDGDE28iGtnJLqA==
X-Received: by 2002:a92:c14d:: with SMTP id b13mr3548606ilh.269.1596635733090;
        Wed, 05 Aug 2020 06:55:33 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c2sm1073796iow.6.2020.08.05.06.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 06:55:32 -0700 (PDT)
Subject: Re: [PATCH] soc: qmi: allow user to set handle wq to hiprio
To:     =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     elder@kernel.org, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, agross@kernel.org, ohad@wizery.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
        ath11k@lists.infradead.org, netdev@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        srinivas.kandagatla@linaro.org, sibis@codeaurora.org
References: <ADUAnwD8DVByMMSsrG-r3Kri.3.1596374087585.Hmail.wenhu.wang@vivo.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <5c6123f2-1a65-8615-9d5d-3bb1d25818b2@ieee.org>
Date:   Wed, 5 Aug 2020 08:55:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ADUAnwD8DVByMMSsrG-r3Kri.3.1596374087585.Hmail.wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/20 8:14 AM, 王文虎 wrote:
> 
>>> Currently the qmi_handle is initialized single threaded and strictly
>>> ordered with the active set to 1. This is pretty simple and safe but
>>> sometimes ineffency. So it is better to allow user to decide whether
>>> a high priority workqueue should be used.
>>
>> Can you please describe a scenario where this is needed/desired and
>> perhaps also comment on why this is not always desired?
>>
> 
> Well, one scenario is that when the AP wants to check the status of the
> subsystems and the whole QMI data path. It first sends out an indication
> which asks the subsystems to report their status. After the subsystems send
> responses to the AP, the responses then are queued on the workqueue of
> the QMI handler. Actually the AP is configured to do the check in a specific
> interval regularly. And it check the report counts within a specific delay after
> it sends out the related indication. When the AP has been under a heavy
> load for long, the reports are queue their without CPU resource to update
> the report counts within the specific delay. As a result, the thread that checks
> the report counts takes it misleadingly that the QMI data path or the subsystems
> are crashed.
> 
> The patch can really resolve the problem mentioned abolve.

Is it your intention to submit code that actually does what you describe
above?  If so, then (as David said) you should propose this change at
the time it will be needed--which is at the time you send that new
code out for review.

Even in that case, I don't believe using a high priority workqueue
would guarantee the improved behavior you think this would provide.

In case it wasn't clear already, this change won't be accepted
at this time (despite your explanation above).

						-Alex

> 
> For narmal situations, it is enough to just use normal priority QMI workqueue.
> 
>> Regards,
>> Bjorn
>>
>>>
>>> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
>>> ---
>>>  drivers/net/ipa/ipa_qmi.c             | 4 ++--
>>>  drivers/net/wireless/ath/ath10k/qmi.c | 2 +-
>>>  drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
>>>  drivers/remoteproc/qcom_sysmon.c      | 2 +-
>>>  drivers/slimbus/qcom-ngd-ctrl.c       | 4 ++--
>>>  drivers/soc/qcom/pdr_interface.c      | 4 ++--
>>>  drivers/soc/qcom/qmi_interface.c      | 9 +++++++--
>>>  include/linux/soc/qcom/qmi.h          | 3 ++-
>>>  samples/qmi/qmi_sample_client.c       | 4 ++--
>>>  9 files changed, 20 insertions(+), 14 deletions(-)
> 

