Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FED1DE13A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgEVHpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:45:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60906 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgEVHpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:45:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M7gTgg144154;
        Fri, 22 May 2020 07:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wUngACO6K3FamWywrvEa3kjqSy0a9Y1L5dy/nrosdQs=;
 b=A2k+DovclLwClh2ZBFm3NDljhB9zW1ezhlZk8UoddJ5fYPduBrr3rlYlu7czc3w4Xl8f
 eR1RAlKAYKBU6cCmcfv3lEzw7EE1BnGBosJwQOmxxFclVggX+NLp3NBhB7ol/nzIAn4r
 Nw6AnyYY37jTxGvjIUYxO/sEnyj71h33nJyoyaSRPdcnIeCjLEEbeHCtMbdBwrMKlq1g
 zIosOl1yupfN05Fui760yN1rAph0ikkMUECPG8DIiwR4MXKyQtPvzpCtACEZE9cP8Vz5
 /hUk6gNMtiR7ub3AiDcXzP1f36k4OnWpYUtzwZdBLcyQKCF4F9gsJWLIOHsYhhwT+A7Q NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31284mcaug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 07:45:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M7hG5u006399;
        Fri, 22 May 2020 07:45:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 312t3dr6u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 07:45:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04M7jTDk003959;
        Fri, 22 May 2020 07:45:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 00:45:29 -0700
Date:   Fri, 22 May 2020 10:45:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: fix possible NULL pointer dereference in
 mt7915_register_ext_phy
Message-ID: <20200522074522.GB22511@kadam>
References: <a03171996da0aaaa0963a4704b6d59be818bd42f.1590132235.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03171996da0aaaa0963a4704b6d59be818bd42f.1590132235.git.lorenzo@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220062
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Fri, May 22, 2020 at 09:26:06AM +0200, Lorenzo Bianconi wrote:
> Fix a NULL pointer dereference in mt7915_register_ext_phy since phy
> data structure is allocated by mt76_alloc_phy routine
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Thanks!  Could you fix the same the bug in mt7615_register_ext_phy() as
well?

regards,
dan carpenter

