Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755F27D60F7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 06:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjJYEzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 00:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYEzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 00:55:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E809D
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 21:55:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P3ureI004025;
        Wed, 25 Oct 2023 04:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gyWPWjmjqLcBADPCyNQZAfS7D99bZTCB9d0MzfFFl0E=;
 b=C3dY5m1Q71rSFWumK3PWE1JrL3jrBv7Nok4nNUZ5zOYcrxYN1ICYzaQX9ob9mLTarzXP
 2NKGhTFBVapX+Vga+WRTs0YqbWKYZtXbjeB8F1slCXNzBm2KCIRUAbd/i/cntX61Blhc
 r4dmKwj0XphytlfaXiYEIvgblGAoAXuIaDjBr0+Nx+8AurObjACNHyCd/Duce5FAsiN3
 Ow77ZTBxhxwkhkLrTir6zjmtrrTuji7MaOA3GXsO4jQo0XU8s4ilW1sg8FU2YIR2QflU
 HRaJ8Kjzn7Wm/5REH73pBgcWyhntAPs4dqFkRELmW+vXoBEghhjuFK3mUbwXEkq+3IEV SA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txjtnh3nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 04:55:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39P4t8Wo025666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 04:55:08 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 21:55:07 -0700
Message-ID: <61688563-5db3-42e3-82a6-d972777a0923@quicinc.com>
Date:   Tue, 24 Oct 2023 21:55:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ieee80211: fix PV1 frame control field name
Content-Language: en-US
To:     Liam Kearney <liam.kearney@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20231025002755.1752983-1-liam.kearney@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231025002755.1752983-1-liam.kearney@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uK_n3TTrB9-Lv0xIPmQGtFErvnvVEDzG
X-Proofpoint-ORIG-GUID: uK_n3TTrB9-Lv0xIPmQGtFErvnvVEDzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=452
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/24/2023 5:27 PM, Liam Kearney wrote:
> Update PV1 frame control field TODS to FROMDS to match 802.11 standard
> 
> Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

