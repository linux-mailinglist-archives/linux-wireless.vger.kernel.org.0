Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD56F7B61
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 05:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjEEDK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 23:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEEDKX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 23:10:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE86211DBF
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 20:10:18 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34532nhs030745;
        Fri, 5 May 2023 03:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+EEcic9YW8adPflQvC7dJKIL2bz4FIbMGUzGQptH45M=;
 b=MIsn6qTPMTtqDSh0HoEa8rQZ6kBY0/HAvX7CPXqAk4mlM3cGMaC1Gzxwb9RpGPPIlgx3
 XV/TGF/xbIijkX4nmabeThmDTGX4c4BmO1VVj2cP9YugolwAy9JDvOxVXu46fsx7DzUX
 Fl/2QbrjqGSNwHkIyjDPAoHgGaiz/p0ijSx4Hf+r8Wy11xRc+qsH0Idd9QbQ5wznTIeU
 enngi1xf1LCwUWS6/TIbl8b2kx0fFV7k16wbJPE0hRwKDr+rkv+G9m7L23PrHC2hq9/J
 DZhq/nbhpoSlx/bZm1GoiImbhp5ksvIGO1+FohwS2wGIrGz7+wc3w6SBAd2QLYO36nRr 9A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc7a42fnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 03:10:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3453ACLS012193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 03:10:12 GMT
Received: from [10.253.76.254] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 20:10:11 -0700
Message-ID: <d131fe0b-f416-f221-217d-4a42b932a680@quicinc.com>
Date:   Fri, 5 May 2023 11:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 00/11] wifi: ath12k: (v3) EHT support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
 <87ildjtc1c.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87ildjtc1c.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9K_6JayOUGDY5DBxUxzwl88WCePnWWIH
X-Proofpoint-ORIG-GUID: 9K_6JayOUGDY5DBxUxzwl88WCePnWWIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 mlxlogscore=846 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050026
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/26/2023 2:03 PM, Kalle Valo wrote:
> Aloka Dixit <quic_alokad@quicinc.com> writes:
>
>
...
> This breaks WCN7850 support:
>
> [  144.039164] ath12k_pci 0000:06:00.0: BAR 0: assigned [mem 0xda200000-0xda3fffff 64bit]
> [  144.039315] ath12k_pci 0000:06:00.0: enabling device (0000 -> 0002)
> [  144.046220] ath12k_pci 0000:06:00.0: Hardware name: wcn7850 hw2.0
> [  144.118539] mhi mhi0: Requested to power ON
> [  144.118716] mhi mhi0: Power on setup success
> [  144.222303] mhi mhi0: Wait for device to enter SBL or Mission mode
> [  144.627712] ath12k_pci 0000:06:00.0: chip_id 0x2 chip_family 0x4 board_id 0x104 soc_id 0x40170200
> [  144.627945] ath12k_pci 0000:06:00.0: fw_version 0x1005bc12 fw_build_timestamp 2022-10-11 12:13 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> [  144.959196] ath12k_pci 0000:06:00.0: failed to parse tlv -22
> [  144.959317] ath12k_pci 0000:06:00.0: failed to parse ext2 event tlv -22
> [  150.263567] ath12k_pci 0000:06:00.0: failed to receive wmi service ready event: -110
> [  150.276547] ath12k_pci 0000:06:00.0: failed to start core: -110
WCN7850 use "single_pdev_only = true" in ath12k_hw_params, it has some 
difference while handler WMI_SERVICE_READY_EXT2_EVENTID.
I have patch to handler this for WCN7850, and the patch is verified.
