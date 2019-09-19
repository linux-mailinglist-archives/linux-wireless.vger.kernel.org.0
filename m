Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32543B7BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfISOHV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 10:07:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387729AbfISOHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 10:07:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JE4LSn029434;
        Thu, 19 Sep 2019 14:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=/YOWrbzA7kJtkI9FFDm8sH5YeE3VoVARbcy1fM1cXRE=;
 b=qZLq+3h2EvEkLjvIyHKLJDAHQ32KYiaJdh0PBfakYyRHY5KW78HK8ieinAblp2oEFach
 sLKV0aYEnAfvOOE66nEEtzEaWzwnYZeAeyk91KR2PYSnIPI3rNsAk1/q7e9LoWo013TP
 qz3VMa4mtgybbXJfIVTvbLgML3oQkejaEyzF3u+jsy7/RZujEsiXXF3/GdTXA7HkcfMP
 tcTTT3bfLh9VaCD8/mDwywpLwSdIl+mF5tSEyqXcd+y2jBBuOdn0sX+w27DicfOGhCrm
 7d99D8QKK0XUJLzVxppypl1TFcfjYxuNkQ0Wk3bYj4KO+++/ooKJNT0ytF0nDocv2gv/ Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v3vb4m7fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 14:07:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JDwbWd176998;
        Thu, 19 Sep 2019 14:07:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2v3vbs5jb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 14:07:08 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8JE76Ts016960;
        Thu, 19 Sep 2019 14:07:06 GMT
Received: from [192.168.0.106] (/183.82.16.154)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 07:07:06 -0700
Subject: Re: [PATCH] iwlwifi: fix a potential NULL pointer dereference
To:     Johannes Berg <johannes@sipsolutions.net>, kvalo@codeaurora.org
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1568830262-5529-1-git-send-email-allen.pais@oracle.com>
 <fd8813c1c3c02734d60f494a3c8081d95550ec85.camel@sipsolutions.net>
From:   Allen <allen.pais@oracle.com>
Message-ID: <2380f108-54a6-0110-4e2b-e66dd54ae800@oracle.com>
Date:   Thu, 19 Sep 2019 19:37:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fd8813c1c3c02734d60f494a3c8081d95550ec85.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=914
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=985 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190133
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> 
> Anyway, as 0-day bot pointed out, this isn't really right. The cleanup
> paths here are also tricky, so I arrived at this patch a few days ago:

  My bad, I should have looked at the cleanup path.

> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index eb544811759d..882fdf7e5e7b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -3530,6 +3530,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
>   	spin_lock_init(&trans_pcie->reg_lock);
>   	mutex_init(&trans_pcie->mutex);
>   	init_waitqueue_head(&trans_pcie->ucode_write_waitq);
> +
> +	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
> +						   WQ_HIGHPRI | WQ_UNBOUND, 1);
> +	if (!trans_pcie->rba.alloc_wq) {

   I would like to stick to if(unlikely(!trans_pcie->rba.alloc_wq) just 
for consistency.

   Let me know if I could add your SOB and send out V2.

- Allen

> +		ret = -ENOMEM;
> +		goto out_free_trans;
> +	}
> +	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
> +
>   	trans_pcie->tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
>   	if (!trans_pcie->tso_hdr_page) {
>   		ret = -ENOMEM;
> @@ -3664,10 +3673,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
>   		trans_pcie->inta_mask = CSR_INI_SET_MASK;
>   	 }
>   
> -	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
> -						   WQ_HIGHPRI | WQ_UNBOUND, 1);
> -	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
> -
>   #ifdef CPTCFG_IWLWIFI_DEBUGFS
>   	trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_CLOSED;
>   	mutex_init(&trans_pcie->fw_mon_data.mutex);
> @@ -3681,6 +3686,8 @@ out_free_ict:
>   	iwl_pcie_free_ict(trans);
>   out_no_pci:
>   	free_percpu(trans_pcie->tso_hdr_page);
> +	destroy_workqueue(trans_pcie->rba.alloc_wq);
> +out_free_trans:
>   	iwl_trans_free(trans);
>   	return ERR_PTR(ret);
>   }
> 


