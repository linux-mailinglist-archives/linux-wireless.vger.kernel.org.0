Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B257A1D78C4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgERMj5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 08:39:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgERMj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 08:39:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04ICVfYq073811;
        Mon, 18 May 2020 12:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bd0vnwwO0ZWmC6vWHdPtL16W06duYPkWRifCu26fO60=;
 b=IiIqMtZ+t1lX07BWRk0aJx/RJCywKkEFvJJVBJSjN6eAtXzFZsyYj9i9lUhC7IQzHTIv
 saoCxewMAE/Vpb5uvnyydvh6Wg9QMdnuBTo9xg9JYjyrMvop0F6jbV1PEXDtA9AhnVH6
 DnSPCe5v1zoU0Vx/qZv/Sm3Jo0JdIrpeU+JtLcBGpA6VO78lFsivzoQVbPEqmmdOEAjq
 E5VskLTJ7p8BpLm7yY+m6HuafWLniN1Jzl/k8YB8oGPhLZbgVQH4XRmUG2OQ8BpEqv40
 jp20tedOgV9vXfDYX3Z0d+ZRDBA/Tyil1DpG1f+l7tps9omb2qQa066K0YM1KZrQAMQX 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31284kpg79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 12:39:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04ICd0sS142559;
        Mon, 18 May 2020 12:39:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 312t30tbe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 12:39:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04ICdptI016564;
        Mon, 18 May 2020 12:39:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 05:39:50 -0700
Date:   Mon, 18 May 2020 15:39:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: vt6656: vnt_beacon_xmit use
 extra_tx_headroom.
Message-ID: <20200518123944.GI2078@kadam>
References: <5f00d319-9242-65b2-d100-dcfe9b0e32be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f00d319-9242-65b2-d100-dcfe9b0e32be@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180114
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 16, 2020 at 11:39:34AM +0100, Malcolm Priestley wrote:
> Create room for vnt_tx_short_buf_head in sk_buff and vnt_tx_usb_header.
> 
> The struct ieee80211_mgmt is not longer in the header and is at
> the initial skb->data point.

I feel like the SubmittingPatches guidelines on verb tenses and not
saying "this patch" or "I" has got everyone so worried that it's like
playing Taboo.  Do you mean that the struct moved before or after we
aply *this patch*?

> 
> Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>

I can't understand the point of this patch at all.  Is it a fix or a
clean up?  If I had to guess from the subjec, I would say it's a
performance improvement but I don't know.

regards,
dan carpenter


