Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2739433AE3B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCOJLs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 05:11:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCOJLf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 05:11:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12F9A6B9073804;
        Mon, 15 Mar 2021 09:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TyGg+uKj5swceqnF7ADrAAvVI400/7/tNo98mRFkVRE=;
 b=vkpLBY1amFW28s74cLLzH8XTDwxCpvezENWmtyyvCHl/WAQ3FqbrgHJfcoXa87YXQqgf
 NmsXOf2xoAKB4K8iNIvpXurMAnAyKUJEUglWQSQsjZ6zqCgrdIwMFnmrx7cev4uKMR4Q
 W3gKh460xEkymW9kR45p0UoZ49oA6+PTTqsx5M0agvBHtlwDcVlz3h12ociwhsAHs3Xj
 W5KyzxEenxT1p+3BIOwG9GX8/xNLLHsMnNeSLaPWBSU4yZmlhYQ3Wjcz0xEcGpQAi6tn
 f0wWJ9+2rFw3NsP4w1fJyP0LzCmifkQpihfaiRDMetqxU98BI1GROo2h1sIGGhMtLNEC xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 378p1nk1p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 09:11:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12F9B3qD108285;
        Mon, 15 Mar 2021 09:11:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 37a4er8kt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 09:11:21 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12F9BIlU022840;
        Mon, 15 Mar 2021 09:11:18 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Mar 2021 02:11:18 -0700
Date:   Mon, 15 Mar 2021 12:11:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Tzu-En Huang <tehuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtw88: Fix an error code in rtw_debugfs_set_rsvd_page()
Message-ID: <20210315091107.GO21246@kadam>
References: <YCwgb/4F4Y+tyE56@mwanda>
 <20210315080817.A3975C43461@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315080817.A3975C43461@smtp.codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150064
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150064
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 15, 2021 at 08:08:17AM +0000, Kalle Valo wrote:
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > The sscanf() function returns either 0 or 1 here.  It doesn't return
> > error codes.  We should return -EINVAL if the string is invalid.
> > 
> > Fixes: c376c1fc87b7 ("rtw88: add h2c command in debugfs")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Why do you remove the num variable? I think the code is more readable with it.
> 

The way I wrote it is slightly more normal (457 vs 333) and we don't use
"num" except for the one if statement.  But I can write the other way.
I'll resend.

regards,
dan carpenter

