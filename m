Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4725D7B548E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjJBOJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBOJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 10:09:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85809B
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 07:09:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392Cqn3j030923;
        Mon, 2 Oct 2023 14:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NAJ95J+c4IZJm7HDf0fm+4Wl4ZicV9IqxOM1yivywfA=;
 b=Ms+TfXERT1MDTy+5vP6uEaT8695nhaO9rvg3Qh8w/6cPCDOsVBWliG4ZSNoPV/zPR2Nm
 6zas5EIfehmG+AVb4mIoeCyvrHD1sdV4QkQyjg6GOPxSgp7iynUx/D67OcROJUU3KXET
 ZqT6GD5YOHKhCneEz5rDvqKbRBEUMhr/UabSREVC9ksO//2A2ocq5N2WQsAhKU3NFaLy
 mrQ3dwgqH0C00UcXn7psg3Rbq39iatOXj4GwJAhrgXlkdmw4/mZydbOXi2yCLY/UqyXF
 7c+mqazfiO1GGpR7ijPtb2uKZCKnv4BPl0Ytp4TQgepQ8vyURClYkAnhasIi+vq+p9ar 9A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tecuukp2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 14:09:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 392E9Go7032421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Oct 2023 14:09:16 GMT
Received: from [10.111.179.185] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 2 Oct
 2023 07:09:16 -0700
Message-ID: <d7185f2a-cae8-4560-b147-c1d88fd61868@quicinc.com>
Date:   Mon, 2 Oct 2023 07:09:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k_pci: failed to connect to HTT: -110
Content-Language: en-US
To:     Fourhundred Thecat <400thecat@ik.me>,
        Linux Wireless <linux-wireless@vger.kernel.org>
References: <1642436c-9046-1abe-c65b-880df9096038@ik.me>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1642436c-9046-1abe-c65b-880df9096038@ik.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _GH-hX1NGHvlkYUa1B1AlCkoup8bK6DM
X-Proofpoint-ORIG-GUID: _GH-hX1NGHvlkYUa1B1AlCkoup8bK6DM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2023 10:38 AM, Fourhundred Thecat wrote:
> Hello,
> 
> I have Qualcomm QCNFA765.
> I am using custom-compiled kernel 6.1.55. I have ath11k_pci in the 
> kernel, and all firmware files are loaded successfully. Yet, when 
> booting, I see on the console:
> 
> ath11k_pci: Service connect timeout
> ath11k_pci: failed to connect to HTT: -110
> ath11k_pci: failed to start core: -110
> 
> and the network device wlan0 does not exist.
> 
> But lspci -v shows the network card, and module it is using.
> 
> and dmesg | grep ath11k
> 
> ath11k_pci: BAR 0: assigned [mem 0x90600000-0x907fffff 64bit]
> ath11k_pci: enabling device (0000 -> 0002)
> ath11k_pci: MSI vectors: 1
> ath11k_pci: wcn6855 hw2.1
> ath11k_pci: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> ath11k_pci: fw_version 0x11090c35 fw_build_timestamp 2022-04-18 20:23 
> fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> ath11k_pci: leaving PCI ASPM disabled to avoid MHI M2 problems
> ath11k_pci: failed to receive control response completion, polling..
> ath11k_pci: Service connect timeout
> ath11k_pci: failed to connect to HTT: -110
> ath11k_pci: failed to start core: -110
> ath11k_pci: ignore reset dev flags 0x4000
> ath11k_pci: ignore reset dev flags 0x4000
> ath11k_pci: failed to wait wlan mode request (mode 4): -110
> ath11k_pci: qmi failed to send wlan mode off: -110
> 
> since I am using custom kernel, it is possible i am missing some kernel 
> option. Here is my kernel config
> 
> https://ctxt.io/2/AABQk4VZEg
> 
> can somebody please tell me what is the problem ?
> 
> thank you,

Does your tree have:
39564b475ac5 wifi: ath11k: fix boot failure with one MSI vector

