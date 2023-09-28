Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A927B291F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 01:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjI1X56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 19:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1X55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 19:57:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043019F
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 16:57:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SNqgmk023791;
        Thu, 28 Sep 2023 23:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aV42jCMLX5gdYTJmYA+4NY6S5Cu9N6Abmv0DWAsSWJE=;
 b=YqUhhXQriqmR6pe2lUtPygusuRiaP1ipnrd5TgdXBPMG3+Ojq9ZWctIXHFjiW2mfBETB
 Cyn1DJmWqXnFKXFKFYJp2Qu+qNI4+7f5z/bZw9Aq9DPtRS1/8yA6G5JojjqMSUNcYIpk
 nqXvKR40HgrxY9t3SCVFDTPRHGq46uzSqCQrrami3X7iEJjNmDTpe4DmJf8hVYWO5Zp9
 5XdJbc2Fym2WVv/zYUx+pmOsOxbBLgTUDmXTip0PMDxwoO/8o+X2K6NUqbipNwU4szot
 jOXHBkMU2Otln6lQjKt+HmlPybsehobZ5P7ek/loj++ueqOLQDU8eCuhrQC3S84KWmnD vg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tda4c18su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 23:57:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SNvenY004425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 23:57:40 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 16:57:39 -0700
Message-ID: <e1b4621f-5877-452c-8f92-01fe28982c58@quicinc.com>
Date:   Thu, 28 Sep 2023 16:57:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] wifi: mac80211: Check if we had first beacon with
 relevant links
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
 <20230928172905.3fe476aa83e5.Ic1505cf3d60f74580d31efa7e52046947c490b85@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230928172905.3fe476aa83e5.Ic1505cf3d60f74580d31efa7e52046947c490b85@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AY3qakrG6PyW7DV3aw_0XokOKnYvtaj1
X-Proofpoint-ORIG-GUID: AY3qakrG6PyW7DV3aw_0XokOKnYvtaj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_22,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=694 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/2023 7:35 AM, gregory.greenman@intel.com wrote:
> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> 
> If there is a disassoc before the fisrt beacon we need to protect a
> session for the deauth frame. Currently we are checking if we had a
> beacon in the default link, which is wrong in a MLO connection and
> link id != 0.
> Fix this by checking all the active links, if non had a beacon then

s/ non / none /

