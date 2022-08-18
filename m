Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9B5990CD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbiHRXC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiHRXC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 19:02:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F2CAC65
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 16:02:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ILxdfF027517;
        Thu, 18 Aug 2022 23:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xB2x825eYZu+c0CZhOf14LGGuNhUb+GEZHWjxU8VRAY=;
 b=kpTm4dBJHyWnKbU2CJ997Hz6LmXBL3nvsB3S62GUZhNI6WhDQBysSmf3pSbKykLgmbBA
 71aItDQlgses1nz576W5JcxLYYVXWHsVnsIavsTGfzmm/AwfqZ51ed2mZx8WFoze+TU6
 Efga8/DmQUI5nL/xEf5MYQiO2fb2ffCwPHz4Oes0wdUDjkW2MDf73yqAslCKOKIl17a0
 f+eX0l2cClCjOF/u7QdPMLai7X4lI5b3GHuopfA5S5+mF726DO/ZwrvonW05QAk9qZ9w
 kBWVHKmUY787kVZ97dyGDD0z5M24R5EfSAnVp6W0cyvw9ZxJoTxT1NDYU1ARklO8IjyY 9Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j13c05ust-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 23:02:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IN2JEC002102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 23:02:19 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 16:02:18 -0700
Message-ID: <7b06d248-c976-6c9f-4d5c-5dec7b1d5511@quicinc.com>
Date:   Thu, 18 Aug 2022 16:02:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 35/50] wifi: ath12k: add pci.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-36-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-36-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G-oFaRIwDyhWmJLXyBODr9WRDDlSGvyO
X-Proofpoint-GUID: G-oFaRIwDyhWmJLXyBODr9WRDDlSGvyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:09 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/pci.c | 1344 +++++++++++++++++++++++++++++++++
>   1 file changed, 1344 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c

snip

> +static void ath12k_pci_remove(struct pci_dev *pdev)
> +{
> +	struct ath12k_base *ab = pci_get_drvdata(pdev);
> +	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
> +
> +	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
> +		ath12k_pci_power_down(ab);
> +		ath12k_qmi_deinit_service(ab);
> +		goto qmi_fail;
> +	}
> +
> +	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
> +
> +	cancel_work_sync(&ab->reset_work);
> +	ath12k_core_deinit(ab);
> +
> +qmi_fail:
> +	ath12k_mhi_unregister(ab_pci);
> +
> +	ath12k_pci_free_irq(ab);
> +	ath12k_pci_msi_free(ab_pci);
> +	ath12k_pci_free_region(ab_pci);
> +
> +	ath12k_hal_srng_deinit(ab);
> +	ath12k_ce_free_pipes(ab);
> +	destroy_workqueue(ab->workqueue_aux);

it seems strange/asymetrical to destroy this here.

it was allocated in ath12k_core_alloc() so I'd expect it to be destroyed 
in ath12k_core_free() to maintain symmetry

in addition I don't see ab->workqueue being destroyed, and imo that 
should also take place in ath12k_core_free() for the same reason

> +	ath12k_core_free(ab);
> +}

snip

> +static SIMPLE_DEV_PM_OPS(ath12k_pci_pm_ops,
> +			 ath12k_pci_pm_suspend,
> +			 ath12k_pci_pm_resume);
> +
> +static struct pci_driver ath12k_pci_driver = {
> +	.name = "ath12k_pci",
> +	.id_table = ath12k_pci_id_table,
> +	.probe = ath12k_pci_probe,
> +	.remove = ath12k_pci_remove,
> +	.shutdown = ath12k_pci_shutdown,
> +#ifdef CONFIG_PM
> +	.driver.pm = &ath12k_pci_pm_ops,
> +#endif

conditional compilation is unnecessary here since SIMPLE_DEV_PM_OPS 
handles the conditional

> +};
> +
> +static int ath12k_pci_init(void)
> +{
> +	int ret;
> +
> +	ret = pci_register_driver(&ath12k_pci_driver);
> +	if (ret) {
> +		pr_err("failed to register ath12k pci driver: %d\n",
> +		       ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +module_init(ath12k_pci_init);
> +
> +static void ath12k_pci_exit(void)
> +{
> +	pci_unregister_driver(&ath12k_pci_driver);
> +}
> +
> +module_exit(ath12k_pci_exit);
> +
> +MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11be WLAN PCIe devices");
> +MODULE_LICENSE("Dual BSD/GPL");
> 

