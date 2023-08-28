Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D010978AC2D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjH1Kht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjH1KhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 06:37:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7669BAB
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 03:37:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S8eD5X020144;
        Mon, 28 Aug 2023 10:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3YviArF8KzsiOoLsdvbrpEFgVXuSIBYlTeOVplZXqcA=;
 b=MXxZ+IAi0MosuNOu8ioYwMZQ8G3ZtkFvVAJ5EDBmEzRpJU0/CZvo4aU80+SKsu+6KeEv
 PjcqwVc1jAYFacDEKS1a6AIYe5jtzN4yER2QFzXmDnY7UT/VtCKtwonnOIaLWXHlTG6r
 0QGCjh97VHU0zpEczeTSGk6e8Il4e9nKk0aCXZWUKgSPzlKJA1LW2DAUY8w4+toFPmWJ
 tjDXFUbLW4j42vXQFPWgLhMdtmXG1CLPVxqRpwjqkm/Y7UvnWf9J4TedMnD7Wyrq8jvd
 YFSp8DdDPevjOX5YDVzyjzCKtn8sE9qFTf32jc+gEx0Rn+gS66IoAgQIdEZnssWNepZ1 YA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9m8ucap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 10:37:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SAbEG9019001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 10:37:14 GMT
Received: from [10.231.195.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 03:37:12 -0700
Message-ID: <07d48f1e-88ee-85d5-b920-ec75ffb4ef8d@quicinc.com>
Date:   Mon, 28 Aug 2023 18:37:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 12/15] wifi: mac80211: Print local link address during
 authentication
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, Ilan Peer <ilan.peer@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
 <20230827135854.9c08605e2691.I0032e9d6e01325862189e4a20b02ddbe8f2f5e75@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20230827135854.9c08605e2691.I0032e9d6e01325862189e4a20b02ddbe8f2f5e75@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sahtvI0HRzFd5yp44XuyYoW8myGxyjqy
X-Proofpoint-GUID: sahtvI0HRzFd5yp44XuyYoW8myGxyjqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_07,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=774
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280095
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/2023 7:05 PM, gregory.greenman@intel.com wrote:
[...]
> @@ -7218,6 +7217,19 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
>   	if (err)
>   		goto err_clear;
>   
> +	if (req->link_id > 0)
> +		link = sdata_dereference(sdata->link[req->link_id], sdata);
> +	else
> +		link = sdata_dereference(sdata->link[0], sdata);
> +

req->link_id >= 0 means MLD.
For non-MLD, req->link_id < 0, is it better to use sdata->deflink for non-MLD?
Is sdata->link[0] always pointer to sdata->deflink for non-MLD?

It has a comment for deflink of struct ieee80211_sta, but no comment for deflink
  of struct ieee80211_sub_if_data.

> +	if (WARN_ON(!link)) {
> +		err = -ENOLINK;
> +		goto err_clear;
> +	}
> +
> +	sdata_info(sdata, "authenticate with %pM (local address=%pM)\n",
> +		   auth_data->ap_addr, link->conf->addr);
> +
>   	err = ieee80211_auth(sdata);
>   	if (err) {
>   		sta_info_destroy_addr(sdata, auth_data->ap_addr);
