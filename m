Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6F782730
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjHUKge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjHUKgd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 06:36:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B99CF
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 03:36:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LAa2mP029437;
        Mon, 21 Aug 2023 10:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M9LrFDGtirBDe4qaL6Pz4lsB7+9h7xdTOhN3vR5Q2tw=;
 b=cBMnOYosQYL4SYAYGTnUKXWLK6bEATyn3OFz0OD2QZEEMZdaVEyOU9d9iMiNjQAI18CZ
 UhlwdrRkBk5ONn1JyMxV530H6cFLNdvucbyIsusJ8n4iDc6KDztfo576cOlgjNvb5FIp
 qo8cSQYOeZml8oCgtZ9kuIFBDmcZHABg4RdQ7oia7rBituYSbG/Fx42Xd38cgdqdyvSF
 bUQ3UV9zkwmA5jWnr/pQ7l9hkjWpIcsNlwz5ZLdGlQg52Rs2ax5DVdpgCNtGk6yq/3r/
 M0JpKbp+ZYQzk6zpW+nOqGEoQtZGxGqOILaiwPTWu5IkXokTmizGw2HAA4mWn6WR2XC3 Xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjk3tkgdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 10:36:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37LAaR5X021382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 10:36:27 GMT
Received: from [10.253.75.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 03:36:26 -0700
Message-ID: <9ce54e8e-556b-976c-06d9-145b747705db@quicinc.com>
Date:   Mon, 21 Aug 2023 18:36:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz
 operation information"
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
 <f28ee65621bd52ad59cae891e81431ef83eeaf2e.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <f28ee65621bd52ad59cae891e81431ef83eeaf2e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QJApxRS6cBBydsEfN47gBfYQ09lqMWT5
X-Proofpoint-ORIG-GUID: QJApxRS6cBBydsEfN47gBfYQ09lqMWT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210097
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/21/2023 5:06 PM, Johannes Berg wrote:
> On Mon, 2023-08-21 at 10:59 +0200, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> This reverts commit cb751b7a57e5 ("mac80211: add parse regulatory info
>> in 6 GHz operation information") which added a station type bss_conf
>> assignment in a parsing helper function, which will corrupt mesh data.
>>
> Ah crap this won't work, rtw89 already uses this.
>
> Wen please send a fix for this ASAP.
>
> johannes

Hi Johannes,

I looked the patch some times, but I do not know how it corrupt mesh data,

Is there any clue for me?

