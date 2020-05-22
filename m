Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3B1DE252
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgEVIk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 04:40:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgEVIk2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 04:40:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M8XV4F017562;
        Fri, 22 May 2020 08:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6gzheESaMSB8Q5+Lji9xAUUxK5HXoYYW/K4BBIqJrmg=;
 b=RQxT308nEbHQsvOL6ut+KOgOgNQteDwkq9uQNsXhvYiZecited2IZ3Bx9o+06f7/Mj/n
 T4l32xEPxZw7+ESaNEx0RSk39PEurPx/34mzLK1dGYjWoS8YWAF8Rn42vrKjHv0DkpYu
 b05hKnqyz4F5rllhxYod5hWoWT2QIMQgSEWB6HdCRCU6YmyN5k1C3KnfZXq0uHeqRoxB
 253vyk7SiH3ZMdM0cPYybRvQ/8SUayjM33f7QMJCVvT4r21Pfi6AIctDQuHzprBTshOv
 TL0o9qb5Ch4r2voh5NCYsTZnXD4Tr6191e5YpEZxpASWbkYVDrcBXnyVh3xvgQh/pArH Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501rk3kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 08:40:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M8WixY009163;
        Fri, 22 May 2020 08:38:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj73tp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 08:38:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04M8cGUA003683;
        Fri, 22 May 2020 08:38:16 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 01:38:15 -0700
Date:   Fri, 22 May 2020 11:38:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: fix possible NULL pointer dereference in
 mt7915_register_ext_phy
Message-ID: <20200522083809.GD22511@kadam>
References: <a03171996da0aaaa0963a4704b6d59be818bd42f.1590132235.git.lorenzo@kernel.org>
 <20200522074522.GB22511@kadam>
 <20200522075124.GB4245@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522075124.GB4245@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=816
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=850 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220070
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 22, 2020 at 09:51:24AM +0200, Lorenzo Bianconi wrote:
> > 
> > On Fri, May 22, 2020 at 09:26:06AM +0200, Lorenzo Bianconi wrote:
> > > Fix a NULL pointer dereference in mt7915_register_ext_phy since phy
> > > data structure is allocated by mt76_alloc_phy routine
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > Thanks!  Could you fix the same the bug in mt7615_register_ext_phy() as
> > well?
> 
> Hi Dan,
> 
> I have already posted the fix here: https://patchwork.kernel.org/patch/11553519/
> The patch is already in Felix's tree.

Fantastic.

regards,
dan carpenter

