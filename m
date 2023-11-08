Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F557E594D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 15:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjKHOj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 09:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjKHOj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 09:39:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC141BC3
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 06:39:24 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8E2ddA015496;
        Wed, 8 Nov 2023 14:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dv/Z9G6ZAr9+lMxiIaSYC1sphG27a5cZSvv4iXRKE4E=;
 b=VSi+0vhHhqkroGtIAQtYVqxDjxxDmSMhworfrSpTdIjGIddR3ewKbXcn4bPPSwKUOI+M
 PujqA8FLYosifRbed2QMDT91KXfaooS3H65LXXq7phi13SPNnvCfO/qDm7nD7CflxRjH
 dXjnedg56zHVARxqncDsXryQeZGhVzE+ZvNdR1dNAn2DVUA5Ha4XqP08vgdxuiG2hAqL
 BeXXfz/oxhyIn/USkuj4LbKFm4KN7DepEu1G6dXu3/IqBOwsyVudLay8fvoqK8059Vzl
 dyoOU9HGBHsS2w9dCgZmfUdkpG5K038Zr4KDT39nyAJGeBzmcJEPrMc/gzck/mUwV6nV kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2c1vvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 14:39:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A8EdFaX013459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 14:39:15 GMT
Received: from [10.110.1.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 06:39:14 -0800
Message-ID: <b2a44dc4-f5ec-46fe-a4ce-a2151ac65aa3@quicinc.com>
Date:   Wed, 8 Nov 2023 06:39:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can ath11k automatically enable CRYPTO_MICHAEL_MIC?
Content-Language: en-US
To:     James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <c558e244-b10d-43f3-9f42-f6c2f98d5b95@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <c558e244-b10d-43f3-9f42-f6c2f98d5b95@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K52qDjw9qRCO-05013gYInzWHpQXaLlV
X-Proofpoint-ORIG-GUID: K52qDjw9qRCO-05013gYInzWHpQXaLlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_03,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=703
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080121
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/2023 6:33 AM, James Prestwood wrote:
> Hi,
> 
> I'm not very familiar with how the Kconfig stuff works, but I spent 
> longer than I care to admit trying to get the ath11k support to show up 
> in menuconfig.
> 
> The issue was CONFIG_CRYPT_MICHAEL_MIC was not set, which removed the 
> ath11k driver from menuconfig because of:
> 
> depends on CRYPTO_MICHAEL_MIC
> 
> Maybe there was a good reason (again, I don't know much about Kconfig), 
> but should/could this use "select" to automatically enable 
> CRYPTO_MICHAEL_MIC?
> 
> Thanks,
> James

+ ath11k list to see if there is any history on this topic
