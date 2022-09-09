Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58B5B2D48
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 06:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIIEQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 00:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIIEQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 00:16:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA0121115
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 21:16:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2893guvX003125;
        Fri, 9 Sep 2022 04:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PB6yekp+T/ib3XA50NMk3ORS4/oPAI/anuoTQSk0ZAQ=;
 b=ZjI35axTOOGXIWOR3QUX/tFcczKcPrDL8fhyt0N1HomRRC8imESOD0ysOdelxbPGAitS
 5JA5lrJxVmfKq8D0oRduEEa0Fi0u/iRy4nGvTP0yIwi1c9v7GNmv0vGit6m4F489QfMe
 mtzc4JcvSYYizTfCodQ6B9fUgZ0SJXNqg3iT+e+p5uSdWt3EyX+Sr7c4SLBkSB4ce+IA
 VAUvK2BahpbjNsiSb2UXsMqiGMsMUfoRsl8hf5qP86VHELQ5wuSD/O6Q3CY4E7CoLOj7
 4kLvP49FzgD3Wj+ajkhur9IOof6DgrXmXxEBR1m1NvmibJgeRnvFleE36MHHwR/Ms0e9 Kw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfuww89sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 04:16:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2894GJAI024285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 04:16:20 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 21:16:18 -0700
Message-ID: <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
Date:   Fri, 9 Sep 2022 12:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
 <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
 <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
 <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
 <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WT8bTCDKL4DuDKD5iUXEL1q6861mXSEA
X-Proofpoint-ORIG-GUID: WT8bTCDKL4DuDKD5iUXEL1q6861mXSEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_02,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=850
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209090014
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/8/2022 11:52 PM, Johannes Berg wrote:
> On Thu, 2022-09-08 at 23:51 +0800, Wen Gong wrote:
>> Another thing is what is the local MLD addr and local primary link(send
>> authentication/assoc requset) addr relation?
>> I think they are same address for station, right?
> No, they aren't, and shouldn't be.
IEEE P802.11be™/D2.0
35.3.3 Multi-link device addressing
An MLD has an MLD MAC address that singly identifies the MLD.
Each STA affiliated with an MLD shall have a different MAC address.
NOTE 1—The MLD MAC address of an MLD might be the same as the MAC 
address of one affiliated STA or different
from the MAC address of any affiliated STA.

This means the MLD address can be same with one link.

I suggest to set primary link local addr same with MLD address for station.
reason is:
When station up, one link interface of driver will be created with the 
addr of struct ieee80211_vif,
it is used for scan and non-MLO connection.
If station start to do MLO connection now, then random local link addr 
will be generated by below call stack.
for the 1st link. This lead driver must change the link interface local 
address to this random addr.
After disconnect MLO connection, driver also need to change the link 
interface local address back to
addr of struct ieee80211_vif. It increased the complexity and driver 
need to sync the link interface
if this is a scan running at this moment.

ieee80211_mgd_auth()
     ->ieee80211_prep_connection()
         ->ieee80211_vif_set_links()
             ->ieee80211_vif_update_links()
                 ->ieee80211_link_setup()
                     ->ieee80211_mgd_setup_link()
eth_random_addr(link->conf->addr);//sdata->u.mgd.assoc_data is null at 
this point
>> And the others local link address is random generated by eth_random_addr
>> in ieee80211_mgd_assoc() , right?
> Yes, at least for now all the link addresses are randomly generated.
>
> johannes
>
