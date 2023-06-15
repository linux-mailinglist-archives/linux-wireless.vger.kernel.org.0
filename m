Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123AF730D3B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 04:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbjFOC1H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 22:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOC1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 22:27:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514591BF8
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 19:27:05 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F1pW5W031795;
        Thu, 15 Jun 2023 02:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=85CY28qY/Z7AbTsQPkZwoI55W/MMosYt1HZ/RFuZZv4=;
 b=SBaP0vYM3c1bZtokS95AgI5FzxZCGUQzZJSxjVv/RYzbcdRkjsj0f4QryG20OtqpiDcT
 d9qc9YKJnQVjmRvo0jRgbL/e6zHskBoKdwlsOJQn5fxJWobm0UN++gQORPbZ1eHuZSDM
 7QEB1HE0yT0CDnc1gE+oDenThfUgRsYI8A/U/PZt7m49XByqBIzpXlXvd/KfQEKB5+sJ
 XwvgCi+OAAvObxCR6QM5ikrwMMe8DOaP2lUB/BJ7HQ/zmyxDaZAA6LhA3B0fpvUTc+xC
 Qw23z6JPlY4+FzsSRN3CUINNcHqlTK0j1sHR7ZuN2XwOYkcT+tHhgTBSNKaejjEjxnWM Kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7ks68hcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 02:26:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F2QtaW015885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 02:26:55 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 19:26:54 -0700
Message-ID: <a7093d7a-0179-7b5f-cc61-a501331d35c6@quicinc.com>
Date:   Thu, 15 Jun 2023 10:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
 <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
 <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
 <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
 <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
 <2cc79101249548f2a92c14af6aff6121143907d6.camel@sipsolutions.net>
 <1c26c205-0240-7670-117d-02a7af068724@quicinc.com>
 <6f8db032286923845202c7d658f1d39db79a758c.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <6f8db032286923845202c7d658f1d39db79a758c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nLW19K9csLgH6zPzyLETVEXVFu7LdDv0
X-Proofpoint-GUID: nLW19K9csLgH6zPzyLETVEXVFu7LdDv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150017
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 6/15/2023 2:32 AM, Johannes Berg wrote:
> On Wed, 2023-05-24 at 15:41 +0800, Wen Gong wrote:
>> May I add a new ops in struct ieee80211_ops? like this:
>>
>> u16 active_links(struct ieee80211_hw *hw, struct ieee80211_vif vif, u16
>> new_links)"
>>
>> then ieee80211_set_vif_links_bitmaps() call the ops to get the links for
>> station and set the sdata->vif.active_links with the return value from
>> lower driver,
>> it means lower driver will dynamic select the links count at this moment.
>>
>> If lower driver not register ops active_links, then keep current logic.
>>
> I guess you can can send patches for whatever you want :)
>
> But I have no idea what you're trying to do? Why would you need to have
> a callback?

Currently driver could use ieee80211_set_active_links_async() to active 
links after connection completed.

But I would like to allow driver to select active links in a early time, 
it will be more convenient for driver.

>
> Was this for link selection in the driver? We should have a patch
> somewhere that adds a BSS_CHANGE flag for when the valid links change,
> so the driver can select others.
>
> johannes

Yes, it is for link selection in driver at a early time before 
connection completed.

Could you tell detail about how the BSS_CHANGE flag works?😁

