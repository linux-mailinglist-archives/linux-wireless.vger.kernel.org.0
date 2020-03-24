Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F221917BC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCXRfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 13:35:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCXRfh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 13:35:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OHX8rt094937;
        Tue, 24 Mar 2020 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=93E2/BAwWeHsNDv0F9mxaIFBaB7h3T6FEvTX5l9gaPk=;
 b=UsCyLVt7hp6JU5Hs1F0vxt6991tQzGAdnK7+pcHuDi45wRpFYqz5HFhU5+CaC6Il4lo1
 rZqBIrEs95lKLj9UbraYAJFVkQAI683bBqsLBOv+64Rs3OD4NgWHIx4YZN1vMYMDHWDb
 2XJm34GtXcKZPVR59MumKbhmni3Ukd3UlY2Dw10Mxw9u44vlLtOsYfHmjcNb8ce/EWqF
 TztQT5gfgZj/KciLNd/DjUyLBz/Tj+t7UNr+CEWFrK7ApUf9QfZqmZO0s+Vb9PLXnZtU
 4NB3xaLfUFHDUmrTjvBUhQVeJf/WTWWwQVsTnpZ6fkYK4QrJLmGkFmMtCP56E9LOKvKi vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ywabr5qy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 17:35:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OHWKSg181616;
        Tue, 24 Mar 2020 17:35:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yymbtw6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 17:35:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OHZKcY006170;
        Tue, 24 Mar 2020 17:35:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 10:35:20 -0700
Date:   Tue, 24 Mar 2020 20:35:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH resend 3] staging: rtl8188eu: Add rtw_led_enable module
 parameter
Message-ID: <20200324173512.GH26299@kadam>
References: <97d2ef68a6bcb7d1ece978eef6315e95732ca39d.camel@hadess.net>
 <20200324152040.GA2511658@kroah.com>
 <73723ab7d2c64c7d5ce7e2ae05b857c965824168.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73723ab7d2c64c7d5ce7e2ae05b857c965824168.camel@hadess.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=832
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=897 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240090
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 24, 2020 at 04:21:47PM +0100, Bastien Nocera wrote:
> On Tue, 2020-03-24 at 16:20 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 11:36:00AM +0100, Bastien Nocera wrote:
> > > Make it possible to disable the LED, as it can be pretty annoying
> > > depending on where it's located.
> > > 
> > > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
> > > out-of-tree version.
> > > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  drivers/staging/rtl8188eu/core/rtw_led.c      | 6 ++++++
> > >  drivers/staging/rtl8188eu/include/drv_types.h | 2 ++
> > >  drivers/staging/rtl8188eu/os_dep/os_intfs.c   | 5 +++++
> > >  3 files changed, 13 insertions(+)
> > 
> > Why was this resent?  Didn't I just reject this?
> 
> It wasn't resent, it's the same mail you already answered.

It says "resend" in the subject.

regards,
dan carpenter
