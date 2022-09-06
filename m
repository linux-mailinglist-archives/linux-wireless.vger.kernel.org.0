Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9BA5AE0CE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 09:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiIFHSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 03:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiIFHSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 03:18:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649397434F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 00:18:30 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28638APs022557;
        Tue, 6 Sep 2022 07:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Df3CbfF3GBxNeh1BN+fU4TQ8m/LykUq8j7p3I0KfFFk=;
 b=ViC3SpAdccqEcSFO3KtK4C4co0R/p9Zx2mvde7qDN7Mo/vjM5jMGzNZidCceixhMsM1f
 thex41+rfWzmbnpm+4W27QFHPNlQq9cuBJrsXK/cTa3GamXlnPesWTrgacv/SMOVqC9q
 B6IJ1ImeUuDavvWklwxWQd4abzWTURWCEP7iXU6PdQvqd6z8dFJGMdTyhjZL+l7P5Exe
 n5qWAsuORkpQFBH9Xn+GdEYlo354L3pIK89t+SgdZx1vS4CLsFbNxL2SH5Iko3GfaQOC
 CfSJ1kmVN+fF96aZvpMI8oPWkRXTes3b7Mos78dM8lpszUietpKKR20kwuzlcq+rpFYV sQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jdufwh9xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 07:18:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2867IQKK030880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Sep 2022 07:18:26 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 6 Sep 2022
 00:18:25 -0700
Message-ID: <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
Date:   Tue, 6 Sep 2022 15:18:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 00/27] another set of MLO patches
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dzimart4mXIguP6SaJCUgp3GkWhMoWH4
X-Proofpoint-GUID: dzimart4mXIguP6SaJCUgp3GkWhMoWH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_03,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=568 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060034
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 10:12 PM, Johannes Berg wrote:
> Alright, here's another set of MLO patches :-)
>
> I'm preparing everything here for link switching (which is also in
> wireless-next/mld-wip branch already), along with some fixes to
> avoid VLANs/4-addr and various other fixes that came up during
> this work. Not all of them are related, e.g. the SW scan stop just
> came up due to the new hwsim checks.
>
> johannes
>
Hi Johannes,

The 3 commit below changed to use MLD address for send 
authentication/assoc request for station and
changed to use MLD address of rx management packet include 
authentication/assoc response received by station from AP.

Does it has any description about the MLD adress in authentication/assoc 
request/assoc response in IEEE P802.11be™/D2.0 or other sepcification?

wifi: mac80211: mlme: transmit assoc frame with address translation
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=4ca04ed36478e21b037fc379a7e6f52d0e6d8d52

wifi: mac80211: support MLO authentication/association with one link
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=81151ce462e533551f3284bfdb8e0f461c9220e6

wifi: mac80211: do link->MLD address translation on RX
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=42fb9148c078004d07b4c39bd7b1086b6165780c
>
