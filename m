Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B339A59A742
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 23:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351998AbiHSUv7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351995AbiHSUvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 16:51:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A690D8E1B
        for <linux-wireless@vger.kernel.org>; Fri, 19 Aug 2022 13:50:52 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JB1FwI031941;
        Fri, 19 Aug 2022 20:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NVEKoE6HPyHMIKayE+its8PR3siiCvbCSH1tYN00GI0=;
 b=lgjPtuvxNdqtlli0ZoT+vGNp2OfiI0IvbgRYXrsWccdBl9Wv4zMTKiBL0TQ0/afexCbS
 /F33460vMh7X8vklOZIhUtRD0qqunoT4n5JhXc4wX1OqLs2nnXOJfrA32+hKeGzIT3Rn
 uaeRHwBwI67olRCg42uiqGBf2HImaa4ySxhT3J7SeDI7rjoZmUHcrbgb8AdcxaZDL7l/
 qtmql2w3Mz11FFGOnXpuWtfaZtiEmt/JAnotkgWHRtk17uyo05LPuI3EQOHSN2NzVFtp
 shnt/Xmll6zf+UILFEyZiCHSh6q12zVvqqAa9j/zV7l8f9xpJsTGZHDmI0BCMGiZYZcb iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j256ttbdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 20:50:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27JKjTJr012263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 20:45:29 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 19 Aug
 2022 13:45:28 -0700
Message-ID: <959339da-3574-8638-02e6-e1459559fa45@quicinc.com>
Date:   Fri, 19 Aug 2022 13:45:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 46/50] wifi: ath12k: add wmi.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-47-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-47-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _dNgFRp2Z15Bf7y1aDGO1KXwLpS9Sq7j
X-Proofpoint-GUID: _dNgFRp2Z15Bf7y1aDGO1KXwLpS9Sq7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
>   drivers/net/wireless/ath/ath12k/wmi.c | 6558 +++++++++++++++++++++++++++++++++

[...]

I notice an inconsistency in logging, and wonder if there should be 
consistency. Some commands have a debug log after ath12k_wmi_cmd_send() 
and some have a debug log before:

> +int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
> +			   struct ath12k_wmi_vdev_create_arg *args)
> +{

[... after case ...]

> +	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_VDEV_CREATE_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab,
> +			    "failed to submit WMI_VDEV_CREATE_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> +		   "WMI vdev create: id %d type %d subtype %d macaddr %pM pdevid %d\n",
> +		   args->if_id, args->type, args->subtype,
> +		   macaddr, args->pdev_id);
> +
> +	return ret;
> +}

[...]

> +int ath12k_wmi_send_peer_delete_cmd(struct ath12k *ar,
> +				    const u8 *peer_addr, u8 vdev_id)
> +{

[... before case ...]

> +	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> +		   "WMI peer delete vdev_id %d peer_addr %pM\n",
> +		   vdev_id,  peer_addr);
> +
> +	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_PEER_DELETE_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_PEER_DELETE cmd\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
> +}

in the case where an error is reported I think it would make more sense 
to have the error log after the debug log.

For the "after" case above, in the error path, you'd have logs:
failed to submit WMI_VDEV_CREATE_CMDID
WMI vdev create: id %d type %d subtype %d macaddr %pM pdevid %d

IMO this is confusing since it tells you it failed, but then seems to be 
telling you it did somethig

For the "before" case above, in the error path, you'd have:
WMI peer delete vdev_id %d peer_addr %pM
failed to send WMI_PEER_DELETE cmd

This seems to make more sense since it tells you it is doing something 
and then tells you that what it was trying to do failed. no ambiguity.
