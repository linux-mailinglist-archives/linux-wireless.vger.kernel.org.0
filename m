Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6021088C8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 07:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYGyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 01:54:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYGyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 01:54:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP6sDEp028057;
        Mon, 25 Nov 2019 06:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=l/PZc/dlwG4EAD6FdzK2zvGCN4xk8EscxXrPQL25xkE=;
 b=MfCLIu10rN5rqDV/Cx/Z4560dJqUaaIoGOSdqx+XrO744F2EAUEg2I3cFoflM5cWcSme
 o969klq7bDx9AxK3cIzKRdq8z9vpIROYW/+Vjubit7BNvBRQRtIDDCrzbQI4TTSkZ9Qg
 In3Vt3hJbWnhC5O0c+MLrCzx0EJph29iiSjoPeienOsEjOgw/lpXLBsodHp2A//JcLXv
 x1UwlfEZTi1OZr5pGP236d8ZZfskaBj+ksnpFqaoG7rep0LbV9QrrCF0PP8mGwhJJtf3
 kvz1Eb+QssOLRlM+6t8pKiH/JaQPuDb9U26+DovNvVo4uASYNJAF2YsbFGnIiWZJ+NSh Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wev6twj2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 06:54:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP6sDHV016407;
        Mon, 25 Nov 2019 06:54:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wfe9dnv8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 06:54:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAP6sVvg001498;
        Mon, 25 Nov 2019 06:54:32 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Nov 2019 22:54:30 -0800
Date:   Mon, 25 Nov 2019 09:54:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adham.Abozaeid@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        Ajay.Kathat@microchip.com
Subject: Re: [PATCH 1/4] staging: wilc1000: use runtime configuration for
 sdio oob interrupt
Message-ID: <20191125065423.GA1774@kadam>
References: <20191122205153.30723-1-adham.abozaeid@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122205153.30723-1-adham.abozaeid@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=697
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=778 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250062
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 22, 2019 at 08:52:02PM +0000, Adham.Abozaeid@microchip.com wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Set SDIO Out-of-band interrupt configuration at run time by passing
> parameter during module load.
> 

This is barely an improvement at all...  Why not just make it auto
detect?

regards,
dan carpenter

