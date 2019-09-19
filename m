Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2EB7E2D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391130AbfISPaK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 11:30:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50348 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfISPaK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 11:30:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JFE2LW096995;
        Thu, 19 Sep 2019 15:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=iHJm1l4HZi+NhouFuN8bcXuu6XqmPJ45tKB8Fntisrw=;
 b=Kg5gtAu4A354UfTrSxQQcvzAC1aZH1VNGX94GgGse3IZ3jcAY6+p6P91OPNd5t/jWPAr
 qAC8jlXNnr9yQrHL55RVCtHtoqnQ0+w1kevvacvWSe0Rzhjmnnr7OT3FgsffDIhy93Yu
 VzPtXfUQPFqe/7kJUeg0yX/s4GCpj+BBtmoj7U7kTUK4tD0X3sPG6oflQ8rI5DZvE+Vv
 6qOPbxofGuQEQykuIHzwrksgXTFCdryEBZV1v972qUllMf6jtpc1WM59G005a13x4Tq0
 tLYMsF4qxMcgFuBscKjGvITnOksKrl4BpReX401pTbUsAUpsHTClJvzF2Z/N+k5aOcqP tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v3vb4mu3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 15:29:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JFDOQe076300;
        Thu, 19 Sep 2019 15:29:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v3vbgav66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 15:29:59 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8JFTv59002627;
        Thu, 19 Sep 2019 15:29:57 GMT
Received: from [10.191.252.26] (/10.191.252.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 08:29:57 -0700
Subject: Re: [PATCH] iwlwifi: fix a potential NULL pointer dereference
To:     Johannes Berg <johannes@sipsolutions.net>, kvalo@codeaurora.org
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1568830262-5529-1-git-send-email-allen.pais@oracle.com>
 <fd8813c1c3c02734d60f494a3c8081d95550ec85.camel@sipsolutions.net>
 <2380f108-54a6-0110-4e2b-e66dd54ae800@oracle.com>
 <ac6cea459c697db7aec99b8c0c5c0b3bf76b5877.camel@sipsolutions.net>
From:   Allen <allen.pais@oracle.com>
Message-ID: <2ee2c6b1-49e3-5050-23c4-a27c152b836c@oracle.com>
Date:   Thu, 19 Sep 2019 20:59:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ac6cea459c697db7aec99b8c0c5c0b3bf76b5877.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190143
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>>>
>>> +	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
>>> +						   WQ_HIGHPRI | WQ_UNBOUND, 1);
>>> +	if (!trans_pcie->rba.alloc_wq) {
>>
>>     I would like to stick to if(unlikely(!trans_pcie->rba.alloc_wq) just
>> for consistency.
> 
> That's just clutter, this path gets called exactly once in the lifetime
> of most systems ...
> 
>>     Let me know if I could add your SOB and send out V2.
> 
> No no, I've already sent the patch on the way internally :)

Great. Thank you.
