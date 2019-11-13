Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5373DFBC05
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKMW7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 17:59:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKMW7o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 17:59:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so2329761pgh.5
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 14:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x0ZnUt6kpEl8U4BFQc25DnqaMomOkgg87tNLp5MJobU=;
        b=R0eY7mrKlGW/OVdYhbPMbOVBf7QxU9dLQqSt3WiiDoDKS8ojUQSuj1cJ5zzMazX1hb
         JTqeimnK15zfrigBOGnw0Bq7/sqQhFU7tOw6X+B5iKTiTR7mMr7rGAtEACGGrXe9fPkb
         NkZK+FmDj/EJuSRG5oerEwQbu/cKivtP2hZ5jDuw0hXdKcfw/7q15elq09GfpcEcv4K8
         nOafiv1azzgJ4A5F06hFgXH+xgleCBpIXU0JUe3AqkqfY8rTXWJc/yCQJ3i0pkFvBJ0R
         kTH0JQ6jMtGy9iIKtMI6NdCt3sBNByqTV1Ht2VTohQOqc9LKt4pbZXkupbvBxiGoVq7T
         tRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x0ZnUt6kpEl8U4BFQc25DnqaMomOkgg87tNLp5MJobU=;
        b=N6PSc2DBpX7SNQnDpwT9WtslJS1pfuUxa+fnBHhYeP1NXrf194TTWNvn51PB0u1187
         T52lCCGiizJz9A1PpQ4z5U2iA8V1NYQltRX3yxoZSyMWl9C3CKgJ0C10qN1fYSXyVn7g
         mT/48veoaUquZfIYvbI4OMDbDZhKJEZJo2jv9fUzSOcgX0MKje6fS5nQo+82k9hlT1G5
         Nn13qaKLsknzVhqvw5UJbqmLA0uZZWW3Gm3HZCH6ZJPtknic04syAEh+b0i232rrNStW
         uRkMlhEbO2TZ/PwINl+4ygeVK6jKAU4munySQVG1vy0j+zHlqLOtzX2qrTlGmajlpXLW
         qVgg==
X-Gm-Message-State: APjAAAU7hzHjxwLzpRoiRCzrWHUulXM0jgfJlZU4p21HOph7HazGGe44
        a0zqFTjPBViHsepgirNdTvJUQw==
X-Google-Smtp-Source: APXvYqxB6VnLMk6EwZYMzfe4Eo4jDzf5CFGuPJT1iqW0GcmV//9bJ9nx8dCxRAqDYoD6u/PuzXc5Nw==
X-Received: by 2002:a17:90a:3264:: with SMTP id k91mr8088584pjb.23.1573685981680;
        Wed, 13 Nov 2019 14:59:41 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h13sm4557008pfr.98.2019.11.13.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 14:59:41 -0800 (PST)
Date:   Wed, 13 Nov 2019 14:59:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath10k: Handle when FW doesn't support
 QMI_WLFW_HOST_CAP_REQ_V01
Message-ID: <20191113225938.GA3727453@builder>
References: <20191106233130.2169-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106233130.2169-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed 06 Nov 15:31 PST 2019, Jeffrey Hugo wrote:

> Firmware with the build id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0.2-XXXX does
> not support the QMI_WLFW_HOST_CAP_REQ_V01 message and will return the
> QMI not supported error to the ath10k driver.  Since not supporting this
> message is not fatal to the firmware nor the ath10k driver, lets catch
> this particular scenario and ignore it so that we can still bring up
> wifi services successfully.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/qmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index 545ac1f06997..eb618a2652db 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -614,7 +614,9 @@ static int ath10k_qmi_host_cap_send_sync(struct ath10k_qmi *qmi)
>  	if (ret < 0)
>  		goto out;
>  
> -	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
> +	/* older FW didn't support this request, which is not fatal */
> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01 &&
> +	    resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01) {
>  		ath10k_err(ar, "host capability request rejected: %d\n", resp.resp.error);
>  		ret = -EINVAL;
>  		goto out;
> -- 
> 2.17.1
> 
