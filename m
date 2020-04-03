Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3368A19D33E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgDCJNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 05:13:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgDCJNG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 05:13:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03399rkp019032;
        Fri, 3 Apr 2020 09:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=byYACmK3/0xJohPsdTYhJy5m5zZAY1HnOE2pzi+zRgc=;
 b=O50q/jGwXTa//Z9bJhlK4iyRLWNhueAV3JAXu7FYtqL9KX5jDaEX1dn1ie4up8JVqaIm
 oecJAxwdybzx7YnoUMpY1BrYuSmbWMV+fkARFr3jIiMiDzszrdAWXF9Mz3u6qu5YlWYG
 xgwhbYA0MWYIbzf5lKift84oj9pB8qzTjmyX8q9GrcKO5xOVl2FG/Uvnr0VLmedFDxZB
 7ssvlgrydwCZJ0J8pWAzvPbcSsg1UhqeLhwY4lqL1ZnNT2jgwLHQk5tE/Z6OdjxVbg4q
 unyJFV0BlNEoJ0SYMHYmEG0pbVgXnW/ZCUH+KUXINA2WGjb8yTFw57TtqU+CI724LlBD 2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 303yunjk82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 09:12:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0339788N136384;
        Fri, 3 Apr 2020 09:10:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2men6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 09:10:40 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0339Abrw025611;
        Fri, 3 Apr 2020 09:10:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 02:10:36 -0700
Date:   Fri, 3 Apr 2020 12:10:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     devel@driverdev.osuosl.org, Ajay.Kathat@microchip.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        Adham.Abozaeid@microchip.com, johannes@sipsolutions.net
Subject: Re: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Message-ID: <20200403091029.GC2001@kadam>
References: <20200326152251.19094-1-ajay.kathat@microchip.com>
 <20200402082745.GG2001@kadam>
 <20200402153034.GB2013@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402153034.GB2013@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030078
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 02, 2020 at 03:30:34PM +0000, George Spelvin wrote:
> On Thu, Apr 02, 2020 at 11:27:45AM +0300, Dan Carpenter wrote:
> > I don't know how this patch made it through two versions without anyone
> > complaining that this paragraph should be done as a separate patch...
> 
> I often fold comment (and spacing/formatting) patches in to a main
> patch, when touching adjacent code anyway and it doesn't cause
> distracting clutter.
> 
> This seemed like such a case, which is why I submitted it as one.
> But it's a bit of style thing.
> 

We're super strict in Staging.  :P  Greg is more strict than I am.

> >> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
> >> Cc: linux-wireless@vger.kernel.org
> >> Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
> >> Signed-off-by: George Spelvin <lkml@sdf.org>
> >> ---
> > 
> > This should have you Signed-off-by.  The Reviewed-by is kind of assumed
> > so you can drop that bit.  But everyone who touches a patch needs to
> > add their signed off by.
> 
> Er... all he did was add "staging: " to the front of the title.
> 
> That's not a change to the code at all, and as trivial a change
> to the commit message as adding "Reviewed-by:" to the end.
> We don't need S-o-b for such things or we'd end up in a horrible
> infinite recursion.

You've misunderstood.  He sent the email so he has to add his
Signed-off-by.  It's not at all related to changing anything in the
patch.  That's how sign offs work.

regards,
dan carpenter

