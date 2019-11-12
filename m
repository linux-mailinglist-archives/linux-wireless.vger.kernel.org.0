Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C976F995D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 20:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLTI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 14:08:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45524 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLTI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 14:08:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so13982026pfn.12
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BR4ymyy2vKO2uYqxjB3mPPNwSRoqEyTEGiX+v5/Slpg=;
        b=mVOnRN1VFG1LQezT4n1aeleww9wgfdVf1EnGVEdr7UvuTM41Q68FBfeDADhsOrzeUb
         33AfMamI/TexG3RQ1sGCIRtweUATCVoVgdDOudYh19VgpC+W0BMmg1E1Hhh7JlWEUPqt
         NOQ8EeVvFx9SV2WtjU/Zq0Ap+MrWcohYDikzh/vOYlIInFOuGeBl7loPQf+vdGmPumcE
         HhARyUvSUx+DMBqIoGzFSnU7e5845u+9IsgGBw+LIvCc6P48vcNHEAeDVPIXLQYdFhq7
         QkK7D8It9DTCBrHT3JlEuz7J6vP775/VOpRRj1uonqBcFgj7pZnk0fGnalzeaFIi73n5
         ht8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BR4ymyy2vKO2uYqxjB3mPPNwSRoqEyTEGiX+v5/Slpg=;
        b=t6DF9ETsWHXjWWT0VdGxexd2VrGmghbaiSuIQ4abUqgPZzzHmtBkk935PqYRnNuOZU
         LVGQyLTxCFSQjq5G2tzzRD/O9HKjqkBBjYJMZBPdh5GO2TiIitmHlmnEvpQum/t4gtdB
         pzl30+iMkiFZICoVzL/px20uFBfRITKC/1ICj3XQzCE+mGqErKdkfNN+Gd2tXgE09olu
         tBm5JuUmXJVh+XbP7Ija5c6AuhyKpFlvoMpnBiotGSq5gXfNJve1ies0c5OlQa3gNpsC
         LcOAB9L4JBKoK3Wiavr19IacD5PzyKl2pw30ccGA0j7pq9yG88effOBuDVwDg85/c3m8
         tqGg==
X-Gm-Message-State: APjAAAXderDVq9LChOAI14VOD2+p6Z5NYxBoocHWDiZFRj5HFl/8/Qcu
        /13CiMsABHWmQs6HsEm8m2kdDA==
X-Google-Smtp-Source: APXvYqy1gKPPrXY8YX4+sqitVZiIIJE+0IYMmTNjOu0a56hMa0jbdBrV/YRB4iYlDOv4vA7eF5VOuQ==
X-Received: by 2002:aa7:80d2:: with SMTP id a18mr14758511pfn.29.1573585705571;
        Tue, 12 Nov 2019 11:08:25 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u8sm8351425pga.47.2019.11.12.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:08:24 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:08:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath10k: Handle "invalid" BDFs for msm8998 devices
Message-ID: <20191112190822.GA3140946@builder>
References: <20191106234712.2380-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106234712.2380-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed 06 Nov 15:47 PST 2019, Jeffrey Hugo wrote:

> When the BDF download QMI message has the end field set to 1, it signals
> the end of the transfer, and triggers the firmware to do a CRC check.  The
> BDFs for msm8998 devices fail this check, yet the firmware is happy to
> still use the BDF.  It appears that this error is not caught by the
> downstream drive by concidence, therefore there are production devices
> in the field where this issue needs to be handled otherwise we cannot
> support wifi on them.  So, attempt to detect this scenario as best we can
> and treat it as non-fatal.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/qmi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index eb618a2652db..5ff8cfc93778 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -265,10 +265,13 @@ static int ath10k_qmi_bdf_dnld_send_sync(struct ath10k_qmi *qmi)
>  			goto out;
>  
>  		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
> -			ath10k_err(ar, "failed to download board data file: %d\n",
> -				   resp.resp.error);
> -			ret = -EINVAL;
> -			goto out;
> +			if (!(req->end == 1 &&
> +			      resp.resp.result == QMI_ERR_MALFORMED_MSG_V01)) {

Perhaps worth adding a comment in the code as well, to describe what
scenario this relates to?

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +				ath10k_err(ar, "failed to download board data file: %d\n",
> +					   resp.resp.error);
> +				ret = -EINVAL;
> +				goto out;
> +			}
>  		}
>  
>  		remaining -= req->data_len;
> -- 
> 2.17.1
> 
