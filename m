Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59BD1F07DB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2020 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgFFQMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Jun 2020 12:12:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21009 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgFFQMX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Jun 2020 12:12:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591459943; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=W2+f/Jlwr9sdU/LqjCOSQU2eKt+VOfS8dbeManW9W14=;
 b=oExGP6AgkLJBTHBEZnd2fc3zrzApQ0NqoBvGtiDM/bkXz/zgAolKO8k4HdzUltPVuCfW6Rmq
 6hTNm9QQPxXgbKKmyNptJFlMBJ73iE21cLthocci3v2TaO4Sz9pE11LrSplKoBPZynGS/BNA
 SHpTYf4+pSOCTJACciJlDUU0NFg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5edbc05360667f2e2f754084 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Jun 2020 16:12:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EADDCC43395; Sat,  6 Jun 2020 16:12:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD6AC433C6;
        Sat,  6 Jun 2020 16:12:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Jun 2020 21:42:02 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org, manivannan.sadhasivam@linaro.org,
        sibis@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Move msa region map/unmap to init/deinit path
In-Reply-To: <1591191231-31917-1-git-send-email-govinds@codeaurora.org>
References: <1591191231-31917-1-git-send-email-govinds@codeaurora.org>
Message-ID: <3e092e58b3c2055933141ae3b698a5c0@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pls ignore this WAR as it does not fix all cases.

On 2020-06-03 19:03, Govind Singh wrote:
> With kernel qrtr switch from user space qrtr, fw crash is seen
> during reboot. During reboot modem rproc shutdown causes wlan qmi
> service exit and msa region gets unmapped. Since pdev is not suspended
> hw still accessing the msa region and this results in  fw crash as
> msa region is unmapped.
> 
> Decouple msa mapping from wlan qmi server arrive/exit to init/deinit
> path.
> 
> Testing is pending with "0c2204a4ad71 net: qrtr: Migrate nameservice
> to kernel from userspace", only regression sanity performed with user 
> space
> qrtr on QCS404/SC7180.
> 
> Fixes: 0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from 
> userspace
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/qmi.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c
> b/drivers/net/wireless/ath/ath10k/qmi.c
> index 5ae829b46c3d..8b1291e28ba2 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -796,22 +796,16 @@ static void
> ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
>  	 */
>  	msleep(20);
> 
> -	ret = ath10k_qmi_setup_msa_permissions(qmi);
> -	if (ret)
> -		return;
> -
>  	ret = ath10k_qmi_msa_ready_send_sync_msg(qmi);


>  	if (ret)
> -		goto err_setup_msa;
> +		return;
> 
>  	ret = ath10k_qmi_cap_send_sync_msg(qmi);
>  	if (ret)
> -		goto err_setup_msa;
> +		return;
> 
>  	return;
> 
> -err_setup_msa:
> -	ath10k_qmi_remove_msa_permission(qmi);
>  }
> 
>  static int ath10k_qmi_fetch_board_file(struct ath10k_qmi *qmi)
> @@ -854,7 +848,6 @@ static void ath10k_qmi_event_server_exit(struct
> ath10k_qmi *qmi)
>  	struct ath10k *ar = qmi->ar;
>  	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> 
> -	ath10k_qmi_remove_msa_permission(qmi);
>  	ath10k_core_free_board_files(ar);
>  	if (!test_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags))
>  		ath10k_snoc_fw_crashed_dump(ar);
> @@ -1046,6 +1039,10 @@ int ath10k_qmi_init(struct ath10k *ar, u32 
> msa_size)
>  	if (ret)
>  		goto err_qmi_lookup;
> 
> +	ret = ath10k_qmi_setup_msa_permissions(qmi);
> +	if (ret)
> +		goto err_qmi_lookup;
> +
>  	return 0;
> 
>  err_qmi_lookup:
> @@ -1064,6 +1061,7 @@ int ath10k_qmi_deinit(struct ath10k *ar)
>  	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
>  	struct ath10k_qmi *qmi = ar_snoc->qmi;
> 
> +	ath10k_qmi_remove_msa_permission(qmi);
>  	qmi_handle_release(&qmi->qmi_hdl);
>  	cancel_work_sync(&qmi->event_work);
>  	destroy_workqueue(qmi->event_wq);
