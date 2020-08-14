Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE61B2448BE
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHNLSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:18:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51036 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgHNLSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:18:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EBGoNJ070776;
        Fri, 14 Aug 2020 11:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=41fr713SEuqBN+291fchNgohOxrXXq9eL+cDz9R+CuI=;
 b=FI3d3AXs9xnVCIfnFeN2Z/Aecm+e8qerW6wrBfQ2CFDEqzXMP0ZfJ3ma1fzXHN6znyu1
 OUatmH1UMyG8kvq2g5D+oYDxRoIoi3GbcTzWuz9jL9g0BpOF+ef1JOxfhwy9StJXCPoW
 KEaqA1SSxjy71xI3QosaLd50Pf3XT7KUAtUWlnaGQgoU2C688FSu1pw7/4qovN5rihis
 WOCJOcTYBWwQ75FQD9CsUAy87hKGYB5nZzLBMtSX/CB7/UlQDzNTVJ4wBIgz8z2F7dCj
 DAX/sf9wYX4e1oBbTtvuGVd2+uj6jTyp1mAPE1MH46a0ArE9/tkC+BZ1Q/PKImStf911 eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32w73ccwda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 11:18:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EBHg00135553;
        Fri, 14 Aug 2020 11:18:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32u3h815gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Aug 2020 11:18:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07EBI11j021448;
        Fri, 14 Aug 2020 11:18:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 11:18:00 +0000
Date:   Fri, 14 Aug 2020 14:17:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jouni Malinen <jouni@qca.qualcomm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] ath6kl: prevent potential array overflow in
 ath6kl_add_new_sta()
Message-ID: <20200814111753.GQ1793@kadam>
References: <20200813141315.GB457408@mwanda>
 <61e34f670a4845f8b1cbf6f6013f8a35@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e34f670a4845f8b1cbf6f6013f8a35@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140087
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 14, 2020 at 08:49:43AM +0000, Walter Harms wrote:
> nitpicking:
> 
> the debugtrace will give the impression that the function is 
> running. perhaps it is more clever to have this after the check.
> 

The debug is more useful they way I did it.  Otherwise it doesn't
print anything.  This is also the normal way to do this sort of
debugging.

regards,
dan carpenter

