Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9443284A49
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfHGLEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 07:04:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfHGLEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 07:04:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77AxRKc134917;
        Wed, 7 Aug 2019 11:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qsOxyHcPznuBeYw4GHXDiHnjlvM31eR7Bd2BDY00Z1E=;
 b=GA7AnrGAUusnu7ym0Hv3ziOj6OKojXkbKkZbXD/X/jPKPz31fAv7fMQunejM2lHerrjU
 u/wYO+4XWyjNoT1/9F3YmEgTGP40MBCXL2STxGcFsnImTY78GbOx7cFMO2NUnyBR30vY
 Pxok4Eyal74nyydZa8dQ0oEuVKANMpxN9JdsqE8BO++cMsTCfVZXh1yuvSp1DhocuAuh
 XEKMruwgBtPM/C4o8GlxniG+Yz4/dOprJEiapiFdf0qpIVRqdMoKbNYY1ZDx4na7N+Xg
 Fjv+NScD2txABXjYEPJZVOl6lcersi1dZq82MwnPQLscpeCskUqy30sAAldeHowbsKsc aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u52wrbkqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 11:04:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77B3Ydo119532;
        Wed, 7 Aug 2019 11:04:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u763hrqqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 11:04:00 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x77B3wCw009237;
        Wed, 7 Aug 2019 11:03:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 04:03:58 -0700
Date:   Wed, 7 Aug 2019 14:03:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adham.Abozaeid@microchip.com
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Ajay.Kathat@microchip.com
Subject: Re: [PATCH 3/6] staging: wilc1000: remove unused members
Message-ID: <20190807110351.GM1974@kadam>
References: <20190725213125.2810-1-adham.abozaeid@microchip.com>
 <20190725213125.2810-4-adham.abozaeid@microchip.com>
 <20190806124656.GH1974@kadam>
 <f0a3701c-39c3-1b95-3148-621b26d3f870@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a3701c-39c3-1b95-3148-621b26d3f870@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=900
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=948 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070122
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 06, 2019 at 07:32:08PM +0000, Adham.Abozaeid@microchip.com wrote:
> Hi Dan
> 
> On 8/6/19 5:46 AM, Dan Carpenter wrote:
> > External E-Mail
> >
> >
> > On Thu, Jul 25, 2019 at 09:31:34PM +0000, Adham.Abozaeid@microchip.com wrote:
> >> From: Adham Abozaeid <adham.abozaeid@microchip.com>
> >>
> >> remove obtaining_ip from struct wilc_vif
> >>
> > How is this "unused"?  It looks like it is used to me.
> The main usage of obtaining_ip was to track the inetadd_notifier status.
> After removing the notifier and ip address timeout timer in the first and second patch,
> the remaining usage became meaningless, and could be removed.

This is exactly the level of detail that I would like in a commit
description.

regards,
dan carpenter

