Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6D728F5D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 07:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbjFIFmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 01:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjFIFmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 01:42:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1830CF
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 22:41:59 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3595LO1s023967;
        Fri, 9 Jun 2023 05:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IQEc6RrGmaDr4EA6xaS271ozx16S+iAbtydx5mUqdxw=;
 b=VwSnWD1Dv4qQswQaqqahlJxUF3sSqWL9UHs76wExqUOO9xpWOY/jRuXmsg5Kgjmksd6z
 nz1P3Kh08/bRYOEKPjCs/BUgf8DzPiEvCEBGAPTMUMRycrf8MoEfZdVrMzhXUjFLWZ0K
 9qkqfr78zOt3ml3BzKm84k44PJVwHQrcaONCiKXJFd7sUVBZK/nJIsoWKrVTRNUJCQvG
 w3sIp5ay4oFsz7zAtFNxnXmNdhcBtbBZvNgSY1nzSko7WULQCZ4VtTLRXr7d23Cr5vzx
 p+qshwKtsNNF3kczLiCLYfIrd/0jUBUbIAQ6HEirkBxRZQbOtTESK6XtxTjT/wwyXeBP Xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r34em2wux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 05:41:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3595fXaZ011161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 05:41:34 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 22:41:32 -0700
Message-ID: <9d393f3e-4452-47c4-1911-92d817e89a25@quicinc.com>
Date:   Fri, 9 Jun 2023 13:41:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <yahuan@qti.qualcomm.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rxBL8L2lpkU5UXw0I6uYfqdb467kUoE2
X-Proofpoint-GUID: rxBL8L2lpkU5UXw0I6uYfqdb467kUoE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_02,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=681 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Could you give comments for these v3 patches?

On 3/15/2023 9:28 PM, Aditya Kumar Singh wrote:
...
